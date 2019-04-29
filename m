From: minwoo.im@samsung.com (Minwoo Im)
Date: Tue, 30 Apr 2019 08:32:29 +0900
Subject: [PATCH 2/2] nvme: add clarifying comments and fix some typos
In-Reply-To: <20190429173533.10366-3-ednadols@linux.microsoft.com>
References: <20190429173533.10366-3-ednadols@linux.microsoft.com>
 <20190429173533.10366-1-ednadols@linux.microsoft.com>
 <CGME20190429173604epcas3p2e65d79c87ba36e384e6c42a1b1744eae@epcms2p4>
Message-ID: <20190429233229epcms2p4b40c9013b34c79be70726af1d1877f5c@epcms2p4>

> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On
> Behalf Of Edmund Nadolski
> Sent: Tuesday, April 30, 2019 2:36 AM
> To: linux-nvme at lists.infradead.org; ednadols at linux.microsoft.com
> Subject: [PATCH 2/2] nvme: add clarifying comments and fix some typos
> 
> Add comment descriptions for struct fields per NVMe spec.
> 
> Signed-off-by: Edmund Nadolski <ednadols at linux.microsoft.com>

IMHO, if you really want to provide description for structure attributes,
why don't we have all of them instead describing few fields only.

Also It would be better if typo-related commit is separted from it.

Thanks,
