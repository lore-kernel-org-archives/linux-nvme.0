From: bvanassche@acm.org (Bart Van Assche)
Date: Thu, 8 Aug 2019 16:57:53 -0700
Subject: [PATCH v3 0/7] nvme controller reset and namespace scan work race
 conditions
In-Reply-To: <32b4c64f-4565-5a1c-269e-9a9059570e99@grimberg.me>
References: <20190808205325.24036-1-sagi@grimberg.me>
 <779b707b-5892-bf23-52d8-5c8affe524b6@acm.org>
 <32b4c64f-4565-5a1c-269e-9a9059570e99@grimberg.me>
Message-ID: <90120210-7740-d0c8-10cf-93e2c8977e99@acm.org>

On 8/8/19 4:33 PM, Sagi Grimberg wrote:
> 
>>> for j in `seq 50`; do for i in `seq 50`; do nvme reset /dev/nvme0; 
>>> done ; nvme disconnect-all; nvme connect-all; done
>>
>> Has anyone already volunteered to convert this into a patch for the 
>> blktests project?
> 
> I'll see if it can reliably reproduce it for loop. Or perhaps I can
> run this with tcp on 127.0.0.1?

There are more tests in blktests that use loopback over a local network 
interface, e.g. the SRP tests. You may want to have a look at 
get_ipv4_addr(), get_ipv6_addr() and other functions in 
common/multipath-over-rdma.

Bart.
