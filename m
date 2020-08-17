Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BC8C433E3
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 19:12:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC652072D
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 19:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="x/8bmvJW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvMzuAxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC652072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EfV4UKhvBSiT27OpkYvDRRfHqlJHeyuOrg5bEB6HKYY=; b=x/8bmvJWYtc2Hs38e80y7/yzI
	HtKAAQKQJt3bewGlYd+Or8mbhxfBwsHvRZpdD3zPgckPV0ChVsijmn//9hRbXdumlPLYWFk4idX/a
	4ONMe5B3+zoYqVOP76mfamIGR/Ysb5YDoZ9qtxLZWK9wRUrUkAbGVapVoouDo9s2a/fzu4T4DP91u
	dDWofsZ4nVArDOixZQ8KxLk845VfdfvEeK+LNV6yxAe5DebE083VhxKAyxB5AKQG2HHVABnIYn3RO
	AQ1Yk4oGPZghFu8l2W+rLcqrFaUw8HQc7fFp0EpmVksdm/hH5eYV7/jSyXk2fhUPq+ckkD2EvQcOw
	Dn0WtzPHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7kYX-0005eI-CU; Mon, 17 Aug 2020 19:12:29 +0000
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7kYT-0005dp-6K
 for linux-nvme@lists.infradead.org; Mon, 17 Aug 2020 19:12:26 +0000
Received: by mail-il1-x144.google.com with SMTP id j9so15470765ilc.11
 for <linux-nvme@lists.infradead.org>; Mon, 17 Aug 2020 12:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NnKCBhQp2Gdr4n0TX2Bi3YpuER7JXpHBIDQP8R6n9AI=;
 b=GvMzuAxS6elmKSXxwtmwDg4ZABKQ94RBoIywyhmFuxzOvYj70kocfV6jjnvsD6xJUG
 TDoxSm0valHIzQ+TX5vr9M31BeFGUFSufYX4P6oEOMp0EM+3WgULq2SPTUHCgsOIRxuI
 fDyMPGMz+v+4byLbGWFj/UVM5255nK7fua7CeNib7oKaPFCl1EXmMDRODEX3VnP75fLd
 grnlAHLzvu/8yvLB6wGOmLG/dhoY8pJbKuZoJFz1OrzTsTTMBng+mF7Yb3wcndmk68im
 uw4FgY0JdtfocFKOeNcsRmidTCINPH/bEXdOXIZv0ihpFzBXEJoD1Qtei9Vvrm3Cod6j
 Eglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NnKCBhQp2Gdr4n0TX2Bi3YpuER7JXpHBIDQP8R6n9AI=;
 b=txiVBU/LkmOB+96m0uhwQX4Ie7/6sL8wz+hQd9D/vgmMpH0ECPKcVpolutihKJK+6h
 bDIj7mGu95+hEvt/uC9HpxIAQ+4P+IC4v6LjPiv4cBUUe3lt2PimWfv1xUfH8QsAvTsk
 0s9HRZfYgiepaRyrEuS/0G7m71UHKrHY8xsGQR4f4dUo4Peh04MJ8AtqlLtASnXKfcjV
 ABWKKgwWzpskut3JgMgDrzsdtshyWTA386VopeaLlWHM5hH+CL7owXXKZdj+gN/zgCTU
 1qUQBZ2RldqwsX5TXBBZ8t/hMQ+5anzxV5FzS2yszfMup57qVQp6pM++lpfqwOq7KIXh
 P2tQ==
X-Gm-Message-State: AOAM531Iko/8/T/8LcDA/3WUSnM6G4QJ6uplOt1AxkX//kxXsfTYw242
 y0L9/I0XNqovbOGlp4RW5L6peMRiKBMMPAyNCKo=
X-Google-Smtp-Source: ABdhPJzXgU+DNHNKO8z9tSqkcxA+YPlJ5aCtnpEUqz2sSEapV34xuQepCaVuriNJ1z06vI0ZEuk2ZLoKyfGEp42KQIo=
X-Received: by 2002:a05:6e02:5c7:: with SMTP id
 l7mr15394166ils.268.1597691543350; 
 Mon, 17 Aug 2020 12:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200816071518.6964-1-colyli@suse.de>
 <CAM_iQpUFtZdrhfUbuYYODNeSVqPOqx8mio6Znp6v3Q5iDZeyqg@mail.gmail.com>
 <20200817054538.GA11705@lst.de>
In-Reply-To: <20200817054538.GA11705@lst.de>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 17 Aug 2020 12:12:12 -0700
Message-ID: <CAM_iQpWnzm=cQZvZMcjKXez1L55tSVfWyadP3d0CUaT=D4nOhw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] net: introduce helper sendpage_ok() in
 include/linux/net.h
To: Christoph Hellwig <hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200817_151225_282551_696660BA 
X-CRM114-Status: GOOD (  26.79  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Linux Kernel Network Developers <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, stable <stable@vger.kernel.org>,
 Coly Li <colyli@suse.de>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jan Kara <jack@suse.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Aug 16, 2020 at 10:45 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Sun, Aug 16, 2020 at 10:55:09AM -0700, Cong Wang wrote:
> > On Sun, Aug 16, 2020 at 1:36 AM Coly Li <colyli@suse.de> wrote:
> > >
> > > The original problem was from nvme-over-tcp code, who mistakenly uses
> > > kernel_sendpage() to send pages allocated by __get_free_pages() without
> > > __GFP_COMP flag. Such pages don't have refcount (page_count is 0) on
> > > tail pages, sending them by kernel_sendpage() may trigger a kernel panic
> > > from a corrupted kernel heap, because these pages are incorrectly freed
> > > in network stack as page_count 0 pages.
> > >
> > > This patch introduces a helper sendpage_ok(), it returns true if the
> > > checking page,
> > > - is not slab page: PageSlab(page) is false.
> > > - has page refcount: page_count(page) is not zero
> > >
> > > All drivers who want to send page to remote end by kernel_sendpage()
> > > may use this helper to check whether the page is OK. If the helper does
> > > not return true, the driver should try other non sendpage method (e.g.
> > > sock_no_sendpage()) to handle the page.
> >
> > Can we leave this helper to mm subsystem?
> >
> > I know it is for sendpage, but its implementation is all about some
> > mm details and its two callers do not belong to net subsystem either.
> >
> > Think this in another way: who would fix it if it is buggy? I bet mm people
> > should. ;)
>
> No.  This is all about a really unusual imitation in sendpage, which

So netdev people will have to understand and support PageSlab() or
page_count()?

If it is unusual even for mm people, how could netdev people suppose
to understand this unusual mm bug? At least not any better.

> is pretty much unexpected.  In fact the best thing would be to make
> sock_sendpage do the right thing and call sock_no_sendpage based
> on this condition, so that driver writers don't have to worry at all.

Agreed, but kernel_sendpage() still relies on mm to provide a helper
to make the decision and ensure this helper is always up-to-date.

In short, it is all about ownership.

Thanks.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
