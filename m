Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE41AC25B10
	for <linux-nvme@archiver.kernel.org>; Mon, 13 May 2024 12:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:Subject:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H/24anTbd23uTqFCzj46U+i/dC2oWYez6CRKoL/UqoM=; b=k2KDEID+HV4jSeVLHNws49FGqz
	MTTabltqLZjpRbTXgNXT2eP6qJSlC1vgN2fKcJm3PVjl1C9C1EYsSBnYhW89WdIAp0yF8Uoj77y07
	f4bB8jfhRxepDgW9NZQ0AiMNyHirIF/tIZ5miaEx/iYDOa3+G9oZv1GABpmAv22d3h8lzOYe+XBEb
	PqiFazzuuDmSM4lpntC3HHRBY6WIiKKeNy99yTpniRzgYYgSjqmSYcv9BC+pGxV9hRKvIjoVOXUck
	jwgP723rTasv4dGhw7sudrInxnSFfWRj4KTImHPb2tQVyjpEOmh5YhYaXo7nWxArLy8ogpyw6rcT1
	kRTzmOXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6Urp-0000000CpTx-1J4O;
	Mon, 13 May 2024 12:33:21 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6Urm-0000000CpTD-21d1
	for linux-nvme@lists.infradead.org;
	Mon, 13 May 2024 12:33:20 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a59b49162aeso1072305966b.3
        for <linux-nvme@lists.infradead.org>; Mon, 13 May 2024 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715603596; x=1716208396; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/24anTbd23uTqFCzj46U+i/dC2oWYez6CRKoL/UqoM=;
        b=l9Pl3dWY5bq8O8eMBdgquQLCOqhexpLXo+OjxCBc7JXlmKK7/eu1p02Pq7w+eF+1ge
         2qhHW2OaFio7R+UfW0N6tBeGPOPEb30IiQeh87qGaRHIfp/ttCS7/d+2L1ER3rPk3uE5
         LC9s0E1dSm1KrHLQf5ionZjVx8PkkzScCFozmmXeof7E0RA+o7fpIsgU2IExtT6d+xam
         XrjKrFwJpJ7Rgf6prr93VgqgOrpiE/JYR+nIwbLyxw/h6IBMGY6OeXGIq6Po53y4yT5A
         zccELnu4ibMAdsOEZ1UO6Rup1Ee+jzhIvDp4lF2nogubC4cp6keiB6RgK4qtVCA6SREr
         slGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715603596; x=1716208396;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H/24anTbd23uTqFCzj46U+i/dC2oWYez6CRKoL/UqoM=;
        b=JqcLRRAjJGVFTxSsx1Yv++6BDY1lw2QAHkXmXPlLrHbzDTs8XRxkQATpVtP0H/LG+k
         5erE5gyCwgRh0Y6mTHzMnLqOf0vE+rn8w9m6N4SLH/t75aZCkJ9GRa67vembuVNVDiwV
         O9kmXjJjw87Iftrk7FJM4KGP5XDCrTRn42sOFle8AmS75+wyavjcimZbMoWVNsJo6QQq
         MnUWWA+3HJGV4Us+J+4q7vwpJdvRHZNKKeFc2jV8G3nWSY0Qhy/0pDCSqBzaRd5pOcfd
         Rdef+RN1l/zAwzZxQw5k6OspEDd9Rc3KfaqTFiEhFew1X7GDyH86uQohH5kKnFvj2yko
         UP5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVprGgPuWpDbJtRK6AQ0eh/pdfBxr+6mUDFga5Gg1TZO3MKX8ue0rNEeBOoGk5WJNbTKJFGGhlGtOhbSD7ZEK8gqLWIm4kPgnsrjNG7Sgw=
X-Gm-Message-State: AOJu0YwE1QtkQDMaRRiTNyhw7M1cpI40o6kk2i7FpZJtEt19BQL/Rm+6
	zWxUZtd2vbQPcr+9B974+QTG7EIzNscrqY4YWRdCbFnVERVnX27diiUdBtUfVGY=
X-Google-Smtp-Source: AGHT+IGi9n6np+k21ewfVp4If9hyjezb1uIX+HkY1xJ7TGPPzTl8vW5wWpuCNurTnvQ4Zt7+zXzWxg==
X-Received: by 2002:a50:d745:0:b0:56e:3774:749b with SMTP id 4fb4d7f45d1cf-5734d6dfeedmr5504633a12.42.1715603595711;
        Mon, 13 May 2024 05:33:15 -0700 (PDT)
Received: from ?IPV6:2a01:aec0:a3fd:7260:9636:62ff:a8fd:5751? ([2a01:aec0:a3fd:7260:9636:62ff:a8fd:5751])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733becfcc1sm6010876a12.45.2024.05.13.05.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 05:33:15 -0700 (PDT)
Message-ID: <ce50c633-598e-4252-88fd-109954808b2b@gmail.com>
Date: Mon, 13 May 2024 14:33:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ming.lei@redhat.com
Cc: benjamin.meier70@gmail.com, hch@lst.de, kbusch@kernel.org,
 kbusch@meta.com, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, tglx@linutronix.de
References: <ZkHcde1xeBOiEikg@fedora>
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
Content-Language: en-US
From: Benjamin Meier <benjamin.meier70@gmail.com>
In-Reply-To: <ZkHcde1xeBOiEikg@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240513_053318_560980_0243B882 
X-CRM114-Status: GOOD (  19.57  )
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

 > 'isolcpus=managed_irq' enablement patches are small, and shouldn't be 
very
 > hard to backport.

I have big respect of kernel code and probably for non-kernel devs it's 
not so easy:)

But yeah, we'll look into this.

 > > > > be tricky to assign all interrupts to those without a
 > > performance-penalty.
 > > > >
 > > > > Given these requirements, manually specifying interrupt/core 
assignments
 > > > > would offer greater flexibility and control over system 
performance.
 > > > > Moreover, the proposed code changes appear minimal and have no
 > > > > impact on existing functionalities.
 > > >
 > > > Looks your main concern is performance, but as Keith mentioned, the
 > > proposed
 > > > change may degrade nvme perf too:
 > > >
 > > > 
https://lore.kernel.org/linux-nvme/Zj6745UDnwX1BteO@kbusch-mbp.dhcp.thefacebook.com/
 > >
 > > Yes, but for NVMe it's not that critical. The most important point 
for us is
 > > to keep them away from our "high-priority" cores. We still wanted 
to have
 > > control
 > > where we run those interrupts, but also because we just did not 
know the
 > > "managed_irq"
 > > option.
 >
 > OK, thanks for share the input!
 >
 > Now from upstream viewpoint, 'isolcpus=managed_irq' should work for 
your case,
 > and seems not necessary to support nvme unmanaged irq for this 
requirement
 > at least.

Yes, probably that will do it. Personally, I still think it's a nice 
thing if it's
possible to assign interrupts to specific cores, but practically the 
advantages are
likely not that big compared to 'isolcpus=managed_irq'.

Thanks for all the explanations

