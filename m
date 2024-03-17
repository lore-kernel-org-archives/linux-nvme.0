Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9136C54E60
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Mar 2024 07:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=rpe25KsIELbEqwYV4ahINKVll5
	BRUniFosijgQV5hFQd1MZE7hV1JDmYBFPFWqouBjmy8YVqHSkuxI1xz8ETNNBgc4QVlHeq38SzVU9
	WJlznb2HlWLr4Ob53FeEPhcke5c6Ev8f5VjNqYYc5IUpwp0874M9Ze94BBM6x2T6GHhBCW7OwxDSQ
	G7sinePtyO3EYII7F/rqV48B38zbr59KVqU6MS12xFFc3Gajijhq4dkY++XObJ/LQp/DO6a0HIjpI
	WPRt13rcFvRjcsSDS0cpq3Vc08GH8bZYfLMq9+gG2/D9m3IFC6CpCzhtq2i+bNQOEOi4GUo5RjWSd
	v0oNVdfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlkyw-00000004fWt-1Wwc;
	Sun, 17 Mar 2024 07:30:58 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rlkyr-00000004fWB-16kQ
	for linux-nvme@lists.infradead.org;
	Sun, 17 Mar 2024 07:30:54 +0000
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33ecdffd9e7so670244f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 17 Mar 2024 00:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710660650; x=1711265450;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=CpgCivZiS18ynhFbcEFLmC3kQPHCTZK5n92mhy+8tE+K1GFD/9oLmbQa9To7Vl0mc4
         SyqVefeD+vrpt2Ni/XKO/dOvDHuVMYxRdkk3ynW5WPpNFuag9uQA0LRegfY5qTzArTVj
         3M/zJ2dUBnizhrgM38ecWaxlB15a3T2t3DjI9U1lnnJu4tzO9d2D+x1RNmg88pVDwvFZ
         iDJJOREinx1sLJr0uoebNgrp+RrDFnwZXBHMSRnI2id1RvR3nCgrUf+DRfnoEkpsKSe9
         U9nKoAPGdLjQ3Y2fMIXFnc1pJQQu+s3gVdjICvEDEREzA8T80GuFytKs8sHbs/KF4sfb
         6V1Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6hd0dMuKyALsRVvI/Gqwqxn7DQwQYyp1PLute0YXYdRAjgSs96teJSA2oz5+YlOC7VgUZ7MvvHD5d41bvVD57vaR0Aj73wRMP4hhbWgY=
X-Gm-Message-State: AOJu0YxVUiDlw3u8AzcEC8BSXbTbSfzA8mpKuQ33KQLLkbP/hOOYZDAh
	moomIGJHU62FIC20LuW3Oea1svuWhCgietghds0FGukjmGgXbBbU
X-Google-Smtp-Source: AGHT+IE1YedpIs5EDAiT+16B5tDyqlOASHCmlbPIoQt7Cazm2Aoe41mMn1s1CeLOEg0pVl+ZlOw3GA==
X-Received: by 2002:a05:600c:1c17:b0:414:225:3699 with SMTP id j23-20020a05600c1c1700b0041402253699mr4358587wms.1.1710660649695;
        Sun, 17 Mar 2024 00:30:49 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id r11-20020a05600c35cb00b00414038162e1sm6341183wmq.23.2024.03.17.00.30.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 00:30:49 -0700 (PDT)
Message-ID: <44dfdeea-973f-4bfe-b72a-96513f447b5e@grimberg.me>
Date: Sun, 17 Mar 2024 09:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] nvme-tcp: Export the nvme_tcp_wq to sysfs
Content-Language: he-IL, en-US
To: Li Feng <fengli@smartx.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Anton.Gavriliuk@hpe.ua
References: <20240313123816.625115-1-fengli@smartx.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240313123816.625115-1-fengli@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240317_003053_331180_AA4647B2 
X-CRM114-Status: UNSURE (   5.72  )
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

