Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CEAC54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QLX36gK2Bwv2oE8I3wF2eFnBcTkqG9m2nU/5+195Tck=; b=Z3yjEQSL31kXswyl/5tLaFEAaT
	7aajociDEOnTMXgLOK0nxdjmE1KAgPVkFYutcb+yONzmaXuYlIFLk4Pzb82o0/roQ7fTCBkdyE7lG
	afJ/1m4MPP0WKZ/kcoNd3tmTj1jjklClmgdHB+UAEeHp/KJ6gyF681/xcnPK8iurC5zODpfkA4enm
	rfzu8KHsrzLfs9M6Ogu7aWNvcZ7ymBsMrBjDV3r5QRg7mb5MKTWrd1KUufWMy19JzyrLNVJvnkv7p
	xAiGZtq8d8ZsHBfdZs91zkb/9hFUoQTUA9Sr8c3GBJA1Z0ZTZ6CR2EvaVlKLJeqLoxKD8VzoC0slm
	z4m/mCJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ric2i-00000009pI0-1r8f;
	Fri, 08 Mar 2024 15:21:52 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ric2h-00000009pHM-3ZV9
	for linux-nvme@bombadil.infradead.org;
	Fri, 08 Mar 2024 15:21:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QLX36gK2Bwv2oE8I3wF2eFnBcTkqG9m2nU/5+195Tck=; b=U3G96h7RDHPskt5np9nXS+yrYX
	yC4OAnxwLIeIqJn49fvvBJVwy0WvZU1SYYOGwnUs+BiW8INqkPFRR7vbYIiuJmlt1Xkh2ls+Nj7ut
	Q6BneG+D2AZWgRsS+ws3E0DefEKHGl82W9EjF05QUtGMz29a8MVl9EP59iynj2M66FgJ/SS1zcnew
	9K9yPhp6TXoqaPRQ6Da/C1K8qvlE57cCvpa2sq1fpGqYTOrFsEZLv9lI2PxUO2bFpR89Dsv3hYp4f
	ft6O1G2HZSCokTmuTv+en0CvomWGNAU2GRNsru7iYYT/l8aHQKPp2E6l0Cabuzt+CjV9/98Jt0SYm
	g1R8vmkQ==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ric2e-00000007KBq-3Anc
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 15:21:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6F0BE68BEB; Fri,  8 Mar 2024 16:21:43 +0100 (CET)
Date: Fri, 8 Mar 2024 16:21:43 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: Re: RFC: untangle and fix __blkdev_issue_discard
Message-ID: <20240308152143.GB11963@lst.de>
References: <20240307151157.466013-1-hch@lst.de> <Zeor_z55xu6ulRyP@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zeor_z55xu6ulRyP@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_152148_968644_836EB106 
X-CRM114-Status: GOOD (  17.78  )
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

On Thu, Mar 07, 2024 at 02:05:03PM -0700, Keith Busch wrote:
> On Thu, Mar 07, 2024 at 08:11:47AM -0700, Christoph Hellwig wrote:
> > this tries to address the block for-next oops Chandan reported on XFS.
> > I can't actually reproduce it unfortunately, but this series should
> > sort it out by movign the fatal_signal_pending check out of all but
> > the ioctl path.
> 
> The last patch moves fatal_signal_pending check to blkdev_issue_discard
> path, which has a more users than just the ioctl path. 

That's true.  I guess I actually need to open code blkdev_issue_discard
in the ioctl path or pass a flag (which would be a bit annoying)

