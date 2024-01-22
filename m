Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B648C47422
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 00:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6loqEtr8W4/MnoN9hv9zyuRQ/zMGZggVt2HpZC6HiwE=; b=GauWa3waS0xYopg9PpEZJNsSue
	/wEcWdeERedavXpZRibfk1nl/EmpkuoXkKhtHE3pg6dFKSYB+fwZehndmtKOh24XMFgxS4U5Ij84z
	gTT7gEG5o7p+WzEG6qNEvZe/p4ii9YJ1hx98o2Fsp23T2ZOGKs9Bp/VV206g0z5xRlPMpZToL0BSB
	LuQI79lJZa1bPnhN23zGMzMAoMen3HC7eGCtAFS9bqkoKe7n8sJGBkCJISqcm/ghLW0mvoxNOF07M
	B6J7fNLyb1+fgoZRjMxU69hmVR6Fg6SNLDLyjhhRhkItHrzunCZi6+9f35iLOoMLU04pcUze3AfnU
	KBVEICNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRi1d-00AFIh-0F;
	Mon, 22 Jan 2024 00:18:53 +0000
Received: from mail-qk1-x72f.google.com ([2607:f8b0:4864:20::72f])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRi1X-00AFI2-1y
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 00:18:51 +0000
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-78376790dfbso282709985a.1
        for <linux-nvme@lists.infradead.org>; Sun, 21 Jan 2024 16:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1705882725; x=1706487525; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6loqEtr8W4/MnoN9hv9zyuRQ/zMGZggVt2HpZC6HiwE=;
        b=ChBdprIcdd2YPwBjvvTYOWQVaZflyCdxL4wDGAj8zfcQaNaFbE8ufR/YT8OCQAy+Ez
         nobiIH0qPGyBY9Kr22kPoSdquwf6tuuJS+v7W1yzG7k1EURc9qY1cE6LWYLcDVV4itGn
         I5olryk5+4BPv2F46il5cnEFvxDA7xMlqNEoftdGg+Tp46QPdtoil9RTxnDWHZz9I7Qs
         kizVfjLXDGwk4yQoqqNPq5cGqryJPRKgbdgippEmNvN2TTV7IgQewKD867V/RyydOtEq
         U/H+wkEe9O7guyS6A3OmsQmeAnkgYjJVS9BT3f/Qdyqxv+nGI1AmCTGJWCTrs6LClVYe
         TulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705882725; x=1706487525;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6loqEtr8W4/MnoN9hv9zyuRQ/zMGZggVt2HpZC6HiwE=;
        b=XOfnc5to5YAlVlU0Q8VQCWv8zqLYGg0iVWzIjtG/Ad9ALwW7yTL2EFClTeEygbTAcW
         bViIqbfyVbhHB1QR8bzTtSmUjOd6IpQvLa6taR1R55Jolv89+i4iNDU7OQ13RcLbv6Dx
         j5Obm4NF4s6RxXy4W+aXBld6JYUWajCPhrvd+x+Mg1kF6D7/ElPKn4Ysnx6MGjyYFpaW
         CNYXpe7YNoM+aBlSBO7bFqQqEC0gKnfiShZArVKufutiUO27+nSvTxOuCar+CnPhg1Vh
         xTMKKeeumd3sreTJulmdo6qju/og9YIleROaejKvJW9Tp5SatBvjvI8b0Ylen12A4XE2
         4HEg==
X-Gm-Message-State: AOJu0YzExllO0A1KkIotD9+ESSEYB4eSXujbXTbgHIbsVM9fAOvtDwpa
	if89M+ezvvniWmuiZHj6CUmgS+87cGA4sxohbxKbU3LO3y2J2QB9MFhakgGA9T4i72gpwrznARK
	t52vJEqJTtmwVCF15MCd76DgR9TByayMm+D6tkw==
X-Google-Smtp-Source: AGHT+IG+gZyrTFmxZcL/YVdEWM1zZYi9bYnrK6V7OnM6bduS/ZZQ1bpPfQMbiOpqPxopthUR3Y+1vPXte763Qg5XT3M=
X-Received: by 2002:a05:620a:1035:b0:783:6e7a:c815 with SMTP id
 a21-20020a05620a103500b007836e7ac815mr6065985qkk.32.1705882725284; Sun, 21
 Jan 2024 16:18:45 -0800 (PST)
