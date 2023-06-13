Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26909C77B7A
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 13:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Uwyanm7aPiwT2URnmQPNCsZAs5PazOw3dHtU2QXV4w=; b=ue4yJQSLiP6PVOkIgLFXC9e6yl
	YeINcsy7Z/S/96VdDUG5Rv4L9Tz4jrcNZ5mmdbtzQnVM3BKulqe6wMc5hwhxZxSl8uvOliLYpS3qy
	4zpntYQkJh2wz3QIXZysnxjDcYxr3MYXgput/UmiLZQbaRZ7dzMkpHfNVUvGixjrNz7B7zPORKwYT
	Dud9nVjid3L1IDiX/TqwshPRtLtYj+Ol3/04189GXScYQTbu5a7ikIHOUy1WvgkOsqkPv1o4TkLiz
	QGYWeCF8dEm1sfUM1FytJ1LmeTYqwXzhUGNfbzmAogvGeuJiImMHXFVPki/BBkhfLy63gTwQykSi7
	Gui/iPqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q93sd-0089Wq-3D;
	Tue, 13 Jun 2023 13:16:16 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q93sZ-0089Vt-2j
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 13:16:14 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3f80cbc37c5so4740895e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 13 Jun 2023 06:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686662170; x=1689254170;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Uwyanm7aPiwT2URnmQPNCsZAs5PazOw3dHtU2QXV4w=;
        b=MdXEBnuE+i+gjaAPVuInbaaCZ8TRdA+dSkR9wNmUPfLHWuG7UvTAPIVKSu+UVeUpqf
         YxR+kCvpa8JWEfnuHP3jYO9nSff2PqSXiVeIfCydTvWGa/KrITw62EXCCpmoiXtALkXg
         0tESQ4AuMv6nE0fg8znvNkNCVVBNpkgWTfxGB4BkqA8xIDIjo/29DMVZkCItoyWscAs1
         CTbaCA+NmvgqCSinBvlFpAp7ydZvkEmdsgs9W2kSTBwukJ5gXmfL+aL1Ku3l2IBL6cW4
         +RosIjuqA3Daa9tkPY3jEpREMRAWXuQw4oPyyc16ecQ5futshr7HmRJJ9K4dWMz8blZh
         kQUw==
X-Gm-Message-State: AC+VfDxPxhb7+eOrpKY/27S9tIBWxkK5WUKfheP1RjCWxVFdYYrFLMqJ
	SOBTOpJKYaXEeLvQs/l94l91bi9LXUE=
X-Google-Smtp-Source: ACHHUZ4/nkf99jwi3l8QGzyAoS9Xa2Z1rJW5PmAhphkmb+ZabgH0B7a9IPE7v21nmrimuicMRIimVQ==
X-Received: by 2002:a05:600c:198c:b0:3f7:f2df:4e3e with SMTP id t12-20020a05600c198c00b003f7f2df4e3emr10021578wmq.3.1686662169762;
        Tue, 13 Jun 2023 06:16:09 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f24-20020a7bcd18000000b003f8cdb1414esm1679025wmj.8.2023.06.13.06.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 06:16:09 -0700 (PDT)
Message-ID: <1dfd132b-cf6e-6097-1977-2450b324ebf0@grimberg.me>
Date: Tue, 13 Jun 2023 16:16:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] nvme: core: unquiesce io queues when removing
 namespaces
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
 Chunguang Xu <brookxu.cn@gmail.com>
References: <20230613005847.1762378-1-ming.lei@redhat.com>
 <20230613005847.1762378-2-ming.lei@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230613005847.1762378-2-ming.lei@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_061611_883517_0953BF64 
X-CRM114-Status: GOOD (  18.83  )
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


> When error recovery is interrupted by controller removal, the controller
> is left as quiesced, then IO hang can be caused.
> 
> Fix the issue by unquiescing controller unconditionally when removing
> namespaces.
> 
> Reported-by: Chunguang Xu <brookxu.cn@gmail.com>
> Closes: https://lore.kernel.org/linux-nvme/cover.1685350577.git.chunguang.xu@shopee.com/
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>   drivers/nvme/host/core.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3ec38e2b9173..4ef5eaecaa75 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4692,6 +4692,12 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>   	 */
>   	nvme_mpath_clear_ctrl_paths(ctrl);
>   
> +	/*
> +	 * Unquiesce io queues so any pending IO won't hang, especially
> +	 * those submitted from scan work
> +	 */
> +	nvme_unquiesce_io_queues(ctrl);
> +

Looks fine, but I think that the removal of the unquiesce from
the condition below (CTRL_DEAD) should be done in this patch.

>   	/* prevent racing with ns scanning */
>   	flush_work(&ctrl->scan_work);
>   

