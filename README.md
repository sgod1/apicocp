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

Configure API case file.<br/>

To find APIC case version, check API 10 version compatibility requirements:<br/>
```
https://www.ibm.com/docs/en/api-connect/software/10.0.8_lts?topic=dr-api-connect-version-10-software-product-compatibility-requirements
```

Create apic case environment file **apic-version.env**.<br/>
Eg for 10.0.8.0.3, create apic-10.0.8.3.env
```
CASE_NAME=ibm-apiconnect
CASE_VERSION=10.0.8.3
```

*Cloud pak Common Services*<br/>

*Common Services* version depends on OpenShift version and APIC version.<br/>
```
https://www.ibm.com/docs/en/cloud-paks/foundational-services/4.6.0?topic=installer-supported-openshift-kubernetes-versions
```
For example, the earliest CS verison for OpenShift 4.18 is 4.6.11<br/>

*CommonServices* case reference:<br/>
```
https://ibm.github.io/cloud-pak/assets/html/ibm-cp-common-services-table.html
```

*Foundational Services Support Cycle 2*<br/>
```
https://www.ibm.com/docs/en/cloud-paks/foundational-services/4.6.0
```

Create cloudpak common services environment file.<br/>
Eg, for cs 4.6.11, create env file cs-4.6.11.env
```
CASE_NAME=ibm-cp-common-services
CASE_VERSION=4.6.11
```

Download apic and cs case files, and generate manifests target APIC version and CS version.<br/>

```
1-download-case-files.sh apic-case.env
1-download-case-files.sh cs-case.env

2-list-downloaded-cases.sh apic-case.env
2-list-downloaded-cases.sh cs-case.env

3-generate-mirror-manifests.sh apic-case.env
3-generate-mirror-manifests.sh cs-case.env
```

If you have proxy docker registry for *cp.icr.io*, you do not need to mirror images.<br/>

Mirror *cp.icr.io* images to private registry.
```
4-oc-image-mirror.sh apic-case.env
4-oc-image-mirror.sh cs-case.env
```

ImageDigestMirrorSet redirects *cp.icr.io* images to private registry.<br/>
ImageDigestMirrorSet is created for each case name / case version combination.<br/>

Apply image digest mirror set
```
5-apply-image-digest-mirror-set.sh apic-case.env
5-apply-image-digest-mirror-set.sh cs-case.env
```

CatlogSources is created for each case name / case version combination.<br/>
Apply catalog sources
```
6-apply-catalog-sources.sh apic-case.env
6-apply-catalog-sources.sh cs-case.env
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

See information about common services versions in the *install* sectioni above.<br/>

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

*Pre-upgrade*<br/>
Check subsystems health, verify each subsystem status *RUNNING*
```
oc project apic
oc get ManagementCluster 
oc get GatewayCluster
oc get PortalCluster
oc get AnalyticsCluster
```

Backup API Manager and LUR databases.<br/>
```
u0-backup-api-mgr-db.sh
```

apicops subsys check
```
u0-apicops-subsys-check.sh management
u0-apicops-subsys-check.sh portal
u0-apicops-subsys-check.sh analytics
```

Backup API Connect deployment.<br/>
```
https://www.ibm.com/docs/en/api-connect/software/10.0.8_lts?topic=connect-backing-up-restoring-disaster-recovery
```

*Upgrade*
Upgrade operators
```
6-apply-catalog-sources.sh apic-case.env
6-apply-catalog-sources.sh cs-case.env
```

Upgrade channels in the following sequence:<br/>
```
datapower
api connect
foundational services
```

Use OpenShuft to upgrade operator subscription channels.<br/>

Check subsystems.<br/>

*Update subsystem CRs*.<br/>
```
spec.version: 10.0.8.9
```

Update deprecated deployment profiles.<br/>

