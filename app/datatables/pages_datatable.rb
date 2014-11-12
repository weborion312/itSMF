class PagesDatatable
  delegate :params, :link_to, :edit_admin_page_path, :admin_page_path, to: :@view

    def initialize(view)
      @view = view
    end

    def as_json(options = {})
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Page.count,
        iTotalDisplayRecords: pages.total_entries,
        aaData: data
      }
    end

  private

    def data
      pages.map do |page|
        [
          #link_to(page.name, page),
          #h(page.category),
          #h(page.released_on.strftime("%B %e, %Y")),
          #number_to_currency(page.price)
          page.title,
          page.locale,
          page.publish_date.strftime("%B %e, %Y"),
          page.created_at.strftime("%B %e, %Y"),
          page.updated_at.strftime("%B %e, %Y"),
          link_to("Edit", edit_admin_page_path(page)) + " | " + link_to("Delete", admin_page_path(page), data: { confirm: 'Are You Sure?' }, :method => :delete, :title => "Delete")
        ]
      end
    end

    def pages
      @pages ||= fetch_pages
    end

    def fetch_pages
      pages = Page.order("#{sort_column} #{sort_direction}")
      pages = pages.page(page).per_page(per_page)
      if params[:sSearch].present?
        pages = pages.where("title like :search or publish_date like :search", search: "%#{params[:sSearch]}%")
      end
      pages
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[title locale publish_date created_at updated_at]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end       
end