Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3A6EB1058
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 14:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RNZHsFJsy6/Ujj4+QvPiqI3rniwep9ya7wURGpaKrFQ=; b=wx83B0Ea7BlznNukHV39DLCGnm
	ic11fzH1EcOej3OZSpMf4qm+X1YbBXxOG8xPtQ51xSJG+XefRPYYbdQY1xTVSYueTJ3h8SXqfAEpA
	+6UBvlvNpx+4Xbv1UsNk1Mz0aPSZVoArbUZjw/KTYlST/obMwUkfAZVWMfamnlz2MFky2/fhZJKGt
	09nrMTnaWP941D8kKqJ0SxIYjcxp4I23IBVO8oKLLYV9OV6cIFw49z8ptzqASaITqvq09ZHHxkh4d
	Nt7dOMZluy9BcUUNoUjzNifOyQfO4wOzkzS5WHz3q+qGLcjQ7c9M1mPZXZPYEsBypzCIR30GOnbVG
	LuaG/89Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzxzv-00000009gxL-28eb;
	Tue, 10 Mar 2026 14:23:47 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzxzu-00000009gxE-12W4
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 14:23:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 512F060054;
	Tue, 10 Mar 2026 14:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7CE3C19423;
	Tue, 10 Mar 2026 14:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773152625;
	bh=RNZHsFJsy6/Ujj4+QvPiqI3rniwep9ya7wURGpaKrFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kouDsF8tT4H4cy8xygWIrgNcJJrCM75GxIhVVoAbjJiQpUBrCMKybqPR/ognuEnZ+
	 xKJcsFrFd4oC2sfUt+PCGx11ZqXQEAQ9dSMxqB19xkTzkC75vSiG0XypJj7/4wanqc
	 tfbwPPYVsDvRemQMwPchCkokBXAgrTnSTKmpLP5T3TO4/9QPpYYptN6ET2QGL8dXX3
	 uMZUq6FKpGczlwSDzMjj1f5QfMR8E2N+L0c+ybtoSccWMOTc/gH4fPrfIir6ZD1fS5
	 AZHgYGzdPQHNlXjJtQ8nhtOlnwOCXpRLpNRPYbDf+/dOTtG4V4plaRV6TXFkXszxVD
	 T79fid5OgCUtQ==
Date: Tue, 10 Mar 2026 08:23:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, wagi@monom.org,
	shinichiro.kawasaki@wdc.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvmet: move async event work off nvmet-wq
Message-ID: <abApbr8UX07y7SPB@kbusch-mbp>
References: <20260226043003.160555-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226043003.160555-1-kch@nvidia.com>
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

On Wed, Feb 25, 2026 at 08:30:03PM -0800, Chaitanya Kulkarni wrote:
> For target nvmet_ctrl_free() flushes ctrl->async_event_work.
> If nvmet_ctrl_free() runs on nvmet-wq, the flush re-enters workqueue
> completion for the same worker:-

Thanks, applied to nvem-7.0.

