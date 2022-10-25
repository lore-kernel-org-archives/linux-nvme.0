Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B7EC38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 14:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y1A0KinkqJZXtWc3dy8dV7laoDmD4Squ4QKOY43J8ng=; b=qIc9tHZZwSaX4mA54FJqgbZujR
	09ILstLSPaFGH8BLOKI6mOq4un927+A3i10+/6PcrpDPWs1fNU4WxumAtHdadk441eEQmrX3Ogbqz
	F8IkTK9vy9QEMQue5IaRdrojpviBoXOSf5FKSDsgBZ63BUVX85Tr+KMyDfhLmPmw0XeL8fY40V+1C
	bZMulFyAFwfXt0U2LQrw710J8/JZFaPJ7yCxNKkmlGYZQBQsibVTzYhJRKmJT+4P6SgQCqnvcYgb8
	RCPoNaWjSHfYy+MIsweScMajmIdFAP+LshV0ZYHJGV7CTPBBQXTGJLA/ImfHtJSqIHDfx/6ep4XJv
	2yjfnydA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKsw-005mNT-Im; Tue, 25 Oct 2022 14:26:30 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onKsV-005mBx-CV
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 14:26:04 +0000
Received: by mail-pj1-x1036.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so6911643pjc.3
        for <linux-nvme@lists.infradead.org>; Tue, 25 Oct 2022 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1A0KinkqJZXtWc3dy8dV7laoDmD4Squ4QKOY43J8ng=;
        b=xUMCAlnR4XuvMILi6XmutYRtljYg02457nRtLmvx2A+0aFb0YQkKh8YfGvPAoHf0+P
         5Oo6SqzVv9eUx4wVJnu49TfX+gvkEFflu3R3snxw/93wGYTjmY+Q663a55WeddgabKdu
         TCjUjPg1tzXLfoKJNKgS4CISdJzH7KKTbvPwjw0TKrkKtb61La4e1QMC6c7JzxL2pTSw
         dIxVDIsn8rbIVCcLMwfxj7BPYaXsxDsy5j25MXoS8mecJonOGwzAl8uXVxwuEHatnSCk
         dTbX8xkdm2iPMku/+oAcphsLdwRC20XZ4lGzSc5SMgLRoS5kKXmAd39Eayz2HSrqxaX9
         LJOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1A0KinkqJZXtWc3dy8dV7laoDmD4Squ4QKOY43J8ng=;
        b=H1Rj7llwTcXmoq500E2pXfhdSIip6f6y20pJJCHxrVPdIHdyRkV+J+F5xyiRdlB9DF
         0c02Tk1uJ2NClEQqZX5CeeukslvCNJgM1WZwx+jXysQjlXLgHrwzKVxkvBVGUwT4zatF
         OWS9bSJc/APbKx0eqJBZefflsW3x99k9cKrGlnyvExOpnpsq/40M38+BOH8vAL86MVFa
         g09zOfcSOPQl3Fna+fVgLyx/5XfWKw8O5mh50jRaH9PIFbwwIrVRGgIElTyUqUmJguFH
         GdRDfUGL/0Yrsl2SSEnpXqhcwPv/veK2K5KTzmdEWd6Jmih2Gc2bagbAnaWuxWnm/g01
         gzig==
X-Gm-Message-State: ACrzQf2zO/62ReZnBudacDisVhv5xHFoUyIUGFODX0h5tfoQu8fabWBI
	NwhxOx0ZtNck8rFeJzaaCBG/uQ==
X-Google-Smtp-Source: AMsMyM5D8UaatM+carGEAks6HckRgLt6KP4qSesCxzY7evMPtiIz7wRcG4NASMf1Gn2JCZMhYBMHtA==
X-Received: by 2002:a17:902:b417:b0:181:d0e4:3310 with SMTP id x23-20020a170902b41700b00181d0e43310mr39010074plr.134.1666707960022;
        Tue, 25 Oct 2022 07:26:00 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p1-20020a1709027ec100b00185480a85f1sm1261456plb.285.2022.10.25.07.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 07:25:59 -0700 (PDT)
Message-ID: <7e9c2c88-2fe4-d48e-dabf-3fa345bcc8e6@kernel.dk>
Date: Tue, 25 Oct 2022 08:25:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/4] blk-mq: move the call to blk_put_queue out of
 blk_mq_destroy_queue
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@lst.de>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org
References: <20221018135720.670094-1-hch@lst.de>
 <20221018135720.670094-2-hch@lst.de>
 <2baca1bc-cee0-9a52-3fcd-bdb812e5f512@kernel.dk>
In-Reply-To: <2baca1bc-cee0-9a52-3fcd-bdb812e5f512@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_072603_475999_EE9D0192 
X-CRM114-Status: GOOD (  13.37  )
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

On 10/25/22 8:23 AM, Jens Axboe wrote:
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 059737c1a2c19..07381673170b9 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4847,6 +4847,7 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>>  
>>  out_cleanup_admin_q:
>>  	blk_mq_destroy_queue(ctrl->fabrics_q);
>> +	blk_put_queue(ctrl->fabrics_q);
>>  out_free_tagset:
>>  	blk_mq_free_tag_set(ctrl->admin_tagset);
>>  	return ret;
> This is wrong and doesn't apply because it got fixed upstream:
> 
> commit 4739824e2d7878dcea88397a6758e31e3c5c124e
> Author: Dan Carpenter <error27@gmail.com>
> Date:   Sat Oct 15 11:25:56 2022 +0300
> 
>     nvme: fix error pointer dereference in error handling
> 
> Can you respin this series so we can get it applied?

I just made the trivial edit in the patch itself, rest was
fine.

-- 
Jens Axboe



