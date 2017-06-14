From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Wed, 14 Jun 2017 12:10:42 -0400
Subject: [PATCH nvme-4.13] nvme/pci: Use saved CSTS value
In-Reply-To: <1497456838-11593-1-git-send-email-keith.busch@intel.com> (Keith
 Busch's message of "Wed, 14 Jun 2017 12:13:58 -0400")
References: <1497456838-11593-1-git-send-email-keith.busch@intel.com>
Message-ID: <yq1o9tqturh.fsf@oracle.com>


Keith,

> Don't re-read controller status when checking controller health on an
> IO timeout.

Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
