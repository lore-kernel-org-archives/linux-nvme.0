Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35017CD4F5B
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 07:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a/lqih5w8kOsHKdyaSXO9SGORGhwE1abTlQDwvsKNOc=; b=2fuKKLFc1dQRObMxCvoJ5JW+Np
	ZTCO8JtEjb+p03AI2plzTXtEEYKoVb1jRYgb9YaqRMnTfuZtIm+uYDNJYKhgIAJo+AU9Czs27rJvI
	LAXgephGgLQ2rq2vwFTfn7bYzBGIUSqPnSS/D7QoWdT1dJjB2yFg1MFfWh41djOlfU91onvlBDg7V
	654Vh1EL2VwQTXWKqRTEKRM74Z8BMddTXyNyNkp9W+b0gTcLdFH8o1Ar6ZQTLb62fMsYyRRC8BoKQ
	IuB5Ve4+yZUoe79X6+yCdAsf4nNwylGbcSIvwxloOT5EPOeUH6P7FeQTCL8QpIWDjfr4dBae70MfB
	onOPKJiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFIh-00000000Zt2-2CwH;
	Tue, 19 May 2026 07:55:39 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFIf-00000000ZsM-0D7n
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 07:55:38 +0000
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-43d7645adbdso2089669f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 19 May 2026 00:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779177335; x=1779782135; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a/lqih5w8kOsHKdyaSXO9SGORGhwE1abTlQDwvsKNOc=;
        b=WEEwTkQMoRlVsd44TlZ0oL20G18pmeI5DnEu4hfktgTNXDv7ep0lhB15LDnohhKt0X
         OSMKksJ2gsMTI3tU0Xj1BgjaZjfS6VFKbk1SOLJCBgzULsSAo9en3EPHo1pqYQhD8i3v
         /71pTtXhF0vXI6e6INIhVAtGKOkeXP2IvkRmnGerQJ6quL2k9wCTgmNz831bRPh5SePX
         wsM8P0UGB1yzuU5Lp1BGqwpgFVx0sMVf6uwiss8PoRg8bwWdSHmuQtht4L0WFLLJWzE4
         1yeyCSxjszNKDyQrqhD17d5NnGmSDUsz//6cnzTgATIxaf4A5lklYxGyl9+h2TWGbJPF
         rj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177335; x=1779782135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/lqih5w8kOsHKdyaSXO9SGORGhwE1abTlQDwvsKNOc=;
        b=iSIqcBGSYlszxoqDmxDMnAIldOhpbM2CenPdyhcspHc+ymbKplvCu/MwUHU+UXvfEI
         joy5gDhxfX9rDNyxWCWwgyvEXb4kojz+U1GpAqHk6lMbhhQ47Bk0jWSxBQFXaLkCWGE+
         3AJpJY/p1SRwGIsusGX8fKIeAjuaNUyJ3yQV7Mv2R2rXn3VDSQDAqnANp5Z0BTZk/vzr
         fy85GZ5I9z+eS+V7r/DNiJ7dzyyAK1bLgVoVixVo/7+Rb+ew0Nq02tN2cdAQ2iS+lawe
         4jFdwXhn+cGN57G3heUyoPIjkAfzRQoUHVWXeH0h6poLziXRXRL5+NB6zxfMHmEfom5i
         dxVg==
X-Forwarded-Encrypted: i=1; AFNElJ+kmNAxd/is2/BwUSuzb963lW7/R4xyRa1VGx/AA07OYrPBMKdSPnWURnGanl1Qr7Lw7/8uU8QIxf3E@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4DmpftXXPIoKhL9Po7U6aUs2PmodiqFPKxJDmw7tbopno6Yp0
	i1mv9V/3+K6R/n5L+zIug3A0F4hdYGx74xaO7zgegIw6Z4qS6IGIeBZa
