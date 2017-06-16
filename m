From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri, 16 Jun 2017 10:42:34 +0200
Subject: [PATCH 2/6] nvme: read the subsystem NQN from Identify Controller
In-Reply-To: <20170615163502.10548-3-hch@lst.de>
References: <20170615163502.10548-1-hch@lst.de>
 <20170615163502.10548-3-hch@lst.de>
Message-ID: <560367a8-34c8-7cda-c6b4-b5b59569590d@suse.de>

On 06/15/2017 06:34 PM, Christoph Hellwig wrote:
> +	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
> +	snprintf(ctrl->subnqn, NVMF_NQN_SIZE,
> +		"nqn.2014.08.org.nvmexpress:%4x%4x",
> +		le16_to_cpu(id->vid), le16_to_cpu(id->ssvid));
> +	memcpy(ctrl->subnqn + 35, id->sn, sizeof(id->sn));
> +	memcpy(ctrl->subnqn + 55, id->mn, sizeof(id->mn));
> +	memset(ctrl->subnqn + 95, 0, sizeof(ctrl->subnqn) - 95);

Is there a chance we can do this with a bit less magic values? We can
calculate all of the offsets.

Something like:

off = snprintf(ctrl->subnqn, NVMF_NQN_SIZE,
	"nqn.2014.08.org.nvmexpress:%4x%4x",
	le16_to_cpu(id->vid), le16_to_cpu(id->ssvid));
memcpy(ctrl->subnqn + off, id->sn, sizeof(id->sn));
off += sizeof(id->sn);
memcpy(ctrl->subnqn + off, id->mn, sizeof(id->mn));
off += sizeof(id->mn);
memset(ctrl->subnqn + off, 0, sizeof(ctrl->subnqn) - off);

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
