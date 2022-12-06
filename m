Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3172C3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 08:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OA1qT8cygRlBgWvxM1EZRhTJJYK6oEnILjsD8BmDs68=; b=d0tNfDq1uiFwzTWMY8lqjgbZhx
	ZMD08zlsGiBO7pSla6IRgr9JEXPWqdyxI7yR+vqnyQ6OLf7Kziyed/5nbRVWoXjFJYeAdEdUMsu4z
	TMoHJM4IuS1wiA5fWUu9boI+9P60NWptkAFbrF5iguwcHmelRyhpdZNeeO7Xa1Yb0G0PJf3To3Fws
	kImFGgLghGqQVEhpyrKEeISjBzVnNaWd0+VuQ3LKDFDO/x97UDGCqLxHAaKGN4pQPa8vbbuu8Nz+U
	sqHaempvjhalMaV0PcBUGjDasA1tRVnrrMhDFiDo1YNpcMca8pMh2XrRCSLSPL38yjCtXlKLAQd+i
	xvqgPmig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2T0E-004Pws-H5; Tue, 06 Dec 2022 08:08:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2T0C-004Pnc-2h
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 08:08:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A1D0968B05; Tue,  6 Dec 2022 09:08:23 +0100 (CET)
Date: Tue, 6 Dec 2022 09:08:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com, Monish Kumar <monish.kumar.r@intel.com>
Subject: Re: [PATCH] nvme:core: initialize core quirks before calling
 nvme_init_subsystem()
Message-ID: <20221206080823.GA8476@lst.de>
References: <CGME20221201125412eucas1p17da85d566e9786dba7d76230f396eb57@eucas1p1.samsung.com> <20221201125233.41094-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201125233.41094-1-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_000832_278684_A0AF81CE 
X-CRM114-Status: UNSURE (   7.45  )
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

Thanks,

applied to nvme-6.1.

