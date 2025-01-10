Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8E9E77188
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jan 2025 22:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pVEElhc7U69cqNNykeyam4SukFLgUilxYsCLLXpuK7c=; b=lIw0ZA9BoM9FuwlspW5F6nHJHq
	fZxfEk6AXOiCY5raYXbgEDRfqn6I+A7bskUZGwQcHKgg57zV62g7h3oRtbozs2SMa5wVH8FG52JqB
	AzUe29qarrSzaC9B/qCNFOrsP3kX00h20hKzJ0FnlglwC6Xr3AeWxQw8ziywF90/Dw8IINZsvMkYM
	ew5n4EHPSvwrSEcb7BwPvjFAqMKjul92xGynVtGd8SE2F41ndhiclMXxEVe4jS3sYTI4jaZve3Fgg
	fKQ6xVX/dIKvI8yf+Jnmm6cLeKb/xjZTL1KI0SZSjBS4Up9cShIo/BUxj13o9EuXWxBtpHwyFI2cK
	l4mypI7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWNpQ-0000000HBXZ-3jCx;
	Fri, 10 Jan 2025 22:50:08 +0000
Received: from mail-wr1-f48.google.com ([209.85.221.48])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWNpO-0000000HBWu-23VD
	for linux-nvme@lists.infradead.org;
	Fri, 10 Jan 2025 22:50:07 +0000
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38634c35129so1934528f8f.3
        for <linux-nvme@lists.infradead.org>; Fri, 10 Jan 2025 14:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736549405; x=1737154205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVEElhc7U69cqNNykeyam4SukFLgUilxYsCLLXpuK7c=;
        b=IfwX6JpJXumuWtDnd7zD3uaLc9KztrXAFYZxwvKMWjHJWJUqVItZPfB2s7AM1EHE7D
         Z2W05iWRLFYcLMHO+f88leYDeHY+hmejXg04lk1Xv3DfdT2OqL+pAF8q+zx2HrjIyXq+
         0qC1YzRoRayDMVpIMAWAD1XYJJtLm0295ui1M3vLQXUC9T57B5lHsy2kkt65lkoORWnn
         rFlV7vQfXcxYFq9ks2HL5thtJyAmmxifI3AmzpzkTb7sBUf/s6O4ig0dPnWpvdlHsQhf
         hxRnLrFiCjwkznCdNZCk5N8wilkqqiBcy3ClFm5SCaREaVV+Km+e9xxza3/rT9MF00o6
         wgaQ==
X-Gm-Message-State: AOJu0YxrB9rcctexycl1K/pn5vMLC03K8YY4MJUrOCRYbaznHnT15I1Z
	mOtP+JKsJQIeFDBOy4AdeJCww7H0nG2poMsIikGKYv6f072MP3Kw
X-Gm-Gg: ASbGnctDVLdDRjG+hIg7Wm4czZzYCrdSKrtzT3rPr8LVrlm/SlcUaSej4Qs1yGYJLMF
	TVNLI1CCxig4af7BpvmxLl0Xw/kTEfOXmSavCxnuVukjcMP4ShwhlR51oS7tQhrquebBGBURYJb
	EkNwttPTayXWcqiSqpaHwq5LgAy2WAaalMmhkvD9L2bfa1gNFKmGnUDTpqESXcCICfoJdhI4kc9
	C31hOnV8m/d+Fc0uVWvBOSSL5oW6Ik31HDgvsdUC9FMK9OtdZ22b+jvf8IAtL3PySnIHbTgCkxj
	E/6u5aBKjwTZvW+C
X-Google-Smtp-Source: AGHT+IEf20aKPRUDKEsTBvn3IJLE1/WOkcvpfJ8u0nF6OUrspiaY0sjr6pja0S6PK5mhKfDSAjKbBQ==
X-Received: by 2002:a05:6000:186e:b0:386:3327:9d07 with SMTP id ffacd0b85a97d-38a8733cbc3mr11577650f8f.54.1736549404701;
        Fri, 10 Jan 2025 14:50:04 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1bebsm5650860f8f.95.2025.01.10.14.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 14:50:04 -0800 (PST)
Message-ID: <f02eac80-b9dd-4618-86f7-c94a4295d551@grimberg.me>
Date: Sat, 11 Jan 2025 00:50:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] nvme-fc: do not ignore connectivity loss during
 connecting
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, Paul Ely <paul.ely@broadcom.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250109-nvme-fc-handle-com-lost-v4-0-fe5cae17b492@kernel.org>
 <20250109-nvme-fc-handle-com-lost-v4-3-fe5cae17b492@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20250109-nvme-fc-handle-com-lost-v4-3-fe5cae17b492@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_145006_748959_5CB190B7 
X-CRM114-Status: UNSURE (   5.82  )
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

Looks better to me, but FC folks should probably review this one

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>


