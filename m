Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557E2C982EE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 13:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NkeBIcnXDbJI7xttPPj+BDZba0zlv1qCEuppUmdh2T8=; b=KppJSVu1IKc9gu4+z/mOu8HCmK
	FOu7Gorpo1k8+5Wy1Z6ZtFx68DmlXYnjgkZylDtFb5Q1/IgsTcZX94nXuEKI0KbqfhxzgmsqaEHMg
	b9JoPk1OMJWl+Iyn16XQiLEPz8r/aCdrstIvCv9ll1Zow8a+p6IoAHmBfYl2m3wLTX7dLfaKcFx/T
	YjxTA1MFl8dPYajZ/JrPZWeMVFiNmJqry+ac2ZOtLO7HlRJmCzbUDBD9Iig73Vk5szfPQv+eV68OE
	xiyKdfY40zxxLGDiuUo6y49bQOSaK1VWv9ef66y9g5SUxjE7MaxxgCNOeEjFnCImBQe3N6Lqdt1et
	285JnBFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eJW-00000002H5M-1qkg;
	Mon, 21 Sep 2026 13:44:10 +0000
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eJT-00000002H4s-1yGA
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 13:44:08 +0000
Received: by mail-ed2-x10.google.com with SMTP id 4fb4d7f45d1cf-6a985fba28bso3536311a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789998245; x=1790603045; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NkeBIcnXDbJI7xttPPj+BDZba0zlv1qCEuppUmdh2T8=;
        b=rstUnvUOC5bNka3OGsV1emn7cs98oUoQ89Yp5conz20kK71tVXJ2i9kcKa77RQrNNx
         Jf+lfooktF+ed/V9wuTAwBcEQbGA1mObcryuVxU5pG4sQVETCPuHojmlgRh5RImtNjQM
         hpV0ny3TQzdjJBneNqKtX4CmgzvW8HqBGVTRcYgmvmLaxdq+yY/PwRMAkt5/4OKnj/FJ
         mydbhz52XIMqflKFkPwkau6wVvuHxW4EamQGH14A0+eWLHFjfIHeaqLiJQ92YT9oKGmS
         XZN7NQobSTn/ebZPuOKNGCHgaDA7AfwDEHV+/skBOatbEsJhr7/1kJrruttX7gL969d7
         TEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789998245; x=1790603045;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NkeBIcnXDbJI7xttPPj+BDZba0zlv1qCEuppUmdh2T8=;
        b=FqWBpOafUkJ6Qr/B0twTXWloP0p5CWREnJtf4ucS9dH02HPhBWMjw3Uuh6FbO8ptPU
         pd0vZ1SBVZaBlt+fXenKWObPboyV7B/zRZBcdgz8b3Dxq3GC4KLH4aXvBhz6AAcZpLho
         ZV9bZxI4D18/a2fCJFRtnyBDjHSNqH2hMpIwEbR80BpipkL/2TtDQhnEAVqydB28SbaL
         SSfgT9LUKsRMbdmzrbZo4dfwkio+rASIZryri5ti4KVXYX6NbktnuwZXpx/8i7OMsNdd
         uCAZ5EISzMUzZxhyo9gm8HMw2U5GvJ760oOCZxQgzczHGYAmOTNO+3o83P+p/MabermT
         DjWA==
X-Forwarded-Encrypted: i=1; AKwUvBzGkzo6JmWN3J+In0awXDR6AFf050YHr84XgynQxJn20BRHs1LosQtkunxeX7EaxVLKqZneoqTlYDdd@lists.infradead.org
X-Gm-Message-State: AFuF++lik8NGKiWCGI1SELd/l6W3ib27UBXtDwFYhvBwx6j+pVCUaVk/
	mQvSuBVEH2tT7SU6WS/DZFUTs2cDC0RxtpdiOJ2In+LFZaybkZkcd767
X-Gm-Gg: AYBFou0eul9/a68wQcd0pwwF0myOFxbn/tbHXIbPxPYn8JpINXD3hXU/oL5qHC1QdAL
	ccvcT8Vz5SCwA6jymzMvB4AEEysYgwMYk3pgjX6LPt3FH0BrOS3DVP64MZQERvJYmJFNdGIaXw+
	3EsFmcFhtJJOyGyFfajCEmvX6eZQ+D3+9vDfrKU+sN/tIjhH/sVqrh54PKuWMCK46L7IhHTFEni
	Ef0A3MgwSJbdt3osXR9xFHfWsYEuby/0EITdcxZ/tdx32Ba0Zh9MQJqdbmQ5lsgdYxYK/X41kjK
	L5nNKgmm2YrmmuTPYGgTPq8/uPT+NT2oxOfiy6/Cge2uyW8asDUPs3lOghb2ZPxURIv3PCocsLl
	4en+5FGm/3LXU8K7uwkIwrX/xYk7I4qMYzwt131UeRiGqqMJgcMioJFlCFhg4H/X5VZdDChlBl8
	K2/tm+d/dZEKxNQ6I6WUhW6dvkGA8vRkJrGv6qoNeV22Z+7ayf1q74RfGIDjFZwlurrv73AAtxT
	KsykkIcQX6zMg4M2FdMBulzFnPONLyN8K3YjrhjrSvugNwLXqn7C/sdJOiGZr7S7QVvfn2mfYfe
	cDWy7hl0Z3itNe0wg3WS4gKuAp93HFPRSp9rNg==
X-Received: by 2002:a05:6402:2355:b0:6a1:4458:7f2d with SMTP id 4fb4d7f45d1cf-6aa53104448mr8100478a12.5.1789998245342;
        Mon, 21 Sep 2026 06:44:05 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa67e0d3c5sm4417232a12.22.2026.09.21.06.44.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 06:44:04 -0700 (PDT)
Message-ID: <b3e1db34-45c8-4723-8d09-eabc28bb0988@gmail.com>
Date: Mon, 21 Sep 2026 14:44:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/16] dma-buf: introduce initial file I/O
 infrastructure
To: Sidong Yang <sidong.yang@furiosa.ai>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, akpm@linux-foundation.org,
 sumit.semwal@linaro.org, christian.koenig@amd.com, nj.shetty@samsung.com,
 joshi.k@samsung.com, anuj20.g@samsung.com, tushar.gohad@intel.com,
 william.power@intel.com, phil.cayton@intel.com, jgg@nvidia.com
References: <cover.1785596451.git.asml.silence@gmail.com>
 <ff5dccf71e8c03d62797352c4bb5fbb7c6c759c8.1785596451.git.asml.silence@gmail.com>
 <20260808074245.85757-1-sidong.yang@furiosa.ai>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260808074245.85757-1-sidong.yang@furiosa.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_064407_811766_E1C95CEF 
X-CRM114-Status: UNSURE (   8.49  )
X-CRM114-Notice: Please train this message.
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

On 8/8/26 08:42, Sidong Yang wrote:
> On 8/1/26 16:46, Pavel Begunkov wrote:
>> +	if (dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_KERNEL,
>> +				  true, 0) < 0) {
>> +		dma_resv_unlock(dmabuf->resv);
>> +		goto retry;
>> +	}
> 
> Shouldn't this be <= 0? With a zero timeout dma_resv_wait_timeout()
> returns 0 for a still pending fence; only -ERESTARTSYS is negative.

You're right, and this chunk is gone in v6

-- 
Pavel Begunkov


