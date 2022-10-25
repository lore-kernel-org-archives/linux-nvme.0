Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD2EC04A95
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 14:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sHFM7hSxk92IObPZe5vjZohRKRqPul0RJaS7riWUCk0=; b=jpV/ZB4W2QSiYVhYntbuZ7xIRC
	pZEPXBcqgVrQvQi/m+qd1NeUqHD6ObuElfgGFrfcj24P1eh4yCC7mmFoMIODJ99K8xV4iFuUXBRs6
	R75GPLQuG/taOtnWwtatPr31oVSAZf/TaQysZIqgtO1ZXRjY4kIaccqM+m8m7wqxD6rqQdOfPDh1M
	m0vya7irS19YxeR/hIKZdo9aBUYBwQX0262+DJYkaDykltPWd6DQ7YSrShE2VADRz39bfuRZpFZUp
	n9HRMj8dh7pXh1aT0myE54YPdPV2zkgMyNOkt668N63Hx14zlOjjPWHxGjFoXlTLmwFGupOChMChF
	oWX4VdGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKrH-005luq-Ca; Tue, 25 Oct 2022 14:24:47 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKqX-005lgo-Hj
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 14:24:05 +0000
Received: by mail-pl1-x630.google.com with SMTP id f23so11090417plr.6
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 07:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHFM7hSxk92IObPZe5vjZohRKRqPul0RJaS7riWUCk0=;
        b=VIxooYOaxwZ61wqPop57waVSoQw62K9KchO4Wp0x3c75zgNLBtlXYzctK143sQY6B9
         E0YCOoJUKy7pqGPDwJM86cc+VBMW+Of8qeUP7WqgStP83C08GuURb/GRfAIxAZcnWUL4
         gnfHuEJ54AthJm+J/BnSaUpIFvukzEcSupHoI/t2p1ZJzZBISD+GnIrX6NZoB1a6feOq
         WoXUJE9AdrVtQAx3ubTOL0DX1fwocYxcKOe2+UFBj01q4iXIPT0LiQFnBujKgAm8y0hY
         4oPkaPV7vmscjbdlV2ge0Uwynwv5GwTYVKB+9nQ+rtLhJouETTVQCqzH5l2G6tnRPBJG
         NqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHFM7hSxk92IObPZe5vjZohRKRqPul0RJaS7riWUCk0=;
        b=vuTnkoJg8jsXy+sxgZOdOiPdt38s1Ad41IQzgGsV1r7XFHtAWNQkfwmpazE6wmWE5I
         jVkaEGZTpiCLC12V19aMk/YBYtuuy7uGLDMDiprca/Qg9esVvtND/DJPxfw4A/DZMv4N
         D+bD5wskWrTq3ouvXHRhbHDZurIb+X00JfKuh/YycArCnUSyzTqn7GZ0FwdOWf8bu6vj
         iy5YFRiC1JONjtMI4+W8w2sOjoU+siZJcOVrS0s9qEsf0aNYKBqf5uz2ygAr5SaPYNKV
         wxAX+fs8EkdePWK89RBYAJ1tlky0A7fOcDoFdcCzH8te5sFTVYm8X9ykWpk15IS1onoV
         E4PQ==
X-Gm-Message-State: ACrzQf094CnFuWDvpBRqp2v0FzLkisZD22gfDa8KGUMWbOK43Og9NRLZ
	OaO3F1ksvUSol8MuJGgur2rNEw==
X-Google-Smtp-Source: AMsMyM741H7P8iGhv9Qw7LG3fWhtLsvG2uiB/1mucg/H0TheENBKEWlKAS7sZ5WnLe0/9edqqKWe1A==
X-Received: by 2002:a17:90a:590a:b0:20a:e93e:2022 with SMTP id k10-20020a17090a590a00b0020ae93e2022mr44004197pji.141.1666707837740;
        Tue, 25 Oct 2022 07:23:57 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h1-20020a170902f54100b00186cf82717fsm330817plf.165.2022.10.25.07.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 07:23:57 -0700 (PDT)
Message-ID: <2baca1bc-cee0-9a52-3fcd-bdb812e5f512@kernel.dk>
Date: Tue, 25 Oct 2022 08:23:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/4] blk-mq: move the call to blk_put_queue out of
 blk_mq_destroy_queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
References: <20221018135720.670094-1-hch@lst.de>
 <20221018135720.670094-2-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221018135720.670094-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_072401_820578_7DEC3FE3 
X-CRM114-Status: GOOD (  11.67  )
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

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 059737c1a2c19..07381673170b9 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4847,6 +4847,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>  
>  out_cleanup_admin_q:
>  	blk_mq_destroy_queue(ctrl->fabrics_q);
> +	blk_put_queue(ctrl->fabrics_q);
>  out_free_tagset:
>  	blk_mq_free_tag_set(ctrl->admin_tagset);
>  	return ret;
This is wrong and doesn't apply because it got fixed upstream:

commit 4739824e2d7878dcea88397a6758e31e3c5c124e
Author: Dan Carpenter <error27@gmail.com>
Date:   Sat Oct 15 11:25:56 2022 +0300

    nvme: fix error pointer dereference in error handling

Can you respin this series so we can get it applied?

-- 
Jens Axboe


