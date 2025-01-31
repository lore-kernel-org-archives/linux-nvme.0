Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFD4C02193
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jan 2025 10:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n+6Opg2sWKZi1i/f0EQybXqGdVG9KIl4q+Jc2rxwf7M=; b=FFh5+hGK+GO+6L1tBmjSr86Yql
	DtPRdmmW0bUCkB0NJkBTQk0MbRpzCZzUo9P/wnZbQ/JflJIZtfmtz79shRIzdLGH2FxQwUVFql01p
	rhqpBpwWXFLuYXuSklf6At/138rRXEeX6kRU/Xjd8Mjv81LxpjzUR2sTKwxKOWwI8TpnHPE8bY7iy
	mRNFH+nFFn/H+FNq4rnW40QR9+MnWUZA8TVqUlBoHotxQqKDGobh7KVxC65Xu8F8CHERRYnod1Qrb
	WkqQ9BwEaKYUh4o1uhFDhiw2GaP1YTxp6Kl7Uz19myqVjGfr2UxL3CqoFpbfpdBSxTbdnzNTxrS25
	5CJ897iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tdoYK-0000000AQVX-2ruc;
	Fri, 31 Jan 2025 10:47:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tdoUP-0000000AQ3J-1lli
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jan 2025 10:43:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 557D568C4E; Fri, 31 Jan 2025 11:43:00 +0100 (CET)
Date: Fri, 31 Jan 2025 11:42:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, josef@toxicpanda.com, dsterba@suse.com,
	clm@fb.com, axboe@kernel.dk, kbusch@kernel.org,
	linux-btrfs@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC 0/3] Btrfs checksum offload
Message-ID: <20250131104259.GA20153@lst.de>
References: <CGME20250129141039epcas5p11feb1be4124c0db3c5223325924183a3@epcas5p1.samsung.com> <20250129140207.22718-1-joshi.k@samsung.com> <20250129153524.GB5356@lst.de> <b5fe3e15-cd7f-41ce-9ac8-70dca0fee37a@samsung.com> <20250130125306.GA19390@lst.de> <12ee6895-aafe-491e-8dea-c024a2a34563@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12ee6895-aafe-491e-8dea-c024a2a34563@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250131_024309_600021_17AFD920 
X-CRM114-Status: GOOD (  16.77  )
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

On Fri, Jan 31, 2025 at 03:59:17PM +0530, Kanchan Joshi wrote:
> > Also if you trust the device to get things right you do not
> > need to use PI at all - SSDs or hard drives that support PI generally
> > use PI internally anyway, and PRACT just means you treat a format
> > with PI like one without.  In other words - no need for an offload
> > here, you might as well just trust the device if you're not doing
> > end to end protection.
> 
> Agree that device maybe implementing internal E2E, but that's not a 
> contract to be honored. Host can't trust until device says it explicitly.

But you're not doing end to end protection.  Once you set PRACT you
basically tell the device to pretend the LU/namespace was formatted
without protection information.  That fact that you even need the
flag has always been very confusing to me - the logical way to expose
PI would have been to make PRACT the default and require a flag to
actually look at the passed information.  I suspect for SCSI this
is a result of shoe-horning DIF and DIX into existing infrastructure,
and NVMe then blindly copied much of that without thinking how it
fits into an architecture without a separate HBA and without all
the legacy concerns.


