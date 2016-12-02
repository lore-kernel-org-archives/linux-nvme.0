From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 2 Dec 2016 10:16:53 +0100
Subject: [PATCH v6 7/7] nvme-fabrics: Add FC LLDD loopback driver to test
 FC-NVME
In-Reply-To: <584130bc.jhaGKcwLa/ND+sLZ%jsmart2021@gmail.com>
References: <584130bc.jhaGKcwLa/ND+sLZ%jsmart2021@gmail.com>
Message-ID: <20161202091653.njg3tn24pla3nug5@linux-x5ow.site>

On Fri, Dec 02, 2016@12:28:44AM -0800, James Smart wrote:
> 
> Add FC LLDD loopback driver to test FC host and target transport within
> nvme-fabrics
> 
> To aid in the development and testing of the lower-level api of the FC
> transport, this loopback driver has been created to act as if it were a
> FC hba driver supporting both the host interfaces as well as the target
> interfaces with the nvme FC transport.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>

Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
