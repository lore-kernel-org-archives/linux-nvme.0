From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 3 Jun 2018 16:17:52 +0300
Subject: [PATCH v2] nvmet: return all zeroed buffer when we can't find an
 active namespace
In-Reply-To: <20180531162348.GA30786@lst.de>
References: <20180530164525.26749-1-hch@lst.de> <20180531162348.GA30786@lst.de>
Message-ID: <8b2300dd-53e8-7dc5-8926-adc18e8594a2@mellanox.com>



On 5/31/2018 7:23 PM, Christoph Hellwig wrote:
> Quote from Figure 106 in NVMe 1.3a:
> 
>    The Identify Namespace data structure is returned to the host for the
>    namespace specified in the Namespace Identifier (CDW1.NSID) field if it
>    is an active NSID. If the specified namespace is not an active NSID,
>    then the controller returns a zero filled data structure.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
> 
> Changes since v1:
>   - remove a leftover debug printk
>   - fix whitespace damage
> 
>   drivers/nvme/target/admin-cmd.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
> 


Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
