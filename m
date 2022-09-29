Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E973DC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 17:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IYZh+nK5YCCQ4oiVyHqObkTmxD0DKA6yJReA9paQ+eI=; b=W9JoJIVt4OoRjpjhIk0nqybs9v
	jmqUt0J7WjZTwm0hGCsgH9jy2LH0jHXt9DyNG7OockkglUnxjFVCZP02eWZTtrDIaHg+6Vk6jgbFV
	ueDMMh7zIzO7icAaA024bHjOepFCLluyCERqj9qWDGKvfUX8X2u0s2HADVbIq0AoCuYfGa9RNrpNP
	HMn50cUuTwvjybTEGUBmEEz51zJ+l/usSAUZI9vbbtXbnw5bnmA6iqh7xtqwzZ9IuArIqdbcBYjxT
	HnFuqhJm2IYiWUJmNBTLvXYM0LhBhJNoXw/Rc3Jrh1aIwkQce4NK+CaqhF/KLGCfa9YphBao/Q4N0
	FhmtxsOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odwzT-004QSv-Oj; Thu, 29 Sep 2022 17:06:27 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odwSq-004CTA-Mm
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 16:32:49 +0000
Received: by mail-wr1-f42.google.com with SMTP id v28so3049778wrd.3
        for <linux-nvme@lists.infradead.org>; Thu, 29 Sep 2022 09:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=IYZh+nK5YCCQ4oiVyHqObkTmxD0DKA6yJReA9paQ+eI=;
        b=ydKRPFjpCATDagZ+C2NjsyqQXg9HA2gK0fMa5EkjpILPCB4t1LLvPkqj/Nn8/M/uyA
         ZozDnNKz1rKZkCoQXnFuIgWWO+mMa12J4xg1qUGpFRIZL2C/185NCozwfa5zPtPRmIfK
         wbj3lcIsoo0v45UrsSwW1riYyY3nQvWL9ZjpTrG5m3etuuJzeeJi5EYWPV9Ghi90q/ej
         KcNtTph/wOAhwrRWDAcBWtICJbrk5GFJ9mnYcKQYd7zjUuncR9V1mu0dQ6ulXXglyT2M
         rqghINkyfP/1gEsbjMslXpGwVroir7V5oLBEB0lenBRHMNPx/FWJEdyIEVYp8h/VMp1T
         6hDg==
X-Gm-Message-State: ACrzQf3CWCNs28GOdCi9Ufs5VLsTnkyZI5uPSc9QoZmfKBgyHn9tbTGy
	cup0Yil7fV+IqxeeYTwTw5o=
X-Google-Smtp-Source: AMsMyM7Vi8Zv246zWA3Kl9vxysqsy5NxHTXSGu7gRTfgvoZ4sXaYFHNRRsDOlBr92PMvARCHZtpRfw==
X-Received: by 2002:adf:a4ce:0:b0:22a:f5e8:6dcc with SMTP id h14-20020adfa4ce000000b0022af5e86dccmr2899437wrb.445.1664469161531;
        Thu, 29 Sep 2022 09:32:41 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id e9-20020adfe389000000b00228daaa84aesm6942020wrm.25.2022.09.29.09.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 09:32:41 -0700 (PDT)
Message-ID: <e5299b5e-5e9a-5a2a-b7dc-30de2bf43adc@grimberg.me>
Date: Thu, 29 Sep 2022 19:32:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Hannes Reinecke <hare@suse.de>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_093244_816106_CDDB88A7 
X-CRM114-Status: GOOD (  11.58  )
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


>>> 3. Do you have some performance numbers (we're touching the fast path
>>> here) ?
>>
>> This is pretty light-weight, accounting is per-cpu and only wrapped by
>> preemption disable. This is a very small price to pay for what we gain.
> 
> It does add up, though, and some environments disable stats to skip the
> overhead. At a minimum, you need to add a check for blk_queue_io_stat() before
> assuming you need to account for stats.

But QUEUE_FLAG_IO_STAT is set by nvme-mpath itself?
You mean disable IO stats in runtime?

