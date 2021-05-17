Return-Path: <SRS0=YADc=KM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC43C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 22:37:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D5D6112D
	for <linux-nvme@archiver.kernel.org>; Mon, 17 May 2021 22:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D5D6112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Q3ewysb4zVEPh6YVxwgqS3n5LSSaAsKQYxNnhl8agyE=; b=CvsO1xKr65WNJJQL0+gzOxg+Qv
	Vari2SkLguGnVoDw6bdvPIqyVRVOnXjJjtUznHYoXmGZ/HFAJjvzg3bTQOCCN0srdCXV0NkdynjGD
	4Legv/yjE+fWPLajM44QXyxlL8RvJzRjN9oKkvxR1BTG6lDubf9eZd1y8sXLfrEPH728/xEZze8Wv
	UptrTmQz9pvGUC4N3QYn+YARkD55Y7t8fQQJRz05+oqC0A4P2ses0uAv8NyZ052T+04e8qv/RW5yi
	emKh7EeRV6mXfgrCiuD2BBZ3bTtsQUX711tI8R298WihqA8bdDanmvKCcLLjfiH/Qvua9B3J1RAwP
	tKwz06xA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lilrG-00GJrQ-Ie; Mon, 17 May 2021 22:37:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lilrD-00GJqo-CN
 for linux-nvme@desiato.infradead.org; Mon, 17 May 2021 22:37:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=eb85AcXtsIUPDt4ucECfuu3DA6/+BTAh5JLQ5HosI7c=; b=qJKPC85EaK0qKYSein9k5J1/iD
 7S4IjYLOGy+5DpWFwdt3Xvn74gQRukXj25yD8aJShMvsPNm6nJIvuth0g69ScW8EBS1L1gpqTUbdL
 KeOjxNj69JFDDe+YW+yPJJPakNe5HemQFGiVoJK+7ZXBk2gRUzl5aR+jhGOeahOD/6UPhe5x4sQMx
 ri1tSFetrSSZxwN+J6OjgawFUsQWPpFQZSiC/usiEFSRiRulbSlpqLDMNHGK1R09GM5BFLejd9OvY
 dJXSNOk2+LVSfXClLbhppvYvtQWqgIccnBEyFK9Md/Vv+wu8riubNYMpFtV2E6u1d2co0neyBguWd
 196dfeKQ==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lilrA-00EBwd-QP
 for linux-nvme@lists.infradead.org; Mon, 17 May 2021 22:37:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1576260FE4;
 Mon, 17 May 2021 22:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1621291020;
 bh=X0aq66tKDEmTFNqonYWaIzboskqm//uCQ+k2qNa9GjA=;
 h=From:To:Cc:Subject:Date:From;
 b=K4xDkWrMLNWDdmU+kJFol9NMTvTz5ITX4mkDUK8Q1Az2EWEM92JB6RECRAjc8Aw6V
 FL8aAaJS//aj8ZMQ6614P3ErGp7HzETtF8mVN3PO8gXSh28Jhr09kGASBbW11y75MY
 RrFRewI7AxIujvaK7qGMWVdRopRawkYWycqmUuHHlDuFEoCx6hQHp4khMe+H+3OfhI
 CMrM9/1lhnA6JRKfl4WeEsS+NuyJQ+RQT7jJDNAtwSRyqz8/mNYxs/2jAXi3dB303S
 +Z0LmFwsDLhVycWRw5oMO8O0guBAOz0QOPT8mMMpckg2eOxkl9BBbOrqk/KIkZf49R
 nmZRguEzfCxWg==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Cc: hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: [RFC PATCH] nvme-tcp: rerun io_work if req_list is not empty
Date: Mon, 17 May 2021 15:36:43 -0700
Message-Id: <20210517223643.2934196-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210517_153700_899560_062A03A4 
X-CRM114-Status: GOOD (  13.82  )
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

A possible race condition exists where the request to send data is
enqueued from nvme_tcp_handle_r2t()'s will not be observed by
nvme_tcp_send_all() if it happens to be running. The driver relies on
io_work to send the enqueued request when it is runs again, but the
concurrently running nvme_tcp_send_all() may not have released the
send_mutex at that time. If no future commands are enqueued to re-kick
the io_work, the request will timeout in the SEND_H2C state, resulting
in a timeout error like:

  nvme nvme0: queue 1: timeout request 0x3 type 6

Ensure the io_work continues to run as long as the req_list is not
empty.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
Marking this RFC because the timeout is difficult to recreate, so
difficult to verify the patch. The patch was created purely from code
inspection, so I'm just hoping for feedback on my analysis right now. 

 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0222e23f5936..d07eb13d8713 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1140,7 +1140,8 @@ static void nvme_tcp_io_work(struct work_struct *w)
 				pending = true;
 			else if (unlikely(result < 0))
 				break;
-		}
+		} else
+			pending = !llist_empty(&queue->req_list);
 
 		result = nvme_tcp_try_recv(queue);
 		if (result > 0)
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
