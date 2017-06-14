From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 14 Jun 2017 11:17:35 -0400
Subject: [PATCH] nvme: Remove SCSI translations
In-Reply-To: <1497452191-11429-1-git-send-email-keith.busch@intel.com> (Keith
 Busch's message of "Wed, 14 Jun 2017 10:56:31 -0400")
References: <1497452191-11429-1-git-send-email-keith.busch@intel.com>
Message-ID: <yq1efumvbsg.fsf@oracle.com>


Keith,

> The SCSI-to-NVMe translations were added to assist storage
> applications utilizing SG_IO transitioning to NVMe. It was always
> recommended, however, to use native NVMe for device management: too
> much is lost in translation and the maintenance burden in keeping this
> kludgey layer around has been neglected such that much of the
> translations are completely broken.
>
> This patch removes SG_IO handling from NVMe. The config option has
> been disabled by default for quite some time now, so hopefully it's
> safe to remove. If not, this will force people to do the right thing.

Good riddance!

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
