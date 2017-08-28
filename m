From: gpiccoli@linux.vnet.ibm.com (Guilherme G. Piccoli)
Date: Mon, 28 Aug 2017 14:52:14 -0300
Subject: [PATCH] nvme-fabrics: Allow 0 as KATO value
In-Reply-To: <29c5954d-eda6-4a6f-1e50-95399c32a917@grimberg.me>
References: <20170828141032.800-1-gpiccoli@linux.vnet.ibm.com>
 <29c5954d-eda6-4a6f-1e50-95399c32a917@grimberg.me>
Message-ID: <375bb4d7-71e0-c516-7eb9-19bbb440a5b4@linux.vnet.ibm.com>

On 08/28/2017 01:41 PM, Sagi Grimberg wrote:
> 
> [...] 
> How about simply setting opts->kato = NVME_DEFAULT_KATO as a default
> at the beginning and remove this condition instead..
> 

Good for me, I can send a v2.
Thanks Sagi.
Cheers,


Guilherme
