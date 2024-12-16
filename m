Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C627E7717F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 16:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u0UNzOfWZeJRJ1OOlRdob0AkneS1135Q5X3pszp7vpk=; b=nVeAMRksGfYxMZQ6XUVnn4V2hZ
	dJAcWqB7Dwo8cbMdHXQ8QsjcN3qkLKs7zFjL3eID04eqv1jgJT3OPQc+wstary1cCPScp14vNzhOJ
	LvMSH8TESYEwoBfrOASnwbIDcNPrBxiGXVDOoG1PNcQEgrsSvHxz2l8qA1iKM51qXsMUtQoQOQH1l
	85/rAdZdCrXFgMWvgqnsVarAyXG27+gHwzeXTwQXniNPUBg1jGM7ykmGac8oMZj97DlWuGp63mgCY
	xbi3dAXL4Ba5TMHNMtsVvSM9xQlgHwrRha6K6Q4fMaK1g2GVQE16jDHvJDts7KzOgLTis0q8DYVoi
	Kc1NrCSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDsF-0000000AZDx-0miy;
	Mon, 16 Dec 2024 16:23:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNDsD-0000000AZDK-1dnL
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 16:23:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B958768C4E; Mon, 16 Dec 2024 17:23:03 +0100 (CET)
Date: Mon, 16 Dec 2024 17:23:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org,
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241216162303.GA26434@lst.de>
References: <20241205232900.GA3072557@bhelgaas> <20241209143821.m4dahsaqeydluyf3@thinkpad> <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net> <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com> <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com> <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214063023.4tdvjbqd2lrylb7o@thinkpad>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_082309_573251_A66B6E32 
X-CRM114-Status: GOOD (  13.46  )
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

On Sat, Dec 14, 2024 at 12:00:23PM +0530, Manivannan Sadhasivam wrote:
> We need a PM core API that tells the device drivers when it is safe to powerdown
> the devices. The usecase here is with PCIe based NVMe devices but the problem is
> applicable to other devices as well.

Maybe I'm misunderstanding things, but I think the important part is
to indicate when a suspend actually MUST put the device into D3.  Because
doing that should always be safe, but not always optimal.


