Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E3DCD4F49
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 14:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+WT00WHtAu4WqCgP+skKdKZ8K4Rq+JbbmW7SvyUtdIs=; b=m6EeUVtwDhEg0h2H1zeGr6V83b
	pTiPNLzRT6KTuplWH2tg/bxbHr+jhmJVFoFr0P+LN/IOsDFvuTB6ynJuFPAnNlQcLNk9dgSibQNio
	Bjw1tpCWVfWqOm6uqYrNQnSTIm7D6u7uDrMxRXpT4tEgUH7onAeFdqqVmLy2IEnTFmeWu9uwPG6cM
	tLJ8TqnQlbVNRCsQ5YwMFUOKzIV08eE8VSKxzYfJn6N/C6/o7/GhbbYcHk2hu4vRzeuCfHTDyp78d
	cR0xJliOBEqCDBqNjMfmcHwc6PKqZAK3QoeQLKsZYeVuZAf8pi5UsimF9f12Rud0iEcZBtl16bGsH
	LRwEku+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOyVk-0000000Fu0d-3x0z;
	Mon, 18 May 2026 14:00:00 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOyVi-0000000FtzZ-3oGu
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 14:00:00 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-67b32c695efso7118977a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779112797; x=1779717597; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+WT00WHtAu4WqCgP+skKdKZ8K4Rq+JbbmW7SvyUtdIs=;
        b=hjIrapEoWSutR4rxauBL+Fqrb0hxlJ1INfvh+DQpsmQ3Zk42X95h7okGumaleEv0Ju
         CWDNyOFVNYDMMtWlDbdrQCOI8EBiPgO2EDjCrxu9OnG8fDx+nzSlh+aEjyoHTn0AdNgn
         SZq3SmdzgYA9oa3OCs7u0tbBx7bXh/aRMa4PGe3Zbqc/9JFXzzoKKuNWdVKHTgPjQRk3
         /XoPoIYCn/rSnjLz2TaA3XTKqD49+8SC1i1OS6rGdeIkW7vOzD+2m0mWjFqa76qsKCeb
         x0n7yDm33UxX02HaIJ10s1PTi5pavDmbI9ReOPOkEInJ31aGzzIDVkRw4p3RhoBAxd9i
         vK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112797; x=1779717597;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+WT00WHtAu4WqCgP+skKdKZ8K4Rq+JbbmW7SvyUtdIs=;
        b=EmeOrr+1c4E6G99aY6+4bPz71FB18oHe2hObzgIuSU6kJsxbpaTLxS0y/FcVVAqiF4
         CKQzNlhmxvWrKcTqVsEsXnvanPVnAgNgYRCwZx+mHAUESMV6dEBoJ4zWcTES+Ks2NUjy
         yEvIkpBW/Gi/FJyJFQ/BvM9Nbv+vYDvFUSjdWbZhVPvOvAF581qovns5OIILO6uGrDEl
         uaBfenn6MRIkxTaWnQma06HZgGHZmnYxgcPOGvSECuzOO6xXGnFd3fz1aNYlEjmp8QiT
         6ZlINHLx/QSRd3oqUlxT4nGviqyp8qMdM7SVg2S33gBVSYChq4ogZ0slFwYbUY5i/NPl
         ekIw==
X-Forwarded-Encrypted: i=1; AFNElJ9zFCdHKp/kAmh5ekDeMTguszWgf6+/Kh2tYlPA6yCT7AboVAYGmxq/tChrm8Rv1fXSnTiKcbYJ+dFF@lists.infradead.org
X-Gm-Message-State: AOJu0YzZzz1Vu12x951ZhPjkEEq+9ofs8d2PaCCFT4l/Om6oIPQLtvXU
	zKQ/+FxX/bHtEtsS3lIal2LMOJSjP03+c5OcszUhat1tO1naVg0DW9Sn
X-Gm-Gg: Acq92OFmEqDS+Zz9XcvAqb4w1ZtZeIqrVKK+Wb+hqVHi7EfFcY9zcWj/WHpv0GA3ynh
	wBh48DXHvWDZYYkCS8rLFhwmU64eftmJRUh2gYHev1jS6zIsdrlwS1kMd5tSJ+f7Wr61XIPeJsO
	01YlYg022D+DLrHBdDOYJeD7umLRG7OT83TbqXW+9eEMdaJfrTnZVKNFdl//VCCifed8Z1xr3NU
	iB5fFCq5iUDaVD7DmyY6VA3LrKG4xXYsDGKMPTP6CEFgzgh2BODNhLrp2KPSsejTPHPM7lBsVyJ
	uZkUY6uQ6XRoIc9qfrGmjyPP6pOS6btw+YCXK0pCLbN7R5hXr6IX6OONkll4ECmMkJz9SvXcJfu
	IQnkl7UQmho58sYreGGF5OSlye9yuBvKThbpFFue8CFeGvoOx3aHLzh12ojwsbUujpsWEGxRRcO
	LOS3W8F7vVpUYQxILClEMeK06dPSk4VRxD4QcqccB/tsayhtQmxD/DeZeBiu6RPm9Ss3cOmLJCQ
	MSC95dLy50wcWFw8vrjrva+I+KYPM7iUDy9OceJyI2EI8gnOHqXJYJ0Kg5722gJfeuU0fNEW8tV
	pTVp3WYgPdT+
X-Received: by 2002:a17:907:3f1d:b0:bc1:7da0:21 with SMTP id a640c23a62f3a-bd4f34bd0e3mr858876966b.23.1779112796524;
        Mon, 18 May 2026 06:59:56 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4dea94bsm565057266b.33.2026.05.18.06.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:59:55 -0700 (PDT)
Message-ID: <166da921-77bd-422e-85af-ef67d6fccc42@gmail.com>
Date: Mon, 18 May 2026 14:59:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
To: Christoph Hellwig <hch@lst.de>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
 <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
 <20260513081929.GD5477@lst.de>
 <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
 <df697a76-c700-4908-ac08-a47ad07e0796@amd.com>
 <4561c621-817c-46be-8ff0-0b557f6c819d@gmail.com>
 <20260518125713.GC5754@lst.de>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20260518125713.GC5754@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_065958_970245_EC174C5E 
X-CRM114-Status: GOOD (  20.48  )
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

On 5/18/26 13:57, Christoph Hellwig wrote:
> On Mon, May 18, 2026 at 01:40:18PM +0100, Pavel Begunkov wrote:
>>> When that is really a performance critical path then you can use the likely() and unlikely() macros to give the compiler the hint which one to prefer.
>>
>> That might be more penalising than placing them in the right order,
>> and it might be fine as it's new and all that, but it's not a clear
>> cut as it's definitely not created to be a slow path.
> 
> Yes.  Whatever the caller is using at a given time is the fast path here,
> and dynamic branch prediction in modern cpus handles this really well.
> 
>> TBH, not sure
>> why we're bike shedding such things, is it somewhere in the code
>> style?
> 
> It makes reading the code annoying, so it better have a good reason.
> Now for a single conditional it's not much of an issue, but these
> things tend to pile up and then start to get really annoying.
> Always write your code the most straight forward way unless you
> have a good reason not to.

For me, having the most common case first is more natural and
readable, but I'm going to flip it just to avoid spending more
time here.

-- 
Pavel Begunkov


