From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 26 Jun 2018 08:55:32 -0600
Subject: [PATCH v4 1/2] nvme: cache struct nvme_ctrl reference to struct
 nvme_request
In-Reply-To: <20180626135141.14088-2-jthumshirn@suse.de>
References: <20180626135141.14088-1-jthumshirn@suse.de>
 <20180626135141.14088-2-jthumshirn@suse.de>
Message-ID: <20180626145532.GA6628@localhost.localdomain>

On Tue, Jun 26, 2018@03:51:40PM +0200, Johannes Thumshirn wrote:
> @@ -652,6 +653,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
>  	}
>  
>  	cmd->common.command_id = req->tag;
> +	nvme_req(req)->ctrl = ctrl;
>  	if (ns)
>  		trace_nvme_setup_nvm_cmd(req->q->id, cmd);
>  	else

I don't think we need to do this per-io. The request coming from the
controller's tagset, so we can do this just once at .init_request time,
right?
