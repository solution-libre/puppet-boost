require 'spec_helper'
describe 'boost', type: 'class' do
  platforms = {
    'debian6' =>
      { osfamily:        'Debian',
        operatingsystem: 'Debian',
        release:         '6.0',
        majrelease:      '6',
        lsbdistcodename: 'squeeze',
        prefix:          'libboost',
        suffix:          '.0',
        suffix_dev:      '-dev',
        version:         '1.42' },
    'debian7' =>
      { osfamily:        'Debian',
        operatingsystem: 'Debian',
        release:         '7.0',
        majrelease:      '7',
        lsbdistcodename: 'wheezy',
        prefix:          'libboost',
        suffix:          '.0',
        suffix_dev:      '-dev',
        version:         '1.49' },
    'debian8' =>
      { osfamily:        'Debian',
        operatingsystem: 'Debian',
        release:         '8.0',
        majrelease:      '8',
        lsbdistcodename: 'jessie',
        prefix:          'libboost',
        suffix:          '.0',
        suffix_dev:      '-dev',
        version:         '1.55' },
    'debian9' =>
      { osfamily:        'Debian',
        operatingsystem: 'Debian',
        release:         '9.0',
        majrelease:      '9',
        lsbdistcodename: 'stretch',
        prefix:          'libboost',
        suffix:          '.0',
        suffix_dev:      '-dev',
        version:         '1.62' },
    'el5' =>
      { osfamily:        'RedHat',
        release:         '5.0',
        majrelease:      '5',
        lsbdistcodename: nil,
        prefix:          'boost',
        suffix:          '',
        suffix_dev:      '-devel',
        version:         '' },
    'el6' =>
      { osfamily:        'RedHat',
        release:         '6.0',
        majrelease:      '6',
        lsbdistcodename: nil,
        prefix:          'boost',
        suffix:          '',
        suffix_dev:      '-devel',
        version:         '' },
    'el7' =>
      { osfamily:        'RedHat',
        release:         '7.0',
        lsbdistcodename: nil,
        majrelease:      '7',
        prefix:          'boost',
        suffix:          '',
        suffix_dev:      '-devel',
        version:         '' },
    'ubuntu1004' =>
      { osfamily:        'Debian',
        operatingsystem: 'Ubuntu',
        release:         '10.04',
        majrelease:      '10',
        lsbdistcodename: 'lucid',
        prefix:          'libboost',
        suffix:          '.0',
        suffix_dev:      '-dev',
        version:         '1.42' },
    'ubuntu1204' =>
      { osfamily:        'Debian',
        operatingsystem: 'Ubuntu',
        release:         '12.04',
        majrelease:      '12',
        lsbdistcodename: 'precise',
        prefix:          'libboost',
        suffix:          '.0',
        suffix_dev:      '-dev',
        version:         '1.46' },
    'ubuntu1404' =>
      { osfamily:        'Debian',
        operatingsystem: 'Ubuntu',
        release:         '14.04',
        majrelease:      '14',
        lsbdistcodename: 'trusty',
        prefix:          'libboost',
        suffix:          '.0',
        suffix_dev:      '-dev',
        version:         '1.54' },
    'ubuntu1604' =>
      { osfamily:        'Debian',
        operatingsystem: 'Ubuntu',
        release:         '16.04',
        majrelease:      '16',
        lsbdistcodename: 'xenial',
        prefix:          'libboost',
        suffix:          '.0',
        suffix_dev:      '-dev',
        version:         '1.58' },
  }

  describe 'with default values for parameters on' do
    platforms.sort.each do |k, v|
      context k.to_s do
        let :facts do
          { lsbdistcodename:           v[:lsbdistcodename],
            osfamily:                  v[:osfamily],
            operatingsystem:           v[:operatingsystem],
            kernelrelease:             v[:release], # Solaris specific
            operatingsystemrelease:    v[:release], # Linux specific
            operatingsystemmajrelease: v[:majrelease] }
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_class('boost') }
      end
    end
  end

  describe 'parameter functionality' do
    let(:facts) do
      { osfamily:               'Debian',
        operatingsystem:        'Debian',
        operatingsystemrelease: '6.0',
        lsbdistcodename:        'squeeze' }
    end

    context 'when packages is set to valid hash <\'signals\' => {}>' do
      let(:params) do
        {
          packages: {
            'signals' => {},
          },
        }
      end

      platforms.sort.each do |k, v|
        context k.to_s do
          let :facts do
            { lsbdistcodename:           v[:lsbdistcodename],
              osfamily:                  v[:osfamily],
              operatingsystem:           v[:operatingsystem],
              kernelrelease:             v[:release], # Solaris specific
              operatingsystemrelease:    v[:release], # Linux specific
              operatingsystemmajrelease: v[:majrelease],
              prefix:                    v[:prefix],
              suffix:                    v[:suffix],
              suffix_dev:                v[:suffix_dev],
              version:                   v[:version] }
          end

          it { is_expected.to contain_package('boost-signals').with_ensure('present') }
        end
      end
    end

    context 'when all_devel is set to valid bool <true>' do
      let(:params) { { all_devel: true } }

      it { is_expected.to contain_package('boost-devel').with_ensure('present') }
    end

    context 'when doc is set to valid bool <true>' do
      let(:params) { { doc: true } }

      it { is_expected.to contain_package('boost-doc').with_ensure('present') }
    end
  end

  describe 'failures' do
    let(:facts) do
      { osfamily:               'Debian',
        operatingsystem:        'Debian',
        operatingsystemrelease: '6.0',
        lsbdistcodename:        'squeeze' }
    end

    context 'when major release of Debian is unsupported' do
      let :facts do
        { osfamily:                  'Debian',
          operatingsystem:           'Debian',
          operatingsystemrelease:    '4.0',
          operatingsystemmajrelease: '4',
          lsbdistcodename:           'etch' }
      end

      it 'fails' do
        expect {
          is_expected.to contain_class('boost')
        }.to raise_error(Puppet::Error, %r{boost supports Debian 6 \(squeeze\), 7 \(wheezy\), 8 \(jessie\) and 9 \(stretch\). Detected operatingsystemrelease is <4.0>\.})
      end
    end

    context 'when major release of Ubuntu is unsupported' do
      let :facts do
        { osfamily:                  'Debian',
          operatingsystem:           'Ubuntu',
          operatingsystemrelease:    '8.04',
          operatingsystemmajrelease: '8',
          lsbdistcodename:           'hardy' }
      end

      it 'fails' do
        expect {
          is_expected.to contain_class('boost')
        }.to raise_error(Puppet::Error, %r{boost supports Ubuntu 10\.04 \(lucid\), 12\.04 \(precise\), 14.04 \(trusty\) and 16.04 \(xenial\). Detected operatingsystemrelease is <8.04>\.})
      end
    end

    context 'when osfamily is unsupported' do
      let :facts do
        { osfamily:                  'Unsupported',
          operatingsystem:           'Unsupported',
          operatingsystemrelease:    '9.0',
          operatingsystemmajrelease: '9' }
      end

      it 'fails' do
        expect {
          is_expected.to contain_class('boost')
        }.to raise_error(Puppet::Error, %r{boost supports osfamilies Debian and RedHat\. Detected osfamily is <Unsupported>\.})
      end
    end
  end

  describe 'variable type and content validations' do
    # set needed custom facts and variables
    let(:facts) do
      { osfamily:                  'Debian',
        operatingsystem:           'Debian',
        operatingsystemrelease:    '6.0',
        operatingsystemmajrelease: '6',
        lsbdistcodename:           'squeeze' }
    end
    let(:validation_params) do
      {
        #:param => 'value',
      }
    end

    validations = {
      'bool_stringified' => {
        name: ['all_devel', 'devel', 'doc'],
        valid: [true, 'true', false, 'false'],
        invalid: ['invalid', 3, 2.42, ['array'], { 'ha' => 'sh' }, nil],
        message: '(is not a boolean|Unknown type of boolean)',
      },
      'hash' => {
        name: ['packages'],
        valid: [{ 'ha' => {} }],
        invalid: ['string', 3, 2.42, ['array'], true, false, nil],
        message: 'is not a Hash',
      },
      'string' => {
        name: ['package_ensure', 'prefix', 'suffix', 'suffix_dev', 'version'],
        valid: ['present'],
        invalid: [['array'], { 'ha' => 'sh' }],
        message: 'is not a string',
      },
    }

    validations.sort.each do |type, var|
      var[:name].each do |var_name|
        var[:valid].each do |valid|
          context "with #{var_name} (#{type}) set to valid #{valid} (as #{valid.class})" do
            let(:params) { validation_params.merge(:"#{var_name}" => valid) }

            it { is_expected.to compile }
          end
        end

        var[:invalid].each do |invalid|
          context "with #{var_name} (#{type}) set to invalid #{invalid} (as #{invalid.class})" do
            let(:params) { validation_params.merge(:"#{var_name}" => invalid) }

            it 'fails' do
              expect {
                catalogue
              }.to raise_error(Puppet::Error, %r{#{var[:message]}})
            end
          end
        end
      end # var[:name].each
    end # validations.sort.each
  end # describe 'variable type and content validations'
end
