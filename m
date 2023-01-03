Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41E6AC46467
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 10:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1gbL+cALMqR6hPWSYe/MQYdljgQPpRN+krGvw7T8Yyo=; b=NJX8/mpDw3dAf5EH6luKe8iJwn
	bw9jixKARNWM/jUySB+3tf1dtyywZi3kLZPwfDI+0Iz+7bYDL4kVYiwy256fh+prZzboC9Fd85Zro
	+KdsmUay22YjVh4P8EVqbtSDsRxTwt6EX5eAXDPr2R3s/NKU7/21Q7YjrgCyWFMq3TLZERF5HtldS
	2WlvhUnqoqR42WNJ/apU81M52Mrk3gGXBMq6lUQTdU9kfTwG7bW09pXaXQzz3zSRDU8moyNmhoiaS
	TSwIkzz/rf23/xCDvwPaq8LZKj1DJHLXZ79oeuOkZOVefQM5Mk+aSVYbrD1sIuDBW+1QL8uQAPyEe
	NdpFLUlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCeKu-000fDW-1N; Tue, 03 Jan 2023 10:16:00 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCeA0-000bhm-IX
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 10:04:46 +0000
Received: by mail-pj1-x102b.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so30649422pjd.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Jan 2023 02:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1gbL+cALMqR6hPWSYe/MQYdljgQPpRN+krGvw7T8Yyo=;
        b=XAzQeYvy3j0O2XnsbZZmZl9L2thGMU/4Nkauu4/5ySrGqcYHcvML334xXbFqhmpm1O
         VOgX7WFo7TdoNkMV5TurC10Mr+GvahBvfFlLw08XSEaB5awdqIcan4Ge5+BO3VahxuPf
         ltl9vEDr/z6Pe7TXD26DYhACU15ZBqr5e4mUIEUM/g/ocraA6hvmKcUstnTEawbZbM/L
         39UI5UwkYlmc4zD1CUZGe4Cd/9Mwg040DA8rL5ZflYStWJgPbi4uV8mYzJf8f3+WfkDD
         dJ6Pso1h6u37OU53efrJ0xCwIzkp2/jTwi7z3xM+ykVteWRf8HNKu9FbfiQM/TDCQ0Q6
         gbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1gbL+cALMqR6hPWSYe/MQYdljgQPpRN+krGvw7T8Yyo=;
        b=K8sU7zuenC0tll8PL4N9/JzSKOJvgWoyTRPqQSh0HoY7SbJ0aSJ65y15Osdi8dMLsi
         trhio7UCGEN85k4fmA5G9Qoqm4LI7FSI3sDTddJYkj9epDv2+/NYzHHCh1l4wbwdDAFO
         k9x6iQPt5FYmrUviwca3MWIui647LgIq4wAN/LAOMpV77LToCVbND91Ef9d6h2MfIGFB
         QxyVISujxhY1QL0eW+B55x3F/DfQQzIpkrESU0sdSoBrq0WeVYN5NRRugt30OO71+VoP
         URxhSv2xJ8eaw4rFng60v+PtlaD6Gpq3rEHoUWBkY91nL8b6fbg9ZkOXSfj0NStwi9lm
         6PWg==
X-Gm-Message-State: AFqh2koApmVxckiHjQP+I8H5XedPD1UAjyksKWEVRW4Zb2MZ4yqeZapv
	1ZghjUbgAhqj4V16ENM9Wc9ptrrV1gr+0Q==
X-Google-Smtp-Source: AMrXdXt3q1ehK5e9y/CzfvF9Mtt/UjzLv0lm5w38CBaJtHTxSkh6CQC775y2s4SpHvG+wZ+DzoxZtg==
X-Received: by 2002:a17:90a:ba84:b0:225:df28:fecf with SMTP id t4-20020a17090aba8400b00225df28fecfmr32273004pjr.13.1672740283363;
        Tue, 03 Jan 2023 02:04:43 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id j14-20020a17090a2a8e00b002187a4dd830sm14311691pjd.46.2023.01.03.02.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 02:04:41 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: james.p.freyensee@intel.com,
	ming.l@ssi.samsung.com,
	larrystevenwise@gmail.com,
	anthony.j.knapp@intel.com,
	pizhenwei@bytedance.com,
	ap420073@gmail.com
