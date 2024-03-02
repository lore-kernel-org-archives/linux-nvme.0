Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAE7C54798
	for <linux-nvme@archiver.kernel.org>; Sat,  2 Mar 2024 14:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yZDhAHqUrs7e8GTQhNJcQbMerccoAu6Wc2bvM4FJQtM=; b=bB7FRe6iSopDwgq7WL3mDunhgS
	99K3f0cyUWM74fcHc6wBhwwyyyiQj1XuYHcBgWS/FYm9g8mBvIrt3qd1SYVlDypw9CLRnK4dDqhAw
	7zmjz/DnSLhHfzuGXZoWTYHwxF0NTb/6re9q/qlsHj1i7n/W481kYVkBs3dlQ0LHDUdXCsCPYigdC
	fE7/oZMqhJdG6/mLLNGfQVwGIRN5I4CKJIsILFum24cVbfFmKK9L913RKB35kBiHvdve4YpOdO2Nn
	FOyF2d/w66ZBK8KaobIGYfysZIn12QItytu9N2+oi7iHC6GQcpb+muYx151F8TufpHP1fxraGfbx6
	IUTr81cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgPuM-00000003g9q-1sKu;
	Sat, 02 Mar 2024 14:00:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgPuG-00000003g7a-0GM2
	for linux-nvme@lists.infradead.org;
	Sat, 02 Mar 2024 14:00:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 808A767373; Sat,  2 Mar 2024 14:59:54 +0100 (CET)
Date: Sat, 2 Mar 2024 14:59:54 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>, Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: convert nvme to atomic queue limits updates
Message-ID: <20240302135954.GA1072@lst.de>
References: <20240228181215.873854-1-hch@lst.de> <ZeIAT5uY36cLkVpJ@kbusch-mbp.mynextlight.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeIAT5uY36cLkVpJ@kbusch-mbp.mynextlight.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240302_060004_267555_9D276A6A 
X-CRM114-Status: GOOD (  18.55  )
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

On Fri, Mar 01, 2024 at 09:20:31AM -0700, Keith Busch wrote:
> On Wed, Feb 28, 2024 at 10:11:54AM -0800, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series converts nvme to the new atomic queue limit updates, and
> > as part of that refactors a lot of the setup code.  The first two
> > patches are block layer patches already sent out as part of the md
> > queue limits conversion and will hopefully get merged into Jens' tree
> > soon.
> 
> The whole series looks good. I see Jens has got the first two patches,
> so I'll rebase nvme-6.9 to that and apply the rest of the nvme patches.

I had to fix up the little thing Max noticed an also added another
patch for multuipath.  I'll resend with those updates once you
rebased.

