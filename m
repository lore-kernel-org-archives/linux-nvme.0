Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C555C25B75
	for <linux-nvme@archiver.kernel.org>; Fri, 31 May 2024 08:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=af14pdYSNZPIaFcIFr708QbRpJ
	tEIxNja7LVYLVBKkPyCynoVJCyWCalevbsGAoo5Hg4hXhrCp4hZ3ZtAxZrwp/kJSuPaSkai+M38X0
	cIen4fJn+3PKon91ZO4miOHMAT6sh37BNo81Yp9WN+hywOHfvQ6bL+v/zHgTU7xo9Sa6IVYg4UE/X
	1TTKtZ5D/HkVqt4/mNRQVVvBKEGWsBEfhvaytCLg99TQ7PWgN1GXEtyaEhvurW14Vll8O4uRhBf6a
	/FukTfTAHywa/6KJsWWj4xaFBw0Jh3a2yVPgxZwtOky75wZ58NGPW5HgYMjGpU/2NtJII6vEIdmxq
	/xjnjNlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCxlN-00000009dk9-3Ffh;
	Fri, 31 May 2024 08:37:25 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCxlJ-00000009dhO-0PgU;
	Fri, 31 May 2024 08:37:22 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42129d4e7bdso809595e9.1;
        Fri, 31 May 2024 01:37:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717144638; x=1717749438;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=RYDrG8f8srqMaEnHiMxmtfx3WtilY5KUF5quLBBqA5WqshnWpXwuGxRwsmAULoche7
         8wuVj9pfKjRM8wUNt9S7kcELfESj0TDdgH9hppiQ205sAq5fI8VxD7wEVwu1LhuyzE4Z
         ArTI1uGN2e10IYCDXyWs1zp1qJfAsjb5vlcYj9jbxW7freb1gVBZEnSKY/Leih+PkitY
         /ekwMU+PaSxwwZLaRdyrx1/8HWAznfnBzvYz92pEkniXiY9uHuClqFJC2edUDk/Nkc4+
         3xco14oSWnnTp8NAakT4U5PrrlkhbnBT6xK2vusk1JQu0at8PZaxmGV1hZzR0h6R8CYm
         4fMg==
X-Forwarded-Encrypted: i=1; AJvYcCUNU+fURFhkAgkoxVzS3BiaGftt3CFuhxSfdmTtTfOKnsxo+vAZbADMZC6llPA7rRgKVHZDQY3pWsIi31WvnHHScYRc3ofGl0iti3KZ+kb3W4ZyzitTWGl8goRHqw8TcuYJhfJ6liKWItIqbJCBp3jeeqg/QA==
X-Gm-Message-State: AOJu0YxLrL4op6k6L/2vkYtVGyD8KABBpsz4PpbDs2TH3cFhww9DuzKg
	/HApeDjJ7SnYvOVCBvGmkbYC7vaJxIhUsHavHt3MKobL4Em5UUqf
X-Google-Smtp-Source: AGHT+IEcMZB90PK3n/9rMQxD7m9IN3Nt4bzySZUbYfywqxlzdNOgXH/47NR1pw7f8r7XCWcMKZ23iw==
X-Received: by 2002:a05:600c:3b0c:b0:421:2918:3d9a with SMTP id 5b1f17b1804b1-4212e006132mr9155745e9.0.1717144638185;
        Fri, 31 May 2024 01:37:18 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212b8afe40sm17955285e9.40.2024.05.31.01.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 01:37:17 -0700 (PDT)
Message-ID: <746bdba5-8826-4069-8f3b-08891d78321d@grimberg.me>
Date: Fri, 31 May 2024 11:37:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-apple: add missing MODULE_DESCRIPTION()
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Hector Martin
 <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240530-md-nvme-apple-v1-1-b8b7ca569660@quicinc.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240530-md-nvme-apple-v1-1-b8b7ca569660@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_013721_368291_C88AF6E0 
X-CRM114-Status: UNSURE (   5.37  )
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

