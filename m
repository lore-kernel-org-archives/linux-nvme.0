Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369C3C47422
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Jan 2024 23:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tjAyR5yAuxqP2MXzhvI5gNl4zdn4tEXP6bBd21ORa3E=; b=AIHXEHEM0zKT+7lRSwTM/u7mDF
	4URVf/WHX5IpXcbfRk6dtc4qHa5GybkLZ3/aWePyGLICACGvjArrlll85coJxv62tdX1JbMpxhJc/
	eFV/nih6hhueH32LxPdOewkjuWMFoJhEGpI/uftdxY25m1sqpJChcb5TrveGlVZjiwt+GDkRwqSxk
	1HoLaIxY16HQGaTZy7xY1l+oHcyuhTCEbQt6N9XyUcUdXAR8nO6TnfEOJFmJIf9ff6LrVRi3fPXyk
	n0mjMgp1gIN1EkIuK3px/RpgrFXJgQeBLyyoIAMPPGQFdbqv3Bi9Czcenw2ENXIdzZ7CNxZyNbqr2
	8SNHviNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRhIp-00ABvD-20;
	Sun, 21 Jan 2024 23:32:35 +0000
Received: from mail-qt1-x836.google.com ([2607:f8b0:4864:20::836])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRhIj-00ABtz-0o
	for linux-nvme@lists.infradead.org;
	Sun, 21 Jan 2024 23:32:34 +0000
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-429af318342so24287581cf.0
        for <linux-nvme@lists.infradead.org>; Sun, 21 Jan 2024 15:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1705879944; x=1706484744; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjAyR5yAuxqP2MXzhvI5gNl4zdn4tEXP6bBd21ORa3E=;
        b=UqGd23kbTJLq4LhOLjJgVMRIowXxPAHhuCUXq/KSE0kpFFeQ41f0tqYNhT6kXSmfT7
         vtwKmWWY1XWLLe5lAm3ROn9o69OwphcncnEANpCEGf5fvPJJ1JWcGm6lqx2lBXZfQI7I
         0//dYLaLEp5RLHM88u7h1NrHdZZRkDfPOQrHN+3IY5ol9fLVd9GUj8C/lZZlRT9ibBtD
         f3p5yUW/ClZimwmoTd25tjXToc06TjE1fRbQPanlvU/2dA1ddBZpWl2BxStKUcleT2JS
         WJjBbbtRoHYhQBF/dGt+5h9fReC0N0ZF8iRw4wuqyvQqyzmWQn/9gJDP1ppGflETUPZq
         JRFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705879944; x=1706484744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tjAyR5yAuxqP2MXzhvI5gNl4zdn4tEXP6bBd21ORa3E=;
        b=vMOQs+RlLawI2gLAegmrUgfk/NctWBPBUjjxxv35uT5ogdKlyXnvzi7LixlVm5Din+
         PmwR5bRUhSSa+jRIwrnV+MsxEWjRpnBFnWOOjHTfjStJJ9UtA9luyONVyXvhrJWg+7j5
         MS170Ie82nx8F0LjfMEoYV2gO3p/rLCVPV9QTBl9mw8KIPmG4RHG2PwxUEUQzlLO7sAQ
         nex51kGQ538nxP9CdGj704g6RqgTAXfwuk5CnJJNN/q9fGLTW6TH0FLryOPKbjDHuod9
         CG9jRFNLFNJSHab3Tl3wML35DwWyIcFPKXw5w+gGBIWXuUEHWam0TQr0NUq+SebZgNWA
         eCrw==
X-Gm-Message-State: AOJu0Yxja7U11xsKSR+FNLa2hQ6WygGJbjvwXppmzb99mq8dgKZsgWhE
	MFHM3Ekfh6brDn+/ANH3jbzXT+VH2xjDLImYWo6e8oM23rrx6Hycp3jOYcU2A8xn6Eg2yqe/A83
	qGZpmVHtsFgd8snStx6EeXyKyiesBTXcRY7pWhg==
X-Google-Smtp-Source: AGHT+IHivVz4AXDlztP5Ti2xRZhD4G1//TCleyRPSv0+jm2GNZ2s0PiypPLZvpl/q0OkhQIdBOHj30bfFDYrRraUsOY=
X-Received: by 2002:a05:622a:b:b0:42a:3274:c523 with SMTP id
 x11-20020a05622a000b00b0042a3274c523mr4459943qtw.137.1705879944558; Sun, 21
 Jan 2024 15:32:24 -0800 (PST)
