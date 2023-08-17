Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8869CC5479A
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 20:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hNGtJZdneBAl7lmjoJKJfKqjJmQbRHdxs25+V37yGMU=; b=Ep42nwQWaMPlDBB1FH+O+5djdd
	M/MMMp/hqpZ17mcQZGfjCBsuAroehnLnCy8poBzh7MECLR0c8zDOSj5/0z0VpvKZIeb2oiHuOGLa2
	g9BzIG4zf7CWMGSB56dGqf3bEeUQSMPFsXkcTnP+LXoIqIjjekBlCzi12rcGcs3SPD0oWitD3HTfH
	NqscxY2CTTxqX/Yidp4Uc5O7DmtQbY6ONfEWuBQm8UV6yPvmTznxl1qIUXStb57Kd3BxjnwYgJ00b
	iP4TEB160oWDuz1LyKCP11ubBxZTgUBg/GFoXbPsA4lUqitkeqZ6Ko7W+lzK2HdKDJsCi8dOHgALD
	pv5QThuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWjLn-0075Zn-2L;
	Thu, 17 Aug 2023 20:12:11 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWjLk-0075Yn-2B
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 20:12:09 +0000
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4103393a459so1800851cf.0
        for <linux-nvme@lists.infradead.org>; Thu, 17 Aug 2023 13:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692303124; x=1692907924;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNGtJZdneBAl7lmjoJKJfKqjJmQbRHdxs25+V37yGMU=;
        b=qtijS+kAIyJhoDDHHuS3IXqBZlLAEqaqlvI532/0qr9CavPwWxzK63EhH3jAWB8DG4
         9NVpnAyuObcdU93+4ih77DmbMUxDhJMdtEdWzsXVkFacOrcthozDLbl61X68O5WtxftD
         2rzGHuj00r2lfQL9Cna05nz1N8gaBZ4ENX1j66Bq/ulOtEoJj2PMfH92nDiB75ESEs8d
         Maovi32u5iK87aQ0SSJKHesYXr4Qybac9HQ7nUFZKBS6M041632GQLRxuXqitIq/0qbi
         n/MYOGTI9EaSVpcUmho8/W1xUKRaxWiq+AcbVyF5Jx2+nY1EYNSEEc9Dt/M8dhRXxYSm
         KeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692303124; x=1692907924;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNGtJZdneBAl7lmjoJKJfKqjJmQbRHdxs25+V37yGMU=;
        b=JmAp6Tq4M9VFLZ9h3kLu8/T0iz/4+VEpiG8p8Z0kSrqmENosGIHnEIlv3kifwEDd0L
         LGgNYWbyLKEKko55m0alo7J3k5Pb4VEDOhSXSvlOlqPw2YUnjtE8rfuRvM0+PL3pz3Nn
         rAgyd6MurN0z9ZZ4RTYs4nKUJPb1qDxJDp6ULod6j9bom8pGEu6TYmbASl++KWoYN8Y9
         tWp2EHnpLlhLsV8yJQEUPMDhNyOMD56AwRo7duy33OKcA+7zW/Ul0+s3s5S/KnsOGz8H
         Xwak+n20DQGPraQjSi7PbUupimO5Z13sD16wWPWg04qZSYpl9dhUdrhhy3z2noW8HKuR
         kC4Q==
X-Gm-Message-State: AOJu0YwcycYSDEffM67ImA0/FCJAijxF/ixPZ6muYR58LsiSSCansG80
	/cPdcfaawIu2/Z/J4ManD+kY4UUFlMk=
X-Google-Smtp-Source: AGHT+IHf9d/hQXut6UtZ2LXibhsWfxB/cKElGT5DWIaWUw+ybt1ugdvc+7IMQuTbQ64WVyIAmws2TA==
X-Received: by 2002:ac8:4e92:0:b0:40f:da50:4dbf with SMTP id 18-20020ac84e92000000b0040fda504dbfmr836007qtp.1.1692303124649;
        Thu, 17 Aug 2023 13:12:04 -0700 (PDT)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t17-20020ac865d1000000b0040ff0590fd2sm82366qto.87.2023.08.17.13.12.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 13:12:04 -0700 (PDT)
Message-ID: <87944825-9b33-4b2d-8ce4-812e770ad8bd@gmail.com>
Date: Thu, 17 Aug 2023 13:11:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-fc: Prevent null pointer dereference in
 nvme_fc_io_getuuid()
Content-Language: en-US
To: Nigel Kirkland <nkirkland2304@gmail.com>, linux-nvme@lists.infradead.org
References: <CACnqm78ssvRVay=Q5mPhsZaWvu5-LxASKs2Dv86NiVgGXytWoA@mail.gmail.com>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <CACnqm78ssvRVay=Q5mPhsZaWvu5-LxASKs2Dv86NiVgGXytWoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_131208_737296_57838B22 
X-CRM114-Status: GOOD (  15.16  )
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

On 8/17/2023 12:43 PM, Nigel Kirkland wrote:
> The nvme_fc_fcp_op structure describing an AEN operation is initialized with a
> null request structure pointer. An FC LLDD may make a call to
> nvme_fc_io_getuuid passing a pointer to an nvmefc_fcp_req for an AEN operation.
> 
> Add validation of the request structure pointer before dereference.
> 
> Signed-off-by: Nigel Kirkland <nkirkland2304@gmail.com>
> ---
>   drivers/nvme/host/fc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 1cd2bf8..a15b377 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1924,7 +1924,7 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
>       struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
>       struct request *rq = op->rq;
> 
> -    if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq->bio)
> +    if (!IS_ENABLED(CONFIG_BLK_CGROUP_FC_APPID) || !rq || !rq->bio)
>           return NULL;
>       return blkcg_get_fc_appid(rq->bio);
>   }

Looks good

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james



