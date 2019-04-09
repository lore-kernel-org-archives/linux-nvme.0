From: kbusch@kernel.org (Keith Busch)
Date: Tue, 9 Apr 2019 08:55:17 -0600
Subject: [PATCHv2] nvmet: Fix discover log page when offsets are used
In-Reply-To: <20190409095401.GD6827@lst.de>
References: <20190408194652.641-1-keith.busch@intel.com>
 <20190409095401.GD6827@lst.de>
Message-ID: <20190409145517.GB1005@localhost.localdomain>

On Tue, Apr 09, 2019@02:54:01AM -0700, Christoph Hellwig wrote:
> > +u64 nvmet_get_log_page_offset(struct nvme_command *cmd)
> > +{
> > +	u64 offset = le32_to_cpu(cmd->get_log_page.lpou);
> > +
> > +	offset <<= 32;
> > +	offset += le32_to_cpu(cmd->get_log_page.lpol);
> > +
> > +	return offset;
> 
> Maybe just a pet peeve of fine, but can we avoid the pointless local
> variable?  Why not:
> 
> 	return le32_to_cpu(cmd->get_log_page.lpol) |
> 		(((u64)le32_to_cpu(cmd->get_log_page.lpou)) << 32);

Sure thing.
 
> That being said I don't get why we don't simply replace lpol and lpou
> with a single __le64 to start with to simplify things further.

It is on a natrual 8 byte alignment, so I guess we could make it an
__le64. The split just aligns to the spec.
