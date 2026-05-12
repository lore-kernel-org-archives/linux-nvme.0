Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F60CD4851
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 09:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1i6gK0r7rGWa5W/9WTpQ/H0vww/+AQmB17cNctDGbjU=; b=hxrdVzcwCs0tRh4FXey9AA/Tld
	tvxebHqX7BDZcoz53cTtJkZeU+vdfVYDnGKY093p8/ENoUM+4TezzpmFRsWtyssOjzn3pt7jwVG5S
	c6SZ0Al6KrBrFYO73Vyhot5kpSPhePv+QxUsiMrzNx9r/pDQXaS87J5Gi/aX1Pkwu5URrROJ+mU6m
	IIsVmI1ws6qrwKsT9bUrEnNywNN1tvrmMIvFb2JhZvwMb5EFliRk/3Mw623W4uyajYAA1wPW7qFlg
	SWCKeq4tpG849UxPjar8S6AqCMDfrlTm1BMRTuNWcOL++UiLZy7wx9Dgz9oBzvfc0zQO36VOsXtdW
	mLTb2bdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMjRq-0000000GGk0-3lLA;
	Tue, 12 May 2026 09:30:42 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMjRo-0000000GGiM-0bqe
	for linux-nvme@lists.infradead.org;
	Tue, 12 May 2026 09:30:41 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-67bce1840f1so8345145a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 12 May 2026 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778578238; x=1779183038; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1i6gK0r7rGWa5W/9WTpQ/H0vww/+AQmB17cNctDGbjU=;
        b=LhYVrusv/AfMG+pE7rm1TWds7pxDO2vvPgw9xxLY80UHEZggCiDNZjvupGBYTHm16a
         8Dd1bPcyhjtQU72DeAjtn4YSgpBEi6Vxqqsqi2caZdZgc9AG4htRYhNVU3C6fykTrunq
         hfY+uR53mUJ+q77LIu45XjA7HW3uK3s7Wzn3Jn8ZAKo/cDgx6Pf/DZWogoy3F11w9vWL
         Eua5P266ETDNiMfVZcODJUqNH63gjICkgedQrzZgDpzjb/PI4vIxjKYg8Kwwu1NQ7Wsh
         iE2nk/O4D32vigMaaaKlzjga9CnIkVWWp901Hyufg5xS4ld4MGWDV1GPm/n9+pTf8zOc
         mBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778578238; x=1779183038;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1i6gK0r7rGWa5W/9WTpQ/H0vww/+AQmB17cNctDGbjU=;
        b=hbEW0xmNX+shthbwD2stw1w+IojEkbdnAYxquyuVZoORgUTfB3Z5KcbnYdVBS3giRc
         0K8S/BYjVRaw6xJa1PmwTjACFagNJlP2bNxaIlXRYZH3YBylUnskULhBHLOIFXietPGw
         0B10HnvY4LwcKlrZ0+4qmkzps0ZYL3gErVknzUAJJh9h9tIkGmv+reEzhnlNdC1WF83d
         YLYxjU7ev7mA2HPdPi3leRDIQ/S1kE54xls5HUC7ZI+YjpsKRjBK+Y3G3SKn1v4rYaHi
         hS5k0OMv/6A2yTodUct34G+bOlXt3HHg+pzRqASnwO42gTeSlL61dxijlIGosR7WnsiX
         6WQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+DIump0lX2rYmijXKHtvtk73oNWvDGuiOvoPnGuBe3QngOZ2KkgWpLw7L9r5dKfgtE092V3qS6fD0g@lists.infradead.org
X-Gm-Message-State: AOJu0YyIOHOCUUFpNkcR5K4GLOBcgNRq3/BT9H0TUJWAlSiBhhM1Qdpr
	VLqFuban7XJwqISfuweT0amWBP8b1oHq0CSVpqoRZpQX9eUgbCgxPb11
X-Gm-Gg: Acq92OFElxrxxVwJfFM9BlR2M7pQaluVp5ZA5keD/NWXfoZ0pP5AHSYrWrCZMwb6l69
	94oR7I0+cDNVEXtYWvQD+H6fnMoa7S4kmPzuFrDiLXDYXniEm7r8aWz26ZWfH5h73uKbKlXBEtn
	QAs6jjhMtlTYj9Oa70cP/4rHpQ7oUcKB65HR/+k+qODk8FrMY8Sz+d26RZXvt1yMZriCRo67kpW
	pzN1fuVO7SCoAtutlrQC5Pr8rWvVZWX8/+RsXQDUMGxAPimXDsoDSYyXc9+OtrtR4sbQiKN5E1T
	HeAQaEm1+AfHc+MB3TzZZOXRz5wtu1KFeUeLpjz7Vop8CW3woEcRpzOxrzn5dCtQ5TfGsroLUdN
	33zqqYypbT6zLsS8/tamxGf+oLsARu+jTya0+48DicUgcds8AxxcQfkH79Wn8CCYL5cyeQaEc4t
	rGd/TGZBmoDcf+H5ck8949MbOb/r3BhmLEctQURXyZ6f9zhOgh5sPQFOyohu4mImpDKSQmzzhJi
	HO4c4WKvz7J2hvXZTtvqKXsXAe2xt+kSbdjIKgbsTeuQZ4fNg==
X-Received: by 2002:a17:907:97d0:b0:bc2:1dab:3ea0 with SMTP id a640c23a62f3a-bd28de036d4mr114881866b.8.1778578237873;
        Tue, 12 May 2026 02:30:37 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::372? ([2620:10d:c092:600::1:8c90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcfb7b17d1fsm303492866b.41.2026.05.12.02.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 02:30:37 -0700 (PDT)
Message-ID: <24cc68b2-c432-4623-92eb-b56b76850c35@gmail.com>
Date: Tue, 12 May 2026 10:30:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] Add dmabuf read/write via io_uring
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
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
 <afi7c-VUJWOLlC1m@fedora> <6873d617-c904-45f3-bad9-e1ae39cfecd2@gmail.com>
 <afxgc4hizusnAA26@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <afxgc4hizusnAA26@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_023040_209336_3580476A 
X-CRM114-Status: GOOD (  19.07  )
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

On 5/7/26 10:50, Ming Lei wrote:
...
>>> BTW, inspired by this approach, I adds similar feature to ublk via UBLK_IO_F_SHMEM_ZC
>>> which can maintain long-term vfio dma mapping over registered user-place aligned buffer.
>>
>> Interesting, just too a glance, and it looks like what David Wei
>> was thinking to add to fuse, but IIUC he gave up exactly because the
>> client will need to cooperate and that could be troublesome.
> 
> Here the cooperation is minimized, maybe one shmem/hugetlb path, or memfd,
> and it is one optimization and opt-in, and fallback to normal path
> if application doesn't cooperate.

My point is that with widely enough adopted interface the user will be
able to opportunistically use it without knowledge about the file, i.e.
not knowing whether it's ublk or something else. But as you mentioned
below, it'd be cooperative interface in either case.
>> Should we try to push everything under the same interface instead of
>> keeping a ublk specific one? Again to the point that it requires
> 
> If generic interface can be figured out, it shouldn't be a big deal for
> ublk to switch to it, and the usage is simple actually.

Sure, you'd just need to maintain both as there is a mismatch between
interfaces.

> So far, ublk supports both FS and nvme block device.
> 
> And cooperation can't be avoided for this usage no matter if generic or
> driver specific implementation is taken, for both fuse & ublk.
-- 
Pavel Begunkov


