From: hch@lst.de (Christoph Hellwig)
Date: Thu, 1 Sep 2016 10:35:27 +0200
Subject: [PATCH WIP/RFC v3 2/6] iw_cxgb4: block module unload until all
 ep resources are released
In-Reply-To: <bf7a550bc5e1367e4c1ec3b8e703e6d17c75e033.1472574410.git.swise@opengridcomputing.com>
References: <cover.1472574410.git.swise@opengridcomputing.com>
 <bf7a550bc5e1367e4c1ec3b8e703e6d17c75e033.1472574410.git.swise@opengridcomputing.com>
Message-ID: <20160901083527.GB3703@lst.de>

On Mon, Aug 29, 2016@02:26:48PM -0700, Steve Wise wrote:
> Otherwise an endpoint can be still closing down causing a touch
> after free crash.

This also adds a few WARN_ON calls that might be worth mentioning in the
changelog.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>
