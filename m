Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB270C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 10:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+SSR1F78zy4UIn5icVa1yrwTAH7k3So6xKGkbdVwdj0=; b=3kVj8CNFvz0+JLfLC5eLTVXewH
	Y4XASAcmCJGTg27htRGOntKM4CqLEmskix5ot+tOX80v621+0ufWdvO9LgGhnwRHV1dbGR/FToEou
	V6Qlc7+pY1swTvjUY6+bSqXj2spqonZOhHLpuThkPByo0/vEcc9Dqa0UOaAsVttgYEAB4SdP3rbOe
	eALRbholoGoExiTt4SYo1OzxXu5nFkUYJhG2R27WX76fXwodnKZtxkZlJJr43q+AdX5mueDGGxPMN
	IwCBXhLgnc7jibUNrNVYbIBptN07tPRCFt1RjyrofVeWLYADYBnhWLb1ydyZUp/xqoJRGKn4uk2t6
	q+0JvXbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1outNF-00A3yh-45; Tue, 15 Nov 2022 10:41:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1out1Y-009p78-Rt
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 10:18:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B875D67373; Tue, 15 Nov 2022 11:18:33 +0100 (CET)
Date: Tue, 15 Nov 2022 11:18:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Uday Shankar <ushankar@purestorage.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@fb.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Guixin Liu <kanie@linux.alibaba.com>
Subject: Re: [PATCH v3] nvme: avoid fallback to sequential scan due to
 transient issues
Message-ID: <20221115101833.GB27559@lst.de>
References: <20221115002357.3949804-1-ushankar@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115002357.3949804-1-ushankar@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_021837_098785_4C073DEA 
X-CRM114-Status: UNSURE (   9.29  )
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

applied to nvme-6.2 after fixing up the comment.

