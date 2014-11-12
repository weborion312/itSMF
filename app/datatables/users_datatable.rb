class UsersDatatable
  delegate :params, :link_to, :edit_admin_user_path, :admin_user_path, to: :@view


    def initialize(view)
        @view = view
    end
    

    def as_json(options = {})
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: User.count,
        iTotalDisplayRecords: users.total_entries,
        aaData: data
      }
    end

  private

    def data
      users.map do |user|
        [
          #link_to(user.name, user),
          #h(user.category),
          #h(user.released_on.strftime("%B %e, %Y")),
          #number_to_currency(user.price)
          user.email,
          user.position,
          user.last_sign_in_ip,
          user.created_at.strftime("%B %e, %Y"),
          user.updated_at.strftime("%B %e, %Y"),
          link_to("Edit", edit_admin_user_path(user)) + " | " + link_to("Delete", admin_user_path(user), :confirm => 'Are you sure?', :method => :delete, :title => "Delete")
        ]
      end
    end

    def users
      @users ||= fetch_users
    end

    def fetch_users
      users = User.order("#{sort_column} #{sort_direction}")
      users = users.page(page).per_page(per_page)
      if params[:sSearch].present?
        users = users.where("email like :search or last_sign_in_at like :search", search: "%#{params[:sSearch]}%")
      end
      users
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[email last_sign_in_at last_sign_in_ip created_at updated_at]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end       
end