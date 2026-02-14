Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C99EF99FF
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DWiAfLikzaFr4GnyqsyXng2vgSJVn4kiF95ZAV+60zk=; b=qoJVABlCJArgAH26595KGpM01D
	N9BDfBVATOHY/g9NisSj6/LwrRj2Z4XTlYYbD+5CrGYFRQr4tHFHCf7Ffu3hx6Q5qM/CpoHK2qh23
	XqEbL0xTrmbOrhNo0ftneQYE6vPmjVuIrS/g4WwP9f+EfxbnGQB0xtxeswQcfB8jqJLichP8kPEMC
	PK2gV50Du+Dmx17DguPQIzhWJncR/7gXNPW+xiWmv5Eav/HCofBEqPBqW8PvSjFuwlUZeU7aCLZMm
	pxybhxhRQx9e3zoteZmlfP+xoS8fnIqJbAHJdYioa3grQ0IlmiY6s3cxSV/LTdCJwt5rgAosXF9ql
	wmyx9PuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gb-00000004Ew9-1uAQ;
	Sat, 14 Feb 2026 04:28:25 +0000
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7GY-00000004Euz-3Xww
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:23 +0000
Received: by mail-dl1-x1234.google.com with SMTP id a92af1059eb24-1270adc5121so2321963c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043302; x=1771648102; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWiAfLikzaFr4GnyqsyXng2vgSJVn4kiF95ZAV+60zk=;
        b=U3qUM4Z/8IpkSuMczVQxYYrwStl/ds6QkCJZO9iz7208eMxE/GJuxivkJE9FumoyfS
         UxjhfBgKx3fBndf13Gy1oO0/a9zK2McFaYhDwwPu1R/V/Em80bO6t6OWlzXplHwRqUsy
         ei8hoaldyxi0ghy3v9lY9fdIg54qpfedICf33+zoTm4phmwAKio3sA2htSQfJVzodq65
         WDPmlpO7Q8W+nOiOrIr0zHwkI03NSjYL0HZ6xBYGHW9NTd0xZ2yK9yqU5rfOn0x/t9XP
         ZHrWPNWxWpOoHBxu/eQOs1K2pF+1XWf289hs+bLzlmcDcDqm/h9iJqUF+jqwybyn5NW/
         P12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043302; x=1771648102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DWiAfLikzaFr4GnyqsyXng2vgSJVn4kiF95ZAV+60zk=;
        b=T7UzgzmacJPCpLOoFfH0bQN842JboE5285FFxJS+f4f9INEgkxOV1C0oJzbScqb+jH
         HOHmpEs/tOcwLKRf1xSQJ9vEp4mh8/0FSbnJSQBzL+YcD0T98Bx0nikHM/703TtPjJ/v
         53DcLcwpgZOxq/2zbedhgxgmFnxhCyb4gjG+lDB43Ua3Ll5d9JOgumOgK42E5UdRw6w7
         MTVyd/aPd4ssp7HAZH4xTG6YUPdUHN77RfDbB5QeyuGb5oblcS/+zM7SIevXOfFI7PzL
         cqnnlwVhh5vCb1uWVQcnCtI22r8st9tAsSBFOavNh62x3y7UIL3BZdY42Yi6RVklY4mW
         tWdA==
X-Forwarded-Encrypted: i=1; AJvYcCUMVoYDR0tKaOKKu/nvWnhFq8JUej7TAy5cquRQjSkZBUihjkFJaEta33bJ4zVtrezQnir63AwX4ubs@lists.infradead.org
X-Gm-Message-State: AOJu0YwOYezDpZFqdZE9DXVB04MqRb+5fjUNuL/GY5JwXnJbjxwrsYkV
	JXIsJJizj+mXOh6pmBEnv/PzCvwpMstyX4f7osfOlFIlUMk9fWsJA3ECj+hYueU8JO8=
X-Gm-Gg: AZuq6aJswn8WGE71S7czlQeu/FG1YDNWN3GpTdsbp/Xm3X9llH4t21Q8SvTMnw0GriU
	OXYKH4HNyqqhInNX5+SZZYUMTf7xv7DQMVsw9tQ2fw2zcn87snci3xkxx+hfivcmRVH5XIWYQx7
	fMj2zgui+82+KhDYB1SnWkt9dtK2MGAfgFPHz8wbm3als5JV4au6mzeXw8Tr8yM16kmEOm6TEkP
	Lc0cVHu0yxpwrSCD+R619eYO98bXlrw4V9qBPWasb7+FLWHgYrB9YLDKFFh+Fvsc+jcxtxAtm9V
	H7EW5Hdh/2nIwb31vs5FJOf66TnwSwy9lUBxeZm9/wLvNof57ZaKokGKFOEkOIqbBx/H8KI0WuR
	cWgDrGWJee+VXzwq3J1TooyMtbJzJL/kp/tQ/a61poE4a0ETleRmaZ1Tn1Nv0O7PzJGixh3iTlR
	dlRdDrk/0L2JBKvnzSsEP3z4FuYignXOKsNg4tNDLN48tqaw==
X-Received: by 2002:a05:7022:2394:b0:127:33c5:536b with SMTP id a92af1059eb24-1273adf06e3mr1330405c88.1.1771043301717;
        Fri, 13 Feb 2026 20:28:21 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:21 -0800 (PST)
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
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v3 01/21] nvmet: Rapid Path Failure Recovery set controller identify fields
Date: Fri, 13 Feb 2026 20:25:02 -0800
Message-ID: <20260214042753.4073668-2-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202822_884469_35C9CF4C 
X-CRM114-Status: GOOD (  14.92  )
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

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/admin-cmd.c |  5 +++++
 drivers/nvme/target/core.c      |  9 +++++++++
 drivers/nvme/target/nvmet.h     |  2 ++
 include/linux/nvme.h            | 10 ++++++++--
 4 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 5e366502fb75..368e36362ac5 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -696,6 +696,11 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
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
index eab3e4fc0f74..e5f413405604 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1394,6 +1394,10 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 		return;
 	}
 
+	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
+		ctrl->ciu = ((u8)(ctrl->ciu + 1)) ? : 1;
+		ctrl->cirn = get_random_u64();
+	}
 	ctrl->csts = NVME_CSTS_RDY;
 
 	/*
@@ -1662,6 +1666,11 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
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
index b664b584fdc8..a36daa5d3a57 100644
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


