Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DE7C3DA60
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 21:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=NYbklpjW9tUUr4XUeKEl8SbsIV
	KHSCUqZssx55F1zs6NV9KMW1zvv82rmgEL/pzYzWksGZ874xlmWOHohE2mef8yfQIC4A+nWUudzCN
	N8ITMC6DQa0DQ7uevjFzR+sUx+SLC0VnJ5GyVfjV1m8KKThN1tag36chEASSGRox1V8sUrnVm/FyG
	w3yYsXgJVKmCb1ibcWsqIPJclcyWiJzzLe07kY4h1Suw8b3FO4zTkXe530wQ6hpoeqga24Dj4BKW+
	oe6h90ieCZUmO+yrmCuRPtP5cvfp5KSWVJmWnVb9iIBp72wc435qzDrIpWwpBhht7QOeQOjqDi6h3
	yS3TeJXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUC49-0000000Ex95-39aB;
	Wed, 17 Jul 2024 21:20:01 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUC3x-0000000Ex6i-1BU0
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:20:00 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3684b48d586so4735f8f.0
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 14:19:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251187; x=1721855987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=UtoQayKJexFxOIXb7eBsUUhefvczaBa6tgYjruUutFWb78rNYrz098+X5bmiUzD9Li
         7tckqBRQWV3EaUpuxXKgVYPDl1r9dlANqZwQpEEi6mMRMMHsYbtcOO7JPASZsSP6njz/
         pRRpjku4oJL7gemc99UXXM+E5dQMC8exppmnKhFB8fgL6WY3sLs026vBJ9tNg4rmoy3p
         SWIzFr5d6LwsxJfaWV3I2b0Xpv2ooPN462PBl0MC7M2rfK5JiqYuiUy4m98C4V51VlCa
         hilgmrzSeUYZWVwhedZK4COvES5zVT15/LjfTa6+tUGLHypRF6fuQBWL2rfus0Uu1can
         XxkA==
X-Forwarded-Encrypted: i=1; AJvYcCWyOuMNDhoyOZ4eX4Svpc9gYlYvLxKc4hn8Gy2K+xQ1iuopK4JQWlgV5RHZdWFILthgH9/Ir9BKds7Ux0YT97KYMA4zMrO74nWXU5m868k=
X-Gm-Message-State: AOJu0YxyFzCokIjTTjGAWBwZBO2m05475d/6ktyt3Hjrfcs/qdVHhGce
	yNUKir1f6lTbdfdD0X9RIKCTsRDKvmy3SSx7bsxfKhmQmT7g8pcn
X-Google-Smtp-Source: AGHT+IEHz2NXXcYHOegRrWIILOiUTt6CUnI33IcfXup/xXHEUUtz3s+feVoiAwSsz9fnks8/vtzp5Q==
X-Received: by 2002:a05:600c:511e:b0:425:7ac6:96f9 with SMTP id 5b1f17b1804b1-427c6ba30cbmr6160935e9.0.1721251187466;
        Wed, 17 Jul 2024 14:19:47 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafb99fsm12604604f8f.84.2024.07.17.14.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:19:47 -0700 (PDT)
Message-ID: <06eb20b5-8dd9-4834-93cf-fe008d50b085@grimberg.me>
Date: Thu, 18 Jul 2024 00:19:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] nvme-tcp: check for SOCK_NOSPACE before sending
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240716073616.84417-1-hare@kernel.org>
 <20240716073616.84417-8-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240716073616.84417-8-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_141949_330231_7C09F82B 
X-CRM114-Status: UNSURE (   5.35  )
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

