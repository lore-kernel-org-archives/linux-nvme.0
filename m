Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F35A0F513F9
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Mar 2026 04:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1cbn+3+HkIVRBEaPMO8A4x5yFyEMR2C7+8q12adE7jA=; b=mi5QRRmtA9if738D/FAILpBhjD
	oKHKJnuwJWxbjoRqkPDUXQUt+NnWoAkQehxj4Gu/hjM4jwX36WcxSaBgt8K3W3TpSVYCmdjzf05NR
	rOw9mEylRo66z3SctAcoZCOyPRH7xjOCfnI+Th1Ez5tv/JnYfZ+7TUBuVTzLY5Xh5VGNBmRDOVIjp
	uR6l6TfbalWc5d7oGxi8bnIYD4FH2twvT3Or40Jie8LdZmEWWoheBR598SVfi43kQ0r7pyr+F99T1
	nFzJG2G97GTQJvPb13DIQaxRFeq8Sd0kHg8isjLbSsfd09G9EWvIwBonTwPxe7t+mH9BamXZ9M1Mt
	pqvWJitg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyMdr-000000030I0-1p5w;
	Fri, 06 Mar 2026 04:18:23 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vyMdo-000000030Hc-3Cq0
	for linux-nvme@lists.infradead.org;
	Fri, 06 Mar 2026 04:18:21 +0000
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-82990763921so1163297b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 05 Mar 2026 20:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772770699; x=1773375499; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1cbn+3+HkIVRBEaPMO8A4x5yFyEMR2C7+8q12adE7jA=;
        b=O4nYEgaxsjxrxAety3CArNDdSPX905hosp48oQ4m419oS64fiM5siAWQHiHL7Lhy3O
         aVC4OT4xWZOxCqNUkRQZRA+rl7FHjrHHURlB4fsBbe2u984E1FFrFRtBJhFEuU2RWmlr
         Y8YAtHRv/RopM/cLl+XclR3Mo7Ep0JWb514MJ2sp4TUYH7YPrXE/rge/tiY35NmACmla
         R7QJ28DzUSIk/2VmeDWK/KIiRtZMi86w8K4xiGPk0xu7QWQSZYXJqjsNzuspeXdAKFZB
         HWnf4Ej7+xCamej9eVmEL92Tf07AfOUliDPe+tjA4HteV5+WfPSPUzUn3vHr1cJTQsdx
         IMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772770699; x=1773375499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cbn+3+HkIVRBEaPMO8A4x5yFyEMR2C7+8q12adE7jA=;
        b=rUiuh+mdLm2ID1Ix2HM36M6vkV2x4hqprVjP5CBOaEHmiB/h+8+gbVBK431IdF8fSh
         cs+O7Gci1xcwX/qi7Zu1EvVvuqsOMwI6R3nQ6az730tmYzzTdQ1f1llcM6uQNEaWlOcZ
         q0EDPglhoVZ3EhhLBiVKQI3NWFuD6iFsExQuHt+f3SIUHAygNTYTY9HZa21deGKqAQ9Z
         ekHV9mQ2YJjxoGfm4fp22pwKujv7cw7tPVpz/55Um/RfxPjDGdgMSkyRusMKrv0EDmTd
         +iU+HYQ/q9ZVhnnWcNoUTRgV5qeFa6bC2l8/jt9XZLzfuRvpCjihAevIGnXoJrz3LuyE
         sb3g==
X-Forwarded-Encrypted: i=1; AJvYcCV/Rub1X/Z4XWiErY4XsIHTPYV21OlFlbM8/+sGc/kyHR7EudffaSLgiHr2kn9TqkdHFSc4KbOjDZOe@lists.infradead.org
X-Gm-Message-State: AOJu0YzWMd0QP4WZlxDM4IG0JqFywbvzSFUXTsk8Ppnd/dNsxXU4DiBT
	5o/f+FzzufDnZdWya0IbjF8ewWHCXZQw/Vqyb/mlCAiaLyzkLfruMlof
