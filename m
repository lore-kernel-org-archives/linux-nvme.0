Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FA7CAC592
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 17:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RY44oomYo27pAtzSe1JaEhH8C7rj/9SwTuvYx8N/upA=; b=jiI56orb34hF8uMd34bwVo+vJY
	ao2Iv/b73+mjxW2YQWiFYVKhNF/pFP52L2NMp1rNSLwO8d9KryCjWwqCSgoPWf3UrPM8vIpU/PzkY
	I1ky6Hb92zxnB/wScn/zJLJg8L4b0MpG1mnS9Gizkr5aOLWH+rVZPt3I4nu6GAajtI/k/+4s/PFAG
	J7f960/V/c/spAzaCfyjxThAuLra1ZKDNn+fybGDkIfv5jCQrpi+v7Re6O4qfo9i+j5VcTAYnM/lm
	MXTY1I/vuPM4TsHbzHuBydzUCHhAK5o+Jk5Bn/iWKPa9QzVJWRsT7eLh+0XFvR9UVMjcQO6zt2jir
	7nvS/s0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kPj-0000000B8n3-0rSV;
	Mon, 22 Sep 2025 17:33:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0kPg-0000000B8m3-3bQY
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 17:33:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 978E4227AAF; Mon, 22 Sep 2025 19:33:16 +0200 (CEST)
Date: Mon, 22 Sep 2025 19:33:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org,
	sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 1/3] nvmet: prevent redundant enable/disable of
 nvmet_port
Message-ID: <20250922173316.GA14393@lst.de>
References: <20250920234943.4959-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250920234943.4959-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_103321_040756_276DAE0A 
X-CRM114-Status: GOOD (  11.38  )
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

On Sun, Sep 21, 2025 at 02:49:41AM +0300, Max Gurtovoy wrote:
> Add early return checks in nvmet_enable_port() and nvmet_disable_port()
> to avoid redundant operations if the port is already enabled or
> disabled.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


