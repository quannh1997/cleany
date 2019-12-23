class BooksController < ApplicationController
  def handleBook
    user_id = params[:user_id]
    partner_id = params[:partner_id]
    start_time = params[:start_time]
    end_time = params[:end_time]
    date_next = params[:date_next].to_i
    address = params[:address]
    note = params[:note]
    price = params[:price].to_i/1000

    booking = WorkingLog.new(user_id: user_id, partner_id: partner_id, worktime_start: start_time, worktime_end: end_time, address: address, cost: price, note: note, working_date: DateTime.now.next_day(date_next).to_date)

    if booking.save
      render json: { data: "Book Successfully! Wait to response from clean Staff! " }
    else
      render json: { data: "Error! Try Again!" }
    end
  end

  def deleteBooking
    working = WorkingLog.find_by id: params[:working_id]
    if working.destroy
      render json: { data: "Delete Working Successfully" }
    else
      render json: { data: "can not delete" }
    end
  end

  def acceptBooking
    working = WorkingLog.find_by id: params[:working_id]
    if working.update_attributes(:status => 1)
      render json: { data: "Accepted this working! Please call your customer!" }
    else
      render json: { data: "can not accept" }
    end
  end
end
