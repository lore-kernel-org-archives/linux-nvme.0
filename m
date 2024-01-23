Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA8DC47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 08:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=OgpqZ0WZ61zOLufRI/U7+KLT0D
	dDa0+UoYsSPn1EvpBebGWWX3Uq5tVzMHRo5hx2emrchUuDi3rpqicbev/Z98RoC+XbbZ0Q0YIwc1P
	zz03brTx4TBUm1OMPWuUlJmT4c+4T40FxgB5N6JjA0bqnXIzmrWtM4TGHIW6n+p8DrZAEio1H631b
	we6lh6g6XwsSi5oCxGBp3gliDZk0fHaPOnUj1vcSOF5x2AMw8lQwBs1EBqnE15cCADngeE+Pn4APz
	bQa61Wu/X5LdAgHKteFkWVbWt4zLGZpTH4xtSoFtqHM4dbAivwdx1lPxuKKW7Qnom86fsz45gAdCo
	MUs6/dvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCXb-00FeTi-2w;
	Tue, 23 Jan 2024 08:53:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSCXZ-00FeST-0P
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 08:53:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7CF8A68BEB; Tue, 23 Jan 2024 09:53:50 +0100 (CET)
Date: Tue, 23 Jan 2024 09:53:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, israelr@nvidia.com, kch@nvidia.com,
	oren@nvidia.com
Subject: Re: [PATCH 4/8] nvmet: set ctrl pi_support cap before initializing
 cap reg
Message-ID: <20240123085349.GD30155@lst.de>
References: <20240104092549.25721-1-mgurtovoy@nvidia.com> <20240104092549.25721-5-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104092549.25721-5-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_005353_304279_6FCF2955 
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

