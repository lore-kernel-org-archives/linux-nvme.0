From: hare@suse.de (Hannes Reinecke)
Date: Wed, 30 May 2018 11:51:06 +0200
Subject: [PATCH] nvme-fabrics: allow internal passthrough command on
 deleting controllers
In-Reply-To: <20180530061116.23610-1-hch@lst.de>
References: <20180530061116.23610-1-hch@lst.de>
Message-ID: <20180530115106.1ad71844@pentland.suse.de>

On Wed, 30 May 2018 08:11:16 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Without this we can't cleanly shut down.
> 
> Based on analysis an an earlier patch from Hannes Reinecke.
> 
> Fixes: bb06ec31452f ("nvme: expand nvmf_check_if_ready checks")
> Reported-by: Hannes Reinecke <hare at suse.de>
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reviewed-by: James Smart <james.smart at broadcom.com>
> ---
> 
> Note: Pending full testing on FC by James..
> 
> 

Fixes the problem with RDMA shutdown on my rig.

Tested-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
