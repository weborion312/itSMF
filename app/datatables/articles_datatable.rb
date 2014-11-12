class ArticlesDatatable
  delegate :params, :link_to, :image_tag, :edit_admin_article_path, :admin_article_path, to: :@view

    def initialize(view)
      @view = view
    end

    def as_json(options = {})
      {
        sEcho: params[:sEcho].to_i,
        iTotalRecords: Article.count,
        iTotalDisplayRecords: articles.total_entries,
        aaData: data
      }
    end

  private

    def data
      articles.map do |article|
        [
          #link_to(article.name, article),
          #h(article.category),
          #h(article.released_on.strftime("%B %e, %Y")),
          #number_to_currency(article.price)
          image_tag(article.cover.url(:thumb)),
          article.title,
          article.locale,
          article.created_at.strftime("%B %e, %Y"),
          article.updated_at.strftime("%B %e, %Y"),
          link_to("Edit", edit_admin_article_path(article)) + " | " + link_to("Delete", admin_article_path(article), :confirm => 'Are you sure?', :method => :delete, :title => "Delete")
        ]
      end
    end

    def articles
      @articles ||= fetch_articles
    end

    def fetch_articles
      articles = Article.order("#{sort_column} #{sort_direction}")
      articles = articles.page(page).per_page(per_page)
      if params[:sSearch].present?
        articles = articles.where("title like :search or locale like :search", search: "%#{params[:sSearch]}%")
      end
      articles
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = %w[cover_file_name title locale created_at updated_at]
      columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end       
end