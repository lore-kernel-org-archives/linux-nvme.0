From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Jun 2018 09:38:59 +0200
Subject: [PATCH 06/10] nvme: add ANA support
In-Reply-To: <20180612104544.4fd45421@pentland.suse.de>
References: <20180611141139.30462-1-hch@lst.de>
 <20180611141139.30462-7-hch@lst.de>
 <20180612104544.4fd45421@pentland.suse.de>
Message-ID: <20180613073859.GA22633@lst.de>

On Tue, Jun 12, 2018@10:45:44AM +0200, Hannes Reinecke wrote:
> > +			le32_to_cpu(desc->grpid),
> > +			nvme_ana_state_names[desc->state]);
> > +
> > +	if (!nr_nsids)
> > +		return 0;
> > +
> This will cause any 'change' state during runtime never to be evaluated
> as we're setting the RGO bit, and consequently 'nnsids' is zero:

During runtime RGO should not be set, but during initialization we
do set it indeed.  So I've moved the check up to fix this.
