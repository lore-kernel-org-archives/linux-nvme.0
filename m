Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D56C05027
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 17:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TNiHk5nv7vAyGt0ZyZf9OdgdQ5Fl13b2FdiYpQM5hgg=; b=CiW3T6HTmFU7N6FpLQpht5cxIr
	+9/gnuZ/Jglm8SkiMgLwolaKSEDXftpH/8QOpTLjzy/fFQBOggyYOmT9X8t4kZQg5Mdx3twR5Troz
	rPMuGtG6y5iGVagNzudEN6H8Gg6KIu9wYaFHEGNLShAt11GHtG5yiBM6oYGAe6Xq3DwZVLfoJsgnG
	M0obsktIh1ZzUfec4HShb3ys8C6CJuFEuDjnAqQWMnsM6LTs/qraPHii2AZTZPE/lILz67hJZzV5w
	LbCiW5bEw3sVbfPaAI9ZWsD90Ry3cm4HICoF/aLhgIuG4zb24fE8rcO0JBuVM5lFKrtgr4yuKbJFd
	qxr9SnfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK0qN-000u8H-CM; Mon, 23 Jan 2023 17:42:55 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK0qK-000u7Q-Jy
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 17:42:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id 70248CE13DD;
	Mon, 23 Jan 2023 17:42:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552C6C433EF;
	Mon, 23 Jan 2023 17:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674495768;
	bh=Ws590V69ZhRKstwpPxR5OQ3zCRJghdb/eEdQXPHemnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEXOTwbTTFYtlH0E5VEQWbzF2hx1VT2tjGDSA3Tsq5fDNFfETjQP2MdZjpMdCUAnl
	 gNq/+qh6g1JFNLjirtBXXt24QWr3QAmfs0v96knwGkcQBF0puo29L2pIaM+e55WZk2
	 FpfsKLSlwJCp+/dY4767b+gdEPj+62SkD8Ac+YKwAZkNzAy8jxK92M450xR/vd2xOL
	 AxytcfAZSol9cAhuwEQEKgZTGnARuMXC6zmSUJ6InmLNiq9RqWz5w4aPlKjjRToyJz
	 1laGKP7o7Z0pUBMN611LZuTcboe5KCmOr108+d5elhgUNXHMZvfsFqgCXnOC+br4U8
	 a0az+OjdKqZyQ==
Date: Mon, 23 Jan 2023 10:42:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCHv2] nvme: always initialize known command effects
Message-ID: <Y87HFanyksHLp7BO@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20230119164739epcas5p17673bc9fb1b91d7c85561af220a230eb@epcas5p1.samsung.com>
 <20230119164128.2159217-1-kbusch@meta.com>
 <20230123102431.GA11000@green5>
 <Y8617zOJDMka7J0h@kbusch-mbp.dhcp.thefacebook.com>
 <20230123163536.GA7699@lst.de>
 <20230123163819.GA8009@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123163819.GA8009@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_094252_862174_B5DB5577 
X-CRM114-Status: GOOD (  25.39  )
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

On Mon, Jan 23, 2023 at 05:38:19PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 23, 2023 at 05:35:36PM +0100, Christoph Hellwig wrote:
> > On Mon, Jan 23, 2023 at 09:29:35AM -0700, Keith Busch wrote:
> > > On Mon, Jan 23, 2023 at 03:54:31PM +0530, Kanchan Joshi wrote:
> > > > On Thu, Jan 19, 2023 at 08:41:28AM -0800, Keith Busch wrote:
> > > > > +	if (!ctrl->effects) {
> > > > > +		ctrl->effects = kzalloc(sizeof(*ctrl->effects), GFP_KERNEL);
> > > > 
> > > > ctrl->effects is not getting freed if controller does not support the
> > > > commands-supported-and-effects log page?
> > > 
> > > Right. If the controller doesn't support it, the driver will make one up
> > > with some sane defaults. The point of this patch is that we don't want
> > > to re-construct the defaults for each passthrough command so we need to
> > > store the defaults somewhere.
> > 
> > But it never ends up beeing freed even when the controller is torn
> > down as it never gets added to ctrl->cels.
> 
> And maybe part of that is the weird double storage.  Can we do away
> with ctrl->effects and head->effects and just do the xarray lookup?
> The xarray lookup for our normal case will basically add one more
> pointer chase and one more cache line that is read.

xarray lookups are pretty slow in comparison, though. This is in a fast
path now, so I think we need to keep caching it.

Alternatively, we could replace the xarray with a normal array sized to
highest seen CSI. Realisitically, I don't think we'll see a CSI higher
than 3 any time soon, so it wouldn't take up much space.

