Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F97CE7AD44
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Dec 2025 12:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=D7Rm5TAioAZfgX3bKVeC4agNJF
	QQnpIyXdNd0mnSkDctq+Oo7VB6+yV6UeKCGPNZnP2FN+KBgl+x4QTvNLKcynbmCZyK05cJQXCpEKv
	KxlamSLPyAl1fQyhzF/PrRG1g2M6UnMsdADiBya6CtWc9QaHS1Oo1KJUer5sX8VhxU0q6qfsrCVls
	Ncl5GMzQpj5ZS0q/hLlUntt0Ji30Kd3fcypwhSOROw6KL+4jdXuj0aGjX2RRZp8FqgZrA1uO1JDjP
	3nBxYTRLOOaMYp9onKpQeF8opUlk4+eXbJk38rHY4x1a0ca2C05pZm+t0HHXGSXZR41X+RMdu2qZ1
	XlEjs0Kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYklM-00000000PyF-1XCd;
	Thu, 25 Dec 2025 12:48:16 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vYklJ-00000000PxZ-0mNf
	for linux-nvme@lists.infradead.org;
	Thu, 25 Dec 2025 12:48:14 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fb5810d39so3583170f8f.2
        for <linux-nvme@lists.infradead.org>; Thu, 25 Dec 2025 04:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766666891; x=1767271691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=nbBbd/kOp+62/c+ze81kdAQFEigvtGKdJGGILvOkl9yPiTZSsLe6fr4X/8lNT1vjhJ
         VOsWALLwHKa+z3bGi4g9u7isiqyhC25rvFcyRt9F9pSAn/LX36F67sqGG9oLxpf3BzXM
         UsKKvLY5SlOcVZ/htdFkHm/7HKe3BP+DP0ruyY1hoXXV4D/aQk6t9F7lcr+HMeASD1cn
         djzgJjN6pZEWlgLIliv6F8ZspfPuqygbostRmX7TsChm4TJugKl9p4HYKxVGv6X13u3h
         W+7nTdczcZKtl5xqA1AHfJeETP4kIR00sTkK/3AkLVxoEZMyANgLvXqLK7B9frg+Xhob
         kKMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7w9X1FC3XlHDwXDZWqWMZq6JXXj20QNNXVlEjMOSpmnqf37mf5eLdTWtucFqQgR/hNFGD+GLm2n1U@lists.infradead.org
X-Gm-Message-State: AOJu0Yye+twy2XoL2GbsVJOGpWJnosnuKrUkxRwjPs+gP8UlgwrJeX0u
	M/65+y4CIqx42RlphR8F4lvfZP05gGZOtGv2DsHrPBDQjl4lsdFZZSuE
X-Gm-Gg: AY/fxX4+KOurrhaTqWfnArm0br85+gA2s2YiJa7I2kIn+KQCzMuW6C2Vs8UkAfx77t7
	IdMs6KqgQQo6ZBCYY9lziTPoulYo5nr5pYDVXtc19+guDgfE5WMtd0hVyQP3rduoF6ZtAaVjBVO
	GiTcFVlZLea7BfPoTkZQwZHrDq3O8TFu+5C+eqSFY2Zc+tdD0jtD0I/bPkSVUzKB4e/oc5V5t7t
	GAjCoMqI9zGWryPxpcUDvVyoeVTjosXyVtWsdlBSYSDtIMyqlhAlg5fsIn1T4To4g7enD77La+D
	MPP2o09zfnMy5PVRo6ZJD+LSIUkGUCl+Vl/UpYWQsEca8lkNRWCqfDw7ISl4r/162JLCL4WnY+U
	Lla9Lz0qJkaaXcTqOKqFYeixHkjVYjVZhI+yuSML9mCw0mr98MMgHvYH68Bn9Fi7+RnSlF39i0u
	IF0sBSesOwphuZZxzxeJMlYy9GRzpFUAd2mYTqF5QS62hPRQ==
X-Google-Smtp-Source: AGHT+IF2Wmth28U9F5uxX0dLefBKcteCh+qgLtce5c+QZTnbibe6/zlcKha8jJU4QLMOOsN938iIrA==
X-Received: by 2002:a05:6000:2886:b0:431:7a0:dbbe with SMTP id ffacd0b85a97d-4324e4fb399mr23247652f8f.32.1766666891083;
        Thu, 25 Dec 2025 04:48:11 -0800 (PST)
Received: from [10.100.102.74] (89-138-78-197.bb.netvision.net.il. [89.138.78.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab2721sm39430969f8f.39.2025.12.25.04.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 04:48:10 -0800 (PST)
Message-ID: <b1b6e935-a294-42ee-b014-7e33c8ce2830@grimberg.me>
Date: Thu, 25 Dec 2025 14:48:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: do not copy beyond sybsysnqn string length
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
 Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20251221073714.398747-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251221073714.398747-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251225_044813_328140_7C9CD699 
X-CRM114-Status: UNSURE (   4.60  )
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

