Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF9FC5474E
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Aug 2024 07:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=R/5E8xol4JaJhnqxZnatWmr25Q
	srMppnPJW4nSxpQ1ql+ysK0IDbGPRM9PNm8mkVPCCX4AkEm+bcXJKK+OHqL/bJ0ka0vwwhS8eiWpM
	3NDa5ldtZayry7Jn0Cj+nG+WpAlpbGgsaxAjEe8P1MZUsEHcfbdxGrRQmi8pfz48fATywJhEn8Gc6
	qw4HCCCCT31ngJIFix+fvBHTeX03lRib37NgYko0zEej24S0S1B4M/2gnHQD9qDFPwE/CI1JsLMRq
	H2HfCrgtSqkWKGk1KeJ/3cA4Wv7yxwMjlVkCpeTHRrVr5kPlwBrbI272uS340YCoQzTjMWv39y9rO
	E1xcKMvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjCzY-0000000EFZo-10i7;
	Wed, 28 Aug 2024 07:21:20 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjCzV-0000000EFXb-3cp3
	for linux-nvme@lists.infradead.org;
	Wed, 28 Aug 2024 07:21:19 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-428e0d18666so54590075e9.3
        for <linux-nvme@lists.infradead.org>; Wed, 28 Aug 2024 00:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724829676; x=1725434476;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=uANKRLO0hQD6rRZpnXi0ELtlYfn5tdqRQHdhtszBCXy4ll4wziusb8CRiT4bEuwl/V
         BqgfHmMtuvriP2pR2ExMHBF/2fGLoXDkb3hs9O7oX8AfdOme3yUx9r6+tn9UaywaT1f7
         5li5UQKMfX56o/KlsNjU6xyZyE0l9T2ICm3mCUyeyzx+wlgP3elTJuJo31saNW+Z9/LS
         5dClnQroX+r4oGqG+mQJrc1EGa1mcgg8sd+5mKaTKjyWDxxIyCXVYQ0b/+RDlbQM8z2V
         MQ10V2nJ/L4QLYoz/fWkNoVMmy8fnfnAcYJESeELIt/nFb1diuvBag0D8FqTJf/2gU0h
         AN5w==
X-Forwarded-Encrypted: i=1; AJvYcCUODjvn/z5ihjyOCjOAu41r2iopCweEywgnHV9tx5XIQH9vcsOLHPgfkFQflgl7+q51pKP3YF7OrDIR@lists.infradead.org
X-Gm-Message-State: AOJu0YzTcX33/czcMYOQbIPtc3+wQakMNrN2ZIIYwQ8GTOkA6X7j4ft1
	qF3dsITa0lW2z+RvEFyzfwFW1oLZGBLznb/eF+P08HvN9oFnUvYj
X-Google-Smtp-Source: AGHT+IEGJZdA3zvixLCvIXaagTRCXYmH0vz055XZp+0Wc/q1JrJ+WLhLLmXFEmrklDgOFEqcyWFzWQ==
X-Received: by 2002:a05:600c:4687:b0:426:5b29:b5c8 with SMTP id 5b1f17b1804b1-42ba66a957amr7106115e9.28.1724829675219;
        Wed, 28 Aug 2024 00:21:15 -0700 (PDT)
Received: from [10.50.4.202] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6397ec1sm11779745e9.4.2024.08.28.00.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2024 00:21:14 -0700 (PDT)
Message-ID: <9e2c5b2d-a582-488e-9afa-31ae6183816e@grimberg.me>
Date: Wed, 28 Aug 2024 10:21:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
To: Puranjay Mohan <pjy@amazon.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 puranjay@kernel.org
References: <20240827132327.1704-1-pjy@amazon.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240827132327.1704-1-pjy@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_002117_936665_CAD1D5F5 
X-CRM114-Status: UNSURE (   6.10  )
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

