Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0185ED111A8
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Nov 2025 23:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=; b=DiTRaHumD4vgFN3sei9MmvVn8z
	RcYluvwcuSWFKkxdfw9nk11nPhrZvkl5sr+ki73PJG2hNsdkJ7cP/hjJlYzEs41GYK6UyNwy3lI2Q
	M1sO4Vp46PK9GOhHkxC7NP4CV/2kApwjsbl7ngsI8cWtk3DStliXTJrwQTZ3GAhoz9lPYPye3ih9M
	ZAnIG9lVxLpHj/fGp07HgAjutA2Sb3FxuktYP4kU3PAhuJgFDc4sKBf2RkJ5f9PSqYG0RiNDiStqi
	goICnWV9GDhc8hJ3zbfcSo0zNgj+vmyLFiKjFMPJqIJ3loSx/TVo8r//Z6Xe8l+F05V5U4VIra7ey
	7vIwVihg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqSH-00000002ep8-0Ose;
	Sun, 30 Nov 2025 23:03:45 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vPqSE-00000002eoE-2Qza
	for linux-nvme@lists.infradead.org;
	Sun, 30 Nov 2025 23:03:43 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42b3c5defb2so2538281f8f.2
        for <linux-nvme@lists.infradead.org>; Sun, 30 Nov 2025 15:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764543820; x=1765148620;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
        b=fEBooM/Rk0VgWrTJW81qsFQS/4+HWOmUwgC3HPoprkBv/pGrlqJfe7bYL2iev68FHf
         xrmuQROKfihe+Q408mr8BB4neI/Cw0oO+MxK4TSa2bAW4nhI0pZoP4q5zVY72McpPUZB
         Fh+C2Dq6OCN5Q6N+WbotP4EeqGcBKtYgh7BXjwJyIXRilntyBQokZgjQk8Vk809APRyx
         B8WiTlgTP2+pc64daOyzicrYIQxkp2IYZJLBdPU2EQktgzPhjln4L1T61Nxy2Oi1DxgJ
         dIWavc8TLeplZC2KqkxDgcXCrHrEs0WQgVBEXsNbYbfMeVlgOZV5xTJTi3fXX1CuJZDu
         yFww==
X-Forwarded-Encrypted: i=1; AJvYcCVBXl2Zccp3o/ByvAAbkEpSKfLoZKHQT5M5exwLHX9MN11efmmvdyaA4JSdLnQtr1s2SNve6TeJZMl8@lists.infradead.org
X-Gm-Message-State: AOJu0YxBqFsxcbivpcOnOvGCamz9aK3JoEOdkFizbsZRCBqgWcA16HgM
	PNbUde1CRuZL4ZDUaN3hNq7pGXmMx8rQODrZP9HdNMil5nQp1WGTHZQS
X-Gm-Gg: ASbGncuYmpiuqftxan47VaEALVxIXCNoQOUbW843Ozum/uJZeqN04t7L2NKbeegm7hC
	0Z8xdiosMJv/xa+7pfxqhgMlYr8etqSjjrWTuE7gcy5rCXXg56dIqcbYrVBBUQSji/vIZ6WCpDq
	ToWoViTE2+7RkXcWeDHAFdbgmUdqRntEiu/4FY6YrBI8C88GsCkpXROPeP5F+KWgKzInSQg8MYs
	C4xTXZ69v4dnyZbbFHUUl7wnAjrx1e8GRWs1/dGO4qvw84yLXmJV9fblUAoUy9OmZVnVBvkXSCE
	bBMFTM4jMPZQ8VKZmkzr2vpj9m27l6YbCVv754qNhP/4nB0KjoQVilJZF/hMNrAm4QIKreZHhbJ
	mMtNNWZSnogouq5I71twF49WX9f1CFbO6ELZNSiFdlKy0CJg0F2XwX+hUqdO03/jbSFpqM/UAzz
	JbZwsLpBvJF1v0N1FZqFnOALVrNKrLuN4Ifiv3hgY6
X-Google-Smtp-Source: AGHT+IG0kUJO7SYN4V6YpXy8uJxkqAm9wDLe/yTWTady0nKXHIsEefrNGBZg2POKGw5qhetClLnvgw==
X-Received: by 2002:a05:6000:2484:b0:42c:a449:d68c with SMTP id ffacd0b85a97d-42cc1d0cf34mr37257663f8f.30.1764543820316;
        Sun, 30 Nov 2025 15:03:40 -0800 (PST)
Received: from [10.100.102.74] (89-138-71-2.bb.netvision.net.il. [89.138.71.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1caae37esm22401721f8f.40.2025.11.30.15.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Nov 2025 15:03:39 -0800 (PST)
Message-ID: <b33b3587-edb0-4f30-a8ee-baaa2b631ed9@grimberg.me>
Date: Mon, 1 Dec 2025 01:03:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] nvmet: use bio_chain_and_submit to simplify bio
 chaining
To: zhangshida <starzhangzsd@gmail.com>, Johannes.Thumshirn@wdc.com,
 hch@infradead.org, gruenba@redhat.com, ming.lei@redhat.com,
 siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 nvdimm@lists.linux.dev, virtualization@lists.linux.dev,
 linux-nvme@lists.infradead.org, gfs2@lists.linux.dev, ntfs3@lists.linux.dev,
 linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhangshida@kylinos.cn
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
 <20251128083219.2332407-13-zhangshida@kylinos.cn>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20251128083219.2332407-13-zhangshida@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251130_150342_627272_7549695B 
X-CRM114-Status: UNSURE (   3.88  )
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

Acked-by: Sagi Grimberg <sagi@grimberg.me>

