From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 15 Aug 2017 12:09:32 +0300
Subject: Flush warning
In-Reply-To: <00be01d31521$cb237900$616a6b00$@opengridcomputing.com>
References: <016301d30c86$e7034ae0$b509e0a0$@opengridcomputing.com>
 <9bc142de-b8ba-acb6-5ea1-2ccdbb578655@grimberg.me>
 <003401d30f91$c7e2a3f0$57a7ebd0$@opengridcomputing.com>
 <00ff01d3112b$94142350$bc3c69f0$@opengridcomputing.com>
 <20170809162749.GA4069@obsidianresearch.com>
 <011601d3112d$fa305b70$ee911250$@opengridcomputing.com>
 <20170813064651.GR24282@mtr-leonro.local>
 <90ada4f5-d6a1-2b93-5164-c593955c20cf@grimberg.me>
 <20170813103359.GW24282@mtr-leonro.local>
 <3d9cca62-4612-53dc-776c-3aeb2df58365@dev.mellanox.co.il>
 <1828884A29C6694DAF28B7E6B8A82373AB17595A@ORSMSX109.amr.corp.intel.com>
 <00be01d31521$cb237900$616a6b00$@opengridcomputing.com>
Message-ID: <64134765-9a10-d014-3ac4-b0f747d6c670@grimberg.me>


> By the way, the queue I'm actually having the problem with is in the iwcm, not
> the ibcm.  I think we should remove WQ_MEM_RECLAIM from all the CM queues
> because I agree now that ulps potentially can/will allocate memory in the
> contect of these workqueues...

Agreed, want to take it Steve or should I?
