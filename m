Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B8CC25B74
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 04:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NPzymWGZFZtOe+/jKRLbVu5DHM/rAWyTP2BsW0jWWww=; b=CcSSG9TH5jIsxDWi7OzmovM9Ov
	Vnjx4BxV1p8WiqdVwJQh+BXkXzWQ3yiKgo8qVERaeEbjSxDwOGLrn58HLA3XiTTgS/6k54S9Qo/+f
	HEax7Q5f2TVI/pq1q96d+OxRcJVPhGE6BNDSzk+/utqbZjWi32ArkTh2xAljwxxI/ONv2S/F76qHu
	8rIwdiwVROevBCUr6qjS19+qUFH53fbYMbMuSPeOs6ORgvSAQG/pJPJRAsLRWlss4HSzX2dpMenIt
	jBC1ZOcMAH+SZU2GpfPRTrUGV8AwWqBQU2uYq6By1q/bXH5/yV3mwWGRRLQBdqkny3hGZOwqybVJz
	YtWVl05w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELjp-00000001AnE-4A2h;
	Tue, 04 Jun 2024 04:25:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELjl-00000001AmC-4BHI
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 04:25:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 575D968D13; Tue,  4 Jun 2024 06:25:27 +0200 (CEST)
Date: Tue, 4 Jun 2024 06:25:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Weiwen Hu <huweiwen@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Mike Christie <michael.christie@oracle.com>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/4] clarify NVMe status symbol names
Message-ID: <20240604042527.GA28815@lst.de>
References: <20240603125702.97368-1-huweiwen@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603125702.97368-1-huweiwen@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_212530_202386_45947CC2 
X-CRM114-Status: UNSURE (   9.31  )
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

The whole series looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>


