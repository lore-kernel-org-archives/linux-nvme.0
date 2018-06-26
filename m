From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 26 Jun 2018 09:01:06 -0600
Subject: [PATCH] nvme: trace: add disk name to tracepoints
In-Reply-To: <20180626135141.14088-3-jthumshirn@suse.de>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-3-jthumshirn@suse.de>
Message-ID: <20180626150106.GB6628@localhost.localdomain>

On Tue, Jun 26, 2018@03:51:41PM +0200, Johannes Thumshirn wrote:
> @@ -655,9 +655,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  	cmd->common.command_id = req->tag;
>  	nvme_req(req)->ctrl = ctrl;
>  	if (ns)
> -		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
> +		trace_nvme_setup_nvm_cmd(req, cmd, ns->disk->disk_name);

Not related to your patch, but I did notice that the req->q->id isn't
really useful here since that's not the hardware context identifier.
That's just some ida assigned software identifier. For the admin command
completion trace, it's actually a little confusing to see the qid in the
trace.
