From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 22 Jan 2019 20:43:33 -0500
Subject: [PATCH 0/2] Fix use-after-free errors in lpfc driver when using
 NVMe
In-Reply-To: <20190117161445.25671-1-emilne@redhat.com> (Ewan D. Milne's
 message of "Thu, 17 Jan 2019 11:14:43 -0500")
References: <20190117161445.25671-1-emilne@redhat.com>
Message-ID: <yq11s54no6y.fsf@oracle.com>


Ewan,

> These two patches fix use-after-free errors in the shutdown path of
> the lpfc driver with both the Initiator and Target mode usage of FC
> ports.
>
> The problem is very apparent with slub_debug enabled, as the memory
> poisoning prevents the wait_for_completion_timeout() from returning
> after the object has been freed.

Applied to 5.0/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
