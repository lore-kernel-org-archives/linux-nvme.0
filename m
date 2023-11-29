Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FCBC4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 09:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=bEsUhndrsmLZUOrFCr1sM4yMoz
	IfSoxUc9lequTa6XC7P1bORXs3yAVQzGHfZgjvsVLJiRwGy53gFgWTKAQ+vRt/5b0DYgsKmbYBNL8
	eRbtU+mcwEQRCxnhHi4uH//Y+CWXC58ipLbXE8itxgs31caYxXM1kvqXezNmWc7Qt5zqEeOJBE6/K
	AKkwFxi5SR+tJ5V4bHEpT3GeyKkvEd2e3JPwsatG7HI/UFuJq2ZDOtbKx4Ryze0sqHoBkR1CVc68x
	MjQoC9eiVwDuNZ8UG39E+GEtB1CTw3o2GBwHLpInUnt/xGnR67Mc+9d1+7Mn7Oi5eZz7sie3fT1BN
	eZ2OpQ7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Glt-007cKM-3B;
	Wed, 29 Nov 2023 09:22:18 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8Glr-007cGX-2F
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 09:22:16 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40b4ff0f254so1118525e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Nov 2023 01:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701249729; x=1701854529;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=BeRtVikhO5YebExNbWe0Hlza2s49U9O7FvQ24l5mjuuoPRtXDfnWM7ML0OMc0GpYxR
         k6E1ZprjmuS+RunXIJawOKVNzusEu7cKcmyicR1thvpaHHtIr0d63NL2Qb/ZOwOZRZC8
         gjt2ICyTlBzR9iI/du/IZmFTAGoRnh+SSAKYDYFd5dkQbLMS0EDRxRHfs1ho66u9ejCX
         bUS8YzwNy4fYxo6FK8xc2AR2OC9p67GntQ+Cbul+TyP6sWur4qUSs/A/u9A/NxjyvCp7
         bBn3zh4Kh0Z9C8bdBkdR+KWi4jvOa+oU4IZJUJu8bQLGBCuF0ql+f2NkVzDEVFPyQq+g
         seuw==
X-Gm-Message-State: AOJu0Yzg+pFe5W9oIksW36YWkDfe3ncjdGZRs5OOjHavLGw7fr2/Xpja
	/m12zBpiEKRatjxhZS8Z/0Y=
X-Google-Smtp-Source: AGHT+IF2352qk2ABKk7cSBNYQBLl0iLKZzpsQO6+jTsB/d7H2BYz82b+J0FuuZt2jmiK/PjCZGTARg==
X-Received: by 2002:a05:600c:3d8b:b0:40b:3d6d:e46b with SMTP id bi11-20020a05600c3d8b00b0040b3d6de46bmr10683872wmb.4.1701249729052;
        Wed, 29 Nov 2023 01:22:09 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b0040b360cc65csm1524542wmq.0.2023.11.29.01.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 01:22:08 -0800 (PST)
Message-ID: <4a688846-fd5c-4b36-8ccf-634fbcfe5567@grimberg.me>
Date: Wed, 29 Nov 2023 11:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: Update type from size_t to u16 for
 opts->queue_size
Content-Language: en-US
To: Nitesh Shetty <nj.shetty@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: error27@gmail.com, gost.dev@samsung.com, nitheshshetty@gmail.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <CGME20231128123622epcas5p4940679fbbafdf0da802deea3e531f850@epcas5p4.samsung.com>
 <20231128122958.2235-1-nj.shetty@samsung.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231128122958.2235-1-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231129_012215_743244_3F600654 
X-CRM114-Status: UNSURE (   6.58  )
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

