Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74FAAC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 20:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T+kXOv6/wWEcgyg9QhuqsaSGFRe97BZqyoi7R+lGhmE=; b=JRlLSDYQD/TQ0ggsHTk1jzdUKC
	olDiGhZnW0wm36NWvLOMmB0FaA7TRx7es51YVo5N1ZmvNxcydbr8hNPwE3YhWqsqJ39TJMYIrMiet
	CtpBfYeeYZ1g/ovPuYZqV8ZFRV4jWd/IBBnLr7wee/6mC7V+k3OgLKOAOKtmOga6Q1uaoJSeLjucc
	u17rbzbJpnnYDfa+qnJ2rhZTA9Z9fFkobFUFAdac5vpB08g521mlP4KC17+q+ATSmqsmUYsimhPVI
	zAy3NK9kdAh//Z4KKsFDSu0aSr+Df2BXSc/HlkfSbZTO8VQRAk+NgPAqP3U1rcnRdhRiH5b3hKOM9
	rJEE8svg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noW2Q-003t6j-A6; Tue, 10 May 2022 20:00:54 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noW2F-003t09-Pz
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 20:00:46 +0000
Received: by mail-pg1-x532.google.com with SMTP id 202so15494538pgc.9
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 13:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T+kXOv6/wWEcgyg9QhuqsaSGFRe97BZqyoi7R+lGhmE=;
 b=p1/i/ZV0pT8615LNv6Zf1IruIYAo+ekvFsP91nL2zPdEk0R3sDnU3f86AqATCrR4Vx
 HBJDJeih5I+TJcJdhuxZ/XIr5O6lcFDDJ2CTudfS2xptJdsSlxN6ZRCnWQ008tg02AP1
 2PPaIFNGuIHImYqgiEwj7fU/0Ya3hB7idu4fhDm9HOtEGFnMrnKIduPElooDRxTe1LKI
 zH2EgmNvusYgqDEgUWGGi17arsyNuphHMj+8M+q2igy6uD48Q0pmilq49OxM0b2Z4V58
 /xDFe0Jk9c34H0jVmKekGT5YTp6CMnQZOg3Na+jw9XRjSNknsXK+1Zys4/yQ1vF7sGmF
 9dAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T+kXOv6/wWEcgyg9QhuqsaSGFRe97BZqyoi7R+lGhmE=;
 b=2lRrZlnCwfw28uimgG0PkfNGwav4ngp7Jc8poa3i9HD3Nxy6E/xGOnZ4PHpc7odXNT
 MKgkSr7jq+/K3g7GKKa3LLs2GVYdnk2XDvxIo5wC2NBY86KD6cWPuBMD6F4sga8muP7v
 SPQ5KQgUyrNF41c8RkjaVtjMFpG59K+c7Lfta5kXYnS2yOoYZGZAhdR/IF3GRgRFSYya
 IDS3aM49Q4KJ0ifNy3hHg2/ZUTWp4v3SA5dou+nBJfxRyf+O4SQiwMs/4Iu0W8gkKVeZ
 bfM3JMQDUVRBm4ZjJD5BoaATZf6Q5DL9H9J3hP77Zxw0nUGuXzVYruf6Xj5f6U5fzoDr
 61Gg==
X-Gm-Message-State: AOAM5311FE0glFGnPD8ivY4cPjgdtOXvxBozHAUKrfgvz+6/R9Ih/9PM
 LavlY4lLNrbgTkNn8KwEdzQ=
X-Google-Smtp-Source: ABdhPJzCDevBRV78CphoEtrU7yHW9B1gsklwQx63JtnF6GoSWnE6yMq0IFiVgMLZW9dnqbUNqD+M9A==
X-Received: by 2002:a62:a50c:0:b0:510:6b52:cd87 with SMTP id
 v12-20020a62a50c000000b005106b52cd87mr22047230pfm.30.1652212840295; 
 Tue, 10 May 2022 13:00:40 -0700 (PDT)
