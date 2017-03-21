class PetitionsController < ApplicationController
  before_action :set_page_title, only: %i(verify)
  before_action :petition, :cycle, only: %i(signatures)

  def verify
  end

  def signatures
    @signatures = petition_service.fetch_petition_signatures(params[:petition_id])
  end

  def use_simple_header?
    params[:action] == "verify"
  end

  private

  def petition
    @petition ||= petition_repository.find_by_id!(params[:petition_id])
  end

  def cycle
    @cycle ||= @petition.plugin_relation.cycle
  end

  def petition_service
    @petition_service ||= PetitionService.new
  end

  def petition_repository
    @petition_repository ||= PetitionPlugin::DetailRepository.new
  end

  def set_page_title
    @page_title = case params[:action]
                  when "verify" then "Validar documento"
                  end
  end
end
