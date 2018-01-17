From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 17 Jan 2018 08:46:47 +0100
Subject: [PATCH v2 1/2] nvme: add tracepoint for nvme_setup_cmd
In-Reply-To: <20180116164954.GA9812@lst.de>
References: <20180116142821.11693-1-jthumshirn@suse.de>
 <20180116142821.11693-2-jthumshirn@suse.de>
 <20180116164954.GA9812@lst.de>
Message-ID: <20180117074647.aqk72mjwtxxo53cd@linux-x5ow.site>

On Tue, Jan 16, 2018@05:49:54PM +0100, Christoph Hellwig wrote:
> > +	trace_seq_printf(p, "slba=%llu, length=%u, control=0x%x, dsmgmt=%u, reftag=%u",
> 
> Overly long line.
> 
> > +			 (unsigned long long)le64_to_cpu(rw.slba),
> 
> u64 now always is an unsigned long long, no need for the cast.

Ah OK. Didn't know that. Will fix.

> > +			 le16_to_cpu(rw.length), le16_to_cpu(rw.control),
> > +			 le32_to_cpu(rw.dsmgmt), le32_to_cpu(rw.reftag));
> > +	trace_seq_putc(p, 0);
> 
> This look weird, is there a a good reason for putting a 0 character?
> 
> Also I'd be tempted to add a new trace.c file for these and make them
> dependent on whatever kernel option enables the tracing.

I was considering this as well so let's just do it. 

> 
> > --- /dev/null
> > +++ b/drivers/nvme/host/trace.h
> > @@ -0,0 +1,69 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> 
> Please add a real copyright header including the author.

I thought this is the new standard. OK will add a copyright header.

> const char *nvme_trace_parse_cmd(struct trace_seq *p, struct nvme_command cmnd);
> 
> > +#define __parse_nvme_cmd(cmd) nvme_trace_parse_cmd(p, cmd)
> 
> This looks weird.

Why? For instance that's exactly what SCSI does as well and nicely hides the
implicit "p".

> > +TRACE_EVENT(nvme_setup_cmd,
> > +
> > +	    TP_PROTO(struct nvme_command *cmd),
> > +
> > +	    TP_ARGS(cmd),
> > +
> 
> Please remove these empty lines.

Standard coding style in include/trace/events/ that's why I adopted it.

> > +	    TP_STRUCT__entry(
> > +		    __field( __u8,                opcode   )
> > +		    __field( __u8,                flags    )
> > +		    __field( __u16,               cid      )
> > +		    __field( __le32,              nsid     )
> > +		    __field( __le64,              metadata )
> 
> > +		    __field_struct( struct nvme_command, cmnd )
> And the additional whitespaces before and after the braces

See above.

> > +	    TP_fast_assign(
> > +		    __entry->opcode	= cmd->common.opcode;
> > +		    __entry->flags	= cmd->common.flags;
> > +		    __entry->cid	= cmd->common.command_id;
> > +		    __entry->nsid	= cmd->common.nsid;
> > +		    __entry->metadata	= cmd->common.metadata;
> > +		    memcpy(&__entry->cmnd, cmd, sizeof(__entry->cmnd));
> 
> Copying the whole SQE in tracing seems rather excessive.
> 
> > +	    TP_printk("nsid=%u, command_id=%u, flags=0x%x, metadata=0x%llx, cmd=(%s %s)",
> 
> Too long line.
> 
> > +		      le32_to_cpu(__entry->nsid), __entry->cid, __entry->flags,
> > +		      (unsigned long long) le64_to_cpu(__entry->metadata),
> 
> no need for the cast.
> 
> > +#undef TRACE_INCLUDE_PATH
> > +#define TRACE_INCLUDE_PATH ../../drivers/nvme/host
> 
> This seems wrong.  Instead you should make sure we include the srcdir
> in the makefile, take a look at fs/xfs/Makefile for example.

That's what dma-buf, drm and ras do so I copied it over when moving the TP
header out of include/trace/events

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
