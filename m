Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68BFCCCFA18
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 23:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O1qmLvBmRsfddvSIMLLF1wU/sxsBAzT2ahNzIDu+7xY=; b=1F2ayCkiLzX/ytj9LK7fsSff6/
	tspqjPexIetlkItNhjCmBdC95Rv5JLwBaAJstWmaoiFhgzY1jg8ATFBJFUEBL8bPsS1plv/k8Awo8
	3HUl9OtTjDEMYDAiDXCtXxYuHc0Bt2lAu6SQaN1Fb6JEEwSgKPz1l2MTsCX1kIl8hSTOg6dCfhMQ9
	rHh4yvPfyKgR0h5xXm5wyHqd8upDkvhozutk9PkDDNqo+CCqO2yanojR+xqe/dlv2TEwgwxHqUq8x
	xmYoraBKz+EkSDx6hf0+QR4Zsc7/UAMAVMgdifRN11JKruXhKabxZfU9kxn7pnW/72bG3pLkEG+fT
	hxsDspHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIy3R-00000007tOT-3idS;
	Tue, 11 Nov 2025 23:45:41 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIy3P-00000007tNo-2hCt
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 23:45:40 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-782e93932ffso206315b3a.3
        for <linux-nvme@lists.infradead.org>; Tue, 11 Nov 2025 15:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762904739; x=1763509539; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O1qmLvBmRsfddvSIMLLF1wU/sxsBAzT2ahNzIDu+7xY=;
        b=lXMN55evtXHVj4XwIyEOi9zI3ChSgi1fgAtkz+8EMPDxwCEL1AkD5jKKqT6L2Vx1Vx
         wbj/YfOgvvYX5lcsvR8JkBjYs4+fRcBF5tsHET3uv/ULG6zK4GNA06vwm/9v4EgzqN06
         83xjyYfeJ3ou3Yx1f1XuwiG0EsMrrUr+G+VP8NgAxR8QGSTB+Ev4kt6Og9Lo4fowWuSF
         Ud4GBqz5Q8jlQwopU1yJ1TQtIH569C1xMBCxSMnremaayJQ5jRaQ4NitozdKsRVDDFS8
         wTto+i7vbFz8A1hutHfhQ/OEjouGZwBE+eQfQkjQPTOywggRr4Jw5aT0ff4ozYfajej8
         AwGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762904739; x=1763509539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O1qmLvBmRsfddvSIMLLF1wU/sxsBAzT2ahNzIDu+7xY=;
        b=Joh3M0wHN0dhuwY0/oL7H3LjC/g5BGSvngm9hy71/vdpHjRIzoYbInx7N258wg1mE4
         ySGDdvK3bdfK+8HXwYteyf6mVRt5nbU3v2vJvfp6/kxobCxRPtZOgpC9bvn27synXoiP
         MVluBejE/hswM48LHlOxa5NFZcbWEmXct8S71HPM29NVmx62L/F2sLPAYGbOAZMumMB+
         7i6S0AqHl2EUPcrDUbxwM/MvMoQ8EW8GfIUKvG39lclyOrVLC9gRVDtYaT+njy89EZsq
         64+54oWyJyRrD5KyH8LPFf6vm0TnF17Mbb6Ys+PZoFsf//5wLB3mRDiWQXmT7xcX/ThK
         pDEg==
X-Forwarded-Encrypted: i=1; AJvYcCVRuCZ27ZQ4qUQ+vb6mjNi9DuXqHJ4FBOQ5UiqgH6f0TiRxHMrs3o+DMQFuuDrUwPc46g5bBuQ+g0X1@lists.infradead.org
X-Gm-Message-State: AOJu0Yxn86QO9KGthJmSJbq/9tKYw33Flh8bYUWUEBPMVFKKSk3nbY0E
	4I3xYvn4b92GWjOZjhTeg+WnJYUqCcjuBM/hd7JZbS493gUObLU6F9hlpeFbfQ==
