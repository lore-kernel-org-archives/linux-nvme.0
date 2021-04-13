Return-Path: <SRS0=BJyz=JK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8158C433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 06:52:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41FAC6128E
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Apr 2021 06:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41FAC6128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rL4VJLzH1RKCXbBXunF6KRKkRloE3pWzsCHEc7QNmOI=; b=Od1MPn4KzJxGfDVbpR1fFC3fJH
	PJLAxqScv/3P2sFBbjGDVn4zDTinVWhjI+O2w8M6zHXPef9VWgIdA6yIXyq4uYZC2AmAZKdiV3Hii
	uWobmoC5jBaxEIt0GAuimlhzArvYbPlucL7l7XPwKNkp34W2ToKfgG/T6d7P+DfGBO2rGrg1Z8O0H
	hDwoFg/yiOXK/gDYDpETjPE18YT4EhUeYbwca3s1XHlWSj/lrw4FGC5KPUWnStAgyRoRqN1Sp3mTz
	/VRW9XEOcOSaiBx35YoBjqVDmtfWn65wegccb0Q/2juuHPd3EG79k7gPSWxTJjP5E3pSJzzHilSAd
	zyPlhRJw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lWCu9-008R5E-F3; Tue, 13 Apr 2021 06:52:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWCu7-008R55-AH
 for linux-nvme@desiato.infradead.org; Tue, 13 Apr 2021 06:52:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Type:
 Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:Content-ID:Content-Description:In-Reply-To:References;
 bh=PKC8LejtA0DqTJYm6L2J64/mhAvGye2UKglBDVLmp74=; b=U6b55Jp570OZcdWErKpm7fdQRJ
 ZlcnRUCM9SqnRApGNEjbi09PYXBNmbQpRCxi0xxLTxPNNFeq0VybW1WY7Vcpp3uQYTz5JtBDkIOUA
 v9zZyGCci0hs1agbZg5NFDL+vFu1dXLb3QKdmzv0OIr80h4luQxzVccYR1FNRm7alvRMQf/avK2wO
 AXY9cqxA1vQq61RjKBCi9O7PE/XaWjWhrkSpURj/ZgR5LTytyhsurkoWDafzYw9vw7oLyNsSGoF8K
 mPQ7fiXnrTYGoFMLqCvh9OWsQMsfhXi1iJOEZP/uagQ8hdnqKsDiu9ak3q/gFF3VJuveCW4+U//7z
 VkLXPDYw==;
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWCu4-006mOF-99
 for linux-nvme@lists.infradead.org; Tue, 13 Apr 2021 06:52:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618296721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PKC8LejtA0DqTJYm6L2J64/mhAvGye2UKglBDVLmp74=;
 b=X6F8LgNP+sG51td+bZ4L6er/v8ivcgcWjw+3ZKWyufCy9EFZfmgzcjLZ6uzteYS+TE1aod
 srr1Qsz/SF7dAb01Q/uoLEI8On0MH7RukbuYsy213yuelUvJ/TIX7ws2EYYevcqU3m1TjX
 1UgBPG4Ea33Vy6XLwC8oHs4HbWgpU8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-2Fy1E4oWPsyApXpu5j2PSQ-1; Tue, 13 Apr 2021 02:50:01 -0400
X-MC-Unique: 2Fy1E4oWPsyApXpu5j2PSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7937B814339;
 Tue, 13 Apr 2021 06:50:00 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.64.242.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 684B150DE3;
 Tue, 13 Apr 2021 06:49:58 +0000 (UTC)
From: Gopal Tiwari <gtiwari@redhat.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org
Cc: gtiwari@redhat.com
Subject: [PATCH] Fix NULL pointer deref in nvme_ctrl_fast_io_fail_tmo_show
Date: Tue, 13 Apr 2021 12:19:53 +0530
Message-Id: <20210413064953.541394-1-gtiwari@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=gtiwari@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_235204_441110_86EB9A39 
X-CRM114-Status: GOOD (  12.63  )
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

When accessing fast_io_fail_tmo from /sys hit kernel crash

 #7 [ffff9ddf82467d80] page_fault at ffffffff90e010fe
    [exception RIP: nvme_ctrl_fast_io_fail_tmo_show+22]
    RIP: ffffffffc0465116  RSP: ffff9ddf82467e38  RFLAGS: 00010286
    RAX: 0000000000000000  RBX: ffffffffc0476260  RCX: ffff8b617fe94000
    RDX: ffff8b617fe94000  RSI: ffffffffc0476260  RDI: ffff8b5e45a303a8
    RBP: ffffffff912b7d30   R8: ffff8b5e45a303b8   R9: ffff8b618dae5900
    R10: ffff8b617fe94000  R11: 0000000000000001  R12: 00000000ffffffff
    R13: 0000000000000001  R14: ffff8b617f46ee00  R15: ffff8b60e9a56380
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #8 [ffff9ddf82467e30] mutex_lock at ffffffff90d4a5ce
 #9 [ffff9ddf82467e50] sysfs_kf_seq_show at ffffffff907b0abb

Fixed by the checking opts for NULL.

Fixes: 09fbed636382 (nvme: export fast_io_fail_tmo to sysfs)
Signed-off-by: Gopal Tiwari <gtiwari@redhat.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 314705da2c10..39b8fbe87adb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3752,7 +3752,7 @@ static ssize_t nvme_ctrl_fast_io_fail_tmo_show(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	if (ctrl->opts->fast_io_fail_tmo == -1)
+	if (!ctrl->opts || ctrl->opts->fast_io_fail_tmo == -1)
 		return sysfs_emit(buf, "off\n");
 	return sysfs_emit(buf, "%d\n", ctrl->opts->fast_io_fail_tmo);
 }
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
