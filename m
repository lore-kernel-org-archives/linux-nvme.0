Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F2DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jan 2022 07:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=60upxjyxeBYFMHBJsWzuAdZzS7MBQhPTqfGoMIXyAgM=; b=OuY91HIMBM9bqspcoU26v+9E50
	1rAl5uMIFJr3TipIbxQB14tzIKeI9o7eqzM9aHdjlIo5HXPOJbnHK2Oq95cvlLQ3C+v8sJJJEXXkL
	sY0z9MiT20zjAYj0SSsZp31PAZkyu/Nqpprdwc+QD5Yd1gnakld8Kbw0yVB7ZBu5N6XCZocjhg/D5
	St1wsQy2NOw2g+xRLrvp5DPoGjZfcOTucs+M/VB2MSHSIDtwUZ8v3J0TflaxMoseReBFo2w8u2KxK
	nXRctPTvsnSNBUbvZDnRuXj272o6u3akSPRSBLxxWibMFDgcpAHNakHXbUr0YCqX0FEDotyS+Bljk
	e5BgdYdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n7Xsd-001NsD-A7; Wed, 12 Jan 2022 07:17:11 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7Xsa-001Nqw-F9
 for linux-nvme@lists.infradead.org; Wed, 12 Jan 2022 07:17:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2531368AFE; Wed, 12 Jan 2022 08:17:00 +0100 (CET)
Date: Wed, 12 Jan 2022 08:16:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Rajat Jain <rajatja@google.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Mark external NVMe devices as removable
Message-ID: <20220112071659.GA4502@lst.de>
References: <20220112013154.1210480-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112013154.1210480-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220111_231708_697229_92B0AF8E 
X-CRM114-Status: GOOD (  11.29  )
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

On Wed, Jan 12, 2022 at 09:31:54AM +0800, Kai-Heng Feng wrote:
> Commit c037b6c818c3 ("PCI: Add sysfs "removable" attribute") can mark
> entire Thunderbolt hierarchy as removable, if system firmware provides
> correct attribute.
> 
> So apply GENHD_FL_REMOVABLE for NVMe if removable bit is set, to make
> userspace daemon like Udisks knows it can be automount.

GENHD_FL_REMOVABLE means removable media as in floppies or CD-ROMs,
which does not apply to NVMe at all.

