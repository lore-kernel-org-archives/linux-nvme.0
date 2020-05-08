Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26E5C4724C
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 16:16:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8327C206B9
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 16:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O3GJ19Is";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvCuDbAI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8327C206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=c5ALsNZNVefMVaEgY4lpcZXWURl7URhhbaMS1WWwheg=; b=O3GJ19IsPb6hW5
	tpYQh63CkvZg9XOj0/iXtYjWWsEYsUuA+xp0vaeKGMNX3r4onMnnMQDszu4hpCaPiSIpKEoaNd3bA
	xDJQM7HK/t4Zme6SVS0vTXeLNTmRgSw9ZxbrhWIxI2lhuatVXYVDNHyL2jQvMjrnbSwwz9Py50nGX
	tbS9TSuWnS2PXdAicCd0NkK/p6vdX8jUs4030QRAEkm4f+3rLNuLG9UUQ78SYmQT9jpaICcQmrmjc
	tY9yQOD4msoc1hOZC+/plkUPbcrGKe2x6v4tD+4/eWxAGAH9YR8xj9+IwngelFD3qVMnOmvKcSHgv
	GOsJSGlcBjT2oNfoZ0gQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jX5fn-0004xd-9j; Fri, 08 May 2020 16:16:27 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jX5fk-0004w0-3y
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 16:16:25 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2CEC1206B9;
 Fri,  8 May 2020 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588954583;
 bh=hwJCAAbdcufl+vVPcJlNyZl8MJ2d6DW57Cahcc++qYQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VvCuDbAIr8htgpLvFtAj2PFlbR4VpJkAd8UTBzK6JaBeZ5Xjkl4VQJmyyNMkIT/ZL
 f6LrGT8eK9G2cFn4qL3uIbEJBROQzcqnVeOBkIhFa0zSlxKWqUy/zPIkuJ2Ha/SGQV
 ITJsV5+VLUix6IVOctRBr0rDKjIePYSrvgJ6ALG4=
Date: Fri, 8 May 2020 09:16:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] nvme-pci: slimmer CQ head update
Message-ID: <20200508161621.GB2622778@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200506163104.GD12919@willie-the-truck>
 <3453193c-424b-1e4c-16be-279088612c68@arm.com>
 <efc85e9a-93a6-989b-b8d7-db83b5d74b96@huawei.com>
 <6673a108-c572-12ff-7ddd-b88147829615@huawei.com>
 <4dae5990-e81b-8b33-dafc-ee47e4f06b6a@arm.com>
 <e1643b53-d362-0b5e-573f-72f0ea249ebf@huawei.com>
 <20200507142352.GA2621422@dhcp-10-100-145-180.wdl.wdc.com>
 <8b297620-c72b-2184-36cb-032f5cfda05c@huawei.com>
 <20200507153506.GA2621480@dhcp-10-100-145-180.wdl.wdc.com>
 <6b573185-c6a5-501c-7db2-befacefa3701@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6b573185-c6a5-501c-7db2-befacefa3701@huawei.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200508_091624_195869_BB71C443 
X-CRM114-Status: UNSURE (   9.69  )
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
Cc: sagi@grimberg.me, Robin Murphy <robin.murphy@arm.com>,
 linux-nvme@lists.infradead.org, Alexey Dobriyan <adobriyan@gmail.com>,
 axboe@fb.com, Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 07, 2020 at 04:41:01PM +0100, John Garry wrote:
> I have an FAE contact, who I can ask. That may take a few days.

John,

In the meantime could you see if the following resolves your
observation?

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e13c370de830..8e96ec6eed61 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -989,6 +989,7 @@ static inline int nvme_process_cq(struct nvme_queue *nvmeq)
 
 	while (nvme_cqe_pending(nvmeq)) {
 		found++;
+		dma_rmb();
 		nvme_handle_cqe(nvmeq, nvmeq->cq_head);
 		nvme_update_cq_head(nvmeq);
 	}
--

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
