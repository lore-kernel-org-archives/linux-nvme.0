Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77567C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 06:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wGEzLJcvz1nd1SEC0lgv9m39jM58EzpITi0+uCUq+Lw=; b=Wrq+5F9UNV5NMJhe7Ag4KXrYMU
	5mwdpR1XEt1mtWP4GUwwUXbjbuua/rf+UnaZzEGnvLW/Hf9W+U4dV0TnSr3Wu1xBQQV6TzMS0GBKl
	SNfNys+ke/QMvTYw/Y543xtpUJB9TccJrWNW3IP1q5pINCjZWcQtUDJa4u50tYEOA/wCnZ5kbMsfG
	/NQpFh2pvbkoh0MbTLzLYX0Z82UHQpBcSFmIc4ZA9pR662Cad9OwvRCbatiSFiokXMEpyD1niDXsq
	zOVlnknulrjxAzxonTA3wni0/wl4eZBOmcEzx1R/j9p96LHOIWsV5Zk7kXXO1B4QR0JD1KHPaoE7P
	KlYrDsew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noJ7a-0006lr-1O; Tue, 10 May 2022 06:13:22 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noJ7X-0006lI-PY
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 06:13:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id C9C0E68AFE; Tue, 10 May 2022 08:13:12 +0200 (CEST)
Date: Tue, 10 May 2022 08:13:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 kbusch@kernel.org, kch@nvidia.com
Subject: Re: [PATCH 1/1] nvme: remove un-needed include from constants file
Message-ID: <20220510061312.GA10966@lst.de>
References: <20220428091524.35442-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428091524.35442-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220509_231320_013543_53A57E7E 
X-CRM114-Status: GOOD (  10.81  )
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

On Thu, Apr 28, 2022 at 12:15:24PM +0300, Max Gurtovoy wrote:
> No usage of blkdev.h elements.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>

git-am is not happy with this one:

Applying: nvme: remove un-needed include from constants file
warning: Patch sent with format=flowed; space at the end of lines might be lost.
Patch is empty.


