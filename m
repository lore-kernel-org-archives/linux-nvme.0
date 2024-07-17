Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FA29C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 22:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iQSklx3nS8vr+LJs7L64lFnji8dhYXZrYFF+YxW2mzo=; b=HmZoU3o/UaSvHGSkYpsDMlxGJW
	MNfF/xyo6Fj+2g2BQtF/VTiS36lLd8Uo1uHvz/G6nLCvZYjRhUUq2IuxI7aFEaSUPoOPMoIDAZKwJ
	G7Cw3QcFQWJI8ZrMq2YblkV7OWjvbNSDxFMzYseU/7pWjm5um9R2t8lU8LlZ0ZL4wN7JK5Ytm9dXB
	7CdAOE+w+/SR86pr88CwgXZ+fyFl7strklNqwSA/39pIr6ygS3ef8ay8uby9rMQ0OiZ21Pr+ML8MN
	VuJH2wgVt9HD2Z1zXRydrMpUSCxyQRYjq/8usBPHiM6fIVnoYirOHaF9zOQrPTXhU08XYNBZauWZb
	3FNPkhVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUDG1-0000000F8Ma-2Ymc;
	Wed, 17 Jul 2024 22:36:21 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUDFy-0000000F8M6-3fcB
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 22:36:20 +0000
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-427b9fca517so238875e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 15:36:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721255777; x=1721860577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iQSklx3nS8vr+LJs7L64lFnji8dhYXZrYFF+YxW2mzo=;
        b=TRv94/Kpv2L0BZvWmIE+JIsR/v3QfLpgEi1eDfi7RIKfvFK8T1OnX6vpPSSQo3eYWU
         kUkJZgFE/2vkwghLYAqrmJQgSHrFSme53ZOzuFJjNZsafGC+/fwobly75W+z/9C0lyvI
         twW9lCjJSVFcB34LZObMu9uvET18xa0YXM1RjhRCxBo6HjOLTNsoqQgT2gl37DJNIZSc
         cFWk2zYUXP1uuOjW1Z6fYkLYt5tzwwJOjqwGNnPj3R0jPNcPMrPMEOopDee2TcW3w23K
         LL7dJuUtPLj5v/wizAzTTSFZempLpnF0srXZvf0d1OPKMzsdXCgBdrGn+Bgk1ZlBMALs
         uhrg==
X-Forwarded-Encrypted: i=1; AJvYcCUysMFxvsXnmGCR5WeXxF45f8TrkVmquLLzLSGTlsMMBfbeUzrTVI6jsd/Dcdbs0Xy6mZ4bepfZ14jcdj1Mp2PBrhsNO9w0yIhpbU5BxzU=
X-Gm-Message-State: AOJu0YxXNBQm55gPOUX7BWK5tvffrQ3xV5gddWdlnM7VB7G+qon4gJe+
	ngO1QQzXL7jg8YRjrc21Xb3eDsWSNo7TcjGqUcvoB6UY0pJtYe4v+fsAag==
X-Google-Smtp-Source: AGHT+IHmRixNYumoQ6RNtbIKJyBuARRMTTqGyRqvMZ7aCwTjeAkxiXzJCXXOLRKU8y6i2jwjx9Fx8Q==
X-Received: by 2002:a5d:64e8:0:b0:362:1322:affc with SMTP id ffacd0b85a97d-368316fbf8dmr1277933f8f.5.1721255777356;
        Wed, 17 Jul 2024 15:36:17 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabef8csm12623609f8f.25.2024.07.17.15.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 15:36:17 -0700 (PDT)
Message-ID: <ee8c31e1-31fe-47e0-9c60-61d3292851e0@grimberg.me>
Date: Thu, 18 Jul 2024 01:36:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] nvmet-tcp: support secure channel concatenation
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20240717091031.143188-1-hare@kernel.org>
 <20240717091031.143188-17-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091031.143188-17-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_153618_950332_3DBCDFC4 
X-CRM114-Status: UNSURE (   7.54  )
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



On 17/07/2024 12:10, Hannes Reinecke wrote:
> Evaluate the SC_C flag during DH-CHAP-HMAC negotiation and insert
> the generated PSK once negotiation has finished.

Will look in details at the patch, but first a question,
IIRC TLS enabled ports should only allow host to connect
over TLS. How does this change now?

Plus, what does the discovery service tell hosts about such
discovery log entries?

