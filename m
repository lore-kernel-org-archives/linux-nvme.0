From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 14:04:37 +0300
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <20170710102049.GF5105@linux-x5ow.site>
References: <20170707094838.GD16648@linux-x5ow.site>
 <a34f03ac-4306-ba87-e6f4-fc29bfd80828@grimberg.me>
 <2b758039-5957-96b5-bf30-5cbb5515fe9c@suse.de>
 <6eff23f4-1bb7-3c64-6916-987f4b38ae78@mellanox.com>
 <20170710091054.GD5105@linux-x5ow.site>
 <a940a9ea-c090-6620-a080-eb7cf6140ad3@grimberg.me>
 <20170710102049.GF5105@linux-x5ow.site>
Message-ID: <77c7d11c-bd67-8663-cc10-da3af8bfcd22@grimberg.me>


> OK, running a test now. I have a local test patch that cancels and
> re-schedules the kato work on every mq_ops->complete() for testing as well
> which I also like to check as a proof of my hypothesis and then I'll report
> back.

That won't work as the target is relying to get a keep-alive every
kato+grace-constant, otherwise it will teardown the controller
