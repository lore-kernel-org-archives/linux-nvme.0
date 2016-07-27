From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 27 Jul 2016 11:04:23 +0300
Subject: kworker blocked for more than 120s - heavy load on SSD
In-Reply-To: <db42fba9a6344f9ea54ba477fa41ea17@bowex36e.micron.com>
References: <db42fba9a6344f9ea54ba477fa41ea17@bowex36e.micron.com>
Message-ID: <b106a662-c446-bbe1-f521-f67432df4dfd@grimberg.me>

Hey Robert,

> We are stress testing the Windows NVMe over Fabrics host driver and we're seeing a few issues.  Snippets are below.
> These issues are repeatable and occur when the underlying NVMe SSD is being overloaded; it has too much work to do.
> Any and all help on tracking down the root cause would be much appreciated.
> The server code is the nvmf-all.3 branch and the kernel was built early yesterday.

First, thanks for reporting.

The hung task is is a queue termination that gets stuck. I believe this
is an escalation of the host disconnecting from the controller during
live I/O.

When we teardown a queue, we wait for all the active I/O on it to
complete (each I/O takes a reference on the queue). nvme_sq_destroy()
wait for that reference to reach zero. The fact is that it's not
happening, can be:
1. we are messing up with refcounting.
2. the backend never completes certain I/Os.

The fact that you mentioned that the SSD is being overloaded makes
me think that its the SSD's not completing all the I/Os but I'm
not sure. If this is the case, perhaps we need to protect ourselves
against it. I'm wandering if Keith's patch to limit the number of
retries in the nvme driver can help:

--
commit f80ec966c19b78af4360e26e32e1ab775253105f
Author: Keith Busch <keith.busch at intel.com>
Date:   Tue Jul 12 16:20:31 2016 -0700

     nvme: Limit command retries

     Many controller implementations will return errors to commands that 
will
     not succeed, but without the DNR bit set. The driver previously retried
     these commands an unlimited number of times until the command timeout
     has exceeded, which takes an unnecessarilly long period of time.

     This patch limits the number of retries a command can have, defaulting
     to 5, but is user tunable at load or runtime.

     The struct request's 'retries' field is used to track the number of
     retries attempted. This is in contrast with scsi's use of this field,
     which indicates how many retries are allowed.

     Signed-off-by: Keith Busch <keith.busch at intel.com>
     Reviewed-by: Christoph Hellwig <hch at lst.de>
     Signed-off-by: Jens Axboe <axboe at fb.com>
--

Can you please add some more log info so we can see when the queue
teardown started and why?

Also, it would help if you share your test case.

Cheers,
Sagi.
