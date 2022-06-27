Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1316C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 20:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kvgcOZrQWrx0JNyz24fOHr3SC1L9IVTDxYubqdOpFYk=; b=BkpbdAnO9VtMpiDm6EVEgy4gzS
	ssSvZoKTTKvR3EWPf+gbZ3Pc5Cvgz6yNZ2nucf+CNP9IG2vDnsHq8Ehb4JHIoLU1OUwAWDpW4gv6G
	m2uOLpkjJzC5Au4HMCbUS4sZLuPm+aTyRTYS2Oqjc3oFmNgQdJ06OHeDWd43KCiymCqe4ZVblbc4B
	l/+/tP2NxPN2ho6ueQPTkePv5xLZT9sCkZPLQ/jKh4zAVDIzxn6lG4YLXwGPa8l2FoOstt3s8a0QM
	4L/N6m9Pb7UOtKxaEbEeUy8G0BTZYuVUKRQG85sZapSl2XgEagLuB/WNRMcjz46wgK5zvIVmwgIDu
	cKQroiYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5v7m-002jho-2L; Mon, 27 Jun 2022 20:14:22 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5v7i-002jgc-Nw
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 20:14:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 185F3B81AAA;
	Mon, 27 Jun 2022 20:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488D4C34115;
	Mon, 27 Jun 2022 20:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656360855;
	bh=kvgcOZrQWrx0JNyz24fOHr3SC1L9IVTDxYubqdOpFYk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jz0wAmYorDGrP9ew5bHwPHOkxwdpz9pcBI8RvYOzWMWRQOZULN+BbQon/u3OGwObg
	 cXkgKnAbqj4HJnCL0HRSyxFV0EfZfOfTzqoC2gHTHR3rSs+fOtBPCtjgkQzIScXEL/
	 At7UNjEcyW9E6BHayhjBlZKRzbZP7Mmhk2XpnTOhXsv2gpq11vbDAZhQciHWYSRemu
	 fi/eCX/DoRWp+SLirLJY+fkUq9LQu/DTjrHFcLLpg3hJNVL7VErC6PoTlqcasi7/x0
	 vS5sDFlTGvS5uycEvAL0b1Pd94o/2pi+HID3rbNVTuZDR9aEVooK0olDMFjeDy4auR
	 biYZUkn72OmWQ==
Date: Mon, 27 Jun 2022 14:14:12 -0600
From: Keith Busch <kbusch@kernel.org>
To: Pablo Greco <pgreco@centosproject.org>
Cc: stable@vger.kernel.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG
 SX6000LNP (AKA SPECTRIX S40G)
Message-ID: <YroPlErIYce5LbMr@kbusch-mbp.dhcp.thefacebook.com>
References: <20220625121502.9092-1-pgreco@centosproject.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625121502.9092-1-pgreco@centosproject.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_131418_957994_0524451A 
X-CRM114-Status: GOOD (  10.38  )
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

On Sat, Jun 25, 2022 at 09:15:02AM -0300, Pablo Greco wrote:
> ADATA XPG SPECTRIX S40G drives report bogus eui64 values that appear to
> be the same across drives in one system. Quirk them out so they are
> not marked as "non globally unique" duplicates.

Looks fine.

Reviewed-by: Keith Busch <kbusch@kernel.org>

