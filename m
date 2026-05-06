Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA3FCD342C
	for <linux-nvme@archiver.kernel.org>; Wed,  6 May 2026 09:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mmaZWXsqMxYY1SXzoardDG6u5dyIRaJ/iULJJHwbN+E=; b=tERv6DbqhLSqKR5zS4nuCzBHXB
	/hCwXaEz+tXUq6DW7hhnUXM/euUcc/mPgz6ODqi6JMM/Islm+NJPQU0+VItJ/Y6BXKliytYmgcdVG
	wMaRh8AmrSlInE76j0U2lXgAuh6J6NP1bg7oNnkaNC8fq6uG+PQJ3Sxdkfdjnw6oZmXqNTwqBfeIo
	ifdBNfxnvkjNm0LvA2ZVMpCYlWm0MegXtqDh2hgLvwFsA1ftbe1eflKPpmBleqq6SqEXoD7TPq1Cu
	gfvm6ESe1RBKuzu7zNXduySGlZUjhEkcb29s5hh8SpF2aVj7piwknJnJpPrHijaPwj8FUF6gKstTM
	Ks/72f+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKY9D-00000000HHo-0mhY;
	Wed, 06 May 2026 09:02:27 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wKY9B-00000000HG3-1jpV
	for linux-nvme@lists.infradead.org;
	Wed, 06 May 2026 09:02:25 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-488b0046078so53741775e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 06 May 2026 02:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778058143; x=1778662943; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mmaZWXsqMxYY1SXzoardDG6u5dyIRaJ/iULJJHwbN+E=;
        b=EPJTG+NT0gy8SnBo0rJIbmApoyt0Sbs7+qFJfg07YCRmaLhhKE8M+uv0+KSxVnP+Ky
         J8yEuzm0qiqm71u8TvJwMiH8Exu3cKFwDRLZrwrA3zX+uyFxOHr5TFqVlv9eH4OiJO9n
         u1pUeAxJ4b4sUQiNmV1sBn+Ce01XEMlgsj33jsr0heLNHHh3/iOLPXwRpwlJmVA31CT9
         Wv0qH/6ZvkZZRKofGcqQNeQTRIpSkT79y+fRi5+dvFsRR4XidR0L/OiZl2NN+Gzi7TmA
         eegazIKo5cMseV8KaI2pklI3v6CAF/i11X+T83myR52DYc0HGlf+RTRo0OdeRTHbHrkO
         OreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778058143; x=1778662943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mmaZWXsqMxYY1SXzoardDG6u5dyIRaJ/iULJJHwbN+E=;
        b=OkWx/9k1e/CJ+Ew5FQ1l2aU0crkzlKqDmw1nksFr+O3FEG8H8E1dOfmJ5L1dNoNVC4
         C8Q+onz2z0CoZ+gLfL6TMo4pT7QTwVNRdeq41haRV6KY1ofi/5DqbBwgLvMRKraWb6OO
         Mpa5ZGQXIx117DamrhloYmRCZ7OVbDG542mPjK/eJea3JR7PKha95Qd3t02jv7ijw9dM
         CDmOajnDSqJ5qrUP+W97EgBlvgP8rrmppaKeV7ZxOTmGlhj8H5TYWH9TAlbQIG07h7K9
         c7Hf2iZwU3MoWZBdY0WNOaAfD886uNTCXISM+LaOY9Fb1bM9sOWlEhElp9uzqoKif8Zw
         F6Pw==
X-Forwarded-Encrypted: i=1; AFNElJ9/I1z5L7hdZE65xtc79IxwRb7+T1uwsYbzEw6SOlhVuhNnxL0dXBuCfg6s6PaFPnEi2bhdSoGnT3Zk@lists.infradead.org
X-Gm-Message-State: AOJu0YwzeQYb6aCa71BkjvcJ2evTBwYPxxO/vH6+FszbW6wVSG2yU790
	SRWzT85M1IL+SfB+VSTgaSAP62Pna5ygRk4ChiB6c/NsrX5FRzd1XazT
