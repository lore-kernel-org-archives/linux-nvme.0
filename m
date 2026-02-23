Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F7CC636B9
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 03:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o5apb2fNS5zR4mqQ2mGuBeE4hs0cbbtGBis6MQdZiwM=; b=AFTmBBgLvUMwT4N/r5syAzwoCT
	Eh2tuynF04uDxUTi9KeRbk6wvV7h6PkrNER4wEkLM0DWXf75wbRN9Z8XtJ1ONSUWzKwVnCS9wO0Dy
	fvaSK3fjLYUFW/esuocZUVR5Xo5O34xSocLzXDTDPdskkhE1WC70/u+j/QQvyDCVzUFblyStyUpwq
	4EMEnpY+rQQRNpUOvpeCRfEAEx1IiNG4QzbJ1tDy7XFTFpqmjDNttnjVvhl7Q06mauIppDog0PKV4
	etGlXQvGPgkOOABOy4V09l6vFSuxoklsjVnOq3jSKWshEZhfAScXnEWjFYAZECpNFeH54Ux4QBlb/
	DHCiLMWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuMxu-0000000HBe8-0fdf;
	Mon, 23 Feb 2026 03:50:34 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuMxp-0000000HBd1-2yy3
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 03:50:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771818629; x=1803354629;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+BB0YuNKO58wQ3TD+GTLoLScimyw7bZcwG7UqLXjpQQ=;
  b=VtPUBeJpTIw0Rm91q3B1DLSw2guHTNziNwOdq5xANV+hfdm9yAyFrV0p
   JnJJOMNl7l/r5lZJ0N3Tn9HnjZPnIsnMJfQ1MYwbFX07JHrlr4VkfyU8Z
   cMtbHArJoWrRcDW1N3p1qibwKGmxj2sImevrI3yNU6eXVtOuEKh+Y9WFd
   SBdd4dHq2NAinp3aFNiiCoMGrfqIcImV7PdnSaoZtnYC4lt0TvH+4wUo0
   BTgwH5fUGDac2WCBVHrdOhr+Ben5antZCBwwA1Ny5wicLEu9oq492oulJ
   TjdNDuVqbLyseGGZFsDnbVpW9LIMdDGPUw9+AhODOV3aXtwFdOywkLVPB
   A==;
X-CSE-ConnectionGUID: 0kMIK52dTyixrUfXeq3r6A==
X-CSE-MsgGUID: 4Icah63cT8CMQZbsrPUx6w==
X-IronPort-AV: E=Sophos;i="6.21,305,1763395200"; 
   d="scan'208";a="140288650"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep03.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 23 Feb 2026 11:50:27 +0800
IronPort-SDR: 699bce84_OcXnr1n/3Xvu+aSfowm6vQMZiFGS3/yQYa/FjcgdpUGeb8e
 L8aUBhor4G/BLMYepSZEHzssrcBGTQV4p9foIxQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep03.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Feb 2026 19:50:28 -0800
WDCIronportException: Internal
Received: from 5cg217417w.ad.shared (HELO shinmob.wdc.com) ([10.224.109.142])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Feb 2026 19:50:28 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 2/3] common/rc: introduce _load_module()
Date: Mon, 23 Feb 2026 12:50:22 +0900
Message-ID: <20260223035023.21902-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
References: <20260223035023.21902-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260222_195029_812321_37D112E5 
X-CRM114-Status: GOOD (  14.16  )
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

When a test case requires specific modules for testing, it loads and
uses the modules. To maintain a clean environment, it is desired that
the test case unloads after execution. The modules should be unloaded
only when the module was not loaded before the test case run. However,
writing logic to determine the module load status and unload accordingly
can be cumbersome.

To simplify and standardize such module unload control, introduce the
helper function _load_module(). It attempts to load the specified
module and records it to the global array MODULES_TO_UNLOAD only when
the module was not already loaded. Modules listed in MODULES_TO_UNLOAD
are unloaded by _unload_modules() after each test case run.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/rc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/common/rc b/common/rc
index abf66a4..0a8caca 100644
--- a/common/rc
+++ b/common/rc
@@ -69,6 +69,18 @@ _have_driver()
 	return 0
 }
 
+# Load the specified module. Record the module to MODULES_TO_UNLOAD so that they
+# will be unloaded by _unload_modules() after each test case run.
+_load_module() {
+	local modname="${1/-/_}"
+
+	if ! modprobe --quiet --first-time "${modname}"; then
+		return 1
+	fi
+
+	MODULES_TO_UNLOAD+=("${modname}")
+}
+
 # Check that the specified crypto algorithm is present, regardless of whether
 # it's built-in or as module.
 _have_crypto_algorithm()
-- 
2.53.0


