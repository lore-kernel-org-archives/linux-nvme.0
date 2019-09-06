Return-Path: <SRS0=wEPw=XB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30D4C43331
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 13:00:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 575962082C
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 13:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ItJhzW/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575962082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EeRm0cAq7dgKCVbZA1nNUsUz9Aup9bczQQ7TYh5HuIg=; b=ItJhzW/MlzhUgy
	kArko85yIQN9B2MITnZ3oixGjznrA4pFiblfR5Gk/2hjpRwMw8KeIzboL5ySBNBokArYW5s/mFDad
	m7Vxd/E6Nl8Gc7KvAINpjkQ5vsq94EGlmY3hgunnCCS3483oAlFSdYffuEaRcPUB1jppn7q8MH5NY
	PJGIs85oB7VOkQYcX5YxAHGIpmKunzrOP/+4XC8bj16KiHsTlOc7KU42t8+g//7QB+MV0EL86aiUR
	6QqxEeWMcJgLk9wCo7dChLnPmgjT5q6Fo+48JAnPypIEqZCfp3o+GO0nUeKFa0283SkLFsseeoIFJ
	XYh2Vb8ALHTirnq3WpIQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6DqN-0003DR-2R; Fri, 06 Sep 2019 13:00:03 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i6DqJ-0002vt-Tm
 for linux-nvme@lists.infradead.org; Fri, 06 Sep 2019 13:00:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CD47A68BE1; Fri,  6 Sep 2019 14:59:53 +0200 (CEST)
Date: Fri, 6 Sep 2019 14:59:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v4 3/4] nvme: add uevent variables for controller devices
Message-ID: <20190906125953.GA8873@lst.de>
References: <20190904215954.15423-1-sagi@grimberg.me>
 <20190904215954.15423-4-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190904215954.15423-4-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190906_060000_108282_85AD684A 
X-CRM114-Status: GOOD (  15.13  )
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
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.de>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 04, 2019 at 02:59:52PM -0700, Sagi Grimberg wrote:
> When we send uevents to userspace, add controller specific
> environment variables to uniquly identify the controller beyond
> its device name.
> 
> This will be useful to address discovery log change events by
> actually verifying that the discovery controller is indeed the
> same as the device that generated the event.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/core.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fccf28d77c03..7a1df95ec840 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3630,6 +3630,33 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  }
>  EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
>  
> +static int nvme_class_uevent(struct device *d, struct kobj_uevent_env *env)
> +{
> +	struct nvme_ctrl *ctrl =
> +		container_of(d, struct nvme_ctrl, ctrl_device);

Why the weird variable name of d instead of dev? as we usually use?


> +	if (opts) {

	if (!opts)
		return;

?  But then again how we can end up here without ctrl->opts?

> +		ret = add_uevent_var(env, "NVME_TRSVCID=%s",
> +			(opts && opts->trsvcid) ? opts->trsvcid : "none");

No need to check opts here again.

> +		ret = add_uevent_var(env, "NVME_HOST_TRADDR=%s",
> +			(opts && opts->host_traddr) ? opts->host_traddr : "none");

Same here.

Otherwise this looks fine modulo the nitpick from James.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
