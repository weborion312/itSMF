class TemplatesDatatable
  delegate :params, :link_to, :edit_admin_designed_template_path, :admin_designed_template_path, to: :@view

    def initialize(view)
      @view = view
    end

    def as_json(options = {})
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: DesignedTemplate.count,
        iTotalDisplayRecords: designed_templates.total_entries,
        aaData: data
      }
    end

  private

    def data
      designed_templates.map do |designed_template|
        [
          #link_to(designed_template.name, designed_template),
          #h(designed_template.category),
          #h(designed_template.released_on.strftime("%B %e, %Y")),
          #number_to_currency(designed_template.price)
          designed_template.name,
          designed_template.status,
          designed_template.created_at.strftime("%B %e, %Y"),
          designed_template.updated_at.strftime("%B %e, %Y"),
          link_to("Edit", edit_admin_designed_template_path(designed_template)) + " | " + link_to("Delete", admin_designed_template_path(designed_template), :confirm => 'Are you sure?', :method => :delete, :title => "Delete")
        ]
      end
    end

    def designed_templates
      @designed_templates ||= fetch_designed_templates
    end

    def fetch_designed_templates
      designed_templates = DesignedTemplate.order("#{sort_column} #{sort_direction}")
      designed_templates = designed_templates.page(page).per_page(per_page)
      if params[:sSearch].present?
        designed_templates = designed_templates.where("name like :search or name like :search", search: "%#{params[:sSearch]}%")
      end
      designed_templates
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[name status created_at updated_at]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end       
end