Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C09CEC1112
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 17:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kovlhYTHEWCe+6Hv08nwU/ged3f6bHNO5rTkjbt/oo8=; b=VJuqoTvESvOxzePXFKvmWLzIj+
	p8oNMzd/el2R/QqAf07iZy/q0A2PNn6ipz1+f7n/Z+qr0Vx5jWxKjhzNxgXIEhR2RD8y0vOgsXcYM
	946B4p2FUHw/BcSgeFpXdvzr7DOELfWWewAJe58kfV242WARsAAtnt4f12ETiprt/LeOgPujWQVdt
	aSrwhINjdD1O1y4CZ0j4k/XbhqCNNYLhr8sKq2tDhZhFkSD/U1820U950YF9Y6F8bkqj/qHpipHAj
	FY4F/tcGNXvdu9EXIlGeX3f3AbiS94KuaJKQYFJBwQ3e6dPv2XvQ6Fka5v1S7dGVFVpqdCkooqeWE
	2L43+XqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZfU-00000000mD2-2QQz;
	Mon, 23 Feb 2026 17:24:24 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuZfR-00000000mAn-3YmG
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 17:24:23 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-81df6a302b1so4405591b3a.2
        for <linux-nvme@lists.infradead.org>; Mon, 23 Feb 2026 09:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1771867461; x=1772472261; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kovlhYTHEWCe+6Hv08nwU/ged3f6bHNO5rTkjbt/oo8=;
        b=bnDjmXCz13FwZqj5Rr2LbU2CcgFMx/sESgs+U5JC/aGBuboS95Lk/eSkhxyC/6pL4K
         rd8F2Bn/TdiFcT5YlgQPVXcNKMXQPIEYnt9ojEONAqGAGKuFai1QlnScUsMNVxmfGZmV
         OhdHZMkQe8dLQvzWCSQ/RhHSiA+JUNmOsxN6fKNUn+VFkpfwL5qzl3hDga91MqBbtoYO
         3now/GtbN7xUbGPBfGqV0d0b1V8h1D9589MHeUq4NVTUGIHyWUThetlcW8Fuseukvwvg
         W8uWRWJoDuAMI+v3VXai32DjNvkaiOW+OtKLJHb+vbOqz1ccNTTyBPd2N7CJd6aXb0oy
         6Siw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867461; x=1772472261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kovlhYTHEWCe+6Hv08nwU/ged3f6bHNO5rTkjbt/oo8=;
        b=wdXIDeDocmxN8V0UMwLMECrmPqkqnrCWE3zLYdXgSzyVIP/ZG4eXLxh9QSdBWa+25w
         8XhCMfQqK7bKMdBZMVX4IQxiEAeXC4LM8i5ESS7UqHK+XvXqnTIR9+Q7W78MPYS8yoHg
         oRwl25nlnpdokROMoE80ld0jr6QJ9t+kaAtNvQi96cfc1slvGyoCn4XA3/orsOD/vmf/
         WpMDfL1CJEHYjXB9fVV+wiiEBniyIIbyltiDzjh/luF/dHDwom3BWBTy5TXFzEUWMaGA
         LbVY2bpKYn0CSiiEhgL4yMJ4r5r5/zC7z3XmA7bd3Zl3DaoP5Mm6GnJtptDIN7ydOYOs
         Loaw==
X-Gm-Message-State: AOJu0YyuMZft+QJUabGQZHlrE7pwD+MBnv3oCJEKc9XNSC//FslKnqaj
	7p8P5nZNs/k9tjb29opCldNfSQNMueAHULPJV+5fRKWYaBPXOZg+57lHeYpLmy3D0XE=
X-Gm-Gg: AZuq6aLykAbzjH2/VbZV5WZfP9ZueA+Z/HtUrH3gLYhhUon/J3+nSABEGeRsNjCGKcJ
	FJq5QEtMCR4/V1+t40lkmlemR+PxE0gsZ/DRRp1fxqEbkZIdPFJPXTj/p1XmrfI7z7yjYswQn/g
	h2j/S9IEAuMaZjry+EfBzBVmYGeurqmKlF12Xvsr8lZ45pR2wRtQ89SYMHX28ahULN+5I4KAXSh
	1kvzvx6cCdwvRFQ70SHYTXdz7Djg4bzOA8XHSNP94g2CFYX2C+HVeI7gdArNvaAt++j28dB5Ll5
	Yeh43Pu9HoHNxe3nJhL1V/99icJUOe6DX8BngyIfEo5oGPVxrq+evTSFBGI7rkBWZyOU92DEYkb
	oFWTdCyRsDayrmALOD44ynPv80lmpa/+jRlHYM0jMtO+zXK3L1G0DPqaZR38oZvMp4yQJ2f1FdE
	UqvFGkFEU6YWIpG+mQ9Uyn252R53Awnr8=
X-Received: by 2002:a05:6a20:9f96:b0:366:14ac:e1dd with SMTP id adf61e73a8af0-39545fc297dmr8671445637.67.1771867460985;
        Mon, 23 Feb 2026 09:24:20 -0800 (PST)
Received: from outpost.localdomain ([110.44.9.85])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b724321esm7802332a12.16.2026.02.23.09.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 09:24:20 -0800 (PST)
From: Jaskaran Singh <jsingh@cloudlinux.com>
To: stable@vger.kernel.org,
	james.smart@broadcom.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	Jaskaran Singh <jsingh@cloudlinux.com>,
	Marco Patalano <mpatalan@redhat.com>,
	Justin Tee <justin.tee@broadcom.com>,
	"Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH 6.1.y 2/2] nvme: nvme-fc: Ensure ->ioerr_work is cancelled in nvme_fc_delete_ctrl()
