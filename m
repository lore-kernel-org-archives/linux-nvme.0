Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB85D10374
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+zJ+1UlEvFnxYO/+mlL/kPamED7cAsv3lc5btMMeFCc=; b=BovLmIKtadpG+rjPSLrvqFKoeE
	VplDqzTZXoOqiB2VUfEsDSdNCzfI17yEOSwqXp16snUFUy/q3cEHcXtqZg0scvGDD43ktdjgK3htU
	YWeZbjuAlSdGqCrVIrzgFjyI+XvCLlwENbLHaqxk3rqbBROxt36p719NOWMZ/BigS/6j5ZoF1WKYi
	RSeu8Y7LLmWEavHvJte3yAGiwtTmsTtow+qsOwyuWtz1P++an/alAv4XWvJPiYTXkElNAL+tHtwfH
	k6AwuSzMBbgorkvAymp4W9U+TpBYlsdnI7p1n97UclWCRKyhtPMGqXg16eFxnEt83Sp4O+5bBRNnZ
	2+RzVPNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO526-0000000EDM4-0dRv;
	Wed, 26 Nov 2025 02:13:26 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO523-0000000EDKm-2mlq
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:13:24 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-bc274b8ab7dso4460715a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764123203; x=1764728003; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zJ+1UlEvFnxYO/+mlL/kPamED7cAsv3lc5btMMeFCc=;
        b=NTDOOfWL4AHPg+N9maj6zjVITxVhtqHOWozfjdtHloaEoJKCVKAtuavrCtdPbmwzKu
         9+rcr9g1AjKJ4aO3iSYPoo0cKMZMqEV7Vtz1zSEL7xUfU6GV/bw52G7ku0YoHGbek1Bk
         43uKwvCifFny0+KJHy/H1Ps1mfM6XqeHv3BDmT786L/v7g5Yz8oJLjmX4sCpen5EkUV4
         Ll9NsouIP/2GCbjOZON21aaG5FHNeEXVKQwNw/6N54Xmac7GKM/LjcQEScJ3NpRn8kNc
         rHDGi8sfqRAy4T+Hgz079HL1BXRtmy5kDNR9Y5iXto4GaaOVEupqw37+mLFK00WRUkvq
         He4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764123203; x=1764728003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zJ+1UlEvFnxYO/+mlL/kPamED7cAsv3lc5btMMeFCc=;
        b=AdSJX9KsORySu05zVaOEM2+G+AW6a+CbRnTnJvyAQiinJWTW/L0qb/QuFa6AzBvjgF
         KCC1kw6CcZMQVgEOmcdSFHyaW8z4QTeq3Nl8DBHyJULgWwxKB5Zzolg4nGJLebqkJx5U
         RmvvQD744IuI1AwP2diogLrWMCHp2cX5HYbSNDVUGFkoPizGSssBFI4C467DSAvHZCsl
         O/NnvOvYaREWjsrSz3qaj1KkcH6j0sTpMlgIrJJIF8JejwFYXMs6tPa3cBMfgR/A4AfF
         NF7JE0iIrPohocCSEp0ffQ6zZo8nJXCjmoTA2BBF/kyi8Sq40lCuGprC832N9ONz9gA/
         bdNA==
X-Forwarded-Encrypted: i=1; AJvYcCXaVCz81GWfXtbOZyni9EgekE7q1eTf5atOeb8YQ/NOp5Yal4XS1O005ERzLrxcV4yqaq1eDu9Nvj5r@lists.infradead.org
X-Gm-Message-State: AOJu0YxPbjMIVpgQfZ7LD0iXWtR5BmNhjg3QwwZX4lKDKMn5iM/+YJem
	Jsoz5K408vq68DSMQ9XMNrRgbAYeasQ/BQOH82ZzB6v2pAohK6yKi/M2NRz5CrqrHks=
X-Gm-Gg: ASbGncsO4tcabkC3jb2k+KBut+4ZqtxQSe5IC9iaPsQpCleH3gXog8XBksKf5ypVYL4
	8SygRIgreewV/9mNDWk5/kjZ7L9X5dysbkMorOnZ41UsKLdQJoir0Ga8eS3RGac1OzOO+9I9CGN
	ZuvAiLJMSHwWSC3SBWY58CLVejFdzMi2aWQlxNDjnItVGs+2z3zlHVX/ghr6A3jvyI7ux5t3j7h
	IidKRANTbauAAjf1DxUC9R8tuilMkJVf9lVxZUynEcw76ac+kWqujYf4VeHaZmYHycNErwqMS7d
	NFgviSnHxODUQWPizq9TA5R4FG3TmDLck2c8GNGCkpTSN1/liaAmUDNWoq4y31hq+7TnOGuZ3UC
	cthCkfoKYUH6B/5gIT+yLjT3chqVq4+9Xaj+XahIQiVsIgzs9qzvqy+yhPTR/KNwQ+amIPgmLlc
	ehY/NgpBTsaziZuTDm+fUH/Ye74MlbbgXQZEo4yqV/u5if
