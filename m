From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Jun 2017 10:53:51 +0200
Subject: [PATCH 2/6] nvme: read the subsystem NQN from Identify Controller
In-Reply-To: <560367a8-34c8-7cda-c6b4-b5b59569590d@suse.de>
References: <20170615163502.10548-1-hch@lst.de>
 <20170615163502.10548-3-hch@lst.de>
 <560367a8-34c8-7cda-c6b4-b5b59569590d@suse.de>
Message-ID: <20170616085351.GA11261@lst.de>

On Fri, Jun 16, 2017@10:42:34AM +0200, Johannes Thumshirn wrote:
> On 06/15/2017 06:34 PM, Christoph Hellwig wrote:
> > +	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
> > +	snprintf(ctrl->subnqn, NVMF_NQN_SIZE,
> > +		"nqn.2014.08.org.nvmexpress:%4x%4x",
> > +		le16_to_cpu(id->vid), le16_to_cpu(id->ssvid));
> > +	memcpy(ctrl->subnqn + 35, id->sn, sizeof(id->sn));
> > +	memcpy(ctrl->subnqn + 55, id->mn, sizeof(id->mn));
> > +	memset(ctrl->subnqn + 95, 0, sizeof(ctrl->subnqn) - 95);
> 
> Is there a chance we can do this with a bit less magic values? We can
> calculate all of the offsets.
> 
> Something like:
> 
> off = snprintf(ctrl->subnqn, NVMF_NQN_SIZE,
> 	"nqn.2014.08.org.nvmexpress:%4x%4x",
> 	le16_to_cpu(id->vid), le16_to_cpu(id->ssvid));
> memcpy(ctrl->subnqn + off, id->sn, sizeof(id->sn));
> off += sizeof(id->sn);
> memcpy(ctrl->subnqn + off, id->mn, sizeof(id->mn));
> off += sizeof(id->mn);
> memset(ctrl->subnqn + off, 0, sizeof(ctrl->subnqn) - off);

Not really much more readable, but if there is a preference for this
version I can do it.
