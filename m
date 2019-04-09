From: hch@lst.de (Christoph Hellwig)
Date: Tue, 9 Apr 2019 11:50:07 +0200
Subject: [PATCHv2] nvmet: Fix discover log page when offsets are used
In-Reply-To: <SN6PR04MB45279B323BEE059E7FE46BD1862D0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190408194652.641-1-keith.busch@intel.com>
 <SN6PR04MB45279B323BEE059E7FE46BD1862D0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <20190409095007.GC6827@lst.de>

On Tue, Apr 09, 2019@02:33:04AM +0000, Chaitanya Kulkarni wrote:
> > +u64 nvmet_get_log_page_offset(struct nvme_command *cmd)
> > +{
> > +	u64 offset = le32_to_cpu(cmd->get_log_page.lpou);
> > +
> > +	offset <<= 32;
> > +	offset += le32_to_cpu(cmd->get_log_page.lpol);
> > +
> > +	return offset;
> > +}
> > +
> Can we please mark above function inline ?

Log pages are pretty much in the slow path, so despite the
triviality I don't really see a reason to inline it.
