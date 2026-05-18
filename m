Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3926ACD4F3C
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KBUJm1g4jrVLHLARnQ410xCyIfZ2+knqUA7xvFczZVo=; b=3LcfPE3/B9essVTY/TWMHdE+6d
	2iVA2wgG10DgJmKuKaURDilxIbpWAFqQVdd2wd2qEQnWxFfLJFqMBVZ9KOytvXU+aDyQ2o44M3Bsw
	4WdDJ8AmXMoM23ZnfhDw+Ab84eGCOEAYKaHzPcfllUxa8hsukhTN3VoiyLRFD/vN1gAUm8mRJE+SA
	FnVAxJuMLHGMJARsUS1l1iyB0+i+PHCHEiBIADxvr2Z+qp59Sw+RvsOXCP7uQ2UHkkDN9Zc6BmL24
	SW4qSEBdln2N4mS0ZXvD9rxvg7OwsBbpAZwem/BrcBN6DWmE91/EYFXmCwUky5RB7OUOtvxitbz+8
	7Y+eWRNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOvOU-0000000FHNM-2fjf;
	Mon, 18 May 2026 10:40:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOvOT-0000000FHN6-1bcf
	for linux-nvme@bombadil.infradead.org;
	Mon, 18 May 2026 10:40:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=KBUJm1g4jrVLHLARnQ410xCyIfZ2+knqUA7xvFczZVo=; b=dx0NasrhJhqpMMiIeRF5FcHuSs
	i7r9ArL0YqlWDv+hVljAQHquZJ45j6lj8yHbWWDhvz0CFWvS4FoXZhgR96O27zk83Z7uqcRs+I0RB
	JEa8mW2A/5vCIH1+AmVJrBl8yRmNdVPvhrNTCjFY6pPtAVdhikyxbvUcozBZn7oJH0j8v45+YNmt6
	W/jgLLuMJ30m+fBLSePT5/lek7vaBnfJXVwWw782ypoUttFI/B/05e7htLAoWRD/w3XZKzBwUWono
	sH3IKjxKepfWOFE3EP+QiCS+H47SdZbrX9oBEbBcgJspH4k9mYb4inNrrDBB6zw+Ve1F1wiRW5Q8P
	JGQhOIgQ==;
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOvOQ-0000000AnNR-0W57
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 10:40:16 +0000
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso20309165e9.3
        for <linux-nvme@lists.infradead.org>; Mon, 18 May 2026 03:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779100813; x=1779705613; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KBUJm1g4jrVLHLARnQ410xCyIfZ2+knqUA7xvFczZVo=;
        b=LSxel6t3SWK0lR0rbWcJdhdGAXRqtGPm1qzsilcnBrU/xoKoc+nWrrjUmkbq8EOCHu
         bhxSZOa4M5/fM4nhQ3Cw5H4uY/oXD+OPp4fkmI5p9RDwKgvYGkrrsjmrcO47SslWzAdv
         5E1XdlAkD6DBVpSoHylzs/SP47BdfmZi8ox0MA7/vYhAPEq60FyNbS2U7baZ7lGXQHfv
         cyWfjuM7rRLuY8YXkVnXWprRZcDHReKreMDDg35RMdcdiFsi+p2VkQEyyKJ3bfC7T9Jm
         CjkZdAwG1RHjLCGT2VxLMea9wuHkH4SN/cUApcXpyf4yM6a4cUpaKHLw0wXFQkB3EZxy
         Y8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779100813; x=1779705613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KBUJm1g4jrVLHLARnQ410xCyIfZ2+knqUA7xvFczZVo=;
        b=eZwnepBt3tmAbJuVv/weT7He/RY96InaeX8cbMIu/swgsGR8WhJeCRVBvIYEaJtjD3
         45FrBfdRu5DM5opQdaz8OLDm6IEPE3r8R8xXWP7+HO7KH/22HvBQbOWZfsPNaQ+bhXYq
         dBJUgEHFuNwWuC09SRNwOAmuyRz4Z3ENhEpGnehNxAYSH33li19VWIrD0BERzx73byBJ
         0ESB8rIfa+K361pJeUdBlQmu2Ru/N4Ni9UPJ7DtMGrFw3OR0+HojqAgvnHLABvk/Kef9
         UIYfzTVz+U6/yNqt88CTjoUYgtmip1DaDjvAzBJe4fMR9IDY0DUHdhDvmk2CyRLa1WrT
         sY9g==
X-Forwarded-Encrypted: i=1; AFNElJ8hkvskUb2iaWhAxuvylncgBTgbtFlbbEfrQS2hf+2NyiPZcngdFfQi3jo44m2lZmC2zOCMXzdaw7OW@lists.infradead.org
X-Gm-Message-State: AOJu0YwpvUfazkt5dPvF0WOcUe6IWuFVxQdM+rm7GXRaweHoTdnWOZU8
	ouusVtROxPgDHLFp63hg2BQ5iPnMam7+0MRQ8iBUCgGmO+MXcQonF4fb
