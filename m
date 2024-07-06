Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3ADBC2BD09
	for <linux-nvme@archiver.kernel.org>; Sat,  6 Jul 2024 21:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=bMW+yu4FLJONqgcgOWtuE17J52
	Kc9W+Z/yh/Y5bg6Tq70GNcAd8GjLGfiLdkBgp6tHCoMLQ9VUxw4XIk3SlOuMKngv/CibAX9GovaWA
	U7yyi/wSUwh47FckeQVnNZW5MvqTBq0N4ivit9DBATfRg4YJ5YlirAJeCdG3cjqBqHATpxNGqZ+k5
	cdlf6pe2OBn26SJwd2S+netZ/1NfbG9hYnuRwWLzCyOV9wH0ugJiL4F9DVKZs47tCm6W1/ltSnqRd
	eEo0AXhl/U66i60N2lqSoKlW7iGRent/jvY+rs6KCrs9mVFouCdDc7iYTxysEr4B8Psun64QYL6Nx
	XpYAU/kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQD8b-00000000rXV-2Vb7;
	Sat, 06 Jul 2024 21:40:09 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQD8Y-00000000rWY-2dXO
	for linux-nvme@lists.infradead.org;
	Sat, 06 Jul 2024 21:40:07 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4265f823147so879485e9.3
        for <linux-nvme@lists.infradead.org>; Sat, 06 Jul 2024 14:40:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720302005; x=1720906805;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=J9hL2rV8+f2ZfwV+rS4a2vL4Xa5ibG0wb+vv09KEABuoqnCTZ/g9J2XKduwAlUixPu
         1xrU6/bUOGR5R6/hP0C0FgP0SVZPs/6FfCKa1Rix7vZh2+3XH0hN/mQjP7+0s/0jzgA7
         TYceNvc9aLQlkyLX/hpUBNID0mCcd7BljSu8hQdbfNdYWGH8K/7+IQs5+xdU+cjCiNu3
         3g6X50ZiJKbgUcTKb5zs5hzxqlvCnGUAMI89W2habcQIcsysAKUagt1ZUG3KwUgQOh+j
         zaF3KP2SBghls3bjh3ZHtkg5CN3tHpuypp+CLQXsFtdHj3affNmuYRCG4xEm+Eta9QZV
         nhvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcqbfq0Zt4TRzecOjLA0Zy51Td19yn+24sCvfGnbIgFJiou95W79WxBdEG2oT69ouqt4owYV0gMeBi4bJqEeaeQ6+qSuvmhbGgZbQS2fA=
X-Gm-Message-State: AOJu0YyRVFxdyn6rUaY2DKvlbz6H9z/VTTZeZDm5qLdtoNkqQK2sAvFq
	LqlJjLrh6bJKtTY53yCIXfYwblDmrGBWsDqrnONAFY0srgpcgH1u
X-Google-Smtp-Source: AGHT+IGkEtO54B+3ReCDSqVIsybKxnDiaxLeBXKUf3x50Rf7Z8EFDFOdqOtXaMtFBTzQDaBRQ8xGFQ==
X-Received: by 2002:a05:600c:1c9f:b0:425:7ac6:96f7 with SMTP id 5b1f17b1804b1-4264a35297dmr56139645e9.0.1720302004812;
        Sat, 06 Jul 2024 14:40:04 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2ca6dbsm109757665e9.38.2024.07.06.14.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 14:40:04 -0700 (PDT)
Message-ID: <41bce6f7-d62e-4a02-a3e1-5dd433fa7646@grimberg.me>
Date: Sun, 7 Jul 2024 00:40:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs/blocklayout: add support for NVMe
To: Christoph Hellwig <hch@lst.de>, trondmy@kernel.org, anna@kernel.org
Cc: linux-nfs@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20240705165141.2248305-1-hch@lst.de>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240705165141.2248305-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240706_144006_678383_755A252C 
X-CRM114-Status: UNSURE (   5.38  )
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

