#!/bin/bash
# Author: Mikolaj Izdebski <mizdebsk@redhat.com>
. /usr/share/beakerlib/beakerlib.sh

rlJournalStart

  rlPhaseStartSetup
    basedir=$PWD
    rlRun "pushd \$(mktemp -d)"
    mkdir pkg jar
  rlPhaseEnd

  rlPhaseStartTest
    tar -c -v -f smoke1.tar -C $basedir smoke1
    rlRun -s "rpmbuild -D '_topdir %{lua:print(posix.getcwd())}' -D '%_sourcedir %{_topdir}' -D '%_builddir %{_topdir}/build' -D '%_srcrpmdir %{_topdir}' -D '%_rpmdir %{_topdir}' -ba $basedir/smoke1.spec"
    dist=$(rpm -E '%{?dist}')
    nvr=smoke1-1-1$dist
    srpm=$nvr.src.rpm
    rpm=noarch/$nvr.noarch.rpm
    rlAssertExists "$srpm"
    rlAssertExists "$rpm"
    rlRun "rpm -qip $rpm"
    rlRun "rpm2cpio $rpm | (cd ./pkg && cpio -idv)"
    rlAssertExists pkg/usr/share/java/smoke-1.2.jar
    rlAssertExists pkg/usr/share/java/sub-dir/alt-name-1.2.jar
    rlAssertExists pkg/usr/share/maven-poms/smoke-1.2.pom
    rlAssertExists pkg/usr/share/maven-metadata/smoke1.xml
    rlRun "unzip -d jar pkg/usr/share/java/smoke-1.2.jar"
    rlAssertExists jar/greeter/Greeter.class
    rlAssertExists jar/META-INF/MANIFEST.MF
    rlAssertExists jar/META-INF/maven/smoke/smoke-test/pom.xml
    rlAssertExists jar/META-INF/maven/smoke/smoke-test/pom.properties
  rlPhaseEnd

rlJournalEnd
rlJournalPrintText
