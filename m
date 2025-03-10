Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58D9C282DE
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Mar 2025 14:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9BVAfbDMcQPaaTYRiXyzg6ZuHQP0b763yyO7KTf+WLw=; b=qw9tgHM7W7gyI6SSlf6YYwbbDl
	P04HGi4+4TRwHXChTlL2VU9Qxab18p7hopb8Co7xoQyrTU+MpViyUsiS5mmjyVIRBNR8/FwrR4cc3
	vduXD/lVXXJ7MJoH/MUzJ9Zp7PowpzABpEFmPegI+KZh1Z7VkZY4wAmTq8ek8IWuu9/nluvDsJC57
	h5oV0s/SwmflLn5NMFgAji9hUhwts0QNXGnBYOzpT8i6u415lCt/b6HRbinYl+PC7CgGSDcPvsefM
	3bV18KC1VsvYIp+PgdsnFOhh9eZUDP9N5dpARw9V6sTPjd+KIeXrUB1GJAfNex71ipBcMjb5MX+DT
	2nAdZIpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1treRK-000000030O5-2QxN;
	Mon, 10 Mar 2025 14:49:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trd7k-00000002ms9-0ecy
	for linux-nvme@lists.infradead.org;
	Mon, 10 Mar 2025 13:24:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CA40B67373; Mon, 10 Mar 2025 14:24:48 +0100 (CET)
Date: Mon, 10 Mar 2025 14:24:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: simplify request ready check for pci
Message-ID: <20250310132448.GB8835@lst.de>
References: <20250307232655.2143570-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307232655.2143570-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_062452_334368_1F1E0A2B 
X-CRM114-Status: GOOD (  13.33  )
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

On Fri, Mar 07, 2025 at 03:26:55PM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The criteria for pci transports' request ready check is simpler than
> fabrics. Move the pci check to a different function. This also makes the
> existing ready check simpler since it doesn't need to repeatedly test if
> the controller is a fabrics type.

The change looks good, but now that this is split, the PCI version
should move to pci.c, and the fabrics version should move to fabrics.c
and into the nvmf_* namespace.


