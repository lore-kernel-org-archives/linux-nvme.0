Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2FBC48260
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Feb 2024 09:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U/aZOeDnFL01hyfR2OWfnC1Uprj0z5woI9XMPol02CU=; b=U2gKI7QvpdxvJWd0NZGUpj3W+x
	ECp7KuTUkXU94K7QpPuTlAt467+ormPxlxbmb8p2FBxFLd+mAMivH2UKOIyCloz7fLbH7tYjMmFck
	ITBHP6mSp7jJ9H5J9xSzpIbXF7RLryBno3CV71THpvIqtTczR2SBW/ZFdnjbXivXi7Dq3fgubaNpP
	nYpbWCUWYBkmG510DjjSNwwd3TMirPRLm3qtI2UNfKdyYgbx8uQ2bLnXMomIjLZLyHNCV+P8qwBRU
	S0DwfIg48IwVCsYMTv7qSvDpn8pdIubN9KPFN9ZeEP9PlhrUdJsAW1dPMt36PHn/EHaZFBgShecyY
	yj6WOEXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rauqT-00000001myK-2MUm;
	Fri, 16 Feb 2024 09:49:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rauqQ-00000001mxT-2aYH
	for linux-nvme@lists.infradead.org;
	Fri, 16 Feb 2024 09:49:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1585968BFE; Fri, 16 Feb 2024 10:49:10 +0100 (CET)
Date: Fri, 16 Feb 2024 10:49:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0 1/6] nvme-fabrics: introduce connect_sync option
Message-ID: <20240216094909.GA19961@lst.de>
References: <20240216084526.14133-1-dwagner@suse.de> <20240216084526.14133-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216084526.14133-2-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_014922_828632_F040C23C 
X-CRM114-Status: GOOD (  15.74  )
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

On Fri, Feb 16, 2024 at 09:45:21AM +0100, Daniel Wagner wrote:
> The TCP and RDMA transport are doing a synchronous connect, meaning the
> syscal returns with the final result, that is. it either failed or
> succeeded.
> 
> This isn't the case for FC. This transport just setups and triggers
> the connect and returns without waiting on the result.

That's really weird and unexpected.  James, can you explain the reason
behind this?

> Introduce a flag
> to allow user space to control the behavior, wait or don't wait.

I'd expect this to be the default, but I'll wait to hear more about
the rationale.  If we keep the async default the option looks sensible.


