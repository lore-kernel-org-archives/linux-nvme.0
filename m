From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 May 2018 09:21:30 +0200
Subject: [PATCH 01/17] IB/isert: fix T10-pi check mask setting
In-Reply-To: <1527436222-15494-2-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-2-git-send-email-maxg@mellanox.com>
Message-ID: <20180528072130.GB5618@lst.de>

On Sun, May 27, 2018@06:50:06PM +0300, Max Gurtovoy wrote:
> A copy/paste bug (probably) caused setting of an app_tag check mask
> in case where a ref_tag check was needed.
> 
> Fixes: 38a2d0d429f1 ("IB/isert: convert to the generic RDMA READ/WRITE API")
> Fixes: 9e961ae73c2c ("IB/isert: Support T10-PI protected transactions")
> Cc: stable at vger.kernel.org
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>

Looks good, and should probably got into the scsi tree ASAP.

Btw, please don't cc stable@ for the whole series.
