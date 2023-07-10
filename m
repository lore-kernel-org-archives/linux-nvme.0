Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6475EB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 09:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=sH+kn4qEn5bpWmS9xYr5T00g2O
	hc6hIiCdD0VJ6nNy6m3evOw+il5ONzt109kAhK1h7pCb2q+kbRBUYmjNXfWY15K/dPDxs498YLksh
	1TD88XcoYEW3pe9IPXEWTOPRoqfLl1AvJ1ZXwv39LWKrhpJ6hlPnDB4oTZJwucnTrC+AbQDJ3nnfU
	g2Wi+b/xnKR4RBNGaPn6E6dW8/A3f9zeFgWIFTAQhU39hofri+vCXtrND/5fxHqDZGvOxbA45mz8/
	wwFR/uyqvWV4bJQH1votCshUcp93ofP9c0/vNGvdBVuXWn9O4EsrZRekQBguzkPqV9MTeDKV6w+JV
	yfPozblg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qInD6-00B0VF-0G;
	Mon, 10 Jul 2023 09:29:36 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qInD3-00B0U2-1r
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 09:29:34 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3facc7a4e8aso9014165e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 10 Jul 2023 02:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688981370; x=1691573370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=aNiReHbIDrTOvX8FBFBC59NhtHvBX7F18BjSe8ntpFy36Wb3pOJw7589H3q66tFpC+
         p6qTq+hBY0k9oFQoctbSFMgQcZE9cXeXe0RzCkocJJgZ4euzbR+spj3ckfRomZyPECUv
         78FBAhqcVXGP70sgdrWbS/wrCmO8VQP3spSBZ5IYp7NNhuPf9274ZAh9M3THUO1OYsIe
         MSEaCleSE8AMChTtOPmLn/14EbuU3ZoCRghfHxECH4/HdMrRmDwu2Q+GBa9ECGwBFKIV
         bnvI1lJt22F3TAKSzrkI+mJLAmQLD3ufTGhBy3UAclnKmaL6K4K9BWmn3ZLdeIGYgbfP
         Fq7Q==
X-Gm-Message-State: ABy/qLY1kWviE7my+08pRicZoamn7GryhHgMuts5INANaFFTEfAr2OgK
	y/kOLFfWE30uVRakhpbE/uWOhLgpSwE=
X-Google-Smtp-Source: APBJJlEICPLIIB8HPjX1V78fyHKqZt4Ymy34m8iOn29c0ojF0TgRk/U76vBiUo6Dp3FY9lpoacB2cw==
X-Received: by 2002:a05:600c:4709:b0:3f6:8a3:8e59 with SMTP id v9-20020a05600c470900b003f608a38e59mr12498101wmo.1.1688981369684;
        Mon, 10 Jul 2023 02:29:29 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c230b00b003fbaade0735sm9724982wmo.19.2023.07.10.02.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 02:29:29 -0700 (PDT)
Message-ID: <5f6ea693-d4b7-8117-9151-3666ea86e59f@grimberg.me>
Date: Mon, 10 Jul 2023 12:29:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/4] block: don't unconditionally set max_discard_sectors
 in blk_queue_max_discard_sectors
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20230707094616.108430-1-hch@lst.de>
 <20230707094616.108430-2-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230707094616.108430-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_022933_609573_A3E381EB 
X-CRM114-Status: UNSURE (   7.36  )
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

