Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EA5C02198
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 08:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ybAlURBwm145vyUm4cVEytqlzqU1Duc4Ne/JcU9UY6I=; b=WjmtDo73a71RH9qsi2KqiKxoaZ
	YekoMaGgIrmIS/lDY3HBfAxTxioVNC9PWEWp9Cfa3qM/W5IErxcWBX4h8d19iqYl5Q1pC3iT6sAXI
	q8S+DcuVycQKyjSNZmTtzrjjxGYF+mwMDmbZiwmtZBA8VGE6sdkjhuGHw7HxCXJ0nQaCM7sUZP+18
	6/GUHgt1gaPRoUrbMMmfxRhmoFEedG88/nIFR0p8e01hO9dC6aIrgq1FUCNT8Gz0tVg7qMgPhNa9j
	wh+uQGIx3MAqpzcMOlT4jjEQNE3VtLDnBSsDDN0TvDLbceLzZ777fP1FfKUXfSATTfOoxCQcfXUqI
	sBtGWMYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkIs2-00000007FZO-4BJl;
	Tue, 18 Feb 2025 08:22:22 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkIrz-00000007FXZ-3WgG
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 08:22:21 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394a823036so53811105e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 18 Feb 2025 00:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739866938; x=1740471738;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ybAlURBwm145vyUm4cVEytqlzqU1Duc4Ne/JcU9UY6I=;
        b=DruMGlBRPFbCWkRUgeNvSTQqg1+uXl93bOqAsizVqkQJA0vVzUWOVBLpoXfVf73txg
         llFqJdEIk+d/+S10Risg8jI0NKhxIVQHurRvYCOARcTin4a6WN1roH3OlpNOZzb1to/n
         DUo9WQekHG+xLakm9VkAAvgdCKF6afpeW3Q9/CJUbpBUZncyZYpRlG8nbbgCWZQm+M6f
         corsGT13fx3d5u83hmCmK1RMhhBB76B/dALu7DRDT084qKAI30NLOwwiUe6vF4uWug2M
         YwTxV2wGR5MS3dz29PY+rY9C/oWrn33QG/06QuXWDLulr5CDz1E89mAVZpypDdqjB4Eu
         MU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjHDV7Hqbph6y9Pwuz89iglT0MUXKaFUXyQtiHRE8pUk+YDemDqa5AhyIEHHmtLngjeaVmWUVfDuj3@lists.infradead.org
X-Gm-Message-State: AOJu0YytiseRVbpDfVxKvfCI8Ps+G+fiBw9pt+V67rkJ5wzRc8h46HDx
	K4cpmUakYt1EeJfHwIsgCznIYIo8ipl+wqNFe0hGCEt/x5yKqUa7PSwdug==
X-Gm-Gg: ASbGncskYef4qMaV5zuIA0frXN85xfypfTzk4IAqNn95+uwVrzoQssss71h0T8CeEFn
	4VJSqsM+gTszILzpyUvqM2iSmYpjTle423ZkUqsIPJzdx9FUykrOkwEqwhIRZRh+Tv5dRSXvo1D
	ruoXO1CwySB+L3CZ/3lYzRd6ngBcLP58IAYjSSEPc8o1I7fkgFrFnG3X/XlV29vQVzSm9y52KEB
	Gc4q5HJ0cZ5wjJppXGzPeXZrcdEVHemkzlKvnblBADXbK+CYZ3wV9f3yjGLfSAzlQz3ZsWwBeg1
	ShSb3dn7xQhY0LRYosLExZmlWvKpVpYFMcJWmxQ8gApvh/DLNIaU7OjXQw==
X-Google-Smtp-Source: AGHT+IF+dSL1LxV6bKV5wt2/ezSlvi+jDM/F3m1vgZEgtlfiPSwbBLMz1G/d+u10i1Y3BuI7zrHfBQ==
X-Received: by 2002:a05:600c:4f51:b0:439:66ae:ed0c with SMTP id 5b1f17b1804b1-4396e6d7b5dmr95136455e9.1.1739866937979;
        Tue, 18 Feb 2025 00:22:17 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f2580fe7dsm14330330f8f.0.2025.02.18.00.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:22:17 -0800 (PST)
Message-ID: <cdc36db2-5bbe-4fed-8149-a9105a67698d@grimberg.me>
Date: Tue, 18 Feb 2025 10:22:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] nvme-tcp: add basic support for the C2HTermReq PDU
To: Maurizio Lombardi <mlombard@redhat.com>, kbusch@kernel.org
Cc: axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
 hare@kernel.org, mlombard@bsdbackstore.eu
References: <20250217160827.369977-1-mlombard@redhat.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250217160827.369977-1-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_002219_879362_C9876682 
X-CRM114-Status: UNSURE (   5.63  )
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

Look good,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

