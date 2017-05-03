class CreateClouds < ActiveRecord::Migration[5.0]
  def change
    create_table :clouds do |t|
      t.string :name
      t.string :provider
      t.belongs_to :user, index: true

      #Azure settings
      t.string :azenabled
      t.string :azclientid
      t.string :azappkey
      t.string :aztenantid
      t.string :azsubscriptionid
      t.string :azobjectid
      t.string :azdefaultresourcegroup
      t.string :azdefaultkeyvault

      #GCP
      t.string :gcpenabled
      t.string :gcpdefaultregion
      t.string :gcpdefaultzone
      t.string :gcpproject
      t.text   :gcpjsonkey

      #kubernetes
      t.string :k8senabled
      t.string :k8sdockerregistryaccount
      t.text   :k8skubeconfig
      t.string :k8snamespaces
      t.string :k8scontext
      t.string :k8sdockerregistries

      #dockerRegistry
      t.string :drenabled
      t.string :draddress
      t.string :drusername
      t.string :drpassword
      t.string :dremail
      t.string :drrepositories

      #openstack
      t.string :osenabled
      t.string :osauthurl
      t.string :osusername
      t.string :ospassword
      t.string :osprojectname
      t.string :osdomainname
      t.string :osregions
      t.string :osinsecure

      t.timestamps
    end
  end
end
