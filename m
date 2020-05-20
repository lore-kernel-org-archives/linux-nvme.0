Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EC6C433E2
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:00:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A742C207D3
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 19:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="avKsFmNm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2v677ZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A742C207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fJbjwohAc7BOUHZrDpvLdid3j9xl6MQv779rqbJQGn0=; b=avKsFmNmt4N6wY
	Q8aHJ6dzj/rIObMZjwZ9vuM8eLXOqVOvbDVoyv/Kq6o33z1fHEfJE++GyeAr71ZhT8nKvaHqtIvPK
	l1g6quZRdjnVQt+oqH66Sxm96LHgCLvi5r+hsZ/sn9q2my9he5tmBWEuAgP2pL5zxxgpVwC+19u03
	jLZp6ALFsfvR+RGDMoC/U+6PC9jrLqLgnl76x4+wIjJ32QqA77Iaepth+A4mhNfovM/nFKhaPOZzZ
	Acenp5cp2SwBIjqeFz4ZY3F77y6tG7ECNxpYqiAFtHjQoGgTbnXWKRpqRd2sHpLkFJ4/+2XSKaBPf
	AQ4iOeHFmCzzfx7JetTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbTwa-0001vp-1C; Wed, 20 May 2020 18:59:56 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbTwU-0001t9-I9
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 18:59:53 +0000
Received: by mail-wm1-x342.google.com with SMTP id n5so4028266wmd.0
 for <linux-nvme@lists.infradead.org>; Wed, 20 May 2020 11:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9XznIvAR7bDiKtKJMgdilzMAzpTq9fw9qWshfkg00WA=;
 b=c2v677ZGK91kZ/Rcz2CeDe5ceLjERgAeHQprZlhB0BGlLmR4PLd/n3GYuTqPhbMJPP
 Z0qsPv7x0IWzhf8ao1Qm8shIROhCgepiZddpNzgLS1L+UdyG/n2MzGP1QbzSo2/URPQJ
 ivR6LxZGihjHz+0KnW3JHHfsMJjkSCpdhIyabJ226RI44xgfLwFaf9IiAzTCxj1owS7e
 4d2pv5ISR+/LDGlm1JduhYzaQUFPmMe0OZ+NvuV3s+x3CgLqj4gYgchc2LZL19/WcxTa
 T/3xO8fUoemLciM+nBpeXJvvXZoGdaVVHhbj/WTPVXpvtmzG3cwEMlMfAXIR+p+vEMRo
 esnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9XznIvAR7bDiKtKJMgdilzMAzpTq9fw9qWshfkg00WA=;
 b=QIT1O6dvZ9GQAY1WLIp3JaIoVuqI93qwJ5wKzn0t24TyV9pyT5IqkKir8DBqmsOKdJ
 y9dckTf2tPSB7NJnhvDaFZMklTQRbeEoM9kQIsbSVomjwdRLS7TyFl8M/+K4ny8lyUiW
 W3mOVON7XwuUgYaIkvc49sXMpmloGH0RPIFRkq5J1EgNMgvB7K/7HlgKQIzLHTnub4/f
 4CUMyldxH/siP+zJihA6Podj085InjXEyjMG2R3wd5Umci86ca2mtiFjGygtZY77yDM8
 K9/cKnsYgB9Dz9CJ1+FaItD/VF/CfqVTS8t4EvNxEZ2yrwHDZfF8wfuoBHQPFv2olWdp
 bvrQ==
X-Gm-Message-State: AOAM533LQNuo0feRjZ25cq1M04Mj96v6bplEAg9ac1kd/eImDJ6WV3Dz
 aehCYW4LkJh3pcuq8U7iXaXdjqtx
X-Google-Smtp-Source: ABdhPJwu8XZia8JwprTLIrZXGEdQqEAyuKu+UEXw1dUK/7VHyuWf7pfCFsuhPSqbONiSVioPIWDyDw==
X-Received: by 2002:a1c:307:: with SMTP id 7mr5798016wmd.104.1590001188791;
 Wed, 20 May 2020 11:59:48 -0700 (PDT)
