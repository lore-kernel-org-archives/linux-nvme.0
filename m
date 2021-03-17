Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D022C2BA4C
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 00:58:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911EA64FF5
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 00:58:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911EA64FF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lCAU7jrmkSW37OKAyJUxb31H1rhkHrEw+2T3HDAyM7U=; b=TXDEIlybdmrrpJBqE257byeKW
	z3wW0Ft7cGdzY41QxtS2Luia1oiCiOP0QGrLjCJoEgiPTJP+VitP14yT19UtHIOI7nd24AnnFTADu
	qXbrjE3qahXFCantC0vpaHe5UkxOuYsfXyO8P/37vv2TP+C15E+vmdPBaeotD3dvIg2E9/LNbT2dp
	8nxz4GjFlE6o9wi2B8N9mj7QdHEPDuO6MvMe9UjLDgjoexx2SpV34WilmIYNk3DGPRwYEgHDChbb6
	FdecAG/e27bTHlZBK3prf/y0ApVA25kJ7U4kbphVGVrFN51FP7JocHBzd/qsbo1sGaBB08qp4UNT4
	3tFBPhBJA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMKWC-0027ZM-3g; Wed, 17 Mar 2021 00:58:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMKUQ-0026hN-5M
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 00:56:51 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id EFB5264F9B;
 Wed, 17 Mar 2021 00:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615942604;
 bh=gR+XjA2GvUDUPqy8DoHaelmXBzQE5a6V+SzzSf7OFhg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YDuWHPukzx3dW+QmXS5vIejl2dWpJuiVFGA8wpyNMjvSd7N5xapyQtz6dN/DQbsRO
 a5eV3dkqt7svR9FVqDj0OxxvKC+b3koRGSQl8w5zzUGxyoT8sLM3Ilm+RZq/vieXvn
 YmbE/xZu/Zi2MrVMU/kO5FWKhx1XX3UO6KKDw6T24rkYJO3Ql/We8hZ2qpXW7S0NFy
 YaB7PWwf0zjq4dYBuJwU32YYpG55G7DgowxfqAhc6fGGNxlp7ImO4CPdD+3Q4f0gNU
 LJ77lE5Rxg3lGWvRi/iu/QJSdSVHrKsspdQDrNxao2l58OAvYBCjj2gLmEJJbW1jEZ
 idIOh7G0OfaZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.11 55/61] nvme-pci: add the DISABLE_WRITE_ZEROES
 quirk for a Samsung PM1725a
Date: Tue, 16 Mar 2021 20:55:29 -0400
Message-Id: <20210317005536.724046-55-sashal@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317005536.724046-1-sashal@kernel.org>
References: <20210317005536.724046-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_005648_370879_C3DD7222 
X-CRM114-Status: GOOD (  10.78  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>

[ Upstream commit abbb5f5929ec6c52574c430c5475c158a65c2a8c ]

This adds a quirk for Samsung PM1725a drive which fixes timeouts and
I/O errors due to the fact that the controller does not properly
handle the Write Zeroes command, dmesg log:

nvme nvme0: I/O 528 QID 10 timeout, aborting
nvme nvme0: I/O 529 QID 10 timeout, aborting
nvme nvme0: I/O 530 QID 10 timeout, aborting
nvme nvme0: I/O 531 QID 10 timeout, aborting
nvme nvme0: I/O 532 QID 10 timeout, aborting
nvme nvme0: I/O 533 QID 10 timeout, aborting
nvme nvme0: I/O 534 QID 10 timeout, aborting
nvme nvme0: I/O 535 QID 10 timeout, aborting
nvme nvme0: Abort status: 0x0
nvme nvme0: Abort status: 0x0
nvme nvme0: Abort status: 0x0
nvme nvme0: Abort status: 0x0
nvme nvme0: Abort status: 0x0
nvme nvme0: Abort status: 0x0
nvme nvme0: Abort status: 0x0
nvme nvme0: Abort status: 0x0
nvme nvme0: I/O 528 QID 10 timeout, reset controller
nvme nvme0: controller is down; will reset: CSTS=0x3, PCI_STATUS=0x10
nvme nvme0: Device not ready; aborting reset, CSTS=0x3
nvme nvme0: Device not ready; aborting reset, CSTS=0x3
nvme nvme0: Removing after probe failure status: -19
nvme0n1: detected capacity change from 6251233968 to 0
blk_update_request: I/O error, dev nvme0n1, sector 32776 op 0x1:(WRITE) flags 0x3000 phys_seg 6 prio class 0
blk_update_request: I/O error, dev nvme0n1, sector 113319936 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
Buffer I/O error on dev nvme0n1p2, logical block 1, lost async page write
blk_update_request: I/O error, dev nvme0n1, sector 113319680 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
Buffer I/O error on dev nvme0n1p2, logical block 2, lost async page write
blk_update_request: I/O error, dev nvme0n1, sector 113319424 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
Buffer I/O error on dev nvme0n1p2, logical block 3, lost async page write
blk_update_request: I/O error, dev nvme0n1, sector 113319168 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
Buffer I/O error on dev nvme0n1p2, logical block 4, lost async page write
blk_update_request: I/O error, dev nvme0n1, sector 113318912 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
Buffer I/O error on dev nvme0n1p2, logical block 5, lost async page write
blk_update_request: I/O error, dev nvme0n1, sector 113318656 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
Buffer I/O error on dev nvme0n1p2, logical block 6, lost async page write
blk_update_request: I/O error, dev nvme0n1, sector 113318400 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
blk_update_request: I/O error, dev nvme0n1, sector 113318144 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
blk_update_request: I/O error, dev nvme0n1, sector 113317888 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 806a5d071ef6..514dfd630035 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3242,6 +3242,7 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x144d, 0xa822),   /* Samsung PM1725a */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
+				NVME_QUIRK_DISABLE_WRITE_ZEROES|
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
