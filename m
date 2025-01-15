Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD36C02180
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 04:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0qlbbBwJzayUamBG16V5o6//ujjqM4UghrZn1gCsl8o=; b=cCzy5MJNJ6LNxdVwUpUTlG80hc
	/viGKhuvpeXTEMY7F92fFDnDdFtIrWsSRaS5qNccLoAuJqU7obbNx77d1ygg4mBlOjV+yU7a4XfQu
	SYzQtKZpuaGavEZCamCjrjBdTLBpIYiaY2whp/FxLG2lZyKbpVFL81n2Vv9mcBWJlRissgvZemiXL
	DD67ckGduqjki3W6f+CM+f/JrqsRYiHmH9N79zpJwU9Llsjfd2ZOzo+SK3ElLSZarWdt3cdifd8QV
	c80xcmn9q4DtuvopVhlKpJjMMmKug8nBT5iANkZ4gDQ2oZs4+AtvJxFobQjdTDSxjIpJc2j9QzVWK
	c7Evy//g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXvQs-0000000AdmW-44rN;
	Wed, 15 Jan 2025 04:55:10 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXvQq-0000000Adm8-3AEi
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 04:55:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 59898A4160A;
	Wed, 15 Jan 2025 04:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679AEC4CEDF;
	Wed, 15 Jan 2025 04:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736916907;
	bh=+1nQ3hmNjQnaaQcJ8igBWrkFfrTpilYeFBpl5dqRKwk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lk3En1wwpJdK1XiXuc8eZB4GL3FUJxkg/CRrPA6cug9cjscU25tnt+IWCn6VTOhBe
	 Ncq95BF1+vXNW0LHCXkndG0X7IYHNpVmUbtP+3QU5jxOhWYQHC3+TgL30wyRjyAZot
	 G66kI6jtfFp5Qefyj4OQK+Ab6wr88EUQGAFwqeRMcSndKN0gf5mF7rTVNU4Ejip2KG
	 PKt4hcxKVTp1klHdRfjMUOw+K9/huXlERxgmYqOJEK2lbESv3ZCIQ9YqY78jHH7lOb
	 o9e7huu/FGhp9T6lhQnuOTTXzyfUdczyDpa34Ldf6+nzF0Ve9CZmaMI4F9XyoilbAi
	 KoCB8xMGbafag==
