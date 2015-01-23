From: axboe@fb.com (Jens Axboe)
Date: Fri, 23 Jan 2015 10:52:21 -0700
Subject: [PATCH/RFC] NVMe: add support for doing offline/online of attached
 namespaces
In-Reply-To: <20150123175121.GA28134@infradead.org>
References: <20150123152430.GA6107@kernel.dk>
 <20150123171112.GA2650@infradead.org> <54C283DD.8080809@fb.com>
 <20150123173140.GB28005@infradead.org> <54C2875A.3040502@fb.com>
 <20150123174457.GA12539@infradead.org> <54C288EB.5020506@fb.com>
 <20150123175121.GA28134@infradead.org>
Message-ID: <54C28A55.8070101@fb.com>

On 01/23/2015 10:51 AM, Christoph Hellwig wrote:
> On Fri, Jan 23, 2015@10:46:19AM -0700, Jens Axboe wrote:
>>> We've added > 1 queue support for virtio-scsi and srp, but most HBAs lack
>>> the hardware support for it.
>>
>> Is that queued up for 3.20?
>
> All that work already is in 3.19-rc.

Oh, guess I had missed that... Thanks!

-- 
Jens Axboe
