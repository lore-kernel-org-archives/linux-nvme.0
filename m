From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 28 May 2019 12:36:50 -0700
Subject: [PATCH 1/1] nvme-rdma: Add association between ctrl and transport
 dev
In-Reply-To: <77b99fb1-8996-52bf-1e6f-f2fee9216a2e@mellanox.com>
References: <1558444796-5190-1-git-send-email-maxg@mellanox.com>
 <da6603ee-4a71-e057-5c88-656455956eba@grimberg.me>
 <ceb1744a-cc68-9588-bd07-d3060630e857@mellanox.com>
 <724732d9-2ea2-e349-435b-ae664692b565@grimberg.me>
 <77b99fb1-8996-52bf-1e6f-f2fee9216a2e@mellanox.com>
Message-ID: <bfff9f16-6893-2324-9b64-34bd69e5459e@grimberg.me>


>> I'm getting the feeling that we need to map the qe's in queue_rq
>> and unmap in complete_rq. I don't see any other way around it because
>> on the bonding use-case we need to wipe out all of the device related
>> resources because we need to have it teardown and be prepared to get
>> a different device on the next (re)connect.
> 
> Yes, thought using block layer iter but in case it won't hurt 
> performance I'll do it in queue_rq/complete_rq.
> 
> Let me check that...

OK,

So lets just do that instead, and not try to get too smart with device
referencing...
