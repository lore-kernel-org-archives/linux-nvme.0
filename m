From: axboe@fb.com (Jens Axboe)
Date: Tue, 31 Jan 2017 07:35:12 -0800
Subject: [PATCH] nvme/pci: Don't mark IOD as aborted if abort wasn't sent
In-Reply-To: <1485299220-14866-1-git-send-email-keith.busch@intel.com>
References: <1485299220-14866-1-git-send-email-keith.busch@intel.com>
Message-ID: <5122e41d-c58d-8cc3-38b2-ef0b352ef1ba@fb.com>

On 01/24/2017 03:07 PM, Keith Busch wrote:
> This patch sets the aborted flag only if an abort was sent, reducing
> excessive kernel message spamming for completed IO that wasn't actually
> aborted.

Thanks for handling this Keith, applied.

-- 
Jens Axboe
