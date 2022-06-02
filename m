Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA75C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jun 2022 08:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+CQLLLj3K4jEUZhxxzSnmaV/7Y7tTveTs0ApYcM5FcE=; b=rJhKhmvKC7e1RZXUP6sSRP9H2q
	+9/MW28GTftC6mVDQ9DC28L30pIN+QCEEQmpS1X48COJQHAxxVBBxGEjD/JsZKq/HHq8YkhvI6zyd
	rFoSjQxt5ES6T7y6BaNTiWTFzGd/djCmoMtKxBEcoTOcBPNJeXRq5lQ6vOaHUmkjmETS+e6tSroqa
	+XsqRQyxlUfCdmicTNTtyPnpgVgvnAaH09XaZVZer6VCc9BFGLkfVzneghpxs92fZVbzenoGcS282
	74ITy7D8+a4iw8dB7RRkOEckpHyo5pd71d/iLB93WB65f3PP8rg58HMS5wEkERbJRellUYeAnqyp6
	6tCFGsCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwgYO-002HeF-S2; Thu, 02 Jun 2022 08:51:40 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwgYM-002HdF-Ee
	for linux-nvme@lists.infradead.org; Thu, 02 Jun 2022 08:51:39 +0000
Received: by mail-wm1-f52.google.com with SMTP id 67-20020a1c1946000000b00397382b44f4so2404196wmz.2
        for <linux-nvme@lists.infradead.org>; Thu, 02 Jun 2022 01:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+CQLLLj3K4jEUZhxxzSnmaV/7Y7tTveTs0ApYcM5FcE=;
        b=GdsPBYs2W5LvE/yi76GnBNQNYtDb/duRafYmY9In52FUDFTnLhDYRYQ8zV2Zkx0LxF
         A6PXsBKMqATAfiijlo5e3GVIRIh4eClmaT4weuOXmVDDpZ+gdSVmN13InXr0DJNbMe+r
         SYlLsN5X5gK+BNyBP7yNyYcRg5JW6Le02JejWtHtLqr8+zpgBK6V6s7KvIIitNZuzP+N
         yba7pGfk4DYluO6jndbRSHJoRAy7fWNpo//RYrjfMZEA3dMoMCgeA8lgr6XM8Pr/McyY
         /wWqbv0fGWPeho+wCDrA3pJCODDGhI8zbTu7IAvkQUrBAr9yN7l2E55BERgoEX+DTo4U
         q+4g==
X-Gm-Message-State: AOAM530kZ+8rXhBlx9oiNNiPfBukt+Yr62oYn/E+Ud9Bf8Rw4XAhfeOH
	RM6VhO3vXR5BRrqEOUlhKlU=
X-Google-Smtp-Source: ABdhPJxJ18/srXiU1HIWNCcy+wdkRS4cr9ZYuEgWiFwTHFGvOmLOzNgRVeltPV0U1sf83nuK+gL6Ww==
X-Received: by 2002:a7b:c3cc:0:b0:39c:35f4:9544 with SMTP id t12-20020a7bc3cc000000b0039c35f49544mr466623wmj.180.1654159895938;
        Thu, 02 Jun 2022 01:51:35 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c215500b003973e8a227dsm7499647wml.46.2022.06.02.01.51.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 01:51:35 -0700 (PDT)
Message-ID: <da0cfe3f-115e-0ecf-74de-ff18c5099da3@grimberg.me>
Date: Thu, 2 Jun 2022 11:51:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] nvme-core: fix oops in dhchap_ctrl_secret_show()
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org
References: <20220602014504.7873-1-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220602014504.7873-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220602_015138_538859_7A689E57 
X-CRM114-Status: GOOD (  20.02  )
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


> In current implementation when we try to disconnect the subsystem
> that doesn't exists nvme_ctrl_dhchap_ctrl_secrete_show() ends up in
> OOPS:-
> 
> RIP: 0010:nvme_ctrl_dhchap_ctrl_secret_show+0x16/0x40 [nvme_core]
> Code: c6 78 a1 16 c0 e8 5a ad 2d c1 48 98 c3 0f 1f 80 00 00 00 00 0f 1f 44 00 00 49 89 f8 48 89 d7 49 8b 40 78 48 8b 80 98 0b 00 00 <48> 8b 50 68 48 85 d2 74 0f 48 c7 c6 46 a0 16 c0 e8 25 ad 2d c1 48
> RSP: 0018:ffffc90000f3fdb8 EFLAGS: 00010282
> RAX: 0000000000000000 RBX: ffffffffc01731e0 RCX: 0000000000000000
> RDX: ffff888104b44000 RSI: ffffffffc01731e0 RDI: ffff888104b44000
> RBP: ffffffff822f7380 R08: ffff88810274a2b8 R09: ffff8881782fbdb8
> R10: 0000000000020000 R11: 0000000000000000 R12: ffffc90000f3fe80
> R13: ffffc90000f3fe58 R14: ffff88817f0944d8 R15: 0000000000000001
>   ? nvme_subsys_show_type+0x50/0x50 [nvme_core]
>   dev_attr_show+0x19/0x40
>   sysfs_kf_seq_show+0xa8/0xe0
>   seq_read_iter+0x11c/0x4b0
>   new_sync_read+0x106/0x180
>   vfs_read+0x138/0x190
>   ksys_read+0x5f/0xe0
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fdeccbdf702
> Code: c0 e9 b2 fe ff ff 50 48 8d 3d ca 2a 0a 00 e8 b5 e8 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
> RSP: 002b:00007ffe0dfb4f28 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> RAX: ffffffffffffffda RBX: 00000000017df780 RCX: 00007fdeccbdf702
> RDX: 0000000000000fff RSI: 00007ffe0dfb4f30 RDI: 0000000000000003
> RBP: 00007ffe0dfb4f30 R08: 00000000017df9f0 R09: 00007fdecccb1a60
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
> R13: 00000000017e75a3 R14: 00000000017df760 R15: 00000000017e75a3
> 
> Add guard to make sure opts is not NULL in the
> nvme_ctrl_dhchap_ctrl_secret_show() to avoid the OOPs.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 5bdeb7134ede..3df8e6bef589 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3671,9 +3671,12 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
>   	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>   	struct nvmf_ctrl_options *opts = ctrl->opts;
>   
> -	if (!opts->dhchap_ctrl_secret)
> -		return sysfs_emit(buf, "none\n");
> -	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
> +	if (opts) {
> +		if (!opts->dhchap_ctrl_secret)
> +			return sysfs_emit(buf, "none\n");
> +		return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
> +	}
> +	return 0;

Shouldn't this be filtered as non-visible in the first place?

