From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 4 Jun 2017 18:17:10 +0300
Subject: [PATCH 4/8] genirq/affinity: assign vectors to all present CPUs
In-Reply-To: <20170603140403.27379-5-hch@lst.de>
References: <20170603140403.27379-1-hch@lst.de>
 <20170603140403.27379-5-hch@lst.de>
Message-ID: <5a48e208-9279-9db9-2465-dfdb8d0319e5@grimberg.me>



On 03/06/17 17:03, Christoph Hellwig wrote:
> Currently we only assign spread vectors to online CPUs, which ties the
> IRQ mapping to the currently online devices and doesn't deal nicely with
> the fact that CPUs could come and go rapidly due to e.g. power management.
> 
> Instead assign vectors to all present CPUs to avoid this churn.
> 
> For this we have to build a map of all possible CPUs for a give node, as

s/give/given/

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
