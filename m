Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B518FC55182
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Aug 2026 03:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=18FSn5VpgGwA3Jxv/a+gf19wQDwKWHG3Oj6FPr8iG6g=; b=aM6pRkscXxs+Zx7P/yAzJajPe1
	rmSTOELMUteDxzSTKZ/GpnTErJyZ1f3VRf3TrnyP3q+DrJwHUqyfs70lfn4BMobww/PkXUgB9BaAY
	1uvszflYu62AM0NLsFYFy5z1plztFH7H6MxLmk1L3LLqF+k2uQm8KM27SDEI6s2gwPGCXx4aRoiqZ
	PpgAMRW3JpHV6gmiWiJfRkqKTqZWOHRXkAZxMQQ7GxP+PtSP/QqjauM78w6Fokb/fR6zR0N+/SSle
	1keMHTGGUZGCC6PqNFu5Tlp6eefDL+oXojYFjPwOipjrN93g8YdCjghc02LtEpjCnUvXc025oc5Ii
	JQALCUXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr5wt-00000000vmt-1dba;
	Tue, 04 Aug 2026 03:36:15 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr5wr-00000000vmQ-1nzp
	for linux-nvme@lists.infradead.org;
	Tue, 04 Aug 2026 03:36:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785814570; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=18FSn5VpgGwA3Jxv/a+gf19wQDwKWHG3Oj6FPr8iG6g=;
	b=oTEo5qSiV9oO9t2Ta3nEMY6BSkHdKeUt8VaEeNX6SsPK8YIelnDfVBGOfAqamNJHIaonTi6A1FPG19J2Fe0A3EOXqAi7N64UiEXhi3xv0ElLVrkBG9ByZtFzH7Z4GxIyzBhrAVjBsIdgnBQqyXfY5Ol7uwzmeH+KNVt44s3WoEE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X8MO5ge_1785814569;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8MO5ge_1785814569 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 04 Aug 2026 11:36:09 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Damien Le Moal <damien.lemoal@wdc.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: fix NULL pointer dereference in nvmet_execute_identify_ns_zns()
Date: Tue,  4 Aug 2026 11:36:05 +0800
Message-ID: <20260804033605.3973127-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260803_203613_652807_FEFC2DA2 
X-CRM114-Status: GOOD (  11.12  )
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

When a host issues an Identify command with CNS 05h (I/O Command Set
specific Identify Namespace) and CSI 02h (ZNS) targeting a file-backed
namespace, nvmet_execute_identify_ns_zns() calls bdev_is_zoned() on
req->ns->bdev. A file-backed namespace has no block device, so
req->ns->bdev is NULL and bdev_is_zoned() dereferences it, oopsing.

The I/O command set is selected by the host-supplied CSI field and the
command is routed here whenever CONFIG_BLK_DEV_ZONED is enabled,
independent of the namespace backing type, so any file-backed namespace
is exposed.

Reject the command with Invalid Field when the namespace is not backed
by a block device.

Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/zns.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index f00921931eb6..a13befd5f3ad 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -116,7 +116,7 @@ void nvmet_execute_identify_ns_zns(struct nvmet_req *req)
 		mutex_unlock(&req->ns->subsys->lock);
 	}
 
-	if (!bdev_is_zoned(req->ns->bdev)) {
+	if (!req->ns->bdev || !bdev_is_zoned(req->ns->bdev)) {
 		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		req->error_loc = offsetof(struct nvme_identify, nsid);
 		goto out;
-- 
2.43.7


