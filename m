Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 919F0C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 09:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=EiEXFLI+haYU3Z2dyTJ1O6KRpt
	IxaruG3JUiiJsDWQjxLQSXpk5Fn05GokFBpHU2H0OCDG6CiEYxc/oMNihywwP7OnPfuzvhBuklj4X
	p/8XyHkLfumm9DdQp94N+Zq2wlPQqKIJjsGiUYyA0PY0sm9HRnGAc9ptzqoKMt+MLYx9X9wCeS/6g
	0qhP+q+QBq8XJpGAwqikQA8Zq0R6ESwrbKW73Xd/l5WIQmDX92GCmKkRVNpRbsINBg9S3yehqs3FQ
	NONMmw+QeKu4nJrh0/ah1bl08CyxMsMtJMnU+zpL0hFghb2HhvKvu3Fum42GpRQA2nT5/xrqIORgm
	pSUOf4pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjCiy-00000008gq2-2cjQ;
	Mon, 13 Jul 2026 09:13:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjCiu-00000008gnl-0PhB
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 09:13:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 58E6068C4E; Mon, 13 Jul 2026 11:13:06 +0200 (CEST)
Date: Mon, 13 Jul 2026 11:13:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com
Subject: Re: [PATCH nvmet-v2 1/1] nvmet: zns: reject full zone report when
 buffer is too small
Message-ID: <20260713091305.GA7390@lst.de>
References: <cover.1783579899.git.liuxixin@kylinos.cn> <cover.nvmet-v2.1783940400.git.liuxixin@kylinos.cn> <c7e4a91f2b8d.nvmet-v2.1783940400.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e4a91f2b8d.nvmet-v2.1783940400.git.liuxixin@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_021312_278863_9D5552C7 
X-CRM114-Status: UNSURE (   8.34  )
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

