Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E15C07CB1
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 16:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FYybJ3/eV+hh/TvadtemFGwdudaTBIH0r1daSQ1Uaxw=; b=JYGWKYQaStqTaAep+2/NED+tJ9
	a9R3B/hkbj1Edq2qeIMra7F6LpjNTDkAcXt9xMFxDcnK3c3bpDGBYltt2AryL5g+ANAuS3aOPbIXc
	WGU17kTDcFJEEoNbVgKoLvk214/OrwTefFxWp/GXqOsJJ1vVatxcibigmGJnrx+48QZ3xgMoYtRGD
	Iuetam4WbWXSjs4prSI0M6rxSyN09zgdm1rhjgEYVh1HMFDd7gcY8gN1jCOG6fwYS8dl4jpW2WaGq
	GIDVp/lzgqqZDt2FUDvAUF1fGpR2zcofWsX0IOB732e1Zz6zWPp/dgcRDazSs2DjGMMh2Y8wmXy9P
	s6ArEEIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7eYH-0030cQ-2A;
	Mon, 27 Nov 2023 16:33:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7eYE-0030ZM-0M
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 16:33:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 89A7C67373; Mon, 27 Nov 2023 17:33:33 +0100 (CET)
Date: Mon, 27 Nov 2023 17:33:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <20231127163333.GA2273@lst.de>
References: <20231127103208.25748-1-dwagner@suse.de> <20231127141857.GA25833@lst.de> <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com> <20231127155649.GA1403@lst.de> <ZWTEFvYbI1bFTXyZ@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWTEFvYbI1bFTXyZ@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_083338_313039_E778B36C 
X-CRM114-Status: GOOD (  18.12  )
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

On Mon, Nov 27, 2023 at 09:30:14AM -0700, Keith Busch wrote:
> > > Should this even be an nvme specific attribute? I thought we should have
> > > blk-integrity.c report its 'tuple_size' attribute instead. That should
> > > work as long as we're not dealing with extended metadata at least, but
> > > that's kind of a special format that doesn't have block layer support.
> > 
> > Reporting the tuple size is a good idea.  But is that enough for
> > the existing nvme-cli use case?
> 
> nvme-cli currently queries with admin passthrough identify command, so
> adding a new attribute won't break that. I assume Daniel would have it
> fallback to that same command for backward compatibilty if a desired
> sysfs attribute doesn't exist.

Yes.  But does it care about the tuple size, or the actual size of the
metadata field even if is bigger than the PI tuple?

