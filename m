From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 23 Oct 2018 17:37:13 -0700
Subject: [PATCH v2] block: fix rdma queue mapping
In-Reply-To: <20181024000923.GA17352@ssaleem-MOBL4.amr.corp.intel.com>
References: <20180820205420.25908-1-sagi@grimberg.me>
 <20180822131130.GC28149@lst.de>
 <83dd169f-034b-3460-7496-ef2e6766ea55@grimberg.me>
 <33192971-7edd-a3b6-f2fa-abdcbef375de@opengridcomputing.com>
 <20181017163720.GA23798@lst.de>
 <c850626a-5891-fa34-e647-c815f67099da@grimberg.me>
 <00dd01d46ad0$6eb82250$4c2866f0$@opengridcomputing.com>
 <ab0370aa-c488-bfed-675a-b0f84d75a42a@grimberg.me>
 <20181024000923.GA17352@ssaleem-MOBL4.amr.corp.intel.com>
Message-ID: <60315f82-ebc1-838d-4757-c27b9bb650ff@grimberg.me>


> Sagi - From what I can tell, i40iw is also exposed to this same issue if the IRQ affinity
> is configured by user.

managed affinity does not allow setting smp_affinity from userspace.
