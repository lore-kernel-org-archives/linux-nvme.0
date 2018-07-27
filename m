From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 27 Jul 2018 09:21:03 -0600
Subject: [PATCH v4 1/3] block: move ref_tag calculation func to the block
 layer
In-Reply-To: <1532533577-1600-1-git-send-email-maxg@mellanox.com>
References: <1532533577-1600-1-git-send-email-maxg@mellanox.com>
Message-ID: <a50d17af-6e6f-c899-5dd6-e87d5436af98@kernel.dk>

On 7/25/18 9:46 AM, Max Gurtovoy wrote:
> Currently this function is implemented in the scsi layer, but it's
> actual place should be the block layer since T10-PI is a general
> data integrity feature that is used in the nvme protocol as well.

Applied 1-3 for 4.19.

-- 
Jens Axboe
