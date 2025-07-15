Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F865C83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 06:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CLXS9C3pI5axdzxWaBynMYzCe9FGkgv5TqvxPYv7Tbw=; b=kQZlUG8cAVm0xwLJBCztEd6g0U
	ldeOGUPU5MJQQes+KnGZDRdI1gIGa3Nh7Fd0TyylQkJtFwZIVGDqyoLjsxoG2uPZK5w7vODVaz/pf
	VgLClaewPNtIGWhDZJDPXCPdcmOSEnKpZDbajSLbta5xw9Sg5t/KTN9VvFPJOAbw2Qzu/AuNVFw7l
	JLlyPamOoK2l4DH93fKWMQSkFAq7ox3T107G/k9O30VPYzRyLg3WydXPqgR+9mjaLvvAu3nep7NTn
	PoatvuQutG+MevMwULs3oO0K9JbwrfgvO6VE02QtmGX6oYOgSE7/8Y6MRKWNSK8baxvgfHTlZxA4n
	/OV6WDAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubYos-00000004AcI-1uuJ;
	Tue, 15 Jul 2025 06:07:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubYiF-000000049qa-0ZBA
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 06:00:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 18D8F227AAE; Tue, 15 Jul 2025 08:00:09 +0200 (CEST)
Date: Tue, 15 Jul 2025 08:00:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
	John Garry <john.g.garry@oracle.com>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715060007.GA18349@lst.de>
References: <20250714131713.GA8742@lst.de> <20250714132407.GC41071@mit.edu> <20250714133014.GA10090@lst.de> <20250714160400.GK2672049@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714160400.GK2672049@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_230023_315620_9F828F3D 
X-CRM114-Status: GOOD (  12.13  )
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

On Mon, Jul 14, 2025 at 09:04:00AM -0700, Darrick J. Wong wrote:
> Do you want to handle it the same way as we do discard-zeroes-data and
> have a quirks list of devices we trust?  Though I can hardly talk,
> knowing the severe limitations of allowlists vs. product managers trying
> to win benchmarks with custom firmware. :(

I don't think whitelists are a good idea.  I'd expect the admin to
opt into it.


