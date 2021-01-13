Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29999C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 21:57:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A420C23136
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 21:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A420C23136
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V/OSr/FU9+1jUfzo8Tdc9VRxmKlXo6kGxKr1ONA77wU=; b=kwCjGDnIIS1mBXu9ZEIl8HUS0Q
	8U/+ZMk7+8e/tXD8yXjMAlscjjqjOLo3E83LuEtnAf6hbk8RjsF+NxuqAzH24qc+DXiyPM+ogINFO
	xl60n00Cj6U1+y2dr9HYtS8MulViAoHgT7IUIjTpO9Jy73dHkEbrW/mzI4qZymhb9bZ8YU+XWVv0r
	j11cFLkjvsfpnDzeOSpGGzx9k6SPGAOnfesJcNhRp/J+dM2oFBYfC74uHOT0etvp9YX10ReMfe0cw
	ElcROSr60TENDurl0/gWnuAu2F48BU32JeeGV3a5V7DC+dSFexqTGvQhzbGJm+vSjH6X0byw7XTr5
	iHvMcFpA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzo8Y-0005Ia-Mj; Wed, 13 Jan 2021 21:57:06 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzo8W-0005HE-6t
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 21:57:05 +0000
Received: by mail-wr1-f43.google.com with SMTP id w5so3701280wrm.11
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 13:57:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IHjGm60tqa8W5pdU5sGxvbMUWOnZwDBfwNw5s24adBY=;
 b=pE9uc9n4VnqPxnQdYFmLy2QbO4psk7ywOQ14vL5L3wKk2AdVRjOpHfNJr3nXMuCXHH
 lsBdajK/aLrg6RRBkKIhsS5y+lbZq+8SZBJjce4z6XjtGxmBXCkfly8LdQK+gz3s/fb+
 8dnnGO6uBCcmi+ng5+5gugKRKm5xPREVOP3MTLYwlxp4gclcvHsG1mnJWglQS4CwHBtV
 UR0OWlixNj8BNwUTbBvuyoLiciTxeAiODsJbGkM+FXZLn0DDhX/f4EDBH5lrnjbygN67
 6mIop4l7Sv98mOU0D1LUov4CyW+62kkKK7AIM5D+qJqYHh1J0CddZEJaUjDEC8hYqyHv
 IC3A==
X-Gm-Message-State: AOAM530L8Z+MhZJyUkmtSJZz6qdUX8NjVAiCz+3ENfOOwpd7hh2H+grM
 Z+y/5WsssJK91V0SWq3teUY=
X-Google-Smtp-Source: ABdhPJw+24pLDdJag5dJgoXfLThVbj6UpX6mmLp8zLoB9/vW44+jqh19/dT80PFsUtn+dKiirwl1JA==
X-Received: by 2002:adf:e590:: with SMTP id l16mr4662311wrm.294.1610575022639; 
 Wed, 13 Jan 2021 13:57:02 -0800 (PST)
Received: from localhost.localdomain ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id l8sm7205124wrb.73.2021.01.13.13.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 13:57:02 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2] nvme-tcp: fix possible data corruption with bio merges
Date: Wed, 13 Jan 2021 13:56:57 -0800
Message-Id: <20210113215657.1613817-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_165704_289340_DC19BA9C 
X-CRM114-Status: GOOD (  15.44  )
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
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes from v1:
- use iov_iter_single_seg_count instead of poking into the iov_iter

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 979ee31b8dd1..1ff6d6c5eb41 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -201,7 +201,7 @@ static inline size_t nvme_tcp_req_cur_offset(struct nvme_tcp_request *req)
 
 static inline size_t nvme_tcp_req_cur_length(struct nvme_tcp_request *req)
 {
-	return min_t(size_t, req->iter.bvec->bv_len - req->iter.iov_offset,
+	return min_t(size_t, iov_iter_single_seg_count(&req->iter),
 			req->pdu_len - req->pdu_sent);
 }
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
