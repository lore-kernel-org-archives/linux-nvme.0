Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D6B0CA5534
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 10:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=u170OcCBXLj6MMryTUJDvfm6R1
	JMjtgZ2tIHx3DyWHqQES7z0x8+xgTJdnkOj7PueoU9DVeG/KkCZQJW7J9d2v85UKVcgw+LbBzHP17
	u6cjobUhJA5Yv6S4YMvd9xen0A/mneUzDT8CiFCDl3VZcXdoLHwZtw3nLEAArWhIi04y7is0VJJlQ
	6R6H0blq74oNsU8OIsGcz7k0DdCBdeZd0/VC7UTIvSReGgKbaUXbHxa00vyn1k4uVbDON1BbafOcI
	heDWg5KdMqauXmE0p0QpNtpQFZiIitLuYJUsN+jX3m4B0US5EqGLXBT9ZVAp2NAuCYkftQBAeVsaK
	rB6f7pQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgNV1-005fb0-0B;
	Wed, 13 Sep 2023 10:53:35 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgNUy-005fZE-25
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 10:53:33 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-3fe4f3b5f25so19489545e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Sep 2023 03:53:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602411; x=1695207211;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=OAd7jtCSRVlxFMnKbAggVyT78Tw9ub8sRZPmgBvZ9basRHswKRQWKhjNbKdRbhMO4O
         +JxYQqm5G82hKOj1w5VWAjlVSnq7QWDEmHmIrk8p7uBFN6dvGj4oZmk+oy5+rT3F25CS
         Pkgea7FuLSNESugfHywR1fkpTtX6rvMwyR5ZyQ6Ky7y8ax65F+fHfSFw2xAN6VGWFqEe
         UEtB+HyobIjkv6Pgh982tPQUMoXD8k/p5dz8tCH3Nd6cSTXuTVVbmUoAzuWtKdWlGf+E
         2Q4opmz0hxYc5NzdwM+HQPWZaHxA9CVdGtULkhR6MDHVXk2XQA1zwIVKvZdXMsTOEhRD
         B0zg==
X-Gm-Message-State: AOJu0YxWP4ydhVnMbZCc18XMos7I12NURJH45nkFayIAJ5QsTLXid+OF
	6xd0GE2AwDBpcR2hJsEnUMA=
X-Google-Smtp-Source: AGHT+IGkRmZ0CR9beBwyh+hHjwDKmORDBKF9RFFeEpqhNR6GfLzRqzTJfhasbDBEewaLGoLOBgC4QA==
X-Received: by 2002:a05:600c:1c0f:b0:403:334:fb0d with SMTP id j15-20020a05600c1c0f00b004030334fb0dmr1712660wms.4.1694602410675;
        Wed, 13 Sep 2023 03:53:30 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id l16-20020adfa390000000b0031c5e9c2ed7sm4528013wrb.92.2023.09.13.03.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 03:53:30 -0700 (PDT)
Message-ID: <917e2f75-ce0c-f631-11f6-0dd86ab114a1@grimberg.me>
Date: Wed, 13 Sep 2023 13:53:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] nvme: avoid bogus CRTO values
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>, =?UTF-8?Q?Cl=c3=a1udio_Sampaio?=
 <patola@gmail.com>, Felix Yan <felixonmars@archlinux.org>,
 stable@vger.kernel.org
References: <20230912214733.3178956-1-kbusch@meta.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230912214733.3178956-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_035332_724137_4F110756 
X-CRM114-Status: UNSURE (   5.87  )
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

