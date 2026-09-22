Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D19AC98304
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 22:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0EGwnJqLTgLZnLrZ6Z5AxYK0hsLKxXP9M5c8Jp/5Ro=; b=GCVQjdWKsLBj6mhFdCDaV2Sp2S
	t1YGG50oteWmHjW3lxNXVbezqOWAz7MCQpj+j+5djvypbnnij9BLMA88Ylp7BfUfthTMZhnLQyJGA
	SOe+QbvnDcB2yqw5cksn0rFTmKrAZ6iDG4I9kCR2yyMc52m17vHSy/i6Q9hjQ45pGGPdUGxXJwo+s
	yodSq6kWAfVqtMLY8zNjORPXbUXLpW7bfVHp1t5U4eq1PkGXnlbXYtyxUneklP1WETl1uLSfKLKFJ
	3nOhbopmHv7T3NSQRRHkAtkQ2h1HWjSTAAY/KjDHeU6c1j1K1cKwJ7IGyncNwFaKRA5iFqUg/Gyto
	THEQb6eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x98ie-00000006fHO-1Ybt;
	Tue, 22 Sep 2026 22:12:08 +0000
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x98ib-00000006fH0-2WrJ
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 22:12:07 +0000
Received: by mail-dy2-x0f.google.com with SMTP id 5a478bee46e88-33e630052ebso331622eec.0
        for <linux-nvme@lists.infradead.org>; Tue, 22 Sep 2026 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1790115124; x=1790719924; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M0EGwnJqLTgLZnLrZ6Z5AxYK0hsLKxXP9M5c8Jp/5Ro=;
        b=Of6ik4y2JvKoehQLA2I8u08L6CkU9dig/MxrWUH/ebkRVE7uKKGv39+23C7472BQbg
         YJbcUIXvYJUzwtA7jEYYIjzIBY5SZ9JdnLpfqqHEpdR7qWNtF9k1r6WYVDhRN+YTGn+T
         aan6dc3iA8evaBKK+Q17LEMWobiDykF7sVB/N4xicdcMkgD8sj1NM/p2scAz3aXLqa4U
         ywuwsoMXaR5lEfGz2KfseO4F4dKKs0szcCo32BK0HVBya2ZQ4bQM3VM6lk5xWzxPRRJ/
         1ERQxcZtvidHPq5BHs09x4Z7AtZBgzZPpFeVPYOBNH3yV1AryCrx9iv9bonYdF4PIMZy
         0+hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790115124; x=1790719924;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M0EGwnJqLTgLZnLrZ6Z5AxYK0hsLKxXP9M5c8Jp/5Ro=;
        b=hAOKpCTlvIigE8XGRrujW5xQKtjneUxygLUaQogVcOmSBE0TiAWSxwFHyIjCo5+xw8
         JrrzyutKx5GjMh//SWB90w+vvHbBT+6RqcB6C0HKxO+z3MAd7osBI/u5NvuXgjBQi/hA
         hDqOUJYK8vSqcOkZFPQPAmNOZQp6P5Yqvb7fD87Hzlgn0JVqb6aIjanSTmAaJ4XdjVIx
         lsJm44g+lYvs+h/47ebQ0KEje2zGRj6VxULZqYpPhKk8o9I5X79e3ptO1rfEqCGoCOfc
         8ByJATLCXcdAdhBbhifGJ7/TCvhLAjmvUuSb52waqO05j5yyht59qPi3G1ILjh7kV6yV
         xgsQ==
X-Gm-Message-State: AFuF++k2A+pwXKBkg9pJ1/TBAAApeYXsaVWpejXLmquT3P/+hFmnkBdR
	/ox74UvJAFrDtdWTX7klr5y9tMSivGgTgWMqZyGhuTABVK7p2b9+Ep+bKOhsi5MoIOE=
X-Gm-Gg: AYBFou3q2xGhmce3ymJmZw0PO/woA61BYaGdMIGQwQNkjtcQl/nlbMTSgC3kZ/3S/Oe
	oBRj0g35aUPgvj4oQO5NlUlZQ/wyxum8SSZxEke6Rxml4lX2rNBXj4y1oQ24siXvThI2jmmH//y
	3XXQcY8NEETz01vVt5GeNkmPjFVJphONIA4Ejlvn0PCFsCi2rxEHfsff2U1/UCJ6W32XfK29O/i
	FF3ya8YewqNGZwxcfebycNoWkZ5UiZZ1keswQlH1Q7XRG0g8mJkQGxjsWeJtUSSCM4lg7TZqPOS
	BU9k6kUaQn+z5QMepWRLW2FRklgSwBClPTZ8PnuCrPNTdhnFdsenJcmiX7Pm6ms8t5SUTmzvVJE
	mg66bFog5lvNNmsKtxMIsRcsyZRQ5nynLM3f7ceQh2fkAfRKLOeSbx9KJt/uZXzFes14ha2wlkY
	sw42dgxARc0dqCTvVVC6apmK/JKy8SGiCzcxYKsfiU1VgkaJwL5OxIJFlHv/bF+rcpkMcHrCipD
	CF2fNMQxO4z8zbiKsHJmtLzp9+L/GtHT/15pfVt
