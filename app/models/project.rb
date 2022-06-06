class Project < ApplicationRecord
  has_many :tasks
  belongs_to :user

  def  badge_color
    case status
    when "not-started"
      "secondary"
    when "in-progress"
      "info"
    when "complete"
      "success"
    end
  end

  def status
    return 'not-started' if tasks.none?

    if tasks.all? { |t| t.complete? }
      'complete'
    elsif tasks.any? { |t| t.in_progress? || t.complete? }  
      'in-progress'
    else 
      'not-started'
    end
  end

  def percent_complete
    return 0 if tasks.none?

    ((total_complete.to_f / total_tasks) * 100).round
  end

  def total_complete
    completed_tasks = tasks.select { |t| t.complete? }.count
  end

  def total_tasks
    tasks.count
  end

end
