From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 19 Jun 2019 00:17:26 -0400
Subject: [PATCH v3 3/3] nvme: Set physical block size and optimal I/O size
 according to NVMe 1.4
In-Reply-To: <20190617161222.253849-4-bvanassche@acm.org> (Bart Van Assche's
 message of "Mon, 17 Jun 2019 09:12:22 -0700")
References: <20190617161222.253849-1-bvanassche@acm.org>
 <20190617161222.253849-4-bvanassche@acm.org>
Message-ID: <yq15zp2us2x.fsf@oracle.com>


Bart,

> NSFEAT bit 4 if set to 1: indicates that the fields NPWG, NPWA, NPDG, NPDA,
> and NOWS are defined for this namespace and should be used by the host for
> I/O optimization;

LGTM.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