MIME-Version: 1.0
References: <ZaqiPSj1wMrTMdHa@casper.infradead.org> <b04b65df-b25f-4457-8952-018dd4479651@google.com>
 <Za2lS-jG1s-HCqbx@casper.infradead.org>
In-Reply-To: <Za2lS-jG1s-HCqbx@casper.infradead.org>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sun, 21 Jan 2024 18:31:48 -0500
Message-ID: <CA+CK2bCAPWhCd37X8syz9fHYSv_pQ0-k+khgXZc1uCPRBnFaWQ@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20240121_153230_411521_843FFDB5 
X-CRM114-Status: GOOD (  43.53  )
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

Hi Matthew,

Thank you for proposing this topic. I would also like to be part of
this discussion at LSF/MM specifically because of the memory
efficiency opportunities coming of memdescs.

On Sun, Jan 21, 2024 at 6:14=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sun, Jan 21, 2024 at 01:00:40PM -0800, David Rientjes wrote:
> > On Fri, 19 Jan 2024, Matthew Wilcox wrote:
> > > It's probably worth doing another roundup of where we are on our jour=
ney
> > > to separating folios, slabs, pages, etc.  Something suitable for peop=
le
> > > who aren't MM experts, and don't care about the details of how page
> > > allocation works.  I can talk for hours about whatever people want to
> > > hear about but some ideas from me:
> > >
> > >  - Overview of how the conversion is going
> > >  - Convenience functions for filesystem writers
> > >  - What's next?
> > >  - What's the difference between &folio->page and page_folio(folio, 0=
)?
> > >  - What are we going to do about bio_vecs?
> > >  - How does all of this work with kmap()?
> > >
> > > I'm sure people would like to suggest other questions they have that
> > > aren't adequately answered already and might be of interest to a wide=
r
> > > audience.
> > >
> >
> > Thanks for proposing this again, Matthew, I'd definitely like to be
> > involved in the discussion as I think a couple of my colleagues, cc'd,
> > would has well.  Memory efficiency is a top priority for 2024 and, thus=
,
> > getting on a pathway toward reducing the overhead of struct page is ver=
y
> > important for our hosts that are not using large amounts of 1GB hugetlb=
.
> >
> > I've seen your other thread regarding how the page allocator can be
> > enlightened for memdesc, so I'm hoping that can either be covered in th=
is
> > topic or a separate topic.
>
> I'd like to keep this topic relevant to as many people as possible.
> I can add a proposal for a topic on both the PCP and Buddy allocators
> (I have a series of Thoughts on how the PCP allocator works in a memdesc
> world that I haven't written down & sent out yet).

Interesting, given that pcp are mostly allocated by kmalloc and use
vmalloc for large allocations, how memdesc can be different for them
compared to regular kmalloc allocations given that they are sub-page?

> Or we can cover the page allocators in your biweekly meetings.  Maybe bot=
h
> since not everybody can attend either the phone call or the conference.
>
> > Especially important for us would be the division of work so that we ca=
n
> > parallelize development as much as possible for things like memdesc.  I=
f
> > there are any areas that just haven't been investigated yet but we *kno=
w*
> > we'll need to address to get to the new world of memdesc, I think we'd
> > love to discuss that.
>
> Thee's so much work to be done!  And it's mostly parallelisable and almos=
t
> trivial.  It's just largely on the filesystem-page cache interaction, so
> it's not terribly interesting.  See, for example, the ext2, ext4, gfs2,
> nilfs2, ufs and ubifs patchsets I've done over the past few releases.
> I have about half of an ntfs3 patchset ready to send.

> There's a bunch of work to be done in DRM to switch from pages to folios
> due to their use of shmem.  You can also grep for 'page->mapping' (becaus=
e
> fortunately we aren't too imaginative when it comes to naming variables)
> and find 270 places that need to be changed.  Some are comments, but
> those still need to be updated!
>
> Anything using lock_page(), get_page(), set_page_dirty(), using
> &folio->page, any of the functions in mm/folio-compat.c needs auditing.
> We can make the first three of those work, but they're good indicators
> that the code needs to be looked at.
>
> There is some interesting work to be done, and one of the things I'm
> thinking hard about right now is how we're doing folio conversions
> that make sense with today's code, and stop making sense when we get
> to memdescs.  That doesn't apply to anything interacting with the page
> cache (because those are folios now and in the future), but it does apply
> to one spot in ext4 where it allocates memory from slab and attaches a
> buffer_head to it ...

There are many more drivers that would need the conversion. For
example, IOMMU page tables can occupy gigabytes of space, have
different implementations for AMD, X86, and several ARMs. Conversion
to memdesc and unifying the IO page table management implementation
for these platforms would be beneficial.

