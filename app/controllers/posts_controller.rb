#encoding: UTF-8
class PostsController < ApplicationController
  #ApplicationHelper::addon_header.push "zh_header"
  #ApplicationHelper::addon_top.push "zh_top"
  #ApplicationHelper::addon_footer.push "zh_footer"
  # GET /posts
  # GET /posts.xml
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])
	
    respond_to do |format|
      format.html { redirect_to(@post.topic) }
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    @post.topic = @topic
    @post.attachments.build
    @actions = [@topic, "回复"]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @post.attachments.build
    @actions = [@post, "发表回复"]
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])
    @post.topic = Topic.find params[:post][:topic_id]
    if @post.topic.nil? or @post.topic.locked
      return render :text => "Topic not found or locked."
    end
    @post.user = @current_user
    @post.displayorder = @post.topic.floor
    @actions = [@post, "发表回复"]
    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post.topic, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post.topic }
      else
        @post.attachments.build
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    @actions = [@post, "编辑帖子"]
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post.topic, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        @post.attachments.build
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end
