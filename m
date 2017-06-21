From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Wed, 21 Jun 2017 16:19:39 +0800
Subject: [PATCHv2] nvme: Remove SCSI translations
In-Reply-To: <1497987223-3119-1-git-send-email-keith.busch@intel.com>
References: <1497987223-3119-1-git-send-email-keith.busch@intel.com>
Message-ID: <ec7ea66d-959e-6ce7-f82e-d3cbe15ad65b@huawei.com>


On 2017/6/21 3:33, Keith Busch wrote:
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

Reviewed-by: Guan Junxiong <guanjunxiong at huawei.com>

.
