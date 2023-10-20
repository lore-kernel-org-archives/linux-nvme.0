Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EC3C001DF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 18:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=04gH1wK0MN9lWn/YJPzI2WddwHxIZ8s/y81mEW7mDkQ=; b=sgjhGe7KCEX3eslSZhYk/36t9m
	QJAkg018f1UKQDHBip6/HN0qZUClXuCxuvGV6as6qDnu2CDTu9LUHQ72Jcy83PhJxzzdp0sNgCI7C
	xGIeEsmI3KfFa9cRYiNwEd9REACzTh08f808szWslx1FyjklDGWRUB/Onal2MtHXnRa5Fl2g+Nk/t
	UkS/58ex95Fh1EUw/Koz7pLlph8CC7A2z39qhOw+1BIV/NfopF2xtzWy3ztw0N86qyC+N9wZ3hvV7
	3UvhYEbRkR+ewFlCxyu7s5tnyINEhhtm795GE8UAX4MkB1MDis7mM2NGaulfqLdyF7P8SX08d2ijd
	JMR+IJhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtu8q-002qZ8-2N;
	Fri, 20 Oct 2023 18:22:36 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtu8n-002qXk-0K
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 18:22:34 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c8a1541232so9448015ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 20 Oct 2023 11:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697826149; x=1698430949; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=04gH1wK0MN9lWn/YJPzI2WddwHxIZ8s/y81mEW7mDkQ=;
        b=TR/gkLSX6LYMWzAUrkjzdOotdh1TyVYJLQQfSw3G8A4PxT9jC/l+cn4tuxknPe0757
         iu6telcCDRL97VVnMrjl1y8K+9wker7hpfF4Zt5qb24jorpJYXrclb9iUEoUuRuFkLuf
         wCCjdhPLgDleVKrzpH/d36crvepsqgrpSITco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697826149; x=1698430949;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04gH1wK0MN9lWn/YJPzI2WddwHxIZ8s/y81mEW7mDkQ=;
        b=P1RWrTs9snKXhdmWk3LaXr0BUa+2ucROpCkzG52dwzSRoyceEuH2xKrcextc4hXvpo
         VlzYLidS9glkdqNqCoQDC2gceJita2FO+jTQvRGx7teh66heCiIB91UFGJDa91bvU1QG
         TknwgqUx2tYCGiO7ZTPVJfSi2MBVqbiij/4COF6XO1kLBBWHXoiEkvN03vIIJa3iGQ5x
         O96oFbSJ7eHc9Z20YKYAlpTEFV8rXW/rcTHnoHzfHtvyIqOiCc3idCC/CqKO9ebiSWzY
         WsE6LMmBCKpdlV8WxmaWLoqclnzwtBxp1u+EFYm6qUe449WOMlpoGxb+87TfaScfiby+
         VlCg==
X-Gm-Message-State: AOJu0YwaiCJZwixONXT5npO5HWV3SVahGFRJYvA2+NF6JldETZMs7MfU
	/H7qkyxUEemGWvJK5qc7iWcLKQ==
X-Google-Smtp-Source: AGHT+IHY7//XAjVbmv0+8CTvhanr4J11DW7dmowhqoeDWSPu7A2hJov+lZgIQALeiVmTuJFeYMRjFQ==
X-Received: by 2002:a17:902:ea0e:b0:1ca:20a0:7b08 with SMTP id s14-20020a170902ea0e00b001ca20a07b08mr2589174plg.50.1697826148954;
        Fri, 20 Oct 2023 11:22:28 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id je22-20020a170903265600b001c625acfed0sm1826088plb.44.2023.10.20.11.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 11:22:28 -0700 (PDT)
Date: Fri, 20 Oct 2023 11:22:27 -0700
From: Kees Cook <keescook@chromium.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Justin Stitt <justinstitt@google.com>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	ksummit@lists.linux.dev, Azeem Shaikh <azeemshaikh38@gmail.com>
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <202310201111.595F790@keescook>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de>
 <202310182248.9E197FFD5@keescook>
 <20231020044645.GC11984@lst.de>
 <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
 <CAHk-=wj4BZei4JTiX9qsAwk8PEKnPrvkG5FU0i_HNkcDpy7NGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj4BZei4JTiX9qsAwk8PEKnPrvkG5FU0i_HNkcDpy7NGQ@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_112233_162226_2629D077 
X-CRM114-Status: GOOD (  18.78  )
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

On Fri, Oct 20, 2023 at 10:56:31AM -0700, Linus Torvalds wrote:
> On Fri, 20 Oct 2023 at 10:40, Justin Stitt <justinstitt@google.com> wrote:
> >
> > There's some docs at [1]. Perhaps there could be more?
> >
> > [1]: https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify-string.h#L292
> 
> Note that we have so few 'strlcpy()' calls that we really should
> remove that horrid horrid interface. It's a buggy piece of sh*t.

Yup, that's on-going. There's just a few left; Azeem has been chipping
away at strlcpy.

> It does mean that if you used to have
> 
>     dst[4];
>     strlcpy(dst, "abc", 8);
> 
> then that *used* to work (because it would copy four bytes: "abc\0"
> and that fits in 'dst[]'). But
> 
>    dst[4];
>    strscpy(dst, "abc", 8);
> 
> will overflow dst[], because it will do a word-copy and you told
> 'strscpy()' that you had a 8-byte buffer, and it will try to write
> "abc\0\0\0\0\0" into the destination.

Luckily, we already have checks for these mismatched sizes at compile
time (i.e. CONFIG_FORTIFY_SOURCE will already check for pathological
cases like above where 8 > sizeof(dst)).

> The above is insane code, but it's an example of why a blind
> strlcpy->strscpy conversion might change semantics.

Totally agreed. All of the recent string conversions have been paying
close attention to the behavioral differences.

-- 
Kees Cook

