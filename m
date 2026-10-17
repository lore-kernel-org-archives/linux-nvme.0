Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8BFCCF2C4
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Oct 2026 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EE+MiTt74CK7KkF/IZaKJAB/iw+nwq5cMCvHfUJcFlg=; b=jhXPeLPbJ4lZlG908NLUN+1u0y
	fhP99nVwECevXkXPHwm3HWlPn88+mPqQbZ2sXrkLlEJo5Woh4wI/kyude7EmZo2GVRsZMy9yYdO8n
	pvv6PZHCfdOKx0GO1E5IKDtf4uLD1VWFh7s8ksn68bU3WwNLu0xaH4txGHmH0TFJ8AT1jBzdtwjxT
	NxeT0tFwhKszgY7U/SA9rwzggy1/ChRVnnWY9uQabxYDOUdhA2wVmmQ043GuSf5qpz1dmb8DFv9kp
	jVqEmaFwxC3Bj5ay+rCkDmqxrIRKSBr6CX2Wzd1ZY9AKZH+O7NkQReqGLH71k1L9XkybCKv0+pK+G
	x/M1AU5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI6V0-00000004tFM-0DF7;
	Sat, 17 Oct 2026 15:39:06 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI6Uw-00000004tEx-2EWq
	for linux-nvme@lists.infradead.org;
	Sat, 17 Oct 2026 15:39:04 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-89f28c3ac7bso282214b3a.0
        for <linux-nvme@lists.infradead.org>; Sat, 17 Oct 2026 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792251541; x=1792856341; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EE+MiTt74CK7KkF/IZaKJAB/iw+nwq5cMCvHfUJcFlg=;
        b=jOIBBqRgJVfuFKo/x5nPkXBNi3PDMh/4cTdoI69iOqJo61yvo4Znvv5FmIO8CDfRfE
         zOrjfiv90fDHD40pI2kKGMr3DAxaCiWDp1v+J2vmpkYi/3GOnEICz9C9sTMnG1JAxnql
         /OA0ekDi7hb2xIV1bR43JoI3YFhdIvgCx94NvmsMWalXRFZ2n4Uofogf/Dp6ghEodXhI
         3GpWKs8ptu12pUlGDdFVemgFklXPUMJdBaD+OpCjxeKFpKwCjnDeWBLNaBhVEnSg+JXl
         OcX3q9oyxshKP5kK8J+/F6BiqaFOdTqczMCFrIhPrec6xMXxpO5xs1FQk2ZHtYjotaqm
         7nng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792251541; x=1792856341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EE+MiTt74CK7KkF/IZaKJAB/iw+nwq5cMCvHfUJcFlg=;
        b=mD/SPKnBB3P9SVLBtWw19QKu2PTnZKu3wOHX8zTIp8fEuttapwq0i12YrSB17810Y0
         e2KlZ5BIV8CbdXHjcXBC+kXFMoEVtki7xvZI7gS+7gpCpzocZYnbdpW9J5+vt0QfApxb
         2nIiblohIK99Y7YkW9J/VJzMpfB7/eIWZhMK0l4t5JLN97P8+59JJvd5/slWTKczfbpd
         i9wVRWJ7jxU1ZP0dyKYZ0I8IQ6bccfHAjtU2pL4n/6vPwgUGk0Zquzo0zbD/P5EpYdBi
         Piub06O5BMhtrWLjQMf8on+So2gXRv9RgYY07m1b6SNdlynqE8UKJFT+oeYu7SrNDeUJ
         ZGjw==
X-Forwarded-Encrypted: i=1; AKwUvBxEq43cIw+Pix22BkdWVvED3iqL2ME6tO09y5LOdznbw/ODcXY3fnJh8SNFLALpL95W+v1/W6UgkJXo@lists.infradead.org
X-Gm-Message-State: AFq9FYLLX3smvW47ZXykfd9oJriZ4+93BdHrNLvFShpHJ9CmVzKg0Q3I
	ZsjiAY6NMIgU+4DZBUXdRFN7YMV48261D0LAGxt2ePt4orARoP0Ie3c1dsgl1IxMWCg=
X-Gm-Gg: AYBFou3BBz4+q52W3qTZxmTVRmU5zLKaO5/4MAel43yf6vLcfwyb53rtHQvXwV3kbTq
	sGWtT50i+4JLu/SClHfc0n2gTNCrR1rvBG5rG9lkCSMEDil98/mo3YaC0PH6Sax/YOiqRoMgGAA
	rIHJ2hLmDgf1z+HcNxHr2xYYPfKJkfD8+CAIwt0FnoDiBHQFS4eQhtkN/5AKlGq1H0UdhgR6+Tf
	sp1i+4e4YqVL77rs4K3nKw5aWCXNQUp107C5q1NRydJiMzQRZB8SP16lbHIrstNvAaZax3pDtQE
	PTvOGbeHh/BLxUXaeZ3rn8JaSwVRpd4v9emicBPHgnHnlCZ5Vgz4f7aw6J+CeNEpA1ByqU8M6+X
	TNUe4ouqY47mpNQtvzRJzh3xlq7e1oE37hxqkwn200CirBO1EKsgf3/BavUeBJPlTYy4eJPzu94
	2XnMz3Fd9V/7CDawglyQKMGi+VURVx4BSZ06jGPKk6jrw2LQl74f2w1S86N4+kGVNq7G9pxNLCx
	97ezMKd93O2+peEEq3MwmDgWtviTWPN
