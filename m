From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Tue, 12 Feb 2019 22:10:44 -0500
Subject: [PATCH] scsi: lpfc: fix calls to dma_set_mask_and_coherent()
In-Reply-To: <9572ae3b0131ad1c74d6a775f819437e3d4f1795.camel@redhat.com> (Ewan
 D. Milne's message of "Tue, 12 Feb 2019 10:37:45 -0500")
References: <20190211150502.9999-1-emilne@redhat.com>
 <20190212080627.GC10547@infradead.org>
 <9572ae3b0131ad1c74d6a775f819437e3d4f1795.camel@redhat.com>
Message-ID: <yq1y36ks7rf.fsf@oracle.com>


Ewan,

> It also appears as if the patches to hptiop, hisi_sas and bfa need to
> be fixed up.  I don't have a test environment for these, although I
> might be able to modify the test environment for bfa.  Martin/James,
> what about the others?

I'm afraid I don't have any of those. But I'm sure John would be happy
to check hisi_sas.

-- 
Martin K. Petersen	Oracle Linux Engineering
