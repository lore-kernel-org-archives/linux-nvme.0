Return-Path: <SRS0=0e7J=G5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AECC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 05:20:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DEF422795
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jan 2021 05:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEF422795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NIaXykgfO/TUuaGeJSp94YK4joUqWJ71kKOTJ4c2a3A=; b=UvSqHWhXI0p+IK/0LI7WCSUPkV
	HfIb/Qj37nFZanp80P91fUiUNhxzbwsD11uQ/A8at2fA+G6SIAjj3gE8f7Gknr9YEd5Pyxiid8N7b
	erLLBno8ddnPyHIvtFg4EfBv08hbDP4/Z4WMxO2EqN3HAENrAG+MlvzqFx5jft9DF/N7Dm4o0SapV
	ndlRqmNDgvBxpfFPg+wz5TO37ffh9g2+NSj0b9Z7Bf2WUJB6w5AfwPTXs6mz2w3mnJKpEi+HdBR+3
	6v3ZVgyJhPkxdECHumoao/2QiPtiIq16UghJ8+iZRs+RiF+dRf/+iVWLnZYrEvMp31DVHVEeRyupZ
	T1gN6QOg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4GlC-0007Iv-7P; Tue, 26 Jan 2021 05:19:26 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4Gl8-0007IS-A0
 for linux-nvme@lists.infradead.org; Tue, 26 Jan 2021 05:19:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611638362; x=1643174362;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=dRJBB2ohZfDMJg1dRQlfKdgpXuSVE8/9m0yM8Jexxzs=;
 b=kktWWmS9fioEKPvFexbtFekC/VA685iY87+gt8hJmDLEkGWLjS70VWbP
 mRns4GMEDX55lDDkt+bXKmUNH6efpFntQ8Z4vwKlAeyGoA8GYvOkrEwvA
 29DCFBvnRJqo8etAvM/nALbCJNt4zXNKX5zkHRjkA0USKxsGXLZqCBB9S
 4YmnikGY0G/5MbYwjPZr/7MAylS5TI5I31QkQ4K2NMiMSuRLS8t/6akhp
 wqCj5bi4oeuXhuK8uUGGF4HkT9cmIGrur3UsTLya8yCuIf5cBY914bZA6
 cYuwApooFGialiSWSKBM6OWwzDLwf48mfxffqJbzMVrKhLgPosq0PfLlY A==;
IronPort-SDR: YAyrXxrps3z4EsK3Qu/8zx1TXon8FFNn/sqkuldAhnSC670IdqYeGD96XBSJuPH0HMyQwA1gE9
 3ypv8mYH+fe5zNFL4wgKGlz0DgIcDn3+nTtyVFRhKGwjbv08ECnV99Wg7rM2ub6nzuogTP/kWi
 iLxBFipsvfFTmQvUpKYtwlnbpFVyi8CFdL0Jfjlj34PfgV7yILa8DEQ1Wb0YmbWWvB0A5m6GR8
 HbCT8Ee7+S+RQB6aZjANDNAVSW9b+Ulp1twK4szgTUbxuDhY1EqzK6ag4R9IoYWhy/TTezp52n
 u+g=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; d="scan'208";a="159494588"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 13:19:19 +0800
IronPort-SDR: 37MeBU/rg07WGdxp3lT4KNMadgAXRMb+RGm9Wj3qcFAaiH9rwCCfxPB9koyuGTwr8JiRWhJYST
 xs7BRppFjOx+09DlDBWjq45jzhV4GcZgagfmGmE31QbJXzzqfAap0kYnu0niygvoQnfRfWCwJb
 8fBfJNT8CM3sw1I7w7UHsNbUkC3rh1sZ0f0PXVU6ftdgCa0ykYgsb2Df9ANHdkDGFqAC0VIU0h
 NuvVBa7+iQfHVsyp5MSnDLOhw9NTz2jHBV1o/10EbWZ9r4eWbAR5PqaxM36Zhr0CdXYdUfhZGq
 PbpN+wK6jqoKILBHExIoo0sQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 21:03:45 -0800
IronPort-SDR: PWjLFg/PGVxyqJcA8Q6mum/ZC4ZWIWTI6llJTrsf0pkGf/LlQDO0h91TC36EnoqkkiVPrkH/I2
 gjG0JgLZNkhNZL7H4kwIwh3sF8/A1BXUWKphU0GQ0Kpykq1cA9hjBBrSnCZUnKWjg2TDfHZjyy
 Utrh4wSRGQv2J4opIMI9X6MZZ4Vn3dXvagafT5A2HJdmYhpwb9VQkCFW3gGDdkDv2Pd6q/MXRf
 wOzSeEYxi8tnE1ufQC4IOT/ywjWRSqgI0AmzpI3vmjp4FljaDStwnLd87tTbIf1iwzX6Ly40E6
 SUI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 21:19:18 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-pci: add write-zeores SPCC quirk
Date: Mon, 25 Jan 2021 21:19:16 -0800
Message-Id: <20210126051916.3271-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210126_001922_475206_F8E586E2 
X-CRM114-Status: GOOD (  13.86  )
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
Cc: kbusch@kernel.org, chapman6235@comcast.net, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This adds a quirk for SPCC 256GB NVMe 1.3 drive which fixes the
following problem :-

[ 2745.659527] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G            E
5.10.6-BET #1
[ 2745.659528] Hardware name: System manufacturer System Product
Name/PRIME X570-P, BIOS 3001 12/04/2020
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
[ 2836.672064] blk_update_request: I/O error, dev nvme1n1, sector 16350
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672072] blk_update_request: I/O error, dev nvme1n1, sector 16093
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672074] blk_update_request: I/O error, dev nvme1n1, sector 15836
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672076] blk_update_request: I/O error, dev nvme1n1, sector 15579
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672078] blk_update_request: I/O error, dev nvme1n1, sector 15322
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672080] blk_update_request: I/O error, dev nvme1n1, sector 15065
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672082] blk_update_request: I/O error, dev nvme1n1, sector 14808
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672083] blk_update_request: I/O error, dev nvme1n1, sector 14551
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672085] blk_update_request: I/O error, dev nvme1n1, sector 14294
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672087] blk_update_request: I/O error, dev nvme1n1, sector 14037
op 0x9:(WRITE_ZEROES) flags 0x0 phys_seg 0 prio class 0
[ 2836.672121] nvme nvme1: failed to mark controller live state
[ 2836.672123] nvme nvme1: Removing after probe failure status: -19
[ 2836.689016] Aborting journal on device dm-0-8.
[ 2836.689024] Buffer I/O error on dev dm-0, logical block 25198592,
lost sync page write
[ 2836.689027] JBD2: Error -5 detected when updating journal superblock
for dm-0-8.

Tested-by: Bradley Chapman <chapman6235@comcast.net>
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 25456d02eddb..0c1e492e0c94 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3228,6 +3228,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
