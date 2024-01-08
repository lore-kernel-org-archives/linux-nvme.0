Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3894DC3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jan 2024 08:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qa1t3FUrsK1zvOYptevQN7W+wA01G/iIWWSWmlsG3A0=; b=OZSKTOAZcPX4OjVPf/pbRPVyUv
	zrRPmQEJa3eb3zqV6N4wgtK60rhLGm331FyfwDDyMLsF4SUiRynjbWhC2ePoGVT9fZJcJZdKCgDNC
	zSvgyJMv8CUyxGkYK4U6hAQroKNArLqdlK1/8KbSjCRbzlF1y6myL6/9sy8wMBsYDmhw9dYQ3OHgM
	RKSSxA9WuXY4ukh7Pt3d0sAf1pisE2mWECVyjEfTuQODC3YfSTs+tQKS+6ZJ1YwLI9xwGWONrXhXo
	kcHeLQRSj3VR2tAJmvvphrjsPH8uHaedQ8Xbq3PKRJIGwVG6qOY1Rcla6BqZRlIYiIWoPqThTAvMh
	8lyDztHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMkxg-004INi-1G;
	Mon, 08 Jan 2024 08:26:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMkxd-004ILq-14
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jan 2024 08:26:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B970F68AFE; Mon,  8 Jan 2024 09:26:14 +0100 (CET)
Date: Mon, 8 Jan 2024 09:26:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
	chaitanyak@nvidia.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3] nvme-pci: enhance timeout kernel log
Message-ID: <20240108082614.GA4623@lst.de>
References: <20240105182020.2721350-1-kbusch@meta.com> <0ec0e324-8261-4e4c-9797-7b3154355305@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ec0e324-8261-4e4c-9797-7b3154355305@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_002617_512582_9DD11DD6 
X-CRM114-Status: UNSURE (   9.40  )
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

On Sun, Jan 07, 2024 at 02:26:54AM +0200, Max Gurtovoy wrote:
> "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout, reset controller\n",
>
> I'm sending patches to align rdma and tcp to print tag and cid as well.

Yes, that sounds good to me.


