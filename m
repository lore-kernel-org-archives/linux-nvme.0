Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0A4D6B6D1
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 20:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZwX5HQBRdls9HGl562/3LWDHexYSLiXyMo3oYf3ZMSM=; b=LWS9GqV+3VcuXA1ADb7bvWsYOT
	o8oAgGiD56C2TRq+6kGNRQGBW//FlxI4oMCYdCBZrMaISleobBQD8aqoPC5g5R9f5jpcWuULxumgY
	Sz5zxux3TAP+KGGjdBCwUCT8qNm6/TxcAxCceqiwXni9oRASbU8LfIrh6xYU7DKsT4ZEmndcLOSJX
	ID/yp5igzobK9KYQix6i2Rizsw6VJHR1aZ8fFWqWU1JBw28KUIVkADKE0hHUPGxynW2BVz7riDoDP
	uPRR3w+oByM9EMpXo91s8dfq6inJC9eknmp97F4lgI9LXQ5nBhtqmZYo1373Cx8iHIaK/3s+ywJwd
	9UlKte+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6FKq-00000001fe2-3UOS;
	Wed, 30 Oct 2024 20:30:32 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6FHD-00000001f3X-14dj
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 20:26:48 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XdzDk1cVczlgMW3;
	Wed, 30 Oct 2024 20:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1730320002; x=1732912003; bh=ZwX5HQBRdls9HGl562/3LWDH
	exYSLiXyMo3oYf3ZMSM=; b=IBlnjePqqXFRQURyxJU9Of+9zoHkLQBQCOhKK3al
	ygFLunnXoIaFdI566iOuvPbuLf+Z+ihJ7CqaifLU90rnkRlJ9PsllTu7s2ZuhizC
	XuJeKEXLhOSBbjodsRQvM4tpRmK9FRiPwglQvSYABX4wRXjv2Zt7Y+VRH9XJGWrE
	1/iAvd59vbi/aCeHPu5II+WWalxby3oRSJX9uku+VxA+hsI10nUOeWe26FmxOtKQ
	93jwQzRvWvcFwxxZSARePy90PPaAJBhrXXYtkfhFwUW+hTfiU+pwtdTaQFaNjeUv
	WeJcnOEG28u+TYcrIFQMnRx57zenYleIY0ytrXtW+03Ahg==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 0JqpT7IAAI3o; Wed, 30 Oct 2024 20:26:42 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XdzDb6wflzlgMVw;
	Wed, 30 Oct 2024 20:26:39 +0000 (UTC)
Message-ID: <7f63ba9b-856b-4ca5-b864-de1b8f87d658@acm.org>
Date: Wed, 30 Oct 2024 13:26:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 4/9] block: allow ability to limit partition write
 hints
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 joshi.k@samsung.com, javier.gonz@samsung.com
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-5-kbusch@meta.com>
 <a1ff3560-4072-4ecf-8501-e353b1c98bf0@acm.org>
 <20241030044658.GA32344@lst.de>
 <ZyKTACiLUsCEcJ-R@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <ZyKTACiLUsCEcJ-R@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_132647_501563_A891C898 
X-CRM114-Status: GOOD (  14.20  )
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

On 10/30/24 1:11 PM, Keith Busch wrote:
> On Wed, Oct 30, 2024 at 05:46:58AM +0100, Christoph Hellwig wrote:
>> On Tue, Oct 29, 2024 at 10:25:11AM -0700, Bart Van Assche wrote:
>>>> +}
>>>
>>> bitmap_copy() is not atomic. Shouldn't the bitmap_copy() call be
>>> serialized against the code that tests bits in bdev->write_hint_mask?
>>
>> It needs something.  I actually pointed that out last round, but forgot
>> about it again this time :)
> 
> I disagree. Whether we serialize it or not, writes in flight will either
> think it can write or it won't. There's no point adding any overhead to
> the IO path for this as you can't stop ending up with inflight writes
> using the tag you're trying to turn off.

Shouldn't the request queue be frozen while this write_hint_mask bitmap
is modified, just like the request queue is frozen while queue limits
are updated? This change wouldn't add any additional overhead to the I/O
path.

Thanks,

Bart.

