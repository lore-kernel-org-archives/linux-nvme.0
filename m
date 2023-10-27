Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E1AC25B70
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Oct 2023 18:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wL6rsP27kyhBgPNjGAE37z4bXgSpgcwn8+JkklueuV4=; b=dRzEeultgQ99s++sMLTd1nPVJi
	4LaIIKsG/iQT9+OGKVdASD7hQiq41KQA+0CMlFf4fm0Cvx6XyEwpXecK1HMYfNHr050FBMSoBkfVr
	fJgwKSHyaZ9GhwhdCTxUlbVntVjenywnA07T2N+lOn49mxEUJUvY5WgCpkouqWDpxi7p5WaE35m9+
	slDdvKOltVNCmTaCxneUH3QT3yCfd+A0RgTyg0v2qYIzgPdv3I8/Fdt8LbmV4aSuKRRYpiiG9TV7U
	oiGxGrKENattIq7TMK77pVZ7zGFy1RSbMr6Rar2ZrcIZnk+4MvVwzfliamd3OcDuc9D/jaUIlIShF
	ZqB7UCpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwRdK-00H1NR-1b;
	Fri, 27 Oct 2023 18:32:34 +0000
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwRdH-00H1KR-12
	for linux-nvme@lists.infradead.org;
	Fri, 27 Oct 2023 18:32:32 +0000
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a6190af24aso384838566b.0
        for <linux-nvme@lists.infradead.org>; Fri, 27 Oct 2023 11:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698431547; x=1699036347; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wL6rsP27kyhBgPNjGAE37z4bXgSpgcwn8+JkklueuV4=;
        b=b6zVuMHyfDQEH/VmBuDKyefyn4iYVU1IpRRlps6lvWkE+6HA2ytBS5xorCt+ENkzno
         LX3ZmRy/tqPTOleXgNVv7o2SKuEKYIGkwhcIW8C6Yj6DgrmjhjprB5GVDUbiB4jqL8Nd
         i8HCdz6ptuA7M6Gd93FvggfxMlHOUlc02mqF09CVnMuCTAnr55yXDtF6xGJTF0CepKLf
         Gs3k0Z23YaI6X3vzb6qUelh0szi9HmXaIdap7sJ1xYPa0ziUnIhaWl4egYNWIdf5V62C
         j8YzDeFZnmJ4tUFQianesxeeVTFHDPfGuNObA5a9cxGZXxmA78A408RMfO7dy2035bW4
         3oBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698431547; x=1699036347;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wL6rsP27kyhBgPNjGAE37z4bXgSpgcwn8+JkklueuV4=;
        b=k0GfW+iHkrgv5YvYqjK7nkODoUy0LURputUtnAHf1S24bm4XYcbIfCMfdnEr0l2T26
         sCgyp9yBg6jfYC2/nuosWuTtSNJFt7eYsNMWX67AsVbCclMGIf6N5BKTjeiW32kwrN2g
         dwj0o4O/i4v6ZtZHYnU2hNaf7SS3HbcOCv66bOejOpHSrpPWL/h4B3fpZ7cx+woOCNQd
         xjvmmqEVe4Vp05i3SM4bJWUdoO0Cp4ns8uXlgymzdKBL5imKfa8WcM9znGeGbw7cnkL/
         shCc4bAi2veF1wARLRthD7eITPjtGLUFylwtlETtPCAaPWKdqJiN5C1DyeVhcj4RZej9
         Q7nQ==
X-Gm-Message-State: AOJu0Yw51eJhvfTSQ+yCJX+SnaLyiTov8zv5ds5k0PKHYczYMyKEIICL
	b0e0S+LceUyrAhomo/1xVCkarwqkhzgo
X-Google-Smtp-Source: AGHT+IEseHwXORBr9sJ631o9racXkSS0mpkOkeFDiKUjuXjwWnaaKLPyzrP3KLBhmO4nUsL9dB9gVw==
X-Received: by 2002:a17:907:31c1:b0:9bd:a165:7822 with SMTP id xf1-20020a17090731c100b009bda1657822mr2862145ejb.47.1698431546635;
        Fri, 27 Oct 2023 11:32:26 -0700 (PDT)
Received: from p183 ([46.53.253.206])
        by smtp.gmail.com with ESMTPSA id gt11-20020a170906f20b00b009bd9ac83a9fsm1571360ejb.152.2023.10.27.11.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 11:32:26 -0700 (PDT)
Date: Fri, 27 Oct 2023 21:32:24 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Christoph Hellwig <hch@lst.de>, Kees Cook <keescook@chromium.org>,
	Justin Stitt <justinstitt@google.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	ksummit@lists.linux.dev
Subject: Re: the nul-terminated string helper desk chair rearrangement
Message-ID: <c9dd71ba-bb29-4e2d-b8cc-d49d493ffb32@p183>
References: <20231018-strncpy-drivers-nvme-host-fabrics-c-v1-1-b6677df40a35@google.com>
 <20231019054642.GF14346@lst.de>
 <202310182248.9E197FFD5@keescook>
 <20231020044645.GC11984@lst.de>
 <CAFhGd8o8FaD-3rkBAhEXhc8XqpUk_cLqNwyfpndVuSxDOei_gA@mail.gmail.com>
 <202310201127.DA7EDAFE4D@keescook>
 <20231026100148.GA26941@lst.de>
 <710149630eb010b18b69e161d02502bc3b648173.camel@HansenPartnership.com>
 <20231026095235.760f5546@gandalf.local.home>
 <CAMuHMdV9CcjGkpF=FGe_U5XtbF08bKTEYkPSxArO1zBwnug0Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdV9CcjGkpF=FGe_U5XtbF08bKTEYkPSxArO1zBwnug0Wg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231027_113231_361607_3ADB499F 
X-CRM114-Status: GOOD (  21.19  )
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

On Thu, Oct 26, 2023 at 03:59:28PM +0200, Geert Uytterhoeven wrote:
> Hi Steven,
> 
> On Thu, Oct 26, 2023 at 3:52 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> > On Thu, 26 Oct 2023 07:39:44 -0400
> > James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> >
> > > While it's nice in theory to have everything documented, it's not much
> > > use if no one can actually find the information ...
> >
> > Does kerneldoc provide an automated index? That is, if we had a single file
> > that had every function in the kernel that is documented, with the path to
> > the file that documents it, it would make finding documentation much
> > simpler.
> >
> > Maybe it already does? Which would mean we need a way to find the index too!
> 
> ctags?

ctags is a tool from previous century. It doesn't help that "make tags"
is single-threaded. It needs constant babysitting (loop-like macros,
ignore attibute annotations which masquerade as identifiers). I think
"make tags" became much slower because ignore-list is one giant regexp
which only grows bigger.

> Although "git grep" is faster (assumed you use the "correct" search
> pattern, which can sometimes be challenging, indeed).

I tried QT Creator indexing at some point (which is parallel), it needs
to be told that headers are C not C++. I didn't find a way to tell it
that .c files are C too but F2 jumped to definitions quite well.
Also hovering over identifier/name works (being IDE it understands
popular doc styles).

It can be made to work reasonably well provided that you did "make
allmodconfig" and added few header locations. clangd parses like compiler,
not like human and kernel uses a lot of CONFIG defines so some config
must be chosen.

But I need to recheck all this stuff now that new version was propagated
to distros. It should be better (and less segfaulty :-)

