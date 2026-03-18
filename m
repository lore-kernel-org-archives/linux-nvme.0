Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB310FED9E9
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 00:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kAySL08WZH4li/cvsK0A8VcXPldu+e2SzbCzG56Tn7Y=; b=gdFXnXPc+fB4P3yhzSprg76NLC
	vmuJF0S1lzdIRl8oA0luDxBEFWK99FP7mgL0lbPxY8/lcbd2fv5wPQcPkRekG6XSW0l8B0FPKg0QO
	j/frpADwPLnc2IY6EYPBRsuqP8Jkdwiq/sRjKeC4trU5hgsuuD0Yo/18hGqVwY7bWhnvesG1yJ+b7
	5g+L2duyVbncWAlybaXa+5KXZAAYhBnTedtk5LvH7IGW7okt3pi42XL2K2UnVgnBN0wM+MfVrUEY3
	Zy8FA0t4si392NbIsjXjCU8rIR5MEFoIQD+nIgNl7ut13GevFaRp/Au3iiZ1P9dJVy3em4t4Grbvm
	VWOopsng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2f43-00000007WQO-00zv;
	Wed, 18 Mar 2026 00:47:11 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2f40-00000007WQ3-3SA3
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 00:47:09 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2ab46931cf1so3686445ad.0
        for <linux-nvme@lists.infradead.org>; Tue, 17 Mar 2026 17:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773794828; x=1774399628; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAySL08WZH4li/cvsK0A8VcXPldu+e2SzbCzG56Tn7Y=;
        b=WU2lmez1mmz4DpVfMdw2a5ZWn5pzZwNCcGDWWJSzrBmNG4tLTy35Chjnj3u6I4Cp/N
         2IoTJPr1KxAcjD1q9O1aXAw0OT30b2mpwXGAPYKW188pRXIdkhP+REegqjwdeyAvjF2M
         Yp+GIqT4Ahiqa4X2jFRR4vsg22ARxOxxrVxZ0NdnZedEdGIizUSgYIX13rHiHzbVttCs
         ulO6XgJSlOjIDGycy4qQbLoCkdImSnpdWDZS9Iwn61OxMAx77bZfHOxSg5GEE9uiQ+e4
         4EwOkcUWjMplu9ItAu5f3dVqvmUu7Uov3BgCIAMiRL0yK88wpVkzIIE7+OI+YrK6hu4+
         ZCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773794828; x=1774399628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kAySL08WZH4li/cvsK0A8VcXPldu+e2SzbCzG56Tn7Y=;
        b=Po/M/AJrkeC0ObUF9M6GeV+e5HbusUX9QOLgX1TxuDO/6g9mfg+B8xGfPTLwjM3gD+
         WpA1MM9mYPkqAGElGlgywZwr13Fd19dW8YB8iVDMf3rx8by78EociHmpexqUctRrn1j8
         On/jPZ3xHTkCEjL00VTTRKhIL4WFs6w7AMr71vAAMUM7CGRLh135flUFINw5IY2KklRC
         5OqnyKIml1hQpnwrzD5DfSzSFQl9eynZtJE+QNSqA7qxMe0f+dbFBLp2wjwPNTEw8iqZ
         hEPa3468neSFw/iji/L9whDDEYSNUDCScEdEUWJWwLhCDOCiXyeTM7VJRBGwY9HUaSxo
         gZ7g==
X-Forwarded-Encrypted: i=1; AJvYcCW3JqaqEgZRPk5QIidSA5PmIt+sEfWDzAf4Z5xQkKQl2lD4iab/9jx6B2pNOPRt0Ftzt1t/PQ4kIK9I@lists.infradead.org
X-Gm-Message-State: AOJu0YwMpIdp4wvn0UisNLud7pnMPmlW8NCLGQb0MdlDIDsUaX0+Dzbo
	UGayHwyvq5vbxocAHYE6UXC6iYrGQJseKNZsvk+vLfy9+cCzXtPpAFHlraiIAlAJ
X-Gm-Gg: ATEYQzzy8d8bAONKMqwRhgp0TO5u04YFu238XFGgOW/m6xa4/NziJmw+R34ct2cX3dI
	8GaXjxesG/1q7q7tpMSKpCJ21PiolPf4yZj6aRPSZNq17nts9/iqHrCOkM7AC+OUnDx3RTouZp3
	F/ZvNdmXdMFAOlM/VF2Ni5SQ6C6OE9FzUTrvIi7tKPohLaeWtx0J85rfJ0xtutboHKoNzZwgCGb
	SPaulQiRDck3Exk3qAcCMAWYMyr6/99xNLLWtGnnB4x21NHTubCz/Fb5lwvBLaqScO7JCEb+RTi
	4zZy0Xx8Nno//KRVXnFotiVJ9CZXKgZW+5HdzuRTzJet0Ia79acdex9Axr6Cb1xbBBteT5z9hjc
	lmMJmQh+zJ5kcH9bh7h+C160Tq3M0vZd+gSkxFlSWBzjyuui8U1CPjTFORVy/dDn5VZ+uw+ymjd
	mXNXqs+oEjxLbet5/zL7694lWaFg+E60aLHN2BnzYQBg==
