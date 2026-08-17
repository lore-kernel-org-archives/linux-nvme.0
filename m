Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DABC5B572
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 07:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m5QSLKCyGcKdik827L/TWDavo0dzy7td/HCpykQFur0=; b=1B7hehDFwLGSsq6DoF4dF21oIu
	mF0oUf8OwWFNl7VRxhz/H2wakYwrVaPS8FQd9hBZnCnnDf4O9EJEX6QMDLug2FkgKuqvY6wC1UcVU
	10wvewDTzey49uZQxcC8Xg38AD6edTaKMyXelHls4BsDAlL9ShT061RJsqRcWGbi4jC0clQ8qmFVA
	qNJemyy9LNMY5RMrw3jYeEiR11CwM4nKSHd4zQwUzulCn8maWTYu/CVv+ct1+z+Dgklmmyy1dQm+f
	uQm4udCsiGSi18COAT3VYL3UwbwgJmUdKvWPbVwHnCQIL0xe/FPTaeWzE7St2ZNyWfxq8rN9mFM1p
	VfmtQLCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvs0A-00000005aVr-0azG;
	Mon, 17 Aug 2026 07:43:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvs08-00000005aUM-01fh
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 07:43:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A8D7468CFE; Mon, 17 Aug 2026 09:43:15 +0200 (CEST)
Date: Mon, 17 Aug 2026 09:43:15 +0200
From: Christoph Hellwig <hch@lst.de>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet-rdma: fix queue leak when connect backlog is
 exceeded
Message-ID: <20260817074315.GA20043@lst.de>
References: <nvmet-rdma-backlog-leak.v1.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nvmet-rdma-backlog-leak.v1.git.liuxixin@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_004320_193106_8A388D8D 
X-CRM114-Status: GOOD (  10.94  )
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

On Thu, Aug 13, 2026 at 02:42:01PM +0800, Xixin Liu wrote:
> When pending disconnecting queues exceed the backlog limit, the
> connect path only drops the device reference and leaks the newly
> allocated queue and its IB resources.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


