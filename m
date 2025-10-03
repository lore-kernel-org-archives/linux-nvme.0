Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7317CAC5B0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 07:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z6PVgubQ9K/XoE/gouDhqN7YCL1T9KtwlLI2VldL7UM=; b=jTFkXVDfF4Q/8Ou8LdOqxbR3Bf
	d/1AGsQXh/UT3xrQq6xQHGUIwlO77mItd6f2gL35LbEyxHq/o1Ak1dBfOZQ8wM3rdN9ykThE5p1Vh
	0oUdL2PdP1Yg1V7ywUhLONawJOevB2/OoA33ezM6RLI5WaFxACqHU1/7sNQFRGwFzJccB7/+FIbS3
	HXJ6pifDhQJ+5w/2z+qU4hK3qBHPuoLK2yfYf7JPyEBFeS6iYyxFDOM2WVwFwtisGigvYUw/Vy1bD
	DmcjNHgpZ3m2UfB6OIzHPDNmLqv7yRFQQzoH5VU+JqmT+pykzdgIi63XdT70GVHvZIftWivyoMJ4d
	kqlfU4gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4aJt-0000000Bp7G-0oxv;
	Fri, 03 Oct 2025 07:35:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4aJq-0000000Bp5r-47Cd
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 07:35:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 48062227AAC; Fri,  3 Oct 2025 09:35:07 +0200 (CEST)
Date: Fri, 3 Oct 2025 09:35:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/3] nvme-keyring: typo in nvme_dhchap_psk_lookup()
Message-ID: <20251003073506.GB12862@lst.de>
References: <20251001142200.61696-1-hare@kernel.org> <20251001142200.61696-3-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001142200.61696-3-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251003_003511_189477_68972629 
X-CRM114-Status: GOOD (  12.23  )
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

On Wed, Oct 01, 2025 at 04:21:59PM +0200, Hannes Reinecke wrote:
> Spurious semicolon in the function stub nvme_dhchap_psk_lookup().
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202509302259.Yku13u90-lkp@intel.com/
> Signed-off-by: Hannes Reinecke <hare@kernel.org>

Looks good.  But maybe we should just drop the series and pick up a
resend with the fixes folded in?