X-Received: by 2002:a17:903:185:b0:2ae:5d90:9d95 with SMTP id d9443c01a7336-2b06e0fb884mr14506645ad.14.1773794827625;
        Tue, 17 Mar 2026 17:47:07 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e5ef3c6sm7406935ad.43.2026.03.17.17.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 17:47:07 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: hare@suse.de,
	kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>,
	Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Subject: [PATCH v3] nvme-auth: Don't propose NVME_AUTH_DHGROUP_NULL with SC_C
Date: Wed, 18 Mar 2026 10:46:58 +1000
Message-ID: <20260318004658.3681991-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_174708_872732_5435C380 
X-CRM114-Status: GOOD (  13.23  )
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

Section 8.3.4.5.2 of the NVMe 2.1 base spec states that

"""
The 00h identifier shall not be proposed in an AUTH_Negotiate message
that requests secure channel concatenation (i.e., with the SC_C field
set to a non-zero value).
"""

We need to ensure that we don't set the NVME_AUTH_DHGROUP_NULL idlist if
SC_C is set.

Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
v3:
 - Ensure chap->sc_c is set before the if statement
v2:
 - Use a macro for Diffie-Hellman Group Identifier List Offset
 - Use a pointer for data->auth_protocol[0].dhchap.idlist

 drivers/nvme/host/auth.c | 26 ++++++++++++++------------
 include/linux/nvme.h     |  2 ++
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 405e7c03b1cf..f9efed08997c 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -125,6 +125,8 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
 {
 	struct nvmf_auth_dhchap_negotiate_data *data = chap->buf;
 	size_t size = sizeof(*data) + sizeof(union nvmf_auth_protocol);
+	u8 dh_list_offset = DH_GID_LIST_OFFSET;
+	u8 *idlist = data->auth_protocol[0].dhchap.idlist;
 
 	if (size > CHAP_BUF_SIZE) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
@@ -141,21 +143,21 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
 			data->sc_c = NVME_AUTH_SECP_NEWTLSPSK;
 	} else
 		data->sc_c = NVME_AUTH_SECP_NOSC;
+	chap->sc_c = data->sc_c;
 	data->napd = 1;
 	data->auth_protocol[0].dhchap.authid = NVME_AUTH_DHCHAP_AUTH_ID;
 	data->auth_protocol[0].dhchap.halen = 3;
-	data->auth_protocol[0].dhchap.dhlen = 6;
-	data->auth_protocol[0].dhchap.idlist[0] = NVME_AUTH_HASH_SHA256;
-	data->auth_protocol[0].dhchap.idlist[1] = NVME_AUTH_HASH_SHA384;
-	data->auth_protocol[0].dhchap.idlist[2] = NVME_AUTH_HASH_SHA512;
-	data->auth_protocol[0].dhchap.idlist[30] = NVME_AUTH_DHGROUP_NULL;
-	data->auth_protocol[0].dhchap.idlist[31] = NVME_AUTH_DHGROUP_2048;
-	data->auth_protocol[0].dhchap.idlist[32] = NVME_AUTH_DHGROUP_3072;
-	data->auth_protocol[0].dhchap.idlist[33] = NVME_AUTH_DHGROUP_4096;
-	data->auth_protocol[0].dhchap.idlist[34] = NVME_AUTH_DHGROUP_6144;
-	data->auth_protocol[0].dhchap.idlist[35] = NVME_AUTH_DHGROUP_8192;
-
-	chap->sc_c = data->sc_c;
+	idlist[0] = NVME_AUTH_HASH_SHA256;
+	idlist[1] = NVME_AUTH_HASH_SHA384;
+	idlist[2] = NVME_AUTH_HASH_SHA512;
+	if (chap->sc_c == NVME_AUTH_SECP_NOSC)
+		idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_NULL;
+	idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_2048;
+	idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_3072;
+	idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_4096;
+	idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_6144;
+	idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_8192;
+	data->auth_protocol[0].dhchap.dhlen = dh_list_offset - DH_GID_LIST_OFFSET;
 
 	return size;
 }
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 655d194f8e72..bd540ef33b63 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -2332,4 +2332,6 @@ enum nvme_pr_change_ptpl {
 
 #define NVME_PR_IGNORE_KEY (1 << 3)
 
+#define DH_GID_LIST_OFFSET 30
+
 #endif /* _LINUX_NVME_H */
-- 
2.53.0


