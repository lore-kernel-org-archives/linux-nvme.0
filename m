Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0F3C54E94
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 16:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vwx9f5w/QJmdjIBkHnN0CrpI29WwYXex8x4+/anrGEI=; b=3Ck9KsATSJ8LOq2G8tkH0HWX0x
	WpWZTMYglcUm/zel2DIYhE3RJYJ5nK/U7Bjjwj0DuldArTLbv5TQ7tYcLmMG+MF4FZwHb7tDcg/Dh
	EPETJIe8hB1cTOKngtliFNOy9zxxl4x0FSpkcYrZws678Ec1xc0lVfr4RpEwaguNhrqyTox8W+WaA
	2bsc0KfpSm+wrPROH+64LtUPPqjT+2cJA2dWtJKNWFNyzIsJHwVqBZXAnYhLqGsthEeRpWNRjsHU4
	GNP2dvMvO6FAVIPPSFd8oLkjtGb/Zq4SYrCi6VIWpjeJ8LX+OU+HJzQZrebE6r9YEHbwr/O9POFdj
	0d39bWXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJzqE-000bu0-22; Mon, 23 Jan 2023 16:38:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJzpv-000blS-Ri
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 16:38:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 208AC68C7B; Mon, 23 Jan 2023 17:38:20 +0100 (CET)
Date: Mon, 23 Jan 2023 17:38:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCHv2] nvme: always initialize known command effects
Message-ID: <20230123163819.GA8009@lst.de>
References: <CGME20230119164739epcas5p17673bc9fb1b91d7c85561af220a230eb@epcas5p1.samsung.com> <20230119164128.2159217-1-kbusch@meta.com> <20230123102431.GA11000@green5> <Y8617zOJDMka7J0h@kbusch-mbp.dhcp.thefacebook.com> <20230123163536.GA7699@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123163536.GA7699@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_083824_090237_32EC81ED 
X-CRM114-Status: GOOD (  21.01  )
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

On Mon, Jan 23, 2023 at 05:35:36PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 23, 2023 at 09:29:35AM -0700, Keith Busch wrote:
> > On Mon, Jan 23, 2023 at 03:54:31PM +0530, Kanchan Joshi wrote:
> > > On Thu, Jan 19, 2023 at 08:41:28AM -0800, Keith Busch wrote:
> > > > +	if (!ctrl->effects) {
> > > > +		ctrl->effects = kzalloc(sizeof(*ctrl->effects), GFP_KERNEL);
> > > 
> > > ctrl->effects is not getting freed if controller does not support the
> > > commands-supported-and-effects log page?
> > 
> > Right. If the controller doesn't support it, the driver will make one up
> > with some sane defaults. The point of this patch is that we don't want
> > to re-construct the defaults for each passthrough command so we need to
> > store the defaults somewhere.
> 
> But it never ends up beeing freed even when the controller is torn
> down as it never gets added to ctrl->cels.

And maybe part of that is the weird double storage.  Can we do away
with ctrl->effects and head->effects and just do the xarray lookup?
The xarray lookup for our normal case will basically add one more
pointer chase and one more cache line that is read.

