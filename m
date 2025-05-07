Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07948C3ABBF
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 17:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=KfXOGkCR+0vTruLQ5XQO6PGcH8
	PwZ1uAZ2QAg2l5BCFeEz5W2Al9c16OJ9xsOhVjEKGXfpBGC8LObQqwgMmYkKgpymaQ1f1Zv4QrnjS
	WGPCXTS6Q8OrUhpATA0+wFfTWsXaJUVQ7gtaGWvCFYvzQawgpiR762e67GbwVygyQzxpWOwAftKFC
	/6nec5m5uzNQ/HEsEQY61Mv6aI1Ip5BXEua5tlD2lBIuGaCiZ0sbv9kdTcDe8NOfAlWQHtLCrwi8u
	texjvwDWQbOn7o92Pk62EObCpp2O/KijIoEr7KqqUhh+4woN/bsFzlZ3DmiK1Quh8NT4uEu6IJvwM
	iE/EeEkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCiWa-0000000GHwT-0gFr;
	Wed, 07 May 2025 17:25:40 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCgoO-0000000FzeJ-4Agb
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 15:35:58 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so62335e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 07 May 2025 08:35:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746632155; x=1747236955;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=pi7IdbyvgOJuzfIjC9WsF8aSjxqdK0elzsglnpwz9ihGNnIXzUD0Eqc13cBoAnrk2Q
         nwqm8JGiIGLykgdCqFZdX2QN8G+BtPGtnmXOb4vraDOuxFOjM30Uz2+vtgBNQL8S8wP/
         9Yn3d4FBwjw9zjrypBKrGGmhb8jjxfPnhYZVI+w+723vHhzUc0bv6w478azqmBkefmmc
         B9GutQZJjawXSFssqqXnq2ug4vzq39tlwbmxw1lfIhSKhqpFVA5GWXz4Z/LY2Ztu9M1s
         7YU9sQ9H/YNuAknpA8J5/PxjXuwInx3PxKdxnD78icI9Q305KYwfArOIaJJuLGf5UC58
         fnIw==
X-Forwarded-Encrypted: i=1; AJvYcCWqmiXD67bkt1958tQDO4YncoU1kVjCamLe5Cv/RaShOJoUyUGhOzc19HSFD98fs45U6hfec7h8o8+Q@lists.infradead.org
X-Gm-Message-State: AOJu0YxQ/YKjoTVM0blNfLfAGGj7zFmLS8LAZ/JBDoJlYAkPyLq/r8pV
	1YlLnvyLqR52vNpZ4gfidAlNNlYHjzm31cJED1r5Okl4fS1X89Uw
X-Gm-Gg: ASbGncvTV8lK4Ea0oGwPU48iE2RUwrJ2VY6wr50Y+jhETnWl17tQ0S1SpiALWwxuYyK
	kgZ9Khx4ovdQ0dyimO69qSG/eqvpvGlmv6yIstzZl+hQeb2/CbivGtme2TiTlRxnnclQKZcNHrd
	7ZEykRcxSdHOhbMDHHCJOPPtQ2lCtAnhG8LHBz8EE8v9pN6xBFNEYt1X9huuchRxx1yJLalxEru
	rKwJJpauGeO5WSMYcjCeBx8xU3GsUAguuUUTteHy8tjIH1zc83yhUC6O4oMs8mB5yWbU5sTUTZS
	gDjXs2wBbjK7qxBXtX9uoXf9BJaGYShBA5h5lNZ/+VCd27vy2NKPT/UClFpXpMgFlCZqyd2DigS
	ao2FT3A==
X-Google-Smtp-Source: AGHT+IGiOr4SxpX8KWlJR572ZILxJmet+uuIdlr8DZlTDzT4zYf2DpLQoH8ENn6oAIzBxFPpjVQjIQ==
X-Received: by 2002:a5d:47c8:0:b0:3a0:b294:ccc8 with SMTP id ffacd0b85a97d-3a0b4a21b0bmr3032175f8f.59.1746632154419;
        Wed, 07 May 2025 08:35:54 -0700 (PDT)
Received: from [10.50.5.11] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd350f56sm4539555e9.21.2025.05.07.08.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 08:35:54 -0700 (PDT)
Message-ID: <5c9a5e51-8149-4506-9db4-337c641b23f8@grimberg.me>
Date: Wed, 7 May 2025 18:35:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/handshake: Add new parameter
 'HANDSHAKE_A_ACCEPT_KEYRING'
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 linux-nvme@lists.infradead.org, kernel-tls-handshake@lists.linux.dev
References: <20250507094049.26181-1-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250507094049.26181-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_083557_033281_4D030DF5 
X-CRM114-Status: UNSURE (   5.45  )
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

