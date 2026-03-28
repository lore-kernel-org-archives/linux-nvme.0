Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F01810ED67F
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2026 00:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I7azvsY2lfVVrUuxgtShy75bCL3D9ds2FfFrJhMe74c=; b=OJ5Lpkmbg6nry0TIDLQLgH8i6q
	Zwd4kik6EinXBVEg+FFGYr2pOf3E1GDr/3xGDjS6b9oCLILhlP+Z4nUJb/0MiHHPXfWJfLD7tZLi4
	7mVIc5AFKxOOk8TAsN3aAfZRAYkBpwXQJKETFsB8t9SwQJrz0TvHea1siirf2OxKKcTaksP4X33a4
	lnTLR9nQMFq1VVl2FC3oH3I4BH0mnVo9jwJLV5SZ9nUaCjiHwgDFmap8TOfRgErzWInP9JZy7SncM
	CHC9307s7AaIyUDGO6F/BnePZ7YgRk+O+17AxkilDya1/WkL2stADY4kr42QTnUjsuQCyMYwZ9aaH
	anjWtVTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoJ-00000008NpC-3754;
	Sat, 28 Mar 2026 00:45:55 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoG-00000008No6-1nd5
	for linux-nvme@lists.infradead.org;
	Sat, 28 Mar 2026 00:45:53 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so26244745ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 17:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774658751; x=1775263551; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7azvsY2lfVVrUuxgtShy75bCL3D9ds2FfFrJhMe74c=;
        b=GIQ00JcIgkPwaP7h+9qQITiHTgj4+HRZ3pCiMO7gEnP0Qtsz7K3mFu20oTXtWFRx6D
         cjanutgomplNtp5tRMT2s2XtTc+LWvbD+oxw4Si+xoATH6hfukPQYuDjxynotNGLPvl2
         5+EDgSewE87LKTTkWi9WYQ5uc049xi9k7rre7DDq8x2HE7GcN+50QNCt8jUZ+KH74iFp
         srG3L35WL3MJqf2XBK5uxU28+dL8PZmPZEi872Jm3dqvfIf3Fzh/nINyc9+hLdvLwK00
         7RxK2h8atIo+yoDgwKp8N/X2tl4FZ3jYm7CwmeDsC/jkEVdA7j2M24ZtHRgOJjenROAv
         tRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658751; x=1775263551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I7azvsY2lfVVrUuxgtShy75bCL3D9ds2FfFrJhMe74c=;
        b=QB31OwwDjmE/jwPGooJQa9bEoaSYcZBAFH4UOAhTSgbHU3ePd+uBCl/kz4H59DllKM
         YJ7r/rAaMdC/qBb75NI7iQhmqDh3nuD0GHgY6WKUpBdsrf8Z3eOEHQygM+mYBcRBMLD7
         1irYrtQfOMzVgwR0c7t46EoolvGAIDCbG5nvEwVWmofIb5O1Zr1eOWmQ+tCkrMcqQTvY
         FOiFoO7a2ByZ7T37Svw60Dwb9fEMWmD4NAG8e+ZiEdzeAsHguKG3jEGjNTTlmiuGQEVC
         YsTtVxNQzmgV7esunUdJEP23BWm3erBSjp8vs4D6O8hF02n2whHLXozspaLAgzK8CZ9C
         JPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVglBwqeQ+VaixmWxymsnlrT+JHcDfXPEeuMCE1pyhT5kjm9SjoRsp7OfyiEszz+E5sKM05HRyZ9qx5@lists.infradead.org
X-Gm-Message-State: AOJu0Yxqjqya1ppQ2KmN+H4O28GLR+54KqB+mP8n6eCn49ZDSkpjezoT
	/CRam50aucLndbzvnrlQY8Wo9j0LF0Hlv7c/WX+lE38yRdU4JRz3p9sP+T9ow1/tj+g=
X-Gm-Gg: ATEYQzzoBaeTzlTNLOuZbFWA9NP/fryAkNswRgsgAeGJeM2zw9O5HHyNaZ0Zoxz+ua2
	F+Rl6qkwjMrg87ot42HQNZaK2x3mzDLAQ6ComY5zhQbYujG0qYT0y0Nl7ry+Y7U2GTlNW/9JThD
	bA7OIn8Y+lSr9apLASIS4bVkvXyUQ8DYhOH6l4JhhqfGUuebbmniDcVVeEw44XT3BBbTk5sxB8M
	uRG33kvdqL7j35en4xGAjU+RMI7eoyzMWTkagTPqR1xxFDfZA9S8Z5sW95AZiF12havAd+2zUuT
	u45U8UbOpmKP8z3qGy01B1bqkQ5/xYQ1M4a4AAMMT7MKzggnzmHL7D0oAS4wBbx58fA7j0McJp/
	bkN6dN3oPU96re/5LmfedrYkujps1XwhduR6kf1lc8JnYK93z7II6mtpGuYezwgHQoo5DMzRfkK
	UEsvnDoN4oESi6fY2xWw==
X-Received: by 2002:a17:903:46c6:b0:2b0:66bc:2282 with SMTP id d9443c01a7336-2b0cdc20726mr49307635ad.6.1774658751378;
        Fri, 27 Mar 2026 17:45:51 -0700 (PDT)
Received: from ceto ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b242683064sm5342705ad.33.2026.03.27.17.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:45:50 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v4 01/15] nvmet: Rapid Path Failure Recovery set controller identify fields
Date: Fri, 27 Mar 2026 17:43:32 -0700
Message-ID: <20260328004518.1729186-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328004518.1729186-1-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_174552_470998_6456378D 
X-CRM114-Status: GOOD (  14.80  )
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

- CIU (Controller Instance UNIQUIFIER): is an 8bit non-zero value that
is assigned a random value when controller is first created. The value
is expected to be incremented when RDY bit in CSTS register is asserted
- CIRN (Controller Instance Random Number): is 64bit random value that
gets generated when controller is created. CIRN is regenerated everytime
RDY bit is CSTS register is asserted.
- CCRL (Cross-Controller Reset Limit) is an 8bit value that defines the
maximum number of in-progress controller reset operations. CCRL is
hardcoded to 4 as recommended by TP8028.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/admin-cmd.c |  5 +++++
 drivers/nvme/target/core.c      |  9 +++++++++
 drivers/nvme/target/nvmet.h     |  2 ++
 include/linux/nvme.h            | 10 ++++++++--
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ca5b08ce1211..ec09e30eca18 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -695,6 +695,11 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
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
index 9238e13bd480..e8b945a01f35 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1396,6 +1396,10 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 		return;
 	}
 
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->ciu = ((u8)(ctrl->ciu + 1)) ? : 1;
+		ctrl->cirn = get_random_u64();
+	}
 	ctrl->csts = NVME_CSTS_RDY;
 
 	/*
@@ -1661,6 +1665,11 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
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
index 319d6a5e9cf0..2181ac45ae7f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -264,7 +264,9 @@ struct nvmet_ctrl {
 
 	uuid_t			hostid;
 	u16			cntlid;
+	u8			ciu;
 	u32			kato;
+	u64			cirn;
 
 	struct nvmet_port	*port;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 655d194f8e72..7746b6d30349 100644
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
2.52.0