X-Gm-Gg: ATEYQzyhZvLar05KMpU36+KZmg5FbLpIg9Za8nMT5fvU7luMfyzSxcqmqccxGYDpNg5
	mcxW9yoqanpZEbNGGZeoBWg3P35Kv25kyD1F6hO975KckoYfM3eKE6Xz2Md1tpsmUTNAWat7xcq
	D3LG7xO/KCSe6rna9ygdds4wB8B4tZwRjvTlU1Pz3EsgKW6IfGymsjUvO9gyWZoRyCVBPHHnkla
	DuTYp6OIiFtmu+yjfCHxIR3bQ0KzD4r0MwGkb1J1V1j8CbqWJxcXH+s38gdee1ZDk2aOgyJ/K9K
	qS5JN8Y8K1QLjGUSJNU9xZDuOsFa54SIf02xjt91A30XBzpp9nQ6lzjQY4gh2fU0Wfd3sNuoWAf
	0rONaqXBTta4KRX7mamk0FP1b0oJscn54nh14zQGEUilOpRwBCCz5vE/IPHn6zaKi3MYI3Sx2Vt
	5S3xYLr9zZmIze8eBUXzZz3uuL+Nn7wkBZll1TP+rA
X-Received: by 2002:a05:6a00:1c84:b0:827:343a:a1ef with SMTP id d2e1a72fcca58-829a30c2008mr730786b3a.52.1772770699391;
        Thu, 05 Mar 2026 20:18:19 -0800 (PST)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48a249bsm257357b3a.44.2026.03.05.20.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 20:18:18 -0800 (PST)
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
Subject: [PATCH] nvme-auth: Don't propose NVME_AUTH_DHGROUP_NULL with SC_C
Date: Fri,  6 Mar 2026 14:18:06 +1000
Message-ID: <20260306041806.2321074-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260305_201820_815161_EA9619C0 
X-CRM114-Status: GOOD (  10.88  )
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
 drivers/nvme/host/auth.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 405e7c03b1cf..40ef6f3fb970 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -125,6 +125,7 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
 {
 	struct nvmf_auth_dhchap_negotiate_data *data = chap->buf;
 	size_t size = sizeof(*data) + sizeof(union nvmf_auth_protocol);
+	u8 dh_list_offset = 30;
 
 	if (size > CHAP_BUF_SIZE) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
@@ -144,16 +145,17 @@ static int nvme_auth_set_dhchap_negotiate_data(struct nvme_ctrl *ctrl,
 	data->napd = 1;
 	data->auth_protocol[0].dhchap.authid = NVME_AUTH_DHCHAP_AUTH_ID;
 	data->auth_protocol[0].dhchap.halen = 3;
-	data->auth_protocol[0].dhchap.dhlen = 6;
 	data->auth_protocol[0].dhchap.idlist[0] = NVME_AUTH_HASH_SHA256;
 	data->auth_protocol[0].dhchap.idlist[1] = NVME_AUTH_HASH_SHA384;
 	data->auth_protocol[0].dhchap.idlist[2] = NVME_AUTH_HASH_SHA512;
-	data->auth_protocol[0].dhchap.idlist[30] = NVME_AUTH_DHGROUP_NULL;
-	data->auth_protocol[0].dhchap.idlist[31] = NVME_AUTH_DHGROUP_2048;
-	data->auth_protocol[0].dhchap.idlist[32] = NVME_AUTH_DHGROUP_3072;
-	data->auth_protocol[0].dhchap.idlist[33] = NVME_AUTH_DHGROUP_4096;
-	data->auth_protocol[0].dhchap.idlist[34] = NVME_AUTH_DHGROUP_6144;
-	data->auth_protocol[0].dhchap.idlist[35] = NVME_AUTH_DHGROUP_8192;
+	if (chap->sc_c == NVME_AUTH_SECP_NOSC)
+		data->auth_protocol[0].dhchap.idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_NULL;
+	data->auth_protocol[0].dhchap.idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_2048;
+	data->auth_protocol[0].dhchap.idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_3072;
+	data->auth_protocol[0].dhchap.idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_4096;
+	data->auth_protocol[0].dhchap.idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_6144;
+	data->auth_protocol[0].dhchap.idlist[dh_list_offset++] = NVME_AUTH_DHGROUP_8192;
+	data->auth_protocol[0].dhchap.dhlen = dh_list_offset - 30;
 
 	chap->sc_c = data->sc_c;
 
-- 
2.53.0


