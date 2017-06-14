From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 14 Jun 2017 08:50:20 -0600
Subject: [PATCH] nvme: Remove SCSI translations
In-Reply-To: <1497452191-11429-1-git-send-email-keith.busch@intel.com>
References: <1497452191-11429-1-git-send-email-keith.busch@intel.com>
Message-ID: <117ed46c-e1db-c5eb-129d-34950ca883d7@kernel.dk>

On 06/14/2017 08:56 AM, Keith Busch wrote:
> The SCSI-to-NVMe translations were added to assist storage applications
> utilizing SG_IO transitioning to NVMe. It was always recommended, however,
> to use native NVMe for device management: too much is lost in translation
> and the maintenance burden in keeping this kludgey layer around has been
> neglected such that much of the translations are completely broken.
> 
> This patch removes SG_IO handling from NVMe. The config option has been
> disabled by default for quite some time now, so hopefully it's safe to
> remove. If not, this will force people to do the right thing.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Acked-by: Jens Axboe <axboe at kernel.dk>

-- 
Jens Axboe
