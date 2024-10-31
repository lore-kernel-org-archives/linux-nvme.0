Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA17D74959
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 13:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MIowFYY9CgWfp84izcSR3YvHOG8P8l8d0gx6cO/OelM=; b=w4K6pNdYNT2S4L9jClUPE+J1VM
	QFznaGL6MXbcqlOcHtSttdgMIopH8xK1bUqxsh9mFuxXL7Yf117qxM3xwJErL5rFTqznPXVEf0mYj
	8t5ZRViJ9Tci9gDkwJviDgqhpk3E0/OIaHAKnnOEKScYX/sgK6sgco+vyf4zNNpunKOApNierZogS
	UE4xQsoGXJzuFRMBd3NeHesfpADiVHvDegTZyV7lDrUra/z0R7MxCxDAW2I/LW5V4TKQfTaFsnuYk
	TXhCaUkhT3xU/0QZ2EFd6livnlnl5KR4eSuBBR0UQD23b5sZYuSbU2B1D5lGJsYLUYX2Oz7+x+8H3
	o+jgfy7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Ux8-00000003e6s-1Cc2;
	Thu, 31 Oct 2024 13:11:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6UpJ-00000003chv-0ZzG
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 13:03:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BBFDE68B05; Thu, 31 Oct 2024 14:02:52 +0100 (CET)
Date: Thu, 31 Oct 2024 14:02:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hans Holmberg <hans@owltronix.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	joshi.k@samsung.com, javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <20241031130251.GA17961@lst.de>
References: <ZyEL4FOBMr4H8DGM@kbusch-mbp> <20241030045526.GA32385@lst.de> <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com> <20241030154556.GA4449@lst.de> <ZyJVV6R5Ei0UEiVJ@kbusch-mbp.dhcp.thefacebook.com> <20241030155052.GA4984@lst.de> <ZyJiEwZwjevelmW2@kbusch-mbp.dhcp.thefacebook.com> <20241030165708.GA11009@lst.de> <ZyK0GS33Qhkx3AW-@kbusch-mbp.dhcp.thefacebook.com> <CANr-nt35zoSijRXYr+ommmWGfq0+Ye0tf3SfHfwi0cfpvwB0pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANr-nt35zoSijRXYr+ommmWGfq0+Ye0tf3SfHfwi0cfpvwB0pg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_060301_338526_65EE7664 
X-CRM114-Status: GOOD (  16.64  )
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

On Thu, Oct 31, 2024 at 09:19:51AM +0100, Hans Holmberg wrote:
> No. The meta data IO is just 0.1% of all writes, so that we use a
> separate device for that in the benchmark really does not matter.
> 
> Since we can achieve a WAF of ~1 for RocksDB on flash, why should we
> be content with another 67% of unwanted device side writes on top of
> that?
> 
> It's of course impossible to compare your benchmark figures and mine
> directly since we are using different devices, but hey, we definitely
> have an opportunity here to make significant gains for FDP if we just
> provide the right kernel interfaces.

I'll write code to do a 1:1 single device comparism over the weekend
and Hans will test it once he is back.


