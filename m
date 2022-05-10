Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EF7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 20:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4mkXfBOsra36+NEkCqMoCZAIM4Sa+cL7AC/Mj7PxHoI=; b=s59xiSuuXWCxDXpoMcsr7bGx8N
	7hEqsf49hZ6BeqhUKpSSAQfG3EzBV25P5xGq/xGGcXez+6ejwPnxAmRd5fqTufKnVEMJyb4vGI/Z1
	/gxYPqyvDHndDl/I0C4K67JIm8no1WgmZsewUBo1ZXA/J9c+bSejx6ZLzvVS8O5mvAR8tTBPJbh4y
	eJdYRRniYq0eNZlt9bWRT9lbLnyTW1gtSV9VaPnvDdeGG4M5sRCdm7xU+hjT0RXWjSceRQGMksWJT
	gzfWh77na6GaZ8BS+ZUeL68HpnfHxZ5amUDopqdzbCa2JSAplKLIpQksDF/yAHAPZK/JThTwixSax
	krviN6ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noW2U-003t7o-JJ; Tue, 10 May 2022 20:00:58 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noW2F-003szR-Q0
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 20:00:46 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 137so868996pgb.5
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 13:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4mkXfBOsra36+NEkCqMoCZAIM4Sa+cL7AC/Mj7PxHoI=;
 b=jJK9glZbNv/5I2jm2a3WHv1AY/fSlaN9y6ZSRx+Pj91OqpAV+4/otlFvNRvBHEWvtm
 LP8Via76vvkqc0TCE9ruLJbCknVA3wysXzXUxeF9LrBxRG1+ZaZ2qpB+AYnJFCSGMURx
 Chu8O+3Wah29w5wgfXOGS5KVWW1jMH0fZW6P3XIpj7c45zFv/LbB8Fw9IiOq7ujVbHUU
 tuwF5BX99u/F22iGH6GjGjoxKTrSkHtJC+t3e5iJlpbxjp/fHUuM2ur7pMocbPRz199G
 sNhzZmYFArXbSAoG8OINrAEJ6gunLfkLqGXI5Uv4ik7U1X1l/aTNUYiGJjgrD+fF8ZOL
 fT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4mkXfBOsra36+NEkCqMoCZAIM4Sa+cL7AC/Mj7PxHoI=;
 b=EVpEdEOC5ttgWaMIvfpQG3+gv/khNQ3KMdWpRzUd8o06GeyCZZzJllgotPt0a+NPrp
 P8wLAeaQkCC/bQSqoLyYOiuoqSawz/mT7X+8Yd6/3wvfyMeDHX+szGtrKdYkanHxJoiS
 dM63KLD3g/ZVsfYnZa6/lb5N27Av1IGXIw2bGJ2L0oDCHsRNMT1m3ekwHOkcHoICE/ow
 JslsX+3tED94ajRlkxCe9YNdXV2W94oPbpKH0IjaYkOATQfzWAVM6+MLiIPADnrfQTp7
 Qr9Rmq5bKMYLf+M8LGh7DASts4Hq58oOlg3Op0k9RXaogU7EhIKyBk/BmKIQSKZhv9Nx
 7w1w==
X-Gm-Message-State: AOAM531vsP6qIjeLcAcnl81FpQWcqJOOSEZy0ksRTqDvPy5O3SVkEmMS
 IWLNsdsBVEwe8T6eigXWxMU=
X-Google-Smtp-Source: ABdhPJw1cx3C+TUifOD0C1x8ZI6K/5DAaeqvsczH7y6CpTEPm3hpgefp8gmJ7+OFd3by5l5GrK4Ohw==
X-Received: by 2002:a65:6051:0:b0:39d:1b00:e473 with SMTP id
 a17-20020a656051000000b0039d1b00e473mr17820372pgp.578.1652212836941; 
 Tue, 10 May 2022 13:00:36 -0700 (PDT)
Received: from mail-ash-it-01.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 bh2-20020a170902a98200b0015e8d4eb2d2sm2422679plb.284.2022.05.10.13.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 13:00:36 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Muneendra <muneendra.kumar@broadcom.com>,
 James Smart <jsmart2021@gmail.com>
Subject: [PATCH 1/4] nvme-fc: Add new routine nvme_fc_io_getuuid
Date: Tue, 10 May 2022 13:00:25 -0700
Message-Id: <20220510200028.37399-2-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220510200028.37399-1-jsmart2021@gmail.com>
References: <20220510200028.37399-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_130043_869796_8FD3E21D 
X-CRM114-Status: GOOD (  16.46  )
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

From: Muneendra <muneendra.kumar@broadcom.com>

Add nvme_fc_io_getuuid() to the nvme-fc transport.
The routine is invoked by the fc LLDD on a per-io request basis.
The routine translates from the fc-specific request structure to
the bio and the cgroup structure in order to obtain the fc appid
stored in the cgroup structure. If a value is not set or a bio
is not found, a NULL appid (aka uuid) will be returned to the LLDD.

Signed-off-by: Muneendra <muneendra.kumar@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/host/fc.c         | 16 ++++++++++++++++
 include/linux/nvme-fc-driver.h | 14 ++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 080f85f4105f..a484fe228cd5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1899,6 +1899,22 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 	nvme_fc_error_recovery(ctrl, "transport detected io error");
 }
 
+/*
+ * nvme_fc_io_getuuid - Routine called to get the appid field
+ * associated with request by the lldd
+ * @req:IO request from nvme fc to driver
+ * Returns: UUID if there is an appid associated with VM or
+ * NULL if the user/libvirt has not set the appid to VM
+ */
+char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
+{
+	struct nvme_fc_fcp_op *op = fcp_req_to_fcp_op(req);
+	struct request *rq = op->rq;
+
+	return rq->bio ? blkcg_get_fc_appid(rq->bio) : NULL;
+}
+EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
+
 static void
 nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 {
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 5358a5facdee..fa092b9be2fd 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -564,6 +564,15 @@ int nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *remoteport,
 			void *lsreqbuf, u32 lsreqbuf_len);
 
 
+/*
+ * Routine called to get the appid field associated with request by the lldd
+ *
+ * If the return value is NULL : the user/libvirt has not set the appid to VM
+ * If the return value is non-zero: Returns the appid associated with VM
+ *
+ * @req: IO request from nvme fc to driver
+ */
+char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req);
 
 /*
  * ***************  LLDD FC-NVME Target/Subsystem API ***************
@@ -1048,5 +1057,10 @@ int nvmet_fc_rcv_fcp_req(struct nvmet_fc_target_port *tgtport,
 
 void nvmet_fc_rcv_fcp_abort(struct nvmet_fc_target_port *tgtport,
 			struct nvmefc_tgt_fcp_req *fcpreq);
+/*
+ * add a define, visible to the compiler, that indicates support
+ * for feature. Allows for conditional compilation in LLDDs.
+ */
+#define NVME_FC_FEAT_UUID	0x0001
 
 #endif /* _NVME_FC_DRIVER_H */
-- 
2.26.2


