Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950B3C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 21:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=SxvkkaH0jaZrlGACUZ02z+kCLh
	KJecfdC3oA6OMc30ofRBBKc/ugTCrRYsCiK5Gnypq/x7LnHNcfDg/iHrOIwdSAI+zAsRSifVlVWMT
	U1tbFF/9W9uqz39vB2EgCCeoSpgPWbnvn7Y/ppUKBfWghMI3laaJF0aShYi8derb4KlYr2OP5IvVa
	IfGeB8dz8GA4Ua9MlSi4592ff/TV1zNAg0Zfvy3qzrn2GvcJ+bwTyLkfcnVQx6gJiujlb3u23Zrm5
	I84vuAAV+6biwfbA/QhawOvcjyb39JU0+wuhlWmnE5BSBiAyMnZuAQpqnW8XPQ7w8HWomY60zZP7B
	avHHxbkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCcL-0000000F28n-36n6;
	Wed, 17 Jul 2024 21:55:21 +0000
Received: from mail-wm1-f54.google.com ([209.85.128.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUCcI-0000000F27f-147H
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:55:19 +0000
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4265f823147so242445e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 14:55:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253316; x=1721858116;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=BIKgkksfqbB6Dl8RauzThS4FRF3AnGct8e6tvdk7+lYQI2roZMUDapRDEefN+sIymj
         KbOZ4E2yJaORXiubELGpe9BlCkSf5hMlLZ9xi32qFOBtXOLSn33zi+Z3P1ILw5JRq3gH
         e5AoVIDuMWHnSq2zXZaYLL0vJp0XpwUQT8fHzml9VAAR9GIssoFL9XaA0ohKPKDUH+hZ
         8Ij2ZjwYYvbGSEzrQvcWeHW6879ysWFuqOsESar2Cg8aNInzuQ1YArS+5pzpTMYjWGIU
         o35zemGy6dD7OFFphhL0xXv7m9piJNKkmKOOn/1pWf0hC848tQ2nH4Tjigd9IQgYzURn
         0Org==
X-Forwarded-Encrypted: i=1; AJvYcCWMajYpNjywq4ybTn/Zj5nmOOzVvgRFJMdfljNaQr1sALXjAzXyM7f+bcU6L8AHXL7aZ+7ll/NuINRXdhGejrSY7QAkQqRggnqDVkqHcMI=
X-Gm-Message-State: AOJu0Yw87FiVq9DcWgD3Eh9GSsZYKgulI3Bd22dBHwRsWtMhW5ub/7ul
	8if+ee8YwjDvDiwtp+rieDcjmNogRz0lV2ANZrRMdITh6BiSJtaU
X-Google-Smtp-Source: AGHT+IEe9zCdI0etlApryqbRYXShPz2Z3OXa1CgZj7TanE+Dr5twqztFF7fBjrV8lvD39YHZjz4tWA==
X-Received: by 2002:a05:600c:46cd:b0:427:9f6f:9bff with SMTP id 5b1f17b1804b1-427c2d33f06mr14243855e9.5.1721253316501;
        Wed, 17 Jul 2024 14:55:16 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427c77b02f4sm11182075e9.16.2024.07.17.14.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 14:55:16 -0700 (PDT)
Message-ID: <69eb0ddc-d077-43eb-bbb5-eebf3b121bcb@grimberg.me>
Date: Thu, 18 Jul 2024 00:55:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/16] nvme-tcp: check for invalidated or revoked key
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-4-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091031.143188-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_145518_296589_6C0019E2 
X-CRM114-Status: UNSURE (   5.77  )
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

