Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C7CEB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 09:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wr3IYtJWcHjEY6gENl5GBD+7khviAKxDTeSYJJa5iLo=; b=E37dsl5csq2wZwJJGblkADTeKV
	P1XoIxDUpqFXVumApKzFAw3kXl+er6/V0/gtehVVrsltUPjxPT1Z+GWYnmsNCSC3XOXdaksoXa2eO
	fVZrjMo86Td0WnYf4zBiu4ZkF2LNI09SMQV37sFLSHpFXGym0sotR7fP3dqEPtJ4hmT8ePOjeID4Y
	a7gZRaPTqw0nU3ggDzy/0sf8DG5sgqGmJvsESY6pK/pV6IN5LAbzSAdEqqsf+SJ+6+l+1txtN5Gsh
	imiOgtQvvDfqpcRa82vpCB73V1OE1Kq9uSyQNQsKWYWMYfYcKVTVsr7zkhojoJd8PfT9xApRpST45
	EqHhhS1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTfml-004TIQ-2b;
	Wed, 09 Aug 2023 09:47:23 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTfmi-004THo-0V
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 09:47:21 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-3fe4f3b5f25so9453495e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 09 Aug 2023 02:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691574436; x=1692179236;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wr3IYtJWcHjEY6gENl5GBD+7khviAKxDTeSYJJa5iLo=;
        b=LdnPz2fQfKGd8aJZNI+SXehyacWPvBOJJ1O+wIxBNQrHAdTjji4dsnAfK917g//r8g
         FRPQWhmFjhJhYSyl87F7+R6F2xnxfFqHZ5lc0KPAuoZWIWy7uMLECqJ8+MGE9BtRTOeR
         SVq46HGNKc9g89IUWhURXiyWrbDHNV6sXdFkWMVkN7/0SomOaDueEqsh37KXpxg7zqj4
         Lhv+El/BniD6VfxIrpvi56q0zmY/3q1Lj+LP13DIO4ykz/Ja33UhVR4zM5ii17GwHWBv
         1QfCG+xfsCnlsNvkHXEE6zih+5MVirFm5AMhYtco/8WSSUMJC+Q0drod6b9YQRczVedu
         4h3w==
X-Gm-Message-State: AOJu0YxYNopkGxmxkKKgySSxeNt5gbw4kUHx3R/VcL2XNkxfc/mm7JIS
	HCQ2sAv15yb4zXYD9YqRyo8=
X-Google-Smtp-Source: AGHT+IFq0kUT5tXKgse5oxpFOiqL8hR0GQXemoHPdm3H64GAYqx+ZdbbnUB6/kc0A/kDrc87tceCsw==
X-Received: by 2002:a05:600c:1d19:b0:3fe:21a6:a18 with SMTP id l25-20020a05600c1d1900b003fe21a60a18mr1857178wms.3.1691574435683;
        Wed, 09 Aug 2023 02:47:15 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z4-20020a1c4c04000000b003fe11148055sm1428411wmf.27.2023.08.09.02.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 02:47:15 -0700 (PDT)
Message-ID: <8f7dd2b5-bc7d-5c2f-a807-ee18e809b3a7@grimberg.me>
Date: Wed, 9 Aug 2023 12:47:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/16] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20230808165354.123499-1-hare@suse.de>
 <20230808165354.123499-9-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230808165354.123499-9-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_024720_364892_0722DB40 
X-CRM114-Status: GOOD (  16.21  )
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


> @@ -1802,9 +1922,17 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   {
>   	int i, ret;
> +	key_serial_t pskid = 0;
>   
> +	if (ctrl->opts->tls) {
> +		if (!ctrl->tls_key) {
> +			dev_err(ctrl->device, "no PSK negotiated\n");
> +			return -ENOKEY;

This is really unexpected. its not that no PSK negotiated, something
went awfully wrong if the psk wasn't negotiated and we still end up
being here... Or there is a flow that can make this happen?

> +		}
> +		pskid = key_serial(ctrl->tls_key);
> +	}

newline missing.

key_serial can operate on null.

>   	for (i = 1; i < ctrl->queue_count; i++) {
> -		ret = nvme_tcp_alloc_queue(ctrl, i);
> +		ret = nvme_tcp_alloc_queue(ctrl, i, pskid);
>   		if (ret)
>   			goto out_free_queues;
>   	}

Perhaps do:
--
@@ -1793,7 +1793,7 @@ static int __nvme_tcp_alloc_io_queues(struct 
nvme_ctrl *ctrl)
         int i, ret;

         for (i = 1; i < ctrl->queue_count; i++) {
-               ret = nvme_tcp_alloc_queue(ctrl, i);
+               ret = nvme_tcp_alloc_queue(ctrl, i, 
key_serial(ctrl->tls_key));
                 if (ret)
                         goto out_free_queues;
         }
@@ -1812,6 +1812,9 @@ static int nvme_tcp_alloc_io_queues(struct 
nvme_ctrl *ctrl)
         unsigned int nr_io_queues;
         int ret;

+       if (ctrl->opts->tls && !ctrl->tls_key)
+               return -ENOKEY;
+
         nr_io_queues = nvmf_nr_io_queues(ctrl->opts);
         ret = nvme_set_queue_count(ctrl, &nr_io_queues);
         if (ret)
--

> @@ -2631,7 +2759,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
>   			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
>   			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
>   			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
> -			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
> +			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS,
>   	.create_ctrl	= nvme_tcp_create_ctrl,
>   };
>   

