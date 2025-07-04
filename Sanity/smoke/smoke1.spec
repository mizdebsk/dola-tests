Name:           smoke1
Version:        1
Release:        %autorelease
Summary:        Smoke test 1
License:        MIT-0
BuildArch:      noarch
ExclusiveArch:  %{java_arches} noarch

Source:         smoke1.tar

BuildSystem:    maven
BuildOption:    usesJavapackagesBootstrap
BuildOption:    mavenOptions {
BuildOption:        "-Pquality"
BuildOption:        "-Djupiter=junit-jupiter"
BuildOption:    }
BuildOption:    testExclude "FailingTest"
BuildOption:    transform ":smoke-test" {
BuildOption:        removeDependency "com.example:bad-dep"
BuildOption:    }
BuildOption:    artifact ":smoke-test" {
BuildOption:        files {
BuildOption:            "smoke"
BuildOption:            "sub-dir/alt-name"
BuildOption:        }
BuildOption:        compatVersion "1.2"
BuildOption:    }

%description
Smoke test.

%files -f .mfiles

%changelog
%autochangelog
