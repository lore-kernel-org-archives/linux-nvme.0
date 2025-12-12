Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 775CDD4922B
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 13:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=eQO8TcVAKhzkFxBWzUIiaBkF78
	Pe+Z3iUC0yNUy5Qh1IB/IC0vVD3Yr+BkJVAVgsJuYsuVSx5Pv70vlm6cgOekdYzQPt38dQJ2AENzv
	LdgP9hzw615d6SCsKE3hcVvxcF+HmVL6GsOmBh+O1Amp58PXcEw6681qP41uTRu5VkYBZu/xFP/Ar
	2IkGlio077Ysp2qMUnKtV0Que+X9qlhRZXyKgOctqa9T6w1YG1/nNenvbpSwWb1y0pH3iLwkggWS+
	8MO68YkEEwq90AtUZoxEGYDATPVghuDvReeLcW89Sv2ZIfs37l8r6hB9Dx4GrDk0HHPVH64uGUkgt
	FllrzKmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU3ZN-00000000ahI-2U1K;
	Fri, 12 Dec 2025 13:52:29 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU3ZM-00000000agr-0WeY
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 13:52:29 +0000
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a2ab455fso13859595e9.3
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 05:52:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765547546; x=1766152346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ruAYVn5U3pg6reSP8SxfYT+HB1KFmRorDr+WqgmURb9HKQeGkUJiAzFSsz+x1Y3yLa
         /a2Fr0nZOxAS2o59GtEXrXi+Qxrs+K6WrTXk8hJsdLsDnQXNQe88fAAC/TZpKX5pxYHP
         K8iaVmKdGUX4RI6qtJNN9BLMg8d5ClBaDDDex4F85skdcmcsDc4aueh1ybCMJ3M8oPdr
         f63eglO64ynTHWvJVaSuEi8X6Ka0yidVHPqqHdPSE62TDKw6Xv6IZTneqakgXAhXWIn6
         w6wvxbQAF5evEi+26OMXr62YdhQkMUEK7lZ/LS5IlPptmzoETSzX7NJSMGdCw3XgyhtA
         wbug==
X-Forwarded-Encrypted: i=1; AJvYcCUzaD3zP/eABLXddV01577cUrA8d2Wy80/WuwRhTZS9ByS60INlXhkbCqqbIbs94fQFJ9J6eFEJVwEK@lists.infradead.org
X-Gm-Message-State: AOJu0YxiY+LNDujb7uCLJ2hOypFV5aTA7aXjxxzQkyblHpcerv3inp9o
	9hnuATvGCfz5MTLI7vksOlOJQ9kTQU7TW0mVk7zANylaZTtyZzu7MWNb
X-Gm-Gg: AY/fxX7Vm0yVleptIuDC1kzn943gvb08CLt3drjqU1ADojNYIR9xPwW56JQZVNl20py
	lWfFKCHeOhEu/aSJueqmJ98j6tUOWYkkLodTln1aQ+Zs7HQYhWej9c+GjY9xoeu3YAsZOx9JmBZ
	EQSfl0GT0gaOXsfL5KA7N+Yckzy89TUuUdMsCPPETL0A4QPlFekEOqzrJnRLp2QlTQ+BH2PDPlL
	zkwhpMfY8bgOh8KHNYNP4wCkQch/XsIRxwXVQEF8K8MsotyoHtHVWphBZpm5ssfvFgHTp+NL4aU
	/eM4+hheyDEs5qKkyh+c9mk4587Vk9YJWvarmsVT6Dhm1DgwpJHWMjBAt2eJED7q50p0j+Dh/A4
	hP2WdzkBO+oTzqRTvOtBzS1nhqxt7yWBSrZO6faT/0nNX4r2Dnzd35R/RJNsyfDSMkz1qHhE7qe
	CddT/i73pnkJXMUB2tmtMvAGuA/Ly7NBSdY1fGhpnuchxYtA==
X-Google-Smtp-Source: AGHT+IEcX5sH8HamxY+Ta5EM8IrXPKO0n4JypI42DW5aSGLQ3yNyuwR9k8L9ZNYEnayt6zoQe6mICw==
X-Received: by 2002:a05:600c:35d2:b0:477:7c45:87b2 with SMTP id 5b1f17b1804b1-47a8f8c65a6mr32205805e9.16.1765547546106;
        Fri, 12 Dec 2025 05:52:26 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f7037casm11899055e9.15.2025.12.12.05.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 05:52:24 -0800 (PST)
Message-ID: <ac63d164-4616-45d1-ba8e-7bd3cd16e8b6@grimberg.me>
Date: Fri, 12 Dec 2025 15:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] nvme: Allow reauth from sysfs
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 hare@suse.de, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251202051755.1312158-1-alistair.francis@wdc.com>
 <20251202051755.1312158-5-alistair.francis@wdc.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251202051755.1312158-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_055228_159950_E68F0847 
X-CRM114-Status: UNSURE (   4.20  )
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

