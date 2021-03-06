require 'spec_helper'

describe 'log4j::appenders::syslog' do
  let(:title) { 'test' }
  let(:facts) {
    {:operatingsystemrelease => '6.5',
     :osfamily               => 'RedHat',
     :operatingsystem        => 'CentOS',
     :kernel                 => 'Linux',
    } }
  let(:params) {{
      :path => '/tmp/test.xml',
  }}

  it { should contain_log4j__appenders__syslog('test')}

  it { should contain_augeas('appender-test') }

  it { should contain_augeas('appenderref-test').with({
         'incl'    => '/tmp/test.xml',
         'lens'    => 'Xml.lns',
         'changes' => [
            "set Configuration/Loggers/Root/AppenderRef[./#attribute/ref = 'test']/#attribute/ref test",
         ]
     })}
end