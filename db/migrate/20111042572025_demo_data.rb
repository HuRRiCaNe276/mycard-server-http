class DemoData < ActiveRecord::Migration
  def self.up
    Board.create  :id => 1,
                  :superboard_id => 0,
                  :name => "综合讨论中心"

    Board.create  :id => 2,
                  :superboard_id => 1,
                  :name => "测试版块",
                  :introduction => "版块简介",
                  :notice => "版块公告",
                  :logo => "http://bbs.66rpg.com/data/attachment/common/skin/VX.png",
                  :banner => "http://ftp.66rpg.com/WEB_PLUS/attachment/forum/201104/24/221009dzbmkp6666pp3mue.jpg"
    
  end

  def self.down
  end
end