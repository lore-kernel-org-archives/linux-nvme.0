From: hch@lst.de (Christoph Hellwig)
Date: Mon, 22 Jan 2018 16:23:01 +0100
Subject: [PATCH v4 1/2] nvme: add tracepoint for nvme_setup_cmd
In-Reply-To: <20180119141819.11938-2-jthumshirn@suse.de>
References: <20180119141819.11938-1-jthumshirn@suse.de>
 <20180119141819.11938-2-jthumshirn@suse.de>
Message-ID: <20180122152301.GA5818@lst.de>

On Fri, Jan 19, 2018@03:18:18PM +0100, Johannes Thumshirn wrote:
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> Reviewed-by: Hannes Reinecke <hare at suse.de>
> Reviewed-by: Martin K. Petersen <martin.petersen at oracle.com>
> Reviewed-by: Keith Busch <keith.busch at intel.com>

This could really use a changelog explaining what you're tracing,
and most importantly why.

> +struct rw_cmd {
> +	__le64 slba;
> +	__le16 length;
> +	__le16 control;
> +	__le32 dsmgmt;
> +	__le32 reftag;
> +	__le16 apptag;
> +	__le16 appmask;
> +};
> +
> +struct dsm_cmd {
> +	__le32 nr;
> +	__le32 attributes;
> +	__u32 rsvd12[4];
> +};

Why do we need all these different defintions?  Just use
cdw2/3/10/11/12/13 for the fields and decode those __le32 on
a per-command basis where needed.

> +const char *nvme_trace_parse_cmd(struct trace_seq *p, bool admin,
> +				 u8 opcode, __le32 *cdw10)
> +{
> +	if (admin) {
> +		switch (opcode) {
> +		case nvme_admin_create_sq:
> +			return nvme_trace_create_sq(p, cdw10);
> +		case nvme_admin_create_cq:
> +			return nvme_trace_create_cq(p, cdw10);
> +		case nvme_admin_identify:
> +			return nvme_trace_admin_identify(p, cdw10);
> +		default:
> +			return nvme_trace_common(p, cdw10);
> +		}
> +	} else {
> +		switch (opcode) {
> +		case nvme_cmd_read:
> +		case nvme_cmd_write:
> +		case nvme_cmd_write_zeroes:
> +			return nvme_trace_read_write(p, cdw10);
> +		case nvme_cmd_dsm:
> +			return nvme_trace_dsm(p, cdw10);
> +		default:
> +			return nvme_trace_common(p, cdw10);
> +		}
> +	}
> +}

Wouldn't it be easier to have separate tracepoints for admin vs
I/O commands?  Especially as people might often want to trace
only one or the other.
