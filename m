Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C90F3383D
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 14:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zbh2USkipkXYHyBaw5hpNckUGgzJmL38MwMMfwOdVkI=; b=IzBsO2/+A4ALT86io6VUfcUlIp
	vb/jOmkZJm90l2Z899RztdpKRSMAxjWM44PaTKBB6zFKkXyiz6kVtWeJj+rA6DXj3gicvska2F7KP
	OKi31HB89Q5CwS//OkgQDARObXX9WA7erIGzAfDBrmcOwyxNoLwtJeJejUAaIQrXsg0SgY+HwQqE8
	R43KhwfHVk78xaC36inpEFA9E2pMlw0pVm4RH59El2EezS+DYdq6i2TPxgMz0NqDtQ7/OG/rzxgOX
	k3rqqzSqNnJx7p3WgFy5xei4vXcOfhtCelNv7opewDUOB89RC/Mte8sf5QQkhoNzTWU1Dn5QXfYF+
	yUO6iHUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VXX-00000006d6E-39VS;
	Tue, 17 Mar 2026 14:36:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2VXV-00000006d5q-1d7T
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 14:36:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7989B68BEB; Tue, 17 Mar 2026 15:36:52 +0100 (CET)
Date: Tue, 17 Mar 2026 15:36:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
	m.szyprowski@samsung.com, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, robin.murphy@arm.com,
	martin.petersen@oracle.com, damien.lemoal@opensource.wdc.com,
	ahuang12@lenovo.com, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, ionut_n2001@yahoo.com,
	sunlightlinux@gmail.com
Subject: Re: [PATCH v1 0/2] dma: fix dma_opt_mapping_size() returning bogus
 value when no backend hint exists
Message-ID: <20260317143651.GA5186@lst.de>
References: <20260316203956.64515-1-ionut.nechita@windriver.com> <8b7706a0-41be-44a2-8247-ebbc33fee937@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b7706a0-41be-44a2-8247-ebbc33fee937@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_073657_570435_051AC170 
X-CRM114-Status: GOOD (  10.57  )
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

On Tue, Mar 17, 2026 at 09:11:59AM +0000, John Garry wrote:
> For SAS controllers, don't we limit shost->opt_sectors at 
> shost->max_sectors, and then in sd_revalidate_disk() this value is ignored 
> as sdkp->opt_xfer_blocks would be smaller, right?

That assumes opt_xfer_blocks is actually set.  It's an optional and
relatively recent SCSI feature.  So don't expect crappy SSDs or
RAID controllers faking up SCSI in shitty firmware to actually set
it.


