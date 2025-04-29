Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F363C369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 15:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mZjMxrhZX3PqZC48WDq0iIbfVoV5QzA01VRsQ1C30T8=; b=hqORm7onBs8Ukyu/vafWO+z6sS
	AcKIY9d5Tz/C+v/iyE29U54V4Gzwjbwm6gaJFOPyeanlXiFCDOyATaAlGfhQe8DtlzYEn2wvOHYCy
	mq1zqH+ePhOHxyC+RAbrImMVvmM9KeoLYD4PPEkOIskbWzDDrGIaxBnpMe7axTm1Ih0XUZQ8FJgil
	XVm9FtWKa2w+AfxGQgytPjdhQuuQmAOL/yRyAvYeyzIvXVFXLehyRspezBaG1M4asnL46ALWwrUdj
	2PLqQQiAcDIVm3LZlgFnIaelK/1/h5j73xOme6VAHZcviUwXAQ+UM80OnEV125RmlfpttxokMQPpV
	R8GbPHYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9mgz-0000000A4uo-1mue;
	Tue, 29 Apr 2025 15:16:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9kiC-00000009jmT-0RVY
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 13:09:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 483C668B05; Tue, 29 Apr 2025 15:09:19 +0200 (CEST)
Date: Tue, 29 Apr 2025 15:09:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: WangYuli <wangyuli@uniontech.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com, niecheng1@uniontech.com,
	guanwentao@uniontech.com
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 126f:1001
Message-ID: <20250429130918.GA13970@lst.de>
References: <5AE9DE3EEA7F8772+20250422121725.162229-1-wangyuli@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5AE9DE3EEA7F8772+20250422121725.162229-1-wangyuli@uniontech.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250429_060924_283052_83D24A60 
X-CRM114-Status: UNSURE (   7.86  )
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

added to nvme-6.15.


