class Post
  include ActiveModel::Model
  include ActiveModel::Dirty

  attr_accessor :id, :name, :body, :created_at, :updated_at
  validates :name, :body, presence: true

  COL = Rails.application.config.firestore.col('hotwire-bbs/models/posts')
  private_constant :COL

  def self.all
    COL.get.map {|x|
      y = new(
        id: x.document_id,
        name: x[:name],
        body: x[:body],
        created_at: x.created_at,
        updated_at: x.updated_at,
      )
      Rails.logger.info y.inspect
      y
    }
  end

  def self.find(id)
    x = COL.doc(id).get
    new(
      id: x.document_id,
      name: x[:name],
      body: x[:body],
      created_at: x.created_at,
      updated_at: x.updated_at,
    )
  end

  def save
    if @id
      COL.doc(@id).set({
        name: @name,
        body: @body,
      })
    else
      dr = COL.add({
        name: @name,
        body: @body,
      })
      @id = dr.document_id
    end
    true
  end

  def destroy
    raise
  end
end
