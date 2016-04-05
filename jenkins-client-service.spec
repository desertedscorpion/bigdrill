Name:           jenkins-client-service
Version:        VERSION
Release:        RELEASE
Summary:        Installs my personal repo.

Group:          Administrative
License:        GNU/GPL3
URL:            git@github.com:desertedscorpion/lostlocomotive.git
Source:         %{name}-%{version}.tar.gz
Prefix:         %{_prefix}
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

%define debug_package %{nil}


%description
This programs installs the jenkins client service.

%prep
%setup -q


%build

%install
rm -rf ${RPM_BUILD_ROOT}
mkdir --parents ${RPM_BUILD_ROOT}/usr/lib/systemd/system
cp jenkins-client.service ${RPM_BUILD_ROOT}/usr/lib/systemd


%clean
rm -rf ${RPM_BUILD_ROOT}


%files
%attr(0644,root,root) /usr/lib/systemd/system/jenkins-client.service
