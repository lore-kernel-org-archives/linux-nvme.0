Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695B0C27C65
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 17:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xSm3/mSAdrGoFoAFcszrBVVRPory/rmYE4HpbQSvZhM=; b=E9Ed01/tQZEhFT0P3DDa1dSy24
	aLudt1u318vSu1CAc2ubZqPRd7YaFg6XC+HiwDYivCtlj1naD117pZSN7WKGyPKKlxgR+y11LzuHl
	iMSUHcAu2kA2XcvTQyJwjbdBnmmJ0PGMoROcX8S27h1aGN5kBiYccGTrQ+TKQodrXCgT6SRmVu7Ta
	EQ2+JhsT5BBhRjGRMghGufNsHt/LdEuCprJIZRAcPXmUQnJjYBaEKBmJ193KB6NgzduFqMCZCH4uH
	Sr3zZ3Yd/NjNQ6OGREwFkz3lAB1xFNW1UiCgBiFXt17HjwGRObBIcm62mAM+uDLnfh9l3pKKKuNqT
	s+nsTMyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH5aR-00000009ijW-3N31;
	Tue, 11 Jun 2024 17:47:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH5aO-00000009iiX-2aEQ
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 17:47:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 942C460DD6;
	Tue, 11 Jun 2024 17:47:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4F4C2BD10;
	Tue, 11 Jun 2024 17:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718128027;
	bh=36T2K9aFkBfiAZcwV3STRai8NPf570te/8GleiFFim4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kydNF9SsJ80vSZCuiiCkZuUDwKJZucbSmr9Y3AlI20saZg1IuJDZzKD2QBbt4Vs8d
	 Eu2Bk08iwefcQgQSA+mqlgEgYHt4DSKFphr0xrPzyjSgn9P9LLT4uX8ihJu+Rknyjg
	 DmP4Zyw6MppFIOijpkeGQqXp+6xBWtgC3P7OWTR0rCold/FyGzYfFG9mw/4cYGnkei
	 +e/+NyD68x47FfQf3pqHPTQNbxU7F9ax+JLKhn12YYSkgBeEfq9pzQVDc5YCE7Opb+
	 nHwgHjXABXCZuU/DX3frnP/NxSs+VrALqgZXjnhKcda2mI77dSmE4Q3c1Z1MOpbzZY
	 aahWPTm+4Db6Q==
Date: Tue, 11 Jun 2024 11:47:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: fix namespace removal list
Message-ID: <ZmiNmIPLom4NFhkY@kbusch-mbp.dhcp.thefacebook.com>
References: <20240611152055.2317197-1-kbusch@meta.com>
 <20240611163955.GA12787@lst.de>
 <ZmiHvDaI11gu8K4I@kbusch-mbp.dhcp.thefacebook.com>
 <20240611172448.GA13680@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611172448.GA13680@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_104708_796214_E8B37D46 
X-CRM114-Status: GOOD (  24.01  )
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

On Tue, Jun 11, 2024 at 07:24:48PM +0200, Christoph Hellwig wrote:
> On Tue, Jun 11, 2024 at 11:22:04AM -0600, Keith Busch wrote:
> > > Is this actually valid for a (S)RCU protected list?  If the entry gets
> > > added to the new list before the grace period has completed, we could
> > > trick a concurrent traversal into following the new list unless I'm
> > > mistaken (although chances I'm mistaken on RCU corner cases aren't that
> > > low..).
> > 
> > Good call, you are absolutely right that a sync should happen between
> > the del and the add for readers to consistently iterate this list.
> > 
> > I might be able to weasel out of this though: our namespace list is
> > sorted, and this function wants to append everything from this element
> > all the way to the end to the "rm_list": a reader should get the same
> > result either way, whether if it was torn at this element or the move
> > happened without the reader seeing it.
> > 
> > Now if there was a way to rcu split the list so we don't have to do it
> > element by element...
> 
> Isn't that exactly what the list_splice helpers do?  We'd just need to
> do that exactly once at the cutoff point and not once per namespace.

Not a splice since that takes the entire source list; this usage is more
aligned to "list_cut_position()", which doesn't look rcu safe as-is, but
I think we can make one!

