# frozen_string_literal: true

module Web
  module Views
    class ApplicationLayout
      include Web::Layout

      def flash_messages(flash)
        alert = [
          { class: 'danger', type: :alert }, { class: 'info', type: :info },
          { class: 'warning', type: :warning },
        ].find { |a| !flash[a[:type]].nil? }

        html.div(class: "alert alert-#{alert[:class]} alert-dismissable text-center", role: 'alert') do
          button(class: 'close', type: 'button', 'data-dismiss' => 'alert', 'aria-label' => 'close') do
            span('aria-hidden' => 'true') do
              raw '&times;'
            end
          end
          strong raw(flash[alert[:type]])
        end unless alert.nil?
      end
    end
  end
end
