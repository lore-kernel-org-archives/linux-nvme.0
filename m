From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 21 Jun 2017 09:30:21 +0200
Subject: [PATCHv2] nvme: Remove SCSI translations
In-Reply-To: <1497987223-3119-1-git-send-email-keith.busch@intel.com>
References: <1497987223-3119-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170621073020.GB4131@linux-x5ow.site>

On Tue, Jun 20, 2017@03:33:43PM -0400, Keith Busch wrote:
> The SCSI-to-NVMe translations were added to assist storage applications
> utilizing SG_IO transitioning to NVMe. It was always recommended,
> however, to use native NVMe for device management as too much is lost
> in translation and the maintenance burden in keeping this kludgey
> layer around has been neglected such that much of the translations are
> completely broken.
> 
> This patch removes SG_IO handling from NVMe to avoid any confusion
> regarding maintenance support for this interface. The config option for
> NVMe SCSI emulation has been disabled by default since 4.5. The driver
> has supported native nvme user commands since the beginning, and native
> tooling is publicly available for use or as reference for anyone writing
> their own tools, so there's no excuse for hanging onto a broken crutch.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> Acked-by: Jens Axboe <axboe at kernel.dk>
> Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> ---

Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
