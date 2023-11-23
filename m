Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D519C61D99
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Nov 2023 02:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nW/LoTMRHD3jKJ4jNIOdKgHKNSbqbO64228NLE3wKic=; b=o/V5ldWsatPDqjrndV2hX5MUBM
	88Ax6g6hYw5Yhn++shIveolZxzOQ7PVMbN/mF+jzaoS6VTBpYDlJ1exHiyZpGxPNFsMBJzai/k2Vu
	ZWGXP0wjrMttlAqf4kcn/6SCAQ+VdZ5G6qdMZBN6TVnkkNoDiXlX7DADAtm3QbLeG4124/QlTxPBF
	LVNtaqo3CCjwqS9Q50IT/gLmnozLWwD/MHCWdNF3154+FcOHFRltLc8jbU4SAzdffCVqpgrz069Cy
	uXifL7SlAqe+5S+Dz6uyausX9qB3zuIEsE8f3MqWD/GA29phtRSV7wYJ7FUOekzm+nptypBXK6p9h
	Q+huR3dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5z37-003YiF-32;
	Thu, 23 Nov 2023 02:02:37 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5z35-003Yhu-39
	for linux-nvme@lists.infradead.org;
	Thu, 23 Nov 2023 02:02:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 384ABCE212E;
	Thu, 23 Nov 2023 02:02:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E3AC433C7;
	Thu, 23 Nov 2023 02:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700704952;
	bh=OImsWoDCM9k5QBfPOzcccsAYXqLYofeIqJCqGz2sIGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RSdHxVQvZHc4YAk80/G787C8uTOh+tyzjg6xqROwCxE3i+mRw8ehnqzDDxNdnn4Gy
	 ph4G3kfjvYrS88x8KWNR62cshDgCgqj419zuvEVZGLyFmA6r+MCcQV7F6J4xfbhPLc
	 zJcrMRZ+/ACjIDmQZpcnD8K2/40rssktQmySi6x9wviOyeTzwD/lDY2eG++W+CWeHX
	 YUW2YTzGRUtG0qP7xZVso1PEJuIUDlxMu9vO+QxDFvT+hBu1vxKuAAjWDIzjVRictS
	 Y0aARZOFGKv5BsjZYWoiJ2W0xTXUS1aSrFnnduLyO1mN65pF5fOb/0/FCy7JFY/9oR
	 yOjOfZHcM/p9Q==
Date: Wed, 22 Nov 2023 19:02:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-nvme@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] nvme link failure fixes
Message-ID: <ZV6ytebPTC11Patu@kbusch-mbp.dhcp.thefacebook.com>
References: <20231122224719.4042108-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122224719.4042108-1-arnd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_180236_265805_65930E41 
X-CRM114-Status: GOOD (  14.33  )
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

On Wed, Nov 22, 2023 at 11:47:16PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> There are still a couple of link failures that I tried to address
> with a previous patch. I've split up the missing bits into smaller
> patches and tried to explain the bugs in more detail.
> 
> With these applied, randconfig builds work again. Please either
> merge them or treat them as bug reports and find a different fix,
> I won't do another version.

Jens is taking these directly, but for the record: looks good to me and
thanks for the fixes.

Acked-by: Keith Busch <kbusch@kernel.org>

