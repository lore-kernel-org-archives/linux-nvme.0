From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 01 Nov 2016 12:11:42 -0400
Subject: [PATCH v5 11/14] SRP transport: Move queuecommand() wait code to
 SCSI core
In-Reply-To: <b447e9bc-7e29-d058-76ad-89ba2a7bf729@sandisk.com> (Bart Van
 Assche's message of "Fri, 28 Oct 2016 17:22:37 -0700")
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
 <b447e9bc-7e29-d058-76ad-89ba2a7bf729@sandisk.com>
Message-ID: <yq1h97r18ox.fsf@sermon.lab.mkp.net>

>>>>> "Bart" == Bart Van Assche <bart.vanassche at sandisk.com> writes:

Bart> Additionally, rename srp_wait_for_queuecommand() into
Bart> scsi_wait_for_queuecommand() and add a comment about the
Bart> queuecommand() call from scsi_send_eh_cmnd().

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
