Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC41C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 20:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1qsp3v6JLdFkpkDuPdqdTA04998UbyaxHTh9mj+8HL4=; b=YqHncJV99O5Tby6KTCuKUcltfs
	1SFWt+hDg+US20dG+y362Kt55mAPzJBH1ADQ76ATKwezQ+bU0SwWzVZ/eVHp+Aw6kYlk28VWj2CXK
	Brp2yu/r19lbq4+cKhMFgYUZcsgVklJ5421JDNaVyEo5YsUoS1lEiDEPtBQIwPyRoSMYD4g96/UpO
	28RzcWUePwF/aMUMszu6yt2xx5paiFtNISDE7bACL8YcKY9LxkXwEm+qZArwW6hQe+lkcyVmZsCeq
	67FVSmlnAF4UzJ2iUdm2wtgEXB3u7dJfaFNDqF+Fn1NiiGxIn/l6HGgbC/0DB/S7ajKAhwWggvNJN
	OjBvbkBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noW2M-003t4A-0Y; Tue, 10 May 2022 20:00:50 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noW2F-003szt-Q6
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 20:00:45 +0000
Received: by mail-pj1-x102c.google.com with SMTP id iq10so235460pjb.0
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 13:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1qsp3v6JLdFkpkDuPdqdTA04998UbyaxHTh9mj+8HL4=;
 b=K/R2+YWadyMquiVrAfC9DWx0IvLH2EvbP0RTf3Caqpr04h2UWFJ/Tn3rZyeDgsoaP6
 YYTuZSJ/aJUAPCrauoxAWcDY58737fm+jBXDt9D3cvXC1HbGYKkHG2dDCcOJLsPWmErD
 adoBvVAmBpqBvONadbYU0ScFb/TBzoCdq9g80Dl1re0ftN1U4n97Y3G4yhBeA1FsFp1Z
 4YhoIcgXhYYfGuLbz7rPoy1mmhmwSYg/SDUxNf6+xIKoOJu6/YsgENNlnLpLegi/Q/JB
 77af+2impLs+NOxPpU6tc0B/sZaAGTtsFr8Lt8XYhXNW6OdUAbrJZf6DkVmjCNl/AXw+
 9esg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1qsp3v6JLdFkpkDuPdqdTA04998UbyaxHTh9mj+8HL4=;
 b=yDISAwGYDemuA8Yc/S/dbGpOAv+nDc76f+KzOKU7iKWpU2EiRC/X0INmmH5mZnX7x2
 tnZ0zoPNwpsRpoQTlSPMcbyW6F4RDKMoNMTd1Y6vno63qvzrsIk11Y7LUTtOfohBRJtI
 45dKDU4EXee9TfN4BvoR5Omgpn8YSXyD6aN/N5RCg0zTKDDS+YTC4yNoQuGDH6xG/Msp
 r77gi+nb/TEA8w0kDhvUOua4q6MZAILAUiDHCMqzTI8Avs78ikn7T/H+o0jIXjLKW1GD
 PJzzCbmWvsHwH4jcAFaH/+JzkAEwRgfFGApPZDeUqqXE3lYFVYyQwhXObnl1SrOwmCxR
 XCHg==
X-Gm-Message-State: AOAM531GScKaksSp1cnpBzCY3kX+PRJgLBKF6MFkcG2SJNBBZHnUB2Nk
 Emq4Y9YS8/TH7JfV/XxXXS0=
X-Google-Smtp-Source: ABdhPJxyKknKiZyGftIej6kY1tR27U9WAkOOYQOKQ/xTPnnIdNIfZaj2vahF2PHsXIEw/MkG7jJxhA==
X-Received: by 2002:a17:902:c404:b0:15e:9aa2:3abc with SMTP id
 k4-20020a170902c40400b0015e9aa23abcmr21954792plk.172.1652212839365; 
 Tue, 10 May 2022 13:00:39 -0700 (PDT)
Received: from mail-ash-it-01.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id
 bh2-20020a170902a98200b0015e8d4eb2d2sm2422679plb.284.2022.05.10.13.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 13:00:38 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, James Smart <jsmart2021@gmail.com>,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH 3/4] lpfc: rework lpfc_vmid_get_appid() to be protocol
 independent
Date: Tue, 10 May 2022 13:00:27 -0700
Message-Id: <20220510200028.37399-4-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220510200028.37399-1-jsmart2021@gmail.com>
References: <20220510200028.37399-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_130043_883129_082DC6A4 
X-CRM114-Status: GOOD (  11.11  )
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

Rework lpfc_vmid_get_appid() arguments to remove scsi cmd dependency.
It's now callable by nvme path.

Fixup scsi calling path for arg change.

Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_crtn.h | 5 +++--
 drivers/scsi/lpfc/lpfc_scsi.c | 7 ++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 913844f01bf5..b1be0dd0337a 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -671,8 +671,9 @@ int lpfc_vmid_cmd(struct lpfc_vport *vport,
 int lpfc_vmid_hash_fn(const char *vmid, int len);
 struct lpfc_vmid *lpfc_get_vmid_from_hashtable(struct lpfc_vport *vport,
 					      uint32_t hash, uint8_t *buf);
-int lpfc_vmid_get_appid(struct lpfc_vport *vport, char *uuid, struct
-			       scsi_cmnd * cmd, union lpfc_vmid_io_tag *tag);
+int lpfc_vmid_get_appid(struct lpfc_vport *vport, char *uuid,
+			enum dma_data_direction iodir,
+			union lpfc_vmid_io_tag *tag);
 void lpfc_vmid_vport_cleanup(struct lpfc_vport *vport);
 int lpfc_issue_els_qfpa(struct lpfc_vport *vport);
 
diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 70d0a4d3d92e..f5f4409e24cd 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5446,9 +5446,10 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 		uuid = lpfc_is_command_vm_io(cmnd);
 
 		if (uuid) {
-			err = lpfc_vmid_get_appid(vport, uuid, cmnd,
-				(union lpfc_vmid_io_tag *)
-					&cur_iocbq->vmid_tag);
+			err = lpfc_vmid_get_appid(vport, uuid,
+					cmnd->sc_data_direction,
+					(union lpfc_vmid_io_tag *)
+						&cur_iocbq->vmid_tag);
 			if (!err)
 				cur_iocbq->cmd_flag |= LPFC_IO_VMID;
 		}
-- 
2.26.2


