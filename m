From: axboe@fb.com (Jens Axboe)
Date: Fri, 23 Jan 2015 10:46:19 -0700
Subject: [PATCH/RFC] NVMe: add support for doing offline/online of attached
 namespaces
In-Reply-To: <20150123174457.GA12539@infradead.org>
References: <20150123152430.GA6107@kernel.dk>
 <20150123171112.GA2650@infradead.org> <54C283DD.8080809@fb.com>
 <20150123173140.GB28005@infradead.org> <54C2875A.3040502@fb.com>
 <20150123174457.GA12539@infradead.org>
Message-ID: <54C288EB.5020506@fb.com>

On 01/23/2015 10:44 AM, Christoph Hellwig wrote:
> On Fri, Jan 23, 2015@10:39:38AM -0700, Jens Axboe wrote:
>> For the per dev host/sdev busy counters, those could be further improved if
>> they turn out to be a problem. I've got various "things" here that'll do
>> 1-2M IOPS per dev, so some test/profiling would not be a problem to do.
>
> We've tested up to 3M IOPS and it wasn't an issue, but none of these
> systems had more than two sockets.

I've got an older 4 socket here that loves to prove these are issues :-)

>> First issue is support for > 1 hw queue in SCSI, though.
>
> We've added > 1 queue support for virtio-scsi and srp, but most HBAs lack
> the hardware support for it.

Is that queued up for 3.20?


-- 
Jens Axboe
