From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Oct 2015 14:53:05 +0200
Subject: [PATCH 7/8] nvme: move namespace scanning to common code
In-Reply-To: <alpine.LNX.2.00.1510131918560.27742@localhost.lm.intel.com>
References: <1444633811-28319-1-git-send-email-hch@lst.de>
 <1444633811-28319-8-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1510131918560.27742@localhost.lm.intel.com>
Message-ID: <20151014125305.GA14457@lst.de>

On Tue, Oct 13, 2015@07:31:57PM +0000, Keith Busch wrote:
> The "__exit" section on nvme_core_exit causes a mismatch reference warning
> since it's being called from an __init section. Just drop __exit from
> the core function.
>
> Other than that, this is series has gone very smoothly; initial sanity
> testing hasn't hit any issues yet. I'll run tests on metadata formats
> later today/early tomorrow and will let you know how that goes.

Thanks.  I've found another small bug where I pass a __le64 value
without endianess conversion, but that shouldn't impact your testing
on little endian platforms.  I'm not going to resend anything before I
have results on the metadata ioctls.  Talking about those:  What userspace
programs actually use the NVME_IOCTL_SUBMIT_IO?
