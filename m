From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 12 Apr 2018 17:28:18 -0400
Subject: [PATCH] NVMe: Add Quirk Delay before CHK RDY for Seagate Nytro
 Flash Storage
In-Reply-To: <1523561125-31945-1-git-send-email-micah.parrish@hpe.com> (Micah
 Parrish's message of "Thu, 12 Apr 2018 13:25:25 -0600")
References: <1523561125-31945-1-git-send-email-micah.parrish@hpe.com>
Message-ID: <yq1r2nkunbh.fsf@oracle.com>


Micah,

> Add Seagate Nytro Flash Storage nvme drive to quirk list for
> NVME_QUIRK_DELAY_BEFORE_CHK_RDY, which solves a bug where the drive is
> probed on hot-add before the firmare is ready, I/O errors are generated
> while reading sector 0, and linux is "unable to read partition table".

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
