From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 26 Apr 2017 21:56:48 +0300
Subject: cqe dump errors on target while running nvme-of large block read
 IO
In-Reply-To: <DE927C68B458BE418D582EC97927A92855072ECF@ORSMSX113.amr.corp.intel.com>
References: <DE927C68B458BE418D582EC97927A9285505C9EA@ORSMSX113.amr.corp.intel.com>
 <47f19583-1882-09d4-ce1c-534b8e59068b@mellanox.com>
 <DE927C68B458BE418D582EC97927A9285505F0C9@ORSMSX113.amr.corp.intel.com>
 <52c550c1-849b-7ea5-ab34-56543cb9069d@mellanox.com>
 <991b26ec-69d3-9e1c-ed3e-0d6e6618e73a@grimberg.me>
 <DE927C68B458BE418D582EC97927A92855072ECF@ORSMSX113.amr.corp.intel.com>
Message-ID: <8521776c-9557-04f1-9c7c-8389e083052b@grimberg.me>


> Folks, I have to apologize here.  Flow control was at one point configured correctly, but we had a power outage in our lab two weeks ago.
> We thought the switch had come back up OK, but late week we were double-checking all the ports in use and we found one port had lost some
> settings and no longer had flow control enabled (it had also reverted from 100Gb to 50Gb for some reason).  After fixing the port settings
> we ran IO through the weekend and the early part of this week on a variety of workloads.  We don't seem to be able to reproduce the failure
> after fixing the port settings.  It looks like this one may have been caused by the lost flow control setting on the switch.  Sorry for the confusion!

Yep, don't expect RoCE to work without flow-control.
