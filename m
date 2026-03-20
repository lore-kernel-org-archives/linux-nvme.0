Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A016F1093187
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 07:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bNLO3gA1u9StvJs+WEoGSxpc9lHkq/tzX1OIOmH4zz0=; b=2clPddjKeR8UumBJ7by6XkMxgl
	yd0L9FpcaSJsv63uQXRKtbO1wNpp4neANMvd8HZTzJoc1e9SzMg/HpYJlE4PHYIL7JGHTbiW29nRh
	x8DseGA6ZZDfmxnDRMv2oSbMeHCQszB5CTaIhAxUEVdTxgReuP47z071QQmXu3DBF9N5sOqkf1Ixq
	2UJ5LKBkCls6x/pC57azuSSBSOmi/YaSgJy8qApbd5+0PtRJ34aXhcVrJdLs35yzM+gIoMGMUDEnd
	RZ1XgAdgigqpmlWI040KnUG2blJI+MDcyiOxzpxyl9UwdP0bZQzNMEPtOVTWUyc4fBg3kDTdg5VsR
	Lf9qIMIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Uk1-0000000CIVo-2eCf;
	Fri, 20 Mar 2026 07:57:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Ujy-0000000CIVR-2fCL
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 07:57:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE9E86732A; Fri, 20 Mar 2026 08:57:50 +0100 (CET)
Date: Fri, 20 Mar 2026 08:57:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/3] nvmet: replace use of system_wq with
 system_percpu_wq
Message-ID: <20260320075750.GA14771@lst.de>
References: <20260223102336.108512-1-marco.crivellari@suse.com> <20260223102336.108512-2-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223102336.108512-2-marco.crivellari@suse.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_005754_836928_62E351D3 
X-CRM114-Status: GOOD (  11.26  )
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

On Mon, Feb 23, 2026 at 11:23:27AM +0100, Marco Crivellari wrote:
>    system_unbound_wq -> system_dfl_wq

"dfl" is a weird acronym, that doesn't really help understanding the
code.  What does it even mean?

Either way given that this has already been picked, I guess we're stuck
with it, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>


