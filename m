Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD6FC44501
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LJ3eqT5MrrmAjHbEtV8wOhzni/tkslB66Zt2m3a2DuU=; b=EOVC65HnJXnc1c0igsLZQhmGRu
	aoO7HrKS43adPIq+rnVHsEwhRN3nkeYyaa+aAYSS/xtry1uZ6lcde22LLUZ+bDddr5PmLeEV3w5lU
	iHDhAOvtnSjo4qXCq/W4e16EGfMPGe18+e2VvrJGePe6gJN2ROjf9KJp5VmdSI/8waWzIxkLS7BLC
	4tNzdcQq91FnWI0bDEtXApetaa9w70YCZrSoS5lPk30U2SAk26wtzmm9wPsfkzhoJwGUis9c502np
	qPVFvdQkVlUNzUEOCtmdT69MuxcNEYpPnW3P4Cch/FyYmcb7vL1d/lvMyEJDQjie0HOk0D4LSUemu
	9Qn276iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsg-000000071Lf-3usF;
	Sun, 12 Jul 2026 02:25:22 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsc-000000071KQ-37sC
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:21 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so2377070a91.3
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823118; x=1784427918; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LJ3eqT5MrrmAjHbEtV8wOhzni/tkslB66Zt2m3a2DuU=;
        b=J1n1Zot69Qbx5eY065Hi3KfUJlkQGoD1yFsKwGjpz2kyPYAaz8XcORUTF+w+CsmSlh
         hDm3dSwnZzZ6JhqNKl/LzsRRFPeRMy17H+yt+NB6KGPWtnWWbPE3dgbzRdwIvajomOBu
         RMp1wjVMZvYsQ7Ng3XYE3bsqP7uAW0geCPxNR+1hiHNi/9Rw1HtOS4YmMknF901CT5oG
         L7gYRUfPqfPOo6KXtuxx5+RoA4SwkQKjPa7S0fi8x7VjV1P6ZKQP2Lb9N1AtC8v+NDgW
         ellT2WRaxF+fZ/nfKvmSwk+68iMDQ5MiFbHHT2uObLpIzB7IpQcbbC4M2EHsCS9arbBn
         PWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823118; x=1784427918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LJ3eqT5MrrmAjHbEtV8wOhzni/tkslB66Zt2m3a2DuU=;
        b=YLmG3lAUak5pfU2zdhlHGRAq0B31rrNliv24u9ihMA4Z8kPGsxAoBieqzQWdX1gF9X
         LtZmaFgoxsJn5O9axmLApYWH/zsZd5oWURJJeJh7d7eKVKaQWWOY0mCQGU9kAsmPJxs6
         bJodz827cppra1goAbSm5HV6XzDYE4lh8fm0D/DjhqZ2y5IP9+yxDIjNRCFZ8dOBkaQA
         j6s/kevZC4Es5a3/j5bv7Tnkcqzhx1GdZFB5hUkRXLYJRQe+aa9RBSI7bTASQP6fpurg
         /1+0nkpfeJo/9yEUfIYZ0RFhtZbLkFBZr6KSmuKBTdbq0NmiuhAJkoIKcRtWAE0fTkZk
         LnAg==
X-Forwarded-Encrypted: i=1; AHgh+RoajPYIFGz5PTXOYb2HsJiaFBKY7BdbHQegEmNv7JYljnp+5FJVy/4iZgsUb18lhUqLJkCQw0uyuZZT@lists.infradead.org
X-Gm-Message-State: AOJu0YxTXujaT0TolI+t023/e1T/4l4hUsffG+D87Hphemt0gfCtbezX
	XyUavDCWjC/8ci5wQ/rnV6QJoUSOqwIGy4tdf87YNAsk/GQ/zLBiWmEkgl37njtpx+s=
X-Gm-Gg: AfdE7cmru00cuiJr7sZEri5o0Eyj25dP3alHSNGvTNPPebQOstOa6Rc8dYhZR1fnN//
	QCUZ09atZ0aopO6x/iNxDnVao8B9aD//WNx0A1IXtKq2KutZjrirnnm+phKaxqgjQAHUpFvQLtg
	Cqb0pVQ/fgtlZzYFBbXhK/Cgr4H7KExz1gXckt+/41QsSCNSSKHoiyP0aVJHd6rnthmlOAulR8H
	ouGwXM68cyIGds+EKm+2QiiMzpH2f5gLosaNWPKV+R4lsLfghDyWMu56Z9y8I9YcfGndHrlwjB9
	+F5E0//az6y8ljd+38GfBRVceUCBlMsISHFWQhFlnhSjA0+6156s/0ESIJKXWBApQXTzTa3olut
	7oZirtSTHPI5rJ+6k3loNSxxCIqhuK29hbpX802jJfB1PtqEoFotcRUYyVlFYzRwOGSsRmBkkry
	zG+6hk
