From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Dec 2017 21:06:53 +0100
Subject: [PATCH rfc 2/2] nvmet: expose option to emulate a nvm
 subsystem in read-only mode
In-Reply-To: <c3d78077-b5b0-c05e-fca1-ca9ef5a0e1eb@grimberg.me>
References: <20171204092435.20000-1-sagi@grimberg.me>
 <20171204092435.20000-3-sagi@grimberg.me> <20171204161930.GA12277@lst.de>
 <c3d78077-b5b0-c05e-fca1-ca9ef5a0e1eb@grimberg.me>
Message-ID: <20171204200653.GA17023@lst.de>

On Mon, Dec 04, 2017@08:11:14PM +0200, Sagi Grimberg wrote:
> Can you please elaborate what you mean? are you talking about this
> patch in particular (simply an emulation)? or support for this
> altogether? A subsystem can, at any point, be placed in read-only mode.
> In that case it needs to send SMART AER to indicate health status
> change. I think that if the media has been placed in read-only mode, we
> need to log it, and set all the subsystem namespaces in read-only mode.
>
> Anything different you think we need to do here?

Yes, but for that we should trigger it off gettind a EROFS warning
from the block device, not through sysfs. Having the explicit sysfs
no, and the code to send the AER on connect suggests to me that
this was intended to be used to emulate a r/o setting, but apparently
I was wrong.