X-Gm-Gg: AeBDieupiibnanRbb9mrDWxWSS/q+1wL2axLP8du/Q0e3U36/o4rAAFTLh2Cr1R5IPI
	icrrNX1uYMyE2tC9pZkQJBbcpCc+DmLVcV7SViLp5XYssHD6h3S15pNaq2oRT/6oqC4l13wHVgO
	RN/BTClXIIvXiy1U5FkBNOy02ZIe/qwx6mcsk7o2b9sTIk7uPurOCjRbI0/jupUsuxFzzjlnPe7
	HOFHyEiUNA4C2dwZLOugf++8uwEE8l+MEF4fgzfWDdZRjri+iqifBksElu+Ayyf2Lce0m/MJdXn
	kvsktvNkE0oQv2Om0vXdJU43L+bU33N/22al50UxtYbWztFS0ViRUAKGerE4kyVabWAXfCbJ/R+
	rCwJcSJSC9dxcIAUHcYBT4RCHHJRFh7qX598GwEhUP0qZBtrIjhEFoitjLfDRByUYVzTshCMkT1
	dNO07sGlpMCoPjqV7HWY83lCa/P8gwBMffnksDyrBknxo4f6TsssEesMEKFLs2OeEct1HC8FmLS
	A1jpP8lLcipXMGHJ5lM9FoL/2pWpIrz7YEFEnkYlg==
X-Received: by 2002:a05:600c:2e0c:b0:489:1c2d:211e with SMTP id 5b1f17b1804b1-48e51e0c833mr25734095e9.5.1778058142476;
        Wed, 06 May 2026 02:02:22 -0700 (PDT)
Received: from [10.109.92.22] ([86.33.71.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e52f5c1cfsm21365215e9.0.2026.05.06.02.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 02:02:21 -0700 (PDT)
Message-ID: <6873d617-c904-45f3-bad9-e1ae39cfecd2@gmail.com>
Date: Wed, 6 May 2026 10:02:11 +0100
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
 <afi7c-VUJWOLlC1m@fedora>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <afi7c-VUJWOLlC1m@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260506_020225_482077_C85197A9 
X-CRM114-Status: GOOD (  28.19  )
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

Hey Ming,

On 5/4/26 16:29, Ming Lei wrote:
> On Wed, Apr 29, 2026 at 04:25:46PM +0100, Pavel Begunkov wrote:
>> The patch set allows to register a dmabuf to an io_uring instance for
>> a specified file and use it with io_uring read / write requests. The
>> infrastructure is not tied to io_uring and there could be more users
>> in the future. A similar idea was attempted some years ago by Keith [1],
>> from where I borrowed a good number of changes, and later was brough up
>> by Tushar and Vishal from Intel.
>>
>> It's an opt-in feature for files, and they need to implement a new
>> file operation to use it. Only NVMe block devices are supported in this
>> series. The user API is built on top of io_uring's "registered buffers",
>> where a dmabuf is registered in a special way, but after it can be used
>> as any other "registered buffer" with IORING_OP_{READ,WRITE}_FIXED
>> requests. It's created via a new file operation and the resulted map is
>> then passed through the I/O stack in a new iterator type. There is some
>> additional infrastructure to bind it all, which also counts requests
>> using a dmabuf map and managing lifetimes, which is used to implement
>> map invalidation.
>>
>> It was tested for GPU <-> NVMe transfers. Also, as it maintains a
>> long-term dma mapping, it helps with the IOMMU cost. The numbers
>> below are for udmabuf reads previously run by Anuj for different
>> IOMMU modes:
> 
> Plain registered buffer is long-live too, which raises question: does this
> framework need to take it into account from beginning?

Not sure I follow, mind expanding on what should be accounted?
Are you suggesting that we might want to use normal registered
buffers in a similar way? I.e. giving the driver an ability to
pre-register them?

> BTW, inspired by this approach, I adds similar feature to ublk via UBLK_IO_F_SHMEM_ZC
> which can maintain long-term vfio dma mapping over registered user-place aligned buffer.

Interesting, just too a glance, and it looks like what David Wei
was thinking to add to fuse, but IIUC he gave up exactly because the
client will need to cooperate and that could be troublesome.

Should we try to push everything under the same interface instead of
keeping a ublk specific one? Again to the point that it requires
a cooperative client, but if it's something more generic, the user
might just try to use it as a general optimisation. In the same way
it'll be helpful to fuse, and as a bonus you wouldn't need tree look
ups (but mandates clients using registered buffers as a downside).

It'd need to shaped to somehow work better with host memory as I
assume you want to be able to map it into server in common case.
Switch case'ing if it's a udmabuf is not the greatest approach,
but maybe we can figure out something else.
  
-- 
Pavel Begunkov


