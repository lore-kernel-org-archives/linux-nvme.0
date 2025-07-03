Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 759F4C83030
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 09:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9vOCpXmeLPuMo5eNzMX8qFMc6yWC5xXqT29ciKc8iR8=; b=y/wuuZvu+1ifX/iyVuKnJISN9J
	OiUjpaRAC0SSsXemZA54IQHliiZxNdhG4MPPmvPUa71wvQu6PD/oj+PN/wma+ooszYW6mo4pqUO5v
	N2+YCYsDqD/XHoL+toXD53mvIwVUOb9sPH6kgpe5GurYonZKPONbdPqTnDV2rnDuoZwJwHIqDsRo7
	SdjgyCeN6KKTFkGJKhpUsC2HsQZ1EM+Lh3SfSwjTbx/ISYy1AqhtHAb9CK262lEIEGLjxiUjIoWC+
	dy6SanWgwS9ZAvzS0a3AQ7f5qazMaScoT+6v+xZlGglK8ne3YGNUsOuqeoaHlE1430aWZIrCuJPjb
	Kxv42N3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXGPj-0000000ArAE-0Ee0;
	Thu, 03 Jul 2025 09:39:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXGPg-0000000Ar9a-3zTo
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 09:39:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D517A68B05; Thu,  3 Jul 2025 11:39:24 +0200 (CEST)
Date: Thu, 3 Jul 2025 11:39:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv2 0/9] nvme-auth: switch to use the kernel keyring
Message-ID: <20250703093924.GA8177@lst.de>
References: <20250528140517.3284-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528140517.3284-1-hare@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_023929_130461_7C55289C 
X-CRM114-Status: UNSURE (   9.24  )
X-CRM114-Notice: Please train this message.
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

Can I get some reviews for this series?


