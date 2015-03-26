From: keith.busch@intel.com (Keith Busch)
Date: Thu, 26 Mar 2015 16:19:40 +0000 (UTC)
Subject: [PATCH v2 1/1] nvme: Fix PRP list calculation for non-4k system
 page size
In-Reply-To: <55142ED7.8040809@linux.vnet.ibm.com>
References: <201503242226.t2OMQpWq011660@d03av02.boulder.ibm.com>
 <alpine.LNX.2.00.1503242233530.32385@localhost.lm.intel.com>
 <55142ED7.8040809@linux.vnet.ibm.com>
Message-ID: <alpine.LNX.2.00.1503261618220.32385@localhost.lm.intel.com>

On Thu, 26 Mar 2015, Brian King wrote:
> From: Murali Iyer <mniyer at us.ibm.com>
>
> PRP list calculation is supposed to be based on device's page size.
> Systems with page size larger than device's page size cause corruption
> to the name space as well as system memory with out this fix.
> Systems like x86 might not experience this issue because it uses
> PAGE_SIZE of 4K where as powerpc uses PAGE_SIZE of 64k while NVMe device's
> page size varies depending upon the vendor.

Thanks!

Acked-by: Keith Busch <keith.busch at intel.com>

> Signed-off-by: Murali Iyer <mniyer at us.ibm.com>
> Signed-off-by: Brian King <brking at linux.vnet.ibm.com>