X-Gm-Gg: ASbGncuPrF1Nkkd2gjfDZn3ydrsotL/5AaQTRQy0soaAUror3b9rVksqAfRsgvK0zez
	A3W/BAaj08fIAzlc+Y/64C7TUQWU0jtIOMTQaGRiRKAk3UMozf8cwn6PVFzQOA9Cy2yFgtw94iC
	dEpK0hFXyrjgV2NrVooEtijDtGxt2eiW3696PlF5USSNp+w8UEetw9Zd0fGNQdXzIEuBSlxoW1D
	s/mWX0G6MBNvkmGLrDysomMMwmZE0e8T/gupYDKc9FxBTXw9uKLUcl2pvoXO0xKgjMcAxTBVnUF
	qauyG/Trijb041lBsASlKmc3294N/pf5Vd6PNKPqTYbRCHWd5WOavByQpeKxR9FK2R7dPpY6aU0
	B9/ydITYmAgXnPdp3oe74KcENBS/EcQGUr8Z4eqkX3YY6IdO3gSfIeWTMvdxuHf1Hz5W77wvbuq
	QLiMocVO9RXEXidXE8VM17YlHk7jgS1fwJdktvD+jJksD8J2X8h8a8HiWTiO8tb9HBAFYFgflur
	i+32wtrVw==
X-Google-Smtp-Source: AGHT+IGa7SEJ6OSEuz2ghiRvesNvzPboXyLy+UmQ+C5H9LApItHI6PS/SlgKFtZajc5yC4DweL7yxw==
X-Received: by 2002:a05:6a20:548d:b0:344:97a7:8c62 with SMTP id adf61e73a8af0-35909f6dc49mr1277638637.23.1762904738869;
        Tue, 11 Nov 2025 15:45:38 -0800 (PST)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf06e85bb4sm784308a12.0.2025.11.11.15.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 15:45:38 -0800 (PST)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 1/4] nvmet-tcp: Don't error if TLS is enabed on a reset
Date: Wed, 12 Nov 2025 09:45:15 +1000
Message-ID: <20251111234519.3467440-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251111234519.3467440-1-alistair.francis@wdc.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_154539_689745_588BB29F 
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

From: Alistair Francis <alistair.francis@wdc.com>

If the host sends a AUTH_Negotiate Message on the admin queue with
REPLACETLSPSK set then we expect and require a TLS connection and
shouldn't report an error if TLS is enabled.

This change only enforces the nvmet_queue_tls_keyid() check if we aren't
resetting the negotiation.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
v2:
 - Fixup long line

 drivers/nvme/target/auth.c             | 4 ++--
 drivers/nvme/target/core.c             | 2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 3 ++-
 drivers/nvme/target/nvmet.h            | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 300d5e032f6d..58d80fc72fda 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -140,7 +140,7 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id)
 	return ret;
 }
 
-u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 {
 	int ret = 0;
 	struct nvmet_host_link *p;
@@ -166,7 +166,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 		goto out_unlock;
 	}
 
-	if (nvmet_queue_tls_keyid(sq)) {
+	if (!reset && nvmet_queue_tls_keyid(sq)) {
 		pr_debug("host %s tls enabled\n", ctrl->hostnqn);
 		goto out_unlock;
 	}
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5d7d483bfbe3..bd9746715ffc 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1689,7 +1689,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	if (args->hostid)
 		uuid_copy(&ctrl->hostid, args->hostid);
 
-	dhchap_status = nvmet_setup_auth(ctrl, args->sq);
+	dhchap_status = nvmet_setup_auth(ctrl, args->sq, false);
 	if (dhchap_status) {
 		pr_err("Failed to setup authentication, dhchap status %u\n",
 		       dhchap_status);
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 5946681cb0e3..2e828f7717ad 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -293,7 +293,8 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
 				 __func__, ctrl->cntlid, req->sq->qid);
 			if (!req->sq->qid) {
-				dhchap_status = nvmet_setup_auth(ctrl, req->sq);
+				dhchap_status = nvmet_setup_auth(ctrl, req->sq,
+								 true);
 				if (dhchap_status) {
 					pr_err("ctrl %d qid 0 failed to setup re-authentication\n",
 					       ctrl->cntlid);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f3b09f4099f0..20be2fe43307 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -896,7 +896,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
-u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq);
+u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
@@ -917,7 +917,7 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 void nvmet_auth_insert_psk(struct nvmet_sq *sq);
 #else
 static inline u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl,
-				  struct nvmet_sq *sq)
+				  struct nvmet_sq *sq, bool reset)
 {
 	return 0;
 }
-- 
2.51.1


