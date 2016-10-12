From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Wed, 12 Oct 2016 10:53:37 -0700
Subject: [PATCH 0/2 v2] nvme-fabrics: infrastructure changes for fc
 protocol support
In-Reply-To: <57e93b70.oopX7Rt0+86+HCU9%james.smart@broadcom.com>
References: <57e93b70.oopX7Rt0+86+HCU9%james.smart@broadcom.com>
Message-ID: <1476294817.5410.76.camel@linux.intel.com>

On Mon, 2016-09-26@08:14 -0700, James Smart wrote:
> This patch set completes the patches to the fabrics layer for
> FC protocol support.
> 
> Thanks Sagi, for pulling 3 of the prior patches in.
> 
> The first patch, patching target code, is unchanged from its prior
> posting, which was reviewed and accepted.
> 
> The second patch, fixing sqe.command_id, is a repost of a prior patch
> revised per review to fix pci.c and loop.c as well.
> 

Series looks good,

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
