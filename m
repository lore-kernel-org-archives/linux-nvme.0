Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E05C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Dec 2021 10:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Js75ukED4NHohGsmHCtYToOapLHxofH7lk5Wt6INhhM=; b=ESa3sgES3qaC25soEd9n01Vc/b
	wbTogGIfgh5+QQhTJSlshrPp65XAPTBTJoNgmT/IMKWeiMrSi5rFVrFdUmvhVESJyDACxgay+oLQR
	1jgVRubJq9Bxixkn8zbPt9/48QJOuUYVIjtrdNUd7JvY+R1yXAOXy4GHYvDz/kecjgjRnrgIzuIFd
	3nWw3jcSGxGDSs+C2F4ekFERLolay7k5HuAGL3ZAE9XnPpUx+zHpblrAAyqo2MnpCOiCKuxEYtkha
	TZU+0hzE29uNlrsiibzyuNf4uKRk9C0iFe7sfxhIWjLh192YyFPUUj40Nj4wzKMXZKGN5hBkiaDd5
	PFJahuFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzG1n-001gGI-CG; Mon, 20 Dec 2021 10:36:23 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzG1k-001gF3-M9
 for linux-nvme@lists.infradead.org; Mon, 20 Dec 2021 10:36:22 +0000
Received: by mail-wm1-f50.google.com with SMTP id z206so6552471wmc.1
 for <linux-nvme@lists.infradead.org>; Mon, 20 Dec 2021 02:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Js75ukED4NHohGsmHCtYToOapLHxofH7lk5Wt6INhhM=;
 b=h8TeTBiuBmtgvS2mJkBSuSxvp46BNDMr1UIydWAX/UyWuEIzaDtsA2YHzAPBtzB/oJ
 8I2KGL8KfjTJvRtv0xFQu4I2mcKbDF4Vv/rxTXkBHdgkmWvGie7VP/HZa4uBa0woXtSj
 I8M0zVrbowySepW6beT4owWf80v2yAXk4WIhJZH3tbR8A6yb+miNWj8Bf9MSLyal8lrK
 B0L1uDuu0SXFEw7/A09izajCJEV0lZpao6qbQ7rHqFRU1vzjteogSHdQAbS+j6E/LlNZ
 Ef7D7wN7B0YaV4XkweJW8W3DUSLZs+RFiXRMRdPzlCyNg7Os0U7Nqnx+kTzeStiKqlD8
 /SYw==
X-Gm-Message-State: AOAM532i/+6boYf8381MZDWMjQiM4BCpIqYTu/JIHY0EtL8/wbeDT/XO
 Ysp/yvxoYVX6A6mLY1RSbvU=
X-Google-Smtp-Source: ABdhPJz+Z4Tp8peub6nikr2t5qhP0qsjzPeIMNMcf0rGOfJCBes1+yBRTrnxXniNmSelmxpAir13ig==
X-Received: by 2002:a7b:c357:: with SMTP id l23mr20561652wmj.35.1639996577178; 
 Mon, 20 Dec 2021 02:36:17 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id b1sm4252073wrd.71.2021.12.20.02.36.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Dec 2021 02:36:16 -0800 (PST)
Subject: Re: [PATCHv3] nvme: add 'iopolicy' module parameter
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20211220093017.84283-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <eccd7ac9-42ab-2610-97e6-62a3119e285c@grimberg.me>
Date: Mon, 20 Dec 2021 12:36:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211220093017.84283-1-hare@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211220_023620_768362_87D3E528 
X-CRM114-Status: GOOD (  25.34  )
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



On 12/20/21 11:30 AM, Hannes Reinecke wrote:
> While the 'iopolicy' sysfs attribute can be set at runtime, most
> storage arrays prefer to use the 'round-robin' iopolicy per default.
> We can use udev rules to set this, but is getting rather unwieldy
> for rebranded arrays as we would have to update the udev rules
> anytime a new array shows up, leading to the same mess we currently
> have in multipathd for configuring the RDAC arrays.
> 
> Hence this patch adds a module parameter 'iopolicy' to allow the
> admin to switch the default, and to do away with the need for a
> udev rule here.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c      |  4 +---
>   drivers/nvme/host/multipath.c | 27 +++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h      |  4 ++++
>   3 files changed, 32 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 44c375a1edbb..be404004c235 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2747,9 +2747,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   		return -EINVAL;
>   	}
>   	subsys->awupf = le16_to_cpu(id->awupf);
> -#ifdef CONFIG_NVME_MULTIPATH
> -	subsys->iopolicy = NVME_IOPOLICY_NUMA;
> -#endif
> +	nvme_mpath_default_iopolicy(subsys);
>   
>   	subsys->dev.class = nvme_subsys_class;
>   	subsys->dev.release = nvme_release_subsystem;
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 7f2071f2460c..de98c0e05777 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -13,6 +13,33 @@ module_param(multipath, bool, 0444);
>   MODULE_PARM_DESC(multipath,
>   	"turn on native support for multiple controllers per subsystem");
>   
> +static int iopolicy = NVME_IOPOLICY_NUMA;
> +
> +static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
> +{
> +	char *endp;
> +	int p;
> +
> +	if (!val)
> +		return -EINVAL;
> +	p = simple_strtoul(val, &endp, 0);
> +	if (p != NVME_IOPOLICY_NUMA &&
> +	    p != NVME_IOPOLICY_RR)
> +		return -EINVAL;
> +	iopolicy = p;
> +	return 0;
> +}
> +
> +module_param_call(iopolicy, nvme_set_iopolicy, param_get_int,
> +		  &iopolicy, 0644);
> +MODULE_PARM_DESC(iopolicy,
> +	"Default multipath I/O policy; 0 - NUMA (default), 1 - Round-robin");

Maybe make this a string? user will set numa|round-robin ? That is the
sysfs interface iirc...

