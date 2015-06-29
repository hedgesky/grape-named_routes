require 'spec_helper'

describe Grape::API do
  subject { Class.new(Grape::API) }

  describe Grape::NamedRoutes do
    before do
      subject.get as: :root do
        1
      end
      subject.namespace :users do
        route_param :id do
          get as: :user do
            params[:id]
          end
        end
      end
    end

    it 'has a version number' do
      expect(Grape::NamedRoutes::VERSION).not_to be_nil
    end

    describe '.get_named_path' do
      it 'returns compiled path' do
        expect(subject.get_named_path(:user, id: 1, format: 'json')).to eq('/users/1.json')
      end

      it 'may omit optional params' do
        expect(subject.get_named_path(:user, id: 1)).to eq('/users/1')
      end

      it 'raises Grape::NamedRoutes::MissedRequiredParam if required param is missed' do
        expect {
          subject.get_named_path(:user)
        }.to raise_error(Grape::NamedRoutes::MissedRequiredParam)
      end

      it 'raises Grape::NamedRoutes::NamedRouteNotFound if named route is not declared' do
        expect {
          subject.get_named_path(:wrong_route)
        }.to raise_error(Grape::NamedRoutes::NamedRouteNotFound)
      end
    end

    describe '.find_endpoint' do
      it 'returns instance of Grape::Endpoint class' do
        expect(subject.find_endpoint(:root)).to be_instance_of(Grape::Endpoint)
      end

      it 'returns nil if named route is not declared' do
        expect(subject.find_endpoint(:wrong)).to be_nil
      end
    end

    describe '.find_endpoint!' do
      it 'returns instance of Grape::Endpoint class' do
        expect(subject.find_endpoint!(:root)).to be_instance_of(Grape::Endpoint)
      end

      it 'returns nil if named route is not declared' do
        expect{
          subject.find_endpoint!(:wrong)
        }.to raise_error(Grape::NamedRoutes::NamedRouteNotFound)
      end
    end

    describe 'dynamic _path methods' do
      it 'is proxy to .get_named_path' do
        expect(subject).to receive(:get_named_path)
        subject.root_path
      end

      it 'responds to named path' do
        expect(subject).to respond_to(:root_path)
      end
    end

    describe '.reset!' do
      it 'resets named pathes' do
        expect(subject).to respond_to(:root_path)
        subject.reset!
        expect(subject).not_to respond_to(:root_path)
      end
    end
  end
end