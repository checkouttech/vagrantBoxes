#!/usr/bin/env bash


# TRP Repo
echo '# TRP Repos
[TRP-5-PROD]
name=TRP-5-PROD
baseurl=http://foo/repo/TRP-5-PROD
enabled=1
priority=99
gpgcheck=0
metadata_expire=60

[TRP-5-QA]
name=TRP-5-QA
baseurl=http://foo/repo/TRP-5-QA
enabled=1
priority=99
gpgcheck=0
metadata_expire=60
' > /etc/yum.repos.d/TRP.repo

#
# Sample repo.d fie
#
#[epel]
#name=Extra Packages for Enterprise Linux 7 - $basearch
##baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch
#mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
#failovermethod=priority
#enabled=1
#gpgcheck=1
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
#
#[epel-debuginfo]
#name=Extra Packages for Enterprise Linux 7 - $basearch - Debug
##baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch/debug
#mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-debug-7&arch=$basearch
#failovermethod=priority
#enabled=0
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
#gpgcheck=1
#
#[epel-source]
#name=Extra Packages for Enterprise Linux 7 - $basearch - Source
##baseurl=http://download.fedoraproject.org/pub/epel/7/SRPMS
#mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-source-7&arch=$basearch
#failovermethod=priority
#enabled=0
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
#gpgcheck=1
#
#
# EOF
