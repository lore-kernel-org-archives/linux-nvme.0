Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7807FC636D4
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Feb 2023 09:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UP5tUsWoK/v5FsyC6HlDI0FYrM4H9J/8a3sMHDiHg28=; b=igQ+ZeGFTV2W3S/XfnMQXkni48
	RFYcWsxjJwtNe+sa214AwMs02ZcnPWrqbNMJvKfKFIsFAROfEA6BWmbZfqz0Sb4sTrv0COvEjAmMg
	pGlRF0rlUO2RpPYLouIhBLpzD3pOqt7zwiQE7pwzs6ayfipTB4ifBdCJN/lYf1uFkjvQ+4jvmovyJ
	irnIsz1detC8rLP8WOSxXiYdpVQ9fw0ODNIDjGl58MOwoBSQwSE1OiamfzHC1+IBxFbyYSmEH8tjl
	aFDSH5dUqwJ3xyluwZU+L94yugL81Re8O6YmMKHWiXWFkPeT2j6VToIzaG4zpY0wANbmFqcnNVU5d
	Ma/UBEeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSDeO-005F57-Ku; Wed, 15 Feb 2023 09:00:28 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSDeL-005F4N-Mj
	for linux-nvme@lists.infradead.org; Wed, 15 Feb 2023 09:00:27 +0000
Received: by mail-wm1-f51.google.com with SMTP id k8-20020a05600c1c8800b003dc57ea0dfeso1001600wms.0
        for <linux-nvme@lists.infradead.org>; Wed, 15 Feb 2023 01:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676451623;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UP5tUsWoK/v5FsyC6HlDI0FYrM4H9J/8a3sMHDiHg28=;
        b=qrEGqi/0du3FsHMGPstpvmaE4ONR8EyymFZHJRzJoeKfgZyWMCbqTyw3ns86M85CPe
         rREXV7urm2BICFImZSIntYeRCUO45AKm0Rlaypxqqyv0/C1CfYVKF1M7GO+fZikxq9y2
         5hTWINpWOgwO5ugBllCUk7IB1PzNPj/L9f6+BSCp3+q0JaIu0k945UfSozq75O+Vnw06
         2tZMjVNEbPV9OkILb+69Js6WHrWmieidALe0QjJWTTgjpGaUVI4PrO954wbesEJDlQW7
         Bok0K+e+mO/Zs2KMn+yTMWn+DA9oWjRuGEaEq5e0vyCHY0ad8wgs5LELvHwrSeDRtgjV
         GMeQ==
X-Gm-Message-State: AO0yUKXomDO/kPoS8XEFmzSY8UeqmeNJSEZqjfBlhx9vZVi9QyIx9hqU
	wViMaluw52PR0wB00YkCFnAo3t4t7x8=
X-Google-Smtp-Source: AK7set8koSHir5jNrSl3KRGrwQYoEu9YuJndB6r82ywYpZBIzidbxkUCa+CyiQ1X5hvsaKx40nwZ6w==
X-Received: by 2002:a05:600c:1c9b:b0:3dc:5764:c164 with SMTP id k27-20020a05600c1c9b00b003dc5764c164mr1513635wms.4.1676451622880;
        Wed, 15 Feb 2023 01:00:22 -0800 (PST)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a7-20020a056000050700b002c3e3ee7d1asm15023645wrf.79.2023.02.15.01.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 01:00:22 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Martin Belanger <nitram_67@hotmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH] nvme-print: print the nvme generic name in json output as well
Date: Wed, 15 Feb 2023 11:00:20 +0200
Message-Id: <20230215090020.620994-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_010025_758942_522EEF55 
X-CRM114-Status: GOOD (  13.47  )
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

For both simple and detailed outputs present the nvme generic
chardev name/path similar to how the ns name/path is presented.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 nvme-print-json.c | 4 ++++
 nvme-print.c      | 2 +-
 nvme-print.h      | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/nvme-print-json.c b/nvme-print-json.c
index df5616e88119..489e9e15c3b5 100644
--- a/nvme-print-json.c
+++ b/nvme-print-json.c
@@ -2507,6 +2507,7 @@ static void json_detail_list(nvme_root_t r)
 					uint64_t nuse = nvme_ns_get_lba_util(n) * lba;
 
 					json_object_add_value_string(jns, "NameSpace", nvme_ns_get_name(n));
+					json_object_add_value_string(jns, "Generic", nvme_ns_get_generic_name(n));
 					json_object_add_value_int(jns, "NSID", nvme_ns_get_nsid(n));
 					json_object_add_value_uint64(jns, "UsedBytes", nuse);
 					json_object_add_value_uint64(jns, "MaximumLBA", nvme_ns_get_lba_count(n));
@@ -2565,15 +2566,18 @@ static struct json_object *json_list_item(nvme_ns_t n)
 {
 	struct json_object *jdevice = json_create_object();
 	char devname[128] = { 0 };
+	char genname[128] = { 0 };
 
 	int lba = nvme_ns_get_lba_size(n);
 	uint64_t nsze = nvme_ns_get_lba_count(n) * lba;
 	uint64_t nuse = nvme_ns_get_lba_util(n) * lba;
 
 	nvme_dev_full_path(n, devname, sizeof(devname));
+	nvme_generic_full_path(n, genname, sizeof(genname));
 
 	json_object_add_value_int(jdevice, "NameSpace", nvme_ns_get_nsid(n));
 	json_object_add_value_string(jdevice, "DevicePath", devname);
+	json_object_add_value_string(jdevice, "GenericPath", genname);
 	json_object_add_value_string(jdevice, "Firmware", nvme_ns_get_firmware(n));
 	json_object_add_value_string(jdevice, "ModelNumber", nvme_ns_get_model(n));
 	json_object_add_value_string(jdevice, "SerialNumber", nvme_ns_get_serial(n));
diff --git a/nvme-print.c b/nvme-print.c
index fee9aabfc176..ec98fe304c4b 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -5108,7 +5108,7 @@ void nvme_dev_full_path(nvme_ns_t n, char *path, size_t len)
 	snprintf(path, len, "%s", nvme_ns_get_name(n));
 }
 
-static void nvme_generic_full_path(nvme_ns_t n, char *path, size_t len)
+void nvme_generic_full_path(nvme_ns_t n, char *path, size_t len)
 {
 	int head_instance;
 	int instance;
diff --git a/nvme-print.h b/nvme-print.h
index ab11774daa28..7a4ceeea5131 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -149,6 +149,7 @@ const char *nvme_feature_to_string(enum nvme_features_id feature);
 const char *nvme_register_to_string(int reg);
 
 void nvme_dev_full_path(nvme_ns_t n, char *path, size_t len);
+void nvme_generic_full_path(nvme_ns_t n, char *path, size_t len);
 char *zone_type_to_string(__u8 cond);
 char *zone_state_to_string(__u8 state);
 const char *nvme_pel_event_to_string(int type);
-- 
2.34.1


