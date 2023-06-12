Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3AAC88CB4
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 15:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rnqTTuw5mu0gNFOEfyGW8AOsvekcrvot81MxID3HFPw=; b=hfIy+FJ45DKwipMy/5SaWdgUd3
	jE5OC6uEZkbm16G9yCn+0JlofApOslbcnXK1+K2WZ1KzB3iRQ0QfrhqpenAMjtVYP22MJ9lM5ekPB
	f6Jkc8uCBV7wGkwlyB7k8to9WrGgQgVEBDOeTYayxjMijV9YdV6ZJt5XzGtKgEGg4oa3AFX/hqtg/
	mZOCqis5WYNtjae+1DEokoWBj5+hi1NCUq/KfLXM1d4Lbv0Pphu5QNFGNMbvTtQdUCw/BnocIHUto
	tmE534m8fLHKjzFlBzJlsJVp1yrlYtSS7mqEtdt/vRV3VXD6cHw1Z/pHuDEogxUq58clk0jD/Pe3F
	+WD3doDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8jYf-004VnS-0B;
	Mon, 12 Jun 2023 15:34:17 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8jYb-004Vim-2m
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 15:34:15 +0000
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-3f7364c2ed8so11180855e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 12 Jun 2023 08:34:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686584049; x=1689176049;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rnqTTuw5mu0gNFOEfyGW8AOsvekcrvot81MxID3HFPw=;
        b=MTUavhdUNr6lPw17AH/F/Icn1PuPF9nsK2nXTZ82ex/EWz/DL2oGoLJOuUW5wnGOvR
         APr8hSBsbg4hZ5delv15j2W1H/TBgs7ZiEpvA09AvwI7JVqRexEUfZg3MGfK92JZ2xm5
         YHQtcY0u3iSuEIo47u5F/sAzpdmCdY4+Ho6vjurmUHHkE9XfQMdB56SrA/H3Jzvc748a
         9dfsuxZO/ldTJ4ipW8iMmy35o/TLZJZ+SiqHe6z7/5aWEjeIFZSy1W9mecgoDcwIt799
         rb8aAxiaoQ08MiMZcyXLg573m9qvncU3+za8HzB22pAbtR7oW9Xk07hd9ED/VSDp9prk
         lWJQ==
X-Gm-Message-State: AC+VfDxDnC7xT/eNpBKRPNE+ygsfoWPHvR7lK83n2GZEqcqNSLUUWAEX
	/AUzGmIi+ql5DZTc5HWquE1oEU7A8xM=
X-Google-Smtp-Source: ACHHUZ6kASvDK2eY2hhv/zR4aqzvcgSzuLvFvKKO4sAorH2Q1/cSuPv7TyOFItGNAubw0figQR/7pw==
X-Received: by 2002:a05:600c:3843:b0:3f7:1483:b229 with SMTP id s3-20020a05600c384300b003f71483b229mr7684139wmr.3.1686584048719;
        Mon, 12 Jun 2023 08:34:08 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id o40-20020a05600c512800b003f4283f5c1bsm13368877wms.2.2023.06.12.08.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 08:34:08 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH nvme-cli] nvme-print: fix wrong list-subsys output when ns are attached to different ctrls
Date: Mon, 12 Jun 2023 18:34:06 +0300
Message-Id: <20230612153406.663147-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_083413_900346_B87AD56E 
X-CRM114-Status: GOOD (  14.13  )
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

If we list subsystem controllers not for a specific ns (user did not pass
a namespace device node), we cannot look at the first ns in the subsystem
to list because it may not be attached to all subsystem controllers.

We incorrectly assumes that subsystem namespaces (or at least the first of
them) are attached to all subsystem controllers.

Fix that by showing the multipath subsystem-list flavor only when the user
passed a specific namespace, and fallback to a simple controller list otherwise.

Fixes: cdeaab8fca6e ("nvme-print: Show ANA state only for one namespace")
Fixes: 7435ed9ae6a6 ("nvme-print: Show paths from the first namespace only")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 nvme-print-json.c |  8 +++-----
 nvme-print.c      | 10 +++-------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/nvme-print-json.c b/nvme-print-json.c
index d9b19c96a8d6..e6f8e49e3497 100644
--- a/nvme-print-json.c
+++ b/nvme-print-json.c
@@ -1697,7 +1697,6 @@ void json_nvme_fdp_ruh_status(struct nvme_fdp_ruh_status *status, size_t len)
 }
 
 static unsigned int json_print_nvme_subsystem_multipath(nvme_subsystem_t s,
-							bool show_ana,
 						        json_object *paths)
 {
 	nvme_ns_t n;
@@ -1721,9 +1720,8 @@ static unsigned int json_print_nvme_subsystem_multipath(nvme_subsystem_t s,
 					     nvme_ctrl_get_address(c));
 		json_object_add_value_string(path_attrs, "State",
 					     nvme_ctrl_get_state(c));
-		if (show_ana)
-			json_object_add_value_string(path_attrs, "ANAState",
-						     nvme_path_get_ana_state(p));
+		json_object_add_value_string(path_attrs, "ANAState",
+					     nvme_path_get_ana_state(p));
 		json_array_add_value_object(paths, path_attrs);
 		i++;
 	}
@@ -1782,7 +1780,7 @@ void json_print_nvme_subsystem_list(nvme_root_t r, bool show_ana)
 			json_array_add_value_object(subsystems, subsystem_attrs);
 			paths = json_create_array();
 
-			if (!json_print_nvme_subsystem_multipath(s, show_ana, paths))
+			if (!show_ana || !json_print_nvme_subsystem_multipath(s, paths))
 				json_print_nvme_subsystem_ctrls(s, paths);
 
 			json_object_add_value_array(subsystem_attrs, "Paths",
diff --git a/nvme-print.c b/nvme-print.c
index 38fc8d02251f..0e5fe934bb7e 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1025,8 +1025,7 @@ void nvme_show_supported_cap_config_log(
 	}
 }
 
-static unsigned int nvme_show_subsystem_multipath(nvme_subsystem_t s,
-						  bool show_ana)
+static unsigned int nvme_show_subsystem_multipath(nvme_subsystem_t s)
 {
 	nvme_ns_t n;
 	nvme_path_t p;
@@ -1038,10 +1037,7 @@ static unsigned int nvme_show_subsystem_multipath(nvme_subsystem_t s,
 
 	nvme_namespace_for_each_path(n, p) {
 		nvme_ctrl_t c = nvme_path_get_ctrl(p);
-		const char *ana_state = "";
-
-		if (show_ana)
-			ana_state = nvme_path_get_ana_state(p);
+		const char *ana_state = nvme_path_get_ana_state(p);
 
 		printf(" +- %s %s %s %s %s\n",
 			nvme_ctrl_get_name(c),
@@ -1080,7 +1076,7 @@ static void nvme_show_subsystem(nvme_root_t r, bool show_ana)
 			       nvme_subsystem_get_nqn(s));
 			printf("\\\n");
 
-			if (!nvme_show_subsystem_multipath(s, show_ana))
+			if (!show_ana || !nvme_show_subsystem_multipath(s))
 				nvme_show_subsystem_ctrls(s);
 		}
 	}
-- 
2.40.1


