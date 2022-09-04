class CountryController < ApplicationController
  def index
    countries = helpers.fetch_country

    @page = (params[:page] || 1).to_i
    paginated_data = Kaminari.paginate_array(countries).page(@page).per(10)

    @countries = paginated_data
  end

  def show
    @country = helpers.fetch_country(country_code: params[:id])
  end
end
