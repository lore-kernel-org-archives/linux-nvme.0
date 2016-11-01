From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 01 Nov 2016 12:12:07 -0400
Subject: [PATCH v5 12/14] SRP transport,
 scsi-mq: Wait for .queue_rq() if necessary
In-Reply-To: <32accadb-3ed3-cd5d-e92f-655f8f3cb9bc@sandisk.com> (Bart Van
 Assche's message of "Fri, 28 Oct 2016 17:23:00 -0700")
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
 <32accadb-3ed3-cd5d-e92f-655f8f3cb9bc@sandisk.com>
Message-ID: <yq1d1if18o8.fsf@sermon.lab.mkp.net>

>>>>> "Bart" == Bart Van Assche <bart.vanassche at sandisk.com> writes:

Bart> Ensure that if scsi-mq is enabled that
Bart> scsi_internal_device_block() waits until ongoing
Bart> shost->hostt->queuecommand() calls have finished.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
