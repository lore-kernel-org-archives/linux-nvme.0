Return-Path: <SRS0=BHyj=6F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6696CC54FCC
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 15:30:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37DBC206A2
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Apr 2020 15:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="V5ydsaPx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37DBC206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=x8Wp5iXM5sUVkdxKW31hLjfDp9t+4wjQfteZKPaFkYo=; b=V5ydsaPx1Y52na
	jwO0v9q7pms+wRlVpGFjpqCMYXA1+AH8sTz0OEFITmSm6atNKDkaO/1RHW1rMGhRAiJtgdxtLPxR+
	WeDhyfh41Jwu4c4b1RlK89CvMlxtKRah9rEfOJzaMMyArMUClp9vh+lBOVuvJenp2jvQjEuAqyj/c
	EnGFrOzs2JBDM+6NAgDOAjRcvK/SsWHkUDeGPakgYBJyqulU6LDvCWFrpsFhIlGc4L6BLj1bqpHpJ
	nh44eBxBoySfpFSbaUmyCk770fvIxC3KtpIEpqZ5pHx9OuUFOUZ6lLo0WmExhcgK0Sfa3StfwsrCf
	DPP8PxGW0wO2F9q+h2YQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jQurM-00080h-82; Tue, 21 Apr 2020 15:30:52 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jQurI-0007vx-7h
 for linux-nvme@lists.infradead.org; Tue, 21 Apr 2020 15:30:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 63CD368C4E; Tue, 21 Apr 2020 17:30:45 +0200 (CEST)
Date: Tue, 21 Apr 2020 17:30:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 14/17] nvmet: Add metadata/T10-PI support
Message-ID: <20200421153045.GE10837@lst.de>
References: <20200327171545.98970-1-maxg@mellanox.com>
 <20200327171545.98970-16-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200327171545.98970-16-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200421_083048_448378_708F042E 
X-CRM114-Status: GOOD (  10.12  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, jsmart2021@gmail.com, sagi@grimberg.me,
 martin.petersen@oracle.com, shlomin@mellanox.com, linux-rdma@vger.kernel.org,
 israelr@mellanox.com, vladimirk@mellanox.com, linux-nvme@lists.infradead.org,
 idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com, kbusch@kernel.org,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +	/*
> +	 * Max command capsule size is sqe + single page of in-capsule data.
> +	 * Disable inline data for Metadata capable controllers.
> +	 */
>  	id->ioccsz = cpu_to_le32((sizeof(struct nvme_command) +
> -				  req->port->inline_data_size) / 16);
> +				  req->port->inline_data_size *
> +				  !ctrl->pi_support) / 16);

Can we de-obsfucated this a little?

	cmd_capsule_size = sizeof(struct nvme_command);
	if (!ctrl->pi_support)
		cmd_capsule_size += req->port->inline_data_size;
	id->ioccsz = cpu_to_le32(cmd_capsule_size / 16);

> +	if (ctrl->subsys->pi_support && ctrl->port->pi_enable) {
> +		if (ctrl->port->pi_capable) {
> +			ctrl->pi_support = true;
> +			pr_info("controller %d T10-PI enabled\n", ctrl->cntlid);
> +		} else {
> +			ctrl->pi_support = false;
> +			pr_warn("T10-PI is not supported on controller %d\n",
> +				ctrl->cntlid);
> +		}

I think the printks are a little verbose.  Also why can we set
ctrl->port->pi_enable if ctrl->port->pi_capable is false?  Shoudn't
we reject that earlier?  In that case this could simply become:

	ctrl->pi_support = ctrl->subsys->pi_support && ctrl->port->pi_enable;

> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> +static inline u32 nvmet_rw_md_len(struct nvmet_req *req)
> +{
> +	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) * req->ns->ms;
> +}
> +
> +static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
> +{
> +	return ns->md_type && ns->ms == sizeof(struct t10_pi_tuple);
> +}
> +#else
> +static inline u32 nvmet_rw_md_len(struct nvmet_req *req)
> +{
> +	return 0;

Do we really need a stub for nvmet_rw_md_len?  Also for nvmet_ns_has_pi
we could probably reword it as:

static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
{
	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
		return false;
	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
}

and avoid the need for a stub as well.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
