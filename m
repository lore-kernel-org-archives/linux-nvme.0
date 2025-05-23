Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09B3C54F2E
	for <linux-nvme@archiver.kernel.org>; Fri, 23 May 2025 13:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FjIVkrvWcGJqrRoEHsAxET1vwF+UKwgZFhzlHuLr1zM=; b=xuRU660iamzumd6Bye3F+0NOIe
	NrZYTSPY5MspfMO31uAnHVcjCVfRH3cugrpLWQvYqpNQyAfFU581JwsLOw4ckUJykws4S2TPxDmF5
	/5DLVgWY11xOAVZNMc46t5MKhSrwWzALPub1PF255H50XRHu21/frSRcdo00QxB/Dqkror1pphXTS
	NmNnKD/dmtaA/E9Q1LGJY3tEj3a97qSGKsIMbfDJZ60LqsXOrBCsv85W2w82G5HXRW4b5Qmk1pSh/
	sCVM7xGbeStc3uUAnQoxJI11+66mpJ8PctXyejXlijnGuPG6FMdbUZUi5OtZxVQKMaz6p8tNBnI9z
	70J9bqAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uISOE-00000003wlI-13Uj;
	Fri, 23 May 2025 13:24:46 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uISIC-00000003vdQ-05C1;
	Fri, 23 May 2025 13:18:32 +0000
Date: Fri, 23 May 2025 06:18:31 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5/5] nvmet: implement copy support for bdev backed target
Message-ID: <aDB1p8XIhsauGFhc@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-6-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521223107.709131-6-kbusch@meta.com>
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

On Wed, May 21, 2025 at 03:31:07PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The nvme block device target type does not have any particular limits on
> copy commands, so all the settings are the protocol's max.

I need this additional bit so that the host code actually see the
copy support:

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index c7317299078d..355cb67a8b74 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -734,7 +734,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
 			NVME_CTRL_ONCS_WRITE_ZEROES |
-			NVME_CTRL_ONCS_RESERVATIONS);
+			NVME_CTRL_ONCS_RESERVATIONS |
+			NVME_CTRL_ONCS_NVMCPYS);
 
 	/* XXX: don't report vwc if the underlying device is write through */
 	id->vwc = NVME_CTRL_VWC_PRESENT;