Received: from mail-ash-it-01.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 bh2-20020a170902a98200b0015e8d4eb2d2sm2422679plb.284.2022.05.10.13.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 13:00:40 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, James Smart <jsmart2021@gmail.com>,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH 4/4] lpfc: Add support for vmid tagging of NVMe I/Os
Date: Tue, 10 May 2022 13:00:28 -0700
Message-Id: <20220510200028.37399-5-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220510200028.37399-1-jsmart2021@gmail.com>
References: <20220510200028.37399-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_130043_860938_4406CA0C 
X-CRM114-Status: GOOD (  16.91  )
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

Modify the nvme io path to look for vmid support and call the
transport to obtain the io's appid value.

Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nvme.c | 45 +++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 5385f4de5523..335e90633933 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -1279,6 +1279,19 @@ lpfc_nvme_prep_io_cmd(struct lpfc_vport *vport,
 
 	/* Words 13 14 15 are for PBDE support */
 
+	/* add the VMID tags as per switch response */
+	if (unlikely(lpfc_ncmd->cur_iocbq.cmd_flag & LPFC_IO_VMID)) {
+		if (phba->pport->vmid_priority_tagging) {
+			bf_set(wqe_ccpe, &wqe->fcp_iwrite.wqe_com, 1);
+			bf_set(wqe_ccp, &wqe->fcp_iwrite.wqe_com,
+			       lpfc_ncmd->cur_iocbq.vmid_tag.cs_ctl_vmid);
+		} else {
+			bf_set(wqe_appid, &wqe->fcp_iwrite.wqe_com, 1);
+			bf_set(wqe_wqes, &wqe->fcp_iwrite.wqe_com, 1);
+			wqe->words[31] = lpfc_ncmd->cur_iocbq.vmid_tag.app_id;
+		}
+	}
+
 	pwqeq->vport = vport;
 	return 0;
 }
@@ -1504,6 +1517,11 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
 	struct lpfc_nvme_fcpreq_priv *freqpriv;
 	struct nvme_common_command *sqe;
 	uint64_t start = 0;
+#if (IS_ENABLED(CONFIG_NVME_FC))
+	u8 *uuid = NULL;
+	int err;
+	enum dma_data_direction iodir;
+#endif
 
 	/* Validate pointers. LLDD fault handling with transport does
 	 * have timing races.
@@ -1662,6 +1680,33 @@ lpfc_nvme_fcp_io_submit(struct nvme_fc_local_port *pnvme_lport,
 	lpfc_ncmd->ndlp = ndlp;
 	lpfc_ncmd->qidx = lpfc_queue_info->qidx;
 
+#if (IS_ENABLED(CONFIG_NVME_FC))
+	/* check the necessary and sufficient condition to support VMID */
+	if (lpfc_is_vmid_enabled(phba) &&
+	    (ndlp->vmid_support ||
+	     phba->pport->vmid_priority_tagging ==
+	     LPFC_VMID_PRIO_TAG_ALL_TARGETS)) {
+		/* is the I/O generated by a VM, get the associated virtual */
+		/* entity id */
+		uuid = nvme_fc_io_getuuid(pnvme_fcreq);
+
+		if (uuid) {
+			if (pnvme_fcreq->io_dir == NVMEFC_FCP_WRITE)
+				iodir = DMA_TO_DEVICE;
+			else if (pnvme_fcreq->io_dir == NVMEFC_FCP_READ)
+				iodir = DMA_FROM_DEVICE;
+			else
+				iodir = DMA_NONE;
+
+			err = lpfc_vmid_get_appid(vport, uuid, iodir,
+					(union lpfc_vmid_io_tag *)
+						&lpfc_ncmd->cur_iocbq.vmid_tag);
+			if (!err)
+				lpfc_ncmd->cur_iocbq.cmd_flag |= LPFC_IO_VMID;
+		}
+	}
+#endif
+
 	/*
 	 * Issue the IO on the WQ indicated by index in the hw_queue_handle.
 	 * This identfier was create in our hardware queue create callback
-- 
2.26.2