Message-ID: <e2d6e6c2-9d37-4be0-a1c0-645231715275@kernel.org>
Date: Wed, 15 Jan 2025 13:55:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: fix compliation errors
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
References: <20250115034722.145742-1-kch@nvidia.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250115034722.145742-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_205508_934878_A77D9F69 
X-CRM114-Status: GOOD (  23.55  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 1/15/25 12:47, Chaitanya Kulkarni wrote:
> nvmet_alloc_ctr() only takes nvmet_alloc_ctrl_args. nvmet_alloc_ctrl

s/nvmet_alloc_ctr/nvmet_alloc_ctrl

> doesn't have nvmet_req argumrnt. In nvmet_alloc_ctrl nvmet_req is

s/argumrnt/argument/

> needed when setting up authentication capabilities since call to
> nvmet_setup_auth() requires nvmet_req argument which later uses req->sq
> to determnine if tls is enabled or not.
> 
> That leads to following compliation errors:-

s/compliation/compilation

> When nvmet_alloc_ctrl() is called from nvmet_execute_admin_connect() use
> nvmet_execute_admin_connect()'s function parameter nvmet_req *req as
> a second argument to nvmet_alloc_ctrl() and when nvmet_alloc_ctrl() is
> called from nvmet_pci_epf_create_ctrl() pass NULL as a second argument
> since as of now we don't have a way to know if pci epf needs nvme target
> authentication.
> 
> Also, fix the nvmet_has_auth() and nvmet_setup_auth() calls from function
> nvmet_alloc_ctrl() by adding the nvmet_req *req argument. Fix the
> nvmet_connect_result() call by adding the nvmet_req *req argument. Also,
> remove the local varible nvmet_req and arg->req assignment since there

s/varible/variable

> is no nvmet_req *req present in the struct nvmet_alloc_ctrl_args.

My bad. Thanks for fixing this. I just wonder how I did not see this problem,
nor did the 0-day bot.

With the typos fixed,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  drivers/nvme/target/core.c        | 8 ++++----
>  drivers/nvme/target/fabrics-cmd.c | 4 ++--
>  drivers/nvme/target/nvmet.h       | 6 +++++-
>  drivers/nvme/target/pci-epf.c     | 2 +-
>  4 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index ef424f7e0ed6..d642d0f40b0a 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1522,9 +1522,9 @@ static void nvmet_fatal_error_handler(struct work_struct *work)
>  	ctrl->ops->delete_ctrl(ctrl);
>  }
>  
> -struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
> +struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args,
> +				    struct nvmet_req *req)
>  {
> -	struct nvmet_req *req = args->req;
>  	struct nvmet_subsys *subsys;
>  	struct nvmet_ctrl *ctrl;
>  	u32 kato = args->kato;
> @@ -1632,7 +1632,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>  	if (args->hostid)
>  		uuid_copy(&ctrl->hostid, args->hostid);
>  
> -	dhchap_status = nvmet_setup_auth(ctrl);
> +	dhchap_status = nvmet_setup_auth(ctrl, req);
>  	if (dhchap_status) {
>  		pr_err("Failed to setup authentication, dhchap status %u\n",
>  		       dhchap_status);
> @@ -1651,7 +1651,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
>  		nvmet_is_disc_subsys(ctrl->subsys) ? "discovery" : "nvm",
>  		ctrl->cntlid, ctrl->subsys->subsysnqn, ctrl->hostnqn,
>  		ctrl->pi_support ? " T10-PI is enabled" : "",
> -		nvmet_has_auth(ctrl) ? " with DH-HMAC-CHAP" : "");
> +		nvmet_has_auth(ctrl, req) ? " with DH-HMAC-CHAP" : "");
>  
>  	return ctrl;
>  
> diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
> index d1e03c120893..3b3af19f8aaf 100644
> --- a/drivers/nvme/target/fabrics-cmd.c
> +++ b/drivers/nvme/target/fabrics-cmd.c
> @@ -305,7 +305,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
>  	args.hostid = &d->hostid;
>  	args.kato = c->kato;
>  
> -	ctrl = nvmet_alloc_ctrl(&args);
> +	ctrl = nvmet_alloc_ctrl(&args, req);
>  	if (!ctrl)
>  		goto out;
>  
> @@ -315,7 +315,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
>  		goto out;
>  	}
>  
> -	args.result = cpu_to_le32(nvmet_connect_result(ctrl));
> +	args.result = cpu_to_le32(nvmet_connect_result(ctrl, req));
>  out:
>  	kfree(d);
>  complete:
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 845af16561ab..3dcc01da1abe 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -594,7 +594,8 @@ struct nvmet_alloc_ctrl_args {
>  	u16			status;
>  };
>  
> -struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args);
> +struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args,
> +				    struct nvmet_req *req);
>  struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
>  				       const char *hostnqn, u16 cntlid,
>  				       struct nvmet_req *req);
> @@ -888,6 +889,9 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
>  			 unsigned int hash_len);
>  static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
>  {
> +	if (!req)
> +		return false;
> +
>  	return ctrl->host_key != NULL && !nvmet_queue_tls_keyid(req->sq);
>  }
>  int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
> diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
> index ac30b42cc622..fe7053809308 100644
> --- a/drivers/nvme/target/pci-epf.c
> +++ b/drivers/nvme/target/pci-epf.c
> @@ -2013,7 +2013,7 @@ static int nvmet_pci_epf_create_ctrl(struct nvmet_pci_epf *nvme_epf,
>  	args.hostnqn = hostnqn;
>  	args.ops = &nvmet_pci_epf_fabrics_ops;
>  
> -	ctrl->tctrl = nvmet_alloc_ctrl(&args);
> +	ctrl->tctrl = nvmet_alloc_ctrl(&args, NULL);
>  	if (!ctrl->tctrl) {
>  		dev_err(ctrl->dev, "Failed to create target controller\n");
>  		ret = -ENOMEM;


-- 
Damien Le Moal
Western Digital Research

