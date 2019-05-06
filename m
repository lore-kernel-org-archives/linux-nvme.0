From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 6 May 2019 22:38:04 +0000
Subject: [PATCH V2 2/2] nvme-trace: Add support to trace fabrics command
References: <20190506194644.11109-1-minwoo.im.dev@gmail.com>
 <20190506194644.11109-3-minwoo.im.dev@gmail.com>
Message-ID: <SN6PR04MB4527A10184AEF3DDCC23CB0886300@SN6PR04MB4527.namprd04.prod.outlook.com>

This look okay me with some minor comments, but it does not cover the 
target side tracing. In fact on the target side we have many components
such as discovery/multipath/port/async events etc.

On 05/06/2019 12:47 PM, Minwoo Im wrote:
> This patch supports fabrics command decoded in trace.  Fabrics commands
> are to be decoded with (opcode, fctype) pair.
>
> Now the core driver traces command in a single place of a single place
> nvme_setup_cmd() so that it might be easier if we checks whether the
> given command is for fabrics or not in that place.
>
> NVMe-oF spec 1.0a contains authentication-related commands also, but now
> we don't have any implementation for them so that we can just skip them
> in this patch.
>
> Changes to V1:
>    - fabrics commands should also be decoded, not just showing that it's
>      a fabrics command. (Christoph)
>    - do not make it within nvme admin commands (Chaitanya)
>
> Cc: Keith Busch <keith.busch at intel.com>
> Cc: Jens Axboe <axboe at fb.com>
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   drivers/nvme/host/core.c  |  7 +++-
>   drivers/nvme/host/trace.c | 67 +++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/trace.h | 37 +++++++++++++++++++++
>   3 files changed, 110 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index cd16d98d1f1a..eeda3ce9afaa 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -733,7 +733,12 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>   	}
>
>   	cmd->common.command_id = req->tag;
> -	trace_nvme_setup_cmd(req, cmd);
> +
> +	if (likely(!nvme_is_fabrics(cmd)))
Do we really need likely here ? Isn't this branch should be guarded by 
trace config ? what if trace is not configured ?
> +		trace_nvme_setup_cmd(req, cmd);
> +	else
> +		trace_nvme_setup_fabrics_cmd(req, cmd);
> +
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(nvme_setup_cmd);
> diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
> index 5f24ea7a28eb..0e027a49e3a1 100644
> --- a/drivers/nvme/host/trace.c
> +++ b/drivers/nvme/host/trace.c
> @@ -135,6 +135,73 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
>   	}
>   }
>
> +static const char *nvme_trace_fabrics_property_set(struct trace_seq *p, u8 *spc)
> +{
> +	const char *ret = trace_seq_buffer_ptr(p);
> +	u8 attrib = spc[0];
> +	u32 ofst = get_unaligned_le32(spc + 4);
please use name "offset" here.
> +	u64 value = get_unaligned_le64(spc + 8);
> +
> +	trace_seq_printf(p, "attrib=%u, ofst=0x%x, value=0x%llx",
> +				attrib, ofst, value);
> +	trace_seq_putc(p, 0);
> +
> +	return ret;
> +}
> +
> +static const char *nvme_trace_fabrics_connect(struct trace_seq *p, u8 *spc)
> +{
> +	const char *ret = trace_seq_buffer_ptr(p);
> +	u16 recfmt = get_unaligned_le16(spc);
> +	u16 qid = get_unaligned_le16(spc + 2);
> +	u16 sqsize = get_unaligned_le16(spc + 4);
> +	u8 cattr = spc[6];
> +	u32 kato = get_unaligned_le32(spc + 8);
> +
> +	trace_seq_printf(p, "recfmt=%u, qid=%u, sqsize=%u, cattr=%u, kato=%u",
> +				recfmt, qid, sqsize, cattr, kato);
> +	trace_seq_putc(p, 0);
> +
> +	return ret;
> +}
> +
> +static const char *nvme_trace_fabrics_property_get(struct trace_seq *p, u8 *spc)
> +{
> +	const char *ret = trace_seq_buffer_ptr(p);
> +	u8 attrib = spc[0];
> +	u32 ofst = get_unaligned_le32(spc + 4);
Same here offset.
> +
> +	trace_seq_printf(p, "attrib=%u, ofst=0x%x", attrib, ofst);
> +	trace_seq_putc(p, 0);
> +
> +	return ret;
> +}
> +
> +static const char *nvme_trace_fabrics_common(struct trace_seq *p, u8 *spc)
> +{
> +	const char *ret = trace_seq_buffer_ptr(p);
> +
> +	trace_seq_printf(p, "spcecific=%*ph", 24, spc);
Please avoid magic numbers "24", see following comment.
> +	trace_seq_putc(p, 0);
> +
> +	return ret;
> +}
> +
> +const char *nvme_trace_parse_fabrics_cmd(struct trace_seq *p,
> +					 u8 fctype, u8 *spc)
> +{
> +	switch (fctype) {
> +	case nvme_fabrics_type_property_set:
> +		return nvme_trace_fabrics_property_set(p, spc);
> +	case nvme_fabrics_type_connect:
> +		return nvme_trace_fabrics_connect(p, spc);
> +	case nvme_fabrics_type_property_get:
> +		return nvme_trace_fabrics_property_get(p, spc);
> +	default:
> +		return nvme_trace_fabrics_common(p, spc);
> +	}
> +}
> +
>   const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
>   {
>   	const char *ret = trace_seq_buffer_ptr(p);
> diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
> index 97d3c77365b8..fa3a20007b56 100644
> --- a/drivers/nvme/host/trace.h
> +++ b/drivers/nvme/host/trace.h
> @@ -57,8 +57,17 @@
>   		nvme_opcode_name(nvme_cmd_resv_acquire),	\
>   		nvme_opcode_name(nvme_cmd_resv_release))
>
> +#define nvme_fabrics_type_name(type)	{ type, #type }
> +#define show_nvm_fabrics_type_name(val)					\
> +	__print_symbolic(val,						\
> +		nvme_fabrics_type_name(nvme_fabrics_type_property_set),	\
> +		nvme_fabrics_type_name(nvme_fabrics_type_connect),	\
> +		nvme_fabrics_type_name(nvme_fabrics_type_property_get))
> +
>   #define show_opcode_name(qid, opcode)					\
>   	(qid ? show_nvm_opcode_name(opcode) : show_admin_opcode_name(opcode))
> +#define show_fabric_type_name(type)					\
> +	show_nvm_fabrics_type_name(type)
>
>   const char *nvme_trace_parse_admin_cmd(struct trace_seq *p, u8 opcode,
>   		u8 *cdw10);
> @@ -70,6 +79,12 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p, u8 opcode,
>   	 nvme_trace_parse_nvm_cmd(p, opcode, cdw10) : 		\
>   	 nvme_trace_parse_admin_cmd(p, opcode, cdw10))
>
> +const char *nvme_trace_parse_fabrics_cmd(struct trace_seq *p,
> +		u8 fctype, u8 *spc);
> +
> +#define parse_nvmf_cmd(fctype, spc)				\
> +	nvme_trace_parse_fabrics_cmd(p, fctype, spc)
> +
>   const char *nvme_trace_disk_name(struct trace_seq *p, char *name);
>   #define __print_disk_name(name)				\
>   	nvme_trace_disk_name(p, name)
> @@ -118,6 +133,28 @@ TRACE_EVENT(nvme_setup_cmd,
>   		      parse_nvme_cmd(__entry->qid, __entry->opcode, __entry->cdw10))
>   );
>
> +TRACE_EVENT(nvme_setup_fabrics_cmd,
> +	    TP_PROTO(struct request *req, struct nvme_command *cmd),
> +	    TP_ARGS(req, cmd),
> +	    TP_STRUCT__entry(
> +		__field(int, ctrl_id)
> +		__field(u16, cid)
> +		__field(u8, fctype)
> +		__array(u8, spc, 24)
Can you please just declare a macro and replace 24 ? (I think we need to 
replace in the nvme_setup_cmd() also, please double check.
> +	    ),
> +	    TP_fast_assign(
> +		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
> +		__entry->cid = cmd->fabrics.command_id;
> +		__entry->fctype = cmd->fabrics.fctype;
> +		memcpy(__entry->spc, &cmd->fabrics.ts,
> +			sizeof(__entry->spc));
> +	    ),
> +	    TP_printk("nvme%d: cmdid=%u, cmd=(%s %s)",
Do we need to differentiate between fabrics and local NVMe ctrl when
reporting ?
> +		      __entry->ctrl_id, __entry->cid,
> +		      show_fabric_type_name(__entry->fctype),
> +		      parse_nvmf_cmd(__entry->fctype, __entry->spc))
> +);
> +
>   TRACE_EVENT(nvme_complete_rq,
>   	    TP_PROTO(struct request *req),
>   	    TP_ARGS(req),
>
