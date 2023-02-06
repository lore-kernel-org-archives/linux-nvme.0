Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E21C05027
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Feb 2023 16:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LPlIL/USvxuFmWW8VHK7A7HRMhRsRaYyQFkmBfPpwEw=; b=iYPHzwKDQ9NM7bSehoXg+E7RDf
	PNf/3l2LbtJ6RHLI8CCdYWFe7JaV5x0yE/Tt76I63TTGMmPCvK4prA7cOP8Or3t/mOyvzk6OS8axL
	kxfvvLq8C8RzdGU7Ih4m2cRTYa57xSfM/L8Io7r4Lz0UFuTMXN6wHZmb19E/4gQriulTQOwTsBoAc
	mVY0nXynO9fBNVATv4nTodsS3ob0uREa/EGn5/eLrD4511x4xuLlLJSzSqeOlK0EPmzFIbXjPSJjw
	/jmMH+3xQEQlz+4d8YeOmTwOeRBjDrFC5SfsZwtUhsZMjM/yLRkQzIDI6GWHpAGglPx2V93lc+A34
	qPbvH+Pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP44x-009Dby-5j; Mon, 06 Feb 2023 16:10:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pP3dX-0090CA-Ch
	for linux-nvme@lists.infradead.org; Mon, 06 Feb 2023 15:42:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F66B68C7B; Mon,  6 Feb 2023 16:42:19 +0100 (CET)
Date: Mon, 6 Feb 2023 16:42:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Javier.gonz@samsung.com" <Javier.gonz@samsung.com>
Cc: "Grochowski, Maciej" <Maciej.Grochowski@sony.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"Lewis, Nathaniel" <Nathaniel.Lewis@sony.com>
Subject: Re: [PATCH] nvme-pci: fix resume after AER recovery
Message-ID: <20230206154218.GA12556@lst.de>
References: <Y9kyIzTi6/7hsDsm@kbusch-mbp.dhcp.thefacebook.com> <BYAPR13MB2486C8E796FC7EA0A8C6EAC981D19@BYAPR13MB2486.namprd13.prod.outlook.com> <20230202101818.GB14931@lst.de> <BYAPR13MB2486BFEEFA2D60B9493C84A181D69@BYAPR13MB2486.namprd13.prod.outlook.com> <Y9wSdlJovtGD/GrI@kbusch-mbp.dhcp.thefacebook.com> <BYAPR13MB248665DEEDB9A9B60925655381D79@BYAPR13MB2486.namprd13.prod.outlook.com> <Y9xlPgExhiYuVHts@kbusch-mbp.dhcp.thefacebook.com> <CGME20230203184632eucas1p2d76fa9532b4b505e9bf077b00506ff3a@eucas1p2.samsung.com> <BYAPR13MB2486C2ABA6E7097A86C14D2A81D79@BYAPR13MB2486.namprd13.prod.outlook.com> <20230206140220.6af2b6k7belue2nh@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206140220.6af2b6k7belue2nh@ArmHalley.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230206_074231_599669_DCDDE3D2 
X-CRM114-Status: GOOD (  12.17  )
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

On Mon, Feb 06, 2023 at 03:02:20PM +0100, Javier.gonz@samsung.com wrote:
> Is there a chance we can get a quirk for this for this FW. Seems like an
> issue on our side that is creating problems.

So waht would the quirk look like?  This would have to be something in
the core PCIe code, not NVMe as far as I can tell.

