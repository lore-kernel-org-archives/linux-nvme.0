Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF44C52D7D
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Aug 2024 04:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=u+dHsR3xuceIyAtBnAcCB5QJa8
	jo+ApogSvOy46A9WilRbRbhmwCXNehyG3zjyDT0B94MKo5pORsnt/3doQPZae/vJguhovE6sncTa9
	Q3dAXHfz6qJI1Kkh8Ft+as3GIr5HWe4Ht4ROMbZHTn228YoLQhr71y4XhSzW+0cnQtMzHiBdYIYNh
	KoJfZg4x6XGrQpu++DZkV0vwmigKrVOotBDfvc3Qm2Wf9o5VItTeh8iimZd6W2xBzCzn5/QJjIXDe
	U9OkhJD0jBUHY0SBsLTyhYOLdMoXiHqzYtbUqIA0KtJ9+vN5oZJgDrmn3P/AccuyrMgSOSOXX+EwF
	e8PCVIlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seowg-0000000BncT-1shu;
	Fri, 16 Aug 2024 04:52:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seowc-0000000Bnc3-1x3x
	for linux-nvme@lists.infradead.org;
	Fri, 16 Aug 2024 04:52:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D8769227A8E; Fri, 16 Aug 2024 06:52:01 +0200 (CEST)
Date: Fri, 16 Aug 2024 06:52:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Niklas Cassel <cassel@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	kamaljit.singh1@wdc.com, dlemoal@kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-rdma: send cntlid in the RDMA_CM_REQUEST Private
 Data
Message-ID: <20240816045201.GA28436@lst.de>
References: <20240815201131.1439811-2-cassel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815201131.1439811-2-cassel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_215210_654549_307F0614 
X-CRM114-Status: UNSURE (   9.93  )
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


