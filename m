Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88025C5DF81
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Aug 2026 09:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tvr23X+CegyVjqQJgHYb0m01ZH3nYD0og+5XwoMdqrw=; b=s/GVnnmUSC8vSFl/WSy+giDKqd
	kGQt1Eo+e7nbdzffgOPNE7KJnnraRTwV/pmO5AZWbYyluRI61QPFnU6Qbr7jCRgpyNv3e78eyxwlE
	WKAHTKraCdgL7psub/MyO+aj59ebWaAqHYGUr7jMtN6KBWWnOkufNJZlqYp5DgYs/FBCHwI6G+aOe
	HT4B7bvR6Eoe+hMdFULGhP0uPEGlqTFmepWdWwXoqNz92l5HcHmXB5/HzPcLdAc39RKvJkx5wDf9i
	E4aMPqJFl33KSFKCgQvciGoFxq5eET8VwAHgMWWfPtK/3ScQ8/8Gyh/MPo9ahm4J8cY2kgqP49f+T
	p5275UcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy4SJ-0000000FDUk-142t;
	Sun, 23 Aug 2026 09:25:31 +0000
Received: from mail-ej1-f51.google.com ([209.85.218.51])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wy4SG-0000000FDUI-422g
	for linux-nvme@lists.infradead.org;
	Sun, 23 Aug 2026 09:25:30 +0000
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1677c91969so293455966b.1
        for <linux-nvme@lists.infradead.org>; Sun, 23 Aug 2026 02:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787477127; x=1788081927;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tvr23X+CegyVjqQJgHYb0m01ZH3nYD0og+5XwoMdqrw=;
        b=Bj0qUrMTfgdVdxYtwynZrGNndyGMfilNcE4VRGKSlVzg/ZayHGvSIGGJSWAuyqQhG9
         qOWkRN+SIEw9pdwAGzB82NJP6kIibEn2xCFUdoRnUvgxJkFFVj5YVOvZEpScOfDot+BA
         VH+S3f+1ESNKJqie8WF/1Y8xXs4aWAbPkNBo/Txh7U9A9VJqMcj4OT6CU25XvChBZbM0
         stjesjRhFdobQgawcUfSXkv8rUe7c7NFRJtiydDgyB/RiihYYuI3x/wEfrRYOrqV4paA
         yrQk+5pizj5tBs/Az6PAmdZmfWVEcdfUM6x/6QNW1khuCa0gzI2T8M4oZz+0ajGR39Kc
         Naqg==
X-Forwarded-Encrypted: i=1; AHgh+RoBl4bCTPaiYFGqxY9YP3iLAoXAzXXgmN9ct73eRfbMRzt1MvlroFQQ/oF2OgGWWp6nxfXeVdCXu3YM@lists.infradead.org
X-Gm-Message-State: AFuF++lCWlLsizpRmMyKI3GKrPJp2qtszkqDxK+dgyxm/gWdWox3NaI9
	/3twe0vh8HqC7tBhiunKum1wbmWoUb93gWgNERo9g06qTljAyDv6tTsU
X-Gm-Gg: AR+sD122Lj424mGIuOw4G+eVqHHOAvCh9zj5p2MXp/bvjQHnxQw6IANkMDYeIvsCVH9
	mskRFou3ARE95YnIQp0hW2guf0SSCEnt9YsjqYluYCTyPcmAYrnhlI52OOMIhyNU+/sMDvI0XoC
	Dh+MrLIlP8SsUEwuP6E9rWuPPKxPpjS46BByCZ0R8RDVs+fHK8uZZPe0ZOIaNO4ij8Xlj3GSW/O
	wULXZUUk08oq/25Y4qvckxqDahtp1sx5QGnFAVu44bZXstAw2mWkX4idLegT97cG6yVwwt9ySu3
	Gz8SmHMbxDeFVusLWwklHmEGrc8JPBiMZEC/qBXCreb9AKc4v+3Bm8IvptZo9IG6r1kfusFfDGt
	uQIcrxhL1j9/PrZVGxv+0F1Uz3jJQh/5dGWs0KPE4Rb6/xuxxW7PdlC+yZbxcOEFlbVHKL3Sm6U
	aY2pocY8f6P0KopkK+x3Gss0gT8PfaIFH7lX8EQc80a7Tv5y313eOQahN5j8GELnQwZrKifa9Cj
	AHwpJQgiIPMv9rPHObP8Ut37W5UlpE=
X-Received: by 2002:a17:907:cb81:b0:c16:831c:427d with SMTP id a640c23a62f3a-c249274b411mr1257104866b.21.1787477126909;
        Sun, 23 Aug 2026 02:25:26 -0700 (PDT)
Received: from [10.50.4.207] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606b696sm789418266b.7.2026.08.23.02.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 02:25:26 -0700 (PDT)
Message-ID: <fa36cd8e-ecf3-471b-b1fb-0cfb8a684718@grimberg.me>
Date: Sun, 23 Aug 2026 12:25:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 4/5] block: move bio validation into
 __bio_split_to_limits
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk, tom.leiming@gmail.com,
 coshi036@gmail.com, Igor.Achkinazi@dell.com, dlemoal@kernel.org
References: <20260519172326.3462354-1-kbusch@meta.com>
 <20260519172326.3462354-5-kbusch@meta.com> <20260520072548.GC14937@lst.de>
 <ag3Q5wdOBFNclfMe@kbusch-mbp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ag3Q5wdOBFNclfMe@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260823_022529_005927_71EC2D7E 
X-CRM114-Status: GOOD (  12.32  )
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



On 20/05/2026 18:19, Keith Busch wrote:
> On Wed, May 20, 2026 at 09:25:48AM +0200, Christoph Hellwig wrote:
>> Moving the checking from submit_bio_noacct into __bio_split_to_limits
>> means that we lose it for bio-based drivers except for the few that
>> manuall call bio_split_to_limits.  So we'll still need a helper for
>> them, which could be called just before calling into ->submit_bio.
> Oh good point. It looks like many of them don't even want their bio's to
> split, so probably would need to factor out a limits check from the
> split so that both can call from an entered queue context. Thanks for
> the feedback.

Commented in the previous patch, would it make sense to move these
to __bio_queue_enter itself as bio_post_enter_checks() ?

