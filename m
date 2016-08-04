From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 Aug 2016 13:50:55 +0200
Subject: [PATCH] nvmet: Fix controller serial number inconsistency
In-Reply-To: <1470307404-17193-1-git-send-email-sagi@grimberg.me>
References: <1470307404-17193-1-git-send-email-sagi@grimberg.me>
Message-ID: <20160804115055.GC32487@lst.de>

On Thu, Aug 04, 2016@01:43:24PM +0300, Sagi Grimberg wrote:
> The host is allowed to issue identify as many times
> as it wants, we need to stay consistent when reporting
> the serial number for a given controller.

Looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>

And we really should have a regression test for this using
the passthrough ioctl..
