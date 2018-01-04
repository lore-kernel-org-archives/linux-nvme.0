From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 03 Jan 2018 23:07:18 -0500
Subject: [PATCH 00/11] mpt3sas: Enable scsi MQ & lockless command
 submission
In-Reply-To: <1513927907-19735-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 (Suganath Prabu S.'s message of "Thu, 21 Dec 2017 23:31:36 -0800")
References: <1513927907-19735-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <yq1bmiaxo5l.fsf@oracle.com>


Suganath,

> This patch set is initially posted by Hannes Reinecke to enable scsi
> multiqueue for the mpt3sas driver.  While the HBA only has a single
> mailbox register for submitting commands, it does have individual
> receive queues per MSI-X interrupt and as such does benefit from
> converting it to full multiqueue support.

This does not apply to 4.16/scsi-queue. Please rebase.

Also, the first patch has some out-of-tree debris in it.

-- 
Martin K. Petersen	Oracle Linux Engineering
