From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 28 Jun 2019 16:20:49 -0400
Subject: [PATCH v5 2/3] nvmet: Export NVMe namespace attributes
In-Reply-To: <20190628165331.163919-3-bvanassche@acm.org> (Bart Van Assche's
 message of "Fri, 28 Jun 2019 09:53:30 -0700")
References: <20190628165331.163919-1-bvanassche@acm.org>
 <20190628165331.163919-3-bvanassche@acm.org>
Message-ID: <yq1lfxlh36m.fsf@oracle.com>


Bart,

> Make the NVMe NAWUN, NAWUPF, NACWU, NPWG, NPWA, NPDG and NOWS
> attributes available to initator systems for the block backend.

I'm OK with not opening the can of worms that is file backing.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
