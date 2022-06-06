Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F531C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jun 2022 06:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hWQ11zN6+QeYeDbRx/qX9fS1bgedji/36Ds1YPi6WVk=; b=htgATZpTtxbugIEGLXJW1QVV0v
	tl2iuJKBfiysCX5ok67wO/DX3gpVMhjz/bGJhjPVKur/D40txfOh/2Um+pXUgkn/bR660hWfOIXnv
	RgTfT99zstNletJFTyX90K2IKf8SJOY2WgDGVOA1Szd1SJOvBFZsQ9WVzHUmd+e8Wj9EoIFH768j9
	G/jgOcyJPhay09D4g96p73OAdeBodT9nGY/syZS/bEF81LGO/QhKzvnb6alLXrVgx9b47MXkXaWG2
	uhOKihYbQMnKihhvPy2ZogJCEAv+Ma1a0Ix96hj0EH/G3pnROfMk25WgHiuaoGtDWsHnj8SMa+nbv
	ffshfTxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny6aK-00HR9V-Gv; Mon, 06 Jun 2022 06:51:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ny6Zv-00HQxe-Ag
	for linux-nvme@lists.infradead.org; Mon, 06 Jun 2022 06:51:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6555868AA6; Mon,  6 Jun 2022 08:51:03 +0200 (CEST)
Date: Mon, 6 Jun 2022 08:51:02 +0200
From: "hch@lst.de" <hch@lst.de>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc: Keith Busch <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
	"hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Caroline Subramoney <Caroline.Subramoney@microsoft.com>,
	Richard Wurdack <riwurd@microsoft.com>,
	Nathan Obr <Nathan.Obr@microsoft.com>
Subject: Re: [PATCH v2 2/2] nvme: handle persistent internal error AER from
 NVMe controller
Message-ID: <20220606065102.GA2551@lst.de>
References: <1654278961-81423-1-git-send-email-mikelley@microsoft.com> <1654278961-81423-2-git-send-email-mikelley@microsoft.com> <Yppfm5n41NEcrRlU@kbusch-mbp.dhcp.thefacebook.com> <PH0PR21MB3025781A702070304BB8A282D7A09@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB3025781A702070304BB8A282D7A09@PH0PR21MB3025.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220605_235107_561987_7931F844 
X-CRM114-Status: GOOD (  17.20  )
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

On Sat, Jun 04, 2022 at 02:28:11PM +0000, Michael Kelley (LINUX) wrote:
> > driver's irq handler. The other transports block on register reads, though, so
> > they can't call this from an atomic context. The TCP context looks safe, but
> > I'm not sure about RDMA or FC.
> 
> Good point.  But even if the RDMA and FC contexts are safe,

For RDMA this is typically called from softirq context, so it is indeed
not save.

> if a
> persistent error is reported, the controller is already in trouble and
> may not respond to a request to retrieve the CSTS anyway.  Perhaps
> we should just trust the AER error report and not bother checking
> CSTS to decide whether to do the reset.  We can still check ctrl->state
> and skip the reset if there's already one in progress.

Yes, that might be a better option.

