Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6E4C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 18:25:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DFE7233EA
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 18:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DFE7233EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RcB4YXIBqKOYHlYG9DzNMdcEoLR+kGOBWNXf+QWqzQI=; b=zBhlyT2ONq7Fe5ry/wetY1jl1o
	+VnMKMSJwkd3gnZFpa/s67cC+JhidAnAaoFhjRYlYc5aRZ9QfKjBH7pGkHzoPqJSgtW8RmHOeQKkk
	MWG05DSQQdRZ8g1cf2pBDrYhbE1iYubtU0kTMuSVyYFcxRP2fToHuUbYlsfbMJZ5gcK9iif+TnMsC
	QowdsjXn1xRJdreTyC6qQm3PO2BNJ6nFzFtiqY0yE1haUBsdSvwZyyt3qhg6KcRnod4W+z8ijEY2C
	inxAOK+7XFBgxEq6xdC2HS+Kf4uajoTtSyuXXvb+PeXCbpUfx12WpOHDwD6qz6Q8pkBEKFlPe0hVy
	vb+V2fNQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzkpI-00011N-L3; Wed, 13 Jan 2021 18:25:00 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzkpG-00010U-7p
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 18:24:59 +0000
Received: by mail-wr1-f46.google.com with SMTP id d26so3147379wrb.12
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 10:24:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zzixDA8LaBIkKxuRTPP9uUmCLeaxVcWn2NPNuUsUdlg=;
 b=NuSRWnT6kJDDyOtlfIDmhZpqmQuP8YXxLec2kfpWuQb/k2CffqNaaAIP0wciz6z1eW
 iAxsXyOP2SrxtTi0lkroQe79Gv9ErSmxx+o3K6oE40PpP9BhwfJEHI7VddcDRzXwFz/L
 gWLvVLuNzBS9Oyz47crqqGkjReyOm0vsT/mYFp/d//qWJql3P5LOHEsV3bfYcD2RnFe1
 U/zFLcS7AqYblRUZS/+zD/8MCwBwa5Ro32d7op5fNLKYHbDY5GkeKJilfBePiOnmzexm
 rp99gojRvBRItBoszohSBD1Sr9pleV46tomWlZxg+6bH6awulML4yZAHpFCpz+dQM1/p
 Ligg==
X-Gm-Message-State: AOAM533nUR9biGtZxFOmF6AArHpToKG1ALyrw7cHPDImYdGF9bjqqd3D
 GppVYD5Y8nJ/7u+i/vIGx7c=
X-Google-Smtp-Source: ABdhPJz2xthMi/nP/5nc/xHXDq8gwb/m1r2csm141eSl5dOt+PKCCgrrFcPbJyiuo7YkLX+fMaz/IQ==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr4068215wrp.14.1610562294864; 
 Wed, 13 Jan 2021 10:24:54 -0800 (PST)
Received: from localhost.localdomain ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id q7sm4299382wrx.62.2021.01.13.10.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 10:24:54 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-tcp: fix possible data corruption with bio merges
Date: Wed, 13 Jan 2021 10:24:49 -0800
Message-Id: <20210113182449.1580181-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_132458_316310_6749E34D 
X-CRM114-Status: GOOD (  14.37  )
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
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When a bio merges, we can get a request that spans multiple
bios, and the overall request payload size is the sum of
all bios. When we calculate how much we need to send
from the existing bio (and bvec), we did not take into
account the iov_iter byte count cap.

Since multipage bvecs support, bvecs can split in the middle
which means that when we account for the last bvec send we
should also take the iov_iter byte count cap as it might be
lower than the last bvec size.

Reported-by: Hao Wang <pkuwangh@gmail.com>
Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Tested-by: Hao Wang <pkuwangh@gmail.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 979ee31b8dd1..ad0332477986 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -201,8 +201,9 @@ static inline size_t nvme_tcp_req_cur_offset(struct nvme_tcp_request *req)
 
 static inline size_t nvme_tcp_req_cur_length(struct nvme_tcp_request *req)
 {
-	return min_t(size_t, req->iter.bvec->bv_len - req->iter.iov_offset,
-			req->pdu_len - req->pdu_sent);
+	return min_t(size_t, req->iter.count,
+			min_t(size_t, req->iter.bvec->bv_len - req->iter.iov_offset,
+				req->pdu_len - req->pdu_sent));
 }
 
 static inline size_t nvme_tcp_req_offset(struct nvme_tcp_request *req)
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