X-Gm-Gg: Acq92OE8ld+GZ2fjeq804Zlf6cUBIdLfpAl5a5w5f+eoIqlq2cSPgkXkmCy4bU8FG4K
	cNCosmNtwc1PkUYNCdHuzqu/TLmaoUlvA05kOzQjNNQGty8GKqPdNICsLzis0sGeRMIqlo+n4yk
	HItGSXzwPFfhxdOpTS3HmdoLnsLomLSUW8QJnHzSUVxlPx66+ZRrxM9pUvNUkw4Du0GQv5v79Fr
	wQz4EWLc1cZ3mvbVFPqSWuSkrnowXnbBzqHIXqB6iIYV+pGNMK04nuyRn04cd6/ni+Lld9LeKeI
	f8DVmXTws/Vke6jA8MRz4TVScqNg26+zYAZ+xUX3ueWrQG4MqO24w4vT6gaXYopy5Z0XIS2H9I6
	H6UdZI7T6j1lRtPZ0k5IllWzB0NZkLm2MKnKd4Xrf5xUr4ZIAM/5McAX+llol/1lf+WFOPAeAYg
	+Eyx7siOr2veQXd7Trp3qOsAIc/e+qsoiqMhQY51q2xN9ZZjQ2/5UTywPuz8DInRO+mrfRPhkzT
	qzRX32yOcmjuxxWL7Lsyrao7uRrj2j+QrC4wMIT/NPLhuV0HkoGV/DU+nRKqAkgBA6OzBuvoRvc
	Ug==
X-Received: by 2002:a05:600c:470e:b0:489:201c:dc46 with SMTP id 5b1f17b1804b1-48fe60ea590mr265981195e9.12.1779177335066;
        Tue, 19 May 2026 00:55:35 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c88e5asm329088665e9.6.2026.05.19.00.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 00:55:34 -0700 (PDT)
Message-ID: <9933142a-4ce2-4219-9574-73da30edd74e@gmail.com>
Date: Tue, 19 May 2026 08:55:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/10] lib: add dmabuf token infrastructure
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com>
 <20260513082431.GA6461@lst.de>
 <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com>
 <20260518125326.GA5754@lst.de>
 <ea47051e-697f-4017-a514-be6ef7c110e9@gmail.com>
 <20260519065653.GB8173@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260519065653.GB8173@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_005537_109961_00ACE0C5 
X-CRM114-Status: GOOD (  24.45  )
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

On 5/19/26 07:56, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 03:23:53PM +0100, Pavel Begunkov wrote:
>> To be fair, it's not that dma-buf specific. This lib/ code only
>> does some resv locking, fence waiting and queuing fences,
> 
> But all the dma resv/fence stuff is pretty tied into the dma-buf
> ecosystem.  I don't think it would really apply to something not
> doing DMA at all.

The point is that those can be separated to reuse the rest.
  >> otherwise
>> all the attaching is done by the driver behind callbacks. Switching
>> it to some memfd could be pretty simple. But The main thing it'd
>> need to share is iterator handling like forwarding in the block
>> layer, and it should be fine as it's already passed as a completely
>> opaque object with no knowledge about pages / dma / etc. for the
>> middle layers.
> 
> But none of that really sits in the current lib/ code anyway?

It's about naming. E.g. passing a DMABUF_ITER that doesn't have a
dma-buf would be confusing, and then it'll need renaming at all
layers to support the use case.

>>> lib/ is most certainly the wrong place for something that absolutely
>>> is not library functionality but directly interacts with a few
>>> subsystems.
>>
>> It only interacts with dma-buf, and even for dma-buf attachments
>> are created by the driver. Block, nvme, io_uring are users, either
>> using the helpers or implementing callbacks.
>>
>> Ok. Let's assume for the argument's sake it's not dma-buf
>> specific, if not lib/, where would you put it? I was also
>> assuming that dma-buf being under drivers/ is rather a relic
>> of the past rather than the desired location, hmm?
> 
> drivers/dma-buf is a pretty natural place for it, I could not thing

_If_ there is no dma mappings, drivers/dma-buf would definitely
be an awkward spot. Just trying to understand your criteria for
placement, let's say of a generic buffer registration code assuming
there is no dma-buf involved at all. Again, just a hypothetical.

> where else you'd place dma-buffers.  I'm not sure how hmm has anything
> to do with it.

Looks there is some confusion. It's was meant as an interjection
with an open question, I didn't mention the HMM subsystem.

-- 
Pavel Begunkov


