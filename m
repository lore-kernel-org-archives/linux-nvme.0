From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 16 Nov 2017 20:36:33 +0200
Subject: [PATCH v2 0/3] nvmet-rdma: SRQ per completion vector
In-Reply-To: <1510852885-25519-1-git-send-email-maxg@mellanox.com>
References: <1510852885-25519-1-git-send-email-maxg@mellanox.com>
Message-ID: <263c6c9d-0dd2-da4f-12a9-efefd361e592@grimberg.me>


> Since there is an active discussion regarding the CQ pool architecture, I decided to push
> this feature (maybe it can be pushed before CQ pool).
> 
> This is a new feature for NVMEoF RDMA target,

Any chance having this for the rest? isert, srpt, svcrdma?

> results:
> 
> BS    1.read (target CPU)   2.read (target CPU)    3.read (target CPU)   4.read (target CPU)
> ---  --------------------- --------------------- --------------------- ----------------------
> 1k     5.88M (80%)            5.45M (72%)            6.77M (91%)          2.2M (72%)
> 
> 2k     3.56M (65%)            3.45M (59%)            3.72M (64%)          2.12M (59%)
> 
> 4k     1.8M (33%)             1.87M (32%)            1.88M (32%)          1.59M (34%)

I'm blown by the fact that there is such a small difference for 4k
reads, how many cpu-cores did you have on the target-system? single
numa-node? Maybe if that is the case we can use less srqs than 
per-completion-vector...
