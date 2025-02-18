Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EACC02198
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Feb 2025 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QUWKAwStaXd6mg4sjqTFfQcBktACRLNdWw7p6TIVx+k=; b=ANWrbOn5I5pazRU1WaOXp6SpM7
	R5NIOjVRKVxdHDD2DF4O4CTP/XEt5hFRQQuUTCD9JhQiSztN4LYGr4tkCQQF5TTPveUYT5acPPU62
	0eVZiWkL8H/4Dy2XdOWiWRtzhuee87xNSVyGaopeuQRb5Eb243YOWkcT9gVfpICzMi4AHn8RnItzt
	ZtfMv68cXe8eJmmdHrgZJ7826r12pndI+eP+uBrWZoxB2zD2ObsriI+dC/ygPnuezwLRasY9wYvMf
	hIIa5KQoMyvg16jNwICfnvfCq5V7YGVIz/lazHbJkxbc7PXcumcWuEPeSQP7a1wPCSxKq1+foXW2W
	QlGGNSzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPnt-00000008p1m-3W0P;
	Tue, 18 Feb 2025 15:46:33 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkPnr-00000008p0G-1Jjq
	for linux-nvme@lists.infradead.org;
	Tue, 18 Feb 2025 15:46:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6F3EA5C4CCD;
	Tue, 18 Feb 2025 15:45:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D45C4CEE2;
	Tue, 18 Feb 2025 15:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893590;
	bh=QUWKAwStaXd6mg4sjqTFfQcBktACRLNdWw7p6TIVx+k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kxw1fCtZA4UQgH7hy4oy3TY+3wNy3HPYx32ngSgLPp3GIe7h5oMr+fVBPdqPti+Oj
	 voKdLRrh0RdCVPuSvrQjLHmbFkSbEEzkNLtcth2Q8OfdVIEDlXmf/p/S79dOM1LvVI
	 CkLIkDBED5AHKRTGT5aDXjXrCytMJTCjH3Pvfmudy1QB3kD3Pnl3SGti8A4HfwiFgF
	 ijl0DlZqWjWoMP8k5/vtRXb5mZOM7L5/zgh+YPxOUFmSVQ/yiI7HNsI/paOL2fFBLT
	 CcqdZ5TMV9cMCRVKg0oTbUzoTo2RDWpU7ZcTi4tlo2HsOxpZhVaPNM0goKcbPY8LvS
	 b/r3hevwejDDA==
Date: Tue, 18 Feb 2025 08:46:27 -0700
From: Keith Busch <kbusch@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 0/2] Cleanup controller configuration register handling
Message-ID: <Z7SrUy7eqw40LNOm@kbusch-mbp>
References: <20250213065000.598443-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213065000.598443-1-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_074631_408650_71A5854B 
X-CRM114-Status: UNSURE (   7.36  )
X-CRM114-Notice: Please train this message.
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

On Thu, Feb 13, 2025 at 03:49:58PM +0900, Damien Le Moal wrote:
> A couple of patches to cleanup the definition and handling of the CC
> register. No functional changes.

Thanks, applied to nvme-6.14.

