Return-Path: <SRS0=YrQE=HG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFACC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:32:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB6EC64F64
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Feb 2021 19:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB6EC64F64
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7NI73U/XvR+NVauon7lZvVU53PPpkZKV7aS0NR48Rrg=; b=myALfEYvM3W3x4z9my0zWY1Yp
	zLGAVEt+Kkkz7SZRY1W3SIY1XZLrcRpPNrBFnhxPJM/3TLmKhNTEORXWp3socXXDqIfr8FCGQcVRO
	N83S+KoUmbay3Rt64XfsmeuV1ZGt7rcfx930HDI41yxYlb2i+hCNHXL1qKe4oCrecci1YmBTw/68o
	snJcyeRrQ8pJYJjyYk4Bg4qPcT/QWrdployIu+hy2tsiQ4tiR+ZGN7VkfIwGarVjBZJzRQNiouONO
	tABAc1oA/IDm/eoY60dG39orCrc2IJjIYrybrpFCklv5lMDPu9xWK5tlWxyHy/zVfzUGLbMg5y1tx
	UE/+A3qRQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7kMo-0000S2-UA; Thu, 04 Feb 2021 19:32:38 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7kMm-0000R1-4N
 for linux-nvme@lists.infradead.org; Thu, 04 Feb 2021 19:32:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 590DD68C8C; Thu,  4 Feb 2021 20:32:31 +0100 (CET)
Date: Thu, 4 Feb 2021 20:32:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: jxgao@google.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH 8/8] nvme-pci: set min_align_mask
Message-ID: <20210204193230.GA14946@lst.de>
References: <20210204193035.2606838-1-hch@lst.de>
 <20210204193035.2606838-9-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210204193035.2606838-9-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210204_143236_323144_FED931FB 
X-CRM114-Status: UNSURE (   6.47  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, erdemaktas@google.com,
 iommu@lists.linux-foundation.org, kbusch@kernel.org, robin.murphy@arm.com,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);

And due to a last minute change from me this doesn't actually compile,
as pdev should be dev.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
