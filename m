From: shiraz.saleem@intel.com (Saleem, Shiraz)
Date: Mon, 29 Oct 2018 23:58:31 +0000
Subject: [PATCH v2] block: fix rdma queue mapping
In-Reply-To: <60315f82-ebc1-838d-4757-c27b9bb650ff@grimberg.me>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180822131130.GC28149@lst.de>
 <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me>
 <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com>
 <20181017163720.GA23798@lst.de>
 <c850626a-5891-fa34-e647-c815f67099da@grimberg.me>
 <00dd01d46ad0$6eb82250$4c2866f0$@opengridcomputing.com>
 <ab0370aa-c488-bfed-675a-b0f84d75a42a@grimberg.me>
 <20181024000923.GA17352@ssaleem-MOBL4.amr.corp.intel.com>
 <60315f82-ebc1-838d-4757-c27b9bb650ff@grimberg.me>
Message-ID: <9DD61F30A802C4429A01CA4200E302A7A2FFFC0B@fmsmsx116.amr.corp.intel.com>

>Subject: Re: [PATCH v2] block: fix rdma queue mapping
>
>
>> Sagi - From what I can tell, i40iw is also exposed to this same issue
>> if the IRQ affinity is configured by user.
>
>managed affinity does not allow setting smp_affinity from userspace.

OK. But our device IRQs are not set-up as to be managed affinity based and can be tuned by user.
And it seems that is reasonable approach since we can never tell ahead of time what might be an optimal config. for a particular workload.

Shiraz
