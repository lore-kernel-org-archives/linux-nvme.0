From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Thu, 27 Jul 2017 09:26:32 -0400
Subject: [PATCH v2 03/13] mpt3sas: SGL to PRP Translation for I/Os to NVMe
 devices
In-Reply-To: <1500038560-11231-4-git-send-email-suganath-prabu.subramani@broadcom.com>
 (Suganath Prabu S.'s message of "Fri, 14 Jul 2017 18:52:30 +0530")
References: <1500038560-11231-1-git-send-email-suganath-prabu.subramani@broadcom.com>
 <1500038560-11231-4-git-send-email-suganath-prabu.subramani@broadcom.com>
Message-ID: <yq1a83qvwmv.fsf@oracle.com>


Suganath,

> * Added support for translating the SGLs associated with incoming
> commands either to IEE SGL or NVMe PRPs for NVMe devices.

This all seems very convoluted. You should rely on the block layer
infrastructure instead of doing all this slicing and dicing by hand.

If the attached device is an NVMe drive, call blk_queue_virt_boundary()
and you will only receive requests that are suitable for a device with
PRP-style scatterlist constraints.

-- 
Martin K. Petersen	Oracle Linux Engineering
