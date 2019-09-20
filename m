Return-Path: <SRS0=jFtc=XP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA19C3A5A2
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 18:16:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6503220644
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Sep 2019 18:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hRuZBMLs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6503220644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HGH4QWXQE16zD+qS9IdCs6Cx4yMsu4KyZxXvq1sB+hM=; b=hRuZBMLsk2GR3K/X/MKPLzyW+
	TkzWhtxhAf3CaVdUDKUFiVxZv1Wn9P8bgCHlmw26s4fB53TojcRlep0RlSKUETC9fJxgSuFEqKEL8
	ULDDYyJwU7/Ia8J2H45jqjOOvoOwm1RMlaV0Kkg0STmnC0qdWeoikjBA9svzzptOS6U0iPrdXLT2Z
	vuguCg2JLvt4YmkpWj5HhTxtwQmVqV8BuOR8711V9lJL0DF8KpvNA09OPZjLMzXXCaYE6aC4DWj1X
	ufa/yaGn7TQIcnMT8o3BXQwv/mWzQKljDJDdABmVq/tvW4s5uH+rx7MJnc2gDxipsdro7Od/YWGW4
	MJFV3oIRg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iBNRu-0006NF-1i; Fri, 20 Sep 2019 18:16:06 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iBNRr-0006Mu-LF
 for linux-nvme@lists.infradead.org; Fri, 20 Sep 2019 18:16:04 +0000
Received: by mail-wm1-f65.google.com with SMTP id i16so3509334wmd.3
 for <linux-nvme@lists.infradead.org>; Fri, 20 Sep 2019 11:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ws6fQ/EZAp+PL0K/m2aKUQt9fg7c07JjwcSzBqwr/yw=;
 b=MQ2sjGyTnT6WmcotKFcLUVrbEWGRrdNoF+KckF5M1MKyh0xsiXFbMp9aQx0MQrKoBb
 cA5YMeGANpV7RcQzR6MSbPFdJE/z3O5UZ84FZSnmrNo/iaeOibKfzV1/QtTxzaiCaGg3
 L8Owsls0OHXD+P/yJuUw5o8un7udNzsK/XXoZoym3Dm9ytGOZ1InrIWs2My0nu7dxYdW
 ujd66gE9m2GTfwaZtLMHeMk1dge8fya3nu0Wvl06futvALunBPJpP21e48GI3KMeAuKv
 63Zq70WAM1Xj2zDrE4g0JiPOY8yVHUxzzKmrLXrof7PQFEx/ZOtOeBMbdm/tY7q6OTxE
 3L0w==
X-Gm-Message-State: APjAAAX1aXjKMGOctC0pYXM7HOLjiaM3718SVFtdhIb9FILYaz/2hJAE
 7MQCD8B115Mrr6zrS1IU3yQ=
X-Google-Smtp-Source: APXvYqzCfSUtDz4NLwJJBelbIBHUWSbVXIWUa/BUKwzTqWBwHItM9U5RCcgU+9Vs+Fkl/hVmtaCocQ==
X-Received: by 2002:a1c:4085:: with SMTP id n127mr4670332wma.68.1569003362125; 
 Fri, 20 Sep 2019 11:16:02 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id l6sm3298478wmg.2.2019.09.20.11.16.00
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Sep 2019 11:16:01 -0700 (PDT)
Subject: Re: [PATCHv2 4/6] nvme: Introduce nvme_reset_continue
To: kbusch@kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <20190919213431.7864-1-kbusch@kernel.org>
 <20190919213431.7864-5-kbusch@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ca4829a1-0ae6-c9ed-8506-cc0f72c5ba84@grimberg.me>
Date: Fri, 20 Sep 2019 11:15:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919213431.7864-5-kbusch@kernel.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190920_111603_698344_F4DA86DE 
X-CRM114-Status: GOOD (  15.85  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Edmund Nadolski <edmund.nadolski@intel.com>,
 James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> ---
>   drivers/nvme/host/core.c | 12 ++++++++++--
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e03b1765fc01..95b74d020506 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -117,14 +117,22 @@ static void nvme_queue_scan(struct nvme_ctrl *ctrl)
>   		queue_work(nvme_wq, &ctrl->scan_work);
>   }
>   
> -int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
> +int nvme_reset_continue(struct nvme_ctrl *ctrl)
>   {
> -	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
> +	if (ctrl->state != NVME_CTRL_RESETTING)
>   		return -EBUSY;
>   	if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
>   		return -EBUSY;
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(nvme_reset_continue);

Would it be useful for you to have nvme_reset_continue_sync variant?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
