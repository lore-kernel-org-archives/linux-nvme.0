Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98257C61DA4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Mar 2023 14:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2hgrkPgfB3GRsCK3NmF2r7zO75FK/ebcJiITpxQa4w=; b=gSkJZEAssKiNSjkqOub2iLk7kr
	ooVCxDAoJnbH8m6QyNdaWcJNhMf0cIY1DZ7ApzG3A9S2e2jR/9DPToBnfXZU/6m2JOH+kj7w6rVDo
	usAbBCLfJ2SCDJQvoYKl1xOdr7vE/Mxcb4hL2V6eHrhxvDynujf/SZSMI8820WQeK4IltHdt5Xt4z
	DC7QwkJjuT0ap7kUjuPTXdfbd/KLNrAnszmYRo3I9PVjenO5Ntkzun5tcI3ak4xsX1R98yu4M5GUi
	3+50y9QfiIDyZV+E7pUNtboSiYJ54U8J3tilft77AV7cndXTbavPvT/Gtprr23SPfS5bVry2qZop4
	7/hQJKyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRmn-00DZ5t-35;
	Wed, 15 Mar 2023 14:07:25 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcRml-00DZ4u-1N
	for linux-nvme@lists.infradead.org;
	Wed, 15 Mar 2023 14:07:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 20B5868B05; Wed, 15 Mar 2023 15:07:19 +0100 (CET)
Date: Wed, 15 Mar 2023 15:07:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 0/5] Fix nvme target identify command handling
Message-ID: <20230315140718.GA27193@lst.de>
References: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315105939.305825-1-damien.lemoal@opensource.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_070723_606982_AD863E7D 
X-CRM114-Status: UNSURE (   7.33  )
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

Thanks,

applied to nvme-6.3.

