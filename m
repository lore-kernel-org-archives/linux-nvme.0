Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE88DC25B50
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 09:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3+hrXXVy7rJU70ZHwCHQHeww3gxuBi4lhtjORcUVSRk=; b=KG6FEHIR3ZEffloCK1LJ9E3npQ
	RNBcDXdi8v+3+yefbLx8w6+Oj5x4Oc0/NRSYTeItpsR/1X13FnEA3YzjhQME8jJJW1q0HNdASF6uq
	xyf2LRto1jdmSfVAnu+xXMVI+0PFlx4nO06AhSjgjHbdeG7k/ykABiquLwBSxEdtEz7FP3oHBH3kv
	b7XaBQY+LFlXWOL9QbOaZJynKxqdY59+fE1N1r73y5Ly3xX9TwtNB4TOsJl1INmjrIYYRB0bF+Awc
	hThVOdKQ0PKwoJPRJep1MJBjOxu94Xzmu9Alla1Ayj7R258Gbu5UVISMPZWyhLakzjp6fd5zjhhTZ
	wscxVS8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJtON-00GZEK-G6; Mon, 23 Jan 2023 09:45:31 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJtOL-00GZDZ-Av
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 09:45:30 +0000
Received: by mail-wm1-f53.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so8067111wmc.1
        for <linux-nvme@lists.infradead.org>; Mon, 23 Jan 2023 01:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3+hrXXVy7rJU70ZHwCHQHeww3gxuBi4lhtjORcUVSRk=;
        b=CdpxN5LSGSMDajPWvin5aIunjFp/WRhmjSvSm0Ke/hPnVtwGMbBXh5BALkLLYPxTbQ
         EaSGxVxqCFfiv7GxE5gC+aThfGw49u4ZQV/A7JFLPftJ2/NAile7TeBlwbxJPk9SBVtk
         U/ftgQ3XRoRH9O4bJakO7UQkWJkLTBxrzAaaxj0aLBciWQmdB7XEhTEG33yjj8ytTPWZ
         Eu6dcvnVnFDVALrrL404dk6cDAeRZ/WHQjIyzr+x+kOVcdEvPCJyFHaOYWYQZ4UR/vn+
         nXUzuKXlK7efSFZhd/q5QPNXQvQNBUNjhYlkHCPQY+PHhTW4qeqr6g9Hva3ynwM3RNbh
         xBpQ==
X-Gm-Message-State: AFqh2kqJ6jg/f/DIRgNkLKenQulwybugnrolWWD0Ej8kRT7RM1AHgVX/
	ltp/5kfmkBD9fQ61fnM6mPAQS4GFLsA=
X-Google-Smtp-Source: AMrXdXuQzB65vnLcSjMYvo+13KVq56/W5h+tYasmspXnb/QeHaEL4KQnSJvUHQ2AE2wIdOp9qwnyww==
X-Received: by 2002:a1c:4c04:0:b0:3d9:f0d8:708c with SMTP id z4-20020a1c4c04000000b003d9f0d8708cmr31476195wmf.26.1674467127664;
        Mon, 23 Jan 2023 01:45:27 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c4b0800b003da2932bde0sm11546892wmp.23.2023.01.23.01.45.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:45:27 -0800 (PST)
Message-ID: <75dbb806-d9c3-5710-8690-c7a4327b47b9@grimberg.me>
Date: Mon, 23 Jan 2023 11:45:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCHv3] nvme-pci: fix timeout request state check
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
References: <20230118164416.1085583-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230118164416.1085583-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_014529_426352_81399C41 
X-CRM114-Status: GOOD (  18.87  )
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


> From: Keith Busch <kbusch@kernel.org>
> 
> Polling the completion can progress the request state to IDLE, either
> inline with the completion, or through softirq. Either way, the state
> may not be COMPLETED, so don't check for that. We only care if the state
> isn't IN_FLIGHT.
> 
> This is fixing an issue where the driver aborts an IO that we just
> completed. Seeing the "aborting" message instead of "polled" is very
> misleading as to where the timeout problem resides.
> 
> Fixes: bf392a5dc02a9b ("nvme-pci: Remove tag from process cq")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v2->v3: changed state check to explicitly look for not IN_FLIGHT
> 
>   drivers/nvme/host/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a2553b7d9bb8e..1ff8843bc4b36 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1362,7 +1362,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>   	else
>   		nvme_poll_irqdisable(nvmeq);
>   
> -	if (blk_mq_request_completed(req)) {
> +	if (blk_mq_rq_state(req) != MQ_RQ_IN_FLIGHT) {

I think that this change also applies to nvmf_complete_timed_out_request
no?

