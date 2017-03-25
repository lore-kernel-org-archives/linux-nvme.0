From: dledford@redhat.com (Doug Ledford)
Date: Fri, 24 Mar 2017 21:44:26 -0400
Subject: WARNING on drivers/infiniband/core/verbs.c:1975
 __ib_drain_sq+0x182/0x1c0 [ib_core]
In-Reply-To: <1457714996.31424605.1488696068958.JavaMail.zimbra@redhat.com>
References: <1457714996.31424605.1488696068958.JavaMail.zimbra@redhat.com>
Message-ID: <1490406266.2404.34.camel@redhat.com>

On Sun, 2017-03-05@01:41 -0500, Yi Zhang wrote:
> Hi
> 
> I get bellow WARNING when trying to connect nvmet with nvmecli.
> 
> Steps I used:
> On target:
> 1. Use nvmetcli setup nvmet with below json?
> {
> ? "hosts": [
> ????{
> ??????"nqn": "hostnqn"
> ????}
> ? ],?
> ? "ports": [
> ????{
> ??????"addr": {
> ????????"adrfam": "ipv4",?
> ????????"traddr": "172.31.40.4",?

For testing ocrdma, you need to use the 172.31.45.0 network vlan. ?For
testing other RoCE cards in our lab, you can use either the 43 or 45
vlans, but you shouldn't use the untagged interface for RoCE tests.

-- 
Doug Ledford <dledford at redhat.com>
? ? GPG KeyID: B826A3330E572FDD
? ?
Key fingerprint = AE6B 1BDA 122B 23B4 265B ?1274 B826 A333 0E57 2FDD
