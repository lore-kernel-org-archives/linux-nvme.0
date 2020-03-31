Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7367CC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:50:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE67206CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XjtKxkeR";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDqAIvGu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE67206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=2otEUII1uBGqJfZmqmgmlGU0ZM8cVulH2j8QLUvTFE4=; b=XjtKxkeRwZKZ+td+C1j710wVLn
	SjSZvhcd+JA2jab+zV6duDEAE85vcLg2qRBAT6U93jWzJyO+/7tYS8J+VNxYubcnCp5w+gCSGhR05
	0AtE5m0X7R+yOWjxhFJ0Ca80Wp7UdpPo1AlRHaLURsZ4lRYMecrfi650q8miM2cRHn/hrA4nWIB4D
	33CfDWLJJFScptvI/2e4g3ZrZ5CA+sFH4DOAyc0pBbtgmnKy7Jc1MckLtBhqLFg1GiI5BdwgAICd2
	vNnqmI0o7lpU43z8qMANsXcyB2Gsd/+F+UkQCsL/j8Zib/6Yfegh6RXOviudd7l1qW5CHN8sqaXS0
	1qghrkFQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJK5p-0004M8-IM; Tue, 31 Mar 2020 16:50:25 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK5m-0004K2-9p
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:50:23 +0000
Received: by mail-wr1-x443.google.com with SMTP id h15so26875459wrx.9
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uysuQqt0ANrC4ycHSmVl+QPSiIMVZNOg6U9Y17Y6KD8=;
 b=cDqAIvGuNpu1kZivoJxVZ278Wlme+fZzHLswOhuEQsL6vk1VYVVC02SkeF3dSUazCq
 MLNspkR5lBRUF0bK10LQnOz5HFPAbvb+iJutOt8F9sNsWL4SuNmGiS3EomGfxrzoJO05
 ruVPtH0NQB9yFuEd0r7SGobPuAw1XxRs7tXyyTSjtOGUg65iZF1pqczw6QKMeYxyJvI1
 94IgTsuibKkp83/kUCf1uOlVfpT6q+eWVLJ0D6kCRImLufPYbZ+JvbnnkPjb0S4xV8iw
 lzrf/fpuvZVOSROQ5ZjVuOSEAlqBQ+dozH42YUkJeK5ysjpRX97QIumXJMnx8h+5qxWV
 0OtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uysuQqt0ANrC4ycHSmVl+QPSiIMVZNOg6U9Y17Y6KD8=;
 b=Pb8eaqJ78VIhMHk5imo+FvLUUDGrfdBnox2DArzou4SipOqcPzP+MWeCzG/3ek+/SY
 aHddt9mufjrAz1XenJZXA7GFrc7ZUfnTcAc3riM/LJJSCCJtgZWg7W7nMckOF2YdoGtv
 PMqvmmpm1IHpq45WNkMEHEIfhs2VOkisA/isQqm3RgRdI31jMeIi6NfNYAUaUuQ3XFLS
 fGTdpgwercIvmURBn5GzYdPfdo2tALPYYVFHG6M2gYFxoBSuKJkasUMWDchL9iLQQvhK
 X9OkXQGTyhEFCvKXw8JPf6rwursRYODiRGlY4nVKbEaPm+30icMozmcqN7Oa4XymXW10
 Y5kg==
X-Gm-Message-State: ANhLgQ3cTRMnlxucAT55eBCNnnXui92ND4kMC+8j+p6uOMF6fay+T6bb
 RcobRYs+GDkrdk8wr/EqkxkDWyG2
X-Google-Smtp-Source: ADFU+vusePl5D8rudLx/rQTGy8DrusZLjYzuXcCXSJTZRJgkPh5+qM671JLq05xqGc9b+RKYIfdRCg==
X-Received: by 2002:adf:f852:: with SMTP id d18mr22730811wrq.172.1585673419893; 
 Tue, 31 Mar 2020 09:50:19 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.50.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:50:19 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 01/26] nvme-fc: Sync header to FC-NVME-2 rev 1.08
Date: Tue, 31 Mar 2020 09:49:46 -0700
Message-Id: <20200331165011.15819-2-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_095022_335367_9266883D 
X-CRM114-Status: GOOD (  13.53  )
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
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A couple of minor changes occurred between 1.06 and 1.08:
- Addition of NVME_SR_RSP opcode
- change of SR_RSP status code 1 to Reserved

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>

---
v2:
 Fix mistake spotted by Hannes for struct fcnvme_ls_disconnect_conn_rqst,
   connectid should be struct fcnvme_lsdesc_conn_id type.
---
 include/linux/nvme-fc.h | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/linux/nvme-fc.h b/include/linux/nvme-fc.h
index e8c30b39bb27..51fe44e0328b 100644
--- a/include/linux/nvme-fc.h
+++ b/include/linux/nvme-fc.h
@@ -4,8 +4,8 @@
  */
 
 /*
- * This file contains definitions relative to FC-NVME-2 r1.06
- * (T11-2019-00210-v001).
+ * This file contains definitions relative to FC-NVME-2 r1.08
+ * (T11-2019-00210-v004).
  */
 
 #ifndef _NVME_FC_H
@@ -81,7 +81,8 @@ struct nvme_fc_ersp_iu {
 };
 
 
-#define FCNVME_NVME_SR_OPCODE	0x01
+#define FCNVME_NVME_SR_OPCODE		0x01
+#define FCNVME_NVME_SR_RSP_OPCODE	0x02
 
 struct nvme_fc_nvme_sr_iu {
 	__u8			fc_id;
@@ -94,7 +95,7 @@ struct nvme_fc_nvme_sr_iu {
 
 enum {
 	FCNVME_SRSTAT_ACC		= 0x0,
-	FCNVME_SRSTAT_INV_FCID		= 0x1,
+	/* reserved			  0x1 */
 	/* reserved			  0x2 */
 	FCNVME_SRSTAT_LOGICAL_ERR	= 0x3,
 	FCNVME_SRSTAT_INV_QUALIF	= 0x4,
@@ -397,7 +398,7 @@ struct fcnvme_ls_disconnect_conn_rqst {
 	struct fcnvme_ls_rqst_w0		w0;
 	__be32					desc_list_len;
 	struct fcnvme_lsdesc_assoc_id		associd;
-	struct fcnvme_lsdesc_disconn_cmd	connectid;
+	struct fcnvme_lsdesc_conn_id		connectid;
 };
 
 struct fcnvme_ls_disconnect_conn_acc {
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
