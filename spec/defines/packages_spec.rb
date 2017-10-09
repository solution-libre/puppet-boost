require 'spec_helper'

describe 'boost::package' do
  platforms = {
    'debian6' =>
      { :osfamily          => 'Debian',
        :operatingsystem   => 'Debian',
        :release           => '6.0',
        :majrelease        => '6',
        :lsbdistcodename   => 'squeeze',
        :prefix            => 'libboost',
        :suffix            => '.0',
        :suffix_dev        => '-dev',
        :version           => '1.42',
      },
    'debian7' =>
      { :osfamily          => 'Debian',
        :operatingsystem   => 'Debian',
        :release           => '7.0',
        :majrelease        => '7',
        :lsbdistcodename   => 'wheezy',
        :prefix            => 'libboost',
        :suffix            => '.0',
        :suffix_dev        => '-dev',
        :version           => '1.49',
      },
    'debian8' =>
      { :osfamily          => 'Debian',
        :operatingsystem   => 'Debian',
        :release           => '8.0',
        :majrelease        => '8',
        :lsbdistcodename   => 'jessie',
        :prefix            => 'libboost',
        :suffix            => '.0',
        :suffix_dev        => '-dev',
        :version           => '1.55',
      },
    'debian9' =>
      { :osfamily          => 'Debian',
        :operatingsystem   => 'Debian',
        :release           => '9.0',
        :majrelease        => '9',
        :lsbdistcodename   => 'stretch',
        :prefix            => 'libboost',
        :suffix            => '.0',
        :suffix_dev        => '-dev',
        :version           => '1.62',
      },
    'el5' =>
      { :osfamily          => 'RedHat',
        :release           => '5.0',
        :majrelease        => '5',
        :lsbdistcodename   => nil,
        :prefix            => 'boost',
        :suffix            => '',
        :suffix_dev        => '-devel',
        :version           => '',
      },
    'el6' =>
      { :osfamily          => 'RedHat',
        :release           => '6.0',
        :majrelease        => '6',
        :lsbdistcodename   => nil,
        :prefix            => 'boost',
        :suffix            => '',
        :suffix_dev        => '-devel',
        :version           => '',
      },
    'el7' =>
      { :osfamily          => 'RedHat',
        :release           => '7.0',
        :lsbdistcodename   => nil,
        :majrelease        => '7',
        :prefix            => 'boost',
        :suffix            => '',
        :suffix_dev        => '-devel',
        :version           => '',
      },
    'ubuntu1004' =>
      { :osfamily          => 'Debian',
        :operatingsystem   => 'Ubuntu',
        :release           => '10.04',
        :majrelease        => '10',
        :lsbdistcodename   => 'lucid',
        :prefix            => 'libboost',
        :suffix            => '.0',
        :suffix_dev        => '-dev',
        :version           => '1.42',
      },
    'ubuntu1204' =>
      { :osfamily          => 'Debian',
        :operatingsystem   => 'Ubuntu',
        :release           => '12.04',
        :majrelease        => '12',
        :lsbdistcodename   => 'precise',
        :prefix            => 'libboost',
        :suffix            => '.0',
        :suffix_dev        => '-dev',
        :version           => '1.46',
      },
    'ubuntu1404' =>
      { :osfamily          => 'Debian',
        :operatingsystem   => 'Ubuntu',
        :release           => '14.04',
        :majrelease        => '14',
        :lsbdistcodename   => 'trusty',
        :prefix            => 'libboost',
        :suffix            => '.0',
        :suffix_dev        => '-dev',
        :version           => '1.54',
      },
    'ubuntu1604' =>
      { :osfamily          => 'Debian',
        :operatingsystem   => 'Ubuntu',
        :release           => '16.04',
        :majrelease        => '16',
        :lsbdistcodename   => 'xenial',
        :prefix            => 'libboost',
        :suffix            => '.0',
        :suffix_dev        => '-dev',
        :version           => '1.58',
      },
  }

  let :pre_condition do
    'include ::boost'
  end
  let(:title) { 'signals' }

  describe 'with default values for parameters on' do
    platforms.sort.each do |k, v|
      context "#{k}" do
        let :facts do
          { :lsbdistcodename           => v[:lsbdistcodename],
            :osfamily                  => v[:osfamily],
            :operatingsystem           => v[:operatingsystem],
            :kernelrelease             => v[:release],        # Solaris specific
            :operatingsystemrelease    => v[:release],        # Linux specific
            :operatingsystemmajrelease => v[:majrelease],
          }
        end

        it { should compile.with_all_deps }

        it { should contain_package('signals').with_ensure('present') }
      end
    end
  end

  describe 'parameter functionality' do
    let(:facts) do
      {
        :osfamily               => 'Debian',
        :operatingsystem        => 'Debian',
        :operatingsystemrelease => '6.0',
        :lsbdistcodename        => 'squeeze',
      }
    end

    %w(absent present).each do |value|
      context "with ensure set to valid <#{value}>" do
        let(:params) do
          {
            :ensure => value,
          }
        end
  
        it { should contain_package('signals').with_ensure(value) }
      end
    end

    context 'with devel set to valid bool <true>' do
      let(:params) { { :devel => true } }

      it { should contain_package('signals-devel').with_ensure('present') }
    end
  end

  describe 'variable type and content validations' do
    # set needed custom facts and variables
    let(:facts) do
      {
        :osfamily        => 'Debian',
        :lsbdistcodename => 'squeeze',
        :boost_version   => '5',
      }
    end
    let(:validation_params) do
      {
        #:param => 'value',
      }
    end

    validations = {
      'bool_stringified' => {
        :name    => %w(devel),
        :valid   => [true, 'true', false, 'false'],
        :invalid => ['invalid', 3, 2.42, %w(array), { 'ha' => 'sh' }, nil],
        :message => '(is not a boolean|Unknown type of boolean)',
      },
      'string' => {
        :name    => %w(ensure prefix suffix suffix_dev version),
        :valid   => %w(string),
        :invalid => [%w(array), { 'ha' => 'sh' }, 3, 2.42, true, false],
        :message => 'is not a string',
      },
    }

    validations.sort.each do |type, var|
      var[:name].each do |var_name|
        var[:valid].each do |valid|
          context "with #{var_name} (#{type}) set to valid #{valid} (as #{valid.class})" do
            let(:params) { validation_params.merge({ :"#{var_name}" => valid, }) }
            it { should compile }
          end
        end

        var[:invalid].each do |invalid|
          context "with #{var_name} (#{type}) set to invalid #{invalid} (as #{invalid.class})" do
            let(:params) { validation_params.merge({ :"#{var_name}" => invalid, }) }
            it 'should fail' do
              expect do
                should contain_class(subject)
              end.to raise_error(Puppet::Error, /#{var[:message]}/)
            end
          end
        end
      end # var[:name].each
    end # validations.sort.each
  end # describe 'variable type and content validations'
end
