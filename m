Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB7BC4332F
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Dec 2022 09:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zqUjnYXlEwhbxE3A8YGbV8fAmLHhG2SwAzV0KcF7CZc=; b=4WWwnuf9CXYvhwPsftgQdBUtFL
	lI/QK8i+9bws9D5CfsKB/mWwPQgJNumpPbsKk7SdgaAKFsXK60jt5AcxJ5tCvhdJqdX+ADtr2qQ9f
	Ytdl/iCUBR4mMvYU5R0zCBE/xLaZSte2J2wGnxHK6TQbY7eVI+ckDPCv3drD3QydIiWH33vOQnaPO
	mZUCkZHnChwsC+G3HNvPvUA4s4vw7fB8wyPJ4+PKb7yMkIQtp4c5zrVAI2euZ+0vHsATGccd3mH8q
	teJb3To/jPXZevd88+UxlxhJ/cTrfpkIFtwLOHKmsmIVH98VPPfzjPUJhmMGI6cu/masyx51Zj8P2
	sFoUqDqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p12KO-00EwkI-7a; Fri, 02 Dec 2022 09:27:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p12Gd-00EuK3-1x
	for linux-nvme@lists.infradead.org; Fri, 02 Dec 2022 09:23:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0205B67373; Fri,  2 Dec 2022 10:23:22 +0100 (CET)
Date: Fri, 2 Dec 2022 10:23:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com, Monish Kumar <monish.kumar.r@intel.com>
Subject: Re: [PATCH] nvme:core: initialize core quirks before calling
 nvme_init_subsystem()
Message-ID: <20221202092322.GB14667@lst.de>
References: <CGME20221201125412eucas1p17da85d566e9786dba7d76230f396eb57@eucas1p1.samsung.com> <20221201125233.41094-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201125233.41094-1-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221202_012335_293298_8669B424 
X-CRM114-Status: GOOD (  14.03  )
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

On Thu, Dec 01, 2022 at 01:52:34PM +0100, Pankaj Raghav wrote:
> A device might have a core quirk for NVME_QUIRK_IGNORE_DEV_SUBNQN(such as
> Samsung X5) but it would still give a warning "missing or invalid
> SUBNQN field" as core quirks are filled after calling nvme_init_subnqn().
> 
> Fill ctrl->quirks from struct core_quirks before calling
> nvme_init_subsystem().
> 
> Tested it on a Samsung X5:

Yes, this looks reasonable.  But it won't help with the CSTS
corruption reported by Monish, so it seems like the SSD doesn't actually
show that issue in all systems?

