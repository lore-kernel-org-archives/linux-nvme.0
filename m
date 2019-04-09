From: bvanassche@acm.org (Bart Van Assche)
Date: Tue, 09 Apr 2019 08:19:30 -0700
Subject: [PATCHv2] nvmet: Fix discover log page when offsets are used
In-Reply-To: <20190409145517.GB1005@localhost.localdomain>
References: <20190408194652.641-1-keith.busch@intel.com>
 <20190409095401.GD6827@lst.de>
 <20190409145517.GB1005@localhost.localdomain>
Message-ID: <1554823170.161891.8.camel@acm.org>

On Tue, 2019-04-09@08:55 -0600, Keith Busch wrote:
> On Tue, Apr 09, 2019@02:54:01AM -0700, Christoph Hellwig wrote:
> > > +u64 nvmet_get_log_page_offset(struct nvme_command *cmd)
> > > +{
> > > +	u64 offset = le32_to_cpu(cmd->get_log_page.lpou);
> > > +
> > > +	offset <<= 32;
> > > +	offset += le32_to_cpu(cmd->get_log_page.lpol);
> > > +
> > > +	return offset;
> > 
> > Maybe just a pet peeve of fine, but can we avoid the pointless local
> > variable?  Why not:
> > 
> > 	return le32_to_cpu(cmd->get_log_page.lpol) |
> > 		(((u64)le32_to_cpu(cmd->get_log_page.lpou)) << 32);
> 
> Sure thing.
>  
> > That being said I don't get why we don't simply replace lpol and lpou
> > with a single __le64 to start with to simplify things further.
> 
> It is on a natrual 8 byte alignment, so I guess we could make it an
> __le64. The split just aligns to the spec.

How about introducing a union such that the names from the spec can be
retained and at the same time nvmet_get_log_page_offset() can read a
single __le64 variable?

Bart.
