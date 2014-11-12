class MediasDatatable
  
  delegate :params, :link_to, :edit_admin_media_path, :admin_media_path, to: :@view

    def initialize(view)
      @view = view
    end

    def as_json(options = {})
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Media.count,
        iTotalDisplayRecords: medias.total_entries,
        aaData: data
      }
    end

  private

    def data
      medias.map do |media|
        [
          #link_to(media.name, media),
          #h(media.category),
          #h(media.released_on.strftime("%B %e, %Y")),
          #number_to_currency(media.price)
          media.title,
          media.item_content_type,
          media.item_file_size,
          media.created_at.strftime("%B %e, %Y"),
          media.updated_at.strftime("%B %e, %Y"),
          link_to("Edit", edit_admin_media_path(media)) + " | " + link_to("Delete", admin_media_path(media), :confirm => 'Are you sure?', :method => :delete, :title => "Delete")
        ]
      end
    end

    def medias
      @medias ||= fetch_medias
    end

    def fetch_medias
      medias = Media.order("#{sort_column} #{sort_direction}")
      medias = medias.page(page).per_page(per_page)
      if params[:sSearch].present?
        medias = medias.where("title like :search or item_content_type like :search", search: "%#{params[:sSearch]}%")
      end
      medias
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[title item_content_type item_file_size created_at updated_at]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end       
end