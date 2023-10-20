Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 762EEC001DF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 17:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F4wi3imaHP2uII6OBg2l5IRaJiEg3OU2WqP11N/v4Ns=; b=Rg5OF1RAfjx86HnXZW+hcNEER8
	NcDgmi2fhlbMseqNyZr+jzv5UjmlywP0oplavaZgOybZy8mNEGc+XSXkLwHO5KhPFdQhhoXF8y1O0
	2H9uyxsoIN8ke4HPNXgc3RuxYmk9pI+Rxcfb2WhylR2MhivE8I+LynrFyFQqO5vmiol50pT8IUv8y
	NUHGrbnaMckt3/5SHetKFB8JdHxzTiqG8bAvKvpWxM4+dKcij9i4bGxXvMsvKh4Vi7i0foHPdWLq5
	y7njkE71chGryAvDgNrNFZ9+Xe4VLIo2ekdk+Ysw68GvdgZI6MzUvAOn/o2jL+Xww7UFw1YqWIlgT
	VUCxCFQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qttk1-002o6h-02;
	Fri, 20 Oct 2023 17:56:57 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qttjx-002o5i-2h
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 17:56:55 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so4624911a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 20 Oct 2023 10:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697824610; x=1698429410; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F4wi3imaHP2uII6OBg2l5IRaJiEg3OU2WqP11N/v4Ns=;
        b=PhOvy3Ze9X7wq3omg9F0xyFHQJ/s6OSBi7blFIrWL0ZKF/Wtkci2lhsMjcFvu28+NB
         wL94MnmFshcQZv5YOKO5Vm/yJLxY0nXv1sCmfYBo0YkyrKAlYt8ERhpW2tmLaoP/jNon
         0NB/X+m0PiBRG8q2EQx2/G3ZgPtargxHW/U4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697824610; x=1698429410;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4wi3imaHP2uII6OBg2l5IRaJiEg3OU2WqP11N/v4Ns=;
        b=Bk2VZsmoRGiyDrf1/Y+R3X3PsPObMmPsKcFWwii7yAWtHVnuL5JSGgzjPvmSAeM+F7
         3pzi/sFD34SqBUJGo43RQnMbe7fXYLfCTvp+yY0U5iQUjVPTlJ0ck/0Fz7jh+PtH2zRc
         25CwCYyWOO3GXd1DB8nJpIGciIl3PtkCFazZYWgGpHpDyJZ5RIq/KrRwhtLvmSfKxv2b
         bWdIPpe7hgyzaQ4OX5RxJJi3zF60rFT07dEpXoo2lM3oXPOUd4XXSOSCtpWc/ehbkXF+
         Vv9ZjDyqrWZfPaKerYLS/SzQ1uqNs7pnKZLSBN5SVXMe9dOiUGYjRSY6jRSuAfZxbKRS
         aGSQ==
X-Gm-Message-State: AOJu0YwaOzu+ok0XPWwGd5ZcKRgtknHzvqJsUhFIcEZzo6O8EMx1uell
	ZvZIsn7lnaoSzdmhTq9dE8DDkK/20s+UOh8bct56xN49
X-Google-Smtp-Source: AGHT+IHH1igcuuJutLmaHSq/StQUj9owkJrWQYYN5qwSvOBSlCMmTvx1SNxOchaXFGOYn5SLYL9ySg==
X-Received: by 2002:a05:6402:294:b0:52b:db44:79e3 with SMTP id l20-20020a056402029400b0052bdb4479e3mr5744784edv.4.1697824609928;
        Fri, 20 Oct 2023 10:56:49 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id f30-20020a50a6de000000b0053dec545c8fsm1901117edc.3.2023.10.20.10.56.49
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 10:56:49 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-9becde9ea7bso474089266b.0
        for <linux-nvme@lists.infradead.org>; Fri, 20 Oct 2023 10:56:49 -0700 (PDT)
X-Received: by 2002:a17:907:94d0:b0:9ae:65d6:a51f with SMTP id
 dn16-20020a17090794d000b009ae65d6a51fmr5921646ejc.18.1697824608915; Fri, 20
 Oct 2023 10:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de> <202310182248.9E197FFD5@keescook>
 <20231020044645.GC11984@lst.de> <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
In-Reply-To: <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 20 Oct 2023 10:56:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4BZei4JTiX9qsAwk8PEKnPrvkG5FU0i_HNkcDpy7NGQ@mail.gmail.com>
Message-ID: <CAHk-=wj4BZei4JTiX9qsAwk8PEKnPrvkG5FU0i_HNkcDpy7NGQ@mail.gmail.com>
Subject: Re: the nul-terminated string helper desk chair rearrangement
To: Justin Stitt <justinstitt@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_105653_987513_5B3E38FF 
X-CRM114-Status: GOOD (  15.65  )
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

On Fri, 20 Oct 2023 at 10:40, Justin Stitt <justinstitt@google.com> wrote:
>
> There's some docs at [1]. Perhaps there could be more?
>
> [1]: https://elixir.bootlin.com/linux/v6.6-rc6/source/include/linux/fortify-string.h#L292

Note that we have so few 'strlcpy()' calls that we really should
remove that horrid horrid interface. It's a buggy piece of sh*t.

'strlcpy()' is fundamentally unsafe BY DESIGN if you don't trust the
source string - which is one of the alleged reasons to use it.

That said, while 'strscpy()' fixes the fundamental conceptual bugs of
strlcpy(), it's worth noting that it has *two* differences wrt
strlcpy:

 - it doesn't have the broken return value

 - it copies things in word-size chunks to be more efficient

And because of that word-size thing it will possibly insert more than
one NUL character at the end of the result.

To give an example, if you have

   dst[64] = "abcdefghijklmnopqrstuvwxyz";
   src[64] = "123\0........";
   strlcpy(dst, src, 64);

then the strlcpy() will return 3 (the size of the copy), but the
destination will end up looking like

   dst[64] = "123\0\0\0\0\0ijklmnopqrstuvwxyz...";

This odd "possibly word padding" is basically never relevant (and it's
obviously always also limited by the size you gave it), but *if* you
are doing something really odd, and you expect the end of the
destination string to not be modified at all past the final NUL of the
copy, you need to be aware of this.

It does mean that if you used to have

    dst[4];
    strlcpy(dst, "abc", 8);

then that *used* to work (because it would copy four bytes: "abc\0"
and that fits in 'dst[]'). But

   dst[4];
   strscpy(dst, "abc", 8);

will overflow dst[], because it will do a word-copy and you told
'strscpy()' that you had a 8-byte buffer, and it will try to write
"abc\0\0\0\0\0" into the destination.

The above is insane code, but it's an example of why a blind
strlcpy->strscpy conversion might change semantics.

            Linus

