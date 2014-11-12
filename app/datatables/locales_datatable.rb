class LocalesDatatable
  delegate :params, :link_to, :edit_admin_locale_path, :admin_locale_path, to: :@view

    def initialize(view)
      @view = view
    end

    def as_json(options = {})
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Locale.count,
        iTotalDisplayRecords: locales.total_entries,
        aaData: data
      }
    end

  private

    def data
      locales.map do |locale|
        [
          #link_to(locale.name, locale),
          #h(locale.category),
          #h(locale.released_on.strftime("%B %e, %Y")),
          #number_to_currency(locale.price)
          locale.name,
          locale.code,
          locale.created_at.strftime("%B %e, %Y"),
          locale.updated_at.strftime("%B %e, %Y"),
          link_to("Edit", edit_admin_locale_path(locale)) + " | " + link_to("Delete", admin_locale_path(locale), :confirm => 'Are you sure?', :method => :delete, :title => "Delete")
        ]
      end
    end

    def locales
      @locales ||= fetch_locales
    end

    def fetch_locales
      locales = Locale.order("#{sort_column} #{sort_direction}")
      locales = locales.page(page).per_page(per_page)
      if params[:sSearch].present?
        locales = locales.where("name like :search or code like :search", search: "%#{params[:sSearch]}%")
      end
      locales
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[name code created_at updated_at]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end       
end