MIME-Version: 1.0
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org> <b04b65df-b25f-4457-8952-018dd4479651@google.com>
 <Za2lS-jG1s-HCqbx@casper.infradead.org> <CA+CK2bCAPWhCd37X8syz9fHYSv_pQ0-k+khgXZc1uCPRBnFaWQ@mail.gmail.com>
 <Za2uq2L7_IU8RQWU@casper.infradead.org>
In-Reply-To: <Za2uq2L7_IU8RQWU@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 21 Jan 2024 19:18:09 -0500
Message-ID: <CA+CK2bC8-f2hWqnK4feRYBtuwqjdRoN8=sdaipJOiHFSNos=mg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] State Of The Page
To: Matthew Wilcox <willy@infradead.org>
Cc: David Rientjes <rientjes@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Sourav Panda <souravpanda@google.com>, lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240121_161847_676740_963F2383 
X-CRM114-Status: GOOD (  35.00  )
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

On Sun, Jan 21, 2024 at 6:54=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Jan 21, 2024 at 06:31:48PM -0500, Pasha Tatashin wrote:
> > On Sun, Jan 21, 2024 at 6:14=E2=80=AFPM Matthew Wilcox <willy@infradead=
.org> wrote:
> > > I can add a proposal for a topic on both the PCP and Buddy allocators
> > > (I have a series of Thoughts on how the PCP allocator works in a memd=
esc
> > > world that I haven't written down & sent out yet).
> >
> > Interesting, given that pcp are mostly allocated by kmalloc and use
> > vmalloc for large allocations, how memdesc can be different for them
> > compared to regular kmalloc allocations given that they are sub-page?
>
> Oh!  I don't mean the mm/percpu.c allocator.  I mean the pcp allocator
> in mm/page_alloc.c.

Nevermind, this makes perfect sense now :-)

> I don't have any Thoughts on mm/percpu.c at this time.  I'm vaguely
> aware that it exists ;-)
>
> > > Thee's so much work to be done!  And it's mostly parallelisable and a=
lmost
> > > trivial.  It's just largely on the filesystem-page cache interaction,=
 so
> > > it's not terribly interesting.  See, for example, the ext2, ext4, gfs=
2,
> > > nilfs2, ufs and ubifs patchsets I've done over the past few releases.
> > > I have about half of an ntfs3 patchset ready to send.
> >
> > > There's a bunch of work to be done in DRM to switch from pages to fol=
ios
> > > due to their use of shmem.  You can also grep for 'page->mapping' (be=
cause
> > > fortunately we aren't too imaginative when it comes to naming variabl=
es)
> > > and find 270 places that need to be changed.  Some are comments, but
> > > those still need to be updated!
> > >
> > > Anything using lock_page(), get_page(), set_page_dirty(), using
> > > &folio->page, any of the functions in mm/folio-compat.c needs auditin=
g.
> > > We can make the first three of those work, but they're good indicator=
s
> > > that the code needs to be looked at.
> > >
> > > There is some interesting work to be done, and one of the things I'm
> > > thinking hard about right now is how we're doing folio conversions
> > > that make sense with today's code, and stop making sense when we get
> > > to memdescs.  That doesn't apply to anything interacting with the pag=
e
> > > cache (because those are folios now and in the future), but it does a=
pply
> > > to one spot in ext4 where it allocates memory from slab and attaches =
a
> > > buffer_head to it ...
> >
> > There are many more drivers that would need the conversion. For
> > example, IOMMU page tables can occupy gigabytes of space, have
> > different implementations for AMD, X86, and several ARMs. Conversion
> > to memdesc and unifying the IO page table management implementation
> > for these platforms would be beneficial.
>
> Understood; there's a lot of code that can benefit from larger
> allocations.  I was listing the impediments to shrinking struct page
> rather than the places which would most benefit from switching to larger
> allocations.  They're complementary to a large extent; you can switch
> to compound allocations today and get the benefit later.  And unifying
> implementations is always a worthy project.

