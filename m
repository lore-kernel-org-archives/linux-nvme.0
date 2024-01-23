Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04BCC47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 08:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=MBeSPh1OuI/pwmL9YtzSVvKMpZ
	WF7+ecZg4iMWejWhNLoJoZXu4udoCi23C/Qm8NdqAuFN5J0uuwSlJ4I3TPNUfdpGs1HSRsnIk79/S
	KNOI0bQGX2K5Y1bEe6KztVt12gS9vEvCZVoA5lu6Cf25mS/G/rOnSzZAhiiiC3AcQw0/8CgP6bdg1
	K6xnocgpaH7HD/jQfW30RSmjDlVWgjCjQiRin1LXShFnqUG7wABZbVeFnAO8S9rLADQu/pPU0CdMu
	Cy/fMvkEzlzqr05BW6Adq7zXkZ4UMfCeDQtfYs8wA2Zr0A0477FPk5hwFUdbtS6byQ9UJq2OIMDXB
	7wo+5Now==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCXM-00FePk-2m;
	Tue, 23 Jan 2024 08:53:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCXK-00FeOx-2U
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 08:53:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 01DEF68BEB; Tue, 23 Jan 2024 09:53:35 +0100 (CET)
Date: Tue, 23 Jan 2024 09:53:35 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, israelr@nvidia.com, kch@nvidia.com,
	oren@nvidia.com
Subject: Re: [PATCH 3/8] nvmet: set maxcmd to be per controller
Message-ID: <20240123085335.GC30155@lst.de>
References: <20240104092549.25721-1-mgurtovoy@nvidia.com> <20240104092549.25721-4-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104092549.25721-4-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_005338_952319_1135E787 
X-CRM114-Status: UNSURE (   8.73  )
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

