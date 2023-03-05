Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11347C61DA4
	for <linux-nvme@archiver.kernel.org>; Sun,  5 Mar 2023 14:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=geFdp2UubaJNFNJRsyrlz0hvXM0Q7suzvvy0rmJkujw=; b=prtmYQ7sJ+PGhqfPM/E2WSgrA+
	seKlM9QAiKPEUYyv4y6QPzdaL5YF1rFC71lZW/zIMzKQYq4iAc2uJJPAl+eHRsYJksdr3+WLA7yit
	FirSqyyEO3XW/j61IWR4mls+r1VS+I/xflJmUjd2ejxAFAt7PwGYSRQYOKA+zSargQe8uda84lIRW
	lMM2WaktR8k8yDihORHoDmKrSZs51ibbwSuGQp/AjxyfQ94x5FNenqGoIwX3R5CXnSCmrUmmNT1iA
	bH6AVm/IlOK2rsZsjV5GtA7H2/8otMEe8Vdg0qHaQqakzvwwgiavxt5MAA9FjD90TVRqn1UwzR/gL
	GTlGO7jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYpZb-00AMfl-80; Sun, 05 Mar 2023 14:42:51 +0000
Received: from mail-pl1-f173.google.com ([209.85.214.173])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pYpZX-00AMfP-I4
	for linux-nvme@lists.infradead.org; Sun, 05 Mar 2023 14:42:49 +0000
Received: by mail-pl1-f173.google.com with SMTP id a2so7520852plm.4
        for <linux-nvme@lists.infradead.org>; Sun, 05 Mar 2023 06:42:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678027365;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=geFdp2UubaJNFNJRsyrlz0hvXM0Q7suzvvy0rmJkujw=;
        b=RVBlOgvOPJYDf9FwbYFnPaa5nhA8SPY05N/MOwNBEVpcYZqogeAu8vYj4hpIDQMKIE
         XWZweafIgP2ehYSalgalD4B/Rll5y2UIl1vL6LTwsHWzqN9ycFUIY9BqAIK9TX5ZgapM
         X0jkUBR7Fa9dwWZWpwtaOKal1r5MCkXjNc1ZJMFAQGqcVepeTzB2iJ0EBn2979e4Bv51
         y4+tQH/oAl3zP5pWVYVrmfkxTXYxPK3VU3HmgJEetY1hpIsozu9m82vY8jWCCxdH8iKi
         DmCIRLAdBNyPIs6kNQJvd6+xtovig2xwKrzs4FT7TG3Yo7ImvsHF8mGHmGAsYiHWeHet
         R4aQ==
X-Gm-Message-State: AO0yUKVb55v5DUN4V+F9aS0r1i96vqgH5Y9aAJsN7/p5bQpv9fBJndV1
	g6wdtR/PhgraEMiWJPmDd5s=
X-Google-Smtp-Source: AK7set/wBkGhiJThybY6SdXq3IlEQiw/wLVUAxasJb2gIGIKlPDHoHQ8/d4RyK+T531dDgZAd59rIw==
X-Received: by 2002:a17:902:da86:b0:19e:31a3:1a7e with SMTP id j6-20020a170902da8600b0019e31a31a7emr9205554plx.69.1678027365340;
        Sun, 05 Mar 2023 06:42:45 -0800 (PST)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id i1-20020a170902c94100b0019acd3151d0sm4818908pla.114.2023.03.05.06.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 06:42:44 -0800 (PST)
Message-ID: <8d5f03aa-6166-6cbf-3287-86328d710df9@acm.org>
Date: Sun, 5 Mar 2023 06:42:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] nvmet: Avoid potential UAF in nvmet_req_complete()
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20230305050733.4768-1-damien.lemoal@opensource.wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230305050733.4768-1-damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230305_064247_651517_E8EC95CB 
X-CRM114-Status: GOOD (  15.75  )
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

On 3/4/23 21:07, Damien Le Moal wrote:
> A host ->queue_response() operation implementation may free the request
> passed as argument. Such implementation potentially could result
> in use after free of the request pointer when percpu_ref_put() is called
> in nvmet_req_complete().
> 
> Avoid such problem by using a local variable to save the sq pointer
> before calling __nvmet_req_complete(), thus avoiding dereferencing the
> req pointer.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

How about adding a Fixes: tag?

> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 597d1b2c0d52..0f9193323a02 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -758,8 +758,10 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
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

Interesting. The above patch looks similar to "[PATCH] nvmet: Fix a 
use-after-free" 
(https://lore.kernel.org/linux-nvme/20220812210317.2252051-1-bvanassche@acm.org/). 
One could wonder whether there are more occurrences of this pattern?

Bart.



