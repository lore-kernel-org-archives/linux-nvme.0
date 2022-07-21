Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D38C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 22:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ZaSqNx+Nc5pb5kXHzyEa20E2aUkII08QQbZ9JohIHc=; b=QFYFjbiGlNefjfDXCxT/cPEPtz
	vPrKV39Ha/c/7R9hYC5D8oU2B3TUv2n84JdSZIC3vXu9+zPGOVXL5LgtULt+PUgZeS5GYBOzTt6I5
	r+vsMyZjPnFmm+fQps66xE9wffhtkXmWyClSNSNO02PBsE4I7GdXOy56Rlr+U/ruk3fTQNpnZAJmV
	42Hpb0bZK/Gkged6bCihATX0OfYT/2Omgzko9hciwrqMe7O5WRwJJVTQ6S7D4w48mn4JuksY8WkYS
	Elbo0JSDW2EL5yqvNzXgYigI9oDSFOgIjlBjZfFd8wfsx0AEINRWN2am2OIZIS9I/OAJCOeQXcw7G
	/t/radYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeXO-00Cn6S-8w; Thu, 21 Jul 2022 22:20:54 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeXL-00Cn3u-Hz
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 22:20:52 +0000
Received: by mail-wr1-f47.google.com with SMTP id b26so4200345wrc.2
        for <linux-nvme@lists.infradead.org>; Thu, 21 Jul 2022 15:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+ZaSqNx+Nc5pb5kXHzyEa20E2aUkII08QQbZ9JohIHc=;
        b=diz0ZVIaw3oH0YKt6iAt3o8K0i5fpQ62t12FaoRcF5xbKHYhdAPqNql1iax6vn1kT7
         CDsIIUBcC47mI2SuTuBAfjllJ2svkHEyIcz3YL2U9fKyhocJoZl3hb3P8LM7iU+NJd6y
         b50+Ubq5tGbVLf1blwi8dGO9mbMkEsC4+WmLus+5CvN6tSTZZ1lb44Pic6QFnuDPCw0C
         w4PiZqiC5LhNgPG2N21hGVu8/RqeNGxYnfQ5dws/BTTCDwyO6Dmy9ZvZw8LUP6bh93wM
         pGNdAPQJxj6u1KaVUfxy4MVzcJRJ3uugeWAwzPop6Xlja8CxvlC6yS2JNsF1b1qsfB6U
         Ye5g==
X-Gm-Message-State: AJIora/EG5EvDqZ1df8KRi+mAGpsUn7UWv/SEVrAzEBdO1tKjV5FPbw4
	stoyPjDNgwef3RETp9MtYzYWeQEt0n8=
X-Google-Smtp-Source: AGRyM1t1wrlLCL0CdUTqk/uN3BBUA688yd9FU0JMYsothMIA4pfuHZWVQJWyUNuBWdEffI0kGHc//g==
X-Received: by 2002:a05:6000:1d83:b0:21e:4307:3ebf with SMTP id bk3-20020a0560001d8300b0021e43073ebfmr345791wrb.595.1658442050355;
        Thu, 21 Jul 2022 15:20:50 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id c18-20020a056000105200b0021e4f446d43sm2860817wrx.58.2022.07.21.15.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 15:20:49 -0700 (PDT)
Message-ID: <e448b5d1-d1d1-49a4-3972-cbe89353fbf7@grimberg.me>
Date: Fri, 22 Jul 2022 01:20:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-pci: print the command name of aborted commands
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org
References: <20220718051357.232697-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220718051357.232697-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_152051_637270_FB962D3D 
X-CRM114-Status: GOOD (  13.92  )
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


> To allow for slightly better debugging, print the command name when
> aborting an command.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/pci.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e465902e0b752..1f229dabbe7aa 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1434,8 +1434,10 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>   	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
>   
>   	dev_warn(nvmeq->dev->ctrl.device,
> -		"I/O %d QID %d timeout, aborting\n",
> -		 req->tag, nvmeq->qid);
> +		"I/O %d (%s) QID %d timeout, aborting\n",
> +		 req->tag,
> +		 nvme_get_opcode_str(nvme_req(req)->cmd->common.opcode),
> +		 nvmeq->qid);

I want that for rdma/tcp/loop as well.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

