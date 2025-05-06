Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E71C3ABBC
	for <linux-nvme@archiver.kernel.org>; Tue,  6 May 2025 07:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dDn4W5v9t6AyHBHxLWO7FuLjj98KbpZnLxWf1Zria3s=; b=Syb44pqylg79wwcgFe2r+vw8EX
	CbPdmxNQPKfVDR49kPEAuSoYzlhGlK4H1RIbQ/r1s9Kfl5ueSYsu8MrbeaEovwaLspokajXGo9KaX
	WzlTdFi1RrvFj8v7mD8KmxA/vRjL1lBgLZAs0ylw/hiVarWk04xVMbMubyKP5yqfOw871Lt71x9BV
	SzxfS1paqXgHF4qttMQAzHs7oRXJyBYXlqsPQHb2fvsQ0sx9nvA7+ASAzMDgbPHjARdRQczGfP+mA
	BYsJsryhRn7+mt3LBbAFxOIdm80UriiCAh24gUAWmwGUar9NfL15A4KLG0HfmFuDeZYp70ZsCfD9a
	DquP7t7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCCbW-0000000AteV-1GYX;
	Tue, 06 May 2025 07:20:38 +0000
Received: from smtpbg154.qq.com ([15.184.224.54])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uC8FN-00000009oCT-3xJn
	for linux-nvme@lists.infradead.org;
	Tue, 06 May 2025 02:41:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1746499277;
	bh=dDn4W5v9t6AyHBHxLWO7FuLjj98KbpZnLxWf1Zria3s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=CTw4vjs7anTuMuf5viPJRKtpPfsxTVgOWbz6UtkaqDAj3LTw810/Ly2uxVTpg+Vgf
	 nt6dm0pBEpwvh7dE/Et9YQ/HUxLhIC+XqeT+r+VHpswJZbjRR5ymx2uFgonH2zZfYl
	 8PSF/N3sxTVKVDlGyZA3LERvIY242rVrcFEXBMQk=
X-QQ-mid: zesmtpgz5t1746499273t907c8528
X-QQ-Originating-IP: 34DQWfTnSl+h6rzlZpvgAYkMGl2f6LX6HEo8lm3xiDs=
Received: from mail-yb1-f181.google.com ( [209.85.219.181])
	by bizesmtp.qq.com (ESMTP) with SMTP id 0
	for <linux-nvme@lists.infradead.org>; Tue, 06 May 2025 10:41:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11331692237666958464
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e75607fe4ceso3133294276.3
        for <linux-nvme@lists.infradead.org>; Mon, 05 May 2025 19:41:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVlM0fAmyiOYrPjtXiO+P+ej2UzwrNvHlso7wYkzJhc5FLumwNlO7uUtVarN7G0gtfXVt+62SB1ouyG@lists.infradead.org
X-Gm-Message-State: AOJu0YwzqyRiLzvYt/xdV/Exg2dKqLur1tZc2319mU7hM7C5d5j7GLB8
	mg5xT1usvTLuduKsKQPsAT6e8D1mBLNleSRTFZ6V/qLONJtU/+4ifFMSxCx51GHSHkBeRmymU65
	AAG0+9UCxripp3xJHb0uwll0ukxI=
X-Google-Smtp-Source: AGHT+IFgFFlMacdloLtgDC8BYlif3b1M5uLk0pWcJg25Fujp9vccWuhfsfXobAggGBnTnNta+8cIxYeCcW4lzf1hqZQ=
X-Received: by 2002:a05:6902:1ac5:b0:e6d:f3ca:3e15 with SMTP id
 3f1490d57ef6-e75c08b698bmr1960395276.3.1746499270786; Mon, 05 May 2025
 19:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250429-noautoinline-v3-0-4c49f28ea5b5@uniontech.com>
 <20250429123504.GA13093@lst.de> <D9KW1QQR88EY.2TOSTVYZZH5KN@google.com>
 <20250501150229.GU4439@noisy.programming.kicks-ass.net> <D9KXE2YX8R2M.3L7Q6NVIXKPE9@google.com>
 <08163d8b-4056-4b84-82a1-3dd553ee6468@acm.org>
