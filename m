Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22674CD4851
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 13:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+cq+23+E96HQoAhwgeeSJr3+OJ8IJX5BGImZhad/wV8=; b=V4EWsPBb3p4pFm9TSVVZPAjQHW
	Szn2mJpjxjG+RcFxk9ExlddOQFY7NhCYMSaOsPAWw4aRLPMubJWLwvW+zwbWEYOa1lHVsoOJk9ixA
	Fc8gEiHOMy/Br6v/Q1GrEdt/pGpbqnHsIoYqqP7XrYfIics2X+a8QWFBT1O/Lqc1F8UG/E/TfLc79
	mBs9w4o/8gszm0y+lxi7SyvcQAumXBmH5fWf97ceDYwlEMrZSb/JgxslJ6I+wLsIFz7VpB3niy9Dz
	xLgHuzpC3tgNn38Fqth4UX0OIV4aiKDy1Oixf1cJivxuCxhsmwCTlA2eOrUYIOsQBhJYnIZXTxNW4
	8UGptOHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN9eH-00000002l18-0Qln;
	Wed, 13 May 2026 13:29:17 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN9eD-00000002kzN-40N8
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 13:29:15 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-441209fb77eso4152108f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 13 May 2026 06:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778678952; x=1779283752; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cq+23+E96HQoAhwgeeSJr3+OJ8IJX5BGImZhad/wV8=;
        b=qH4b2uQNh/6El89V63Noo5sSW671oDWvHkr+LckV6XDso5hHPpZUm2bHZ8Ptd2/YfU
         S5JLZCkRFSPBpfGtvlCJKD4IEtXvdcp/ka/SDtxcAvvgLqHyqnYFaCoxLz8WaAmNqMxi
         DsBdrS8IPc8NGY2ui4b970TvPzmeJfDGv1YNUpulljKczEURbGGjx78KAgh0jhG7K/ln
         kbGRaIZIGDpZBwPRjeqj+XfbxIxUCW3I+RdNe4mBrExWdYOxKRTmBDl03bI7XFnPQNed
         9jZIAZVkz/2cnlCewsMEtlOeGlMCh1EJQspIQyOwJCJxCNprzmVY1KOudMLWdHxamcg3
         R6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778678952; x=1779283752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+cq+23+E96HQoAhwgeeSJr3+OJ8IJX5BGImZhad/wV8=;
        b=OW9y/gE4Hv4FUvGv6ZzX5tJGvAvlAFWEcnaV//6crpxKxeCEfJ//5TIpDrQIuLpgYL
         nkeVg6766bIc9Gc/utLszk8+6YjHLCF5U4rTXnYMRTqB5sS/WUekiyAI3Wfv3pOJkUvt
         lCnhCE/SXhWi/RxFMJByMp2/Kp40nkDFGJO5KXQSDm5QLyKvXk8K48Tpqed1yEdp3ydg
         yNcM1cnmnlWSWae3Kwo4gI5By97QI+6Y/XqgKi3Rc9tOjjjcnqzbzacw58gBGZ9ptI9N
         Sm5aAp8fW4d5ZgXGCiVtTIYWf1Fhl937oX5Alz0UpN9TF/bZYuTh6rAFFT/KBOamekre
         wcAA==
X-Forwarded-Encrypted: i=1; AFNElJ/vI2SxF+RA4HfnOcSCResfcye/L5M6CKK3BuTVGRoUajRetrQeCmiNCToe1PH3OnN+wOkplVIhDli9@lists.infradead.org
X-Gm-Message-State: AOJu0Yyy0xs9gdsp7HgJBjnxrUJbWujiEpUR9bo4q2/pRsHcHmUrIIE6
	DQBfK0ghXCUOyeQQAJUZaqk4sk5Cj5lucGRuWHfTiBUhr/aN9uPrSiGP
X-Gm-Gg: Acq92OFdtzT4psYivYj0ddei+vRGi4/67SfgtyK2Ie9FARgHi95+Ktk6dqjDmzJ+eOp
	wc9kCbUktlD/p3qmmHhuTNrw8WZTeWHRjBYFAQAxo83Sest6xC5N61jfUgh9M6/VeRYQ9Z+CaDX
	ssiRRB1IZph59UcQi4pT0OPpcC0RzyfBRKWCAvngzbhAkdiS8EYowSn+fHt8PQX36JKeqZUvjB6
	J5pmnE6XjkgX56ziK2gDBFMXHthYnt+XwWLlXxJnuK5XNhqrnni59wDBudqR1GT4/nP9hSMx33M
	iABpo4TMg6shfaNla4ModDVxWAHCu/Tphhe13qgGzqmEK178PKZjMU0UBUz3v5yMojdY7kGK/0A
	LIX7sIBndGaYBeqH4K//+Idryn1sF2whCjW+e1xjPK7vOdc/Tu4EAao3XBOHy0KkrkMiVSD5Zx+
	Ky/+T79zXFBvUoj5Ko5KIUxzaGDNCchdoq4KOyix0PQt54CYWRicHEgF69tEPB
X-Received: by 2002:a5d:591c:0:b0:446:708e:1e8d with SMTP id ffacd0b85a97d-45ac4504a13mr9930360f8f.30.1778678951817;
        Wed, 13 May 2026 06:29:11 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120ec0asm40068578f8f.17.2026.05.13.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:29:11 -0700 (PDT)
Date: Wed, 13 May 2026 14:29:09 +0100
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
Message-ID: <20260513142909.03ae6c2b@pumpkin>
In-Reply-To: <20260513110557.705bdeed@pumpkin>
References: <cover.1777475843.git.asml.silence@gmail.com>
	<20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
	<20260513110557.705bdeed@pumpkin>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_062914_014853_39591041 
X-CRM114-Status: GOOD (  15.16  )
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

On Wed, 13 May 2026 11:05:57 +0100
David Laight <david.laight.linux@gmail.com> wrote:

...
> > @@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
> >  {
> >  	if (unlikely(i->count < size))
> >  		size = i->count;
> > -	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
> > +	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
> > +	    unlikely(iov_iter_is_dmabuf_map(i))) {  
> 
> 
> Doesn't the extra check add more code to all the non-ubuf cases?
> This could be fixed by either making iter_type a bitmask (with one bit set)
> or writing an iter_is_one_of(i, ITER_xxx, ITER_yyy) define that uses
> '(1 << i->iter_type) & ((1 << ITER_xxx) | ...)'

This seems to DTRT:

#define _ITER_IS_ONE_OF(iter, t1, t2, t3, t4, t5, t6, t7, t8, ...) \
    ((1u << (iter)->iter_type) & ((1u << ITER_##t1) | (1u << ITER_##t2) | \
        (1u << ITER_##t3) | (1u << ITER_##t4) | (1u << ITER_##t5) | \
        (1u << ITER_##t6) | (1u << ITER_##t7) | (1u << ITER_##t8)))
#define ITER_IS_ONE_OF(iter, t, ...) \
    _ITER_IS_ONE_OF(iter, t, ## __VA_ARGS__, t, t, t, t, t, t, t)

int foo(void *);
int f(struct iov_iter *i)
{
    return ITER_IS_ONE_OF(i, UBUF, KVEC) ? foo(i) : 0;
}

See https://godbolt.org/z/sMz93zah1

Pasting ITER_ on the front ensures the values are constants of the right type.
OTOH it makes it harder to search for uses of each type.
You could paste _ITER_ on the front, elsewhere define _ITER_ITER_UVEC
to be ITER_UVEC (etc), and require the caller use the full name.

-- David

