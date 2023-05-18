Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171AAC77B7A
	for <linux-nvme@archiver.kernel.org>; Thu, 18 May 2023 09:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4CE7SgB9eyt5DCErf+5OrHRvw6LcUlxEq6wa8t3tTKI=; b=haYW1Kj2vVp2hfODSLWHxfUT1h
	LooagPztrdfMDKNdGvHaOsw1Gcj4WHudm5DeqGJ0gGDQspRWlJ0l6PVGn2Uk1Q/EQN3sNKj/1d6Fj
	4h/MTxLXvxljPKDdMCAE/yZI6zmvpdVCNhmmuvLOPtNQclu3gz3e/+cUpcPWYbvKKfGMd41gSiQKc
	gp0uGEPYcSo3IvoDN5WtGnQ28PPZu/PDbW6ssyZSjjrOSCVXbOZ4w6x1avMxUW3VkAk/Fp0qxQ+TY
	T5v6wMnRUMecNJbzd7VlewiLIOsMvDEP1ebP2hYWnrmrJk8o5Iv0NKEaKToOYfJl5dpHd1OvBFvFy
	8nX2oDPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzZbF-00CPsN-1p;
	Thu, 18 May 2023 09:07:05 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzZbD-00CPr2-09
	for linux-nvme@lists.infradead.org;
	Thu, 18 May 2023 09:07:04 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-3f475364065so3652595e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 18 May 2023 02:06:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684400816; x=1686992816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4CE7SgB9eyt5DCErf+5OrHRvw6LcUlxEq6wa8t3tTKI=;
        b=k7s4rFaQOAyYyfv17BQYqv5nDj1I+Gp3XXTs3qbf8k5AAskDn5k+MbIfdZp2rbCrsL
         FICax68qwRgk0tuFyRMKG4iKDtz0qIpn4nquOUCfQKsMgbWJlM148kv4sm3ZbYOWzter
         K/oOxqBrbwmEB11iiCz0L1FI8uoIAaA3Top7YRMAYRneUSHJFQ1Z3nWqQ6qlBKcx4Scc
         bmTHLeDHCWgtgsfVcYIhErg7rusR6lrMJc5JUf6kH7rW+qGnr+lgj1YsI+QpocG4K60H
         wiE+4uTerhy5NBBcmExtfZGJpfS6Qu4UKrpwiyjqy6tXugDxJg9/kWXmapBqMPTK7/0F
         4kuQ==
X-Gm-Message-State: AC+VfDz8gURnPkpJzPlcOwNMDFnFPvJ936bPm8jLdY1UV4BhS9SjSSPb
	bPYBei9tT1GblBdef/RrwFp0LaE+PYI=
X-Google-Smtp-Source: ACHHUZ5pJ38Fj3huhRmAG8JrIqCZQV4S/Lp9YUEBP+ai/b3wonawoEnJbWWdU5S3WVBGbQg6sGaoKw==
X-Received: by 2002:a05:600c:3486:b0:3f4:e86b:798 with SMTP id a6-20020a05600c348600b003f4e86b0798mr4794852wmq.1.1684400815493;
        Thu, 18 May 2023 02:06:55 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c024d00b003f42813b315sm4607684wmj.32.2023.05.18.02.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 02:06:55 -0700 (PDT)
Message-ID: <76a74d3a-5a52-7ce5-460d-04c1bc613435@grimberg.me>
Date: Thu, 18 May 2023 12:06:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] nvme-core : remove redundant check from
 nvme_init_ns_head
Content-Language: en-US
To: Irvin Cote <irvincoteg@gmail.com>, hch@lst.de
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-nvme@lists.infradead.org
References: <20230517220915.7244-1-irvincoteg@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230517220915.7244-1-irvincoteg@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230518_020703_082693_E9119E9F 
X-CRM114-Status: GOOD (  15.59  )
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


> nvme_find_ns_head already checks that the list of namescpaces
> in an already existing namespace head is not empty
> 
> Signed-off-by: Irvin Cote <irvincoteg@gmail.com>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ccb6eb1282f8..54a8eadd9876 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4209,7 +4209,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>   			goto out_put_ns_head;
>   		}
>   
> -		if (!multipath && !list_empty(&head->list)) {
> +		if (!multipath) {
>   			dev_warn(ctrl->device,
>   				"Found shared namespace %d, but multipathing not supported.\n",
>   				info->nsid);

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

