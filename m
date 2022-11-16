Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E583C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 13:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fMd1kO06B9o+R7iODyIHsZe10EhEo7D6gkrttEWbwfg=; b=yn+rcVxq6k5fylh9SPj3A2Bw4b
	PDpmypjsJ94J6VDH4aIzUQd1+2Zsc75eek5DHgYCLaa7XbPb8kuOwzghAjMzF/B/XdbcjRUs/04BC
	WIP696sSVLchEDX8Px1+zQO6eIt/kZfaX7xaQYfM1y1It0tyPIbvgdqlJFD75froXbh72Ee/vNAT5
	lbsDoH0aVb8QZ9XxTDKq6jt/qAplwwyvGOYYUeg2NYH64ZkRFWJoqDHMRJo1cBGAUHHv5bBl4OS5D
	zMytMZSMKw18SspQQ8bOJnPUshQF3uY5LQnoz/Vzr0JoMs+XF/gz7K4TMNADRkHnRWVEaS7SiOskw
	ipiEElmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovILD-003pMi-NC; Wed, 16 Nov 2022 13:20:35 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovILA-003pJP-29
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 13:20:33 +0000
Received: by mail-wm1-f45.google.com with SMTP id r127-20020a1c4485000000b003cfdd569507so572561wma.4
        for <linux-nvme@lists.infradead.org>; Wed, 16 Nov 2022 05:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fMd1kO06B9o+R7iODyIHsZe10EhEo7D6gkrttEWbwfg=;
        b=gGGO0stMWKSbU36Veh/LP6qwwtxhE3pV5sxguMxgnXuca1Qg5iYQi53MKoEmBEreUL
         hL9+VpBfbbdMq1PxKMzUWzlN5213KfjFug5/lNZNBxvBApUfLyBgA23iF5B3PYqk7H6i
         tl17Q4xyMR9sULbK6oxliH3k+SpdK8NJM/0Rr5c6JLPCO9rYB5/XyfBDPiAqMWomL0Ui
         aSkImzcdF5AENL0YJXGXvbUhFgcfOCbTMjPk3pHy+tznNCWjIVsw8KDZ2Yokpa1yuTUR
         sX83/2/B6hIGWT2f8gjslwssMOPpV5CvQiDLgl9xucw2TZPaMOQm9nnP/w9OWXVV+Fro
         5rkw==
X-Gm-Message-State: ANoB5plHH8aH+5oZPoCY/LP8d8+f2L0ggxhw1bkisyCK9+LBDCloCz5z
	Zf6inuJxPiAjAp271jlfjk5PW4L13ko=
X-Google-Smtp-Source: AA0mqf7Xs3/SS6o/qN1MZvQ3+Ktty3kblVEO0XrVvlZ8lq5oifO8IdgCvp8IZAmnMvHoLEtjiWfvyA==
X-Received: by 2002:a1c:2b05:0:b0:3cf:7126:1fd0 with SMTP id r5-20020a1c2b05000000b003cf71261fd0mr2064168wmr.14.1668604826128;
        Wed, 16 Nov 2022 05:20:26 -0800 (PST)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id hn3-20020a05600ca38300b003c6c1686b10sm2051126wmb.7.2022.11.16.05.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 05:20:25 -0800 (PST)
Message-ID: <e5de54b2-4906-9902-c150-732718a77571@grimberg.me>
Date: Wed, 16 Nov 2022 15:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvme: don't call blk_mq_{,un}quiesce_tagset when
 ctrl->tagset is NULL
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: lengchao@huawei.com, linux-nvme@lists.infradead.org,
 Gerd Bayer <gbayer@linux.ibm.com>
References: <20221116072711.1903536-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221116072711.1903536-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_052032_134113_DED27B69 
X-CRM114-Status: GOOD (  19.73  )
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



On 11/16/22 09:27, Christoph Hellwig wrote:
> The NVMe drivers support a mode where no tagset is allocated for the I/O
> queues and only the admin queue is usable.  In that case ctrl->tagset is
> NULL and we must not call the block per-tagset quiesce helpers that
> dereference it.
> 
> Fixes: 98d81f0df70c ("nvme: use blk_mq_[un]quiesce_tagset")
> Reported-by: Gerd Bayer <gbayer@linux.ibm.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
> It turns out we have a bunch of other quiesce calls that can happen when
> only the admin queue is live.  So bring back the original quick fix to
> check for the tagset pointer in the quiesce helpers.
> 
>   drivers/nvme/host/core.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3195ae17df309..fd2e26cb7a688 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -5215,6 +5215,8 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
>   
>   void nvme_quiesce_io_queues(struct nvme_ctrl *ctrl)
>   {
> +	if (!ctrl->tagset)
> +		return;

Can this be placed in the pci code instead?

>   	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>   		blk_mq_quiesce_tagset(ctrl->tagset);
>   	else
> @@ -5224,6 +5226,8 @@ EXPORT_SYMBOL_GPL(nvme_quiesce_io_queues);
>   
>   void nvme_unquiesce_io_queues(struct nvme_ctrl *ctrl)
>   {
> +	if (!ctrl->tagset)
> +		return;
>   	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
>   		blk_mq_unquiesce_tagset(ctrl->tagset);
>   }

