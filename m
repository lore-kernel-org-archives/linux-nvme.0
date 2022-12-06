Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70B3C3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 08:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HmwQ6Lj4zXlU+LAD/mZnw5qKJlrEJzjjLnOXZt59uRU=; b=YtOPZtEJw5gG0n/HkJ3atHNcLN
	q4X5DeLF87o7YjDPSIP/1U2QILCoyOlZyQe2NYZHTaOGSfDWH+5dV1fxcyCfPw4OHMUsgZezbZxAZ
	17rtj91gZtIesfP8hvh7Gdi6iUBinD3jHsTL+tnQIXO9IogF9/e6zYGIZA0raZmo/nUCATu6vMK4C
	oz4ouLOZdcpRqsq0U1b+UhKo7TvbKRZXopCmjYsDiPZmHthodxMFHeP4TczD8YtsCGOKpxOdPJZbe
	maGrMcLXZZM/ctlxDQFEBN8p/WDc5zkZ46PW9hpXoYS73E+GiY1BleeMB1/5MAW8j+M93KvV2+lnO
	QvGYMttg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2T0M-004Q57-LL; Tue, 06 Dec 2022 08:08:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2T0K-004Pxy-3N
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 08:08:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8DF4D68B05; Tue,  6 Dec 2022 09:08:36 +0100 (CET)
Date: Tue, 6 Dec 2022 09:08:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, james.smart@broadcom.com,
	kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 1/2] nvme-fc: avoid null pointer dereference
Message-ID: <20221206080836.GB8476@lst.de>
References: <20221130213341.9625-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130213341.9625-1-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_000840_310207_89771317 
X-CRM114-Status: UNSURE (   7.40  )
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

Thanks, applied both patches to nvme-6.2.

