Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3A5C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 01:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HxIlN3T/BwLOh/zJyqMOUI1W8G3owFlTAzaO+QPwVfE=; b=qHg2CbcJZLnxydsxEN8JXvsOk9
	z7+B4QliKyyY5mq70gJfvo79LsbEBA7Ggi45C7h3kfW2NNw2jB1IRVBLGO0mFau3v6Kqm7aLKHgkK
	MuVVZETf0ohJqm/wfsyiurT8nkdb21MXotYPyneSl6RAQ4jgFseX+XqItwYsi4QjWne7p831CsyBN
	/ZeW8pBldlhoLPtS928xAltBgFGmInnPeIjtFALSMOm2WO4XcHvbWya3TW7vosIecHIrLWby5ot/r
	y4fWhPzF7WZU8DovlTbDEcp/JsFgcrnxE2cW2Tf5TpRP2fG1DeR3R8ISr8R9my6s+L0/4vlOWNgJ9
	Em4uEkVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncd3k-00EVHA-LN; Fri, 08 Apr 2022 01:05:08 +0000
Received: from mail-pl1-f174.google.com ([209.85.214.174])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncd3h-00EVGI-Du
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 01:05:07 +0000
Received: by mail-pl1-f174.google.com with SMTP id be5so590720plb.13
 for <linux-nvme@lists.infradead.org>; Thu, 07 Apr 2022 18:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HxIlN3T/BwLOh/zJyqMOUI1W8G3owFlTAzaO+QPwVfE=;
 b=aLO3TuqDhNq3gjqF2HIHzQMuuF+QViBM1FssVcNWp3EAbGtjCCdZKrhSUviykaPaZ8
 URWJ71SYyxXSHtv1P+VZaqrfPQE3VwBKs2ktVO6JeC7hZdlUQY3BIYg7oHRgjd8KyIeL
 Os1DuxlHStRWi69LQM7ss2Yrlj7aCwODMVTs752WCceZimeM56MJb1EGMnRkwiLwoslM
 z2Il/QHeszU/golGPCcNhFfz4A9AeA9khkxS3xnKg7pMsUZwd63UcY/0pk1HvVFwibOy
 ugRuLcpXLWX4x9l5blyXhW8ptsDQ3s0mAejacje5pFeK9uE6ROmLjkrG0x1gLvx78ZvE
 2j9g==
X-Gm-Message-State: AOAM5329DO7lCtLu2yeebPKQmg0HsFhAy+qSn0ZHeZF5cFQunAceKWsU
 lpblyRrHnQ1nHSJxzFiCFOc=
X-Google-Smtp-Source: ABdhPJwPgx1oi9dpn/A7JVp3QCqc/iKVrveN3Uv1q7SqAEjLMJNuaOq+n3DDBsQ+8o1br2GyTSE12A==
X-Received: by 2002:a17:902:da89:b0:154:5d8e:9d40 with SMTP id
 j9-20020a170902da8900b001545d8e9d40mr16441780plx.71.1649379902676; 
 Thu, 07 Apr 2022 18:05:02 -0700 (PDT)
Received: from garbanzo (136-24-173-63.cab.webpass.net. [136.24.173.63])
 by smtp.gmail.com with ESMTPSA id
 k3-20020a056a00168300b004f7e60da26csm24323715pfc.182.2022.04.07.18.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Apr 2022 18:05:01 -0700 (PDT)
Date: Thu, 7 Apr 2022 18:04:59 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Klaus Jensen <its@irrelevant.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, mcgrof@kernel.org
Subject: Re: [PATCH 4/4] nvme: check that EUI/GUID/UUID are globally unique
Message-ID: <Yk+KO8hEYpnKdGu3@garbanzo>
References: <20220224192845.1097602-1-hch@lst.de>
 <20220224192845.1097602-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224192845.1097602-5-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_180505_532719_FE490431 
X-CRM114-Status: GOOD (  28.53  )
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

On Thu, Feb 24, 2022 at 08:28:45PM +0100, Christoph Hellwig wrote:
> Add a check to verify that the unique identifiers are unique globally
> in addition to the existing check that verifies that they are unique
> inside a single subsystem.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index cece987ba1691..f8084ded69e50 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3810,12 +3810,45 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>  	return ERR_PTR(ret);
>  }
>  
> +static int nvme_global_check_duplicate_ids(struct nvme_subsystem *this,
> +		struct nvme_ns_ids *ids)
> +{
> +	struct nvme_subsystem *s;
> +	int ret = 0;
> +
> +	/*
> +	 * Note that this check is racy as we try to avoid holding the global
> +	 * lock over the whole ns_head creation.  But it is only intended as
> +	 * a sanity check anyway.
> +	 */
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(s, &nvme_subsystems, entry) {
> +		if (s == this)
> +			continue;
> +		mutex_lock(&s->lock);
> +		ret = nvme_subsys_check_duplicate_ids(s, ids);
> +		mutex_unlock(&s->lock);
> +		if (ret)
> +			break;
> +	}
> +	mutex_unlock(&nvme_subsystems_lock);
> +
> +	return ret;
> +}
> +
>  static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
>  		struct nvme_ns_ids *ids, bool is_shared)
>  {
>  	struct nvme_ctrl *ctrl = ns->ctrl;
>  	struct nvme_ns_head *head = NULL;
> -	int ret = 0;
> +	int ret;
> +
> +	ret = nvme_global_check_duplicate_ids(ctrl->subsys, ids);
> +	if (ret) {
> +		dev_err(ctrl->device,
> +			"globally duplicate IDs for nsid %d\n", nsid);

So what sort of meachanisms would break in nvme if we don't (as it was
before this patch)? The reason I ask is that it would seem tons of
instantiated qemu guests used the default, and don't set the UUID,
and so this is auto-generated as per the documentation [0]. However,
I'm suspecting the auto-generation may just be... a single value:

root@kdevops ~ # cat
/sys/devices/pci0000:00/0000:00:08.0/nvme/nvme0/nvme0n1/uuid
00000001-0000-0000-0000-000000000000
root@kdevops ~ # cat
/sys/devices/pci0000:00/0000:00:0b.0/nvme/nvme3/nvme3n1/uuid
00000001-0000-0000-0000-000000000000
root@kdevops ~ # cat
/sys/devices/pci0000:00/0000:00:0b.0/nvme/nvme3/nvme3n1/uuid
00000001-0000-0000-0000-000000000000
root@kdevops ~ # cat
/sys/devices/pci0000:00/0000:00:0a.0/nvme/nvme2/nvme2n1/uuid
00000001-0000-0000-0000-000000000000

This means I have to go manually try to decipher this out on my
guests.

Printing a warning would only make sense if this really isn't critical.
But as of now this patch will even prevent boot as some filesystems now
can't mount which were set to mount on /etc/fstab.

[0] https://qemu-project.gitlab.io/qemu/system/devices/nvme.html

  Luis

