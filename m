From: hch@lst.de (Christoph Hellwig)
Date: Tue, 12 Mar 2019 18:00:55 +0100
Subject: [PATCH] nvmet: ignore EOPNOTSUPP for discard
In-Reply-To: <SN6PR04MB45274EEAD33D2D744B69EF5386490@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190312153005.19373-1-hch@lst.de>
 <SN6PR04MB45274EEAD33D2D744B69EF5386490@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <20190312170055.GA3257@lst.de>

Btw, one bit missing in the description is that it also converts
directly from the errno to the nvme status code for io-cmd-bdev.c,
but I guess that should really be a separate patch.  I'll resend
it as two patches with the reviewed-by tags added, if any of you
wants to revoke their reviews, let me know.
