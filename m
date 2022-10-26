Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9686FC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 12:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=oI3pOUL8i3f8InWbssomgwgnlt
	dY78PhWJf6lify8IsSbHpHZKVJ/s7nUuvJ/9X3XczWnlY5vNvnRzTzoGthm/HVcvVdvcnRyuD1WYz
	yvrksNZZkbD/cZ32mmMbQ1YkOqZdS20QeHpzUgQ/8LNX3h87WQhKJGihvRujATvsklpA95bE3Nqz0
	nHGeAR/+19OG29j5QSFD7Wu1x/x/T+Akn6rBre3NLJzDkheiT/KS1zvoJfELZRVv8y+GYE1teI4Ep
	8CPegcojkw64eea4KhpiKNY1twz2kYh4koeCMHH7WI91wzdBp216abAFppYHOFu9VzL5RiK2wK/MM
	p2RafGJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfui-009Ivy-JC; Wed, 26 Oct 2022 12:53:44 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onfuf-009IuN-JK
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 12:53:42 +0000
Received: by mail-wr1-f54.google.com with SMTP id y16so15706134wrt.12
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 05:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=VSd9W7e9z6LrDUyoZxPVsur5JLSiAcYLogET/Ta/+kgqs+eCdoRJdXqKq9Ls5BN1gU
         dz/BksBG5vyc+W5kisDhRG14FnSEBPSSt0soLeise/k3+QstOr4jV2vb9CmmKcVjHbI+
         qvOsV+5hVTtXjT6LoZDCLtgN4+VMA3FVV0+hfZ0sjQrsoCmf+93cRnjAusNK5dplOQLO
         IrRmUNbTzRbngC0z/bEGX4AY4lQAYgsq/oSlSEhxp6RM+moGv5Yv9462+3v2TfjBBvuH
         srBY8agkJWDrZDW+czQuxSzrC1AhXkNX+hHE1f8gEljcdavLdY/P5nk+Zb+xS/y2Qsb9
         d27g==
X-Gm-Message-State: ACrzQf3ylETKLJdR6BMtLX2k3/DDTTQSctGSoBK6Ck9tJsPfqmswNoOi
	K/8t0WHxXrV0yzf+SsB5HG0=
X-Google-Smtp-Source: AMsMyM60cJ7pzhIUQsZa5T0LPmBf/N+cRsqOyuUydrBP8q+Xh6a7AafWS/QhA5wFTAXkaa49R+5uxw==
X-Received: by 2002:adf:e109:0:b0:225:4ca5:80d5 with SMTP id t9-20020adfe109000000b002254ca580d5mr28551504wrz.465.1666788820301;
        Wed, 26 Oct 2022 05:53:40 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r11-20020adfda4b000000b0022e653f5abbsm5277939wrl.69.2022.10.26.05.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:53:39 -0700 (PDT)
Message-ID: <588e8f30-e7c0-5a21-2830-59b37df7ce34@grimberg.me>
Date: Wed, 26 Oct 2022 15:53:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 08/17] nvme: don't unquiesce the admin queue in
 nvme_kill_queues
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Chao Leng <lengchao@huawei.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20221025144020.260458-1-hch@lst.de>
 <20221025144020.260458-9-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221025144020.260458-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_055341_646571_369437F2 
X-CRM114-Status: UNSURE (   7.10  )
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

