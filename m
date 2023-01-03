Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE95CC3DA7D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 10:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yErhuGLHojTft20+iv7qBQjPVql/YGj7Zzwq7DKJ4/s=; b=JfStKrPsmZYeo0zjwTkTOrhgHr
	zTlbuvracPzVVhBOUMa1TX6PU7G+Xt4urv2GdVxXRjL03iSggIemj02L0L3z38UM0EwgqrCVb8BVO
	6uATxaHhqdKPNwC5Sf4e21bR/sFI9bytBWB9bhaQqdQ/osioBymMcAf7zBJiZt4LMc2bR0lG6HHuZ
	3Qc3hr9ahlr9J24d81G+Glil7I0KyPQdzHNKjatQdZKydDIFTmsa70C7YX6rnoRc9EFjKtsgwR1lW
	NPrVEEW9JJM3wz/lpFZ2IaBYetqoxoRufZuEvzRKNQxBeFAmdxd9eYxDBZO+u1PFd6OsMXDTS7SJt
	YSIR4Fwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCeRC-000hDe-FT; Tue, 03 Jan 2023 10:22:30 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCe9q-000bhm-Ba
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 10:04:37 +0000
Received: by mail-pj1-x102b.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so30648946pjd.0
        for <linux-nvme@lists.infradead.org>; Tue, 03 Jan 2023 02:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yErhuGLHojTft20+iv7qBQjPVql/YGj7Zzwq7DKJ4/s=;
        b=U17k3lNM/htAoifu4k5hBYwtpTmdkH/fxjdcV0tSVvPmAijjXLn8cAURBO51Z1UKpj
         H7f/IBVRLsSw0PZTunSR/COujy9S9Zr3PCeaiX6NdSYfCO54hV2HuU763iMBF7Xrm3c3
         u5YM8R2zOyB2qyhTBCC0LWn50KIlxedpnbk6WDcPEtVcd9YOfFDia2bPxVjaFLILgww/
         dAhTABwRBL7qBDqeW+KHE+woPFv4FsR3wLhzpgmnYllwRYPFl2ZLuc2dfi1KgtnQ0XpT
         5qifjRLbmBHYESbtZB8udxm+rYnHZTz1UgQ+QsBZ50QCWxkxagyA7IZ1G4BMzGk22Nz0
         JQrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yErhuGLHojTft20+iv7qBQjPVql/YGj7Zzwq7DKJ4/s=;
        b=brkBTOcbVmnZ4Og6G9+kAg0HCIkDqs9w+PQ8ecrI6vw7N6xsOivWKR9stsbdMFOKNO
         UIyodJEEER1LmzA3KxJOuXMQ12ybs5ycZGFMyWO9pUCaEFcnDRz/XOZXZ9RlvXHiVtSj
         QjTM1pzaG0odbMztFx3ILBqByGEd8hiWVHNre+57uCAYnRcVXMzGHw+aGG2tHz22UDmM
         6SBwkKXnJDkOtO063b5L8bhmLPzW5RQya0fApj4YOwxux9SvQoQsepXPjDK/BgBTvzYN
         CkEtnOfRE/mezNdE8ldjYxTgraAJxdKONKnxmsL2Rs8ThmEUvedjfEm8MdFujEv9uoUy
         gLbA==
X-Gm-Message-State: AFqh2kqB5ovHHkfc4gOaGFFPTVeuBtjTN0luaCfGdpsvRxsmL65X4fFg
	bworeEIqZf4RK6S0crkKVnRRCB484sNv5g==
X-Google-Smtp-Source: AMrXdXsf/YjD4mIqIXx+8SbVCnYejtgBa4HxP+dkgHICAQ43oYPvP5Q9oA9VkkGiG5CAF4ofDmAMkw==
X-Received: by 2002:a17:90b:8c2:b0:225:f353:6624 with SMTP id ds2-20020a17090b08c200b00225f3536624mr28897559pjb.45.1672740270675;
        Tue, 03 Jan 2023 02:04:30 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id j14-20020a17090a2a8e00b002187a4dd830sm14311691pjd.46.2023.01.03.02.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 02:04:29 -0800 (PST)
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
Subject: [PATCH 1/4] nvme: fix delete uninitialized controller
Date: Tue,  3 Jan 2023 10:03:54 +0000
Message-Id: <20230103100357.875854-2-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230103100357.875854-1-ap420073@gmail.com>
References: <20230103100357.875854-1-ap420073@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_020434_637901_493FA9BC 
X-CRM114-Status: GOOD (  13.18  )
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

nvme-fabric controllers can be deleted by
/sys/class/nvme/nvme<NS>/delete_controller
echo 1 > /sys/class/nvme/nvme<NS>/delete_controller
The above command will call nvme_delete_ctrl_sync().
This function internally tries to change ctrl->state to NVME_CTRL_DELETING.
NVME_CTRL_LIVE, NVME_CTRL_RESETTING, and NVME_CTRL_CONNECTING states can
be changed to NVME_CTRL_DELETING.
If the state is successfully changed, nvme_do_delete_ctrl() is called,
which is the actual delete logic of controller.

controller initialization logic changes ctrl->state.
NEW -> CONNECTING -> LIVE.
NVME_CTRL_CONNECTING state doesn't ensure that initialization is done.

So, delete logic can be called before the finish of controller
initialization.
So kernel panic would occur because nvme_do_delete_ctrl() dereferences
uninitialized values.

BUG: KASAN: null-ptr-deref in do_raw_spin_trylock+0x67/0x180
Read of size 4 at addr 00000000000000c0 by task bash/928

CPU: 7 PID: 928 Comm: bash Not tainted 6.1.0 #35
nvme nvme0: Connect command failed: host path error
Call Trace:
 <TASK>
 dump_stack_lvl+0x57/0x81
 ? do_raw_spin_trylock+0x67/0x180
 kasan_report+0xba/0x1f0
nvme nvme0: failed to connect queue: 0 ret=880
 ? do_raw_spin_trylock+0x67/0x180
 ? sysfs_file_ops+0x170/0x170
 kasan_check_range+0x14a/0x1a0
 do_raw_spin_trylock+0x67/0x180
 ? do_raw_spin_lock+0x270/0x270
 ? nvme_remove_namespaces+0x1bc/0x3d0
 _raw_spin_lock_irqsave+0x4b/0x90
 ? blk_mq_quiesce_queue+0x1b/0x160
 blk_mq_quiesce_queue+0x1b/0x160
 nvme_tcp_delete_ctrl+0x4b/0x70
 nvme_do_delete_ctrl+0x135/0x141
 nvme_sysfs_delete.cold+0x8/0xd
 kernfs_fop_write_iter+0x34b/0x520
 vfs_write+0x83a/0xd20
 ? kernel_write+0x630/0x630
 ? rcu_read_lock_sched_held+0x12/0x80
 ? lock_acquire+0x4f4/0x630
 ? __fget_light+0x51/0x230
 ksys_write+0xf9/0x1d0
 ? __ia32_sys_read+0xa0/0xa0
 ? syscall_enter_from_user_mode+0x1d/0x50
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc955d10104

Fixes: 1a353d85b02d ("nvme: add fabrics sysfs attributes")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d307ae4d8a57..cd4c80ca66d4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -243,7 +243,8 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 	 * since ->delete_ctrl can free the controller.
 	 */
 	nvme_get_ctrl(ctrl);
-	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
+	if (test_bit(NVME_CTRL_STARTED_ONCE, &ctrl->flags) &&
+	    nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING))
 		nvme_do_delete_ctrl(ctrl);
 	nvme_put_ctrl(ctrl);
 }
-- 
2.34.1


