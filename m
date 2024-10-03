Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B03CF34A4
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Oct 2024 12:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uOdV0+1UDVaPwjphO80hdAPe5x8G/U2lPI9yeaPyTyE=; b=thqPu5a2ZSA964MOSzRrNq4121
	0QKCxHItHo+eq6ISSN21sXljHa0vgn+oRgx9oAYFgEccPrfIzsrNDQjA/zg8UAZxabnhcOFC5ckhV
	ds7X7bE9Mz89qt6BZvfHaPdAR+KMgsF/DyFaEV6O3s5WUANYioQB98q4WMCvWmJcqXyjjRVLjYWd7
	mZ/sazjq33kG0t0iatZ0X/vkQdlLPLezTlp7eSm+jsLfrOmGVTIHX1W99oWcGeFod9iAq+N2TyA3g
	Z1gmWCF/8jJ8NrlTccD0PlGSp5RDoNBpywTOzo7+CQbJwQs4aZYmDPwskMR6aCAlwI1PmxQaYr7n7
	KJ+DTHkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swLLM-000000094hI-37Ga;
	Thu, 03 Oct 2024 12:54:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swLLK-000000094gr-0AHt
	for linux-nvme@lists.infradead.org;
	Thu, 03 Oct 2024 12:54:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2BB8A227A88; Thu,  3 Oct 2024 14:54:01 +0200 (CEST)
Date: Thu, 3 Oct 2024 14:54:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
	hare@suse.de, sagi@grimberg.me, brauner@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org,
	bcrl@kvack.org, dhowells@redhat.com, bvanassche@acm.org,
	asml.silence@gmail.com, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-aio@kvack.org,
	gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
Message-ID: <20241003125400.GB17031@lst.de>
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com> <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de> <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk> <20241002075140.GB20819@lst.de> <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk> <20241002151344.GA20364@lst.de> <Zv1kD8iLeu0xd7eP@kbusch-mbp.dhcp.thefacebook.com> <20241002151949.GA20877@lst.de> <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq17caq5xvg.fsf@ca-mkp.ca.oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241003_055406_249169_8699FD25 
X-CRM114-Status: GOOD (  23.65  )
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

On Wed, Oct 02, 2024 at 11:47:32AM -0400, Martin K. Petersen wrote:
> It is the kernel's job to manage the system's hardware resources and
> arbitrate and share these resources optimally and fairly between all
> running applications.

Exactly.

> What irks me is defining application interfaces which fundamentally tell
> the kernel that "these blocks are part of the same file".
> 
> The kernel already knows this. It is the very entity which provides that
> abstraction. Why do we need an explicit interface to inform the kernel
> that concurrent writes to the same file should have the same
> "temperature" or need to go to the same "bin" on the storage device?
> Shouldn't that just happen automatically?

For file: yes.  The problem is when you have more files than buckets on
the device or file systems.  Typical enterprise SSDs support somewhere
between 8 and 16 write streams, and there typically is more data than
that.  So trying to group it somehow is good idea as not all files can
have their own bucket.

Allowing this inside a file like done in this patch set on the other
hand is pretty crazy.

> Whether it's SCSI groups, streams, UFS hints, or NVMe FDP, it seems like
> we are consistently failing to deliver something that actually works for
> anything but a few specialized corner cases. I think that is a shame.

Yes, it is.  And as someone who has been sitting in this group that is
because it's always someone in a place of power forcing down their version
because they got a promotіon, best of show award or whatever.