X-Received: by 2002:a17:90b:5585:b0:37f:db06:229c with SMTP id 98e67ed59e1d1-38dc777b895mr4349898a91.22.1783823117600;
        Sat, 11 Jul 2026 19:25:17 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:16 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v5 01/16] nvmet: Rapid Path Failure Recovery set controller identify fields
Date: Sat, 11 Jul 2026 19:23:22 -0700
Message-ID: <20260712022437.3743117-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192518_785693_91817A0C 
X-CRM114-Status: GOOD (  15.41  )
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

TP8028 Rapid Path Failure Recovery defined new fields in controller
identify response. The newly defined fields are:

- CIU (Controller Instance Uniquifier): is an 8bit non-zero value that
  is assigned a random value when controller is first created. The value
  will be incremented when RDY bit in CSTS register is asserted.
- CIRN (Controller Instance Random Number): is 64bit random value that
  gets generated when controller is created. CIRN is regenerated everytime
  RDY bit in CSTS register is asserted.
- CCRL (Cross-Controller Reset Limit): is an 8bit value that defines the
  maximum number of in-progress controller reset operations. CCRL is
  hardcoded to 4 as recommended by TP8028.

These fields are set for non-discovery subsystems only.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/admin-cmd.c |  5 +++++
 drivers/nvme/target/core.c      |  9 +++++++++
 drivers/nvme/target/nvmet.h     |  2 ++
 include/linux/nvme.h            | 10 ++++++++--
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 01b799e92ae6..81988b40d5d5 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -691,6 +691,11 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->mdts = nvmet_ctrl_mdts(req);
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
 	id->ver = cpu_to_le32(ctrl->subsys->ver);
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		id->ciu = ctrl->ciu;
+		id->cirn = cpu_to_le64(ctrl->cirn);
+		id->ccrl = NVMF_CCR_LIMIT;
+	}
 
 	/* XXX: figure out what to do about RTD3R/RTD3 */
 	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a2403a808360..d42421420be6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1406,6 +1406,10 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 		return;
 	}
 
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->ciu = ((u8)(ctrl->ciu + 1)) ? : 1;
+		ctrl->cirn = get_random_u64();
+	}
 	ctrl->csts = NVME_CSTS_RDY;
 
 	/*
@@ -1671,6 +1675,11 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	}
 	ctrl->cntlid = ret;
 
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->ciu = get_random_u8() ? : 1;
+		ctrl->cirn = get_random_u64();
+	}
+
 	/*
 	 * Discovery controllers may use some arbitrary high value
 	 * in order to cleanup stale discovery sessions
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c672c9bf3053..9c98833e8f3a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -268,7 +268,9 @@ struct nvmet_ctrl {
 
 	uuid_t			hostid;
 	u16			cntlid;
+	u8			ciu;
 	u32			kato;
+	u64			cirn;
 
 	struct nvmet_port	*port;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 91ce434a7e8d..cbaf02b0cf07 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -21,6 +21,8 @@
 #define NVMF_TRADDR_SIZE	256
 #define NVMF_TSAS_SIZE		256
 
+#define NVMF_CCR_LIMIT		4
+
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
 #define NVME_NSID_ALL		0xffffffff
@@ -328,7 +330,10 @@ struct nvme_id_ctrl {
 	__le16			crdt1;
 	__le16			crdt2;
 	__le16			crdt3;
-	__u8			rsvd134[122];
+	__u8			rsvd134[1];
+	__u8			ciu;
+	__le64			cirn;
+	__u8			rsvd144[112];
 	__le16			oacs;
 	__u8			acl;
 	__u8			aerl;
@@ -389,7 +394,8 @@ struct nvme_id_ctrl {
 	__u8			msdbd;
 	__u8			rsvd1804[2];
 	__u8			dctype;
-	__u8			rsvd1807[241];
+	__u8			ccrl;
+	__u8			rsvd1808[240];
 	struct nvme_id_power_state	psd[32];
 	__u8			vs[1024];
 };
-- 
2.54.0