X-Received: by 2002:a05:6a00:4f91:b0:89f:9ea6:1de6 with SMTP id d2e1a72fcca58-8a04c80effcmr2316077b3a.24.1792251540821;
        Sat, 17 Oct 2026 08:39:00 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:6c71:58da:ec95:3c04])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f579479ebsm2350277b3a.40.2026.10.17.08.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 08:39:00 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: Justin Tee <justin.tee@broadcom.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yhlee@isslab.korea.ac.kr
Subject: [PATCH] nvmet-fc: fix use-after-free in nvmet_fc_ls_create_connection()
Date: Sun, 18 Oct 2026 00:38:05 +0900
Message-ID: <20261017153805.2528275-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261017_083902_838503_4E29255C 
X-CRM114-Status: GOOD (  13.05  )
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

nvmet_fc_ls_create_connection() looks up the association with
nvmet_fc_find_target_assoc(), which returns it with a reference held, and
drops that reference as soon as the target queue has been allocated.
iod->assoc is then dereferenced again by nvmet_fc_makeconnid() while
building the connection id.

The queue only borrows the pointer and takes no reference of its own.
Once the lookup reference is dropped the association is kept alive solely
by the reference taken when it was created, so a disconnect LS or a remote
port unregister running concurrently can free it before
nvmet_fc_makeconnid() reads it:

BUG: KASAN: slab-use-after-free in nvmet_fc_handle_ls_rqst_work (drivers/nvme/target/fc.c:193 drivers/nvme/target/fc.c:1841 drivers/nvme/target/fc.c:1995 drivers/nvme/target/fc.c:2021)
Read of size 8 at addr ffff888179f1b000 by task kworker/u9:2/1167

Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: nvmet-wq nvmet_fc_handle_ls_rqst_work
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
 print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
 kasan_report (mm/kasan/report.c:595)
 nvmet_fc_handle_ls_rqst_work (drivers/nvme/target/fc.c:193 drivers/nvme/target/fc.c:1841 drivers/nvme/target/fc.c:1995 drivers/nvme/target/fc.c:2021)
 process_scheduled_works (kernel/workqueue.c:3322 kernel/workqueue.c:3405)
 worker_thread (kernel/workqueue.c:3486)
 kthread (kernel/kthread.c:436)
 ret_from_fork (archkernel/process.c:158)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
 </TASK>

Freed by task 1167 on cpu 0 at 405.998150s:
 kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
 kasan_save_free_info (mm/kasan/generic.c:584)
 __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
 kfree (include/linux/kasan.h:235 mm/slub.c:2705 mm/slub.c:6405 mm/slub.c:6720)
 nvmet_fc_handle_ls_rqst_work (drivers/nvme/target/fc.c:1808 drivers/nvme/target/fc.c:1995 drivers/nvme/target/fc.c:2021)
 process_scheduled_works (kernel/workqueue.c:3322 kernel/workqueue.c:3405)
 worker_thread (kernel/workqueue.c:3486)
 kthread (kernel/kthread.c:436)
 ret_from_fork (archkernel/process.c:158)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

The buggy address belongs to the object at ffff888179f1b000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 0 bytes inside of
 freed 2048-byte region [ffff888179f1b000, ffff888179f1b800)

Hold the lookup reference until the response has been built, and drop it
on the error path as well.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Closes: https://lore.kernel.org/linux-nvme/20260731204504.2396434-1-shuangpeng.kernel@gmail.com
Fixes: c53432030d86 ("nvme-fabrics: Add target support for FC transport")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/nvme/target/fc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b557775e033a..f3e80095d7d16 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1796,9 +1796,6 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 					be16_to_cpu(rqst->connect_cmd.sqsize));
 			if (!queue)
 				ret = VERR_QUEUE_ALLOC_FAIL;
-
-			/* release get taken in nvmet_fc_find_target_assoc */
-			nvmet_fc_tgt_a_put(iod->assoc);
 		}
 	}
 
@@ -1812,6 +1809,8 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 					FCNVME_RJT_RC_INV_ASSOC :
 					FCNVME_RJT_RC_LOGIC,
 				FCNVME_RJT_EXP_NONE, 0);
+		if (iod->assoc)
+			nvmet_fc_tgt_a_put(iod->assoc);
 		return;
 	}
 
@@ -1833,6 +1832,9 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 	acc->connectid.connection_id =
 			cpu_to_be64(nvmet_fc_makeconnid(iod->assoc,
 				be16_to_cpu(rqst->connect_cmd.qid)));
+
+	/* release get taken in nvmet_fc_find_target_assoc */
+	nvmet_fc_tgt_a_put(iod->assoc);
 }
 
 /*
-- 
2.43.0


