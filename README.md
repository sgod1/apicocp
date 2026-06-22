## apicocp: IBM API Connect on OpenShift Install / Upgrade

*APIC airgapped install on OpenShift*

Install CLI tools
```
0-install-cli.sh
ls -l bin
```

Configure IBM cloud pak
```
0-config-ibm-pak.sh
```

Configure **creds.env** file and login into container registries.
```
1-login-ibm-registry.sh
1-login-private-registry.sh
1-login-redhat-registry.sh
```

Create apic case environment file.<br/>
Create cloudpak common services environment file.<br/>

Download apic case files.
```
1-download-case-files.sh apic-case.env
```

List downloaded cases
```
2-list-downloaded-cases.sh apic-case.env
```

Generate mirror manifests.
```
3-generate-mirror-manifests.sh apic-case.env
```

If you have proxy docker registry for *cp.icr.io*, you do not need to mirror images.<br/>

Mirror *cp.icr.io* images to private registry.
```
4-oc-image-mirror.sh apic-case.env
```

Apply image digest mirror set
```
5-apply-image-digest-mirror-set.sh apic-case.env
```

Apply catalog sources
```
6-apply-catalog-sources.sh apic-case.env
```

*APIC airgapped upgrade on OpenShift*

Upgrade path depends on the installed and target APIC versions.<br/>

Sometimes upgrade is direct, and some times version path is required.<br/>

Define APIC and CS environment files for the target version.<br/>

Eg, for the target APIC version *10.0.8.9* create apic-10.0.8.9.env, and cs-4.6.11.env

cat apic-10.0.8.9.env
```
CASE_NAME=ibm-apiconnect
CASE_VERSION="5.11.0"
APIC_VERSION="10.0.8.9"
```

cat cs-4.6.11.env
```
CASE_NAME=ibm-cp-common-services
CASE_VERSION=4.6.11
```

*Pre upgrade*

Download case files, generate manifests, and mirror images for the target APIC version and CS version.<br/>

```
1-download-case-files.sh apic-case.env
1-download-case-files.sh cs-case.env

2-list-downloaded-cases.sh apic-case.env
2-list-downloaded-cases.sh cs-case.env

3-generate-mirror-manifests.sh apic-case.env
3-generate-mirror-manifests.sh cs-case.env

4-oc-image-mirror.sh apic-case.env
4-oc-image-mirror.sh cs-case.env
```

*Pre-upgrade*
Check subsystems health<br/>
Backup subsystems</br/>

*Upgrade*
Upgrade operators
```
6-apply-catalog-sources.sh apic-case.env
6-apply-catalog-sources.sh cs-case.env
```

*Upgrade subsystem CRs*.<br/>
