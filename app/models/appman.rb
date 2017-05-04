class Appman < ApplicationRecord
  require 'aws-sdk'
  require 'securerandom'
  require 'erb'
  belongs_to :user
  has_and_belongs_to_many :clouds
  before_create :createSpinnakerStack
  #before_update :updateSpinnakerStack
  before_destroy :destroySpinnakerStack

  @cloudformation = nil

  def createSpinnakerStack
    @appmenid = SecureRandom.uuid
    self.uuid = @appmenid
    renderer = ERB.new(File.read('/opt/app-root/src/app/models/spinnaker-template.json'))
    contents = renderer.result(binding)
    logger.debug contents
    setCloudformation
    self.stackid = @cloudformation.create_stack({
      stack_name: self.name,
      template_body: "#{contents}",
      timeout_in_minutes: 60,
      capabilities: ["CAPABILITY_IAM"],
      on_failure: "DO_NOTHING", # accepts DO_NOTHING, ROLLBACK, DELETE
      tags: [
        {
          key: "Name",
          value: self.name,
        },
      ],
    }).stack_id
    
  end

  def destroySpinnakerStack
    setCloudformation
    resp = @cloudformation.delete_stack({
      stack_name: self.stackid
    })
  end

  def getSpinnakerStack
    begin
      setCloudformation
      resp = @cloudformation.describe_stacks({
        stack_name: self.stackid
      })
    self.stackmetadata = "Stack ID #{resp.stacks[0].stack_id} </br> Stack Name #{resp.stacks[0].stack_name} </br> Stack Change Set #{resp.stacks[0].change_set_id} </br> Stack Status #{resp.stacks[0].stack_status} </br> Stack Status Reason #{resp.stacks[0].stack_status_reason}"
    self.details = "
    In order to access your application manager execute the following actions:
    </br>
    Access Bastion = #{resp.stacks[0].outputs[3].output_value}
    </br> 
    From Bastion access spinnaker with:
    </br>
    Access Spinnaker = #{resp.stacks[0].outputs[2].output_value}
    </br>
    Open your web browser and point it to http://localhost:9000/ 
    </br>
    From Bastion access jenkins with:
    </br>
    Access Jenkins = #{resp.stacks[0].outputs[1].output_value}
    </br>
    Open your web browser and point it to http://localhost:8080/
    </br>
    FQDN WebServer #{self.name}appman.mirapocnet.com\n
    </br>
    FQDN BastionServer #{self.name}bappman.mirapocnet.com\n
    "
    self.save
    rescue NoMethodError
      self.save
    rescue Exception => e
      self.details = "Error #{e.inspect}"
      self.save
    rescue 
      self.save
    end
  end

  def updateSpinnakerStack
    setCloudformation
    resp = @cloudformation.update_stack({
      
    })
  end


private

  def setCloudformation
    @cloudformation = Aws::CloudFormation::Client.new(
    region: 'us-west-2',
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    )
  end


end
