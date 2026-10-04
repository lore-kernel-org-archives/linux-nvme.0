Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2230DCA5FCE
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Oct 2026 07:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OdRsUg4aEd8z+aIPLHLtgWH8DwChXLilPVarrUw7AJg=; b=kUAYubRLlt5Z2hGWlBhqU4FXuI
	W4PY+SE69Y3uibD/A4RmXBoZk/kOZQTlrwnSGuhY6vM0gQ8x8LZhgwsWBb4DPDNzQWz9aYCzrsYJM
	vW+mJ+/+XsLzyqmI4Zea5KVg5v2R79CnKeCJrSoZKccaiiAza47jm54b5ApRxszSWNVabIJxk00dC
	3Lm76NnDsxYzhNMLEAa2B4ZnKWgktBrv5wkudVAbYWRTRhBQXw+dliS04f0UqSK0o+tqGysbC81N4
	tJZnuvBYb3NPiZA/jSCehrt3HqMzXNt+q/mRZdRDQNd/2lCgUpd8+5fHSkdMkq6nnKoY2M9U10/2q
	Mo3hbE3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDGby-0000000ESmc-3c9e;
	Sun, 04 Oct 2026 07:26:18 +0000
Received: from mail-pz2-x0d.google.com ([2607:f8b0:4864:3b::d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDGbw-0000000ESmH-1Juz
	for linux-nvme@lists.infradead.org;
	Sun, 04 Oct 2026 07:26:17 +0000
Received: by mail-pz2-x0d.google.com with SMTP id 41be03b00d2f7-ccc90f98036so185466a12.1
        for <linux-nvme@lists.infradead.org>; Sun, 04 Oct 2026 00:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791098775; x=1791703575; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OdRsUg4aEd8z+aIPLHLtgWH8DwChXLilPVarrUw7AJg=;
        b=dPfChJq1suihKvsrH7zeCBaKVRdgNiuEbdmzB1Ax1TbDOq20jtY9FsYpDc/AW7xVoT
         ZlEUTIzyp8IoO7sNxhsUvY+g5Zr1Oqw7Pbuso9dE0NqDn+SoFLcgP5kGV/7S1XU/ZrPo
         MdmL2ntST+UUnDs8to5BwyVso4kCWL+R9OIwvYsULInkqhSYY2XYnUgSv4KLc94YePPr
         4isENfZFqPEuLAItlMxvngZbBfG3zTLUerAeOlTpbykrrsj6MegY0lWvg3ud6n2ZjkRt
         NQVm1vapVYITOMd0NOEZJ8s3J1tN3EJZXwtrZQMnjm2MKYYTBHklkQF6QV9lXzgmHYQO
         QvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791098775; x=1791703575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OdRsUg4aEd8z+aIPLHLtgWH8DwChXLilPVarrUw7AJg=;
        b=0WV4kzVkF3x9AbDy77TreHj8ikb4aY3QgwptSNkrskpfoBqwbEmB6pAvan44BbdtdG
         qKiL4TZUZkfifcQzmRxCR9LwUyuBO4UgjpF1TTZFZQx5Flu+gKVj8iqXK0XgEVtvm9dR
         rpaORXFGxxYol1WjrLIOrruOJsCLG//pnBpIoyogvTsaLkXlPqEWXGb3Rw8iftblasE4
         Z5Zk5kxvOqsIDWf+IREvFiLKBVU5UwzTu/mePEcnB9fhcDCkPiRKXEEsNhs1gKBmt5NW
         836ycGBa8jYL3+uxMmlK+zOOVzAgILuyZn11yAr+r/HHmzZBo+KeJpHNCaeplMh2hKF1
         bEAg==
X-Forwarded-Encrypted: i=1; AKwUvBwyvl8G8VMycbyRAh1BnQi8GqKVmSYqmj46EymmFEpRb/luKl0J8CYk39PB8Sso/NzsECmE0TYencq9@lists.infradead.org
X-Gm-Message-State: AFq9FYLllebso/Y2VsrJ/nb3vsVsokTFPR5LKHq1MGGVSEw28pVNmMcI
	mmvUYZUCHt0ZR7A5U2SMqkjU9Sb9wKF1Gvc9aSedvXYhpmFio/jqfe8pF342j/kCie4=
X-Gm-Gg: AYBFou0PbmdyvYfpbTpm00cjBdjbfZlBnwz09JCQBJ+IHuJd92tjmQkRcYYr2Hu6OXL
	CTU+jkxnLk+YNGgco8D3uGc3oxL659F2p3hKeqm00P6vp3ny2sIk7ler5fp/kJhpNySaQxBHsEA
	QL6Tebm56+DFXEpP+hqdiiQElxzLVEqvnYufQE6fW1x5RYaq5BsCKvlKKNos51wALycle+IXLs6
	WzawvwsLnYFAYzGOWXyYfICppYyhWj8RLM4Q/iEOlukKnkgk0PeAlPMvD7stWpBkRs/FA42/abO
	of2nh3vFRtcONu7+FFE3uVKj6L7k9UaXRz3LfG/Cp8wl4Vo4cY6+EjCoa+1rV+/L6AYdAyCk91L
	cXhgXuHk/ABmn8FUHc/rRFT2GkJXZAvWgcHBMrvTvxGjKWh+COKOaE/LPPjPfSnufeS/daiye1Q
	z/GqNj/MEQqUowZM6FDMwJlCPe80o54wXR+LSclDUf3SEvkniTsQKWYjrPh0po1nJMwQ8+lWCe8
	Mdvta3HgXleyHRd40A6Nylmr5ShDHyGmyk=
X-Received: by 2002:a05:701b:2704:b0:144:f096:4dda with SMTP id a92af1059eb24-14f5c9da5abmr10241977c88.43.1791098467702;
        Sun, 04 Oct 2026 00:21:07 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([223.185.132.231])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3512718a18esm3057871eec.17.2026.10.04.00.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 00:21:07 -0700 (PDT)
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	syzbot+76c0f0ce8f1e846b4f84@syzkaller.appspotmail.com
Subject: [PATCH] nvme: keep a private copy of the effects log in the ns head
Date: Sun,  4 Oct 2026 12:50:52 +0530
Message-ID: <20261004072052.1574-1-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261004_002616_382453_95AD3EC3 
X-CRM114-Status: GOOD (  17.42  )
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

nvme_alloc_ns_head() points head->effects at the creating controller's
Commands Supported and Effects log, which lives in ctrl->cels and is
freed by nvme_free_ctrl(). The head is owned by the subsystem, though:
with several controllers on one subsystem it is shared between them
and stays around after the controller that allocated it is gone. When
another controller then (re)scans the namespace, nvme_query_zone_info()
and nvme_command_effects() read the freed log:

  BUG: KASAN: slab-use-after-free in nvme_query_zone_info+0x4fd/0x6f0 drivers/nvme/host/zns.c:47
  Read of size 4 at addr ffff88802ab9e5f4 by task kworker/u8:2/43
  Workqueue: async async_run_entry_fn
   nvme_query_zone_info+0x4fd/0x6f0 drivers/nvme/host/zns.c:47
   nvme_update_ns_info_block+0x1b2e/0x2af0 drivers/nvme/host/core.c:2430
   nvme_update_ns_info+0xc6/0xd90 drivers/nvme/host/core.c:2553
   nvme_alloc_ns+0x1a9f/0x3e50 drivers/nvme/host/core.c:4293
   nvme_scan_ns+0x79d/0x910 drivers/nvme/host/core.c:4483
  Allocated by task 6345:
   nvme_get_effects_log+0x13a/0x280 drivers/nvme/host/core.c:3422
   nvme_alloc_ns_head drivers/nvme/host/core.c:4037 [inline]
   nvme_init_ns_head drivers/nvme/host/core.c:4153 [inline]
  Freed by task 14867:
   nvme_free_cels drivers/nvme/host/core.c:5165 [inline]
   nvme_free_ctrl+0x1e4/0x6b0 drivers/nvme/host/core.c:5183

syzbot hits this with nvme-loop by connecting the same zoned subsystem
several times with duplicate_connect while deleting and rescanning the
controllers. The NVM command set case (head->effects = ctrl->effects)
has the same lifetime problem, as ctrl->effects is also stored in
ctrl->cels.

Give the head its own copy of the log, taken when the head is created
and freed together with it. That keeps today's behaviour of using the
first controller's log for the whole head, but no longer ties the
head's lifetime to that controller.

Fixes: be93e87e7802 ("nvme: support for multiple Command Sets Supported and Effects log pages")
Cc: stable@vger.kernel.org
Reported-by: syzbot+76c0f0ce8f1e846b4f84@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=34a8e8b643a20c2cbde3
Assisted-by: LLM
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
---
 drivers/nvme/host/core.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5d7dfd7a63d4..f0df4c204e52 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -694,6 +694,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
 	kfree(head->plids);
+	kfree(head->effects);
 	kfree(head);
 }
 
@@ -4022,6 +4023,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ns *ns,
 	__must_hold(&ns->ctrl->subsys->lock)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct nvme_effects_log *effects;
 	struct nvme_ns_head *head;
 	size_t size = sizeof(*head);
 	int ret = -ENOMEM;
@@ -4052,11 +4054,22 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ns *ns,
 	ns->head = head;
 
 	if (head->ids.csi) {
-		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
+		ret = nvme_get_effects_log(ctrl, head->ids.csi, &effects);
 		if (ret)
 			goto out_cleanup_srcu;
 	} else
-		head->effects = ctrl->effects;
+		effects = ctrl->effects;
+
+	/*
+	 * The effects log belongs to the controller and is freed with it, but
+	 * the head can outlive this controller and be shared with others, so
+	 * keep a private copy.
+	 */
+	head->effects = kmemdup(effects, sizeof(*effects), GFP_KERNEL);
+	if (!head->effects) {
+		ret = -ENOMEM;
+		goto out_cleanup_srcu;
+	}
 
 	if (ctrl->ctratt & NVME_CTRL_ATTR_FDPS) {
 		ret = nvme_query_fdp_info(ns, info);
@@ -4076,6 +4089,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ns *ns,
 out_cleanup_fdp:
 	kfree(head->plids);
 out_cleanup_srcu:
+	kfree(head->effects);
 	cleanup_srcu_struct(&head->srcu);
 out_ida_remove:
 	ida_free(&ctrl->subsys->ns_ida, head->instance);
-- 
2.55.0.windows.5


