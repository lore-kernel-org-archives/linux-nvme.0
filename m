Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6691AC54E76
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 17:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wywbYDdRewZbeBYdBqsQPCT3pfo92S64CwjLHS6OdeQ=; b=Dm9JTjudt1YdOPtnHqtH2dirQ8
	sDORYm8B9+/RKXAfPcGT45whhJfcrV12vPkfV5KxZQC0OSG64HfazA37cFfpDMWyS5s+lIG9jBJ94
	MsVNDtUjQ2ZxjHIGeQFHgEyf+kfq6Dty+lvnDFH4RdDWViAP7Zu93BKkQ3lShV/KOpxeHF4KMaW/I
	q57u2n/MQjkAkT9z8JGbX3EptM0cVik6ficXELpp252I/7BSJavqIacfj3vZ80lFQrTrjery7AmNE
	ToMcljeiTKoemMo69Yz3mxbL7q8BklRV7BX38++kyjxUtzV4F5m6PDyPiZOPxnz/gO9KVJezQLRQG
	L7ONRTvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHpUS-00FDL1-Nq; Tue, 17 Jan 2023 17:11:16 +0000
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHpUO-00FDJm-W2
	for linux-nvme@lists.infradead.org; Tue, 17 Jan 2023 17:11:14 +0000
Received: by mail-io1-xd35.google.com with SMTP id y69so671772iof.3
        for <linux-nvme@lists.infradead.org>; Tue, 17 Jan 2023 09:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wywbYDdRewZbeBYdBqsQPCT3pfo92S64CwjLHS6OdeQ=;
        b=FHQzA+SB1PjLtYDocMcaQu5ERZlfgETSf3c+RoL6zvzVfhmdguW8sINbIv0wDEirVD
         MPNNkk03+hwWl9H7z8x+7JDXDwUi7/TsCreHXebPgL7k8OcPG3lpH44HIFh4FtRHP9P7
         7dpEJxhY2F+sm1kvPsqzQ3BP5QZ86SC4dwmGfbelIeb35tODo8f1BvcATovtijxhug3E
         EIuycqfh4KTyQQsJqveGukZeBccVVJ4rpg3RQKzPgyxCPBkVJuEejLYYL3J38uU1WZg/
         H4uv/FkYRhCOpaqDPBkoE/0rzJZo7bkn9bE3J2oH10TbbxVAg1Sw1POFsrZhuVevJzzu
         V20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wywbYDdRewZbeBYdBqsQPCT3pfo92S64CwjLHS6OdeQ=;
        b=0HDhfkeKJtyjO5MAJZdGS6g43UHygxsZijGgbOuzc1tv9oKjL0TJvZnVepJAp+XG1f
         f9oDgPJM3P6HXTkVyaXaT/QKgCd8nOL5YNb4rv6aqJx+uVsA3gO46pvWvIrzbu8XZ8p2
         kNseiwkz76PIWh8J7BmQxJt+mnTXJsj195GrQ/LTRGVhYeMtqykgMgTg+b3l4Um51KJz
         ZzBcCRTsF+lDKQeNy/+/DywXymkl4FQDkW4nvEW4PisON9+nu0T5K79LKZbjpFsp/TrP
         8Tu8yNZ5Tu88EDujSJi7M4SZ+0A71BienJR/8MC2smVibwA+QWeJ5wYZQOsALK/UMNSp
         am3Q==
X-Gm-Message-State: AFqh2krTkFE8BLpTVBc2VTL4AT0GrA7sY9/QH2J0rKrs/BKd6/3f5Goi
	UXVGX3Q1agIMSi0xV/rr7YIIpw==
X-Google-Smtp-Source: AMrXdXuH0uUysfUh/dakMTeWj+tvfqr+wlc/wqmWBNGp6+udS4yaxUSf2d+cKDtvJ/YnZMPW1mQmDQ==
X-Received: by 2002:a6b:b2d0:0:b0:6e2:d939:4f30 with SMTP id b199-20020a6bb2d0000000b006e2d9394f30mr592309iof.0.1673975469840;
        Tue, 17 Jan 2023 09:11:09 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x20-20020a0566022c5400b006bc039e3224sm10560144iov.17.2023.01.17.09.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 09:11:09 -0800 (PST)
Message-ID: <0e88f8e6-961e-28b2-0606-50c1a0de10fb@kernel.dk>
Date: Tue, 17 Jan 2023 10:11:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH for-next v1 0/2] enable pcpu bio-cache for IRQ
 uring-passthru I/O
Content-Language: en-US
To: Anuj Gupta <anuj20.g@samsung.com>, hch@lst.de, kbusch@kernel.org,
 asml.silence@gmail.com
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 gost.dev@samsung.com
References: <CGME20230117120741epcas5p2c7d2a20edd0f09bdff585fbe95bdadd9@epcas5p2.samsung.com>
 <20230117120638.72254-1-anuj20.g@samsung.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230117120638.72254-1-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230117_091113_057808_227E7774 
X-CRM114-Status: UNSURE (   9.05  )
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

On 1/17/23 5:06?AM, Anuj Gupta wrote:
> This series extends bio pcpu caching for normal / IRQ-driven
> uring-passthru I/Os. Earlier, only polled uring-passthru I/Os could
> leverage bio-cache. After the series from Pavel[1], bio-cache can be
> leveraged by normal / IRQ driven I/Os as well. t/io_uring with an Optane
> SSD setup shows +7.21% for batches of 32 requests.
> 
> [1] https://lore.kernel.org/io-uring/cover.1666347703.git.asml.silence@gmail.com/
> 
> IRQ, 128/32/32, cache off

Tests here -

before:

polled=0, fixedbufs=1/0, register_files=1, buffered=1, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=62.88M, BW=30.70GiB/s, IOS/call=32/31
IOPS=62.95M, BW=30.74GiB/s, IOS/call=32/31
IOPS=62.52M, BW=30.53GiB/s, IOS/call=32/32
IOPS=62.61M, BW=30.57GiB/s, IOS/call=31/32
IOPS=62.52M, BW=30.53GiB/s, IOS/call=32/31
IOPS=62.40M, BW=30.47GiB/s, IOS/call=32/32

after:

polled=0, fixedbufs=1/0, register_files=1, buffered=1, QD=128
Engine=io_uring, sq_ring=128, cq_ring=128
IOPS=76.58M, BW=37.39GiB/s, IOS/call=31/31
IOPS=79.42M, BW=38.78GiB/s, IOS/call=32/32
IOPS=78.06M, BW=38.12GiB/s, IOS/call=31/31
IOPS=77.64M, BW=37.91GiB/s, IOS/call=32/31
IOPS=77.17M, BW=37.68GiB/s, IOS/call=32/32
IOPS=76.73M, BW=37.47GiB/s, IOS/call=31/31
IOPS=76.94M, BW=37.57GiB/s, IOS/call=32/31

Note that this includes Pavel's fix as well:

https://lore.kernel.org/linux-block/80d4511011d7d4751b4cf6375c4e38f237d935e3.1673955390.git.asml.silence@gmail.com/

But this mirrors the improvement seen on the non-passthrough side as
well. I'd say that's a pass :-)

-- 
Jens Axboe


