From: hch@lst.de (Christoph Hellwig)
Date: Fri, 25 May 2018 15:24:37 +0200
Subject: [PATCHv2 07/11] nvme: always failover on path or transport errors
In-Reply-To: <20180522091004.39620-8-hare@suse.de>
References: <20180522091004.39620-1-hare@suse.de>
 <20180522091004.39620-8-hare@suse.de>
Message-ID: <20180525132437.GA24601@lst.de>

On Tue, May 22, 2018@11:10:00AM +0200, Hannes Reinecke wrote:
>  	if (!(req->cmd_flags & REQ_NVME_MPATH))
>  		return false;
> +	if (nvme_req(req)->status & 0x300)
> +		return true;

As I love to correct everyone including myself:
This actually needs to be

	if ((nvme_req(req)->status & 0x700) == 0x300)

to accomodate for future new SCT values.
