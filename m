From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 27 Jun 2018 10:37:06 -0600
Subject: [PATCH v5 2/2] nvme: trace: add disk name to tracepoints
In-Reply-To: <20180627125324.22064-3-jthumshirn@suse.de>
References: <20180627125324.22064-1-jthumshirn@suse.de>
 <20180627125324.22064-3-jthumshirn@suse.de>
Message-ID: <20180627163706.GA9361@localhost.localdomain>

On Wed, Jun 27, 2018@02:53:24PM +0200, Johannes Thumshirn wrote:
>  	    TP_fast_assign(
> -		    __entry->qid = qid;
> +		    __assign_str(name, disk_name);
> +		    __entry->ctrl_id = nvme_req(req)->ctrl->cntlid;
> +		    __entry->qid = req->q->id;
>  		    __entry->opcode = cmd->common.opcode;
>  		    __entry->flags = cmd->common.flags;
>  		    __entry->cid = cmd->common.command_id;
> @@ -122,10 +130,10 @@ TRACE_EVENT(nvme_setup_nvm_cmd,
>  		    memcpy(__entry->cdw10, cmd->common.cdw10,
>  			   sizeof(__entry->cdw10));
>  	    ),
> -	    TP_printk("qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
> -		      __entry->qid, __entry->nsid, __entry->cid,
> -		      __entry->flags, __entry->metadata,
> -		      show_opcode_name(__entry->opcode),
> +	    TP_printk("nvme%d: disk=%s, qid=%d, nsid=%u, cmdid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
> +		      __entry->ctrl_id, __get_str(name), __entry->qid,
> +		      __entry->nsid, __entry->cid, __entry->flags,
> +		      __entry->metadata, show_opcode_name(__entry->opcode),
>  		      __parse_nvme_cmd(__entry->opcode, __entry->cdw10))
>  );

This looks a bit confusing to me. The ctrl->cntlid you're using in
__entry->ctrl_id isn't a unique value across subsystems, and it will
typically be 0 for all controllers that are the only controller in
their subsystem.

It looks like you want the # assigned to /dev/nvme<#>. Do you want to
use ctrl->instance here instead?
