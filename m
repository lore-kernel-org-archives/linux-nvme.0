From: hch@lst.de (Christoph Hellwig)
Date: Sat, 19 Jan 2019 14:19:56 +0100
Subject: [PATCH] nvme-multipath: drop optimization for static ANA group IDs
In-Reply-To: <20190109084515.82076-1-hare@suse.de>
References: <20190109084515.82076-1-hare@suse.de>
Message-ID: <20190119131956.GB24374@lst.de>

Ok, based on the version that actually keeps the optimization I
have to say I actually prefer this variant, given that it is a lot
less code and special cases.  Sorry for sending you off the wrong track.

Reviewed-by: Christoph Hellwig <hch at lst.de>

Note that we could also remove the cached anacap value now.
