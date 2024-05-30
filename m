Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4A4C25B74
	for <linux-nvme@archiver.kernel.org>; Thu, 30 May 2024 17:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hC23jucMm+q+/3nVmnb3JFDkYf90kQS7VVGYEUblW18=; b=W5UY8cnjbDy2XHkZiTxZbzvPDu
	M9TDH2yC9bgcL0qK22Roo8MSVcUq0fkhkMl1eZFpMw812qzTHc5lbiSDZZ5OwvsBv2/YlYJ7KL9/l
	Sw9v1Wx1uu0z65m/3aGzEALDmHP427LEAupQtM+2uKBqY4NLwLGiGDY+4J1IFQZ94sEWB6xzlmDAK
	Qpg/doNlhha1CgtREKsxDIKCr63Ft/+ClsM1KwQOU8H4+pkpbuTLA9nR5ZFIsWvNaX+mz9SuC2ola
	xwuTus+sEROudBYdFjd+mPsrKX1SmjB8O0GjU/ZD51yE9oo0iTVaK6nbqzW2BiKeM6xu8qJ5OvpDX
	QX6S1pNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCk2a-000000083RX-3mDS;
	Thu, 30 May 2024 17:58:16 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCk2X-000000083Qv-31aW
	for linux-nvme@lists.infradead.org;
	Thu, 30 May 2024 17:58:15 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42112396582so429305e9.3
        for <linux-nvme@lists.infradead.org>; Thu, 30 May 2024 10:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717091889; x=1717696689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hC23jucMm+q+/3nVmnb3JFDkYf90kQS7VVGYEUblW18=;
        b=oQ1mndNQE6y7jELjsMoQJWM9Op6aO8W6ou8eye7UygCbo78IY4cWKdmMnoMXaxjYYu
         p+Did7Q8spKLti6IyR1LS0KlpKsEpTJbk8ev3dkykfNcvdBRcLjutJyFkAOj8DG2DnQU
         tU/LpL5m8eRw0MpRJUrSLPnClZCwEoQ6kaRJt6rNZLIdAcTrTYp5quTU8/1UBqzcIMlv
         bwSDUqNuDfys/exTGhwUQI0rKTW4h1RSwA/aM0Bml8glQip0g5zvoBYtqI3YwN3mGyGh
         bFTBbCxjfF/4G1hMJFsifl9XHYhIeTkmVdmoktLhFcaiDWVkpYNw31f8EY8Ntb2NSW8u
         mlFA==
X-Forwarded-Encrypted: i=1; AJvYcCWgIc+5CZNjyBmbCGK1URgvTBICwzSzRim+jkfSH8RX79TCSeTKu6LkkLE5QvEAddQcCc7152IJxAaYWrmDXqAz7QS+u8JboU2ffy2T8dU=
X-Gm-Message-State: AOJu0YxBm02vkDdxgTTDkXxgQ5xrrk8UB3QLc2heTUPKtZ/e0rC7k5Z9
	yi+0qfaYilZplp/2oRN6AIzPiPdcyz4bxt3UKFEmJ5nF3SKyKJSi
X-Google-Smtp-Source: AGHT+IEKs/D/YOXJKNpqQBu1D27NdILizXiASB7GFF049ZDfxVYEPi5NY+sGao+1Yf3CzW3yUcmd7w==
X-Received: by 2002:a5d:678d:0:b0:35d:bdda:3553 with SMTP id ffacd0b85a97d-35dc00bc230mr2126917f8f.4.1717091889059;
        Thu, 30 May 2024 10:58:09 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4212709d341sm31609825e9.36.2024.05.30.10.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 10:58:08 -0700 (PDT)
Message-ID: <d6b2c19b-c2a6-400c-bbf1-bf0469138777@grimberg.me>
Date: Thu, 30 May 2024 20:58:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] bugfix: Introduce sendpages_ok() to check
 sendpage_ok() on contiguous pages
To: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, edumazet@google.com, pabeni@redhat.com,
 kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, philipp.reisner@linbit.com,
 lars.ellenberg@linbit.com, christoph.boehmwalder@linbit.com,
 idryomov@gmail.com, xiubli@redhat.com
References: <20240530132629.4180932-1-ofir.gal@volumez.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240530132629.4180932-1-ofir.gal@volumez.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240530_105813_888477_5915C703 
X-CRM114-Status: GOOD (  21.10  )
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

Hey Ofir,

On 30/05/2024 16:26, Ofir Gal wrote:
> skb_splice_from_iter() warns on !sendpage_ok() which results in nvme-tcp
> data transfer failure. This warning leads to hanging IO.
>
> nvme-tcp using sendpage_ok() to check the first page of an iterator in
> order to disable MSG_SPLICE_PAGES. The iterator can represent a list of
> contiguous pages.
>
> When MSG_SPLICE_PAGES is enabled skb_splice_from_iter() is being used,
> it requires all pages in the iterator to be sendable.
> skb_splice_from_iter() checks each page with sendpage_ok().
>
> nvme_tcp_try_send_data() might allow MSG_SPLICE_PAGES when the first
> page is sendable, but the next one are not. skb_splice_from_iter() will
> attempt to send all the pages in the iterator. When reaching an
> unsendable page the IO will hang.

Interesting. Do you know where this buffer came from? I find it strange
that a we get a bvec with a contiguous segment which consists of non slab
originated pages together with slab originated pages... it is surprising 
to see
a mix of the two.

I'm wandering if this is something that happened before david's splice_pages
changes. Maybe before that with multipage bvecs? Anyways it is strange, 
never
seen that.

David,  strange that nvme-tcp is setting a single contiguous element 
bvec but it
is broken up into PAGE_SIZE increments in skb_splice_from_iter...

>
> The patch introduces a helper sendpages_ok(), it returns true if all the
> continuous pages are sendable.
>
> Drivers who want to send contiguous pages with MSG_SPLICE_PAGES may use
> this helper to check whether the page list is OK. If the helper does not
> return true, the driver should remove MSG_SPLICE_PAGES flag.
>
>
> The bug is reproducible, in order to reproduce we need nvme-over-tcp
> controllers with optimal IO size bigger than PAGE_SIZE. Creating a raid
> with bitmap over those devices reproduces the bug.
>
> In order to simulate large optimal IO size you can use dm-stripe with a
> single device.
> Script to reproduce the issue on top of brd devices using dm-stripe is
> attached below.

This is a great candidate for blktests. would be very beneficial to have 
it added there.

