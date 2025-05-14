Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CB2C3ABCC
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=thouv/Iugv9Ibk1c9KzTk8Zsgx+FoM9fM+m0l2bDqdk=; b=BbmhTdyjT8pHFYZU9cqK+UGxUR
	/ust97Fby7OKuWgc1A1LGrNxWSZKy6v7QAcFFiVjdKynzTuQyEADz7T51mU+tP93yz89szZcyIjon
	nqeL7D4Sa/8VeVL/SmpZGAsJ2CJbWiqE2GaPw6JUR1b37FaKDJovy7B8UsDC3+0KLsIQHedJFCvYs
	yC/izZxq6WDtm6kgwO3i/vDvo2QXohdaCnPOEZQncxHmy+0SgfQHFDxXl6DdVSSo/OGz32S3GtMCw
	CvbzQVTkCFNo7p3CNnZ/8kU1uhzE+TBSXS/9qzVTgQjz8eYH5hUeQ1gXUE63pqUpeMk6VkbI23Jh3
	5t0LJv0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFDEK-0000000FQln-0qro;
	Wed, 14 May 2025 14:37:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFCc5-0000000FLBt-3sj5
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 13:57:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1812268AFE; Wed, 14 May 2025 15:57:27 +0200 (CEST)
Date: Wed, 14 May 2025 15:57:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Alan Adamson <alan.adamson@oracle.com>,
	linux-nvme@lists.infradead.org, kch@nvidia.com, kbusch@kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCH v3 2/2] nvme: all namespaces in a subsystem must adhere
 to a common atomic write size
Message-ID: <20250514135726.GA25649@lst.de>
References: <20250508223802.277311-1-alan.adamson@oracle.com> <20250508223802.277311-3-alan.adamson@oracle.com> <9ae170fd-0f27-4da7-b475-61530b061c85@oracle.com> <20250514053546.GA24782@lst.de> <908caa6b-b904-4a77-9970-36ff61f759fd@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <908caa6b-b904-4a77-9970-36ff61f759fd@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_065738_099584_DEB50C21 
X-CRM114-Status: UNSURE (   8.84  )
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

Thanks!


