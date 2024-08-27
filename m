Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21A61C54736
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 12:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EUJV/K3IPj7yA3yEgmeAkQ/7uhJMl5+kclCIqsdB7/c=; b=NsWUyMu/Vjax/GnfoH7lAzKRH3
	YKh4Z4J03Ut/c0E7NxzNCE/opzB+nJZ6/WoBOEfwG1YJ+rknBgeb+v8v4dkS/Mi1yrmR7GBPoW1WF
	U75EEi1yke/q1lx5d9SZBA8xV/jVymhkQZ5RdGq1EJJUKltWHswP2jJhd5AUL7yzv89W18cotOwFW
	wxjpbeYgA10aGg/RnAt9DFwUR41IrX8yDurgr2qpq21B1k6P3f4b/4tJ3TgSyMLMDrms1B936UUIz
	8XnXKXJI9smsj5mxNVvF4xd0Hdn2/hcsGYhk9DYK4htZCew5uEx1qPsRIgj8TOfxi3ocZP9yZwP7V
	FYEGrF6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sivBV-0000000BByZ-2hgQ;
	Tue, 27 Aug 2024 12:20:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sivB1-0000000BBmP-3dFo
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 12:20:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BB90768AFE; Tue, 27 Aug 2024 14:19:55 +0200 (CEST)
Date: Tue, 27 Aug 2024 14:19:55 +0200
From: Christoph Hellwig <hch@lst.de>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	puranjay@kernel.org
Subject: Re: [PATCH] nvme: check if the namespace supports metadata in
 nvme_map_user_request()
Message-ID: <20240827121955.GB1607@lst.de>
References: <20240827121701.48792-1-pjy@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827121701.48792-1-pjy@amazon.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_052000_065160_6DB07A75 
X-CRM114-Status: GOOD (  12.15  )
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

On Tue, Aug 27, 2024 at 12:17:01PM +0000, Puranjay Mohan wrote:
> +	if (meta_buffer && meta_len && bdev && !blk_get_integrity(bdev->bd_disk))
> +		return -EINVAL;

Overly long line here.  If we go past my initial RFC I'd probably
restructure the function a little bit, i.e. add a new

	bool has_metadata = bdev && meta_buffer && meta_len;

and then use that both for the support check and the actualy mapping
below.