Subject: [PATCH 4/4] nvmet-tcp: fix memory leak in nvmet_tcp_free_cmd_data_in_buffers()
Date: Tue,  3 Jan 2023 10:03:57 +0000
Message-Id: <20230103100357.875854-5-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103100357.875854-1-ap420073@gmail.com>
References: <20230103100357.875854-1-ap420073@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_020444_649291_C5983BAB 
X-CRM114-Status: GOOD (  14.97  )
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

While tcp socket is being released, nvmet_tcp_release_queue_work() is
called.
It calls nvmet_tcp_free_cmd_data_in_buffers() to free CMD resources.
But it may skip freeing resources due to unnecessary condition checks.
So, the memory leak will occur.

In order to fix this problem, it removes unnecessary condition checks
in nvmet_tcp_free_cmd_data_in_buffers().

This memory leak issue will occur in the target machine when a host
sends reset command to a target.

Reproducer:
   while :
   do
       echo 1 > /sys/class/nvme/nvme<NS>/reset_controller
   done

unreferenced object 0xffff88814a5c6da0 (size 32):
  comm "kworker/2:1H", pid 176, jiffies 4305953739 (age 72707.743s)
  hex dump (first 32 bytes):
    82 84 c8 04 00 ea ff ff 00 00 00 00 00 04 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffaa795cf7>] __kmalloc+0x47/0xc0
    [<ffffffffab030a72>] sgl_alloc_order+0x82/0x3a0
    [<ffffffffc086593c>] nvmet_tcp_map_data+0x1bc/0x570 [nvmet_tcp]
    [<ffffffffc086a7d4>] nvmet_tcp_try_recv_pdu+0x7f4/0x1e20 [nvmet_tcp]
    [<ffffffffc086c5a0>] nvmet_tcp_io_work+0x120/0x3272 [nvmet_tcp]
    [<ffffffffaa1b059d>] process_one_work+0x81d/0x1450
    [<ffffffffaa1b177c>] worker_thread+0x5ac/0xed0
    [<ffffffffaa1c8ccf>] kthread+0x29f/0x340
    [<ffffffffaa0034cf>] ret_from_fork+0x1f/0x30
unreferenced object 0xffff888153f3e1c0 (size 16):
  comm "kworker/2:1H", pid 176, jiffies 4305953739 (age 72707.743s)
  hex dump (first 16 bytes):
    80 84 c8 04 00 ea ff ff 00 04 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffffaa795cf7>] __kmalloc+0x47/0xc0
    [<ffffffffc0865a80>] nvmet_tcp_map_data+0x300/0x570 [nvmet_tcp]
    [<ffffffffc086a7d4>] nvmet_tcp_try_recv_pdu+0x7f4/0x1e20 [nvmet_tcp]
    [<ffffffffc086c5a0>] nvmet_tcp_io_work+0x120/0x3272 [nvmet_tcp]
    [<ffffffffaa1b059d>] process_one_work+0x81d/0x1450
    [<ffffffffaa1b177c>] worker_thread+0x5ac/0xed0
    [<ffffffffaa1c8ccf>] kthread+0x29f/0x340
    [<ffffffffaa0034cf>] ret_from_fork+0x1f/0x30

Fixes: db94f240280c ("nvmet-tcp: fix NULL pointer dereference during release")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/nvme/target/tcp.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index cc05c094de22..dac08603fec9 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1427,13 +1427,10 @@ static void nvmet_tcp_free_cmd_data_in_buffers(struct nvmet_tcp_queue *queue)
 	struct nvmet_tcp_cmd *cmd = queue->cmds;
 	int i;
 
-	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
-		if (nvmet_tcp_need_data_in(cmd))
-			nvmet_tcp_free_cmd_buffers(cmd);
-	}
+	for (i = 0; i < queue->nr_cmds; i++, cmd++)
+		nvmet_tcp_free_cmd_buffers(cmd);
 
-	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect))
-		nvmet_tcp_free_cmd_buffers(&queue->connect);
+	nvmet_tcp_free_cmd_buffers(&queue->connect);
 }
 
 static void nvmet_tcp_release_queue_work(struct work_struct *w)
-- 
2.34.1


