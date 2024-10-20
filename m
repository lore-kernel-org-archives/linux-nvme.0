Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEC8D3C927
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Oct 2024 23:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=xIykXgVLjcsRQkstfnrgdJg4np
	hg5xjp5uhoTV9syicbr+2DWyjkwe1e9ji4gKdPUOoVaFLrQCVbs9k9LQ2jrFt0vCUG19sUbEl440o
	5pmASjp5Ts8ZziANnWVPCTYVyFq6LQbH0uFmacHVXToUwoIBx89RqAI+ksR3orH1hZzD2xRLaynDq
	n2zHfmyftds62N6OmPj/7BB6g46Z7FcBKV88jdTA130gOBcdtHQgMEakd6uO+1Rl7d0ttamwK2GWH
	40/zliwDMCTpW5XxPjz40K27fIHiXVRoTlToJ8Y6PJvq+dHRSR4/FFearFIgRnBxu86CMfZmWuFwD
	emNg9Ilw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fgX-00000005eUW-16RD;
	Sun, 20 Oct 2024 23:50:09 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t2fgV-00000005eTm-0K81
	for linux-nvme@lists.infradead.org;
	Sun, 20 Oct 2024 23:50:08 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d47b38336so2616070f8f.3
        for <linux-nvme@lists.infradead.org>; Sun, 20 Oct 2024 16:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729468205; x=1730073005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=iAPUcxnkqKHtaUK0jMXvMQC4BkiJTbDFPevYBgmAO7fa+OkVgNjmhSVGojwrg8Tq/O
         jE1p6hvyvf1IRnDZSxgDxhks+TIIqnyLQJwvF7Sx77RGdAas5f81PWiBj9OqfChmvDRT
         RTLJB2qVwNhJDUvAL5lJlAvUV2ixfMifFQyzjqHJFp6woYNSGQG1sdUpXSbVWSjYlR0d
         mKMs9jx5fH/7g24eO9afCccEGKwIb794/lA3MKerROOnFokiGbuQS/Nob51frZWI8w9e
         ZcMkxeSjnInNZfjJNL7ae1/mI/l1oiUU7iKWQRuYNNr4DCBtNlp+awuMwTY6oHpJhGjg
         GYvQ==
X-Gm-Message-State: AOJu0YxPuk5wl1xA78JSdET2x84Gj1sKOwSIEYIMBxaRrR9WxBdnjPs9
	zYzHrtZkbTuhGR7fmazFVFzd/Lwfk6hP0TdAI7y4Kt5YZUWEaPj5
X-Google-Smtp-Source: AGHT+IGS+/+VYYCrXyK5eGFQnzj8TbrBMyS8z88w9f5BYLdxbAzlOk3LfWuUlcDAtzX5WAw+itA5Qg==
X-Received: by 2002:a5d:60cd:0:b0:37d:4afe:8c9b with SMTP id ffacd0b85a97d-37eb48a0d99mr5929612f8f.54.1729468205267;
        Sun, 20 Oct 2024 16:50:05 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b9b076sm2818321f8f.90.2024.10.20.16.50.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Oct 2024 16:50:04 -0700 (PDT)
Message-ID: <e0901c12-58b8-4378-91bb-b1ef3350de47@grimberg.me>
Date: Mon, 21 Oct 2024 02:50:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: parse reservation commands's action and rtype
 to string
To: Guixin Liu <kanie@linux.alibaba.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20241014101458.80491-1-kanie@linux.alibaba.com>
 <20241014101458.80491-2-kanie@linux.alibaba.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241014101458.80491-2-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241020_165007_128295_B11EAE28 
X-CRM114-Status: UNSURE (   4.00  )
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

