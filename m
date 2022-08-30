Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A9CECAAD4
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 08:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=awkJXmGGU5TdN13Umx2r2zUdBoTqXjBxvaSpBFaOz1Q=; b=t0CCsGbV7UJUQ4JB28/jCoi6uZ
	Ak0dITEvfU114Ze3fpCCznEDXZN8Ij5wUDwX+4/KcSc/0HYpKf+Hnq6gOJWBbWyYWap3uSULGpndw
	m9thbzR7HR8qY5OssBgDGm5Qjm9u1SpvtV+1Qm2jeuI0ZV/6+XSSIqu8o+zS4m5kMwmHQzGrnOkUl
	DP8q7AP1t+P85x6HsoBrU5dCZNmdyVR5aDpuAV7bPqf3uLLxr//cCC+cn1Ace3t4XY0jrnU8zauf/
	zGowtYmSUsjgmn/ZTTOeMygKGlDBTiqqRWjKYxzG8Nwx68BYramfO8hcGZ+omD6Q7RNjicqKDNGXh
	aO/8elRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSwk6-00FH2N-G0; Tue, 30 Aug 2022 08:37:06 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSwk3-00FGyw-FT
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 08:37:05 +0000
Received: by mail-pl1-x62a.google.com with SMTP id f12so10251021plb.11
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 01:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=awkJXmGGU5TdN13Umx2r2zUdBoTqXjBxvaSpBFaOz1Q=;
        b=MNWzEtz28t7wCdJEdyw7V+7sGRZ34xjJdwPaK0ybD4hNvH1HmV5JH6TAKu3ZgABS7p
         xjTVWEtne8Nr9qvDIN3a1sNLxbSmjCT/eEq2PULqQR7Pd5CEGwhdVhisDKmLZhw3F3oF
         fO9AhnfetyNHigK9pNeynOLb3nlLgqEynzAwQF6Q+Vb933bikOKHsj+nveJJFnVFX9Mv
         KBaMNZLZfwzBfXwCW79YQiB6D1As0skH7rPpmpJnUIBVPXIbsqFBXiUPvAJUpOWgML8v
         3SI8L357Uk82mx2mt6VlqE1w3hJQv0xHgygxuNjaYN5J3J4hvv+eLw1C6Yay3PKeyXs7
         WOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=awkJXmGGU5TdN13Umx2r2zUdBoTqXjBxvaSpBFaOz1Q=;
        b=hszW/4ECPVdF5NJ5CPu9QbUI0j/fjn+uUK2ilmdDJoRH01SMzAJpzwHY9FcdR7/Z1O
         o4lts47srH/Ug2r8l1NqKr5RlvmwvAY9zDhQ1pSUaAW9V91en0uUUV+zUjNEILs5xVd7
         H0ZXxZoHxBzbx7Qj9ub1lTTh0m+zT9HtHXEF48kwB4YK+eRy2TzQbxA4a/M5zGlW4idz
         K3ttGBjjQ1Bh8CdHEWLEPNwDXVH8fwCf1Jq/G7D+TOypkeooa+u7Ud0nLsGDw7ZdQNik
         SkqYWf1ZoP8lCAyp4C0/8HmDXULTSkp/q6Tjxc+jOAdy0lpNlbbcBaS7pM7tHprJnBY9
         GKFw==
X-Gm-Message-State: ACgBeo1URFuU8KBOzYdJGUbnXUmu8VU83YYmOPZYmq27yJmEEQ4pqjRG
	copUetO9KZHDOgESNDUQ3NCk/A==
X-Google-Smtp-Source: AA6agR6IBJ7j8lf/g2whEj9kbYF1PlZ8hZ2VY3gIgpfm0wLlV9RB/zMnIhwcOuvhwsg7S+AmnEDR3A==
X-Received: by 2002:a17:90a:fae:b0:1fd:a1bc:ff65 with SMTP id 43-20020a17090a0fae00b001fda1bcff65mr13694791pjz.73.1661848619625;
        Tue, 30 Aug 2022 01:36:59 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.74])
        by smtp.gmail.com with ESMTPSA id h123-20020a625381000000b005360da6b26bsm8676636pfb.159.2022.08.30.01.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 01:36:59 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: hch@lst.de,
	sagi@grimberg.me
Cc: kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH] nvmet-tcp: Fix NULL pointer dereference during release
Date: Tue, 30 Aug 2022 16:36:28 +0800
Message-Id: <20220830083628.499028-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_013703_751783_B393B4A7 
X-CRM114-Status: GOOD (  12.47  )
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

nvmet-tcp frees CMD buffers in nvmet_tcp_uninit_data_in_cmds(),
and waits the inflight IO requests in nvmet_sq_destroy(). During wait
the inflight IO requests, the callback nvmet_tcp_queue_response()
is called from backend after IO complete, this leads a typical
Use-After-Free issue like this:

 BUG: kernel NULL pointer dereference, address: 0000000000000008
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: 0000 [#1] PREEMPT SMP NOPTI
 CPU: 14 PID: 207 Comm: kworker/14:1H Kdump: loaded Tainted: G            E      6.0.0-rc2.bm.1-amd64 #12
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
 RIP: 0010:shash_ahash_digest+0x2b/0x110
 Code: 1f 44 00 00 41 57 41 56 41 55 41 54 55 48 89 fd 53 48 89 f3 48 83 ec 08 44 8b 67 30 45 85 e4 74 1c 48 8b 57 38 b8 00 10 00 00 <44> 8b 7a 08 44 29 f8 39 42 0c 0f 46 42 0c 41 39 c4 76 43 48 8b 03
 RSP: 0018:ffffc900006e3dd8 EFLAGS: 00010206
 RAX: 0000000000001000 RBX: ffff888104ac1650 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: ffff888104ac1650 RDI: ffff888104ac1600
 RBP: ffff888104ac1600 R08: ffff8881073980c8 R09: ffff8881057798b8
 R10: 8080808080808080 R11: 0000000000000000 R12: 0000000000001000
 R13: 0000000000000000 R14: ffff88810601a1cc R15: ffff888107398000
 FS:  0000000000000000(0000) GS:ffff88823fd80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000000008 CR3: 000000010a8e8000 CR4: 0000000000350ee0
 Call Trace:
  <TASK>
  nvmet_tcp_io_work+0xa1c/0xb1c [nvmet_tcp]
  ? __switch_to+0x106/0x420
  process_one_work+0x1ae/0x380
  ? process_one_work+0x380/0x380
  worker_thread+0x30/0x360
  ? process_one_work+0x380/0x380
  kthread+0xe6/0x110
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30

To fix this issue, free CMD buffers until all the inflight IO
complete.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc3b4dc8fe08..2325246e3b4d 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1449,8 +1449,8 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	/* stop accepting incoming data */
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
 
-	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
+	nvmet_tcp_uninit_data_in_cmds(queue);
 	cancel_work_sync(&queue->io_work);
 	sock_release(queue->sock);
 	nvmet_tcp_free_cmds(queue);
-- 
2.20.1


