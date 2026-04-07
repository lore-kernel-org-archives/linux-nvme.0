Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767C2FB5179
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Apr 2026 06:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K2fE+CJG+QCUeBnjP8hrDJkL7iKpnM1pGPtQyL3tj/g=; b=aZR3i4CTTAp2iv/AEfiPccI1YG
	VhgSM99WBbYz03r48P5iWKgBNg9T1ipTyswVbA4jQHq1uS/6W9Tt4vpY+Pgd9FCMwzuATzqESQezZ
	JrfulWQmrDCdK0hRhDnZRAaZUNbXoFRbz4cIUGlLxINcjiAVxH+S6yEnXh7KcPdKGuTi4GTiIFqyQ
	hTGjNLPX4sTeIVdrxMwGFghZbf1Og3PPpApbGgSTqBn3p3SxnvP+qfPBZ0Auf5hJXypgQh2Aaqowh
	wFYg/6oQ9vNLZIekS0Guy4n1rY74IJmL9twNkF/ggEcd5FH9TQvudgPHcaqb3NsrDEsfr559E8Cj4
	fKKZMq1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zyT-00000005zg7-3n15;
	Tue, 07 Apr 2026 06:31:45 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9zyQ-00000005zev-1reM
	for linux-nvme@lists.infradead.org;
	Tue, 07 Apr 2026 06:31:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7CD7268C4E; Tue,  7 Apr 2026 08:31:39 +0200 (CEST)
Date: Tue, 7 Apr 2026 08:31:39 +0200
From: Christoph Hellwig <hch@lst.de>
To: Shivam Kumar <kumar.shivam43666@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, gregkh@linuxfoundation.org,
	security@kernel.org, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, kbusch@kernel.org
Subject: Re: [PATCH] nvmet-tcp: check INIT_FAILED before nvmet_req_uninit
 in digest error path
Message-ID: <20260407063139.GB7036@lst.de>
References: <2026031827-carving-overdrawn-5b1f@gregkh> <20260318225658.1760759-1-kumar.shivam43666@gmail.com> <20260320074652.GA14485@lst.de> <CA+ysrS+Uht6pXJ3odiyGccZ7HrR+WvtrHexNkTB1Gvy=Uxw79w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+ysrS+Uht6pXJ3odiyGccZ7HrR+WvtrHexNkTB1Gvy=Uxw79w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260406_233142_633380_B391439F 
X-CRM114-Status: GOOD (  12.65  )
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

On Sun, Apr 05, 2026 at 03:54:24PM -0400, Shivam Kumar wrote:
> Hi all,
> 
> Just following up on this patch.
> Please let me know if there are any concerns or if any changes are needed.

Well, if we can't get people more familiar with TCP to look over it
there's not much we can do but include it.



