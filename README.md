## apicocp: IBM API Connect on OpenShift Install / Upgrade

*APIC airgapped install on OpenShift*<

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

Download apic case files.
```
1-download-case-files.sh ./apic-case.env
```

List downloaded cases
```
2-list-downloaded-cases.sh ./apic-case.env
```

Generate mirror manifests.
```
3-generate-mirror-manifests.sh ./apic-case.env
```

If you have proxy docker registry for *cp.icr.io*, you do not need to mirror images.<br/>

Mirror *cp.icr.io* images to private registry.
```
4-oc-image-mirror.sh ./apic-case.env
```

Apply image digest mirror set
```
5-apply-image-digest-mirror-set.sh
```

Apply catalog sources
```
6-apply-catalog-sources.sh
```
