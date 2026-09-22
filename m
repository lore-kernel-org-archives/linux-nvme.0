Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37EF3C98302
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 15:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cOoptst2ZoEH8nVl0gkhYSEwxHVp5gsU3BDINyMPqCg=; b=OjUsLDbEmubwm97v5KKoCM2unC
	W8HHjN0nh7dAKUsyv9wVYYyY21/EpvK6Otmj8WRuJsQEuuwE4SumgEEZdxRYqGsRNJXVX72fgsMD0
	6weiHIV6U6A3uHKVousavlKOYWDVwa11Zv3ZYvNwTd+UiTNpMWZ4Xz0+urvCEeHEDG8/fTf2nUONj
	fdeduuzrq7ULygBDlPFrkK/b4+KrDVnfPBGNAUbIrw1szsOMHyryp9NUbrP6gg+kGoLhEJE6s8Zqt
	x1/yrOdJuTh0HiJU4DJ15HU+U7xNUNRM3j+rDFTyivgr6lSq5DuHit7w4TuHootTw4dirdk6NB2ps
	dGho4ZEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x92oB-00000005x8R-0OAQ;
	Tue, 22 Sep 2026 15:53:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x92oA-00000005x7k-1XOj
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 15:53:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id BEACB40BFA;
	Tue, 22 Sep 2026 15:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7903B1F000FF;
	Tue, 22 Sep 2026 15:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092405;
	bh=cOoptst2ZoEH8nVl0gkhYSEwxHVp5gsU3BDINyMPqCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L3RxkiWKuROFiw8J6LgOeWwybKXn/pxST7eaRsKu9zbMuQCmcYr65EAki0pMmLGsY
	 QUnb1BPV09sM7D1bFA2bKnGLSB7AwqLsxKbt9PIO7p9uzvx/q+SK+SeHtm644Yiuxg
	 17lcVpXlyKlVCcMpVaqNBkaTnOkeDJzXqYDnw2/YhohjTtAzpZSHD13XMfpZqfCRBL
	 wWoxESvTFgzXA6rqIQ4ltkXf+AN7zzarNPQYkokHpPwaDb9gdVV1HigU7KlMvwRm+b
	 Dt+OkORRzZ3i/hIcAfUad0sq3sBkC72jD6fvb3nVn3XNeYPurIstKX/lZ8Nsev9lVu
	 tq+HaVv6ccheQ==
Date: Tue, 22 Sep 2026 05:53:24 -1000
From: Tejun Heo <tj@kernel.org>
To: Tao Cui <cui.tao@linux.dev>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	yukuai@fygo.io, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org, cuitao@kylinos.cn
Subject: Re: [RFC PATCH 1/1] block: charge passthrough requests to the
 submitter's cgroup
Message-ID: <arKkdCkRGilTypb7@slm.duckdns.org>
References: <20260921070647.1928289-1-cui.tao@linux.dev>
 <20260921070647.1928289-2-cui.tao@linux.dev>
 <arFgjkKUwYGWbV8H@slm.duckdns.org>
 <acd79732-1ef3-47d5-96fc-4dd3ff3eee27@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd79732-1ef3-47d5-96fc-4dd3ff3eee27@linux.dev>
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

Hello,

On Tue, Sep 22, 2026 at 04:09:57PM +0800, Tao Cui wrote:
> I don't have a specific passthrough workload that triggered this in
> production. I ran into it while testing blk-iocost accounting coverage.
> 
> The relevant concern here is cgroup IO isolation. The expectation of
> blkcg IO control is that the IO consumed by a cgroup is reflected in its
> accounting and subject to blkcg IO policies. Today that is true for IO
> going through submit_bio(), but not for passthrough requests.
> 
> The concrete observation was that the same cgroup issuing equivalent
> writes through two paths gets different results: normal bio IO is
> accounted in io.stat and subject to blkcg IO policies, while SG_IO
> writes consume device bandwidth without accounting or blkcg IO control.
> 
> So the motivation is not a particular SG_IO application, but whether
> passthrough IO should be considered part of the IO usage controlled by
> blkcg.
> 
> I don't know yet whether the right answer is always-on behavior or an
> opt-in mechanism. The RFC was mainly to discuss whether passthrough
> paths should be covered by blkcg accounting/enforcement at all.

SG_IO requires CAP_RAW_IO, so any kind of isolation isn't gonna work out
that well. This is an imaginary use case. Please stop until it become an
actual one.

Thanks.

-- 
tejun

