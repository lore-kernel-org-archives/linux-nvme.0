Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A72CCD6E4C
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jun 2026 07:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p1SJzXxY2u9L5GvhpaKSoycutsl+0AYMgIYio8M5mH8=; b=X1vVCBdWv7/hu3biWcluRh/fJ3
	IVNRC+w7/NvZuDiT1MpuvCaei3V1s7opr140GE+sq8dXBjpBHoJxwz4U9NSdoXpU5mcOPq/Npt9lp
	kCaQrQjD0Yq8vFmo+6rNHTHU/i3fTynEQU0nF5gJuIMUWxM6Wk+T217+NHBbF309gQUFnEWMqTsX1
	H7Cfg4kfhrmlJnUAF2fZpiHT7rVOulOriMDYg09R8wFGmk8N/2+M8HxSUKQ/WtgIOYdTMqRD+DkWg
	kOGa8KbekDHVPXaMfkr75wg16w7ZD9TYRU8Sr6HXIORYS01qAR0uasH+QBpangGKhAVbZWwcigmdE
	4ZCSl10A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwpo-0000000AHhl-45qc;
	Mon, 01 Jun 2026 07:13:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wTwpm-0000000AHgy-0Ckj
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jun 2026 07:13:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7797A68BEB; Mon,  1 Jun 2026 09:13:11 +0200 (CEST)
Date: Mon, 1 Jun 2026 09:13:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: hexlabsecurity@proton.me
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Greg KH <gregkh@linuxfoundation.org>, sagi@grimberg.me,
	kch@nvidia.com, "bvanassche@acm.org" <bvanassche@acm.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] nvmet: fix pre-auth out-of-bounds heap read in
 Discovery Get Log Page
Message-ID: <20260601071311.GB7533@lst.de>
References: <Q8CVAA098pa1LIPOSNGvR2qrzqdOBQqRTLK54O4KsGMzSh4IOT2Ucrlv87C0ULvpILYim-FotD-OumzPcjFauZM2iyjJ4tjzaMRsXE7G_3Q=@proton.me> <20260527132353.GB11071@lst.de> <QQhn1zPqAyjwS7XXM_jeFtjpyW7pXcVTGMP38boMl6zWR5ehel-nsdJdksZf0ASO03qt5pX1B5UAnlANuO7KZISSgggAjnjLruly7nAjJ2A=@proton.me> <20260528083537.GA7590@lst.de> <39YwPS5jntghiVQLt9ikZnmMc7O2g1AY3OVDcxdZjaK53FZHyzQNmyaS5eYBTS93g0Wc-S-UDC0auDRcGgC4iMR5RgXLEBPvqHfFZfbaeoU=@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39YwPS5jntghiVQLt9ikZnmMc7O2g1AY3OVDcxdZjaK53FZHyzQNmyaS5eYBTS93g0Wc-S-UDC0auDRcGgC4iMR5RgXLEBPvqHfFZfbaeoU=@proton.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260601_001314_252337_7A01CEA7 
X-CRM114-Status: GOOD (  10.45  )
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

On Thu, May 28, 2026 at 04:02:17PM +0000, hexlabsecurity@proton.me wrote:
> Suggested-by: Christoph Hellwig <hch@lst.de>

My only suggestion was for a slight cleanup to the flow, so I don't think
this tag makes sense.

The patch itself looks fine, though:

Reviewed-by: Christoph Hellwig <hch@lst.de>


