Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29AAEC021B2
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 11:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=50j8WHvULWcpnbIKbQ31ciAMP+dqwo+G1D1qpji2b9Q=; b=FZ7qAVGXnhpvxZ
	fO9+AjG/N8BORTmRSeMLrF6uDTJt0rLKBiiHAUi7JyA/KncBI8kpp5TX5cMW68zbxWQv/6QHGErHr
	Ay/WRe2vC4Yy1U+hVSTgV8Y+xuS+kNKPAFSlGwlT4SLioZtAw31f/PuYUqdM6dIBxbqugWEXeo8WC
	qm9PBeVVlpe0EV3kjefzK43DCtjuaTPLRxEGmXgxogZf3m9/a+5smgAihBysfBGWFolYu09Da3oWS
	6PT/b5S9at0bSc72IjvsJlt04nF06bFdygJ6cCQK5LMYwKjwLXe7yL8pMpn+ZAUmHLJjQ0+aLg33z
	B4VS46jqKpPRZ/MFxYkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tl4bh-00000000Vw4-110c;
	Thu, 20 Feb 2025 11:20:41 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tl4Ze-00000000VIb-35o1
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 11:18:35 +0000
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4399ee18a57so4786685e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 20 Feb 2025 03:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740050313; x=1740655113;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50j8WHvULWcpnbIKbQ31ciAMP+dqwo+G1D1qpji2b9Q=;
        b=Sc0xUn/rTKay7a4q5y0oGD4vbKoCKBHtcSKLPaLxDFJbMvby1cAwsYmzYrw6Igau+D
         UsBYAYdw8/omjTNlboKu0ap1zEaIOKLvbCXXm4h+e1UGQCs++y8fg8Ndk1m0ZLpK7Unc
         7Gygzl8zGXLoZ59O4kzdTZ1q/xU14hYguR0h5Q69V8vPbKlWCMEMS1U6Cre4LPojX2NQ
         SyancS/y4NqIvd2ku+GfyOhEW+0Wdq+q7kJ9xwP+G3opeypOw7UcI54MBcW0tVDNapLw
         i5rYnhsp60gLYgzdp384q7lKSSJ3i1hS9W721KDuNuzGaophLq6QpeNfbicGZ5cYpr2i
         tQlA==
X-Gm-Message-State: AOJu0YxdSX0qqYqmh75piTwhz+x5+bjikqocArAQOe6taa26hkUCgYUM
	EmHfNxQnnCJ64x98PvI1IGibZfMKB2Qtz/fr0PJ/+DZFn06XTLscKDmnKw==
X-Gm-Gg: ASbGncvr44jSyH5WzWxd8EmhcUhkqxkzVGVaGHRobuHMRt8pAUT3BQ6dwQrXZYd9LE1
	GtdpwDjPGPUsoaIsuGWonc4dtJHXh66daDvtOXBHsY5dMrtRYaTxk7nVg+uRs+jAGloLhTZ/8qh
	JeQbppAfTbm1TLbamn6K61qPqdQRdFe5jVvMZnQ2sgiTSWwNPbHOVhiRTS5uPptI9ZV0EkgOmyG
	5zV8DrWP66zx6376gT5YVGxcqcwpzFjsQ4HU7F17wa8vJVkTPYcCDKZ7zWcTjW+H0Cu1+kWHw1R
	7TLY8/5/jveAOreW1NVVL2ChoB/eNMyB82RfcmYk3vAcjMzhnl3SmTJCZdbIUclj
X-Google-Smtp-Source: AGHT+IF6VoD4wzoxv8WztrHkHbxB2bEfeDiga/1rqMplm6r+1YEGDv84i6yg3qZHXWCzSg8E1JC2dA==
X-Received: by 2002:a05:600c:4451:b0:439:9434:4f3b with SMTP id 5b1f17b1804b1-439a30b9a4bmr23342945e9.8.1740050312485;
        Thu, 20 Feb 2025 03:18:32 -0800 (PST)
