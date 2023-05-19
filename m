Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7958C77B73
	for <linux-nvme@archiver.kernel.org>; Fri, 19 May 2023 02:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9gsigpjsY2ElnjSnXipR3QZI6+oyWrlwMu8uqxjNqhM=; b=mtXNAEeMXLNNSxYrjOkTOJz6hx
	zwOq923cDFzphVTdGbh9gmGEATUxgcq0NB7KDSuaSF7mGx4IDTW0n+4QOV1i0gxABWTSqunkPy+iG
	wUeSjHSew6xCRw9q022jMm/ChZBp8G8mLnh4ZFEDE0XKodzApRRvILi7d07snC9aShNEwvufF7pxJ
	L1VQqQHDhKjF4LTIrAUMaifGUH8VPNo9go2f701o5N3PprIM5aPKM+9PE9++KdnrZCrzsEPYdq2dC
	/7rkzNoquBs27PxihWSWElEGgjO7m7dGBOnMiA1WZbxb2I604L+HYNiScw8yjqSD3m+zOMB7/jfeL
	LGBTSbag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzpba-00Emxb-1U;
	Fri, 19 May 2023 02:12:30 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzpbX-00Emws-1Q
	for linux-nvme@lists.infradead.org;
	Fri, 19 May 2023 02:12:28 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae65e44536so2897115ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 19:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684462345; x=1687054345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9gsigpjsY2ElnjSnXipR3QZI6+oyWrlwMu8uqxjNqhM=;
        b=qtbtG+qO1WSSFmqEm2atI2OB530U/3+qDvSztsAaKKvYhIaJwYYIQShAEpwDYrKeJi
         9weuRpuoDObbjtloUB9aZ7nQALRr/tCvREpvNTQ9qmmcHrepTMkxmkGKTLx0DC3nLlhl
         ad8P1JIv5EoXlYizOZ3nrYk4LJ9KYvl7An0XOdr1Zpq7YLsGgUVsiPXvhLp5c8TB6lnd
         i23Iwje8QJU0xS98T3+rDOZgF3DIJnXhNVxJKkCGsYEtl/B5vwxZw60vIBbNIys5r8eM
         sBLhNrl93Z5ewvt1L7svXnV+AYxsf8z59lRi8Lv0ucAzY6e0wOy9VPDPTBTlJuvEvbFs
         kGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684462345; x=1687054345;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9gsigpjsY2ElnjSnXipR3QZI6+oyWrlwMu8uqxjNqhM=;
        b=Ymo0Z5SlytpDUpepPZ/Frm6KQnw/shBvVxLqK/CTLkCJyM0ibS4DeWCQgkWSGYM2+m
         Meinwlw/s3qUAZgq/bJkNS5VOSs+v6DE9cbbjm2moMnkijiwUoPWBU311w62OiAADBbZ
         7QM+n32J99mRLMAdzKAD9qLDB0N66s2h5j+RK0VhfjmxUDFi8YOIanQA/GNvfDpHMkHJ
         aMxs8NDNEJ0qpvf30wqZcEx0qhSmB1SgNNiijIZmW0WHKZkub4eNi40eHsF0oFNGW8Jj
         ckZijWeeVTC+rBJykp6vCKPS+h+vKB1m4HQTHjYNl6qVozM4GokMsvKREpQGkSxknIrI
         cAsg==
X-Gm-Message-State: AC+VfDzULQ0lKOt45RpoAZ40cX0gfo4O850BIpXvHiS/5VkOApQ00B1Z
	RikH3twcJTPy8r01wf1Zgm84Yg==
X-Google-Smtp-Source: ACHHUZ7D++qOb3lqkeFZGJC2fZXq3dl4S682iSWww75hVNXl0I+IXQ3mY+jvJshdRMbEK7O5bBk30A==
X-Received: by 2002:a17:902:dac3:b0:1ac:775b:3e0a with SMTP id q3-20020a170902dac300b001ac775b3e0amr1189572plx.5.1684462345672;
        Thu, 18 May 2023 19:12:25 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902680d00b001ac8218ddb7sm2178877plk.84.2023.05.18.19.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 19:12:24 -0700 (PDT)
Message-ID: <147b8893-10cd-27dd-eb48-3a5128de8f5d@kernel.dk>
Date: Thu, 18 May 2023 20:12:23 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] nvme-core: remove redundant condition in
 nvme_ns_head_multipath
Content-Language: en-US
To: Irvin Cote <irvincoteg@gmail.com>, hch@lst.de
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <20230518221054.56378-1-irvincoteg@gmail.com>
 <20230518221054.56378-2-irvincoteg@gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230518221054.56378-2-irvincoteg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_191227_503186_6EF34D7F 
X-CRM114-Status: GOOD (  15.52  )
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

On 5/18/23 4:10?PM, Irvin Cote wrote:
> head->disk implies IS_ENABLED(CONFIG_NVME_MULTIPATH) (c.f
> nvme_mpath_alloc_disk) hence the condition is redundant.
> 
> Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
> ---
>  drivers/nvme/host/nvme.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index bf46f122e9e1..7820e40cdce4 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -453,7 +453,7 @@ struct nvme_ns_head {
>  
>  static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
>  {
> -	return IS_ENABLED(CONFIG_NVME_MULTIPATH) && head->disk;
> +	return head->disk;
>  }

Might not matter for this case, but this changes something that'd
compile away for !CONFIG_NVME_MULTIPATH to now needing to read
disk->head instead. That doesn't seem like a good change.

-- 
Jens Axboe


