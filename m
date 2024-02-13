Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FD2C48260
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Feb 2024 05:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mPPtJ16RD/3k0Deq2xHQ5hfdMey6ikpnZ/Cq7hGkUU4=; b=i0Nr4OYvx0jVRE7mZ63KFKx/vl
	/x4cINrEjeWZbg6j6qXzF2oLJaf7G9nqitPbv/Hct9A7trGEPuLqUFKFrGqHj80i84JopQXfc55JA
	bsb3WoJClVEO0Oc0FFmFDsQZ8niJ+sN/da+KeVEfj0vWATFTMFCjPVcBazd8Y4KIGgJ+M2dcpIXUe
	KDHBskrYAanunOspq/murvghI4ylkdM8ftU5S0i3vi/Nk6oU5VMfhrTtdSz6Mx5PnRt+5S3TyowzX
	uGMAElQr4RQnxQHfYgQ9fEZzGzt581Fr/fTVrP1jmckRHm+XfWfUDZowI8kgZB2fszMTTR8yAO/aC
	AaFq0cjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZljH-000000082P4-0V78;
	Tue, 13 Feb 2024 05:53:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZljD-000000082Ob-1z61
	for linux-nvme@lists.infradead.org;
	Tue, 13 Feb 2024 05:53:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 036E8227A87; Tue, 13 Feb 2024 06:53:05 +0100 (CET)
Date: Tue, 13 Feb 2024 06:53:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme-fabrics: fix I/O connect error handling
Message-ID: <20240213055305.GA22378@lst.de>
References: <20240208113125.50498-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208113125.50498-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_215311_678402_8E47C999 
X-CRM114-Status: GOOD (  13.13  )
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

On Thu, Feb 08, 2024 at 03:31:25AM -0800, Chaitanya Kulkarni wrote:
> In nvmf_connect_io_queue(), if connect I/O command fails, we log the
> error and continue for authentication. This overrides error captured
> from __nvme_submit_sync_cmd(), causing wrong return value.
> 
> Add goto out_free_data after logging connect error to fix the issue.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> 
> blktests is passing with this patch :-

Does this imply it didn't before?  In general a Fixes tag would be
more useful than a test log..


