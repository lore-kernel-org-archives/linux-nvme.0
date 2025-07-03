Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8693C77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 12:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hQXtO/a65uVl4Mc37fmC4rhzgxCA8E9k9q0KXPXm1LI=; b=fDZCHg2xJNW9MZ9+H08Ryf5zgs
	zFB7M23PuKo5wdxD2i8bO4ZpKY6IVVymM8MtPfBQsbRDJ6c376Rxsmar6ihzkw9g299edo0WuMx6S
	bBuh+ERbms00AgKq+2f4vVJ4ZUl6lcGlZ1JiCDdhUlNigfsFxqYhXC0wnXhN8h6Cf0zwciMpDAc9d
	NG/8tzRSGAZDz7UfXQOtgh+Ug1YFsenJWaEeqjYz5HFm5NGKvRJrhYnK6wpCN449Otb2SYo2qEnfN
	7UjgbLnUScctVTl3WBenfICZzvjPXYHABsEPV/YKzNGGd98VKK51YXrYLH4UKB3x8bgsruYc2x4JH
	YAwhe78A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJTh-0000000BPAy-0xn9;
	Thu, 03 Jul 2025 12:55:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXIPo-0000000BD32-0klI
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 11:47:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD0CB68C4E; Thu,  3 Jul 2025 13:47:40 +0200 (CEST)
Date: Thu, 3 Jul 2025 13:47:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bryan Gurney <bgurney@redhat.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@kernel.dk, james.smart@broadcom.com,
	dick.kennedy@broadcom.com, njavali@marvell.com,
	linux-scsi@vger.kernel.org, hare@suse.de, jmeneghi@redhat.com
Subject: Re: [PATCH v7 2/6] nvme-fc: marginal path handling
Message-ID: <20250703114740.GF17686@lst.de>
References: <20250624202020.42612-1-bgurney@redhat.com> <20250624202020.42612-3-bgurney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624202020.42612-3-bgurney@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_044744_354440_24485F3E 
X-CRM114-Status: UNSURE (   9.69  )
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

On Tue, Jun 24, 2025 at 04:20:16PM -0400, Bryan Gurney wrote:
>  drivers/nvme/host/core.c      |  1 +
>  drivers/nvme/host/fc.c        |  4 ++++
>  drivers/nvme/host/multipath.c | 17 +++++++++++------
>  drivers/nvme/host/nvme.h      |  6 ++++++

This is not a nvme-fc patch.  Please split out the core patches into a
separate well described patch.