In-Reply-To: <08163d8b-4056-4b84-82a1-3dd553ee6468@acm.org>
From: Chen Linxuan <chenlinxuan@uniontech.com>
Date: Tue, 6 May 2025 10:40:59 +0800
X-Gmail-Original-Message-ID: <973B455678FC1BDD+CAC1kPDM2pUEwFRiUZFHKq_7sYpjARkFczJnp_FRu+r9-xYdgKg@mail.gmail.com>
X-Gm-Features: ATxdqUHhA0M6lhr1xavQzClQ8qzartLkG1qHh9aYbVlX-6LFgZ39KxjHPoTQnkI
Message-ID: <CAC1kPDM2pUEwFRiUZFHKq_7sYpjARkFczJnp_FRu+r9-xYdgKg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 0/8] kernel-hacking: introduce CONFIG_NO_AUTO_INLINE
To: Bart Van Assche <bvanassche@acm.org>
Cc: Brendan Jackman <jackmanb@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Christoph Hellwig <hch@lst.de>, chenlinxuan@uniontech.com, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, 
	Andrew Morton <akpm@linux-foundation.org>, Yishai Hadas <yishaih@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Juergen Gross <jgross@suse.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-integrity@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, llvm@lists.linux.dev, 
	Winston Wen <wentao@uniontech.com>, kasan-dev@googlegroups.com, 
	xen-devel@lists.xenproject.org, Changbin Du <changbin.du@intel.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: N2KYX7bfCwh6GVyYJtKoSICGhucVYsKKvJMffu2lji/wVkdQsTpAUvcu
	pw8fF5TFqZvdq1VNT1U04W37T7lInSgEOR3I3YF7q0iG1OGV9mn8joGpRTQ/Z0kC9o3G3jR
	cJEBM0EJrVT5+PlnZNo0UsqQaTZAloMnpSOCoTPgpmj8EXAXVbs6qI1s5r/BjryUyj70alP
	Y5z13rFvEN1oeIUJcMiVLBSpH7JwtB4AxCnkkSRS25J0vZCjJ3u08HO98y93LP1J3pZrURA
	IngVTnAog5ih62WaI7hIuFTtd6VDlv4ZoPZcSbyXgeoGXCrNGCLI5vUWy/TRd5N584KcOZX
	7VqMt0qhQO6vk0WSCZft70oxLSGCAYpu00AU7l+B8iWNd/s8HLTZaJ3cuAImJbzDwPVeMjG
	TBUgvBfvvWRWHeypCsHNLS90RuwTw5MzePRwXf+Rv4YE/UAfAJHhap+MxkmASzC6rsyxsYk
	a04TrNFxMOr6IFEsvJ3wCqI1fkE/N2sXQtTTV90V8t/jUCn7zMD/MmgLtjrCTziaExua0La
	PsnvIkdcbGNqWi65ge3ymm2ZLwAD/M/sDuq3jVLFkoZm/K3zL7v5cG7Zl5gT/B7lBZbz2JI
	ndAFNLJpS5hgRmOM9sNdATxrzu/aai5YFaItx5RVhrv3iz5UQe4cUfPG6ixKJ9feZ2mnxir
	gngNe3q7P6p/P9P7aMxq9PicvAgBhFQSYeaCGcePTVpslc1ksrmMD3x/upd3Qe8ZLWzI5FD
	i5hfNsIQsbPDxKTYW2zw/bRnMMkSH1sbeEpK4ezPGMhss7snyhxujHFYFcjTSXUfW/nHAqN
	4XrhfiEBl5HcVvovXwEsJJJ5Jxp/tKdQLJ0jDHliy23cJC2L5486umQkOHld1fwudkXihCQ
	a5ea+9loxPEkxPrKt8yGt6zAXfxoFxb9CcDPwL6KitWIqvz9qrg9Pzvdd4SVAjgFvOzk3oD
	lGxpNnFIiB7EoAh5LrB+SpuuPj158DucssHm/6xAFbuMEdzynVp68qCkhd+vqAli7tNLUgX
	3PZGXOgnEDxzCK+T9/VRUChoh3w2sAC0bQL5EMnxMj2qSlPCYIn92hcFKIA+zd0JT569+ML
	Q==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250505_194130_592929_AF5C9117 
X-CRM114-Status: GOOD (  10.46  )
X-Mailman-Approved-At: Tue, 06 May 2025 00:20:37 -0700
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

On Sun, May 4, 2025 at 3:14=E2=80=AFAM Bart Van Assche <bvanassche@acm.org>=
 wrote:

> If this is for test builds only, has it been consider to add
> -fno-inline-functions as a local change in the top-level Makefile?

The issue here is that the current kernel cannot be compiled when
these compiler options that reduce inlining behavior are added.

