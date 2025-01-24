Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E783C0218B
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 11:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=N00Ej+mWjOj0hUpFmdnpGsPNVr
	i/CDiWdzh6uWXwlJX9+pgzvmegMBNXQ3DS62SqznBP4uA217iGNIHpYZOF2Z4Qb/dyEDrdwUgqW8+
	inQY3rFWPceg0KaAwRtkk7pGKAQ91ph4h/Rf4YgekQG/rQtd+Bu5vrCwh3C6zPUNl44NxwMGwC2UK
	ub/vsanZJ4tCaBooXZZBepFXfiD2BJXZYIUsUErfZBYm2z8Yce5x1OfpRbZy9gbx0iHGpVKugP/zB
	FxjzLefMEjTgMLRt1gnixeazPDZbAZ4edTpkBj9inhVaoS9+QJOVr38zl6ZnYXvplYOZKfeKvo2Pj
	8VAakMWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbHRw-0000000EWdb-2lme;
	Fri, 24 Jan 2025 11:02:08 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbHRt-0000000EWcW-1A14
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 11:02:07 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so12479725e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 24 Jan 2025 03:02:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737716524; x=1738321324;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=uencuO9BA+7PuPftoBECabM1EpOtS3slz4wOOahXK4FaZ7n8450jFeZscOP+y2P0ky
         /StrcvLpncb7e2klb+vjIOxzPegEFdH4MHvbWkMijbAgfQdVeCHy5sza5PCV4RH1fC55
         GNAh/JmEiDhwmw8eRCLdOe/KWHd8GuJmci6GRU7VnKe+RNxh3AsxjmA9vkguSg8F1hv1
         b8izXFTBrP60Fll26DwHX55DbFL5/X2UGBZtMqEGqA76ddecwS1YIzlIj6texnz2VQWB
         iV0C/5UBZZR0F+BmQljzOcmHmXufi3VdCdpO+HlDaYmhs5lBP6/adaxxmL6AYDF0r4g0
         CNQw==
X-Forwarded-Encrypted: i=1; AJvYcCV9xhVMe6zfM5YiVfUqmJPFPMTR9QDcLUIte1aYEQoMVMuz824J9YGOtzkr7M3aSOq/ut57UazuL0WJ@lists.infradead.org
X-Gm-Message-State: AOJu0Yx9zisA1U3dyTQLkia8DxVaHiiOOwsTmg4/d/fldbkuBKwM71Sl
	+OXBrbL2xsNaWaVyNMJay2fMwBr2R+Y3A/uc01aIHGUZGKzKGnIgEIg+3A==
X-Gm-Gg: ASbGncvGtCq4GWS1e3O7eKX5PqNTzY+AClf7lBorfCfwv6lJtI4Qcs0zi+2/eK+N6tO
	wli9VcgfFHeChTJe9Vx3Gq6ZTrVeBssqLJ9KxtOGOHNKWjWMdTYCqFxn8xYuJ/EgXorZX4rVwbq
	qdD1CYy31cd1N/PVkdNuOgZ87AlMHl5unTVJNlzMRpEJxmWaPI5bByWnoPLjiqm//b/T463beYk
	7h58gqxbV4hsI9AxDsoL0O1crRCY7d9v4o81SaK+0/0BEEgU14c+mvEbE6c4Pt4/N9pCE25EQ+R
	KuSsUiyY9M5M9dF0VbEcot1Jmq43Wj4jlp+WoVEb
X-Google-Smtp-Source: AGHT+IFZhtz6Qizb6oXZMVUNWFZ7epgJO1m0nayWMYuMNbLuV7kmwRQel0kQ5wddAH94zQBY+/UJtA==
X-Received: by 2002:a05:600c:3b94:b0:434:e2ea:fc94 with SMTP id 5b1f17b1804b1-438913cb620mr319795435e9.11.1737716523342;
        Fri, 24 Jan 2025 03:02:03 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd47eecasm22391585e9.6.2025.01.24.03.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 03:02:02 -0800 (PST)
Message-ID: <b16a4d45-beec-430e-813b-80070f455f46@grimberg.me>
Date: Fri, 24 Jan 2025 13:02:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 blktests] nvme/058: detach loop device after test finish
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, hare@suse.de, gjoyce@ibm.com
References: <20250124074753.9802-1-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250124074753.9802-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_030205_317605_99A53B9E 
X-CRM114-Status: UNSURE (   3.94  )
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

