#!/usr/bin/env ruby
# encoding: UTF-8

module CurrentCounter extend ActiveSupport::Concern
  
  private
  def track
    session[:counter] ||= 0
    session[:counter] += 1
    @counter = session[:counter]
  end
  
  def untrack
    session[:counter] = nil
  end
end
