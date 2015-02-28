module Mercury
  module Authentication

    def can_edit?
      admin_signed_in? && true || nil
    end
  end
end
