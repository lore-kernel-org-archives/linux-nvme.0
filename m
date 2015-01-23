From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 23 Jan 2015 09:44:57 -0800
Subject: [PATCH/RFC] NVMe: add support for doing offline/online of
 attached namespaces
In-Reply-To: <54C2875A.3040502@fb.com>
References: <20150123152430.GA6107@kernel.dk>
 <20150123171112.GA2650@infradead.org> <54C283DD.8080809@fb.com>
 <20150123173140.GB28005@infradead.org> <54C2875A.3040502@fb.com>
Message-ID: <20150123174457.GA12539@infradead.org>

On Fri, Jan 23, 2015@10:39:38AM -0700, Jens Axboe wrote:
> For the per dev host/sdev busy counters, those could be further improved if
> they turn out to be a problem. I've got various "things" here that'll do
> 1-2M IOPS per dev, so some test/profiling would not be a problem to do.

We've tested up to 3M IOPS and it wasn't an issue, but none of these
systems had more than two sockets.

> First issue is support for > 1 hw queue in SCSI, though.

We've added > 1 queue support for virtio-scsi and srp, but most HBAs lack
the hardware support for it.
