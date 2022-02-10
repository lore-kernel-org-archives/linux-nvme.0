Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0C9EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 18:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O4wMENGS2QYIOyT7HJ7ahvJadkvAVpXGCRk6n975CKY=; b=rV8L1wR06Z3sBmEDVPQEb67Srq
	lX1MBqRyZiCvXOgbDBIPmP6ybx8gILeq8Xo0eRlxGxUSdMeAySMFwhNHPSP1edHBxNOFyBrFxbGqF
	CcoiXYiqPt7ekcZfcs4ktoi8f+Cj29ZztIAK5xiDEfZFHLCsH8FspFM9X8mUyLZaapS3xzR9Pj+IZ
	ztb8EHsA2loW7BVWB22JtXiEnHXEYZMnUDajGaGIUroZScZ6bzafTNu+39pO6kXqcYKkeNIDeTwJn
	aZnRzG5fXlLfNWpaCcqTt4kIdYiEZbXT53bIbpBfQWKxyhqBUoUcYSFHbK2dn0mpXZR9eEAjcavJx
	QBoKgXyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIE7M-004bkv-1C; Thu, 10 Feb 2022 18:24:32 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIE7K-004bkW-2F
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 18:24:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 1A9E968BEB; Thu, 10 Feb 2022 19:24:24 +0100 (CET)
Date: Thu, 10 Feb 2022 19:24:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
 Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 m.heingbecker@googlemail.com, linux-nvme <linux-nvme@lists.infradead.org>,
 Nirmal Patel <nirmal.patel@linux.intel.com>,
 Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: Re: [Bug] nvme blocks PC10 since v5.15 - bisected
Message-ID: <20220210182423.GB16171@lst.de>
References: <CAJZ5v0hvvYedSn5u-i7sjpoEHU4P65t7i1b2pVn=S1q0nHWgqQ@mail.gmail.com>
 <20220121210905.GA1114868@dhcp-10-100-145-180.wdc.com>
 <CAJZ5v0gybg+Wk+008UBFnm2WqrxowOarhst9Eh+91BN823mqNA@mail.gmail.com>
 <20220210145635.GA1617879@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220210145635.GA1617879@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220210_102430_271544_CF54D01F 
X-CRM114-Status: GOOD (  13.39  )
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

On Thu, Feb 10, 2022 at 06:56:35AM -0800, Keith Busch wrote:
> Apparently it works fine when you disable VMD, so sounds like the
> acpi_storage_d3 is set, but we fail to find the correct acpi companion
> device when it's in a VMD domain.

I guess the acpi_storage_d3 is set on the VMD device and we need
to propagate that down the entire bus hanging off it.

Which kinda makes sense in the twisted world where vmd was invented,
given that vmd is Intel's evil plot so that only their Windows driver
can bind to these devices, so the property also needs to be set on
the vmd device.

Nirmal and Jonathan, can you help to sort this mess out?

