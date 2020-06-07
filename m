Return-Path: <SRS0=DmOJ=7U=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99723C433E0
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Jun 2020 11:45:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C141206D5
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Jun 2020 11:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="D/mw56QS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BuDXyyOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C141206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XobowgPw4nRG1Cb70w/Rg0zH8CcOEv83A23r9pMB5zA=; b=D/mw56QSBZU2sE
	FtFswnivVVX22hm9UkyWVgB8216rx8pwzc++O0eUiYcdV/E7Vsw03GlL/jVXbN4gsejaN9R2wg5Cw
	aXIRkTfpptPkeacUxqL5dYTgEARxcl5Fsez+M0KyvHKp3xSSvmM/Xce1l4s4cuueghCL2J01zbUv7
	WpE7vNs99OfYkONQIFQBK8Ze3VSrVFv83YdMcTgZFA0u1VtLTjX8LiTu9VAYvAwuE2q27kJc1V2Ap
	5S87JXUuGM9uGwjdL0vFnuK8xfs/7aNIdK+A24S/BSJ9hBmgtUqtFNm4ZF6djUWUXGVNRq7XsVoJV
	FvF58bjVGl3aXnsYVGqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jhtkH-00050z-5c; Sun, 07 Jun 2020 11:45:45 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jhtkF-00050D-13
 for linux-nvme@lists.infradead.org; Sun, 07 Jun 2020 11:45:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1591530343; x=1623066343;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=S7kE+3rYo4NWaQHRLUyBuskqtYeCu0An8sg/ravi1Dg=;
 b=BuDXyyOUx0tnigTQvU0LApE0UJQMCF9EqycPg8dh5E8YNFRYXh01c2BH
 KeEBI85M1xHcOZKgOrYo5+oObC8cWuNYtH0GG0s3wWrjITNl/9JR6CF9l
 JhedGSXkIKWbzR28WUmOfyFjPSQD7fofflngziX/JcUDNSbVY0mR6zElU
 mF6Tfv+ygsZqo0Yank4re2ecS4aoUrhrEd9c6XMYQ7tiX15pjYvgFevvV
 NPSOLYY7tQJDIBeKkQUwQJP/dIQz4XuwDdik2HTVBR1NCpk6UB83x5lkn
 sydN9OyMSXDC9/xEs9xBwNTudK/7Lz3RjvDcRivdLnkpiv/WX9SzAASUv g==;
IronPort-SDR: 8jcMSorRSpAND7QbvGeZnF20OLG1f4WP9rJ0R1n0EW831XyulIEpR8N9PQLxcBHsTuaNmwm3P7
 hvGPMybdHmJyfBgTjQFwTzmZrP4HmHtbwYSoZUiqlRZrB+yfkGyYX8d6PkLFHgQXn/iPiXihbT
 85JdhaTIPp93UjJIo9RQ376lEz9V7gKB5EI3h8KhZ1PPG2mughbYfOzdE+x8D+WzqW1DimX3CD
 TE3toa0wToBxOZOvCwSJqPvrbJuR4fPQYPdP5p0wcM3x0hgdwIS+OsNVDRC6VNyDAWJyPj0ZF5
 5w8=
X-IronPort-AV: E=Sophos;i="5.73,484,1583164800"; d="scan'208";a="248509369"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2020 19:45:36 +0800
IronPort-SDR: C8uYc3uiHrXJ2UlTTlmg7iAxCbBAZiVegIZJkO3Ius2cv5Vmfkmqb1/8KVF7/zp4EW3L0kGpHs
 i6jXBLugkEbkKEbrl4dvQz+wY0Jv3lJR8=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jun 2020 04:35:08 -0700
IronPort-SDR: oq9KIwqGk2lsQJ2F7UpRsBjmE8rHamV0JijZJGpj0a7tWtXi9jTvsO03148VIHsma6npPFRlf4
 Oe5++k68rUnQ==
WDCIronportException: Internal
Received: from phd007118.ad.shared (HELO localhost.hgst.com) ([10.86.57.212])
 by uls-op-cesaip02.wdc.com with ESMTP; 07 Jun 2020 04:45:34 -0700
From: Niklas Cassel <niklas.cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>,
 Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH] nvme: do not call del_gendisk() on a disk that was never added
Date: Sun,  7 Jun 2020 13:45:20 +0200
Message-Id: <20200607114520.130756-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200607_044543_091287_47B70AE3 
X-CRM114-Status: GOOD (  13.33  )
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

device_add_disk() is negated by del_gendisk().
alloc_disk_node() is negated by put_disk().

In nvme_alloc_ns(), device_add_disk() is one of the last things being
called in the success case, and only void functions are being called
after this. Therefore this call should not be negated in the error path.

The superfluous call to del_gendisk() leads to the following prints:
[    7.839975] kobject: '(null)' (000000001ff73734): is not initialized, yet kobject_put() is being called.
[    7.840865] WARNING: CPU: 2 PID: 361 at lib/kobject.c:736 kobject_put+0x70/0x120

Fixes: 33cfdc2aa696 ("nvme: enforce extended LBA format for fabrics metadata")
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
An alternative would be to do like nvme_ns_remove(), i.e. in the error
path; check if ns->disk->flags & GENHD_FL_UP is set, and only then call
del_gendisk(). However, that seems unnecessary, since as nvme_alloc_ns()
is currently written, we know that device_add_disk() does not need to be
negated.

 drivers/nvme/host/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0585efa47d8f..c2c5bc4fb702 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3669,7 +3669,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	ns->disk = disk;
 
 	if (__nvme_revalidate_disk(disk, id))
-		goto out_free_disk;
+		goto out_put_disk;
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		ret = nvme_nvm_register(ns, disk_name, node);
@@ -3696,8 +3696,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	/* prevent double queue cleanup */
 	ns->disk->queue = NULL;
 	put_disk(ns->disk);
- out_free_disk:
-	del_gendisk(ns->disk);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-- 
2.26.2


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
