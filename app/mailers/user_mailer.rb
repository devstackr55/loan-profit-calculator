# frozen_string_literal: true

class UserMailer < ApplicationMailer
  def term_sheet_email(**args)
    @args = args.symbolize_keys

    attachments['term_sheet.pdf'] = WickedPdf.new.pdf_from_string(
      render_to_string('pdfs/term_sheet', layout: 'pdf')
    )
    mail(
      to: args[:email],
      subject: 'Term Sheet'
    )
  end
end
