Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A96CF34A4
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 12:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=96iEHQmDVGwgp+r0+N9QLEVlS4W9gf1TYTlZDSfvOFQ=; b=Pf5ksRiWjHKTq/It5xGfwBqBOH
	ZuuTFzH1ebFD9iVHyub6aAFF3GAcQODinf+4MMK4D7SzbtYF2CNGKdA81hGKB66QLVter8DEvUUZx
	JmBIXVCHqVrRXTOGo+IyNHshb6pwdKZNL9ljrgW22Mt230HcRW5sPVq4RPQA7rAcL3vAd7m5w7Rdn
	h5eXzAXoRW5fz3ewAhohdfK+Deay5GpWnM99bEV1Z+u8OQIJ9nGDVa3u+2KXZGfhRZvWbfMCZwRSP
	S/K00Zh/pjg1fhCSK6MfMK5v7CGRJEYi8TGCKWortZqtEDaw5uQ7rDQUosaAQ99h4Lah2ryLo6LX6
	XigZz1kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swLIb-000000094Ln-2VE5;
	Thu, 03 Oct 2024 12:51:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swLIY-000000094LM-3s6R
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 12:51:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C6AE6227A88; Thu,  3 Oct 2024 14:51:10 +0200 (CEST)
Date: Thu, 3 Oct 2024 14:51:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Kanchan Joshi <joshi.k@samsung.com>, hare@suse.de, sagi@grimberg.me,
	martin.petersen@oracle.com, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241003125110.GA17031@lst.de>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com> <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de> <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk> <20241002075140.GB20819@lst.de> <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk> <20241002151344.GA20364@lst.de> <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com> <20241002151949.GA20877@lst.de> <Zv1nvIcENHnBcd2G@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zv1nvIcENHnBcd2G@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_055115_129173_F38207B8 
X-CRM114-Status: GOOD (  14.62  )
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

On Wed, Oct 02, 2024 at 09:33:16AM -0600, Keith Busch wrote:
> You remember right. I also explained the use cases for per-io hints are
> to replace current passthrough users with generic read/write paths that
> have all the memory guard rails, read/write stats, and other features
> that you don't get with passthrough. This just lets you accomplish the
> same placement hints with the nvme raw block device that you get with
> the nvme char device.

Yes, and as I said before we need an opt-in from the file_ops, because
file systems can't support this.  And I'm speaking that from a position
of working on a file system that made the existing non-idea hints
work (to all fairness Hans did the hard work, but I was part of it).

