Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AD5E7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 05:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k/gdg9hty+Pi7jSl+mNTizM6YkQpuBrwo88OgXuMnqg=; b=vVv34rF9vqFoMAkUh4Zs7B7UJe
	/JVt9Ih72bFdPaXSEsfyf3y50KiyzaTywsYduxJosC/DwuXQuUeGX/z/xQn3bqgakZBjxQwMVtomm
	X1iFVAFxotiS/gpvRU1JkwM+tNshZMA+VeohZl4EcUYMnVZ1LpncLzhrWxMg8Qwh/351TKFopYspP
	fEYsFwl5GwfgjFyRU0BEk4T5hEgg5/ZjZpkCPvozQAsTcZ/tGga8ehILDqY8DrUjxGYQijl6hMVZL
	lRkiEzhLY9WqEVfrs4ej6jwfFi0c/6PXqAIlSgPKFOR6csyYbjiQrQ9nCBc4e6a6C0CysX38KzzYR
	F5kOX+GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLc8C-0000000GzD5-3QMo;
	Thu, 12 Dec 2024 05:53:00 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLc8A-0000000GzC1-0SHn
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 05:52:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BE9AA68D07; Thu, 12 Dec 2024 06:52:51 +0100 (CET)
Date: Thu, 12 Dec 2024 06:52:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com,
	John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH] nvmet: propagate npwg and awupf topology
Message-ID: <20241212055250.GA4825@lst.de>
References: <20241212033148.4008110-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212033148.4008110-1-mcgrof@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_215258_282988_ED128C0C 
X-CRM114-Status: GOOD (  10.06  )
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

On Wed, Dec 11, 2024 at 07:31:47PM -0800, Luis Chamberlain wrote:
> Ensure we propagate npwg and awupf to the target as well instead
> of assuming its the same logical blocks per physical block.
> 
> This ensures devices with large IUs and large atomics get their
> information properly propagated on the target.

nvmet never sets REQ_ATOMIC and thus won't get atomic writes from
say SCSI.  So supporting atomic writes is a little more work than
just propagating the values.


