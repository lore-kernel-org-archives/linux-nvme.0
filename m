Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC64C27C4F
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Jun 2024 08:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=A3YxJQIS0zRnzGJ++2NzD0Ju79
	yyjZiT0CqA7Sh7zGgUbLJJ8CynamKfFb8d3htZlshtH50b3DxYMRsVyD5kLdVIWdbjcnIOJ1ljgA5
	O8bAFqiz6khmbJN/joKfWmWCcK6PaX0tdJtMbsb6EZ9d1KDFgOUfyODS3ZgsJzU6jKSmmtz6g7zqz
	mumuI9wv6KiCqtW9O0VBwu0pVzalbJZw5NZHEPtxfeE+ognKBt+ozh0GXZarxg5++ppgEpm6tmFjE
	HCPF1HbvJRLOWou1BlZfXCuyWe+M2aG4PlhXfabSECCnmdlCF4aSiWf7BK1uT25SGwxV4VYs4aDjd
	J2V7Pucw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNps1-000000002kO-2V8H;
	Sun, 30 Jun 2024 08:25:13 +0000
Received: from mail-lj1-f181.google.com ([209.85.208.181])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNprz-000000002is-12q4
	for linux-nvme@lists.infradead.org;
	Sun, 30 Jun 2024 08:25:12 +0000
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec5f72f073so2171681fa.0
        for <linux-nvme@lists.infradead.org>; Sun, 30 Jun 2024 01:25:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719735909; x=1720340709;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=Dk4YtKN3GWxKAlvsx7YfWTCP2/jSCmHWzcxY8JakKo3a498XOMK+ieGpMTvd0P/PvN
         HnoXn4TkHEROUmA6LikV98efWa0BF2nqBKuQDIqVhisurzleUT+uNSKKqd8thH31Zig6
         AjcaGjOJTWMcN+xupVW4Q2GLx2T9sMq+DPz6yAvhZ29sQFIUX+ZFIXLjxz+4/Khw/eDm
         RFAVsSMctJKy8+7KRGn2pcwOJleGmRWMjFhXObaMKG9ooo1LAgsS+zMNwDOm3gA1kmmT
         4LDHePCEojF840WcFvqduTSg1wu8YT6JWf1NiZEWSgNXKiGUsfAKWOYBkTzTX31YQch0
         8pyg==
X-Forwarded-Encrypted: i=1; AJvYcCWQpDgoxiHgWSWTXWBNPLbLY200My+8oWasjRZQpYOsICqmhTVpMgmrrVFJzH/VmPRwye1Vd5pCHE6u/NI06tT2SbfP4xJbZwVnFP71veg=
X-Gm-Message-State: AOJu0Yx3gyKH4xH+l6o22tMD0Mpo11YeZalmnqzUWC2Mas5rbeLafvlZ
	dfI6iv3Sx29UARx3ZNnd0oYL7tBQ03RXA5AaSXjW02q9yMb93LS6
X-Google-Smtp-Source: AGHT+IGC9jwFb1286Lb4U1VLu0C/tJIWCa21LZBgCfVnza/d/EPdH0MLLKsWGZuqGeYIwyVrnHoK5A==
X-Received: by 2002:a05:651c:210d:b0:2eb:e6fe:3092 with SMTP id 38308e7fff4ca-2ee5e6cd8ebmr19581701fa.4.1719735908801;
        Sun, 30 Jun 2024 01:25:08 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4257a2f7451sm44159775e9.0.2024.06.30.01.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jun 2024 01:25:08 -0700 (PDT)
Message-ID: <4d27ebd2-ea48-418e-9d05-5118ace68ad9@grimberg.me>
Date: Sun, 30 Jun 2024 11:25:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nvme-pci: limit queue count to housekeeping CPUs
To: Daniel Wagner <dwagner@suse.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Cc: Frederic Weisbecker <fweisbecker@suse.com>, Mel Gorman <mgorman@suse.de>,
 Hannes Reinecke <hare@suse.de>,
 Sridhar Balaraman <sbalaraman@parallelwireless.com>,
 "brookxu.cn" <brookxu.cn@gmail.com>, Ming Lei <ming.lei@redhat.com>,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240627-isolcpus-io-queues-v2-0-26a32e3c4f75@suse.de>
 <20240627-isolcpus-io-queues-v2-2-26a32e3c4f75@suse.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240627-isolcpus-io-queues-v2-2-26a32e3c4f75@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240630_012511_398051_C7AFE598 
X-CRM114-Status: UNSURE (   6.12  )
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

