From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Mon, 08 May 2017 21:26:11 -0400
Subject: [PATCH v3] lpfc: Fix panic on BFS configuration.
In-Reply-To: <20170427220826.12693-1-jsmart2021@gmail.com> (jsmart's message
 of "Thu, 27 Apr 2017 15:08:26 -0700")
References: <20170427220826.12693-1-jsmart2021@gmail.com>
Message-ID: <yq1h90uu8gc.fsf@oracle.com>


James,

> Fix is to reset the sli-3 function before sending the mailbox command,
> thus synchronizing the function/driver on mailbox location.

Applied to 4.12/scsi-fixes.

-- 
Martin K. Petersen	Oracle Linux Engineering
