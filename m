Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B62BFC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 13:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PkebJKC6T/F8cShVTssA3MYhq2Ka00GePzxdnKjRjis=; b=2l3ZfaVvHJkMytaN6Xh7CIj4Bj
	xkPe2R5puwcQZAsNO8iH1bydaCdhJK7kflvh68n1Kw9w8VJANDve9Bui9l0/HfMrmwfKaz28GHhQq
	ISDAqfKw3OpROVu/nUbxtp+KWaFZD4uDTVIFkXAPMGQVM0CHIgNRJa2n2OujWWOdJsr0Zy62vxCQV
	7oD93zMckMOSKbWuNcQg1boOTUEbbEkaHwUJh9hEDrYb6+nP9yo5fOxbJG2vJnwEyyXapDO0HC6yy
	49dpvOnYg50zZ+NHxePxfgm6UgK3cG0DIaajJNNMCxiIdmLqzpyZB+5xwpvlcOiOMKv+EyD503XBj
	FNwmrtpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nD4dR-00FrLp-8A; Thu, 27 Jan 2022 13:16:21 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nD4dN-00FrKb-Pj
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 13:16:20 +0000
Received: by mail-wr1-f43.google.com with SMTP id a13so4683155wrh.9
 for <linux-nvme@lists.infradead.org>; Thu, 27 Jan 2022 05:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=PkebJKC6T/F8cShVTssA3MYhq2Ka00GePzxdnKjRjis=;
 b=xNT/Lz33U6hd460sUxiW+NMId+t/wpkWSvmJdrhN6oCBS/Y/SEf2gyHLb2D8K0NCiY
 xUx6SeF5kPeu8+LsHM3fJfWeHXyk81V24xvK5/ukMyB1T32whczOwGQdMaXWFHESO03M
 axPeZ9HMS/zLZtlEaHd2wFiZ9d4ZKllozttCaPXZNqZ6fCLmLub1ehDqnKjTsbq6YQvJ
 gAACxkoSoIUHmleT27Hgxk03MyZoLMbzFwiEle+MkR2a2o40M8dSmWEWCRxpA3nDAYbC
 IquMf0LuzL4oBgsubMSt3RsnqPGLRCqQQulozNH3pvgSRx52tm4P1xDIUMjV7eRgTJua
 c1DA==
X-Gm-Message-State: AOAM533ALT1s5deXrqHg4plCVEq6sk1yxpv30TazSwjVLKBVF//sOcnh
 MbtCqC05qZnECv95or9KFmU=
X-Google-Smtp-Source: ABdhPJzyyfvECcscO7ad/NjGjwBfYX7o/cEHooOLEe06NxGm0sPw5A6SwumsFtBV5qn53hontAQcpg==
X-Received: by 2002:adf:ffce:: with SMTP id x14mr2920772wrs.127.1643289375639; 
 Thu, 27 Jan 2022 05:16:15 -0800 (PST)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id y15sm3459929wry.36.2022.01.27.05.16.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 05:16:15 -0800 (PST)
Message-ID: <ab180f76-f0f4-62f3-d87d-f97e8af984b0@grimberg.me>
Date: Thu, 27 Jan 2022 15:16:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] nvme-fabrics: add discovery controller type
Content-Language: en-US
To: Martin Belanger <nitram_67@hotmail.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 Martin Belanger <martin.belanger@dell.com>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291022C56E35D6F93500AF79C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <BL0PR13MB4291022C56E35D6F93500AF79C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_051617_887417_BE2B1F4E 
X-CRM114-Status: GOOD (  18.06  )
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


> ---
>   drivers/nvme/host/core.c |  3 +++
>   drivers/nvme/host/nvme.h |  2 ++
>   include/linux/nvme.h     | 10 +++++++++-
>   3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4fc794d9c2f4..cd34b92e8e9d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2978,6 +2978,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>   	ctrl->kas = le16_to_cpu(id->kas);
>   	ctrl->max_namespaces = le32_to_cpu(id->mnan);
>   	ctrl->ctratt = le32_to_cpu(id->ctratt);
> +	ctrl->dctype = id->dctype;
>   
>   	if (id->rtd3e) {
>   		/* us -> s */
> @@ -3335,6 +3336,7 @@ nvme_show_int_function(numa_node);
>   nvme_show_int_function(queue_count);
>   nvme_show_int_function(sqsize);
>   nvme_show_int_function(kato);
> +nvme_show_int_function(dctype);
>   
>   static ssize_t nvme_sysfs_delete(struct device *dev,
>   				struct device_attribute *attr, const char *buf,
> @@ -3533,6 +3535,7 @@ static struct attribute *nvme_dev_attrs[] = {
>   	&dev_attr_reconnect_delay.attr,
>   	&dev_attr_fast_io_fail_tmo.attr,
>   	&dev_attr_kato.attr,
> +	&dev_attr_dctype.attr,
>   	NULL
>   };

This attribute should not be visible to I/O controllers.

>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index fe224016418e..f8b60f7346fd 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -349,6 +349,8 @@ struct nvme_ctrl {
>   	unsigned long discard_page_busy;
>   
>   	struct nvme_fault_inject fault_inject;
> +
> +	enum nvme_dctype dctype;
>   };
>   
>   enum nvme_iopolicy {
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 855dd9b3e84b..82567d493c51 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -240,6 +240,12 @@ enum nvme_ctrl_attr {
>   	NVME_CTRL_ATTR_TBKAS		= (1 << 6),
>   };
>   
> +enum nvme_dctype {
> +	NVME_DCTYPE_NOT_REPORTED = 0,
> +	NVME_DCTYPE_DDC = 1,
> +	NVME_DCTYPE_CDC = 2,
> +};
> +
>   struct nvme_id_ctrl {
>   	__le16			vid;
>   	__le16			ssvid;
> @@ -320,7 +326,9 @@ struct nvme_id_ctrl {
>   	__le16			icdoff;
>   	__u8			ctrattr;
>   	__u8			msdbd;
> -	__u8			rsvd1804[244];
> +	__le16			ofcs;

this is unused...

> +	__u8			dctype;
> +	__u8			rsvd1807[241];
>   	struct nvme_id_power_state	psd[32];
>   	__u8			vs[1024];
>   };