Date: Mon, 23 Feb 2026 22:54:05 +0530
Message-Id: <20260223172405.292040-3-jsingh@cloudlinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260223172405.292040-1-jsingh@cloudlinux.com>
References: <20260223172405.292040-1-jsingh@cloudlinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_092421_898167_A31136B2 
X-CRM114-Status: GOOD (  14.07  )
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

commit 0a2c5495b6d1ecb0fa18ef6631450f391a888256 upstream.

nvme_fc_delete_assocation() waits for pending I/O to complete before
returning, and an error can cause ->ioerr_work to be queued after
cancel_work_sync() had been called.  Move the call to cancel_work_sync() to
be after nvme_fc_delete_association() to ensure ->ioerr_work is not running
when the nvme_fc_ctrl object is freed.  Otherwise the following can occur:

[ 1135.911754] list_del corruption, ff2d24c8093f31f8->next is NULL
[ 1135.917705] ------------[ cut here ]------------
[ 1135.922336] kernel BUG at lib/list_debug.c:52!
[ 1135.926784] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[ 1135.931851] CPU: 48 UID: 0 PID: 726 Comm: kworker/u449:23 Kdump: loaded Not tainted 6.12.0 #1 PREEMPT(voluntary)
[ 1135.943490] Hardware name: Dell Inc. PowerEdge R660/0HGTK9, BIOS 2.5.4 01/16/2025
[ 1135.950969] Workqueue:  0x0 (nvme-wq)
[ 1135.954673] RIP: 0010:__list_del_entry_valid_or_report.cold+0xf/0x6f
[ 1135.961041] Code: c7 c7 98 68 72 94 e8 26 45 fe ff 0f 0b 48 c7 c7 70 68 72 94 e8 18 45 fe ff 0f 0b 48 89 fe 48 c7 c7 80 69 72 94 e8 07 45 fe ff <0f> 0b 48 89 d1 48 c7 c7 a0 6a 72 94 48 89 c2 e8 f3 44 fe ff 0f 0b
[ 1135.979788] RSP: 0018:ff579b19482d3e50 EFLAGS: 00010046
[ 1135.985015] RAX: 0000000000000033 RBX: ff2d24c8093f31f0 RCX: 0000000000000000
[ 1135.992148] RDX: 0000000000000000 RSI: ff2d24d6bfa1d0c0 RDI: ff2d24d6bfa1d0c0
[ 1135.999278] RBP: ff2d24c8093f31f8 R08: 0000000000000000 R09: ffffffff951e2b08
[ 1136.006413] R10: ffffffff95122ac8 R11: 0000000000000003 R12: ff2d24c78697c100
[ 1136.013546] R13: fffffffffffffff8 R14: 0000000000000000 R15: ff2d24c78697c0c0
[ 1136.020677] FS:  0000000000000000(0000) GS:ff2d24d6bfa00000(0000) knlGS:0000000000000000
[ 1136.028765] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1136.034510] CR2: 00007fd207f90b80 CR3: 000000163ea22003 CR4: 0000000000f73ef0
[ 1136.041641] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1136.048776] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 1136.055910] PKRU: 55555554
[ 1136.058623] Call Trace:
[ 1136.061074]  <TASK>
[ 1136.063179]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 1136.067540]  ? show_trace_log_lvl+0x1b0/0x2f0
[ 1136.071898]  ? move_linked_works+0x4a/0xa0
[ 1136.075998]  ? __list_del_entry_valid_or_report.cold+0xf/0x6f
[ 1136.081744]  ? __die_body.cold+0x8/0x12
[ 1136.085584]  ? die+0x2e/0x50
[ 1136.088469]  ? do_trap+0xca/0x110
[ 1136.091789]  ? do_error_trap+0x65/0x80
[ 1136.095543]  ? __list_del_entry_valid_or_report.cold+0xf/0x6f
[ 1136.101289]  ? exc_invalid_op+0x50/0x70
[ 1136.105127]  ? __list_del_entry_valid_or_report.cold+0xf/0x6f
[ 1136.110874]  ? asm_exc_invalid_op+0x1a/0x20
[ 1136.115059]  ? __list_del_entry_valid_or_report.cold+0xf/0x6f
[ 1136.120806]  move_linked_works+0x4a/0xa0
[ 1136.124733]  worker_thread+0x216/0x3a0
[ 1136.128485]  ? __pfx_worker_thread+0x10/0x10
[ 1136.132758]  kthread+0xfa/0x240
[ 1136.135904]  ? __pfx_kthread+0x10/0x10
[ 1136.139657]  ret_from_fork+0x31/0x50
[ 1136.143236]  ? __pfx_kthread+0x10/0x10
[ 1136.146988]  ret_from_fork_asm+0x1a/0x30
[ 1136.150915]  </TASK>

Fixes: 19fce0470f05 ("nvme-fc: avoid calling _nvme_fc_abort_outstanding_ios from interrupt context")
Cc: stable@vger.kernel.org
Tested-by: Marco Patalano <mpatalan@redhat.com>
Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jaskaran Singh <jsingh@cloudlinux.com>
---
 drivers/nvme/host/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9b5976c80803..a355db38edc8 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3264,13 +3264,13 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
-	cancel_work_sync(&ctrl->ioerr_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 	/*
 	 * kill the association on the link side.  this will block
 	 * waiting for io to terminate
 	 */
 	nvme_fc_delete_association(ctrl);
+	cancel_work_sync(&ctrl->ioerr_work);
 }
 
 static void
-- 
2.43.7


