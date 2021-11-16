Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C5AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 10:19:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A267B6187F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 10:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A267B6187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2pVUUhOW+PPHRe1owVHKWAC0hNxvDcyMPYMZUcLWpfo=; b=S3OBOIY6j0i6GQX1sckIyq1+m1
	l8lyPWWZBy8qAQRQGfCpHvK6TOHXxXreeeqlLj712hMhTKIyiuJ1I1KnkuZRUcQv02LysfMBh9dz1
	rhsEXaimGmO5lrbA1VwfOIH1fmJav77KCJFuXigDfC3AU59r749zb/Gfure6Fs08cdl3ahELgkJLG
	8s+R4cHBeW7qCTfXBc+Dkk1ic3x0bcfHuHjSAqImvNb6yBzuw7H3vra8SOxdgv+KWSewORGt6l4nj
	XyA6aAu9AL/UrzngoempHOPYueR5exX4eeavRDMdTD8rvpOf5nw4be5zt+tzP6WakjObAqMEm0+X9
	oJ+ievAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmvYm-001A3S-LJ; Tue, 16 Nov 2021 10:19:28 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmvYk-001A2c-3U
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 10:19:27 +0000
Received: by mail-wr1-f49.google.com with SMTP id n29so36447314wra.11
 for <linux-nvme@lists.infradead.org>; Tue, 16 Nov 2021 02:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2pVUUhOW+PPHRe1owVHKWAC0hNxvDcyMPYMZUcLWpfo=;
 b=WegKBICzp9Xm1bS9SxwIgt7KYcLEeS1EnZU4dcYk/N4ORixvF5PCWEW2GNyvwDFP66
 5HaIB6ZyfJY9Z8H+ZbmfK3ZzgYz+kLMJLVny30jpoO2DD3RgJFDMRpcbiNwpty8vZcau
 hWMVccbxa2E2DWucIrrA0FB4Bnrdco3AHpiDVPgQJgL2ZoRYJMp1Nnzk67UyHogPfzUH
 5xnuDRw804NpV4Q5m76rsJLcjL4SW0VZiNs4Grj26BDsCMNKU2K1BULma+WKEXcceV+8
 xrAwvT5JI5/+rbBt1pH+yNVc8XifNNsQNFTs6TDtXRN1Sa4wFWt/o3WOs2uK1cj1pTv1
 KmKg==
X-Gm-Message-State: AOAM532DNCOrWuVyjr57g9v5XZthpYlBmrdoT/6DUXnIMF+bI0ZpJ2Ih
 KyuKN+o8m2oBEDXJLK+nMiw=
X-Google-Smtp-Source: ABdhPJwqefqf0wNR0FMTlsltbl/SJPJHAGRP8LTifsg0vB3tNEwjvpbKaPNg2IP7kWKdjELhfRti7Q==
X-Received: by 2002:adf:e882:: with SMTP id d2mr7934329wrm.389.1637057964056; 
 Tue, 16 Nov 2021 02:19:24 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id z6sm2560612wmp.1.2021.11.16.02.19.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Nov 2021 02:19:08 -0800 (PST)
Subject: Re: [PATCHv5 00/12] nvme: In-band authentication support
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>,
 David Miller <davem@davemloft.net>, linux-crypto@vger.kernel.org
References: <20211112125928.97318-1-hare@suse.de>
 <74db7c77-7cbf-4bc9-1c80-e7c42acaea64@grimberg.me>
 <f67ca46e-f421-33f7-da8b-ff6e47acf8c2@suse.de>
 <8553266f-005c-f947-4737-2108cb7062d1@grimberg.me>
 <a7363853-05af-9d7f-4d6f-b02ec756ce6b@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <50095ec8-3825-efa5-98bb-76b0f0fdc21e@grimberg.me>
Date: Tue, 16 Nov 2021 12:18:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a7363853-05af-9d7f-4d6f-b02ec756ce6b@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_021926_177414_2551EA3C 
X-CRM114-Status: GOOD (  14.69  )
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


>>>>> - Transform secret with correct hmac algorithm
>>>>
>>>> Is that what I reported last time? Can you perhaps
>>>> point me to the exact patch that fixes this?
>>>
>>> Well, no, not really; the patch itself got squashed in the main patches.
>>> But problem here was that the key transformation from section 8.13.5.7
>>> had been using the hash algorithm from the initial challenge, not the
>>> one specified in the key itself.
>>> This lead to decoding errors when using a key with a different length
>>> than the hash algorithm.
>>
>> That is exactly what I reported, changing the key length leads to
>> authentication errors.
> 
> Right-o. So it should be sorted then.

Hannes, was the issue on the host side or the controller side?

I'm a little lost into what was the actual fix...

