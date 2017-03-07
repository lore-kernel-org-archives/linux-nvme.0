From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Mon, 06 Mar 2017 22:35:00 -0500
Subject: [PATCH v3 01/16] lpfc: Correct WQ creation for pagesize
In-Reply-To: <6a197069-2f10-6df1-4cf1-1a62808c8903@linux.vnet.ibm.com>
 (Mauricio Faria de Oliveira's message of "Fri, 3 Mar 2017 22:43:16
 -0300")
References: <58a0d919.08BhoypOnvRSLIqV%jsmart2021@gmail.com>
 <6a197069-2f10-6df1-4cf1-1a62808c8903@linux.vnet.ibm.com>
Message-ID: <yq1tw75kbdn.fsf@oracle.com>

>>>>> "Mauricio" == Mauricio Faria de Oliveira <mauricfo at linux.vnet.ibm.com> writes:

Mauricio,

Mauricio> Please flag this patch for stable.

Mauricio> This patch resolves a serious problem on IBM Power systems at
Mauricio> least.

Both patches are already upstream so I can't tag them for stable. Either
you or James should mail stable at vger.kernel.org and request for the
patches to be queued up.

-- 
Martin K. Petersen	Oracle Linux Engineering
