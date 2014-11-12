class SettingsDatatable
  delegate :params, :link_to, :edit_admin_setting_path, :admin_setting_path, to: :@view

    def initialize(view)
      @view = view
    end

    def as_json(options = {})
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Setting.count,
        iTotalDisplayRecords: settings.total_entries,
        aaData: data
      }
    end

  private

    def data
      settings.map do |setting|
        [
          #link_to(setting.name, setting),
          #h(setting.category),
          #h(setting.released_on.strftime("%B %e, %Y")),
          #number_to_currency(setting.price)
          setting.name,
          setting.content,
          setting.created_at.strftime("%B %e, %Y"),
          setting.updated_at.strftime("%B %e, %Y"),
          link_to("Edit", edit_admin_setting_path(setting)) + " | " + link_to("Delete", admin_setting_path(setting), :confirm => 'Are you sure?', :method => :delete, :title => "Delete")
        ]
      end
    end

    def settings
      @settings ||= fetch_settings
    end

    def fetch_settings
      settings = Setting.order("#{sort_column} #{sort_direction}")
      settings = settings.page(page).per_page(per_page)
      if params[:sSearch].present?
        settings = settings.where("name like :search or content like :search", search: "%#{params[:sSearch]}%")
      end
      settings
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[name content created_at updated_at]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end       
end