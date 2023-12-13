Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84726C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 13:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=hKiiLng4SYkSWtDeR2norqob79
	SOa7pt05Cc54TNuWUKpGtsrfD4w5bzWVwqmWIZItI+qvKqL3TZLljjonS69+S6d9LaDEWR6p4rDqT
	PIT75iMrRF5LOK7auSF1yMEHEDJhAlKcedjrpg7ai+38iwbhrsr7aGyai4Asf8ICISfATjOgviasn
	EJPOWSdadLNnFJ89O3hXfSfy8Bq7nE2YTQpnVC4FxAYW7ti86TD+boo6t2EK1dfpJhLHGX9oJXgMM
	UMW7fePbYnt8hw1pzk+kZ8kBT6alzbEEAUniFa1u4wrjaDJ7DQ3EGdVo2onSfb7QoqHh0dhwaK6Z8
	jKBq46Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPLd-00Ep7w-25;
	Wed, 13 Dec 2023 13:32:25 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDPLa-00Ep59-34
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 13:32:24 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40c32e205fcso10889575e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 05:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474340; x=1703079140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=WfP5OGWe90+EpvUZw3HwGLwHyzTugiSM5gN7Iq9chV3rpEliJ785m0Dvj9XCku0ZO7
         +mVHlHW83z2yw8ItQ/KiDr2qQk+Xk0BlK6hTvLshQL89badYSq7BrfcfXat7YOqZxU4d
         ycgzfVYftAgaEz/CGvbMOHluH+Q9Vd2aNMqfkyDJeemWcnigj4AuDRnHiPYE8spiKiZW
         eklRrT5YTVN5AzAEoTy2FnSbwjmMdRUdjo1ywz4l1Opv3/r2cPqmovd6l338MK2nl57W
         NmaVkTW9suG/uXvGkiKu+Ss0d7cxBtw1enFR3TaEi5Lz5jwwh1q1WcVkGX4sokbD1Hng
         OKSA==
X-Gm-Message-State: AOJu0YxqsUNyQ4aSieAjokVcthc7THI8II8laOP1Yo9jx1T5x4s//bSi
	iUJKTQ4MM5uOLHa9mJWjvwzLjXznDGU=
X-Google-Smtp-Source: AGHT+IHtiL6TJ1f/jklrbpRjsZM2kHXTri1pJJ+Uo6bFpgPODUxd/iNWnh/lfKZOIQHTwXfHtWPWbg==
X-Received: by 2002:a5d:44ca:0:b0:336:34d8:3da with SMTP id z10-20020a5d44ca000000b0033634d803damr2202195wrr.4.1702474340141;
        Wed, 13 Dec 2023 05:32:20 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k14-20020a5d524e000000b00333479734a7sm13308331wrc.99.2023.12.13.05.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 05:32:19 -0800 (PST)
Message-ID: <2fff2da6-1955-4a02-817d-2ab5fa9ee249@grimberg.me>
Date: Wed, 13 Dec 2023 15:32:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/6] nvme: add csi, ms and nuse to sysfs
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20231208105337.23409-1-dwagner@suse.de>
 <20231208105337.23409-6-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231208105337.23409-6-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_053222_991976_F59245E4 
X-CRM114-Status: UNSURE (   4.93  )
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

