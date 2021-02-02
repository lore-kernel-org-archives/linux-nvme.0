Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317EEC433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 15:07:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7B4B64F80
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 15:07:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B4B64F80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TxG23v2np1Zctor2WQM2wFZ2aodKTuou6+mNsfKpZBo=; b=LFhmcG0sDfM2wUaby68r2kXGn
	j7dslNRWrpwy890rzr8yANoUvS+K6b+tbgOy5a/EUkoR/sn7g2TdjA6sD7om2VwgJ2QwPqB9Uk/Sq
	qXp/XC3jG96xgCM+JyXZSaUMN03o2F7hfVB3FdhbfiRVIkrFMjFmsP86F2HB7O9N1wA/SNftP6XxY
	wwxvAzpn5lEJIKtPZnkks/1sMshP1wYyblAqIpcpG7dvhJqHYbd/n/DwK/p1herkki4XT9JHw83tY
	iTikchoVcs/ySVx4SfD8heeWKktDaqG/R3SqsXroPfAbke+KPnejREtbWaSsobYgNva6czOduyG8F
	K7q8ALDJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6xGY-0005wE-Fs; Tue, 02 Feb 2021 15:06:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6xGT-0005ux-MV
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 15:06:51 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4396B64F7E;
 Tue,  2 Feb 2021 15:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1612278409;
 bh=y6VZLk8zLqmib1CZS2K7UGdPbpx6dCtj2tVUJ0W9ZpM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=F2RbEnI4+pC5ZUgEbW7RQWIujVErILwfFnAan1aRoZfQga5SI7VQGNevdo6UP1AdI
 eOs+IRBDqTWUT1WhDbBDKbNr52pf6X4txpSV4KIAMvPIsIHUKO2KfYdnn9al2kb8aH
 Ft5KqqBahsViwPfV1+d59bNRApzonJIyJgTbvJ33iUeyJXt22dn5mj+PBSxHCwCcPK
 bK0DxblluUUCKoakqTGUKKTY9i/rQII8DwYmnkzPEF1/VnmGc8q4EACspOHTvaM7Yj
 6yf8ztr6ljD9BbAPGoblMOh7gD951ASV/LPapIFgj7IN4dzAdQTJr9a/xG630Ug6Ty
 wWpry4njoP46w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 25/25] nvme-pci: add the DISABLE_WRITE_ZEROES
 quirk for a SPCC device
Date: Tue,  2 Feb 2021 10:06:15 -0500
Message-Id: <20210202150615.1864175-25-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210202150615.1864175-1-sashal@kernel.org>
References: <20210202150615.1864175-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_100649_956931_8436DFF7 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: Sasha Levin <sashal@kernel.org>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Bradley Chapman <chapman6235@comcast.net>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

[ Upstream commit 899199292b14b7c735808a37517de4dd2160c300 ]

This adds a quirk for SPCC 256GB NVMe 1.3 drive which fixes timeouts and
I/O errors due to the fact that the controller does not properly
handle the Write Zeroes command:

[ 2745.659527] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G            E 5.10.6-BET #1
[ 2745.659528] Hardware name: System manufacturer System Product Name/PRIME X570-P, BIOS 3001 12/04/2020
[ 2776.138874] nvme nvme1: I/O 414 QID 3 timeout, aborting
[ 2776.138886] nvme nvme1: I/O 415 QID 3 timeout, aborting
[ 2776.138891] nvme nvme1: I/O 416 QID 3 timeout, aborting
[ 2776.138895] nvme nvme1: I/O 417 QID 3 timeout, aborting
[ 2776.138912] nvme nvme1: Abort status: 0x0
[ 2776.138921] nvme nvme1: I/O 428 QID 3 timeout, aborting
[ 2776.138922] nvme nvme1: Abort status: 0x0
[ 2776.138925] nvme nvme1: Abort status: 0x0
[ 2776.138974] nvme nvme1: Abort status: 0x0
[ 2776.138977] nvme nvme1: Abort status: 0x0
[ 2806.346792] nvme nvme1: I/O 414 QID 3 timeout, reset controller
[ 2806.363566] nvme nvme1: 15/0/0 default/read/poll queues
[ 2836.554298] nvme nvme1: I/O 415 QID 3 timeout, disable controller
[ 2836.672064] blk_update_request: I/O error, dev nvme1n1, sector 16350 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672072] blk_update_request: I/O error, dev nvme1n1, sector 16093 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672074] blk_update_request: I/O error, dev nvme1n1, sector 15836 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672076] blk_update_request: I/O error, dev nvme1n1, sector 15579 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672078] blk_update_request: I/O error, dev nvme1n1, sector 15322 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672080] blk_update_request: I/O error, dev nvme1n1, sector 15065 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672082] blk_update_request: I/O error, dev nvme1n1, sector 14808 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672083] blk_update_request: I/O error, dev nvme1n1, sector 14551 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672085] blk_update_request: I/O error, dev nvme1n1, sector 14294 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672087] blk_update_request: I/O error, dev nvme1n1, sector 14037 op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672121] nvme nvme1: failed to mark controller live state
[ 2836.672123] nvme nvme1: Removing after probe failure status: -19
[ 2836.689016] Aborting journal on device dm-0-8.
[ 2836.689024] Buffer I/O error on dev dm-0, logical block 25198592, lost sync page write
[ 2836.689027] JBD2: Error -5 detected when updating journal superblock for dm-0-8.

Reported-by: Bradley Chapman <chapman6235@comcast.net>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Tested-by: Bradley Chapman <chapman6235@comcast.net>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77f615568194d..a4b169408bbf0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3248,6 +3248,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
