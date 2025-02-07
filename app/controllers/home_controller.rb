class HomeController < ApplicationController
  allow_unauthenticated_access only: %i[ index ]
end
