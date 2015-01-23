From: axboe@fb.com (Jens Axboe)
Date: Fri, 23 Jan 2015 10:39:38 -0700
Subject: [PATCH/RFC] NVMe: add support for doing offline/online of attached
 namespaces
In-Reply-To: <20150123173140.GB28005@infradead.org>
References: <20150123152430.GA6107@kernel.dk>
 <20150123171112.GA2650@infradead.org> <54C283DD.8080809@fb.com>
 <20150123173140.GB28005@infradead.org>
Message-ID: <54C2875A.3040502@fb.com>

On 01/23/2015 10:31 AM, Christoph Hellwig wrote:
> On Fri, Jan 23, 2015@10:24:45AM -0700, Jens Axboe wrote:
>> It'd be an interesting experiment in seeing how close scsi-mq is to raw
>> performance, I'd be worried there's still quite a gap though. Maybe when
>> we're further along it starts to become a more viable option, at least I
>> would not rule it out.
>
> I'd love to try it.  On the submission side SCSI for some drivers
> actually is more efficient than nvme in terms of memory allocations
> as we don't require any allocation for common I/O. (Your patch closes
> that gap for the smallest possible IO), altough the per-host and
> per-device shost_busy/sdev_busy counters will show some issues with
> enough sockets.  On the completion side SCSI might still be a bit
> worse as we haven't really haven't started any optimizations yet.

For the per dev host/sdev busy counters, those could be further improved 
if they turn out to be a problem. I've got various "things" here that'll 
do 1-2M IOPS per dev, so some test/profiling would not be a problem to do.

First issue is support for > 1 hw queue in SCSI, though.

>> At the same time, this is a feature we use/need now. So I don't think a
>> potential switch in future direction should preclude that from being done
>> now.
>
> Sure, I was just answering your question for potential alternatives.

Great, thanks.

-- 
Jens Axboe
