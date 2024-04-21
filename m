Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F39C4345F
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Apr 2024 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KAO6uAdXhRWhSWqz75cahmrQkh7UglWpv3HCw64aE+A=; b=KyoPVuPltdfQ3rEduA20QKVBLQ
	/cwE7HcdFTTVtZdkNfM3dqfQkmILKKS3SoU7LrWBOQB5QFXuPQb1xQWm8gCxIXCsuYUiNusShcOFY
	nSeXsRUK0vtBTRg+KV1m85LNEEKshTrK0YX28yFcKMu2KQcUN9zvEuXYEMU7NDk94pqP37Yv5Ew1e
	wfZPsCPn8SYtOTd8vEXj2D8aLLCcWV+kqToeYfznf1BUGoR0ut95g94akRKHw5AefMai8dyFFlr3X
	2b2GxSY+oJIQHIHinvyqSK+bnbE5obvou/2PQ8tKe2z5KyYtUFzq2gY464qNkevFCZYO4R2YaGQH5
	4h2noMEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryVfY-0000000APSn-2xlz;
	Sun, 21 Apr 2024 11:47:40 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryVfV-0000000APSH-2MsR
	for linux-nvme@lists.infradead.org;
	Sun, 21 Apr 2024 11:47:39 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-349a33a9667so503234f8f.3
        for <linux-nvme@lists.infradead.org>; Sun, 21 Apr 2024 04:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713700055; x=1714304855;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KAO6uAdXhRWhSWqz75cahmrQkh7UglWpv3HCw64aE+A=;
        b=qB6bswr8S9ubdVIWMm/SJWyqtvdCmZkXUZmIAmRfz0MbsfIvz5AXMPNOpL7IvmtQHl
         721c1RxCcZtylG5Phicvva2o4UUmCKTjLmgQ35koMJz9R2BqtcYQnBsyqx5Gyj42KAqF
         nMf1cwtYzA93CaATdhidLPhGP7lsBMuRebtqr1MoqDSgUGvpUqwhambwhVhjwq1Z9gms
         l8OWQLLFDiV+NXVE4iOYAJAEuVNWtlTuSIUev74VV5daR+ey3WJRQyVm47j7BY16dqEu
         gvR68wR2nzWQ+Y2+K6Z5k9YEi6IcwKLPrBWYeiCaWLpor+puAZ2tjVcA7plJa0Z10Vcd
         R0rg==
X-Forwarded-Encrypted: i=1; AJvYcCXNWnJ7K+Dlt9EUYm6UsyxAVZE1jepidKVW7dzMFyP05e9WjSMbX48DeOd5IEeZ96Pq333GCpUgwNbhVfsDn0Kp6Ttp6uPeO+vbWy+KvuA=
X-Gm-Message-State: AOJu0YzMYnooPS9ykWzdZwt/PUa9ibedz8P4CA6+A5e/dYRIpxCPoqYP
	OBS+K6yKJGwUiuZwP1Oks7JbUgYtwhKYSFpXofZxrqZC8E0PVFza
X-Google-Smtp-Source: AGHT+IEYsKwwjclRwSZQ+wz8CcVL0uOlw9TVDRYNex6MSArZhtkZpO26JNCiL2dcx2Jn/fOIw62hTw==
X-Received: by 2002:a05:6000:369:b0:349:fc93:1d9 with SMTP id f9-20020a056000036900b00349fc9301d9mr4706458wrf.2.1713700054707;
        Sun, 21 Apr 2024 04:47:34 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id v2-20020adfe282000000b00346ceb9e060sm9078419wri.103.2024.04.21.04.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 04:47:34 -0700 (PDT)
Message-ID: <3ab22e14-35eb-473e-a821-6dbddea96254@grimberg.me>
Date: Sun, 21 Apr 2024 14:47:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 01/20] net: Introduce direct data placement tcp
 offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com,
 edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-2-aaptel@nvidia.com>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240404123717.11857-2-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240421_044737_643029_407C4849 
X-CRM114-Status: UNSURE (   6.67  )
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

> +int ulp_ddp_sk_add(struct net_device *netdev,
> +		   struct sock *sk,
> +		   struct ulp_ddp_config *config,
> +		   const struct ulp_ddp_ulp_ops *ops)
> +{
> +	int ret;
> +
> +	/* put in ulp_ddp_sk_del() */
> +	dev_hold(netdev);
> +
> +	config->io_cpu = sk->sk_incoming_cpu;
> +	ret = netdev->netdev_ops->ulp_ddp_ops->sk_add(netdev, sk, config);

Still don't understand why you need the io_cpu config if you are passing
the sk to the driver...

