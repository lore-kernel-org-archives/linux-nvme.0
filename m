Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61771C07CA9
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Nov 2023 10:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=f+gnNvPhvTpKxgkMMqACdH6cBS
	XQw2TlbzYFMqiMbkhq9+GTS1e8l3Z1tVTA+Uk+0XP3ag2Q9hxq8f89X73YR5SGV/3l/DjoTqC/sau
	ab5MJD2xQHHIqQTV7lvsFupdDP4ZWNA/M6nT7MFM0HTGMSf9NRjvB1Kl+Wmxg4H+lmzui6ggfTeRo
	fi3OOKxjO8vqtVDe7dExFaKnngP3f+CvBFAFScAVWKsH9nMbOmoojVF8a57Gejgc8nsV5P5vQZRF7
	y48H4+4HS2TnlXDO8CGIKsYUr9PfZhLxxApRMUycCddtX5s/12xsXtmS4iNoDjzLA33joPWDXBxrY
	xQqLR8Sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7vZr-004xVG-1i;
	Tue, 28 Nov 2023 10:44:27 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7vZo-004xU8-16
	for linux-nvme@lists.infradead.org;
	Tue, 28 Nov 2023 10:44:26 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40b2a85c99bso6976805e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 Nov 2023 02:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701168261; x=1701773061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=oh7xlwYuKjQxsdS5wYRYBstBS2g/qoAr/NKoTIzfwI3zK4MeHhhg1FPcYv/mhgrLlX
         Xdk+s6w7IGaP+7zHZoMMCW8XpDzs2YtVYD5e1Icf8cOU0TeDNiIfzprIx2czQvAT4ZD0
         ny8HchalxNrn4qOPEmBMZ6czLGqrEjEhJWmgiUuCP9j9JFcP1gz+T/7kcZmC1D22Yfcz
         SAGwNtzDO70rHVCmOGKOFozzqVfGROGIjMLtBVGHcSm4me+C+Zizh3nnL3kT7Kpx5H+e
         GeoFW3PTbo3jS/N07ukf+XLPXUT6cZ258Qjl1WhRjYtoVsy4MtYo9KHtQQRqCCLyZn3P
         W8pQ==
X-Gm-Message-State: AOJu0Yx6jQoUg1WssARh49kLfwVxnbkwdbkyMIYc0ogEQ3ufVTIrf7RB
	6epywBvwXmgGrq+151N5emM=
X-Google-Smtp-Source: AGHT+IH9pcr+AjMGGxZpegopotNjp2DUbGPgQAokhxw9PYt9f1SML+YpUF72waU3nnlYi7OixZLtrA==
X-Received: by 2002:a05:600c:5024:b0:40a:771f:6a56 with SMTP id n36-20020a05600c502400b0040a771f6a56mr10200090wmr.4.1701168261208;
        Tue, 28 Nov 2023 02:44:21 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b0040b347d90d0sm17643343wmq.12.2023.11.28.02.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 02:44:20 -0800 (PST)
Message-ID: <9824d265-d767-465c-b744-c2f9408f83d4@grimberg.me>
Date: Tue, 28 Nov 2023 12:44:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 08/20] nvme-tcp: Deal with netdevice DOWN events
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20231122134833.20825-1-aaptel@nvidia.com>
 <20231122134833.20825-9-aaptel@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231122134833.20825-9-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_024424_375852_00931C7E 
X-CRM114-Status: UNSURE (   4.56  )
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

