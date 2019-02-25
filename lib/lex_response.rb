
require 'ostruct'

class LexResponse
  FULFILLED = 'Fulfilled'.freeze
  FAILED = 'Failed'.freeze
  CONTENT_TYPE = 'application/vnd.amazonaws.card.generic'.freeze

  def initialize(success:, data:)
    @success = success
    @data = data
  end

  def generate
    dialog_action = {
      type: 'Close',
      fulfillmentState: state,
      message: message
    }

    dialog_action[:responseCard] = response_card if success?

    {
      dialogAction: dialog_action
    }
  end

  private

  attr_reader :success, :data

  def success?
    success
  end

  def state
    success? ? FULFILLED : FAILED
  end

  def message
    if success?
      {
        contentType: 'CustomPayload',
        content: data['description'],
      }
    else
      {
        contentType: 'PlainText',
        content: data
      }
    end
  end

  def response_card
    {
      version: 1,
      contentType: CONTENT_TYPE,
      genericAttachments: [
        {
          title: data['name'],
          subTitle: data['tagline'].slice(0..79), # Lex has 80 chars limit
          imageUrl: data['image_url'],
          attachmentLinkUrl: 'https://www.brewdog.com/beers/diy-dog'
        }
      ]
    }
  end
end
