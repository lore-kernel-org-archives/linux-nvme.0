From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 03 Jan 2018 23:08:34 -0500
Subject: [PATCH] mpt3sas: Proper handling of set/clear of "ATA command
 pending" flag.
In-Reply-To: <1514444951-9502-1-git-send-email-chaitra.basappa@broadcom.com>
 (Chaitra P. B.'s message of "Wed, 27 Dec 2017 23:09:11 -0800")
References: <1514444951-9502-1-git-send-email-chaitra.basappa@broadcom.com>
Message-ID: <yq17esyxo3h.fsf@oracle.com>


Chaitra,

>  This patch fixes above two issues by setting of "ATA command pending" flag
>  after checking for whether device deleted, invalid device handle, device
>  busy with task management. And by setting "ATA command pending" flag to
>  false in all of the qcmd failure return paths after setting the flag.

Applied to 4.16/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
