Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF5ED43361
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 01:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pBdi/oDzvSWIXA9titZw8xt1yZ2pS2N9m++Fybej/Mo=; b=t2YscB1J0am3sj3TKpuZuDq+Vw
	KsGPwBRALa8xT7Ew0JJR6JpexC/2eanq00vbojDDCcXxwbZrHB2UZ2y3YaLPgL78K66c9VyELcTwC
	IuSnYE9RwXr71+TMRqnTpTnv2anjKV4w/95hmQi93Wn6w/XF8o0XAFnncIq4YC1Oex3McuQe4fIDa
	ey67ypthul5qxf4azrBJq+BhvCarl6XOqfsd3vKnqZMQe29x46crulOglyMrlNer9+4iN/qxX5Hdf
	42Qf/8QTtglxYKm7vXomTLVPNTxRdCBmPJER1/jnUr1nK/BFTiLL1cHIk/7uMZfOcKq4epYTyXj4X
	qFng4ZjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTreA-0000000HTQn-1ANV;
	Fri, 12 Dec 2025 01:08:38 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTre7-0000000HTQT-2UKw
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 01:08:36 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-343dd5aa6e7so684851a91.0
        for <linux-nvme@lists.infradead.org>; Thu, 11 Dec 2025 17:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765501715; x=1766106515; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pBdi/oDzvSWIXA9titZw8xt1yZ2pS2N9m++Fybej/Mo=;
        b=JoYvzBP4l7j1tLVfviEiQLcY6eLnTsKl8GzFPNd+bRjXMImTUh5tBJsLNH+yYKfs3S
         5UNL7mcv73ekm6/6eUCqvce/auoAMQvFAsdwgZIsGZSXN0f/wpwSh89lhhQqLvDLWaf2
         3SzAa/9Me1gRh+8bHJaLyIIITLIBZ7hw27wA8zqAm7InrlBRTTDcnXX+9xgHfAXb9wku
         x+JSV1+FEO+Lv2mUOXtA6Wdo2kj1d+zay6DbEhug+/ryPsZTsnxTPG2hleEMHvrDtJj8
         uDv95LXIcsaLxBQ4Ye+cpmLrX+HPpDfAoysG4LEmPw9zr3p5fhd6dSbBU2YcuarufNKa
         lCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765501715; x=1766106515;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBdi/oDzvSWIXA9titZw8xt1yZ2pS2N9m++Fybej/Mo=;
        b=e/03KUWIP3nB5PeZS2UHKaUto0+NSrI4IljmaBystF4I/8DKtVTXf9GP/dtWMG1ydw
         +7hh9WeaaiJ1AuKM4WAjo9qlR/NRfLqwNll6TielO2xpOEOvB+g/uWec8W+bPEWRwsSg
         0q57gn/ecN7UnCEQicCKEFnc/EaIRlpS5mi23l8kZ5D6yY6dYFaQRSLzIOwGj5z1L+3r
         R1p48jLEryf5OmkqJ7dycunOTFZ2hSP/yXO6p5NKyZIdqh/XNI7j+XlpcOMdoAytOf5E
         Vi6gmhiegNdei7jfVJPJBPZ3erxH3UVLQEcl27bQOUDNfzo/aNq2DxWcyeoPwFdaWGrP
         W2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCVZbH/MPId79jracPDcqLYOwCKeIdYtWO7WOTXhbgH8f5PkHPG7ORHnboknIi107uGF5AZFC8OLW8hC@lists.infradead.org
X-Gm-Message-State: AOJu0YwIBqMtx1/xZLdZ23liesQyN+PMZUSqwsIgqNNbw8HCLo/LYvaT
	8MQilQTvynm9EJYLbFTaPMWT8x8H6pvDkTJ3sUa9Kc2g5EWyaLacytGD
X-Gm-Gg: AY/fxX5vcTWxUsGR3s+bqjths9K+/7LDtnNseySOA+W0dp8akJsB1ItbBptsWZm402h
	PQscpXeentHR4X1FbqvLVdcgqndYLdNnQexxas4KVuyilOYIBlSxXpmV7a8VGl5d7DXtC1xLlzd
	Ivx82SjYYJylv2NFkUWfhYM01stwFgLDElGf1FN7MMzU0zAXs+mBQyA8UORb9pUNXCYzh9KqT2w
	pDrvLphpkgRWpu4zt2U+1Lus7zDzrSwz6VAk+tykDtCOOddpxY18nno0Ew51HksZ9MfzIS6dZoy
	0AiAwqBEgN8nCPlEx2CzIlcxrJDcMQ/WGRC2cSyGcROzxXXEn0KXOsiJcur4ivJBAgevEdj8Cro
	Qr08oNcP4ePuNqy81KDAS5hLmvHIsy5qJ6snPELr0b5osvJlpyJPBhbeaPMNYZ+oeVgybg1PifL
	Ey3z2tBw9I5DpAgn42eD2mlz3BPCcGYOr4NAXxK5buXCYDX2BJsHO7k4II6C5iECZ+TUubhVEAp
	xl7dPTvU8wMslQ/UTCIVh5mUUxVgerxZ/SLZQbRuIvGR6bdB2Y=
X-Google-Smtp-Source: AGHT+IGFHKJf8QGiqR5uvpYaapCUZkmkibIutIZLTj7GFDM1IGCQKgJEzHKd26M9n65r0qbsOVsfhw==
X-Received: by 2002:a17:90b:4c:b0:340:c64d:38d3 with SMTP id 98e67ed59e1d1-34abd6e0220mr546380a91.12.1765501714653;
        Thu, 11 Dec 2025 17:08:34 -0800 (PST)
Received: from [10.200.8.97] (fs98a57d9c.tkyc007.ap.nuro.jp. [152.165.125.156])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3ba59bsm167302a91.7.2025.12.11.17.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 17:08:29 -0800 (PST)
Message-ID: <4ed581b6-af0f-49e6-8782-63f85e02503c@gmail.com>
Date: Fri, 12 Dec 2025 01:08:34 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 03/11] block: move around bio flagging helpers
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
 Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
References: <cover.1763725387.git.asml.silence@gmail.com>
 <6cb3193d3249ab5ca54e8aecbfc24086db09b753.1763725387.git.asml.silence@gmail.com>
 <aTFl290ou0_RIT6-@infradead.org>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <aTFl290ou0_RIT6-@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251211_170835_638381_962C9987 
X-CRM114-Status: GOOD (  13.15  )
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

On 12/4/25 10:43, Christoph Hellwig wrote:
> On Sun, Nov 23, 2025 at 10:51:23PM +0000, Pavel Begunkov wrote:
>> We'll need bio_flagged() earlier in bio.h in the next patch, move it
>> together with all related helpers, and mark the bio_flagged()'s bio
>> argument as const.
>>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Maybe ask Jens to queue it up ASAP to get it out of the way?

I was away, so a bit late for that. I definitely wouldn't
mind if Jens pulls it in, but for a separate patch I'd need
to justify it, and I don't think it brings anything
meaningful in itself.

-- 
Pavel Begunkov


