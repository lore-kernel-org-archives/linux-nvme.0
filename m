Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EDEC83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 06:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XOXYYKI6ROmdL1Tb92+tnPUjQAbtFnhPglvAtvEE7/U=; b=QWB7ZW8i/yD07zOSoOb1tHq/ZY
	sMt8kzJJ1RQWck5kKoqG/GR5akwDxS8yk5gapvQ860kuhnz44IefTZe+rsCRNRE0Y0lwOso+f/TXh
	4odC78YZkImR0Ahcwcv1J7DXNK+6cFtAYChCzYSfPjR9PS4ALaTr6nbJR8UIZwNsfJw/Yk6tSUToI
	hHuBn8TTfV9vjqbhjfBo5Gh5CIuvo/x+NvQS8mekMVvlgXYDEiPN44eJ/e2C3QUmak3F/C4I0E2Qm
	GuHlkuWBDa8Tny1kKE4RNTufpzub7I75dBPizrg0aZRHNtSE4KKCqggF7j6J9Hsf3/ocjaqoAefev
	DccvVtZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubYot-00000004AcT-0ePU;
	Tue, 15 Jul 2025 06:07:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubYif-000000049wx-1nr2
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 06:00:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0750D227AB8; Tue, 15 Jul 2025 08:00:46 +0200 (CEST)
Date: Tue, 15 Jul 2025 08:00:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Theodore Ts'o <tytso@mit.edu>,
	John Garry <john.g.garry@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715060044.GB18349@lst.de>
References: <20250714131713.GA8742@lst.de> <20250714132407.GC41071@mit.edu> <20250714133014.GA10090@lst.de> <yq1h5ze5hq4.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1h5ze5hq4.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_230049_616096_5B223058 
X-CRM114-Status: GOOD (  10.90  )
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

On Mon, Jul 14, 2025 at 11:22:43PM -0400, Martin K. Petersen wrote:
> For PCIe transport devices maybe we could consider adding an additional
> heuristic based on something like PLP or VWC?

What would you check there?  Atomic writes work perfectly fine if not
better with volatile write caches.


