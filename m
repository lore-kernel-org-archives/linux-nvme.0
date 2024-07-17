Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA41CC3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 21:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tRvDoHBzspcJwnvfieZhJ4LEOAnRTJ6s3R+bLzHwW+Y=; b=ty4BQRIW2Yevo3lF9H1+4EQdSx
	erqmef9e++LACygGATNFYv2F2YFul1c1Y0O+sbjaXQ5qfi/WDNFgyD0I1dRfDxwMRgs4FrvbQJWrE
	zz/4el9P4BPTdYlneCvnB4kzH8Ays/oMbBTl8fyxDE+QKurYg4/4Du3WYeQ+K6BTqC0dKQZn6mZTZ
	mZoG5/0u25sPE+otBATwE7xAN4d4RzgjaFc94mSxOzQICo2AjpSuk26FxBKoO8JvcLmZHOBUbTeg+
	bpmODOk6wD2FzSrMH/1e95lScvMLQpO8UHzWs7sQNtxw3w01Oc5DsWJqm7G/6uWLDbDrm823l19Ud
	u/1c24tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCfM-0000000F2dI-2pUz;
	Wed, 17 Jul 2024 21:58:28 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCfK-0000000F2ch-2h1V
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:58:27 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4266ea4e4bdso115225e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 14:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253505; x=1721858305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRvDoHBzspcJwnvfieZhJ4LEOAnRTJ6s3R+bLzHwW+Y=;
        b=vAOauW02v3aBFECo6IzV22yxC+cQphJNRUQmkvNc42IeXllIrftKtha339h9DsBUy9
         9FObST5o6fCs2NE9+iF922dIfC/aLJT545yQ2VkEjBgJy9ttuMrffhjlQ7LNo9tfZHG4
         F9eWRMCOPHKg4GOuequ4rGdqpST/9h6/6XuKXhDlOd2ScCqAS5L3P6WYCxKvdMCOqyZ5
         UjQWACXhYPh1kGgEvsa3ASKfw2BHMkiA4RY6n0UPMumBBzO8vJ1ILjfiUPmHnxzblKhm
         DRmPWgn2f5ZUfNkSoIliQdYOuLeF38Ar+TyPLVjDEytuEg9olSOs3auyFXOITXMgyV33
         5a/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWebVLDYsiEBUy+c0bJyhoT9lRaGGLBAUHlu1jfrLkkUC9twf4fpykcoR4q+yOwX5353LIibwcMwEA2yttAAMz9OsuTf5W+SbIv1Fi10Uw=
X-Gm-Message-State: AOJu0YzhPd69SoKLYlc16DkOMuCaTZP3tbGBwzsrH8AsPnoUWdAa8rkx
	Li4+QLxMYV5K3QZRNKwV15caSyvVrxwzbWERVjygUA4iabkngLOS
X-Google-Smtp-Source: AGHT+IGXO6b0q/iQ60Joh2E23DcFGivyEzWymoEp0X5Ce5LAckvSl0g3AxRjybKDc3VaGUoxvxAnvQ==
X-Received: by 2002:a05:600c:314f:b0:427:9f71:16ba with SMTP id 5b1f17b1804b1-427c2d2003dmr13112785e9.5.1721253505083;
        Wed, 17 Jul 2024 14:58:25 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c7865f51sm11158295e9.48.2024.07.17.14.58.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:58:24 -0700 (PDT)
Message-ID: <e77a7fb7-f753-4a48-882b-ced61ba0c668@grimberg.me>
Date: Thu, 18 Jul 2024 00:58:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/16] nvme-sysfs: add 'tls_configured_key' sysfs
 attribute
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-6-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091031.143188-6-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_145826_711414_FC1B1088 
X-CRM114-Status: GOOD (  18.91  )
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



On 17/07/2024 12:10, Hannes Reinecke wrote:
> There is a difference between the negotiated TLS key (which is
> always present for a TLS encrypted connection) and the configured
> TLS key (which is specified with the --tls_key command line option).
> To differentate between these two add a new sysfs attribute
> 'tls_configured_key' to hold the specified on the command line.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>   drivers/nvme/host/sysfs.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index be36206cb594..e5cd738660b1 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -676,6 +676,19 @@ static ssize_t tls_key_show(struct device *dev,
>   	return sysfs_emit(buf, "%08x\n", ctrl->tls_pskid);
>   }
>   static DEVICE_ATTR_RO(tls_key);
> +
> +static ssize_t tls_configured_key_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	struct key *key = ctrl->opts->tls_key;
> +
> +	if (!key)
> +		return 0;

Shouldn't this check move to the are_visible part so it isn't visible if
tls_key is not provided?