Received: from localhost.localdomain.localdomain (ip68-5-85-189.oc.oc.cox.net.
 [68.5.85.189])
 by smtp.gmail.com with ESMTPSA id c19sm3896483wrb.89.2020.05.20.11.59.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 20 May 2020 11:59:48 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] lpfc: fix axchg pointer reference after free and double
 frees
Date: Wed, 20 May 2020 11:59:28 -0700
Message-Id: <20200520185929.48779-3-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200520185929.48779-1-jsmart2021@gmail.com>
References: <20200520185929.48779-1-jsmart2021@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_115951_738764_E6E9811D 
X-CRM114-Status: GOOD (  14.52  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@kernel.dk, James Smart <jsmart2021@gmail.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, jejb@linux.ibm.com,
 kernel-janitors@vger.kernel.org, hch@infradead.org, paul.ely@broadcom.com,
 hare@suse.de, dan.carpenter@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The axchg structure is a structure allocated early in the
lpfc_nvme_unsol_ls_handler() to represent the newly received exchange.
Upon error, the out_fail path in the routine unconditionally frees the
pointer, yet subsequently passes the pointer to the abort routine.
Additionally, the abort routine, lpfc_nvme_unsol_ls_issue_abort(), also
has a failure path that will attempt to delete the pointer on error.

Fix these errors by:
- Removing the unconditional free so that it stays valid if passed
  to the abort routine.
- Revise the abort routine to not free the pointer. Instead, return
  a success/failure status. Note: if success, the later completion of
  the abort frees the structure.
- Back in the unsol_ls_handler() error path, if the abort routine was
  skipped (thus no possible reference) or the abort routine returned
  error, free the pointer.

Fixes: 3a8070c567aa ("lpfc: Refactor NVME LS receive handling")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Dick Kennedy <dick.kennedy@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_nvmet.c |  3 +--
 drivers/scsi/lpfc/lpfc_sli.c   | 10 ++++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index bccf9da302ee..32eb5e873e9b 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -3598,10 +3598,9 @@ lpfc_nvme_unsol_ls_issue_abort(struct lpfc_hba *phba,
 	abts_wqeq->context2 = NULL;
 	abts_wqeq->context3 = NULL;
 	lpfc_sli_release_iocbq(phba, abts_wqeq);
-	kfree(ctxp);
 	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_ABTS,
 			"6056 Failed to Issue ABTS. Status x%x\n", rc);
-	return 0;
+	return 1;
 }
 
 /**
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 1aaf40081e21..9e21c4f3b009 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2813,7 +2813,7 @@ lpfc_nvme_unsol_ls_handler(struct lpfc_hba *phba, struct lpfc_iocbq *piocb)
 	struct lpfc_async_xchg_ctx *axchg = NULL;
 	char *failwhy = NULL;
 	uint32_t oxid, sid, did, fctl, size;
-	int ret;
+	int ret = 1;
 
 	d_buf = piocb->context2;
 
@@ -2897,14 +2897,16 @@ lpfc_nvme_unsol_ls_handler(struct lpfc_hba *phba, struct lpfc_iocbq *piocb)
 			(phba->nvmet_support) ? "T" : "I", ret);
 
 out_fail:
-	kfree(axchg);
 
 	/* recycle receive buffer */
 	lpfc_in_buf_free(phba, &nvmebuf->dbuf);
 
 	/* If start of new exchange, abort it */
-	if (fctl & FC_FC_FIRST_SEQ && !(fctl & FC_FC_EX_CTX))
-		lpfc_nvme_unsol_ls_issue_abort(phba, axchg, sid, oxid);
+	if (axchg && (fctl & FC_FC_FIRST_SEQ && !(fctl & FC_FC_EX_CTX)))
+		ret = lpfc_nvme_unsol_ls_issue_abort(phba, axchg, sid, oxid);
+
+	if (ret)
+		kfree(axchg);
 }
 
 /**
-- 
2.26.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
