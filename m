Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BF8D5B86D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fox0hqmASi/mjZiOjkUKN/WCPshkdEspQfK6MddgCt8=; b=JMLhKI+/Scf3hmjmPc/Kq6NkjE
	VJbNdtOzyNF8006HqF0OAD9pDeY9SMQNT5faVq6U+ggzRsPD8VEnY/cxTh2XyrSAog3NkuiUh5axd
	WmWopnKm8kyyJqkg9V9qZKxRjU0xceEGDPzs4P7NPhKygILB+9iKEt4UHMSkjvqzL3+aYMIMgmPH/
	rqJakvc1jFfFsKT2KllZRPIdTAJ6iOmV3Ux1VyIEopxKYf3sLUOsPAcwKBvO2TaSN5fpm7HPxZCoC
	iOYXmwtspiNPod102C5US530uW6lzOA4vcFKXYOjxbV/YO7M0W2CmzP05bS8eOR/qGsGQWNTj8jSy
	OW+sp/dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6B6o-00000000zFB-3Bno;
	Wed, 30 Oct 2024 15:59:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6AtZ-00000000vgR-11RN
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 15:46:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6AE83227AAC; Wed, 30 Oct 2024 16:45:56 +0100 (CET)
Date: Wed, 30 Oct 2024 16:45:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, bvanassche@acm.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Message-ID: <20241030154556.GA4449@lst.de>
References: <20241029151922.459139-1-kbusch@meta.com> <20241029151922.459139-10-kbusch@meta.com> <20241029152654.GC26431@lst.de> <ZyEAb-zgvBlzZiaQ@kbusch-mbp> <20241029153702.GA27545@lst.de> <ZyEBhOoDHKJs4EEY@kbusch-mbp> <20241029155330.GA27856@lst.de> <ZyEL4FOBMr4H8DGM@kbusch-mbp> <20241030045526.GA32385@lst.de> <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyJTsyDjn6ABVbV0@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_084605_448227_261A2F0D 
X-CRM114-Status: GOOD (  24.73  )
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

On Wed, Oct 30, 2024 at 09:41:39AM -0600, Keith Busch wrote:
> On Wed, Oct 30, 2024 at 05:55:26AM +0100, Christoph Hellwig wrote:
> > On Tue, Oct 29, 2024 at 10:22:56AM -0600, Keith Busch wrote:
> > 
> > > No need to create a new fcntl. The people already testing this are
> > > successfully using FDP with the existing fcntl hints. Their applications
> > > leverage FDP as way to separate files based on expected lifetime. It is
> > > how they want to use it and it is working above expectations. 
> > 
> > FYI, I think it's always fine and easy to map the temperature hits to
> > write streams if that's all the driver offers.  It loses a lot of the
> > capapilities, but as long as it doesn't enforce a lower level interface
> > that never exposes more that's fine.
> 
> But that's just the v2 from this sequence:
> 
> https://lore.kernel.org/linux-nvme/20240528150233.55562-1-joshi.k@samsung.com/
> 
> If you're okay with it now, then let's just go with that and I'm happy
> continue iterating on the rest separately. 

That's exactly what I do not want - it takes the temperature hints
and force them into the write streams down in the driver with no
way to make actually useful use of the stream separation.

