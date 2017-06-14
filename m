From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Jun 2017 17:37:54 +0200
Subject: [PATCH] nvme: Remove SCSI translations
In-Reply-To: <1497452191-11429-1-git-send-email-keith.busch@intel.com>
References: <1497452191-11429-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170614153754.GA13038@lst.de>

On Wed, Jun 14, 2017@10:56:31AM -0400, Keith Busch wrote:
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

I like this but would like to hear from the SuSE folks first
as indicated in the other mail.

Also at least the nvme_get_log_page and nvme_set_features functions
in core.c are unused after this patch and can be removed as well.
