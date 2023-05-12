Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63484C77B7F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 May 2023 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=TLVI0nAHzX58DJz401MxWaOopK
	YpdZbv+DZcnxMLGWUlmOVRin23oknA113yPMLNRBFtmwdpRq1BS+qW7FRLn+anCwWiKBmEDep5pUk
	yIH+5buxMDHHr5bW45Im7hjndHGnMBXix4GCxKlnbM3BZZDEVEE4xQVyu1Ux2Udcem9TcXZkG5ezs
	5nxIKYnvESUEa7CRBFAXjqSermgakFWrNWRV075UKuqlF8ANEDS+pdTT8RNA6hwmlMjBoFYeB4t9h
	bT0VN23mvrPx7Hg7tHQD7St4M6vmOpBYD26ZT7IIG9gFtkIUnBQKK2eExrjnTfoHh47qa7pod4azR
	w+2efDrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxU6R-00CEPj-27;
	Fri, 12 May 2023 14:50:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxU6P-00CEOo-1K
	for linux-nvme@lists.infradead.org;
	Fri, 12 May 2023 14:50:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BCEB268AA6; Fri, 12 May 2023 16:50:34 +0200 (CEST)
Date: Fri, 12 May 2023 16:50:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
	linux-nvme@lists.infradead.org, hare@suse.de, axboe@kernel.dk,
	oren@nvidia.com, ngottlieb@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH v2 2/3] nvme-fabrics: check hostid using uuid_equal
Message-ID: <20230512145034.GB5051@lst.de>
References: <20230511165441.30005-1-mgurtovoy@nvidia.com> <20230511165441.30005-3-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511165441.30005-3-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230512_075037_594383_542CD673 
X-CRM114-Status: UNSURE (   8.55  )
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

