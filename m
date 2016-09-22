From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 22 Sep 2016 16:38:48 -0500
Subject: crash when connecting to targets using nr_io_queues < num cpus
In-Reply-To: <20160922210255.GA11015@infradead.org>
References: <011401d203c4$0cdd78c0$26986a40$@opengridcomputing.com>
 <6082d700-a45c-b00a-3f09-ba6196cc3e5e@grimberg.me>
 <00ae01d2045a$a8516500$f8f42f00$@opengridcomputing.com>
 <01b401d20483$2da4fd20$88eef760$@opengridcomputing.com>
 <e31f7c2f-7b15-95f9-f882-4406c94eaedc@grimberg.me>
 <018701d20dca$22a02080$67e06180$@opengridcomputing.com>
 <20160913175223.GB13741@localhost.localdomain>
 <005101d21024$1f8913f0$5e9b3bd0$@opengridcomputing.com>
 <20160916142649.GA18798@infradead.org> <20160922210255.GA11015@infradead.org>
Message-ID: <023c01d21519$b3cda450$1b68ecf0$@opengridcomputing.com>

> Steve,
> 
> can you test if the patch below properly fails the connect and avoids
> the crash?
>

Is this the expected error?

[root at stevo1 ~]# nvme connect --nr-io-queues=26 --transport=rdma --trsvcid=4420
--traddr=10.0.1.14 --nqn=test-ram0
Failed to write to /dev/nvme-fabrics: Invalid cross-device link
[root at stevo1 ~]#

 Steve.