Received: from vastdata-ubuntu2.vstd.int (89-138-75-149.bb.netvision.net.il. [89.138.75.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399c5f901bsm23478065e9.3.2025.02.20.03.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 03:18:31 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-tcp: fix possible UAF in nvme_tcp_poll
Date: Thu, 20 Feb 2025 13:18:30 +0200
Message-ID: <20250220111830.3185561-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_031834_809196_342AB56F 
X-CRM114-Status: GOOD (  14.42  )
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
Reply-To: sagi@grimberg.me
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_tcp_poll() may race with the send path error handler because
it may complete the request while it is actively being polled for
completion, resulting in a UAF panic [1]:

We should make sure to stop polling when we see an error when
trying to read from the socket. Hence make sure to propagate the
error so that the block layer breaks the polling cycle.

[1]:
--
[35665.692310] nvme nvme2: failed to send request -13
[35665.702265] nvme nvme2: unsupported pdu type (3)
[35665.702272] BUG: kernel NULL pointer dereference, address: 0000000000000000
[35665.702542] nvme nvme2: queue 1 receive failed:  -22
[35665.703209] #PF: supervisor write access in kernel mode
[35665.703213] #PF: error_code(0x0002) - not-present page
[35665.703214] PGD 8000003801cce067 P4D 8000003801cce067 PUD 37e6f79067 PMD 0
[35665.703220] Oops: 0002 [#1] SMP PTI
[35665.703658] nvme nvme2: starting error recovery
[35665.705809] Hardware name: Inspur aaabbb/YZMB-00882-104, BIOS 4.1.26 09/22/2022
[35665.705812] Workqueue: kblockd blk_mq_requeue_work
[35665.709172] RIP: 0010:_raw_spin_lock+0xc/0x30
[35665.715788] Call Trace:
[35665.716201]  <TASK>
[35665.716613]  ? show_trace_log_lvl+0x1c1/0x2d9
[35665.717049]  ? show_trace_log_lvl+0x1c1/0x2d9
[35665.717457]  ? blk_mq_request_bypass_insert+0x2c/0xb0
[35665.717950]  ? __die_body.cold+0x8/0xd
[35665.718361]  ? page_fault_oops+0xac/0x140
[35665.718749]  ? blk_mq_start_request+0x30/0xf0
[35665.719144]  ? nvme_tcp_queue_rq+0xc7/0x170 [nvme_tcp]
[35665.719547]  ? exc_page_fault+0x62/0x130
[35665.719938]  ? asm_exc_page_fault+0x22/0x30
[35665.720333]  ? _raw_spin_lock+0xc/0x30
[35665.720723]  blk_mq_request_bypass_insert+0x2c/0xb0
[35665.721101]  blk_mq_requeue_work+0xa5/0x180
[35665.721451]  process_one_work+0x1e8/0x390
[35665.721809]  worker_thread+0x53/0x3d0
[35665.722159]  ? process_one_work+0x390/0x390
[35665.722501]  kthread+0x124/0x150
[35665.722849]  ? set_kthread_struct+0x50/0x50
[35665.723182]  ret_from_fork+0x1f/0x30

Reported-by: Zhang Guanghui <zhang.guanghui@cestc.cn>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c637ff04a052..0e390e98aaf9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2673,6 +2673,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct nvme_tcp_queue *queue = hctx->driver_data;
 	struct sock *sk = queue->sock->sk;
+	int ret;
 
 	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
 		return 0;
@@ -2680,9 +2681,9 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
 		sk_busy_loop(sk, true);
-	nvme_tcp_try_recv(queue);
+	ret = nvme_tcp_try_recv(queue);
 	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
-	return queue->nr_cqe;
+	return ret < 0 ? ret : queue->nr_cqe;
 }
 
 static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
-- 
2.43.0


