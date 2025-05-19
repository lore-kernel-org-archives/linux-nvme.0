Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F9AC3DA6D
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 10:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lcl1eiUgh0tnfvzTLA1YpHKA0bwY0u5PpuPMMhkls0k=; b=uRN+LTpbIibULNlfM5fK5EPOZg
	OL5oNumZfhdA9G3z0o0M93bnQAWdSsu8BhQKyMBMsflN+vf5xwjFy45BPUpqT7FDjq9hMRHlsJSkL
	pM7+9mjY7h8B1cB4828A+WaXE/oGk0GxTshHyU7gYc13OtckKJ0oRl7/ZqAjz4fpFEaE5bUua0GQr
	s1AMCI9xjZNmcQAJHg9w8O/k1uSzw0ouh9RSBR64vjQLrynfbyaamMpRJVc0awTZrZjJj5aFNRzzH
	cvdCnjeb8RQz2Bn5nBioL8ImxVk8ke07bhtsddVKCQ5Qg/AIMBVzGCaV6vbePXAeUXJrGKMFrip08
	oIyALnlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGxP7-00000008jfJ-2fFA;
	Mon, 19 May 2025 10:07:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGxEn-00000008hKK-0055
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 09:56:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 36D5768B05; Mon, 19 May 2025 11:56:43 +0200 (CEST)
Date: Mon, 19 May 2025 11:56:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org
Subject: Re: nvme-cli & json vs blktests
Message-ID: <20250519095642.GA21183@lst.de>
References: <20250519054905.GA6156@lst.de> <30a83f60-34eb-4940-b322-8ed31f091435@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a83f60-34eb-4940-b322-8ed31f091435@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_025649_194452_35166BA8 
X-CRM114-Status: GOOD (  15.69  )
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

On Mon, May 19, 2025 at 11:51:47AM +0200, Daniel Wagner wrote:
> On Mon, May 19, 2025 at 07:49:05AM +0200, Christoph Hellwig wrote:
> > make the nvme-cli build a little less arcane?
> 
> There is no magic build into the meson/ninja build system. meson creates
> the ninja build instruction which are fully hardcoded, thus it wont pick
> up any newly installed libraries on automatically. Running meson with
> 'setup --reconfigure' is a design choice of this build system.
> 
> I don't really see a problem with this approach.

The fact that a make clean is not clean enough to find newly installed
dependencies is very unusual.

