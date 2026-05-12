Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D406CD4851
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2026 06:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eZAruczZ/XZ7XcnBnviefmBw3M84MvDK7lfbPNAeEs0=; b=S8iC+jsh4he6i6/Pe2ZToJkIkm
	KqMVnlDSPr8Tjli16jCBYMeEAAgSWqXw4Ok22em1D+k4tCfgy/59U0N6Euzb5yqAWySU/+43fiN8g
	mzni4TB/9kYyTvm/5U/xbaEdEu/+h6rp+B9sxIn3+Ry9NjcYlIcS347s1Wa6Qrxs4atJ8QgdmLkQx
	/Kp8OJHlO8mSxIHsUjbjLjNrwecu8X2BfZQjeR7zXyWSdQJ08mOgD9D/R4G3xSzNT0i03oSoxL+xq
	dSz+NoY9BOPSsDn6OiLJ3u+sHSShpZZ1HQY8SAcu0xBwTy4SUL+Os7nyK1zHVet08VQ07LwrT7qgm
	sncW9/NQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMgC6-0000000FiXN-0ACh;
	Tue, 12 May 2026 06:02:14 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMgC3-0000000FiWP-0JAW;
	Tue, 12 May 2026 06:02:11 +0000
Date: Mon, 11 May 2026 23:02:11 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
	AlanCui4080 <me@alancui.cc>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: make providing NGUID as UUID usage less scary
Message-ID: <agLCYzpeWXgLF3lH@infradead.org>
References: <UPNVP7_KTI2VieaAyBtUMA@alancui.cc>
 <73735bc1-9821-42d8-9594-1e9cdb03e15a@grimberg.me>
 <agGQZU4NwAgSzHLD@infradead.org>
 <agHsTnBOgkadTqkp@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agHsTnBOgkadTqkp@kbusch-mbp>
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

On Mon, May 11, 2026 at 08:48:46AM -0600, Keith Busch wrote:
> On Mon, May 11, 2026 at 01:16:37AM -0700, Christoph Hellwig wrote:
> > [the patch seem to be missing some maintainer Ccs]
> > 
> > On Mon, May 11, 2026 at 01:19:59AM +0300, Sagi Grimberg wrote:
> > > TBH, I'm not sure why should this be a warning or an info log. This looks
> > > like a debug print to me.
> > 
> > It is worse.  For some reason the commit seems to imply the uuid
> > replaces the nguid and they can be intermixed.
> > 
> > We really need separate sysfs files for the different ids.  I gues we
> > need to keep the existing one someone, but it is a mess.
> 
> Yes, sorry for the unpleasant situation this is. The attributes were
> rushed into the driver at the time.

I'm not trying to put blame.  But I think we need to sort this out
somehow - plenty of devices ship without a uuid and a system log
warning is not useful.  So I guess we need to slowly deprecate this
attribute and add proper ones for nguid/uuid.  But I can't really come
up with good names for them.

