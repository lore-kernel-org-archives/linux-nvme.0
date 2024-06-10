Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41542C27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 19:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RzcwVjd3wuF7qA5HimwlYDFzQ23qzUuT3/7uHPghCl4=; b=H1UIGCHew2r/qqea+MqQ9p8S1j
	f/gLn9vvF4Xo2M+LOFKV+cHw7rwkKTGgpq83AMqtUB9hGE7f8NpUuNpLnz1dyvfzvnufOGc1I1xgj
	l6JdIWXQHH4TU7Ob4TiH4qaWQnPbSDr1Gf+i5KpwXugtvcy0OO8edP3p90TtASTLsfIlUOp8Xfndl
	k5wK6DDapSPN/B8cN9vcw3CYsaXaWHM0nNweQreRE+ECCw4s89jX8xjlfTFE/5jjDYpLUHyILKnw+
	TKE7VC/2sOClWYffVlIW+0aKyipITAP758RV1dKNaK6ywBkMQbWubhs5mbdNnJLI00Nc4O+2T0TGF
	mpks/4vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGkKL-00000006DJx-42fr;
	Mon, 10 Jun 2024 19:05:09 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGkKJ-00000006DIV-24eh
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 19:05:09 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4223427513eso294585e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jun 2024 12:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718046302; x=1718651102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RzcwVjd3wuF7qA5HimwlYDFzQ23qzUuT3/7uHPghCl4=;
        b=tzT6d7ESUWcZ3Q0aZ98UZqDnQl86qXGhaIIeQQFctGgdG9I1tSsZ1h4wXJPalxUF97
         L+qeaGQKY52LdMMQNgSSFOF/ARAo8a31EF3D3FVFA1VmGcWq2QwrwnwI2Q+p8OPEAGF4
         3wJbpnVMEc7L7EREUj43h7a+bbvO2uaBhweef5/c8YpteopEEcc4Ls0XlS/cE3/z0VxA
         ys0fJBzOxHklCPr0h5l25JX6yZUpcbF3zCH7FRuGyR10Zwq4PpTPXHZs4ZxOz4uNINFZ
         zF2/iXnzzgz3FKxlB3ZamTGfqdGt6peRRU4r5Lkb3MX8oJgvIkos9cC2GSXmkLjVA8QI
         tXQg==
X-Forwarded-Encrypted: i=1; AJvYcCVX07/OfGHgB/gWoUtZ9XB6a0VAanHPCI4mag1KvbP1B3FaKXSnRokLemTjNwJ1zK2m4y5uz7ck29RQa13d8sq6BV/CpRHlvZtqifDe0xo=
X-Gm-Message-State: AOJu0YwhKiSCUuEdSw8R+l71gBeZhwrLv2UKN98p5AoPpMYXSOMKRBV/
	YAuRy7N2CNaPd9Og3X8HeyMIGW5eSPRqmgRnhFylv2QH08GJA7T0dSeaNEMo
X-Google-Smtp-Source: AGHT+IEvwv08TmpZPro//md103k727X8OXUPGA54WdjDUCV07StJHAMkwZJmFcCstU1jB4eMBih7gA==
X-Received: by 2002:a5d:526a:0:b0:35f:1412:fa8a with SMTP id ffacd0b85a97d-35f1412fcddmr4011456f8f.1.1718046302401;
        Mon, 10 Jun 2024 12:05:02 -0700 (PDT)
Received: from [10.100.102.74] (85.65.205.146.dynamic.barak-online.net. [85.65.205.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0f2b0d85sm7800267f8f.42.2024.06.10.12.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 12:05:02 -0700 (PDT)
Message-ID: <e8fa4c36-49e5-40b8-9cea-6b3b61aa3240@grimberg.me>
Date: Mon, 10 Jun 2024 22:05:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel OOPS while creating a NVMe Namespace
To: Keith Busch <kbusch@kernel.org>,
 Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, sachinp@linux.vnet.com
References: <2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com>
 <ZmdLlaVO-QUug5aj@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZmdLlaVO-QUug5aj@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_120507_680074_9D0589BB 
X-CRM114-Status: GOOD (  16.07  )
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



On 10/06/2024 21:53, Keith Busch wrote:
> On Mon, Jun 10, 2024 at 01:21:00PM +0530, Venkat Rao Bagalkote wrote:
>> Issue is introduced by the patch: be647e2c76b27f409cdd520f66c95be888b553a3.
> My mistake. The namespace remove list appears to be getting corrupted
> because I'm using the wrong APIs to replace a "list_move_tail". This is
> fixing the issue on my end:
>
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7c9f91314d366..c667290de5133 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3959,9 +3959,10 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>   
>   	mutex_lock(&ctrl->namespaces_lock);
>   	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
> -		if (ns->head->ns_id > nsid)
> -			list_splice_init_rcu(&ns->list, &rm_list,
> -					     synchronize_rcu);
> +		if (ns->head->ns_id > nsid) {
> +			list_del_rcu(&ns->list);
> +			list_add_tail_rcu(&ns->list, &rm_list);
> +		}
>   	}
>   	mutex_unlock(&ctrl->namespaces_lock);
>   	synchronize_srcu(&ctrl->srcu);
> --

Can we add a reproducer for this in blktests? I'm assuming that we can 
easily trigger this
with adding/removing nvmet namespaces?

