Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6FB3C64ED6
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Feb 2023 12:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DwfLEzqZ0QVirXQLbpJW7s08X5a8w2/KigTjbknp+V4=; b=aSMfkCmbrpdw9Oh1gfuS0s6Wj1
	O9AckeLv7NwstqeuHF+kcNDury+UyEmcBlCSdCZsrF+UsLnJSIqwI7f6Xw8O0l3mVMiECYwBPoxKV
	gG2zpJou7NMpfgaOBFmVe/F1qtD+GWHgcLsQHxq6sMSwSQbjDQlW+NouaPvETxlGfQnvixCWkXaSS
	jilzWOKAuMICLYc4S1pl0zICFg77oJ8//P0fskS8IZJ7yrwqgGkWC4h0tJW+jgBeg+pPcw938xm9r
	k7tak7CG54PxdiDyXSUeRhYfOggKgGvSKXPIElgP+MQhnISiySase18XHpRYHTVSUlUWZrZKF8VZd
	pi1mAS1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWGNH-007CM6-0d; Sun, 26 Feb 2023 12:43:31 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWGND-007CLc-1i
	for linux-nvme@lists.infradead.org; Sun, 26 Feb 2023 12:43:28 +0000
Received: by mail-pj1-x1029.google.com with SMTP id x20-20020a17090a8a9400b00233ba727724so9508175pjn.1
        for <linux-nvme@lists.infradead.org>; Sun, 26 Feb 2023 04:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DwfLEzqZ0QVirXQLbpJW7s08X5a8w2/KigTjbknp+V4=;
        b=Bc6PkSLceUdCO6v+2a3TMP5MHAJ/2aXQyPb4HROBz83mzPW0cnKKVp+Vm1dZbRQ6VG
         Uw9P3rxL2MtTsVmh3JjjZkSL1Bmw/SnH08aixUtpx/1qQMzSbqGfnGek/5TATda6qxXp
         rOBO10WLEidoJl1FotRgenUhG2VNdzi+YsHvPWgqPF2RzNxo62Y4yATYKFpy+ajA1xmH
         UhRPwFTY3AGeepdZDTBNj/D94ly3P++1nxid/yXRb2cyE3Rtspf7A8Gi4NcojI2qUmPY
         5urav8N19Napbxvob4G8qVi00pQTnwqf8DQJ6/AxszjWpDBWzHukPWNkYeih6XUzjGRW
         EE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwfLEzqZ0QVirXQLbpJW7s08X5a8w2/KigTjbknp+V4=;
        b=U4UxvGqvtXNSYTyS7j8/BhahJyhETT4ygCytqxvIs70yqyCOvFpLo+v7pfRdltpeMM
         9qo5dagJcWM7wuSmHYXklXdv8Msw9pYz0fWsXrN3zxI5divIEoV6VRnR1lQUdCWF2/Xb
         BCcwKj2+Aab0ciQ1xxlqc1VEg15llzOVNrE7qqyEIQjnAzCFZZIkC/4I3pi5oEbI0b9v
         4mSqwuvAmR/D7AQLvREN+53FoWT1ieaUQxXA3qo9CjTGa0cvoXC55bbsB/IYijxvduwr
         TDqfyjhlvWG9hqeL/OG34e5xGiP4pW/JUtaKfB5Hwkjl6oaGAtetyeKQ8HZYGCzHH6YO
         QLLw==
X-Gm-Message-State: AO0yUKX+oWeyUIqFMCiuFUZi74yzFd4imYkssuuaPqeuH0iJOwNVPlNb
	pz/jAEiTsfW6g9uHBXN5KJgV442lNYw=
X-Google-Smtp-Source: AK7set8mDvlHBHJeDkQOj3trupKYTZhcxWiJNB94mdpl2B/8tayK8v85mWYrerreXlMirWPC7jFBGg==
X-Received: by 2002:a17:90b:4a8e:b0:237:b702:49ac with SMTP id lp14-20020a17090b4a8e00b00237b70249acmr5805423pjb.17.1677415404570;
        Sun, 26 Feb 2023 04:43:24 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:5d7:67d7:fa35:7513])
        by smtp.gmail.com with ESMTPSA id q2-20020a17090a68c200b00234b785af1dsm2513903pjj.26.2023.02.26.04.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 04:43:23 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Martin Belanger <martin.belanger@dell.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-tcp: don't access released socket during error recovery
Date: Sun, 26 Feb 2023 21:42:54 +0900
Message-Id: <20230226124254.59970-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230226_044327_126908_5D0A9AE7 
X-CRM114-Status: GOOD (  14.39  )
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

While the error recovery work is temporarily failing reconnect attempts,
running the 'nvme list' command causes a kernel NULL pointer dereference
by calling getsockname() with a released socket.

During error recovery work, the nvme tcp socket is released and a new one
created, so it is not safe to access the socket without proper check.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Fixes: 02c57a82c008 ("nvme-tcp: print actual source IP address through sysfs "address" attr")
Cc: Martin Belanger <martin.belanger@dell.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1955c0ec209e..7723a4989524 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2492,6 +2492,10 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 
 	len = nvmf_get_address(ctrl, buf, size);
 
+	mutex_lock(&queue->queue_lock);
+
+	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		goto done;
 	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src_addr);
 	if (ret > 0) {
 		if (len > 0)
@@ -2499,6 +2503,8 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 		len += scnprintf(buf + len, size - len, "%ssrc_addr=%pISc\n",
 				(len) ? "," : "", &src_addr);
 	}
+done:
+	mutex_unlock(&queue->queue_lock);
 
 	return len;
 }
-- 
2.34.1


