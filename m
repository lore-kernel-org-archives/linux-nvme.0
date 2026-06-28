Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45B1C43458
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jun 2026 06:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AcAAwIhqjoCM3ME3XA6Mn6UxECV3sXABw2AazXuME6s=; b=LK3SpCp68tY6zHOQ66yGhWEffl
	FaTnhpegJEbZf3KMPITZuXWwsn4hxLknZs9WIiNExc/dr3daWTBWvDUHb0QyLJzj8INjzIzFniyNU
	azw22RkJh0ixNnFvwTUJpsRfnqaLxh4ek4szOyIvk9tGRLL3vVbPT6MbmpVVsjil9tkVQRL9A1Drq
	ZWOvalUTVB7FsllnD3/TVNBVSvVsuyyuw+cC2i/V29jcVqjlzUcwngO0c/iSTaPDNA3q85LitV4Cz
	id54wEHbOxTAI4Wf2Y4C7IJS82Nzm5HZJ2d/DGOqVobZ7/Okx6cdlAKC4IOsKDujyQ7Yulf4G76tl
	IQL2dk7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdiaW-0000000CwLe-45mP;
	Sun, 28 Jun 2026 06:01:53 +0000
Received: from mail-dy1-x132b.google.com ([2607:f8b0:4864:20::132b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdiaT-0000000CwLH-3oNQ
	for linux-nvme@lists.infradead.org;
	Sun, 28 Jun 2026 06:01:51 +0000
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-30eac9abd79so733960eec.1
        for <linux-nvme@lists.infradead.org>; Sat, 27 Jun 2026 23:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782626509; cv=none;
        d=google.com; s=arc-20260327;
        b=U9FQM4SwSYcR4GI5y6pCt69rgFkRi8rDClm57q8wlJ5RuBFob8xxMD4jaNiRHPTKUn
         X/EhuCfWcNDpb1JCfxeN3IIJy8MYG7GiXoJoVWwG1mXpW9fk9TcsPOf4vJpsqvYiADWV
         DMtOOLV4qSxKfZYKNIYjzHDdiTIJ3ak9Nr8ATgyALe/1rQARYOSvlbVv1XpyC/I4hSA8
         b25SyAyGacZKy4GyY7dubFv5qlgEJYVy28bBECVF3OQxuztdbcB1hCDFqh/OvwkO79YZ
         /h3WoYQoQ2FQ6mExAS5vkMU9xaqXUTNX4SEJBPsypXrHxs+UXE1Iy7NK1GzY0KhxAYIZ
         V/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AcAAwIhqjoCM3ME3XA6Mn6UxECV3sXABw2AazXuME6s=;
        fh=5tMRmydHkX13YxN+gnrPAvEwTQM4JQBwH5y4FTuLKH0=;
        b=Xsal/L6/HvAiwwGo1GdBd5CC7xZH4SXbTDp9+WiJttVv9cWLiskGf6mIbl4gBJY6mr
         s7MP7q631/zIztSrDU+Gtut3Hx0kJCCVGVJn520wM3OHBqUIPpBK43xDOZNpDEbW48X0
         MnVtzk3AzizY0JAiSLiArHqkXA6xTH8E5ysmN+knZqoOBeyxeuDWx3h8wbSYTVIBmryE
         FhgEdxPB2W7O0tx8fI9dsVhPMSk0BdwxCGcwICK2MNN/32PrpgyJcWtQ5SwnkzA3zomh
         J9tQRfWO43m2CEujujPK+XSzuus8aP2+iUcxJJJVD+Lwv38IB3uZ9C3gRv1B3yiQNxPW
         NM1A==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782626509; x=1783231309; darn=lists.infradead.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AcAAwIhqjoCM3ME3XA6Mn6UxECV3sXABw2AazXuME6s=;
        b=hIjn6Is1ONVEfxeTLZvV6MMRbWl/A3DSMXRdMTKMPi+dYaDniQoBgCVDYFCphnfcyQ
         XTZO2rYlpO+M4EUWd5f6iPzpmdywEHOl/5im/35xfRDrzYPNQvGdf336gJBgNMIQZ4KN
         7RnL+048uK5fXi73FpJd7991XjScVdOSfoEk89/Wa55Gv1e+jWROXX1noNff+SFv3Yte
         6O7+o341YZ0ST5GoTPi8RiaQZrQ5uBXvxYjSqusKsDzhaFMflElsueSehB2K3aC8G3jl
         a2TRYhueNdcm4qbdVS6DrYshoegzaiHxKtbzCSztZv0zck1GxoetyCoA7Snny79BMCFV
         sDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782626509; x=1783231309;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcAAwIhqjoCM3ME3XA6Mn6UxECV3sXABw2AazXuME6s=;
        b=FKGSirYhM5wfqyGckgmwPYDfKoZmZ09LPG569hGOYSveuHD7+PcMPH5+Dwu1ikTkZ9
         p8H7OumDoLSAew5iLU3GfxOgUpyLwp3/XLo8ZwN0sDtHXd/iTWPWNVQ4ABINC1odDdZB
         1l/zZqU4gDOgOdWsvyfXyN08Lypn6844rJ0TG684YK7vYNCTVkyjaGVf8+X1aDgfP/Fu
         KfKklgWnQYQYG9l6RLvvsB6YhEWnttzQys9xJeSfYyLP/728ExpN/QIdQcxFoHN8f8Hq
         7YltHGmAtc/bovDFIuZbNor/UEJUKNHrFPTDApAuvSElGG6Brn/KGA7ftWHGUyn8leso
         C5RQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/96wcrM3Lapxln7tnKDJbdxLlLchftyshkd4D07IxFNlvkkBY+Xy+XyWM5R/SOyUQfE1IquvlroDB@lists.infradead.org
X-Gm-Message-State: AOJu0Yw0j6j5xtKKVZFuiBsg6FvthWIemuSeQGuskkihBW3QRkF6W01I
	qT3+WwYxx6xyAzxBbOoUA0Qybw76nwGKy2N7mPQ7SEKPFmPWG0YZbDJjL7g9daICq3TXvUzwe0V
	ajzWBezlK7HRwOCR/adNiCTGDEg88DLCMF7BVmOQc
X-Gm-Gg: AfdE7cmInkL4f+7X3eY1II+Crc6VFnQ2WUy8b5VNYKX2ioUs9tN4WvOPjpPqOZFrwM/
	4IEebkuy7EPhyjbJOQWIfms2GAVi+u2IDFmoR8RnB1719ETlsxDXv/cfyHuxIbxWmnAtRdK85IR
	16NAnRhTzfnBKgs1+CggrWClu2uZF6B+C9KnmVU39xaW4Ze8RdliYv5nXrB8bIx4HyYZ6wufWNy
	hlIuU2RlckPDHZJa7Qmc/nT6jXjtM63O+6op2En8nxYdhGJ3Xay91tDgKQpbJqZuyAC/uE=
X-Received: by 2002:a05:7300:3b28:b0:2e7:c701:aa85 with SMTP id
 5a478bee46e88-30cab22b37emr6243815eec.17.1782626507928; Sat, 27 Jun 2026
 23:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-6-nilay@linux.ibm.com>
 <20260626064050.GE10731@lst.de> <e1c60afc-423b-47ec-9c38-db1397d8838f@paulmck-laptop>
 <CANpmjNPPF3TYx6qPzLO-DbQE6qvL_g6r3jYnGCk3aqeiQnnL5g@mail.gmail.com> <41a4cb5a-077c-499f-b060-2a4263303350@paulmck-laptop>
In-Reply-To: <41a4cb5a-077c-499f-b060-2a4263303350@paulmck-laptop>
From: Marco Elver <elver@google.com>
Date: Sun, 28 Jun 2026 08:00:00 +0200
X-Gm-Features: AVVi8Ce08Mcz7KG69hl_TdqHOwlcWqo7CBD28UvcxVK26K69r3VULqnntOVBic4
Message-ID: <CANpmjNPAYsiQ=eiZ=0g579j1uO+-23ZXAhRA7M3uM-B8NdHg1g@mail.gmail.com>
Subject: Re: [PATCHv2 05/17] nvme: add Clang context annotations for nvme_ns_head::current_path
To: paulmck@kernel.org
Cc: Nilay Shroff <nilay@linux.ibm.com>, Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kbusch@kernel.org, sagi@grimberg.me, 
	axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260627_230150_064775_D70069F4 
X-CRM114-Status: GOOD (  35.81  )
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

On Sat, 27 Jun 2026 at 19:14, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sat, Jun 27, 2026 at 05:38:44PM +0200, Marco Elver wrote:
> > On Fri, 26 Jun 2026 at 20:36, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > On Fri, Jun 26, 2026 at 08:40:50AM +0200, Christoph Hellwig wrote:
> > > > On Sun, Jun 14, 2026 at 06:45:20PM +0530, Nilay Shroff wrote:
> > > > > +++ b/drivers/nvme/host/multipath.c
> > > > > @@ -231,8 +231,16 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
> > > > >     bool changed = false;
> > > > >     int node;
> > > > >
> > > > > +   /*
> > > > > +    * This helper is used by namespace failover/teardown and I/O policy
> > > > > +    * update paths. We only compare the head->current_path[] pointer value
> > > > > +    * and do not dereference the referenced namespace, so suppress the
> > > > > +    * context analysis warning for this lockless inspection of the
> > > > > +    * __rcu_guarded pointer.
> > > > > +    */
> > > > >     for_each_node(node) {
> > > > > -           if (ns == rcu_access_pointer(head->current_path[node])) {
> > > > > +           if (context_unsafe(ns ==
> > > > > +                           rcu_access_pointer(head->current_path[node]))) {
> > > >
> > > > I think we need a helper for this, as for a simple pointer value
> > > > comparison without a dereference we don't really need either
> > > > rcu_access_pointer nor locking.
> > > >
> > > > Maybe somthing like a
> > > >
> > > >       rcu_compare_pointer(rcu_pointer, nonrcu_pointer)
> > > >
> > > > ?
> > >
> > > We could provide something like this:
> > >
> > > #define rcu_compare_pointer(rcu_pointer, nonrcu_pointer) \
> > >         context_unsafe(rcu_access_pointer(rcu_pointer) == (nonrcu_pointer))
> > >
> > > Or maybe rcu_pointer_equals()?
> > >
> > > Marco, thoughts?
> >
> > I see 2 options:
> >
> > 1. rcu_compare_pointer / rcu_pointer_equals as proposed. It's more
> > explicit but does add some friction during Context Analysis
> > enablement. But this only makes sense if there are cases where
> > rcu_access_pointer() should be used under the RCU reader lock, which
> > led me to the next suggestion...
> >
> > 2. Redefine rcu_access_pointer() to just not require the RCU read-side
> > lock to be held as:
> >
> > > #define rcu_access_pointer(p) context_unsafe(__rcu_access_pointer((p), __UNIQUE_ID(rcu), __rcu))
> >
> > [ Or alternatively wrap __rcu_access_pointer() in context_unsafe()
> >   (similar to rcu_assign_pointer and friends). ]
> >
> > I think rcu_access_pointer() is in the same category as the other RCU
> > pointer helpers, although currently only the pointer update helpers
> > imply context_unsafe(); I think it might have been an oversight
> > initially, and we should change rcu_access_pointer() to match. There
> > should be no reason why an rcu_access_pointer() should be protected by
> > the RCU read-side critical section, since it's not meant for
> > dereferencing the pointer (that'd be a bug; its documentation also
> > says "Return the value of the specified RCU-protected pointer, but
> > omit the lockdep checks for being in an RCU read-side critical section
> > [...]").
> >
> > If you agree there should be no cases where an rcu_access_pointer()
> > should be guarded by an RCU read-side critical section, then I think
> > this is the simplest and correct design, and avoids expanding the RCU
> > API.
>
> I don't know of any uses of rcu_access_pointer() within an RCU read-side
> critical section, but code in a function that might be called both within
> and outside of a critical section might well use rcu_access_pointer().
> In other words, it should be OK to use rcu_access_pointer() within an
> RCU read-side critical section as well as outside of one.

Thanks, yes, that's what I wanted to confirm; i.e. it's ok to use
rcu_access_pointer() within and outside an RCU read-side critical
section.

In which case, my proposal (2) to make rcu_access_pointer() not warn
on accessing __rcu_guarded pointers outside an RCU read-side critical
section should be the simpler and more generic change (vs. adding a
new rcu_pointer_equals() helper).

