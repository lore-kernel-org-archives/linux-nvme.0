From: minwoo.im@samsung.com (Minwoo Im)
Date: Tue, 07 May 2019 07:56:45 +0900
Subject: [PATCH V2 2/2] nvme-trace: Add support to trace fabrics command
In-Reply-To: <SN6PR04MB4527A10184AEF3DDCC23CB0886300@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <SN6PR04MB4527A10184AEF3DDCC23CB0886300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <20190506194644.11109-1-minwoo.im.dev@gmail.com>
 <20190506194644.11109-3-minwoo.im.dev@gmail.com>
 <CGME20190506223810epcas4p224242aa97518322bcbe2aa11d39d84a3@epcms2p6>
Message-ID: <20190506225645epcms2p6b5efa570eade06b215b78418a0fbfdcc@epcms2p6>

> This look okay me with some minor comments, but it does not cover the
> target side tracing. In fact on the target side we have many components
> such as discovery/multipath/port/async events etc.

You're right, but this patch is just focused on nvme-host side command
tracing.  If host-side patch is accepted, then I think I can prepare the target
side tracing also with the experience of it.

What do you say?

> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index cd16d98d1f1a..eeda3ce9afaa 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -733,7 +733,12 @@ blk_status_t nvme_setup_cmd(struct nvme_ns
> *ns, struct request *req,
> >   	}
> >
> >   	cmd->common.command_id = req->tag;
> > -	trace_nvme_setup_cmd(req, cmd);
> > +
> > +	if (likely(!nvme_is_fabrics(cmd)))
> Do we really need likely here ? Isn't this branch should be guarded by
> trace config ? what if trace is not configured ?

The reason why I put likely here is that nvme_is_write() in linux/nvme.h
is doing the same kind of thing because, I think, it's going to be invoked
every simgle time in a performance critical path.

It's also be able to be built without trace configuration.  Can I ask why
do you concern the configuration of trace? (Actually I have build tested)

> > +		trace_nvme_setup_cmd(req, cmd);
> > +	else
> > +		trace_nvme_setup_fabrics_cmd(req, cmd);
> > +
> >   	return ret;
> >   }
> >   EXPORT_SYMBOL_GPL(nvme_setup_cmd);
> > diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
> > index 5f24ea7a28eb..0e027a49e3a1 100644
> > --- a/drivers/nvme/host/trace.c
> > +++ b/drivers/nvme/host/trace.c
> > @@ -135,6 +135,73 @@ const char *nvme_trace_parse_nvm_cmd(struct
> trace_seq *p,
> >   	}
> >   }
> >
> > +static const char *nvme_trace_fabrics_property_set(struct trace_seq *p,
> u8 *spc)
> > +{
> > +	const char *ret = trace_seq_buffer_ptr(p);
> > +	u8 attrib = spc[0];
> > +	u32 ofst = get_unaligned_le32(spc + 4);
> please use name "offset" here.

I have named these local variables to the same with names on spec.

> >
> > +TRACE_EVENT(nvme_setup_fabrics_cmd,
> > +	    TP_PROTO(struct request *req, struct nvme_command *cmd),
> > +	    TP_ARGS(req, cmd),
> > +	    TP_STRUCT__entry(
> > +		__field(int, ctrl_id)
> > +		__field(u16, cid)
> > +		__field(u8, fctype)
> > +		__array(u8, spc, 24)
> Can you please just declare a macro and replace 24 ? (I think we need to
> replace in the nvme_setup_cmd() also, please double check.

If we need to replace them to a macro, maybe it needs to be prepared with
a new commit to update them.  Anyway, I think size of 24 looks readable.
Do we really need to replace them with a macro ?

> > +	    ),
> > +	    TP_fast_assign(
> > +		__entry->ctrl_id = nvme_req(req)->ctrl->instance;
> > +		__entry->cid = cmd->fabrics.command_id;
> > +		__entry->fctype = cmd->fabrics.fctype;
> > +		memcpy(__entry->spc, &cmd->fabrics.ts,
> > +			sizeof(__entry->spc));
> > +	    ),
> > +	    TP_printk("nvme%d: cmdid=%u, cmd=(%s %s)",
> Do we need to differentiate between fabrics and local NVMe ctrl when
> reporting ?

I think we do.  The former one shows few fields that fabrics SQE does not
have.

Thank you, Chaitanya.
