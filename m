From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 30 Jul 2018 08:27:36 -0600
Subject: [PATCH v5 1/3] block: move ref_tag calculation func to the block
 layer
In-Reply-To: <1532898933-3366-1-git-send-email-maxg@mellanox.com>
References: <1532898933-3366-1-git-send-email-maxg@mellanox.com>
Message-ID: <2da4b36e-ca58-b3b3-f259-9bb03d0ae5d9@kernel.dk>

On 7/29/18 3:15 PM, Max Gurtovoy wrote:
> Currently this function is implemented in the scsi layer, but it's
> actual place should be the block layer since T10-PI is a general
> data integrity feature that is used in the nvme protocol as well.

Applied 1-3, thanks.

-- 
Jens Axboe
