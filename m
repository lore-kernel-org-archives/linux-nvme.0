Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879E1C30653
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 14:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1EpmxXL5gv3tzf9J5nEWiNKc5ewKvpdm9z6Ko/NiZpY=; b=dIowgturtoFd/VXzWJFRp2E/XF
	Fyxir28SJdK/OMAFxCuIr03V1Aqj8kIoPVb8UZJVTjlXemAaHI/Lm8BJD2amixjkZg9V1wbO1T0z3
	iNPlCoOWcVtC3l3kuvt30wKA4NSaVnXm+K6J3PlJUnhaROEeuFIG8ml6K9Z0XJuUFlJKoqDs/LOVZ
	x3VhiMGvaGdktWVnXw034RZi+gV7h67G2aqlEIEDJeDYQe3MADkifQAjCcwd7FRsNLxXk/55b6Ti8
	59UrgI9P6deRnhYpDZ/PU+sYRpLTsVkBz/lxBi0DjwNQdXqe0Ye9/z2pqobQFqbd/ZSUGznKQf1sy
	OdPl9rlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0sa-0000000ASZO-1a2R;
	Wed, 03 Jul 2024 14:22:40 +0000
Received: from mail-lj1-f178.google.com ([209.85.208.178])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sP0sX-0000000ASYa-0FEJ
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 14:22:38 +0000
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ed5af6b214so4942001fa.1
        for <linux-nvme@lists.infradead.org>; Wed, 03 Jul 2024 07:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720016555; x=1720621355;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1EpmxXL5gv3tzf9J5nEWiNKc5ewKvpdm9z6Ko/NiZpY=;
        b=AILoBDJeTtGo+E7yLW692TpvzxBumGOYcn8pTEpFK8LZRtqCIb0+OafT2BG+3iU0b5
         baz0juQ25NEpoQ/5eCp8L5Q+CSBvFl3OPOh1fOjvYZbFe9vdP3nB+4pHcMG/HTLdAr6X
         rK8DyCzOuIsQtxlh9OtctboNfK4JJww4kNrTaYvQIUxh/6pWwc6jt2IB03CuiqR/v80Y
         EAIC0GKIqkxFe5+MlR8PmGx7FdOOXWny1HxG7ypnFI0GF5+GOMZQvRCDup/EnQzdMxYa
         O4n3/uOxVaU4gBixb+ZXMqxCXTKt+RRLxjWIWeiYquWAhNOklb1FLM+4p8oy7l1RV47I
         QBCg==
X-Forwarded-Encrypted: i=1; AJvYcCUJEhdMC2IyauKpFSj+fsWl8Vq3CMs7nD1go989xDR0x6NwkFhU0WtsUFuEop++NBqRmLtp9aCn5ZgxlREIgdRAyYSIoUWvnesqNATLE0Y=
X-Gm-Message-State: AOJu0Yz1WdURDv+EhYLlr9qiTdCUqIIoHOMZR0LUZnx5maa9nhm9iqmr
	wXffqOR5TmZ9HIl1RQUanmiHaXGJQXmFpx6Swc6v/LXQoShi5n7+ixsZEVWA
X-Google-Smtp-Source: AGHT+IE0xRU4IJaqblNMT1ZFb26W411WNGhNyd3Qz5sysd6HNVgJS8bqxxI8EAL3kAKcftjC+MW5xg==
X-Received: by 2002:a05:651c:b23:b0:2ec:5467:375b with SMTP id 38308e7fff4ca-2ee5e2a77c6mr93577721fa.0.1720016554399;
        Wed, 03 Jul 2024 07:22:34 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5b677sm238066705e9.18.2024.07.03.07.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 07:22:34 -0700 (PDT)
Message-ID: <1259766c-234e-4958-a16f-9de753a4a0b5@grimberg.me>
Date: Wed, 3 Jul 2024 17:22:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme-tcp: switch to 'cpu' affinity scope for unbound
 workqueues
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240703135021.34143-1-hare@kernel.org>
 <20240703135021.34143-5-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240703135021.34143-5-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_072237_132533_FC8CC040 
X-CRM114-Status: UNSURE (   9.27  )
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



On 03/07/2024 16:50, Hannes Reinecke wrote:
> We should switch to the 'cpu' affinity scope when using the 'wq_unbound'
> parameter as this allows us to keep I/O locality and improve performance.

Can you please describe more why this is better? locality between what?

While you mention in your cover letter "comments and reviews are welcome"
The change logs in your patches are not designed to assist your reviewer.

