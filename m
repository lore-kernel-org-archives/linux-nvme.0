From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 17 May 2017 20:23:31 -0400
Subject: [PATCH] lpfc: fix build issue if NVME_FC_TARGET is not defined
In-Reply-To: <20170517035229.1145-1-jsmart2021@gmail.com> (James Smart's
 message of "Tue, 16 May 2017 20:52:29 -0700")
References: <20170517035229.1145-1-jsmart2021@gmail.com>
Message-ID: <yq1tw4j6mik.fsf@oracle.com>


James,

> fix build issue if NVME_FC_TARGET is not defined. noop the code.
> The code will never be invoked if target mode is not enabled.

Applied to 4.12/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