X-Google-Smtp-Source: AGHT+IH3R2YXscEDzBRGNgHJXNj5sRMpFq3GXf09IFZdkJCTqRDyWOlwHS19A1MouExGkMqjcKV+Kg==
X-Received: by 2002:a05:7022:90f:b0:11b:9b98:aa4b with SMTP id a92af1059eb24-11c9d60ea32mr11119676c88.6.1764123202326;
        Tue, 25 Nov 2025 18:13:22 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11cc631c236sm17922979c88.7.2025.11.25.18.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:13:22 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [RFC PATCH 01/14] nvmet: Rapid Path Failure Recovery set controller identify fields
Date: Tue, 25 Nov 2025 18:11:48 -0800
Message-ID: <20251126021250.2583630-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126021250.2583630-1-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_181323_723356_509A6DCD 
X-CRM114-Status: GOOD (  16.76  )
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
is assigned a random value when controller first created. The value is
expected to be incremented when RDY bit in CSTS register is asserted
- CIRN (Controller Instance Random Number): is 64bit random value that
gets generated when controller is crated. CIRN is regenerated everytime
RDY bit is CSTS register is asserted.
- CCRL (Cross-Controller Reset Limit) is an 8bit value that defines the
maximum number of in-progress controller reset operations. CCRL is
hardcoded to 4 as recommended by TP8028.

TP4129 KATO Corrections and Clarifications defined CQT (Command Quiesce
Time) which is used along with KATO (Keep Alive Timeout) to set an upper
time limit for attempting Cross-Controller Recovery.

Make the new fields available for IO controllers only since TP8028 is
not very useful for discovery controllers.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/admin-cmd.c |  6 ++++++
 drivers/nvme/target/core.c      |  9 +++++++++
 drivers/nvme/target/nvmet.h     |  2 ++
 include/linux/nvme.h            | 15 ++++++++++++---
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 3e378153a781..aaceb697e4d2 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -696,6 +696,12 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
 	id->ver = cpu_to_le32(ctrl->subsys->ver);
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		id->cqt = NVMF_CQT_MS;
+		id->ciu = ctrl->uniquifier;
+		id->cirn = cpu_to_le64(ctrl->random);
+		id->ccrl = NVMF_CCR_LIMIT;
+	}
 
 	/* XXX: figure out what to do about RTD3R/RTD3 */
 	id->oaes = cpu_to_le32(NVMET_AEN_CFG_OPTIONAL);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5d7d483bfbe3..409928202503 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1393,6 +1393,10 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 		return;
 	}
 
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->uniquifier = ((u8)(ctrl->uniquifier + 1)) ? : 1;
+		ctrl->random = get_random_u64();
+	}
 	ctrl->csts = NVME_CSTS_RDY;
 
 	/*
@@ -1662,6 +1666,11 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	}
 	ctrl->cntlid = ret;
 
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->uniquifier = get_random_u8() ? : 1;
+		ctrl->random = get_random_u64();
+	}
+
 	/*
 	 * Discovery controllers may use some arbitrary high value
 	 * in order to cleanup stale discovery sessions
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 51df72f5e89b..4195c9eff1da 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -263,7 +263,9 @@ struct nvmet_ctrl {
 
 	uuid_t			hostid;
 	u16			cntlid;
+	u8			uniquifier;
 	u32			kato;
+	u64			random;
 
 	struct nvmet_port	*port;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 655d194f8e72..5135cdc3c120 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -21,6 +21,9 @@
 #define NVMF_TRADDR_SIZE	256
 #define NVMF_TSAS_SIZE		256
 
+#define NVMF_CQT_MS		0
+#define NVMF_CCR_LIMIT		4
+
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
 #define NVME_NSID_ALL		0xffffffff
@@ -328,7 +331,10 @@ struct nvme_id_ctrl {
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
@@ -362,7 +368,9 @@ struct nvme_id_ctrl {
 	__u8			anacap;
 	__le32			anagrpmax;
 	__le32			nanagrpid;
-	__u8			rsvd352[160];
+	__u8			rsvd352[34];
+	__le16			cqt;
+	__u8			rsvd388[124];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;
@@ -389,7 +397,8 @@ struct nvme_id_ctrl {
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
2.51.2


