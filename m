Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17127C982D8
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+O4TueAKYiHtgRqWfBMj1NI12Pv4z04h49FFgSbHBPc=; b=YKnpwz93+/cTWYxof1fvSL2K2A
	4/FjVYXoPhNf44sZA/KyWBQtavR4XxGv66mMWSH+hyGAeTCilBvYwCRdUHAeM0cc0oIB8kjhtDVBV
	2yjn6boR+KCoNypxbyBLPcUjC3lL+ln7fBsb7tv7YeMON60q8aEHCI1rLZN2zAfcnDud765rS/m0I
	5iPOIWFZ5juPY2jucncDUN8EIzVXxBLAtiwWR3qBNBTPy89CrX2KtT4cRqhOmmtr2LR++yfcnIwwb
	6NF0BLD6IEU01WXZfK4Iv3+LtemSOddw6Hr3KnKaFNK/3zrCgQRpZRggF9qIhx79BABaPHfbBey2r
	YEoXf8/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MIu-00000000Dib-15x9;
	Sun, 20 Sep 2026 18:30:20 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MIr-00000000DhX-3Y7X
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:19 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so2431649a91.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929017; x=1790533817; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+O4TueAKYiHtgRqWfBMj1NI12Pv4z04h49FFgSbHBPc=;
        b=Ag+pQqsO094qwA6tkEuwxg1IK/CeWpVIGKPAvDNFIKhsscSIf/O7tt2Jzr233tQ4il
         4dcJHhxZLFP9TEVt3DA300A7sQXWq5UCqTKZ85QjtuVrHszelEaL9Ao01B4D2hZnxIrk
         nB1bmOIOIgsgfvVcdx9SRzeFgFleV1F7pTub+V5gUCvRepG1Sv6tuH+Sa68gNWPOc4Cj
         K4kYNryl+0BE0GlHExZrFpu2SflQ6+BGSw+MSu07VIOrd2zzY0aEx8G7bdokq4jc8yZJ
         0aUdawQsr2E82N/9BzxpusMXJv9XTZq9IdnuX4m/6ohmfd2ywy4jNnRdC4/7mSFdlRPS
         +3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929017; x=1790533817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+O4TueAKYiHtgRqWfBMj1NI12Pv4z04h49FFgSbHBPc=;
        b=L9nU+VuKgtNQuQSuFxzsmhL2G5kIJiRlkcnbQXzKnb0u6mii3yHGiODziI7mLOlGNl
         mGI06dy9oeakLAB5eQIDf2dD3NiYZCOjNamm0lk6x8T0V2LE7ZeBB2GFrvm7k/1x6hdA
         mweKPcoIPTTtxuDiOVXkCa8sTYTdgf5eq9poI/yA4oYkTdnqmLDWeDUlgiPvvi9I1HSw
         JExDPkOlob6MLmx0QBP9/E1VbEHMNvggP+R4qKCYmhSVMYShhj5NBu6dtRny/01uDnoS
         +XAHo1Eu46TeHAdGp6cPNYBbYdrs6lquF4WcHH9dq2XIL+zQ0WKkKIXh4U/loZMzpqbS
         HC+w==
X-Forwarded-Encrypted: i=1; AKwUvByhZGbQAb1T3+OrebunvHWbX4WC4GTi/peUqyXnbA1T7tlxDovBp8tudKCKSDEqorONyndjPwTe3YuW@lists.infradead.org
X-Gm-Message-State: AFuF++mR6nXsGq/kzh6I7xD7d/uU+Cl/gLbU1JxjKijTn+UXHCGkGHM+
	z8BLodpjVM2OC2z2LAuujdD/U1/YEdNqq8Jym9SWQqoAYr/zV1r1kjdEobVW4cJ4IMA=
X-Gm-Gg: AYBFou0FanCQdmLGviMXC3OnBq5TsM+Wu5k4TMtnuUA/Y6PqJ8Qz5xvIRW7wzufI5mF
	UqwIhxfT0AozVaJwq+JBkqzqjRo1Hl367nxLewSbGw1Mr6UJvQsYBnOW6wjDAm9Nu1yO5wgULcX
	XD/mljCqqDziRr7jBEeihoCxetumiDzz724DdIA73moLRuOY0ZRb/JYr0Z3tTyLYIz8Pkm2IJGl
	gztO629CAErriG9wTFbySCGfM+8RmB4d+OXijfzwGr/jsig0OHhiWlLNdgTT3pxxhsm9arWcubE
	gIty+HXSmPC4uTUG0BCAcXN9pd2ADYG5/doOuFpxdwoug4Ea6an2fylmwsSUdHKGwbUBP2hoJRQ
	dUbBvX55qFqM1y3Y8SS/2KLSpPnKh5PNpdwHuSO6SLrFxmsA2XIB4ykAdENBzoEi8Bp9jetlJ8r
	yKbsnf0VHYMfVe/rylO0V4/C/w2fgIYWsvn/2bsyYp0u75LG3CuTQR30WP
X-Received: by 2002:a17:90b:1cd0:b0:396:7c01:553f with SMTP id 98e67ed59e1d1-39e36106b85mr17159180a91.21.1789929016695;
        Sun, 20 Sep 2026 11:30:16 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:16 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v6 01/18] nvmet: Rapid Path Failure Recovery set controller identify fields
Date: Sun, 20 Sep 2026 11:27:59 -0700
Message-ID: <20260920182936.2317916-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_113017_883020_BEE5CB82 
X-CRM114-Status: GOOD (  16.45  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/admin-cmd.c |  5 +++++
 drivers/nvme/target/core.c      |  9 +++++++++
 drivers/nvme/target/nvmet.h     |  2 ++
 include/linux/nvme.h            | 10 ++++++++--
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 7764a3c0195c..bf7c5f5927e3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -693,6 +693,11 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
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
index 43871a8f56ca..4c8f30c5ff7e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1412,6 +1412,10 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 		return;
 	}
 
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->ciu = ((u8)(ctrl->ciu + 1)) ? : 1;
+		ctrl->cirn = get_random_u64();
+	}
 	ctrl->csts = NVME_CSTS_RDY;
 
 	/*
@@ -1695,6 +1699,11 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	}
 	ctrl->cntlid = ret;
 
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->ciu = get_random_u8() ? : 1;
+		ctrl->cirn = get_random_u64();
+	}
+
 	ret = nvmet_ctrl_init_pr(ctrl);
 	if (ret)
 		goto init_pr_fail;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dbda55895f4f..e3e414ef68d3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -269,7 +269,9 @@ struct nvmet_ctrl {
 	uuid_t			hostid;
 	u16			cntlid;
 	u16			max_qid;
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
2.55.0


