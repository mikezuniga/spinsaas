class Appman < ApplicationRecord
  require 'aws-sdk'
  belongs_to :user
  has_and_belongs_to_many :clouds
  before_create :createSpinnakerStack
  #before_update :updateSpinnakerStack
  before_destroy :destroySpinnakerStack

  @cloudformation = nil

  def createSpinnakerStack
    file = File.open('/opt/app-root/src/app/models/spinnaker-template.json','r')
    contents = file.read
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
    self.stackmetadata = "#{resp.stacks[0].stack_id},\n#{resp.stacks[0].stack_name},\n#{resp.stacks[0].change_set_id},#{resp.stacks[0].stack_status},#{resp.stacks[0].stack_status_reason}"
    self.details = "
    In order to access your application manager execute the following actions:
    Access Bastion = #{resp.stacks[0].outputs[3].output_value}
    \n
    From Bastion access spinnaker with:
    Access Spinnaker = #{resp.stacks[0].outputs[2].output_value}
    Open your web browser and point it to http://localhost:9000/ 
    \n
    From Bastion access jenkins with:
    Access Jenkins = #{resp.stacks[0].outputs[1].output_value}
    Open your web browser and point it to http://localhost:8080/
    \n
    FQDN WebServer #{self.name}appman.mirapocnet.com\n
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
