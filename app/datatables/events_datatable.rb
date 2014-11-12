class EventsDatatable
  delegate :params, :link_to, :edit_admin_event_path, :admin_event_path, to: :@view

    def initialize(view)
      @view = view
    end

    def as_json(options = {})
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Event.count,
        iTotalDisplayRecords: events.total_entries,
        aaData: data
      }
    end

  private

    def data
      events.map do |event|
        [
          #link_to(event.name, event),
          #h(event.category),
          #h(event.released_on.strftime("%B %e, %Y")),
          #number_to_currency(event.price)
          event.title,
          event.start.strftime("%d-%m-%Y %H:%M"),
          event.end.strftime("%d-%m-%Y %H:%M"),
          event.created_at.strftime("%B %e, %Y"),
          event.updated_at.strftime("%B %e, %Y"),
          link_to("Edit", edit_admin_event_path(event)) + " | " + link_to("Delete", admin_event_path(event), :confirm => 'Are you sure?', :method => :delete, :title => "Delete")
        ]
      end
    end

    def events
      @events ||= fetch_events
    end

    def fetch_events
      events = Event.order("#{sort_column} #{sort_direction}")
      events = events.page(page).per_page(per_page)
      if params[:sSearch].present?
        events = events.where("title like :search or start like :search", search: "%#{params[:sSearch]}%")
      end
      events
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[title start end created_at updated_at]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end       
end