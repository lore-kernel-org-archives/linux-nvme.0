Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27950C678D4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Mar 2023 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JbVvbxr1YVuANXXLDJmYx8XTK1pYLhN0auz+jVcRCsg=; b=L7iio4MB4rCuKuXcuSn58Z+Izb
	zF1VAhICgr3mt1FyCM/BxH+uLXMRmMlhVmTBDtJpIYLxGZT9VVU1rpTfQQA6uA0+O16juL5PteGtn
	nK1yJ3UKwMPp72QyzUiQgRLqYxoCp4OeVWK2q2zcuFBJzDSpvUKbEB16ptAFMksOOk9K78DjSp8ge
	f5BG1qWCHHXSJnGRpiErg9uX0a7yyVSVoDoNJ6NPA506tdkKBjo0GZoVws7CzRcwsefK9w0TkapmV
	1aH24oMtPCRJZY5Ldau2VqAtm0V9LWJfjVmNxU2KzmdMJWtt/stfxvAN1GEnEokYyVvE9TX7MEAVV
	DAi7yYZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZBH3-00D0Cm-2J; Mon, 06 Mar 2023 13:53:09 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZBGx-00D09a-F4
	for linux-nvme@lists.infradead.org; Mon, 06 Mar 2023 13:53:07 +0000
Received: by mail-wr1-f52.google.com with SMTP id e13so8859731wro.10
        for <linux-nvme@lists.infradead.org>; Mon, 06 Mar 2023 05:53:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678110780;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbVvbxr1YVuANXXLDJmYx8XTK1pYLhN0auz+jVcRCsg=;
        b=Hy7+HUGIaGsM6Wi34X31WhW4wdxkoeJsxnbu0SIgkCGmTd8jcnDDtfoxBfFeo6QZz4
         0ibChN1OiIpTdxr9AtWiW+zGk0QnEGd7OitCBLM9ZXZVirQKIi777rY369pHFBxiqTnM
         ZUM/ZL+5hOyUmtXVynZ5enVQC9ghE2nUpcJT9RjkrTvvU+WZIPYH7DYgK+sEKym4S9NW
         zI2nQIdpZF5lLgXbXpaW+KugZHt8Epf0LtBhyzCZGupwEeovhlP8S61S08llEF3xjFXt
         JmvfkMKVhzMfv0XdEu6+jqKVq4TNLxGH08mMeyUHxqaSkOItK5iE2Q0QaBlPWD3ezTQq
         JvXw==
X-Gm-Message-State: AO0yUKUghLLK8KON6FO081y4jq3tuM3WJf38WRaUdiqLA1+Fvc8CiO4e
	U2TYIcahoFdirbsvxAVGLze357XShro=
X-Google-Smtp-Source: AK7set+d+mhbgEZIrdLvFWp4ESSzPq0fg1vl4cH7daN8uUK6NDzLZRuUn3yvdtC8DHGlrouZW/R/Xg==
X-Received: by 2002:adf:eb42:0:b0:2c7:1b46:7b33 with SMTP id u2-20020adfeb42000000b002c71b467b33mr6216697wrn.4.1678110779666;
        Mon, 06 Mar 2023 05:52:59 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id w9-20020a05600018c900b002c5a1bd5280sm9894549wrq.95.2023.03.06.05.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 05:52:59 -0800 (PST)
Message-ID: <b0af3112-6f6e-809f-bac6-2a6e245b9245@grimberg.me>
Date: Mon, 6 Mar 2023 15:52:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] nvmet: Avoid potential UAF in nvmet_req_complete()
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20230306011313.99870-1-damien.lemoal@opensource.wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230306011313.99870-1-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_055303_599360_56BA66F1 
X-CRM114-Status: GOOD (  19.29  )
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

Hey Damien,

> An nvme target ->queue_response() operation implementation may free the
> request passed as argument. Such implementation potentially could result
> in a use after free of the request pointer when percpu_ref_put() is
> called in nvmet_req_complete().

Can you point me to which transport frees the request?

> 
> Avoid such problem by using a local variable to save the sq pointer
> before calling __nvmet_req_complete(), thus avoiding dereferencing the
> req pointer after that function call.
> 
> Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
> 
> Changes from v1:
>   * Added Fixes tag and cc stable
> 
>   drivers/nvme/target/core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index f66ed13d7c11..3935165048e7 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -756,8 +756,10 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
>   
>   void nvmet_req_complete(struct nvmet_req *req, u16 status)
>   {
> +	struct nvmet_sq *sq = req->sq;
> +
>   	__nvmet_req_complete(req, status);
> -	percpu_ref_put(&req->sq->ref);
> +	percpu_ref_put(&sq->ref);
>   }
>   EXPORT_SYMBOL_GPL(nvmet_req_complete);
>   

