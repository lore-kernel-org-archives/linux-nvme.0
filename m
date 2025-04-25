Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EBEAC369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 21:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=2REVzkallbXfQhg+3rJatqJrZt
	Z19fsvykxD20Bt14LMfZYaw20IosnQHk5tqAITr2iRTrqeeL5O+1bdY0GasCTcgUq1KCRV+cybd8f
	vs70XK3+OmcEYEtWiEdY9ZWjYvJCCiTe5HRxVztZL/ASFg4UF/UWhI2W6h4IbkaZAgYR5tRVTBWwu
	nAvcJ+9j+4kJdn6dvyX+K1S1vfkILShASJFx0S3yJefUHi0aPUFkneGVQy8BtKSPGtC3dO3J4Udlu
	BKT2THePBnxbP9Qt284PFz4F9SD8wgYjOKY7SP6AhxWdNPjXl5+XAf1oq0qL7U9H5ZMC89/R2hl3k
	sL+OQRkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Ql2-00000000wSM-0Ys8;
	Fri, 25 Apr 2025 21:38:52 +0000
Received: from mail-yw1-f173.google.com ([209.85.128.173])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Qjk-00000000wO5-2jNQ
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 21:37:33 +0000
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ff37565232so22990597b3.3
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 14:37:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617051; x=1746221851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=XG8UbHvnm4WYtZDoasm4EDlcsdlBhRDmPv4BRIHra0N45xUZk9bCNjfEcDAKTleGP4
         yFo3HOZL/5kcZ0HR0KM5boSpjE+dGgAbkqUSXR52Bp52NVjEV4+B5WoCwK0RjIFKi2nv
         Xzxw5pmpi0KlFPmnxygaBURgM2lQKo1/5z7diiMOQos526sbmARYKayETnL2VGqKubi0
         kWjK59m+uQwtqgf1RRuUrsHYStC4TGQQgdF3B9HcKC2hXD6KwP4s+DnNhwWZwG8wvCIn
         2PupLIRT61LwTXT1OHBtKKo2/rIW64lwLv9v5GQyGQmOYnlNkSU7EatUWREAy/mBxPTg
         UgYw==
X-Forwarded-Encrypted: i=1; AJvYcCVXb0qRicCkMoaK0xtdMNmfmGQVQryV4qo61/xeCaPNP2PV9LpXzIpe+aS0BbaJDwb74g84MzS0ql8V@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4HOzJi/UBP4gDqr2/DvHmLYuA2Jc3xsVeY//Ax8+rHSxo6ssj
	rMP/0EImO3O2Txao+bXIL32Vfq5pQ74Um4XbuOaZ+DPVjgo13Ppi7Jl31w==
X-Gm-Gg: ASbGncvYfrxY647diU/54CcwJdhZu1dpje9ptKfShZ+WL3lWlbpRTWYmjb6iy++m8Ct
	VQVun1GC8f/lFNuaoWj75w0V3e8pRKY02IWMuBab+uLPNB0TRegUhUm89TsJ3iaUbZb3Ml4WK4/
	pOupOvPdvnTJaBQe032YLANB5qHn/SOHkVDBrD6hXDor0jS42UfexuubgYmLuyhWFrA7jOlZCrs
	Wp8Egqg6hW2qmc1VAa9W9BeX+Bj2pU9oekfwSEES3XxhI2Lvi8+ByJt7wk0x/pwnyW3U1abblkN
	GJ7KLrPD0awyRb2UetGodwOrQWFNDg0JrP6pwsAk
X-Google-Smtp-Source: AGHT+IHPAn25MmDclFUAwwcg6IGxvUUY5ue0gIORcrncIbM+mpEE3FoAyyIK0Wmjk0gTh9bI689vAg==
X-Received: by 2002:a05:690c:74c7:b0:702:591a:6958 with SMTP id 00721157ae682-7085411f45bmr56268567b3.22.1745617050944;
        Fri, 25 Apr 2025 14:37:30 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70841930be8sm10825737b3.10.2025.04.25.14.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 14:37:30 -0700 (PDT)
Message-ID: <f2c1c8b8-4a60-42a8-a180-056a11db6439@grimberg.me>
Date: Sat, 26 Apr 2025 00:37:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvmet: Authenticate on admin queue only
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20250422091556.145494-1-hare@kernel.org>
 <20250422091556.145494-2-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250422091556.145494-2-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_143732_693502_2BF81CD1 
X-CRM114-Status: UNSURE (   5.44  )
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

