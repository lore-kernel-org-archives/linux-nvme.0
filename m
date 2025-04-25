Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B5DC369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 22:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ckiUV8HeIYQ/rsOxCbMNm/VjxU8EUESI63njQcctYnQ=; b=yoOqbRA20me32E6DZty2ltPbWp
	cM/1Dff8enfVPljBjrQXt/1iaX4MW1+loU8opxaJ6MDoD3WsuuU9mR9yWk8Q/MMQy6bd6gpweCblg
	3EzcZixhRGfIi8teWxOhVPM+Ao0kyiT7yx+pIdU//J15hQEWOegItVsSxjuVieWeN0k3CCNi4hk3v
	gNzC/ApjpTD/lPbNnPto12KtcW6EJLBFVCIrD9aRd5Jc9vUgIgyXslpITHSUdOGZh+63QY/fonzk0
	UWyCvZNF0lRRTFrW8qBgDia8FQRdbMtM3mgb4RjjxiTubqPSqefik/DQm3Jq0QjYW0AJoZ/+5FS6W
	qL3PQCFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8RGR-000000011cE-48K0;
	Fri, 25 Apr 2025 22:11:19 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8RGF-000000011Zl-2FjU
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 22:11:08 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so27102175e9.2
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 15:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745619066; x=1746223866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckiUV8HeIYQ/rsOxCbMNm/VjxU8EUESI63njQcctYnQ=;
        b=cHyi3yu7qQerZHw6PUt59IOPjqng3MTpKAMdDgeQaOtuzbMgZBrqO0aOaFpE8FLZtj
         piW5GxgO1wOPrzkoQP00W9MxPewbAETxirOWzP++XJSr1aXzznMiK6ykgKQsLo7YrTGS
         cFjZXCUMywlNU3aBoBs3Y+43TPEBSAgt6cC6heIwRAkHyVofGmogH1EzHlH1ju7qxQTr
         ES3Y7tZdRGx6jdO1EXynb5Pdj/SOicJFsiEHgXyKot++hIvuvqEq2y2QSAVUlBQtnDOS
         0bBWKQzm8R8Rc0acbXJfl3uwCjhfNeKOmrxdl1FJI3vFraxZYHJsnb5lC8IR3cXDmlEu
         ZHKg==
X-Forwarded-Encrypted: i=1; AJvYcCUDqhhhrAIXsRHLesA/hbs2lekW/BspA7mLfysGKorRgkbJ0oRoXl/RhyvQpvIYFAe/RXc+0IJN/Al0@lists.infradead.org
X-Gm-Message-State: AOJu0YxNkbvac8MnslJJMv94O4FL2eATDbhjtJNsCaLxwh+QsBvjvwi+
	pimBfvLt1MDH1RORw4nrYoerp1W+d55o2E7zvLR7eRegttS1943G
X-Gm-Gg: ASbGncvGNopC9zeivPBwx619ubRzzpUDY3ey0n+5CCTla5xnGmeDdPUVYHJjEIEJ8Di
	ebbWS6F9SPeULYFApWJeqeheNuUxsIo06EVgoOScQJjUFrJhXGbrDUdDY819Y4hBc1UbZSmasmG
	uq5HxVpuLxkBLRPXaqrpcGH81YsMfA0LMqz5r6RtIyahNiRnPKZ7o5l0rAakaED4Wv8ryHJkuzr
	kQH97TNPhGNZdidc/kK3Ftcq9AFHIGJzMqYeS9wPUfVeWoKqqlgSf5bzyn6x3KW0MAcInQtP7O9
	rTLsUsl67CuXYordD0SJnGLPRUwnCCeom6HnfH8X
X-Google-Smtp-Source: AGHT+IHvEzb7jM8S26s9kOozO9T3DLATaeR0NrOarikeDIv9/fseE1Rr6rxwWwcH/hVl2u6VyYnrLA==
X-Received: by 2002:a05:6000:188f:b0:39e:f89b:85d6 with SMTP id ffacd0b85a97d-3a074f798c1mr2865149f8f.51.1745619065910;
        Fri, 25 Apr 2025 15:11:05 -0700 (PDT)
Received: from [10.100.102.74] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5c68esm3446234f8f.82.2025.04.25.15.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 15:11:05 -0700 (PDT)
Message-ID: <8488e7ae-f30b-4b11-93dc-1973e0dbe732@grimberg.me>
Date: Sat, 26 Apr 2025 01:11:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: don't restore null sk_state_change
To: Alistair Francis <alistair23@gmail.com>, hch@lst.de, kch@nvidia.com,
 linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, csander@purestorage.com,
 shinichiro.kawasaki@wdc.com, hare@suse.de,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250423060621.632581-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250423060621.632581-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_151107_580426_FD06C2BE 
X-CRM114-Status: UNSURE (   4.41  )
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

Looks good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

