From: joseph.r.gruher@intel.com (Gruher, Joseph R)
Date: Wed, 26 Apr 2017 17:17:32 +0000
Subject: cqe dump errors on target while running nvme-of large block
 read IO
In-Reply-To: <991b26ec-69d3-9e1c-ed3e-0d6e6618e73a@grimberg.me>
References: <DE927C68B458BE418D582EC97927A9285505C9EA@ORSMSX113.amr.corp.intel.com>
 <47f19583-1882-09d4-ce1c-534b8e59068b@mellanox.com>
 <DE927C68B458BE418D582EC97927A9285505F0C9@ORSMSX113.amr.corp.intel.com>
 <52c550c1-849b-7ea5-ab34-56543cb9069d@mellanox.com>
 <991b26ec-69d3-9e1c-ed3e-0d6e6618e73a@grimberg.me>
Message-ID: <DE927C68B458BE418D582EC97927A92855072ECF@ORSMSX113.amr.corp.intel.com>

> Joseph, are you sure that flow control is correctly configured and working
> reliably?

Folks, I have to apologize here.  Flow control was at one point configured correctly, but we had a power outage in our lab two weeks ago.  We thought the switch had come back up OK, but late week we were double-checking all the ports in use and we found one port had lost some settings and no longer had flow control enabled (it had also reverted from 100Gb to 50Gb for some reason).  After fixing the port settings we ran IO through the weekend and the early part of this week on a variety of workloads.  We don't seem to be able to reproduce the failure after fixing the port settings.  It looks like this one may have been caused by the lost flow control setting on the switch.  Sorry for the confusion!
