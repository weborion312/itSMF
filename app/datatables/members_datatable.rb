class MembersDatatable
  delegate :params, :link_to, :edit_admin_member_path, :admin_member_path, to: :@view


    def initialize(view)
        @view = view
    end
    

    def as_json(options = {})
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Member.count,
        iTotalDisplayRecords: members.total_entries,
        aaData: data
      }
    end

  private

    def data
      members.map do |member|
        [
          #link_to(member.name, member),
          #h(member.category),
          #h(member.released_on.strftime("%B %e, %Y")),
          #number_to_currency(member.price)
          member.email,
          member.first_name + " " + member.last_name,
          member.mobile_tel,
          member.created_at.strftime("%B %e, %Y"),
          member.updated_at.strftime("%B %e, %Y"),
          link_to("Edit", edit_admin_member_path(member)) + " | " + link_to("Delete", admin_member_path(member), :confirm => 'Are you sure?', :method => :delete, :title => "Delete")
        ]
      end
    end

    def members
      @members ||= fetch_members
    end

    def fetch_members
      members = Member.order("#{sort_column} #{sort_direction}")
      members = members.page(page).per_page(per_page)
      if params[:sSearch].present?
        members = members.where("email like :search or first_name like :search or last_name like :search or name like :search", search: "%#{params[:sSearch]}%")
      end
      members
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