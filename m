From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 2 Aug 2019 13:56:34 -0700
Subject: nvmet_tcp: panic out of memory on writes
In-Reply-To: <B33B37937B7F3D4CB878107E305D4916D165B5@ORSMSX104.amr.corp.intel.com>
References: <B33B37937B7F3D4CB878107E305D4916D165B5@ORSMSX104.amr.corp.intel.com>
Message-ID: <4ca622f1-9a1d-21e5-cfba-a785dcf4400b@grimberg.me>


> Am seeing the following Panic during 100% 4K write activity on NVMf tcp target since 5.2.1_stable.
> Exposed device (ram_disk or actual nvme disk) target makes no difference.
> Testing shows this occurring back on 5.0.7 as well.
> 
> Anyone else see this and working on it, as I dig deeper..

I have not seen this on my test vms (5.2-rcX and 5.3-rc2+ that I tested
with). kmemleak doesn't show anything either...
