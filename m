From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Mon, 08 Jan 2018 22:09:03 -0500
Subject: [Resend PATCH 00/11] mpt3sas: Enable scsi MQ & lockless command
 submission
In-Reply-To: <1515070631-14740-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 (Suganath Prabu S.'s message of "Thu, 4 Jan 2018 04:57:00 -0800")
References: <1515070631-14740-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <yq1k1wrohio.fsf@oracle.com>


Suganath,

> This patch set is initially posted by Hannes Reinecke to enable scsi
> multiqueue for the mpt3sas driver.  While the HBA only has a single
> mailbox register for submitting commands, it does have individual
> receive queues per MSI-X interrupt and as such does benefit from
> converting it to full multiqueue support.

Applied to 4.16/scsi-queue. Thank you!

-- 
Martin K. Petersen	Oracle Linux Engineering
