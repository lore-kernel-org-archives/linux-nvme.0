Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 677B7C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 03:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=L5Sl6DOXTlW5Lk+AYT9sOOp0f9
	kYRnjemsEOwbUy31VvWdJ8O9SJrehwFnKaML5WKXPLeiBZhqPkEhRQoRL7jPb3469OPpwSsVDIqM2
	KdnW2c3EV1rdN1mJNDWYs0ySckFDm8JcVNPWfLjstrfGflGFzeQMnV9XcYHbrttHMYwiG7Czo9lqw
	t3t/qZS5pyrNN058ilEiKuegtTh8lH/eLGC2L/Fdc95D2WIhkLIwLOhpET/dKsJy2p/6tHaQRbCkS
	kcna2SpsGst7s0M1mocrB7KtogvChw0Vi2VEzl3MgMMeTyQynKYPe5a9u6JExWpfikxvEQ1rrBJNG
	7iYY/UJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbQP-00AF3k-Aq; Wed, 09 Nov 2022 03:06:49 +0000
Received: from mail-pf1-f175.google.com ([209.85.210.175])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osbPd-00AEmn-70; Wed, 09 Nov 2022 03:06:02 +0000
Received: by mail-pf1-f175.google.com with SMTP id d10so15493638pfh.6;
        Tue, 08 Nov 2022 19:05:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=oBlkp7bavMCm93lAzBNgTlRBdEkZgCXshxxam49cWNDMWyQ2da6Hax9ke3E42ip3je
         s2i3j469Lo22GelaoaLZrjosDjDdA/guarZhG6s6q2AveumDT8OG3FPZ+JfDS5xDLX5l
         f6JhjJfamKZOTA0QYgZxTY32j6z/GstidjdCYzq8iCZPZcF6AdRGD8WCckit6G4Z1o8Y
         uTcxEk2AgqYKcjq1wuGJA7dRzcJktzoCnKT7qIgKuYLMOp7BnVtOUWwQ8d6EZl53APSp
         y27yrQuIrRB1YsnfBd7mnsbwDwh6+dtWOtBZ2eCEM347U5hA+ygydl+pMr8A0V8soUl2
         bq/A==
X-Gm-Message-State: ACrzQf1ncVn4EkrerJvDMh0G1voZtZgOVex2N4DMUdXDJCwjU4oCK7iV
	MZpSLf69+jVjyaLl2mkj13Y=
X-Google-Smtp-Source: AMsMyM57OKpQMbsW3NhV1pSD0OMtat4fCxDW83AGrmkwXeT5xW/owjlrSsb81CU3Ql/LXdTA5e03Jg==
X-Received: by 2002:a05:6a02:28b:b0:439:19d6:fad5 with SMTP id bk11-20020a056a02028b00b0043919d6fad5mr51783961pgb.591.1667963159323;
        Tue, 08 Nov 2022 19:05:59 -0800 (PST)
Received: from [172.20.3.206] (69-170-33-158.static-ip.telepacific.net. [69.170.33.158])
        by smtp.gmail.com with ESMTPSA id i184-20020a6254c1000000b0053e468a78a8sm7042290pfb.158.2022.11.08.19.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 19:05:58 -0800 (PST)
Message-ID: <618f001b-2435-a195-9c9d-907cf1f93ece@grimberg.me>
Date: Wed, 9 Nov 2022 05:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 10/12] nvme-pci: split nvme_dbbuf_dma_alloc
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org
References: <20221108150252.2123727-1-hch@lst.de>
 <20221108150252.2123727-11-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221108150252.2123727-11-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_190601_298225_9134DBAD 
X-CRM114-Status: UNSURE (   6.50  )
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

