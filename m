Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1F3D3E2D0
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 07:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GKcktcNejbxj0z7CtZAZy1d670cxgCHyg7c2rrGZNJY=; b=mP9Uk69UzgmneOesRIg/4mBpo4
	TtraOzMn4fEXBfOPuTlJN/IiwzaoVYjD3jljpz5sWXItgeNII2nB/S+RadONZ/huuNCzGaBudlXfs
	Pd4tAqHE9Q5kig0Bqd6ZAuhVyZKw5cqyTWQAcu+xcZDrZxEMr3oa8UtOgpdSe8y9TglSLMJhAindB
	oYIP4k81wu82HNTzpPjZj2pKohH5wshrXW7Atl3H+lM/4rzyahknMCD3zfNw7JK06cFAC5t6rGyK6
	XyQCCF2i3V9cZSJsYp8N07N0SCFBWAJwEFEPZNVW3+VGj4d1XeyJeuj9qEzq3NSc+XLlSNkUD+sXI
	uoahZeHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5gu2-0000000DYWW-04bC;
	Tue, 29 Oct 2024 07:44:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5gqw-0000000DXZ6-0jRf
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 07:41:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CDE85227A88; Tue, 29 Oct 2024 08:41:17 +0100 (CET)
Date: Tue, 29 Oct 2024 08:41:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: bob.beckett@collabora.com, hch@lst.de, kbusch@kernel.org,
	kbusch@meta.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: Remove O2 Queue Depth quirk
Message-ID: <20241029074117.GB22316@lst.de>
References: <191e7126880.114951a532011899.3321332904343010318@collabora.com> <20241029024236.2702721-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029024236.2702721-1-gwendal@chromium.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_004122_383681_1038574D 
X-CRM114-Status: GOOD (  14.11  )
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

On Mon, Oct 28, 2024 at 07:42:36PM -0700, Gwendal Grignou wrote:
> PCI_DEVICE(0x1217, 0x8760) (O2 Micro, Inc. FORESEE E2M2 NVMe SSD)
> is a NMVe to eMMC bridge, that can be used with different eMMC
> memory devices.

Holy f**k, what an awful idea..

> The NVMe device name contains the eMMC device name, for instance:
> `BAYHUB SanDisk-DA4128-91904055-128GB`
> 
> The bridge is known to work with many eMMC devices, we need to limit
> the queue depth once we know which eMMC device is behind the bridge.

Please work with Tobert to quirk based on the identify data for "his"
device to keep it quirked instead of regressing it.

