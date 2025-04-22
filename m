Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B0B7C369C2
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 13:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rwS5Z1QObT2KlW52KPIui4CmpQqEJswXv+WZsP87AQ4=; b=XFFj34r9axKnISs4AOrEhLq+D0
	lgt3o02jYT3kwTwYn4hiEaZDVcH9I+KTdFrDv84BzM7Ugpn0I9SiOo9Dt3HUWnSQCayxEr/RhB7cd
	0l7/6lsjfdW9D0EdcP34wPuY46HRy138nPvxf8wkN8aiBYvnyk1i6Vk+ADDoC/gtqfQgci6ENpizG
	OzVeNAU9oRKJAssKJ2G/6skxfWFLae5k9Fr1OMk47WaJSaxPhnamUuCeM9Im4uUht+C6s+PD1DJe2
	mt77+EzQuu+BtO5wlfcaBZ37h3CM/aq3ui4S1VwcIHK9k1vOMR9FKP3ghjvuSriX9qexRpZKdPylh
	jfFaoHYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7DI1-00000007DyF-2jQD;
	Tue, 22 Apr 2025 13:03:53 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7CBv-000000071PV-2nYK
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 11:53:32 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so5391886f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 04:53:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745322810; x=1745927610;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rwS5Z1QObT2KlW52KPIui4CmpQqEJswXv+WZsP87AQ4=;
        b=xODTS1ZDu04VZZLZoWMDIc0tyP2UUQmXDw8z8jUZwhpe72RjEw47PNV9YK7K5wCWJ/
         uFDo8bgri+eUh4h+NgISLGKhQI5Gp4LBoomzpG5holaNAA0OOlHV/3oFAQW4dQsVPVTC
         L86Hgynx7eVQQxHntn9hWrvOGda9+c+L8sthLjzGh1Gmr8Dzeu/1AHFPShNDdjAxDMbN
         6cXo0jj68EmyfWdladr9Ki7NbVHxvWUipdF/z5/eXmC8rLPey7EJrFo7FSS/z9aQBsPA
         TBjW6zb578edUY2SAEWTpVLGCSCFh2yUpCP0JrOnYh2BtjHAKCXuNH245Ot1RoEHuqJ0
         y6Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVQO0vzwlTUnGPEvx/l++H3Ik/op8Vq2nMbEbMoZgA8+tI99Ua2H1TqngkIWe6a+RxP3PyXIZk8YyjP@lists.infradead.org
X-Gm-Message-State: AOJu0YwnYYu2ZgFLDQHHgMTAxdx818FAB3cIYWM/N+Xy4yyGxrzUhjmr
	0LjrFxHEC6L0HgYGzYDehseIrPSON9+MuxaMbRwJiQJfisQBuWc4gAnAYg==
X-Gm-Gg: ASbGnctzjfYZl8KJ0guk68yrG/nOIAuy62ZLYB3HvcfilYpXmXk4O19M5yzsrz4vAZm
	OU0xhTijgLreAyKIfZWXPej+Kgzh1R0YtvTQtO+437z7OTHy40AYUsoMaN+Swkdu9rytnGhCuln
	GlYFh5OWkFXYz4Fa8ff6i2KR3JFYAb2Mqfkr1OL2G5WAw+ydQTzZDmOINqRGc4UZhCxRS9KdRbm
	pE5SdxFllgj/q4qPaHyGYWgWliaTo+4qXl73n7d+/0gOiCBuit0Yjx+Vj6cWeMPUlrrbEj23skT
	koqY02mTDu39uAeoydRKxrvEAmU8wirkWjZCYINV3D2NONBJSKcFa0iH388NRdiFvCTBgkCZZ8D
	6si3kRg==
X-Google-Smtp-Source: AGHT+IFQPQikS9tfx8dxYSXvYg6ZLPFqwkw3J+2/JqN++g0gt3hZJ1+4QT03fAj2WZJLh9tdl0XEpQ==
X-Received: by 2002:a05:6000:381:b0:39c:30fc:20 with SMTP id ffacd0b85a97d-39efbad7d4cmr12337102f8f.37.1745322810229;
        Tue, 22 Apr 2025 04:53:30 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa4a4f2dsm15135764f8f.95.2025.04.22.04.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Apr 2025 04:53:29 -0700 (PDT)
Message-ID: <31cd8d05-09ca-46f9-8753-665feaeb7e6b@grimberg.me>
Date: Tue, 22 Apr 2025 14:53:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvmet: Restrict in-band config files to root
To: Richard Weinberger <richard@nod.at>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, a.hindborg@kernel.org, leitao@debian.org,
 kch@nvidia.com, hch@lst.de, upstream+nvme@sigma-star.at
References: <20250420104726.2963750-1-richard@nod.at>
 <20250420104726.2963750-2-richard@nod.at>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250420104726.2963750-2-richard@nod.at>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_045331_707797_64904C39 
X-CRM114-Status: UNSURE (   5.30  )
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

Not sure who uses nvmet outside of root user, but looks fine to me:

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

