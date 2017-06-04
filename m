From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 4 Jun 2017 18:00:32 +0300
Subject: [PATCH v4 3/8] nvmet: implement namespace identify descriptor list
In-Reply-To: <20170604103649.22130-4-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-4-jthumshirn@suse.de>
Message-ID: <6595c70c-291e-5d02-3260-78a5a97f62e7@grimberg.me>


> +static void nvmet_execute_identify_desclist(struct nvmet_req *req)
> +{
> +	struct nvmet_ns *ns;
> +	struct nvme_ns_identifier_hdr hdr;
> +	u16 status = 0;
> +	off_t off = 0;
> +
> +	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
> +	if (!ns) {
> +		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
> +		goto out;
> +	}
> +
> +	if (memchr_inv(&ns->uuid, 0, sizeof(ns->uuid))) {
> +		memset(&hdr, 0, sizeof(hdr));
> +		hdr.nidt = NVME_NIDT_UUID;
> +		hdr.nidl = NVME_NIDT_UUID_LEN;
> +		status = nvmet_copy_to_sgl(req, off, &hdr, sizeof(hdr));
> +		if (status)
> +			goto out_put_ns;
> +		off += sizeof(hdr);
> +
> +		status = nvmet_copy_to_sgl(req, off, &ns->uuid,
> +					   sizeof(ns->uuid));
> +		if (status)
> +			goto out_put_ns;
> +		off += sizeof(ns->uuid);
> +	}
> +	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid))) {

Plain override in case a namespace is fed with both uuid and nguid?

Perhaps we should try to help the user a bit here and either fail
the user trying to populate both in configfs or pick one here.

> +		memset(&hdr, 0, sizeof(hdr));
> +		hdr.nidt = NVME_NIDT_NGUID;
> +		hdr.nidl = NVME_NIDT_NGUID_LEN;
> +		status = nvmet_copy_to_sgl(req, off, &hdr, sizeof(hdr));
> +		if (status)
> +			goto out_put_ns;
> +		off += sizeof(hdr);
> +
> +		status = nvmet_copy_to_sgl(req, off, &ns->nguid,
> +					   sizeof(ns->nguid));
> +		if (status)
> +			goto out_put_ns;
> +		off += sizeof(ns->nguid);
> +	}

If none exist we return whatever the the stack contains in hdr...
Lets initialize hdr with {} at the declaration.
