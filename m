Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD77CD13CF
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 17:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ot+Dm2IPnRjUmLkFrCB9qmjGxEAuk/qt1GT1Ssp6g4Y=; b=Jx+vd2KdsnYQfpetZiqbgjPFAH
	5pQ27sHSjtSDmlZCNFBXeSKIqXzLJPELUzXxdP0nC2ywnrqKPSmgGQ83BC7q0FzvIe1hSKJJMkmri
	MyhqLFwjzZa/czxqMwspvNCWebjHqAyYmTTHVd0PIGtKe6JIhqhyHG5SIpQMYDWMcg91z3QamnATD
	rYE1Nc9X60r3X3Dg5U9H+HN07USMBKStDkCaxd5wZ3nswQ2cehlNxuC1zO+kb6MjfTmxg/jYBBUNq
	vChaEyjeSGDcH/dB56U0BzhrkeUTh4gMGgapkaplJ+ApPllo318ehlkNp3sTDyKj38ovv0uWUbXzy
	xpzJvhOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slAQh-0000000F6v4-1pQ2;
	Mon, 02 Sep 2024 17:01:27 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slAQf-0000000F6uS-0ATt
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 17:01:26 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42bbe809b06so25586425e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 02 Sep 2024 10:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725296483; x=1725901283;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ot+Dm2IPnRjUmLkFrCB9qmjGxEAuk/qt1GT1Ssp6g4Y=;
        b=iJFGP4CRPWxVlR9XxlkPlLfgXz/jFEw+F7f0KHNl26NWyu4xREY1jQM6ZU+QL5R//N
         cxr6wquJxjXbVmAZNVkIMe/o23LN+AbxqnLPYlDLy5emfyY2hBt0hkxuWvgF98yUpThf
         BInQp8p8GGEBgsbhL3sdReDCz30WCA+KroPozcckxxNGSmBxT7d+knc1zWnm9YzqRKX5
         afeFPVLp4RzswkTlMsV17VHIsIBl2jbeflir5QLrlUFZR3bqzHVA4+tMq9vOb2gZyXte
         RiDZgJjqQrhohK+QsrcYDr8lchmJUPIjUJvhufCSoZZl0xnmRBhHpEpY79SsEBi/8Q72
         pr3A==
X-Forwarded-Encrypted: i=1; AJvYcCVUWCdKKnKyzyAhY6Pi7IJnySVCRQIcP7lpIMblSL3fZTrGcjv193qPaU/fzlyWOMYwcWZOeJGbb2bO@lists.infradead.org
X-Gm-Message-State: AOJu0YzeFQvrI6mAxKgIPC0sJ5TmVHwJ/N8JdTXIrJLrTvftZRZyK3la
	Fk2MJuv/SCmHUEIDKS625f1tvrykBbzJ1jMVSY79p7VVSXBsVq5GLoXyaA==
X-Google-Smtp-Source: AGHT+IE6cfs1lFVY05J3QkxINf0ypKN1tCcl2zwsIaxbANJQyM0p6GpyhCWNnYM/+e5RmMW1GYLSXA==
X-Received: by 2002:a05:600c:3ba7:b0:425:7c5f:1bac with SMTP id 5b1f17b1804b1-42bb0306f94mr123141915e9.21.1725296482770;
        Mon, 02 Sep 2024 10:01:22 -0700 (PDT)
Received: from [10.100.102.74] (89-138-71-253.bb.netvision.net.il. [89.138.71.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374badc581csm8025654f8f.0.2024.09.02.10.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 10:01:22 -0700 (PDT)
Message-ID: <807a6a3d-7da4-4c1c-9299-111172d63cd2@grimberg.me>
Date: Mon, 2 Sep 2024 20:01:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvme: remove existing namespace on ID mismatch
To: Hannes Reinecke <hare@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240902111548.41430-1-hare@kernel.org>
 <20240902111548.41430-5-hare@kernel.org>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240902111548.41430-5-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_100125_110605_41F7E6DB 
X-CRM114-Status: GOOD (  12.92  )
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

Again, patch title should describe what it is fixing.


On 02/09/2024 14:15, Hannes Reinecke wrote:
> When the namespace IDs mismatch during rescan we clearly ran out of
> sync with the target,

Not clear at all. When can this happen and how?

>   but we really can't know whether our local copy
> of the NSID is correct, and that one found by scanning is not.
> But clearly something is wrong with the namespaces, so we should remove
> the existing one, too, to avoid accidental data corruption.

Umm. So you see a bogus ns and conflicting with another ns which is
seemingly fine and you remove it?

I feel like you are describing something "generically useful/correct" 
while you address
a very specific problem but you don't describe it to us...

