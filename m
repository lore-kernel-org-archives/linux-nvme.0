Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5966C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 07:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P1S8zoVjmiogd3HCEeod/C/DMqI6dXD7xQjPEtbSfiM=; b=lyZerQhU2/2c/SR5ra3whJ3MUR
	iQ9FCV/eeunFPGqweu6HpdRUM7b9xWe0g/4Z3jyStrGdNpp3Rf3MJagZLyn6UdBeLmI7uGBJ/vIFe
	uShC6LDEs4jJL/gUnVyk4q3rBF1DHxnXiNEiuGHCJ+emGP2jIZ3efk6yMdAkSEl9t9+Ixp8Mva+YF
	uxLyfnlZ04K7/HW43imJ0QkcIqo9SbYNefiVuNfoPXpRVVajn9Up+H2XhzQ4W3QMSFvlPNAPKupFe
	ZM2unGki2Ji/K/RZakHBjnRj9KkU49wqA4QW4URwAxBgbM3FW1XlFZG1qJEP6lINHsQQrhp3/i519
	2UkTd/rQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osJLu-003Tea-0p; Tue, 08 Nov 2022 07:48:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osJLo-003Tdj-Ox
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 07:48:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2DF4067373; Tue,  8 Nov 2022 08:48:47 +0100 (CET)
Date: Tue, 8 Nov 2022 08:48:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: nvme-pci: NULL pointer dereference in nvme_dev_disable() on
 linux-next
Message-ID: <20221108074846.GA22674@lst.de>
References: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_234852_972348_BE715A0C 
X-CRM114-Status: GOOD (  11.83  )
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

Below is the minimal fix.  I'll see if I sort out the mess that is
probe/reset failure vs ->remove a bit better, though.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f94b05c585cbc..577bacdcfee08 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5160,6 +5160,8 @@ EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
+	if (!ctrl->tagset)
+		return;
 	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
 		blk_mq_quiesce_tagset(ctrl->tagset);
 	else
@@ -5169,6 +5171,8 @@ EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
 void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
+	if (!ctrl->tagset)
+		return;
 	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
 		blk_mq_unquiesce_tagset(ctrl->tagset);
 }

