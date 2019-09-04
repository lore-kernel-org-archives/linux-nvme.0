Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F18C3A59E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 23:17:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0574421726
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 23:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PK8598VO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="B/kbC1XP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0574421726
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SnbBbNHNQLH3Ql4FD6hl2q6g+ZIIsLQv0CmmHGuXoKY=; b=PK8598VOyjBS1ZcuDQQ14oUlQ
	XLNWRQcAQXlRvozi65dT9omfPQo4tvx5jW/K3HjSbbCWW+Ddj+ArbfSLDLZhrfOjmJ20/o/dZEq3F
	fXlMPWyl8vxeuU8h7AVallfardlXaBZtRqk7L77KhGDK+mtjigI1NeFeXPWXbQdg5otZBFLmCzxus
	0GNd6Mo3TxvTMUhxfy8qfyxLLnKsKIHlxsWSMX0Yu6xlr287adlNt+Mdns/mPBHerQZfzmR5PbzyC
	TgI6XKQkO+O5Uk5d3qiADwVHs2uEEyYPU10WDeCHYBh9FUZMSDhGrio3w/3obVJK5awZXkdxZjY/u
	ysiJMBNzg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5eX0-0007Zp-L8; Wed, 04 Sep 2019 23:17:42 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5eWx-0007ZW-Oc
 for linux-nvme@lists.infradead.org; Wed, 04 Sep 2019 23:17:41 +0000
Received: by mail-pg1-x542.google.com with SMTP id l21so284236pgm.3
 for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2019 16:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=cAPUxN0S7sbwgaKTelUbVUIvCODb7x3BSZqydxnWrpc=;
 b=B/kbC1XPgvhTxbgdaMe+AYCWRhgciRL/1lx0GUlnp2Hyv+FdvK/wUc06AgWMmFTGPB
 IE0xyegdqMM3ztbYtElsPdbg77Ui3+m+9EAK8QS+/eyaVKRMjuORv66uO1pe/c/66FlW
 HHz71sn7OrwyJqZd6fK66ELD1EeOKB7sM73Qs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=cAPUxN0S7sbwgaKTelUbVUIvCODb7x3BSZqydxnWrpc=;
 b=pwgnu0GlydZvNA+7VZ14OsqOYuFE2bx1l58A4+5shbRBP4F8S8mSVj77ITqa11dQ50
 7OxWR6RLb22McJ7TTQd86qC4sXn8MEMvAT5DYtPDBBC96JJS6Q+5IPATngTde3nYKngS
 0ug2xFd5Zgyf72uYT3JMDWgN54/btJgUSxiRXuHu8AizDzRv/SH/pYsnNcRkKrJn4xCq
 rTpu0bsHQTFbzHE88ZjhAdoOuaRD49S3I+X+ZkbVu99Gbq727owslNbatPVs0ba75s7J
 ulU67OlRf5hhAwoZpz3yIrvyLs+VJYVYAg62YJs36WGJAPMfBgW0F9rjmCD6SWGl3fU3
 qFog==
X-Gm-Message-State: APjAAAX3ttOqDdy8Qi/XlX+9iZNS8fDVCcH4aWUtDvXOTqITIwiYh0Nr
 e5kbq5nxcS9cB7VOPdkoWd130g==
X-Google-Smtp-Source: APXvYqzJI2nSn4A3adqwBmk2FFrjMlEM/GnHPU+0EVgt0dGSj4Y56WNVTA/cQkOnJLdUA7KxSVBayA==
X-Received: by 2002:a63:4846:: with SMTP id x6mr517652pgk.332.1567639058634;
 Wed, 04 Sep 2019 16:17:38 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id f20sm178012pgg.56.2019.09.04.16.17.37
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 04 Sep 2019 16:17:38 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] nvme: add uevent variables for controller devices
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20190904215954.15423-1-sagi@grimberg.me>
 <20190904215954.15423-4-sagi@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <b0e3f456-4071-abb8-5af9-26354c1a5356@broadcom.com>
Date: Wed, 4 Sep 2019 16:17:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904215954.15423-4-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190904_161739_813264_8ED49C09 
X-CRM114-Status: GOOD (  20.56  )
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
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 9/4/2019 2:59 PM, Sagi Grimberg wrote:
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
>   drivers/nvme/host/core.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fccf28d77c03..7a1df95ec840 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3630,6 +3630,33 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>   }
>   EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
>   
> +static int nvme_class_uevent(struct device *d, struct kobj_uevent_env *env)
> +{
> +	struct nvme_ctrl *ctrl =
> +		container_of(d, struct nvme_ctrl, ctrl_device);
> +	struct nvmf_ctrl_options *opts = ctrl->opts;
> +	int ret;
> +
> +	ret = add_uevent_var(env, "NVME_TRTYPE=%s", ctrl->ops->name);
> +	if (ret)
> +		return ret;
> +
> +	if (opts) {
> +		ret = add_uevent_var(env, "NVME_TRADDR=%s", opts->traddr);
> +		if (ret)
> +			return ret;
> +
> +		ret = add_uevent_var(env, "NVME_TRSVCID=%s",
> +			(opts && opts->trsvcid) ? opts->trsvcid : "none");
> +		if (ret)
> +			return ret;
> +
> +		ret = add_uevent_var(env, "NVME_HOST_TRADDR=%s",
> +			(opts && opts->host_traddr) ? opts->host_traddr : "none");
> +	}
> +	return ret;
> +}
> +
>   static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
>   {
>   	char *envp[2] = { NULL, NULL };
> @@ -4063,6 +4090,7 @@ static int __init nvme_core_init(void)
>   		result = PTR_ERR(nvme_class);
>   		goto unregister_chrdev;
>   	}
> +	nvme_class->dev_uevent = nvme_class_uevent,

Comma at end of line ?

>   
>   	nvme_subsys_class = class_create(THIS_MODULE, "nvme-subsystem");
>   	if (IS_ERR(nvme_subsys_class)) {


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
