Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16D3CA5FF0
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2026 11:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=25uBlo4GDqcGkj4VAPKdolkwb50w3Is4u8TLMjz2GGs=; b=OfMELORYqEv/46uSJf8tdIYUww
	XxpkcfXDUKbSOEasB73dvp/SrawCf37x90d8Q155gybj6lKfJ9JfDZaQdtsdfrcDQ0pBbSAiulYDA
	mDw7NHta5R33g8vUhX9SSIAXnd75xWTT6cnbtv3QHhoTOqrZZ8+JEM88GRQTRt+wI0SM7gMvInqwF
	jeKFnX8z51NFEGcfC4DIMEBVufP2NXjLvE2M6lB9dIxCV/9CLXghr0bmnMLFuMesfCzQVYUTFAj8W
	xSoVaYxbIJzJPZqpGDVaonJvEy+WHfU6LivmHwXgM4ItwX/9bsQ1Ya63qCpfeVlXjfDYa1FWLVhn+
	rWYRzdUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDh9x-0000000GMGg-17kR;
	Mon, 05 Oct 2026 11:47:09 +0000
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDh6F-0000000GLwZ-48JX
	for linux-nvme@lists.infradead.org;
	Mon, 05 Oct 2026 11:43:21 +0000
Received: by mail-wr2-x0e.google.com with SMTP id ffacd0b85a97d-48aff58e6abso875594f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 05 Oct 2026 04:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791200598; x=1791805398; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=25uBlo4GDqcGkj4VAPKdolkwb50w3Is4u8TLMjz2GGs=;
        b=GX8Nn7fQ+oFxRqU5ZAQ2Z6o/jAX6IcRvIWzraOou12rQ6FuZU4ZTTndcZeo2R952kZ
         wqqW43ZcHLCc04CVFBW7r3qIOvlR2lXWJ6iKaHNPAYgHkPPeoQwzzSoWwKtJW4vOUcSn
         3VVi5XBAYRnD2VCxe3bUUqUtinRySOwPFqhUmKyOIQyPzZayYITj6AhpjSf0TRybDgCs
         VhkAg+0/VK0t+5V1/+o9wHYhPwnjWKKjQVgK70KXnToPxX02TyGJZMvpEJ75kE9QTPpn
         aOLR+5HGfrioPEkaLfBySKZzlDDSM/a4f6tcMnJxfwQ/dLkd57B2c9zcH9DEH0O4wV4K
         0vyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791200598; x=1791805398;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=25uBlo4GDqcGkj4VAPKdolkwb50w3Is4u8TLMjz2GGs=;
        b=Ns63PS7N8vh3Yu6g/uSg1Z6IMp7U8nKHowAym1O3N66eIfcyWWp6SNW2INwvECt6L0
         K6wQdNAn1qTzo+kC2GXJ0PtCAWD+AWg7BsE+YPWSGvsUyWDVKR1B+DIxhEDhY2oFmtbK
         6F0kKvNFDR5pt8iIfbNVH0bZQGPKNPtumKehNqg5Qwkh/m0ItqhmD3JWBj9guCgyJt0p
         RKucuM6T6vFvKVwNoYYBxU5dUnhofPUU26UhPV1eEVsoNEGSMoaQuVGfphzgP3h2/7Ax
         bnfD3plk/L1/OyEoM04jsuBnqPGjfpu/asF7IW5ldpVFEXHwfxhzNTJ5xIzH6gkNvboE
         MEzA==
X-Forwarded-Encrypted: i=1; AKwUvBy4BNhZEIWa1J+MbtKOdMeAXAEM5KcgQxGZgR7s3T996xAC73TQC8pbOCTxkA0N+9fN4Wt7DtAPMN1J@lists.infradead.org
X-Gm-Message-State: AFq9FYILD2lD2eWWjDTqGwtS4Yv2lZf9na8uqWbz27jXcF1Q53N/fe+x
	kJezXM2d/ylDXzPUc8DR2zmlC8fBKa67cUH/xuqxqs61/vuTC5cRiMgc
X-Gm-Gg: AYBFou2dFqO2owq7F3PSezOuXIKK41sgIz6Y99bZqN+GhNWO2J46naRo8kJ/DmDsKW2
	TikGiDJrCsFw0ka1i2n8EBrmp9J4qcHzdU5VCChj92AtgL6Uu+OuYDJgfaE9QMSzPb77z3fy18c
	CR/LK8KGRVE8OSp47yymvJ+lExqB/qj1WyfR7cOqSpI8wGA6D80P2qu8J7CeRJAEevKcI3gUNWa
	Cb6GUmK15HlE03mRE8EhjWUWHbSty0ols3xFlCTIkIpRKxZcmDT31uPOtXhPI52YUbh81CrfQUP
	/LlDUotePd+16fxNPr3rl1IVNvwPsEFpsCnar4t79k/mjbyZzkOl5G5GxHHj3HfOHSZ8t5kDJVj
	SSJ0YD/IgQX0/Sj8soOochhPoCgkg5dQwFxxiTFwzIjyLKAXO1WBVhs6mhEfAjzsTMHwCUS8/sn
	ZR5SqjdxQmGAFFDxEO6SQL9ByOhlN8p1kQzffQV3c1b+H4BhKTMlkBSXUOEjPqvHe3IowMXtGgS
	GgykXcHJWraXWPfFFl2+DFrulyWzoFh2WgaK07jrqArvB7bwxNpGecUxLew02y7L/6sclQGnw4=
X-Received: by 2002:a05:6000:40de:b0:48b:d2d:2fcc with SMTP id ffacd0b85a97d-48b1272d0c6mr17543670f8f.9.1791200597696;
        Mon, 05 Oct 2026 04:43:17 -0700 (PDT)
Received: from [10.41.30.1] ([161.12.45.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622704a5sm6943895f8f.15.2026.10.05.04.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 04:43:17 -0700 (PDT)
Message-ID: <be0012e5-872f-42f3-bace-5066a09cd9e6@gmail.com>
Date: Mon, 5 Oct 2026 12:43:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 05/13] block: add dma-buf support for raw bdev
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
References: <cover.1790602223.git.asml.silence@gmail.com>
 <a6b81e65b1f09b6ed1f71f294e5a94896ea1ead7.1790602223.git.asml.silence@gmail.com>
 <20261005091111.GB10727@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20261005091111.GB10727@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261005_044320_042604_B9EE3735 
X-CRM114-Status: GOOD (  13.92  )
X-Mailman-Approved-At: Mon, 05 Oct 2026 04:47:07 -0700
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

On 10/5/26 10:11, Christoph Hellwig wrote:
> On Mon, Sep 28, 2026 at 02:32:21PM +0100, Pavel Begunkov wrote:
>> Add a simple proxy implementation of init_dma_buf_io_ctx() forwarding
>> the call to a new struct block_device_operations operation. Also reject
>> dma-buf backed iterators for buffered IO.
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> [pavel: reject dma-buf without O_DIRECT]
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> The Sashiko report about the errno on fallback here looks real,
> and is probably easily fixed by setting a proper errno.

I'm going to move the check into blkdev_buffered_write(),
this should cover both paths. direct_write_fallback() will
see -EOPNOTSUPP and fail appropriately.

-- 
Pavel Begunkov


