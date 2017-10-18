From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Oct 2017 08:26:05 +0300
Subject: v4.14-rc5 NVMeOF regression?
In-Reply-To: <5fb38923-36f7-c069-5f1d-96f4a9c98248@wdc.com>
References: <1508192588.2493.60.camel@wdc.com>
 <82de6177-27f5-463e-3446-0305fd9f6790@grimberg.me>
 <5fb38923-36f7-c069-5f1d-96f4a9c98248@wdc.com>
Message-ID: <07f75a37-cd25-81c1-3264-2be80bb9a763@grimberg.me>


> Hello Sagi,
> 
> Had I mentioned that I ran into a real deadlock and not only into a 
> lockdep complaint?

No, and the output is a lockdep complaint which I thought needed
silencing.

If you ran into a real deadlock, did you have any other output from
hung_task watchdog? I do not yet understand the root cause from
lockdep info provided.

Also, do you know at which test-case this happened?

> Additionally, can you explain to me why you think the 
> above patch is necessary? As far as I can see nvme_rdma_ctrl_mutex is 
> not held around the ib_register_client(&nvme_rdma_ib_client) call nor 
> around the ib_unregister_client(&nvme_rdma_ib_client) calls.

Its held under ib_unregister_client, my understanding is that the
_nested annotation is required for the inner mutex lock acquire.
