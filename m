Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B77AC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 12:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=Yo17Z9B6ddTVkI7CI5f9wzcxH6
	zpQcEmYGb3OpWf7DAwVuxAtzoWpc3wtpiEUJXPZjL1wZKqfjvxsPEoNTQBfoFFDdHp5OisM8u/hdt
	dxkmzvDqWUG/h9cujkuXSmZkIa1jNySaC69bG0a7GIlMXsV/LNRuV16Xz0gSgFCSJxU0T+R3AsSVA
	DHFamefnWql8emLp0YGZG7JvGjAsKQpwkfhmgv9kIfuXFB4u/Tp+OF3GAPGufmLF39Ccdo1mhR6Wq
	V4+S+MipK4VEjkcmPXsYPnrfMuzDw84CbkrMpSpedx0bIIfYYdIQAO7Vefz3MRvNTOp4f3O2C8gxn
	xpRq6DwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTNZm-002leB-59; Sun, 13 Mar 2022 12:43:58 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTNZj-002ldc-HF
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 12:43:57 +0000
Received: by mail-wr1-f42.google.com with SMTP id j26so19875613wrb.1
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 05:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=HLSZD6Z6iK7KSALCKDYQfVYpLBxevB55dsi88ohIJSIBQ6v45WMyjwjUndgxqLSB2e
 NZ/wjJe3xf7fBf+m0ZRRnxVzhP8+6TFcxW+OVtqnWDiF3RbNMIAoYVriiefqQJJUGJTY
 oX/WuYsFGvmEX5ufJsSj8bevRZxWiYwZtQezLgZixfDt40KzkSI1zRv6nTgaMf6Bg6ux
 nQ/l6ocHg/cWfhDdxn+2dZINOaI2JRyKqEmpqXDvlBgqkNEh8XTW53+V/VnNegflfRIP
 wod7QqCW3ewsd3b7uv0gs4OpVEWSYegg9B9buXZjUEvwU7yqNPzMWY1sLDamaO7nvsj2
 FBkA==
X-Gm-Message-State: AOAM533W8CUqsyN6n5LtpZqIx2IatqoUrj0SWwBT1dGcHUdLM3qCIuCn
 CXkg1p8Kn0AYXGCw52s9dvs=
X-Google-Smtp-Source: ABdhPJyeybrbFPMd8k6s7ssa/Jjwz5tqDSKds/yttCaBFiAeCPHX9fZG+uEi7STunhMwF1J5d+rvSQ==
X-Received: by 2002:a5d:45c4:0:b0:1f0:1683:afbf with SMTP id
 b4-20020a5d45c4000000b001f01683afbfmr13043208wrs.661.1647175433579; 
 Sun, 13 Mar 2022 05:43:53 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 r186-20020a1c2bc3000000b0037bdd94a4e5sm12254347wmr.39.2022.03.13.05.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Mar 2022 05:43:53 -0700 (PDT)
Message-ID: <225dfcce-80dd-5b4f-5d9f-18c12107d4f4@grimberg.me>
Date: Sun, 13 Mar 2022 14:43:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvmet: add missing locks around nvmet_ns_revalidate
Content-Language: en-US
To: Niels Dossche <dossche.niels@gmail.com>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20220309203449.63125-1-dossche.niels@gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220309203449.63125-1-dossche.niels@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_054355_600399_F094D4E0 
X-CRM114-Status: UNSURE (   6.21  )
X-CRM114-Notice: Please train this message.
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

