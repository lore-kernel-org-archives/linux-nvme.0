Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE48C48BEB
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Feb 2024 22:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=9T1gYjKWloD+7WMTvRGO7GXzkRS+zjfh6KTPdkAw9XM=; b=MY3f3mvrMEiAcijewdFf40EHD6
	oQabc5W+493CeenZ0L9pJo24rPUpCmIe+OfPx68gPUpkOW0SojIKHYu5jpIM1yUNhzzdjZe60MVtU
	wSXkpIL6a3wDdPHBHB+AG4/JD59v9QjwQKQySaASmF2i47Br7+tTSn/hybHTNX98z2iIuCBqEvShB
	5WtMAigSQXUWqOev4E80D4ptf1hG5ybKNBhBEKSDOoh1GfBfCk9TkxMvC12pzjFV9GD+E2WIl9rsy
	VmDfhxlc4ik5kHO32wzDFp2TAvhUOdCAv9vUw0EpbrEomDp7fakgbE7tEZazroIc0eOueFoNqIn4T
	StmW3PMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNSS-0000000EOHE-1iTu;
	Wed, 14 Feb 2024 22:10:24 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raNSQ-0000000EOGs-1Ofu
	for linux-nvme@lists.infradead.org;
	Wed, 14 Feb 2024 22:10:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8E24ACE2285;
	Wed, 14 Feb 2024 22:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CE3C433C7;
	Wed, 14 Feb 2024 22:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707948619;
	bh=M5T/X5w8np6ik5FnBPgQHtq/mBLhqToyi8wr6bwPGxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MfKxqjzobHbtXh1hFqKjAuoCGCggHnqe8xazJnW7Cmgq2HN9Rbwe5qHx60i4TKIjW
	 gL0yrdDx4gdOR46K09KvZI0jCNTffM4qtu2eStXUE8DgK8Y5C+Rs3/wddcGZHkg008
	 xcsfhTbDrsm/bJXQZmv/6/sA/w4KQoBLtxNEkkDCvM0XZIidXwDahFfNyhYZfRWD4G
	 12HtBRv/93QX6EXlUT3cLVY1HmM9rqWak55ZIApuVSO28Ajsjk5XbYHtljqrK8HBiI
	 y4JTcoaQWoHvaM5DHzxHGdQA0ddmE1mP2zUpxU2ZSExsAkRkOjitKd4N5/TOxXXLRs
	 lu8c+FcTsqBwQ==
Date: Wed, 14 Feb 2024 16:10:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Christoph Hellwig <hch@lst.de>, Jeremy Allison <jallison@ciq.com>,
	jra@samba.org, tansuresh@google.com, gregkh@linuxfoundation.org,
	rafael@kernel.org, bhelgaas@google.com, sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/5] driver core: Support two-pass driver shutdown.
Message-ID: <20240214221017.GA1268794@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx9WiPUcVkU3bc3-HA7WN_Mq4JaBZB9HQn+LE0F26Tte1w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_141022_573610_603DEF7C 
X-CRM114-Status: GOOD (  19.92  )
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

On Wed, Feb 14, 2024 at 01:36:28PM -0800, Saravana Kannan wrote:
> On Wed, Feb 14, 2024 at 12:10 AM Christoph Hellwig <hch@lst.de> wrote:
> > On Tue, Feb 13, 2024 at 07:36:35PM -0800, Saravana Kannan wrote:
> > > > This changes the bus driver interface with an additional entry point
> > > > to enable devices to implement two-pass shutdown. The existing
> > > > synchronous interface to shutdown is called, and if a shutdown_wait
> > > > method is defined the device is moved to an alternate list.
> > >
> > > This sounds more like you need a parallelized async shutdown than a
> > > two-pass shutdown. Similar to how async probes are done today. Why not
> > > do that so it'll actually be useful in a more general fashion? You can
> > > even add a flag like we have for probes so that drivers don't need to
> > > do anything special to allow this parallelism.
> >
> > Well, we had that discussion before.
> 
> Can you point me to this please? I looked around and wasn't able to
> find it.

I'm not sure what Christoph had in mind, but he might be referring to
this:
https://lore.kernel.org/r/20231227203337.GA1509884@bhelgaas

Bjorn

