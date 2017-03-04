From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Fri, 03 Mar 2017 17:33:23 -0800
Subject: [nvmet/nvmetcli]- bug/break in setting a host on NVMe Target?
Message-ID: <1488591203.4759.20.camel@linux.intel.com>

Christoph,

I think something might have broke being able to use nvmetcli to set up a host
nqn name interactively?

Just following a simple example with mainline 4.10 kernel (tag - v4.10):

[stg at localhost nvmetcli]$ sudo ./nvmetcli?
/> cd /hosts
/hosts> create hostnqn
'module' object has no attribute 'Host'
/hosts>?

but if I hand-write the equivalent JSON file and load the target with that
there seems to be no issue:

[stg at localhost nvmetcli]$ sudo cat test.json?
{
? "hosts": [
? {
	"nqn": "hostnqn"
? }
? ],?
? "ports": [],?
? "subsystems": [
????{
????}
? ]
}

[stg at localhost nvmetcli]$ sudo ./nvmetcli restore test.json?
[stg at localhost nvmetcli]$ sudo ./nvmetcli?
/hosts> ls
o- hosts .................................................................
[...]
? o- hostnqn .............................................................
[...]
/hosts>?

Setting up a subsystem interactively is no issue:
[stg at localhost nvmetcli]$ sudo ./nvmetcli clear
[stg at localhost nvmetcli]$ sudo ./nvmetcli
/hosts> ls
o- hosts .................................................................
[...]
/hosts> cd ../subsystems?
/subsystems> create testnqn
/subsystems> ls
o- subsystems ............................................................
[...]
? o- testnqn .............................................................
[...]
????o- allowed_hosts .....................................................
[...]
????o- namespaces ........................................................
[...]
/subsystems>?

I haven't figured what is causing the problem yet.
