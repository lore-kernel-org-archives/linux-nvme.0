From: hch@lst.de (Christoph Hellwig)
Date: Wed, 6 Jun 2018 16:42:08 +0200
Subject: [PATCH] block: pass failfast and driver-specific flags to
 flush requests
In-Reply-To: <20180606142140.64146-1-hare@suse.de>
References: <20180606142140.64146-1-hare@suse.de>
Message-ID: <20180606144208.GA20487@lst.de>

On Wed, Jun 06, 2018@04:21:40PM +0200, Hannes Reinecke wrote:
> If flush requests are being sent to the device we need to inherit the
> failfast and driver-specific flags, too, otherwise I/O will fail.

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
