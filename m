From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 9 Feb 2016 12:44:28 -0700
Subject: [PATCH] nvme: fix drvdata setup for the nvme device
In-Reply-To: <1454954856-32236-1-git-send-email-hch@lst.de>
References: <1454954856-32236-1-git-send-email-hch@lst.de>
Message-ID: <56BA419C.1010806@kernel.dk>

On 02/08/2016 11:07 AM, Christoph Hellwig wrote:
> Pass the right private data to device_create_with_groups from the
> beginning, and remove the superflous call to dev_set_drvdata.

Added for 4.6.

-- 
Jens Axboe
