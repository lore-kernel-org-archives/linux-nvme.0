Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460F1C83F17
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 06:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CyUbXbw73oVDzuFqpCiRObhBUor9CpYhsp0E7aPt3s8=; b=iqzLXtip0j92q8NvJKfMIYX7dz
	iP2gOzJ1WIkEbEkkWqg+UpyI6CFj4XCVtUDn5xVKDIoAsvJldtWbXezdhW5LY1ymvZ4dSurmSmXRm
	0YNCkyVTbWmK/xbypUag5grCb/Wc6si5PyTZ2LPqrzUm4a1tFg48lPmWzivRp9g3sbmOnF5UXqbJf
	m87PgLHT5ufXNInzHlaCNZk1QRikin00CaHwcKbhnvro7wevTsnIxB3hNdqfcvVfwB563106o1gKZ
	TKyRRjGGZsg1e5WQnRlOFd0U8DCT7nNbqEAFHD683yTtVD3nUOurFW/vky6LNthUwNCq1g6Q9PIXu
	15HjElWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubYot-00000004Acj-3FKD;
	Tue, 15 Jul 2025 06:07:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubYkh-00000004A9t-1b4P
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 06:02:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 371C4227AB1; Tue, 15 Jul 2025 08:02:49 +0200 (CEST)
Date: Tue, 15 Jul 2025 08:02:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@infradead.org>, Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Do we need an opt-in for file systems use of hw atomic writes?
Message-ID: <20250715060247.GC18349@lst.de>
References: <20250714131713.GA8742@lst.de> <6c3e1c90-1d3d-4567-a392-85870226144f@oracle.com> <aHULEGt3d0niAz2e@infradead.org> <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6babdebb-45d1-4f33-b8b5-6b1c4e381e35@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_230255_561334_D922604B 
X-CRM114-Status: GOOD (  16.44  )
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

On Mon, Jul 14, 2025 at 04:53:49PM +0100, John Garry wrote:
> I see. I figure that something like a FS_XFLAG could be used for that. But 
> we should still protect bdev fops users as well.

I'm not sure a XFLAG is all that useful.  It's not really a per-file
persistent thing.  It's more of a mount option, or better persistent
mount-option attr like we did for autofsck.

>
> JFYI, I have done a good bit of HW and SW-based atomic powerfail testing 
> with fio on a Linux dev board, so there is a decent method available for 
> users to verify their HW atomics. But then testing power failures is not 
> always practical. Crashing the kernel only tests AWUN, and AWUPF (for 
> NVMe).

Yes.  There's some ways to emulate power fail for file system level
power fail testing using dm-log-writes and similar, but that doesn't
help at all with testing the power fail behavior of the device which
we rely on here.

