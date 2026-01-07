Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9EDCFD63E
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 14:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Tq5wKQ4i9k4e0YSNkewWHwTKt3
	xKsLW6hMNEZayZ/Dna8sTdRi44EZe+HNIU71SL0zqaIcOyJNvZ7tqqJC60CtuWVAnYba5d8VWtRao
	/01htjwasNrA09IxMfEy2ZNHbBQT7oByXSFjK/bMR8ocwdbKp2feReGz7/8ACR0tT0BcTJGoD/Fpj
	HkbKGKhv8HWNUcSXV3uKMevrqYbY1a9HEKYDmyC1a0e964ZKQXR/9/8FkckzKRhXmKxhbj1fwDOmU
	ya+G9nQ4sqymBGwqjB+QcUDMBm9vaMZg9XZo5KQaMXavYXJTJIHnIzcUxs1QvhQyquOINb9w6jNT5
	MLGLjCvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdUgI-0000000F6iA-3EOq;
	Wed, 07 Jan 2026 14:38:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdUgF-0000000F6hO-49NU
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 14:38:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8881A227A87; Wed,  7 Jan 2026 15:38:32 +0100 (CET)
Date: Wed, 7 Jan 2026 15:38:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: Constify struct configfs_item_operations and
 configfs_group_operations
Message-ID: <20260107143832.GA14904@lst.de>
References: <82fd284cf70cffd374f5889a5c2a1f3800bafab3.1766495484.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82fd284cf70cffd374f5889a5c2a1f3800bafab3.1766495484.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_063836_170278_3FDA8CEE 
X-CRM114-Status: UNSURE (   9.01  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