X-Gm-Gg: Acq92OFx5mAawdDycTscy0OBC9W027W+xWAQv71Ap5NlDDs5A/LiciMPEDwrgZ/aJFS
	dhh9PREGB4fQWTJ66VEr4CHlZddYHfsaU0wnhzBTfTz6rKQaOfL37AurColUbROMef3VZiO/UyO
	iiNTQXeDSoFxS0K3mlF2/ek47QT0itMnZ+hy6+u0RQXIbAXEy6CIG/DZd7gyKzpLfdWKPiTDLDL
	7yf1Lkbbs9O8LfUAcfzncFIs5tCVGmvudoDwDFQEm2uVHsVvaaV8afWbDJUDbjmK04eilPi6Jtq
	2xZSE7tIryvZHb99iSRztKwxHo12Ol3vEDCohnyLod03GEuS+EEUw3eDvJ4Hr+q+WqTzpltDJOe
	jwYqx0rVEGFJ1CXpPAapmNpiG/mmP01IdDYI9YnHZTzf1u3NwNRc1rpATTyIweGDQOxBsab9EfH
	yhpp2bZnoI7k4Q+hqjE2h0kbZMx0N37idCF6ulHlVDpiacFbIBCaIsk7yKegDKngQDhPBkg61zu
	S4yZ9zImDmfIQ==
X-Received: by 2002:a05:600c:4fc9:b0:489:1c1f:35df with SMTP id 5b1f17b1804b1-48fe60e58ecmr202920365e9.10.1779100812550;
        Mon, 18 May 2026 03:40:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c90b27sm255713955e9.8.2026.05.18.03.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:40:12 -0700 (PDT)
Date: Mon, 18 May 2026 11:40:10 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Andrew
 Morton <akpm@linux-foundation.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, Nitesh
 Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, Anuj
 Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>, Phil Cayton
 <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 02/10] iov_iter: add iterator type for dmabuf maps
Message-ID: <20260518114010.6e1f7391@pumpkin>
In-Reply-To: <4b2f74e9-3225-47f6-85fe-911720030e35@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
	<20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
	<20260513110557.705bdeed@pumpkin>
	<20260513142909.03ae6c2b@pumpkin>
	<4b2f74e9-3225-47f6-85fe-911720030e35@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_114014_681346_FFE0AB56 
X-CRM114-Status: GOOD (  18.49  )
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

On Mon, 18 May 2026 10:24:35 +0100
Pavel Begunkov <asml.silence@gmail.com> wrote:

> On 5/13/26 14:29, David Laight wrote:
> > On Wed, 13 May 2026 11:05:57 +0100
> > David Laight <david.laight.linux@gmail.com> wrote:
> > 
> > ...  
> >>> @@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
> >>>   {
> >>>   	if (unlikely(i->count < size))
> >>>   		size = i->count;
> >>> -	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
> >>> +	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
> >>> +	    unlikely(iov_iter_is_dmabuf_map(i))) {  
> >>
> >>
> >> Doesn't the extra check add more code to all the non-ubuf cases?
...
> >> or writing an iter_is_one_of(i, ITER_xxx, ITER_yyy) define that uses
> >> '(1 << i->iter_type) & ((1 << ITER_xxx) | ...)'  
> > 
> > This seems to DTRT:
> > 
> > #define _ITER_IS_ONE_OF(iter, t1, t2, t3, t4, t5, t6, t7, t8, ...) \
> >      ((1u << (iter)->iter_type) & ((1u << ITER_##t1) | (1u << ITER_##t2) | \
> >          (1u << ITER_##t3) | (1u << ITER_##t4) | (1u << ITER_##t5) | \
> >          (1u << ITER_##t6) | (1u << ITER_##t7) | (1u << ITER_##t8)))
> > #define ITER_IS_ONE_OF(iter, t, ...) \
> >      _ITER_IS_ONE_OF(iter, t, ## __VA_ARGS__, t, t, t, t, t, t, t)  
> 
> We definitely don't want that, using them directly would've been
> much cleaner.
> 
> if (get_type_mask(i) & (TYPE1 | TYPE2)) ...

You need to shift all the TYPEn as well.
The above condition would become:
	if (likely(ITER_IS_ONE_OF(i, UBUF, XARRAY, DMABUF_MAP))) {
which reads reasonable well.
Without the token pasting it becomes:
	if (likely(ITER_IS_ONE_OF(i, ITER_UBUF, ITER_XARRAY, ITER_DMABUF_MAP))) {
and the line starts getting long.
Although that version probably needs a check that the mask is constant.

-- David


> 


