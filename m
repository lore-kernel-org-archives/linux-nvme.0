Return-Path: <SRS0=LCWA=KG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61FDC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 10:33:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09379611C1
	for <linux-nvme@archiver.kernel.org>; Tue, 11 May 2021 10:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09379611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X3rvkwLDTTZj8t9Xspv6msOL9aEyTEGXIANWrNDoIWM=; b=PbRxl3Cqu3r6FdLkXjO8imA68+
	iP8b3sITTf8XIiAyATY1KqYWQ0+hprxSCOdBi/i5JEMqojHFN3e3bdEbeM2KIMm1iKdTkEC+8dLaa
	Iu6JjPC0MP4qO40u8dmDNyclMbO/2Nt/rEtEZj5jNTvLaAhx8+2tod3uAs3FiTlavr9VkexCwDEVA
	feZMc5Zj6+/1Wuxshx679e3aicmejyFUngczemzUxYnc3FNreeIS5K3mgpMbBTJvVANTmCPtIcron
	ph+pecmDaAce4dynf9kHjrHfC8vxJJWFLY6GknAHlPlUoYyhEgmmvhn/fGCF3glNHVI33rOBJwgxx
	RPhvr2hw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgPhX-00GxLZ-Hi; Tue, 11 May 2021 10:33:19 +0000
Received: from [2607:7c80:54:e::133] (helo=bombadil.infradead.org)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgKRy-00GJ0G-CC
 for linux-nvme@desiato.infradead.org; Tue, 11 May 2021 04:56:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=aUGRz8/SddWKvaSwbd/gmBK3dNQK6bcFTy9KMxHsXLE=; b=a0JRmvA8b5DE48fUzJ/FJEoR0W
 +B7UvQuF+DXafMMXtR0ldA5cq5R72LJ5dDvStF10+qrskaPLZlTLObEyj6LDrOeZQncZcZvIS46se
 NQoq+32KcoJAWN1CMt74cPLkpMgd5i9dAN99A3O2fFOsqNYM/WP9BRmBUkwTL+5BVMrWQ908CIPYR
 vsW49cZ2/aP9s6HxFQgVuPvN8OP3zvSI1N/Pz0MkrRflew9Vl20yHx50IN7ptlxwc2rU8sZH8l4Go
 5ixrJzYDBwycGFlx8iQlcxR0+hHBOyrzuhS+SSr1lXFt5Yz0U94xQvuqcWbDpV885m7V24l1EuyUq
 aVjSTkuQ==;
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgKRr-009J3b-8s
 for linux-nvme@lists.infradead.org; Tue, 11 May 2021 04:56:48 +0000
Received: by mail-pg1-x52b.google.com with SMTP id i14so14922027pgk.5
 for <linux-nvme@lists.infradead.org>; Mon, 10 May 2021 21:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aUGRz8/SddWKvaSwbd/gmBK3dNQK6bcFTy9KMxHsXLE=;
 b=oIu35dYa1zBfeRl9GRaXj07nlzTS/QaZ6ik9wg+u7tw/WEjLpv5lk/417kr7lzpcbw
 p+7LjeTajPKERta4fmZZ0lrWwQPfiBKvIvEXATAGg9A5h0R/4m8lunwxG6nD6bws9GaZ
 WOKfS9KQpGeNVXaZY4msVrTEB9Pez8eEzWR099ts7tw/nGZ4Vg/G+tie5zapNhVuBNad
 g6rO1NE55WwK492UUb3uLvkAHn+GuFVoBXh0WE0t1vkiTgu+BV6f0x4w8PWH/AhEY2IJ
 DSi0FLqiyLGlygmfca3espHHB+29z1kCEFrDv0yaPhOaYii0VAvz0nhrnFjiDMXsre/q
 TOaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aUGRz8/SddWKvaSwbd/gmBK3dNQK6bcFTy9KMxHsXLE=;
 b=NkJzGyelJJKpp9H7F/q47QkSqoUF/x72ARg2U68VXhVPMpAu9hHEJdxBcSHGBJ8ftp
 JTKZTVT7GTkveej+MhtNX6AQl9CtaGMt2L/8dg0vtY8I34zw48Gn0zaDrEkAXe3z+d/x
 myIEpifwO1xUN5vurW9qxtdscrlIPrD0V84qcdrT6rSRkXyYdm3xogpYmN5srUGzE5te
 9nzfmDjoFzA4cMpESgfQ7XyTQn28sZ066Aeyadv9lWgp4W61nv0WBOKYLvAEe8XqRPQP
 NoTe7iDfnq9XCvdWP68iLRk+plePXPSqJG5BAJdQ/IsQZDXfhAyzlo1M95lcRQIwmAPV
 AMqw==
X-Gm-Message-State: AOAM533cY6gO+uoKeXLPzgsLxzuJ3K8F27M285vpWMpSqgOLDObR3ZsS
 2+1pXfWa1cQSeVrZcRq66ldys0/SzX4=
X-Google-Smtp-Source: ABdhPJxJe6E25A9kwbp3spEApj+7qFiUOvV4Hh3QkYnv86nGPSho9PY31uVarApzq+WC4pHAlhi8rg==
X-Received: by 2002:a63:cd11:: with SMTP id i17mr28474821pgg.74.1620709004047; 
 Mon, 10 May 2021 21:56:44 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id f12sm11880369pfv.155.2021.05.10.21.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 May 2021 21:56:43 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: James Smart <jsmart2021@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-fc: clear q_live at beginning of association teardown
Date: Mon, 10 May 2021 21:56:35 -0700
Message-Id: <20210511045635.12494-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_215647_335079_6E30B7CC 
X-CRM114-Status: GOOD (  13.24  )
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210510_215647_335079_6E30B7CC 
X-CRM114-Status: UNSURE (   9.68  )
X-CRM114-Notice: Please train this message.
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

The __nvmf_check_ready() routine used to bounce all filesystem io if
the controller state isn't LIVE. However, a later patch changed the
logic so that it rejection ends up being based on the Q live check.
The fc transport has a slightly different sequence from rdma and tcp
for shutting down queues/marking them non-live. FC marks its queue
non-live after aborting all ios and waiting for their termination,
leaving a rather large window for filesystem io to continue to hit the
transport. Unfortunately this resulted in filesystem io or applications
seeing I/O errors.

Change the fc transport to mark the queues non-live at the first
sign of teardown for the association (when i/o is initially terminated).

Fixes: 73a5379937ec ("nvme-fabrics: allow to queue requests for live queues")
Cc: <stable@vger.kernel.org> # v5.8+
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
stable trees for 5.8 and 5.9 will require a slightly modified patch
---
 drivers/nvme/host/fc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d9ab9e7871d0..256e87721a01 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2461,6 +2461,18 @@ nvme_fc_terminate_exchange(struct request *req, void *data, bool reserved)
 static void
 __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 {
+	int q;
+
+	/*
+	 * if aborting io, the queues are no longer good, mark them
+	 * all as not live.
+	 */
+	if (ctrl->ctrl.queue_count > 1) {
+		for (q = 1; q < ctrl->ctrl.queue_count; q++)
+			clear_bit(NVME_FC_Q_LIVE, &ctrl->queues[q].flags);
+	}
+	clear_bit(NVME_FC_Q_LIVE, &ctrl->queues[0].flags);
+
 	/*
 	 * If io queues are present, stop them and terminate all outstanding
 	 * ios on them. As FC allocates FC exchange for each io, the
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
