Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A1BC0032E
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 18:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cZuRq2gL8uMCs3ZHk4SNfObSI+VLtMFw8GdVz2Oq9JI=; b=OoQDFAx7SpX/5kD1VNMjwu43Uu
	HGUbusgrC+tNy/2SG3mxvaLT87gONJZcDuEYjn5Zc5PEDRp+SJ4ygh/LgbTwQhRKKrXbGkJLyoB69
	pxYQMM3nDionyI5IqYKLcOHnt/tfwWnezxXbKc1tuBAbGnryb6wNDiOsaKCGWryfzLGIR/zF83sIT
	B/xlUbc+Sbw56wGXJ1ukS6YsbhSLn4SN0H7mY5UM621eRJsECOrXBDILeWLpqryo2A5qS0oBymMpM
	OlKNkP8uHmYYMRuake0PAgQMcZRHbxmONy6mnnKd6sLeKdGWQN6dijSj0jn0LcaGRfLRoSU6im5EZ
	D4FO5eFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtuGs-002rIe-1r;
	Fri, 20 Oct 2023 18:30:54 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtuGq-002rIB-0U
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 18:30:53 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9bca1d96cso8993815ad.3
        for <linux-nvme@lists.infradead.org>; Fri, 20 Oct 2023 11:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697826650; x=1698431450; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cZuRq2gL8uMCs3ZHk4SNfObSI+VLtMFw8GdVz2Oq9JI=;
        b=Vc7P42/QTI/y1wNlzmQ1/wo4+Bh69rauju1a7/goStVob1Ro/Ur6k+Fct9csmTDLis
         4qLm4RxjCy6aNDYs/gy03+s8gaxVDYMs7eX0lMnjU03UqBx8CVMXE4bjChggtu+hXIuo
         5z0A4j2gg5uVXd6r3OMgOLGCkm+c6NiEQE8YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697826650; x=1698431450;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZuRq2gL8uMCs3ZHk4SNfObSI+VLtMFw8GdVz2Oq9JI=;
        b=BGRwr7pTv6clQSfotjUv4VLM+ZhbOrHmo//VjFGYZjFwrzbYypVlQf+ZZZsECQqxXm
         MpE64MVnbI6/YwW7OK46NqvsRiZSCTlfcVPb25NmlDZpTVREc+dgweQoz5FS+99JSlAZ
         znBwCzgZhNDd6H8+fAqPWvzLPnif7wb6uiJ4MnMhq11gsFl1otq0Scw6noyQ6pjMza2n
         n/q8wX6YShdTWVcmHpahYvR7q1D96A5FBc9wxVebDVt9NLtzQ3f1QR/9lhBFyH5Px5J0
         F5PCN213gvUuqqWK8Jc7e5hxJg0H6EQz81shi/uAmPXm15wdb6Kn5/Ul1yu8y/7EMW0t
         m8RA==
X-Gm-Message-State: AOJu0Yyx7B1w4WIvTLxs1k1qiknOX3+Mi3v8J8IgpKymC22l8cyam8d+
	98KO5WXozIjGlyfnMDOrnMfd4Kmka4W60le8rM4=
X-Google-Smtp-Source: AGHT+IEQ/F2SAMlnSzkRLURMBAtWQ6fc35crjlE5m0/e74pZblxdiqWb1ZN3RkP4kY40SbLz7aRDKw==
X-Received: by 2002:a17:902:e5d0:b0:1c9:e2ed:66fe with SMTP id u16-20020a170902e5d000b001c9e2ed66femr2549273plf.52.1697826650428;
        Fri, 20 Oct 2023 11:30:50 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jc15-20020a17090325cf00b001c746b986e5sm1839961plb.45.2023.10.20.11.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:30:49 -0700 (PDT)
Date: Fri, 20 Oct 2023 11:30:49 -0700
From: Kees Cook <keescook@chromium.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Justin Stitt <justinstitt@google.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <202310201127.DA7EDAFE4D@keescook>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de>
 <202310182248.9E197FFD5@keescook>
 <20231020044645.GC11984@lst.de>
 <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_113052_216198_5A84DDF3 
X-CRM114-Status: GOOD (  21.62  )
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

On Fri, Oct 20, 2023 at 10:40:12AM -0700, Justin Stitt wrote:
> On Thu, Oct 19, 2023 at 9:46 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Wed, Oct 18, 2023 at 11:01:54PM -0700, Kees Cook wrote:
> > > Almost all of the remaining strncpy() usage is just string to string
> > > copying, but the corner cases that are being spun out that aren't
> > > strscpy() or strscpy_pad() are covered by strtomem(), kmemdup_nul(),
> > > and memcpy(). Each of these are a clear improvement since they remove
> > > the ambiguity of the intended behavior. Using seq_buf ends up being way
> > > more overhead than is needed.
> >
> > I'm really not sure strscpy is much of an improvement.  In this particular
> > case in most other places we simply use a snprintf for nqns, which seems
> > useful here to if we don't want the full buf.
> >
> > But switching to a completely undocumented helper like strscpy seems not
> > useful at all.

I'm curious where you looked and didn't find documentation -- perhaps
there is an improvement to be made to aim one to where the existing
documentation lives?

> 
> There's some docs at [1]. Perhaps there could be more?
> 
> [1]: https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify-string.h#L292

Right, And it's even valid kern-doc, which gets rendered in the kernel
API docs, along with all the other string functions:
https://docs.kernel.org/core-api/kernel-api.html#c.strscpy

-- 
Kees Cook

