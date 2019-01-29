module Bitmex
  # Best Bid/Offer Snapshots & Historical Bins
  # TODO: looks like all quotes related methods are forbidden
  # @author Iulian Costan
  class Quote < Base
    # Get all quotes
    # @!macro bitmex.filters
    #   @param filters [Hash] the filters to apply
    #   @option filters [String] :symbol the instrument symbol
    #   @option filters [String] :filter generic table filter, send key/value pairs {https://www.bitmex.com/app/restAPI#Timestamp-Filters Timestamp Filters}
    #   @option filters [String] :columns array of column names to fetch; if omitted, will return all columns.
    #   @option filters [Double] :count (100) number of results to fetch.
    #   @option filters [Double] :start Starting point for results.
    #   @option filters [Boolean] :reverse (false) if true, will sort results newest first.
    #   @option filters [Datetime, String] :startTime Starting date filter for results.
    #   @option filters [Datetime, String] :endTime Ending date filter for results
    # @return [Array] the quotes
    def all(filters = {})
      client.get quotes_path, params: filters do |response|
        response_handler response
      end
    end

    # Get previous quotes in time buckets
    # @param binSize ['1m','5m','1h','1d'] the interval to bucket by
    # @!macro bitmex.filters
    # @return [Array] the quotes by bucket
    def bucketed(binSize = '1h', filters = {})
      params = filters.merge binSize: binSize
      client.get quotes_path(:bucketed), params: params do |response|
        response_handler response
      end
    end

    private

    def quotes_path(action = '')
      client.base_path :quote, action
    end
  end
end