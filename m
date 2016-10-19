From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Oct 2016 12:37:16 +0200
Subject: [PATCH 4/6] nvme-fabrics: Fix a memory leak in an
 nvmf_create_ctrl() error path
In-Reply-To: <2c9d4e7b-1c48-619c-4f48-9c968747663a@sandisk.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <2c9d4e7b-1c48-619c-4f48-9c968747663a@sandisk.com>
Message-ID: <20161019103716.GB1191@lst.de>

On Tue, Oct 18, 2016@01:11:03PM -0700, Bart Van Assche wrote:
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
