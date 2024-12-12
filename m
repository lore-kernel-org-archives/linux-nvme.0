Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29137E7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 05:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pzbw2bn6lq4KjIErYdBWT6szT38dDbl+IfFs5Xg79AI=; b=hSn9mfYvJKzGN6y/cLbZHf6zyZ
	Qea8WLVGlaHdyz9Hgqn3YC4YGfs71HZgQ2pqtKWjqYzwyRsHJawMN+0oveR4z2lUdw+JAyezasT87
	EnH/L8NJI546P6kQB/cZ2fRXuePVqRYeq4uJckHRkwVatXCViRsd6jc817wz1eWsfKeaITQOpMhMN
	WDp6CXz0l99qPU8T1h+jddlfPHFDN4QzkP3Cgdx5gvi4CvB5PnvVMKpZCDJtsxRYJSAZ6YbjwyOPJ
	PEjOaetqJuD26Y1W6kcDXFPVxJUVrBi9+24GgfqjEtKpsUsyjznV7Tw51OTOXZkbOFkcd4ZPwjnVD
	JSLcjEIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLcEQ-0000000GzeE-3fN3;
	Thu, 12 Dec 2024 05:59:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLcEO-0000000Gzdm-1Q2o
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 05:59:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7EED568D07; Thu, 12 Dec 2024 06:59:20 +0100 (CET)
Date: Thu, 12 Dec 2024 06:59:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241212055920.GB4825@lst.de>
References: <20241205232900.GA3072557@bhelgaas> <20241206014934.GA3081609@bhelgaas> <20241209133606.GA18172@lst.de> <20241209143821.m4dahsaqeydluyf3@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209143821.m4dahsaqeydluyf3@thinkpad>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_215924_515161_883E7908 
X-CRM114-Status: GOOD (  22.62  )
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

On Mon, Dec 09, 2024 at 08:08:21PM +0530, Manivannan Sadhasivam wrote:
> > 
> > The istory here is the the NVMe internal power states are significantly
> > better for the SSDs.  It avoid shutting down the SSD frequently, which
> > creates a lot of extra erase cycles and reduces life time.  It also
> > prevents the SSD from performing maintainance operations while the host
> > system is idle, which is the perfect time for them.  But the idea of
> > putting all periphals into D3 is gaining a lot of ground because it
> > makes the platform vendors life a lot simpler at the cost of others.
> 
> No, I disagree with the last comment. When the system goes to low power mode
> (like S2R/hibernate), it *does* makes a lot of sense to put the devices into
> D3Cold to save power.

Yes.  That's what the pm_suspend_via_firmware call in nvme_suspend is
supposed to catch.  If that is not the right way to check for a
non-runtime suspend we'll need to improve the interface.  Which really
are a mess, and the last thing I want is more "intelligence" in the
drivers.  We need go information from the PM core what is going on so
that things work out of the box.  Overloading obscure sysfs files with
new logic queried from a driver is a complete no-go.

> The current reality is that most of the devicetree platforms *do* want to power
> down the NVMe during suspend. Only when NVMe is used in an OS like Android, we
> might not want to do so (that's something for future, but still a possibility). 

So fix the bloody interface instead of piling up hacks in drivers.