X-Received: by 2002:a05:693c:8810:20b0:33c:342e:f408 with SMTP id 5a478bee46e88-33e8e2b3e1bmr616215eec.35.1790115123397;
        Tue, 22 Sep 2026 15:12:03 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33e96d46f48sm2056578eec.23.2026.09.22.15.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 15:12:02 -0700 (PDT)
Date: Tue, 22 Sep 2026 15:12:01 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Jesse Taube <jtaubepe@redhat.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Chris Leech <cleech@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] nvmet: Add traffic based keep alive support to
 configfs
Message-ID: <20260922221201.GE2931-mkhalfella@purestorage.com>
References: <20260922202257.1434980-1-jtaubepe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922202257.1434980-1-jtaubepe@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_151205_841073_9874DD7E 
X-CRM114-Status: GOOD (  27.67  )
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

On Tue 2026-09-22 16:22:56 -0400, Jesse Taube wrote:
> Add the ability to turn on and off tbkas (traffic based keep alive
> support) via configfs. This is useful for testing and debugging.

Yep, this is indeed useful.

> 
> Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> ---
>  drivers/nvme/target/admin-cmd.c |  4 +++-
>  drivers/nvme/target/configfs.c  | 27 +++++++++++++++++++++++++++
>  drivers/nvme/target/core.c      |  3 ++-
>  drivers/nvme/target/nvmet.h     |  1 +
>  4 files changed, 33 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index 7764a3c0195c..e734e4b68784 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -696,7 +696,9 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>  
>  	/* XXX: figure out what to do about RTD3R/RTD3 */
>  	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
> -	ctratt = NVME_CTRL_ATTR_HID_128_BIT | NVME_CTRL_ATTR_TBKAS;
> +	ctratt = NVME_CTRL_ATTR_HID_128_BIT;
> +	if (subsys->tbkas)
> +		ctratt |= NVME_CTRL_ATTR_TBKAS;
>  	if (nvmet_is_pci_ctrl(ctrl))
>  		ctratt |= NVME_CTRL_ATTR_RHII;
>  	id->ctratt = cpu_to_le32(ctratt);
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 6286e38436dd..5766e594e724 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1369,6 +1369,32 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
>  }
>  CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
>  
> +static ssize_t nvmet_subsys_attr_tbkas_show(struct config_item *item,
> +					     char *page)
> +{
> +	return snprintf(page, PAGE_SIZE, "%d\n", to_subsys(item)->tbkas);
> +}
> +
> +static ssize_t nvmet_subsys_attr_tbkas_store(struct config_item *item,
> +					      const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +	bool tbkas;
> +
> +	if (subsys->subsys_discovered) {
> +		pr_err("Can't set traffic based keep alive support. %d is already assigned\n",
> +		       subsys->tbkas);
> +		return -EINVAL;
> +	}

Would it be okay to fore reconnecting existing controllers when
subsys->tbkas changes? Similar to what attr_qid_max does?

I think this will make testing more flexible by avoiding need to
recreate the subsystem in order to test tkbas on/off. Also, you may
consider adding ctrl->tkbas, again just like qid_max. It will be copied
from subsys in nvmet_alloc_ctrl() under subsys->lock.

> +
> +	if (kstrtobool(page, &tbkas))
> +		return -EINVAL;
> +
> +	subsys->tbkas = tbkas;
> +	return count;
> +}
> +CONFIGFS_ATTR(nvmet_subsys_, attr_tbkas);
> +
>  static ssize_t nvmet_subsys_attr_cntlid_min_show(struct config_item *item,
>  						 char *page)
>  {
> @@ -1706,6 +1732,7 @@ static struct configfs_attribute *nvmet_subsys_attrs[] = {
>  	&nvmet_subsys_attr_attr_qid_max,
>  	&nvmet_subsys_attr_attr_ieee_oui,
>  	&nvmet_subsys_attr_attr_firmware,
> +	&nvmet_subsys_attr_attr_tbkas,
>  #ifdef CONFIG_BLK_DEV_INTEGRITY
>  	&nvmet_subsys_attr_attr_pi_enable,
>  #endif
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 43871a8f56ca..20aeb9624be0 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1227,7 +1227,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_sq *sq,
>  		goto fail;
>  	}
>  
> -	if (sq->ctrl)
> +	if (sq->ctrl && sq->ctrl->subsys->tbkas)
>  		sq->ctrl->reset_tbkas = true;

If you add ctrl->tkbas, then this will be sq->ctrl->tkbas. It is
guaranteed not to change during the lifetime of the controller.

>  
>  	return true;
> @@ -1865,6 +1865,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>  	}
>  
>  	subsys->ieee_oui = 0;
> +	subsys->tbkas = true;
>  
>  	subsys->firmware_rev = kstrndup(UTS_RELEASE, NVMET_FR_MAX_SIZE, GFP_KERNEL);
>  	if (!subsys->firmware_rev) {
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index dbda55895f4f..241eac4fa969 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -343,6 +343,7 @@ struct nvmet_subsys {
>  	bool			subsys_discovered;
>  	char			*subsysnqn;
>  	bool			pi_support;
> +	bool			tbkas;
>  
>  	struct config_group	group;
>  
> -- 
> 2.55.0
> 

