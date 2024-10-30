Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E34AD6B6B7
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 17:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PIB9RYk1bAbv6lxNIWn5Tk1s90F0K0OHGvXA1/PGQys=; b=GbnyZbi3o3zbRtYT8t0LmpMOwF
	cE4nYFtaYtrCCeOfT5Q+TrX1BZKoqL65+1WOHItLPuAHP6mQOTz1CwlA9qmzXZK1kRnXYBnKLCMPo
	YK1T1FdjCwqeza0OLzjiimbHPUshSk/3uq2/9xW6xKvtFygsMf8w43Qema8H6Yr9xcKUop+7W2cwa
	5Eai4C1/gkVmXimdjjm3EOFAjG39EQzyahtOtWmIiEmJaP8/A3Ewo8mT4G1s+22yRknAKxaNLf+5V
	Nbk/LZRq/m7FaRTTIW+eD3LNpxk/2OwtyqANcSPtVrC+MR58+d5ppSLEckWbSTYPetXY47tDl7XzX
	01DMYpjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6CIk-00000001EQs-2zp1;
	Wed, 30 Oct 2024 17:16:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6CIM-00000001EJm-0Bvc
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 17:15:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B10FB227A8E; Wed, 30 Oct 2024 18:15:41 +0100 (CET)
Date: Wed, 30 Oct 2024 18:15:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <20241030171541.GB12580@lst.de>
References: <20241029155330.GA27856@lst.de> <ZyEL4FOBMr4H8DGM@kbusch-mbp> <20241030045526.GA32385@lst.de> <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com> <20241030154556.GA4449@lst.de> <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com> <20241030155052.GA4984@lst.de> <ZyJiEwZwjevelmW2@kbusch-mbp.dhcp.thefacebook.com> <20241030165708.GA11009@lst.de> <ZyJnPwqIufrcMkFg@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyJnPwqIufrcMkFg@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_101546_272287_431426AF 
X-CRM114-Status: GOOD (  14.37  )
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

On Wed, Oct 30, 2024 at 11:05:03AM -0600, Keith Busch wrote:
> On Wed, Oct 30, 2024 at 05:57:08PM +0100, Christoph Hellwig wrote:
> > And once it uses by default, taking it away will have someone scream
> > regresion, because we're not taking it away form that super special
> > use case.
> 
> Refusing to allow something because someone might find it useful has got
> to be the worst reasoning I've heard. :)

That's not that point.  The point is by locking us in we can't actually
do the proper thing.  And that's what I'm really worried about.
Especially with the not all that great numbers in the success story.

