Return-Path: <SRS0=rRT3=GK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D95C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 04:55:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A5822D71
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jan 2021 04:55:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A5822D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1ZKxTMLlfyaZs9ufRmnQp//MTTe1R7qhIR3QkrqF4uA=; b=r3aOFU7YNiLNSzbfLAdgA0IAAW
	8qhF2lR0M92PzVkd8f1Ki6CG0/IEGwi2WA/J56P3GHGgQHlFfhlzPLirywO5faB2mpnN7d8fdTf7u
	duLwNvN5rGEogRm/uTpvmOeXS6Dn+CJyBIMXYntE4aD6fdQ7+usvZJydlCoEYZVzNn/4Q+kh/KrbB
	oU35nVIt8dr7r04R3q92/ftsxUTDL4om7PChS9PzS3zRDXqNWXWNhSDcUszhn9/Q93Pl+Zih+8uaH
	Yl85t/y3ZGfJDJc56svQAZgw7KjHsAfL9hmnOHiSdgv8+T+rkG2g81RrJ5wKbTLyniz26w12hBW3K
	/7TiLD9g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kxNKK-0008BZ-D8; Thu, 07 Jan 2021 04:55:12 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kxNKF-0008B1-IS
 for linux-nvme@merlin.infradead.org; Thu, 07 Jan 2021 04:55:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=mjRsuPFr48PBvb1myrgwVy0+xEgOwG1XJ157y2CJl5Q=; b=hh7CId3gkxWlnBcMlRKEX5+trZ
 ylDVVVS33tQcF1YGdIQfn9RHisPMsfaBTs4F4t0BJQnUFS0wfadRVWoQnVNHktyqN61TM4YR31Bog
 74JYnF+4SZx9nXlvZ3AK+FJQq5sxuH99i8QFqkkputTa8+KuuABqAVz7XNT5Qy9OzkPOurq+MDhbJ
 WsmbjJoTAuamwtyIVt5OsmTdz6GT/E4ZGwIHlnQwcbygHmewuGy3FLq9LaTUrNLdqh1q3nFLtzkQf
 g6aThn9jzMFPTkHpcsuBVrJJvgFJkUQ2yagttD7F++ZLamjM5PTIYKVF+O2I/s7tYs2msBbNuAP6q
 FT3lI3hw==;
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1kxNJZ-0032tV-Ab
 for linux-nvme@lists.infradead.org; Thu, 07 Jan 2021 04:54:28 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id F389D82D0D;
 Wed,  6 Jan 2021 20:53:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com F389D82D0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1609995203;
 bh=FxTtnlGadZn3It6ChcRUQ0tpCBNu7uDAvp7csH4bByk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KLtR4cILeN8hIDgGaXPBbcM+VZs5X0CCGZji2t0SfNJsXJRRKX36a3bDnoyD+0du5
 IzDBRm3Z5IVyEdXBjfpjUvidqVquRILwBVv2KPQsHnOEJmZVwuDQ1W2tGQsQcHwY9O
 AuXHvpPdLYDRCciyzlK/Wr0tmoUCwB8fx06lqCAU=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Subject: [PATCH v7 06/16] lpfc: vmid: Forward declarations for APIs
Date: Thu,  7 Jan 2021 03:30:20 +0530
Message-Id: <1609970430-19084-7-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1609970430-19084-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1609970430-19084-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210107_045428_184525_36C86218 
X-CRM114-Status: GOOD (  10.46  )
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
Cc: jsmart2021@gmail.com, mkumar@redhat.com, emilne@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch contains the forward declarations of commonly used APIs which
are used outside the scope of the file.

Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v7:
No change

v6:
No change

v5:
No change

v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
---
 drivers/scsi/lpfc/lpfc_crtn.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index f78e52a18b0b..7eb0200ecaa8 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -606,3 +606,14 @@ extern unsigned long lpfc_no_hba_reset[];
 extern union lpfc_wqe128 lpfc_iread_cmd_template;
 extern union lpfc_wqe128 lpfc_iwrite_cmd_template;
 extern union lpfc_wqe128 lpfc_icmnd_cmd_template;
+
+/* vmid interface */
+int lpfc_vmid_uvem(struct lpfc_vport *vport, struct lpfc_vmid *vmid, bool ins);
+uint32_t lpfc_vmid_get_cs_ctl(struct lpfc_vport *vport);
+int lpfc_vmid_cmd(struct lpfc_vport *vport,
+		  int cmdcode, struct lpfc_vmid *vmid);
+int lpfc_vmid_hash_fn(char *vmid, int len);
+struct lpfc_vmid *lpfc_get_vmid_from_hastable(struct lpfc_vport *vport,
+					      uint32_t hash, uint8_t *buf);
+void lpfc_vmid_vport_cleanup(struct lpfc_vport *vport);
+int lpfc_issue_els_qfpa(struct lpfc_vport *vport);
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
