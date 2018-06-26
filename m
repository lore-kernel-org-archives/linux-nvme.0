From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 26 Jun 2018 11:54:18 -0400
Subject: [PATCH] block: Fix transfer when chuck sectors exceeds max
In-Reply-To: <20180626151458.6675-1-keith.busch@intel.com> (Keith Busch's
 message of "Tue, 26 Jun 2018 09:14:58 -0600")
References: <20180626151458.6675-1-keith.busch@intel.com>
Message-ID: <yq160255ys5.fsf@oracle.com>


Keith,

> A device may have boundary restrictions where the number of sectors
> between boundaries exceeds its max transfer size. In this case, we need
> to cap the max size to the smaller of the two limits.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
