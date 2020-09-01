Return-Path: <SRS0=Ap99=CK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06621C433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6125206EB
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2020 15:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="duin4tIA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BHj68uZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6125206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AOmXsj1/yis9w0ThnMi2NsDV/6Rq23bQdYMkEaHhEeQ=; b=duin4tIAbdCxPo0TicHmh2vh+
	bWWt4p/jT2bC9YUdsp+iuaFbcc6P3ZTWJDAshfUpD6Cof0V6NQ8Fp/iLs1ZQtDjSsWqOtqEY5DTeR
	PbTk2sAuUblivMtrcT8kYD3apgB5utP84ddio8gxsawWzwwySaY/jsZ0x/+wGBB/31FYC1Y0gSsTD
	wIdC31mmosjSU/MdtzBME03Yh5tZPPkNwoKnr77V7DGaHZX9dkn+hBmY1oWzZyop3RB1ZApRgjRQ5
	lDuUQAedEP6nZ1S2lzCsgk+2hHVTL20hFkmxeKhNspXiAV8oyxj96AP9OmBxGoH0fo7lb9kfbUiYM
	LafOlmXdQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kD8fV-0002LU-1M; Tue, 01 Sep 2020 15:57:57 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fT-0002Kd-0Y
 for linux-nvme@merlin.infradead.org; Tue, 01 Sep 2020 15:57:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=K5eIje+dXHxfLWtnzeoqBqIaTntBT6FnczHUHcmj9NM=; b=BHj68uZerC2AED+VGnjrkLa0Jh
 nsJRW5vm091mrlQN4jasrWRgCM1ySYUPiKOPMQFvHehK/MlKtnHTq4wA553107TmfoWBqjYusFfYX
 hdHxpzv+daxEQOnuXf6LklRx/LX2GKJBoWUUuYJ/y29nMBNvIIiiJqjuYtLUkOMxx5BP8xZfY/Z4A
 CFzRy/RgRKCcS7Au+4o2s+j98ZQ2HjaNhxqv/ZtdIfcmckO7GlAMLvRgJLn00q/4ttYSbN93Dmike
 0zdupPRWnfslW66yg0S9XJuGo14FgsCVoZ5MV+EfsKdkYr2KNA9ctgbrNlF6+GHh2s9ZqbM0SlrKW
 GAfzhSYQ==;
Received: from [2001:4bb8:18c:45ba:2f95:e5:ca6b:9b4a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kD8fP-0004OY-KR; Tue, 01 Sep 2020 15:57:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/9] Documentation/filesystems/locking.rst: remove an
 incorrect sentence
Date: Tue,  1 Sep 2020 17:57:40 +0200
Message-Id: <20200901155748.2884-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
References: <20200901155748.2884-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Josef Bacik <josef@toxicpanda.com>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, nbd@other.debian.org,
 virtualization@lists.linux-foundation.org, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

unlock_native_capacity is never called from check_disk_change(), and
while revalidate_disk can be called from it, it can also be called
from two other places at the moment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/locking.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 64f94a18d97e75..c0f2c7586531b0 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -488,9 +488,6 @@ getgeo:			no
 swap_slot_free_notify:	no	(see below)
 ======================= ===================
 
-unlock_native_capacity and revalidate_disk are called only from
-check_disk_change().
-
 swap_slot_free_notify is called with swap_lock and sometimes the page lock
 held.
 
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
