From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 1 Sep 2016 12:32:46 +0300
Subject: crash when connecting to targets using nr_io_queues < num cpus
In-Reply-To: <011401d203c4$0cdd78c0$26986a40$@opengridcomputing.com>
References: <011401d203c4$0cdd78c0$26986a40$@opengridcomputing.com>
Message-ID: <6082d700-a45c-b00a-3f09-ba6196cc3e5e@grimberg.me>


> Hey all,
>
> I'm testing smaller ioq sets with nvmf/rdma, and I see some issue.  If I connect
> with 2, 4, 6, 8, 10, 16, or 32  for nr_io_queues, everything is happy.  It
> seems, though, if I connect with a value of 12, or 28, or some other non power
> of two, I get intermittent crashes in __blk_mq_get_reserved_tag() at line 337
> when setting up a controller's IO queues.   I'm not sure exactly if this is
> always non power of two, or something else, but it seems to never crash with
> power of two values (could be a coincidence I guess).

I think Ming sent a patch for this some time ago... Not sure what
happened with it though...
