require 'spec_helper'

describe ScopedId do

  class Model < BaseModel
    scoped_id :owner_scoped_id, scope: :owner_id
  end

  it "generates 1 for the first ID" do
    model = Model.create
    model.owner_scoped_id.should == 1
  end

  it "generates 2 for the second ID" do
    Model.create
    model = Model.create
    model.owner_scoped_id.should == 2
  end

  it "generates 1 if other models exist for a different scope" do
    Model.create(owner_id: 3)
    model = Model.create(owner_id: 7)
    model.owner_scoped_id.should == 1
  end

  it "generates the next id even if a model was deleted" do
    Model.create # 1
    model_to_delete = Model.create # 2
    Model.create # 3
    model = Model.create

    model_to_delete.destroy
    model.owner_scoped_id.should == 4
  end

  it "marks the scoped id as readonly" do
    model = Model.create
    model.owner_scoped_id = 78
    model.save
    model.reload.owner_scoped_id.should == 1
  end

  it "allows setting a scoped id value before creation" do
    model = Model.new
    model.owner_scoped_id = 123
    model.save
    model.owner_scoped_id.should == 123
  end

  it "validates the uniqueness of the scoped id" do
    Model.create(owner_scoped_id: 123)
    model = Model.new(owner_scoped_id: 123)
    model.valid?.should be_false
  end

  it "validates the uniqueness of the scoped id per scope" do
    Model.create(owner_scoped_id: 123, owner_id: 13)
    model = Model.new(owner_scoped_id: 123, owner_id: 9)
    model.valid?.should be_true
  end

  it "is valid if a record exists with a nil scoped id" do
    BaseModel.create # owner_scoped_id == nil
    Model.new.valid?.should be_true
  end

  it "raises an exception if scope is not specified" do
    expect{
      Class.new(BaseModel) do
        scoped_id :owner_scoped_id # no scope
      end
    }.to raise_error(ArgumentError)
  end

end
