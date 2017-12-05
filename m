From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 5 Dec 2017 09:22:05 +0200
Subject: [PATCH rfc 2/2] nvmet: expose option to emulate a nvm subsystem
 in read-only mode
In-Reply-To: <20171204200653.GA17023@lst.de>
References: <20171204092435.20000-1-sagi@grimberg.me>
 <20171204092435.20000-3-sagi@grimberg.me> <20171204161930.GA12277@lst.de>
 <c3d78077-b5b0-c05e-fca1-ca9ef5a0e1eb@grimberg.me>
 <20171204200653.GA17023@lst.de>
Message-ID: <8abf14b8-53a0-c39d-e17e-99bd7840b7a7@grimberg.me>


>> Can you please elaborate what you mean? are you talking about this
>> patch in particular (simply an emulation)? or support for this
>> altogether? A subsystem can, at any point, be placed in read-only mode.
>> In that case it needs to send SMART AER to indicate health status
>> change. I think that if the media has been placed in read-only mode, we
>> need to log it, and set all the subsystem namespaces in read-only mode.
>>
>> Anything different you think we need to do here?
> 
> Yes, but for that we should trigger it off gettind a EROFS warning
> from the block device, not through sysfs.

Just to be clear, that is exactly what I intended to do.

fs/block_dev.c checks bdev_read_only() in blkdev_write_iter and also
there is a patchset to enforce this for several places in the block
layer from Ilya Dryomov ("block: enforce ioctl(BLKROSET) and
set_disk_ro()")

I wander if we need this also in generic_write_checks()?

> Having the explicit sysfs
> no, and the code to send the AER on connect suggests to me that
> this was intended to be used to emulate a r/o setting, but apparently
> I was wrong.

I'm not sure I understand your point here, can you explain what you
mean?

nvmet sends a smart AER in case a host connected to a subsystem
in r/o state because there no other way it will know that (other than
failing writes when they come). Its just an attempt to notify the host
right away instead of waiting for it to issue writes and fail later.
