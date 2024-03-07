Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A290C54E49
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 08:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=97WwwVRWtYQ8/aWJm0Z79+FFPyBo55ZYv9K0xumzQh8=; b=Aw8uEDUyke6N8jdNEDYpUgK9gf
	uFaepqy3Ts+JTMY6tYVRqBU5TxyHffgbh9CSnhP8sz0RNhofKgSQLpn+TaAhlD3db48hlIwqAUWG6
	QYeVuUsBoFEjawjuVgA3LKkrC6ibL7G82X5IkLCVzo3c5F55C2RfZG3dp+pL1c9pxej5hV/EfXtrY
	htcyfMv4tJg4Bs7ZEU9KG9gfDBJxOpJNV3VBB153zq+7i+Giqrf+n80BqHUSqenM0gnlIwz+0n7D+
	w5yzHgp44itQIrUg9K8egkarU6dRnebxysmfwBx9gfA/9eMA4ZN7NSIcZKhqlAajU5W8L8XiRnj6K
	pkZhNiQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8gw-00000003X5z-3YLu;
	Thu, 07 Mar 2024 08:01:26 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ri8gs-00000003X4x-1Yim
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 08:01:24 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33d855caf7dso142082f8f.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 00:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709798480; x=1710403280;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=97WwwVRWtYQ8/aWJm0Z79+FFPyBo55ZYv9K0xumzQh8=;
        b=Ihj8tnkBm6+qw864qUGv6mgz/RgytfbqlT9q3qGon85rFNs8zpB0XRYAOzTM644pIe
         M/QoYY7aUNMkrJTxv/NMKdfnelqyGMtaka8yM7L0WUtRg2izFc6xIYurrKX2JD7RKgaz
         ofZo9zWXUIrFbstJPKEEcnbQ338YHD9VG+vDomWlv9VoGGGKnNrV0z4CP958fcmmzmw1
         YVvsaUsyQB5BBqeBvtHSU5nNbVd7SFVhGhceCQiS63RZ/M9Q3WXDD9AWvioE7bcgsxKs
         4g98qBFATjGpmKtKFYTRB2lmhBjjtppTxkWa5cRWIycSodV+lgpZ7bFyaYt6/8y4qrTl
         L8sA==
X-Forwarded-Encrypted: i=1; AJvYcCUViNZ7pJEcu61DhnZHW+vfvjbOvcQT6PFGRttJOGs94p0UgEnXXuESP0an3uIRNAHXPrRWpwwUQDUPgKCsPJ4xXomqp73iM//ZWR9VK1M=
X-Gm-Message-State: AOJu0YxxoGbbASx+F107YRnh/3+P0AZR5WowB393TvplzYtqpI4dPQ9J
	2/uTZUkM2tCSv5zs9XEXwPRIeK2lPxvzPkeR8cUD7K+pS0C3LovR
X-Google-Smtp-Source: AGHT+IEQKV+TqPHbdgnDGZitM4yLSDvWalrVT0e2s/AG4lzy/hat2pJCQd77C97fYqVc7qTS/VBm/Q==
X-Received: by 2002:a05:600c:1c1b:b0:412:b2af:2632 with SMTP id j27-20020a05600c1c1b00b00412b2af2632mr880562wms.0.1709798480257;
        Thu, 07 Mar 2024 00:01:20 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id bj25-20020a0560001e1900b0033e49aebafasm6592114wrb.3.2024.03.07.00.01.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 00:01:19 -0800 (PST)
Message-ID: <b4a7d773-4963-412c-b9ad-fbfd5c461313@grimberg.me>
Date: Thu, 7 Mar 2024 10:01:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] nvme: constify struct class usage
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>,
 Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240305-class_cleanup-nvme-v1-0-c707fc997774@marliere.net>
 <20240305135125.GA2802@lst.de>
 <ZedCG81IUxid_KzX@kbusch-mbp.dhcp.thefacebook.com>
 <bri7abpenndub2ejegge667wnrgqpxhyh2zjozotr6qn4xuv2t@dcibklqxgxcn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bri7abpenndub2ejegge667wnrgqpxhyh2zjozotr6qn4xuv2t@dcibklqxgxcn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_000122_582612_EC169BEE 
X-CRM114-Status: GOOD (  10.53  )
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


On 05/03/2024 18:25, Ricardo B. Marliere wrote:
> Hi Keith,
>
> On  5 Mar 09:02, Keith Busch wrote:
>> Thanks, applied to nvme-6.9.
>>
>> For some reason this series didn't arrive to my inbox. I got the patches
>> from lore, but I probably wouldn't have noticed this series if Christoph
>> hadn't replied.
> This is weird, I use gmail for sending. Thanks for letting me know,
> anyway,

Same here...


