Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF19C982DF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+O4TueAKYiHtgRqWfBMj1NI12Pv4z04h49FFgSbHBPc=; b=QgKkevtJQsX9lJJm8X0qkb0Tur
	SlgxU/di6xtNUuqOG8Q5WWXrbnP4KIo67Jc9uVaL/NhA9muSl58OASlyYB/S8qc0j5vqY83w3aUjD
	gY1fGL7PhgShXMmk9oRWp7KJl29/Kzt+HJn6hKT9Zh6HuBXx/MsVEQYzNziz1RKySGsaLhLrbUmwD
	YuOPyHkRYTXFEmXLnJ79KGCTMdRwk+I7xYOddPk10Ab61oWBXtqTg50t4+lvWmiCoO5V43v6QeYaY
	b/PfavC0YpQ+9mefbmQBKmikiQ8JMIexti21+gUutvglptb3dPPcO1qHqHSnmE8vgeCOJWwzQbdl8
	7DtDInvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d8x-0000000FGxg-3NO7;
	Fri, 18 Sep 2026 18:17:03 +0000
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d8v-0000000FGwZ-2n0E
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:02 +0000
Received: by mail-pj2-x0e.google.com with SMTP id d9443c01a7336-2ddb44ad1c1so11230965ad.3
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755421; x=1790360221; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+O4TueAKYiHtgRqWfBMj1NI12Pv4z04h49FFgSbHBPc=;
        b=RIEsdq/2v7A+ZvOLDs53JsC/pqAcCjscQx9LFzCBxwnw/9HQgQydEbzOiKazwF3xzo
         6vz6h76g8TnPQatAEM+m03Mtp5UmF7vl+NIK+JYOhy1OmFzd82dPIU101L1pIS9y9/aG
         SY6jdeuXm0mY2jc1VIdkCOE8H+YeQyC6+fkNYJbPDjNO10NwAtL5Pc8qrzyRK2HI9F5a
         jqatMsJAiR/Ekf4nAFg7wtTUAnHaOIcbdnnRCHNBfUw3lpyh4TCdAPhlk77lOR5ClKW4
         EVta5T2h9pTGGGl1QV1R3fwN1jlMWSgGlae9TJbBRI8ZaADSbMeYCCqdWTbFK71E1UaI
         pShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755421; x=1790360221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+O4TueAKYiHtgRqWfBMj1NI12Pv4z04h49FFgSbHBPc=;
        b=kWIGRrZSIGK32d6cDg8nnZTVMdnpURHOrx0IxGbzyJwjZqMfCMasWZZOJCuGOiLnNA
         WcQ83jOULBkpcapWC7KP1zM1J+Hn7cjK2N+FuYI6BpoK5+eSn2MQ7q3VuzexesYKLKps
         ninE/0GOUSxmOoc8ndzpDB5UHN6RiBiWYtHP6j0NZzxHGfTICheHh/R8TDnQkuZ40mhW
         FLUyvWTwCcdgo14jtGC19N67U3sd5J4+RfwUO9V659nTZVu7daebuCbM8OAEmfZHzOMp
         MP/veQoaTBAtZpF8Jup4GcuW46LraZLlwDW2bSbivR80YZKDKnRQI48ap6ydJmJwksaX
         KsXA==
X-Forwarded-Encrypted: i=1; AKwUvBymJ22Lib+vsb7o2ZMrXBh4iasHQpCaKIVsXL6w1mc61QSzSoCXkcQecRfstGOeQ5NWgDKhKEzlgmGd@lists.infradead.org
X-Gm-Message-State: AFuF++nFA26T0vLmZlvIMBlQ3RGz5POwmqoL57W2gGaZX7h4Gahkmxi5
	b0OhgqwOM0GSaJ7korbU1uataZUEdXR99r+gxUAQs5sZ9jYObaFvTcALgF3kv/Oxk48=
X-Gm-Gg: AYBFou0TsqAI5oWmTvLRE0blx1LtcWAuH0j8B1sXcTMr33QEfSjVvC/yuO5J4zQzRea
	8FEbj5qEyk0iA6j+fp0Bhwlth4aWfhbf2K7HSMXA53+eX9khdJHeyYEEnlkwwC/y7tQVLoz7A6v
	dRWVFWQNCtF9ha4WM1cilsqNjNQY2GFXi2kpZN34QO4B4HX910C/VS+W5CEP0d+EIP+HxIxqW/x
	evspqXC1KcOCiWTLlZgJ4Ddq5YzdgkG0UZsUTSSdO/go4wja+Egd5uTsjxjiVMsuL9wHjom0Z2E
	dzhwh10cUUwU8kbmDnPmkBHJC0GUkGan1Q2FcZvne/ne15owRwXbuqejNzdu/2eHaN2cm9Bhkun
	OBUUyxScXoauDy+z7JfOqMacQ4/SL/tGkUUMdYgqYbJL59K2vJ9Dshoj+ZFCd48Yk0OBLg/HyfI
	IoSeCZKletjWwihAvWDemjjmUwWlqq7UIRPvj+5BqO3UT291dhUM3SfRSP2L82gqVW+/fSTYBga
	Jtaf5+rsC+5bRmE8X9Mo2mV1HJ2dGaP
X-Received: by 2002:a17:902:f546:b0:2dd:c053:82f2 with SMTP id d9443c01a7336-2ddc0538461mr10467265ad.41.1789755420559;
        Fri, 18 Sep 2026 11:17:00 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:17:00 -0700 (PDT)
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
Subject: [PATCH 01/18] nvmet: Rapid Path Failure Recovery set controller identify fields
Date: Fri, 18 Sep 2026 11:14:01 -0700
Message-ID: <20260918181614.3947933-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111701_728276_5FC35D94 
X-CRM114-Status: GOOD (  16.37  )
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


