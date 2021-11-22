Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25299C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 11:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6PYoMeGCrhKw6go/xwlVv57ulzna+IWPOUF2+Y6d+Cw=; b=sAPRIJSLH+RVKEtFjwRXQX14t+
	6Yqnng1M8zEV/DwKE3Iyn6asMxtj43XC89CJE8zyQHPb6XT6XkKoBW1/6E76Ru8QahW/H3x77Rvax
	uU1nQWDKcGw7YVVXyR8S6SqBqZDM32VlMv9MKfHiT6hZl3K5UrK/oJfs+fxjOx8C87MzLoo7+RNmY
	wwm7Mbb0vF5+LLcVPhS/RgNCpHliOgedbYCs7ahlbLXKn2D9TuIGiCdveh7t/9KnlFvm0k7Tkupad
	Q4zJfsdxHoxYG5QUHoTf6/0BXMiWYd//2bxtqmBWbGn1ORwdQcnX47iYA+kscI9+q+M1EH01+5BzH
	Vy9vVW+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp7Og-00G1wl-Ae; Mon, 22 Nov 2021 11:22:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp6FX-00Flv9-Cx
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 10:08:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637575714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6PYoMeGCrhKw6go/xwlVv57ulzna+IWPOUF2+Y6d+Cw=;
 b=TsJJdu6cRckN3idv23u3Vok4+iUXTy+KDQ4+JTOXxVlesZZ1Oe3V568jH6BTqhdYFcuHOb
 URfIO/9k59A0iOZwTygYmWFVo1zHeHZ8ApgWeqqZeFMzgR9+y9V9B7mQivWTtAmuH2hlKH
 TOS7O9KTY05XbPBKHUf8givFOiAXnt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-m2oCBzNkPt-zHylmmeMaNw-1; Mon, 22 Nov 2021 05:08:31 -0500
X-MC-Unique: m2oCBzNkPt-zHylmmeMaNw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 001BEBBEFE;
 Mon, 22 Nov 2021 10:08:30 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53BBF1F43E;
 Mon, 22 Nov 2021 10:08:28 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kch@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCH] nvmet: use IOCB_NOWAIT only if the filesystem supports it.
Date: Mon, 22 Nov 2021 11:08:27 +0100
Message-Id: <20211122100827.290117-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_020835_561313_F5AF8961 
X-CRM114-Status: GOOD (  11.37  )
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

Submit I/O requests with the IOCB_NOWAIT flag set only if
the underlying filesystem supports it.

Fixes: 50a909db36f2 ("nvmet: use IOCB_NOWAIT for file-ns buffered I/O")

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/io-cmd-file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 6aa30f30b572..136b14853ed7 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -8,6 +8,7 @@
 #include <linux/uio.h>
 #include <linux/falloc.h>
 #include <linux/file.h>
+#include <linux/fs.h>
 #include "nvmet.h"
 
 #define NVMET_MAX_MPOOL_BVEC		16
@@ -266,6 +267,7 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 
 	if (req->ns->buffered_io) {
 		if (likely(!req->f.mpool_alloc) &&
+				req->ns->file->f_mode & FMODE_NOWAIT &&
 				nvmet_file_execute_io(req, IOCB_NOWAIT))
 			return;
 		nvmet_file_submit_buffered_io(req);
-- 
2.27.0


