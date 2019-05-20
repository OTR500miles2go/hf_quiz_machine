class QuestionController < ApplicationController
  def index
  end

  def show
    # How many questions for this course
    pool_number = Question.where("course_id" => params[:id]).count
    # Randomly select 10 numbers from that pool
    @display_questions = select_random(pool_number, 10)
    
    if @display_questions.kind_of?(Array) 
      # Pull the selected questions, by id, from the database
      @question_list = Question.where("course_id" => params[:id]).where('id IN (?)', @display_questions)
      # Match up the answers with the questions
      @quiz = create_quiz(@question_list)
    end
  end

  private 

  def select_random(total_in_pool, total_items_returned)
    selected_items = []
    # Set a boundary
    if total_items_returned < 1 || total_items_returned > 50
      return -1
    end 
    # Can't request more than we have
    if total_items_returned > total_in_pool
      return -1
    end  
    # Build the array for selected id numbers, remove any duplicates
    while selected_items.length < total_items_returned
      selected_items.push(rand(1..total_in_pool))
      selected_items = selected_items.uniq
    end 

    return selected_items
  end    

  def create_quiz(question_list)
    new_array = []
    # For each selected question...
    question_list.each do |question|
      
      # Available formats: true/false and multiple choice 
      if question.format_type == 0 
        Answer.where("question_id" => question.id).map do |answer_query| 
          # Always display in the same order
          if answer_query.body.downcase.strip  === "true" 
            filler_format = { :k => "true", :m => "false" }
          else
            filler_format = { :m => "true", :k => "false" } 
          end
          # Push the question answer pair to the array
          hash = { :question => question.body, :answer_list => filler_format } 
          new_array.push(hash)
        end
      else 
        multiple_choice = []
        # Push the correct response to the temporary array
        Answer.where("question_id" => question.id).where("correct" => true).map do |answer_query|
          multiple_choice.push(answer_query.body)
        end
        # Get the entire pool of false choices
        answer_filler = Answer.where("question_id" => question.id).where("correct" => false).map do |answer_query|
          answer_query.body 
        end 
        # Randomly select 4 from the false batch and push to the temp array
        selected_answer_filler = select_random(answer_filler.count, 4).each do |index|
          multiple_choice.push(answer_filler[index - 1])
        end
        # Shuffle up the choices and create a single hash array index
        inner_hash = { :k => multiple_choice[0], :e => multiple_choice[1], :d => multiple_choice[2], :n => multiple_choice[3], :a => multiple_choice[4] }.to_a.shuffle
        converted_hash = { 
          inner_hash[0][0] => inner_hash[0][1], 
          inner_hash[1][0] => inner_hash[1][1], 
          inner_hash[2][0] => inner_hash[2][1], 
          inner_hash[3][0] => inner_hash[3][1], 
          inner_hash[4][0] => inner_hash[4][1] }
        # Push the question answer pair to the array
        hash = { :question => question.body, :answer_list => converted_hash }
        new_array.push(hash)
      end
    end
    return new_array
  end
end
