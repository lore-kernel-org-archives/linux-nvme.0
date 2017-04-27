From: majd@mellanox.com (Majd Dibbiny)
Date: Thu, 27 Apr 2017 04:29:27 +0000
Subject: cqe dump errors on target while running nvme-of large block read
 IO
In-Reply-To: <8521776c-9557-04f1-9c7c-8389e083052b@grimberg.me>
References: <DE927C68B458BE418D582EC97927A9285505C9EA@ORSMSX113.amr.corp.intel.com>
 <47f19583-1882-09d4-ce1c-534b8e59068b@mellanox.com>
 <DE927C68B458BE418D582EC97927A9285505F0C9@ORSMSX113.amr.corp.intel.com>
 <52c550c1-849b-7ea5-ab34-56543cb9069d@mellanox.com>
 <991b26ec-69d3-9e1c-ed3e-0d6e6618e73a@grimberg.me>
 <DE927C68B458BE418D582EC97927A92855072ECF@ORSMSX113.amr.corp.intel.com>,
 <8521776c-9557-04f1-9c7c-8389e083052b@grimberg.me>
Message-ID: <209CAF47-1CE4-4A22-9E11-6377CEF62495@mellanox.com>


> On Apr 27, 2017,@2:57 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
> 
> 
>> Folks, I have to apologize here.  Flow control was at one point configured correctly, but we had a power outage in our lab two weeks ago.
>> We thought the switch had come back up OK, but late week we were double-checking all the ports in use and we found one port had lost some
>> settings and no longer had flow control enabled (it had also reverted from 100Gb to 50Gb for some reason).  After fixing the port settings
>> we ran IO through the weekend and the early part of this week on a variety of workloads.  We don't seem to be able to reproduce the failure
>> after fixing the port settings.  It looks like this one may have been caused by the lost flow control setting on the switch.  Sorry for the confusion!
> 
> Yep, don't expect RoCE to work without flow-control.
Sagi and all,

Starting in next release, for ConnectX-4 and above PFC isn't required as long as ECN is enabled.

With current release we also expect to get good results with ECN and no PFC.

Joseph - is ECN enabled on your system?

Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
