Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B456DEA8553
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2026 04:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TUR6e5Ssp3gFRl3Qw5xjvdZ0HUviL37ab7eciXMHhqY=; b=WtCzSkFvLCeTeR0f7IgJhOj/jV
	VborhAGwqlf52sXGezTc6Yc1rx1Zkz4Tax6XzsZaWhY/uxjdeQSr8TdpuUqvp/Op0mLag3YT5guoi
	kizhb/ewDrbDd8DaU72PzO7HpYX6RDDETc2e7mwvAVz6agWuWr7j0SJFbh7/DyuZIJGJadGiKWh/7
	wDOKfmDcoyqcmeTl0FceJdnrGno+Idcw8qzQ3b3la2tKHCh2VeunoyZ/Wx5S4fsQuOySspNcMi1tN
	G9u1hBJ80fD3fcoQ3/45oA1AEEPbGu+9mNrH/F1puVlUn6trsNir1TArwbCQA6we9srvqSjmV0tLk
	r4Y10Heg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzSDl-00000006eDB-1COu;
	Mon, 09 Mar 2026 04:27:57 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzSDf-00000006eCl-0mWw
	for linux-nvme@lists.infradead.org;
	Mon, 09 Mar 2026 04:27:52 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so124374755ad.2
        for <linux-nvme@lists.infradead.org>; Sun, 08 Mar 2026 21:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773030470; x=1773635270; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TUR6e5Ssp3gFRl3Qw5xjvdZ0HUviL37ab7eciXMHhqY=;
        b=fTkO1y2Vr6+XfzNItVJFfkkN21OWVivumLKJunkokUxFvpKKKT58e9IHlqLjjR9Zn4
         2wbaoQ5XCebBlcd5CPOeohEC705Xkkq1zm3WvfF/2mg+V8b0bTkR9AEMDqZPTOgctCR/
         J0QwtLAiqWtxKfVb92IU/RvbveDSlOmvj7ltS0uIuGfZHgDLC6+u9uDN3MvTPhBC0Zux
         qytQigZFlayt4WyRieq7ZDUTa6D8cKAC8+/GkXpqTlYcxyI+mPAgah/vz2xnf+K6kLfp
         E0RzizrCPWvrwMJClIcvWN0WuisCDoS2O2+2+5+NMn74iEjLhGzcwU0JWuiytZo4e4Io
         C/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773030470; x=1773635270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUR6e5Ssp3gFRl3Qw5xjvdZ0HUviL37ab7eciXMHhqY=;
        b=HNSZdsv/drgjkVJFiLvdtEtgyuCrvfZgFL7avuqDsYvqGrDTirQCSw0FChz+VbRJvo
         EXBDmhDVE31CXOBAwzJG7Ac5AigxE+BcfsjOVDMDgBk9uquoip8MGjjhbFJeA0kJj5js
         2UhM9TLT+pQo0bAOh1QOnh5Xq2edZmLOMRO7GzpSD2oBszFOCfe0C8e1Np84KhfGUf+c
         uiVt/3G934oKJJSiWqaQYBTwvebTNy6EKZKL634RSwkch8l9W/jQdH/G7ERSGbuK2mz9
         aPa2x2KJ9Lgu+0QRdBf3MZdcYi73bOEQDbR/BG7o4IjewtSKKdfhRCmkI4F/T8HBHf/3
         5Zdw==
X-Forwarded-Encrypted: i=1; AJvYcCWZRa85W/W3qyoXwgxT+bYvqgFokJwDohjkDViw4QAhc2t2nE6HGqLvlbWNL+K5tsmZ2iykctkN4ea7@lists.infradead.org
X-Gm-Message-State: AOJu0YwZ9RdP57mvtZyuMf6kcQ7HF7lTqOxlZuBq3ihEVMWVIkeU0Ip6
	sPNjxdPV7Eq/B18JgIOTR//C39RKuBYNURx7plFROE93WMBLzlLmpFqW
X-Gm-Gg: ATEYQzzrCDrKXv4/e4xKtKBp9Tb5Xo/E2x79NrCi2IJad7DfGBpY2dTYAS/ZsxkDK0e
	z0q+MNug7jWB6m2fvINjsR7o2IsRsr5xMECpL/oTdLgApxa10eMdwdJXEVb0hDKwxjuoI7/4Lmt
	b37gF5DFjEyB0VAzjQupVtMe3eyNDoVMZ7NKLEmPsnYbt1LJhghvM0ktH9ojC+zf57ErivmzZE8
	js/4+lB304h3Je2hHeKQVsUhnZdBPizNGJbSf2A1JN1H0m47LfWz4EcQo7iuYwzc9+wcavQ4wLl
	22NJZ3uH9pJUuVyzowWobt6bM7/bQcpX/C7h3hNf1P87Hh6qDd8Bv/RwTXF76cW9LhpuWXxx543
	5rF4L5TqJJw0OAsPb7S3R7aqq9uqJfgQwEroKzrosrszRyymNJvNjMMR4+hSL1pTIjvWhFUeNqo
	WU04Rb2WNka8ziDWzyKejkxa1b3DpXwd5DWuAYI2y4Dw==
X-Received: by 2002:a17:903:3904:b0:2ae:4aaf:3b04 with SMTP id d9443c01a7336-2ae82494790mr116959845ad.56.1773030469748;
        Sun, 08 Mar 2026 21:27:49 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e57afesm98517655ad.6.2026.03.08.21.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 21:27:49 -0700 (PDT)
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
Subject: [PATCH v2] nvme-auth: Don't propose NVME_AUTH_DHGROUP_NULL with SC_C
Date: Mon,  9 Mar 2026 14:27:33 +1000
Message-ID: <20260309042733.1137108-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260308_212751_248275_4928EC59 
X-CRM114-Status: GOOD (  12.80  )
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
---
v2:
 - Use a macro for Diffie-Hellman Group Identifier List Offset
 - Use a pointer for data->auth_protocol[0].dhchap.idlist

 drivers/nvme/host/auth.c | 23 +++++++++++++----------
 include/linux/nvme.h     |  2 ++
 2 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 405e7c03b1cf..4e8e4ddd6c8d 100644
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
@@ -144,16 +146,17 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
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
 
 	chap->sc_c = data->sc_c;
 
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


