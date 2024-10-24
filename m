Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E06ED0BB4A
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Oct 2024 01:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zgPf6oTuo/kM1cyZtkswxgQgnS3mJRUyqYO4zblYiT8=; b=jB/yFJXI30GQ7Y+F+4LR49jPdk
	SLSgJG7dJ9kQLtVHnptDWV6SNMwXu1J3Jo7Se4QCvA+0OZlapYiLlleFQ+Z41csUoJHpznR2w8csm
	d1a8cD1BYMo2WABYWRfsmdlZpuupahuw2Nkd6YTt/9h9/6VQ11SMomMxOFY+K8ik4IvCMVUMUkTnK
	45DfLeVxzUfURNFSImXMMhj35l8G4X06JV9ViNAmxFbI0qiyJl5AklWEZZjQNEjZ+QJ+lcGvXAjlW
	E7K5rZ4tiFU8CoBWlxa24Je7AX6sfihpSDg/aervSdQ5IUIbyCZMQD+yZvooKNPzRfsi3yXQFhRgH
	Du8mIv+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDj-0000000GMuE-1hCt;
	Thu, 24 Oct 2024 01:00:59 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3mDO-0000000GMWc-3VQB
	for linux-nvme@lists.infradead.org;
	Thu, 24 Oct 2024 01:00:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729731638; x=1761267638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQBeTTDfwp/tC34qweIPvhsyQ68pBMmqDdNS18VO3DA=;
  b=HpZZs74V+p6HV0izD+sE0L56JB/WCv/DZatwJ2SzUHkSIgdMcv7GMRMX
   yA3OimS+ebhuw9IxFKW7MCZ7TQbak6ZuZoGYzonYE3A+29jw169lwpWet
   xAN1X64bKEGD0MYgK95gc7ydNHbosRCbJZ3KBGUCJACI9esV64FMFwSIN
   XjQBHl9LaO807oB5r2pQpfm5sQIkdrsOFBYPnr1pNBjEvPvFgUBb1Kufy
   +ywVBBsutL3UYpp+zJsKgZt/Yhojh/SHwmeX7g4RfFVI97HTc/d/bQSNt
   oa2BtXhr62lBVZQfoyA32U2iQxcjKmWsrl7ZdrC3jrsRXAAv1P44DPCuV
   Q==;
X-CSE-ConnectionGUID: 3nRmgPrJQNGCJluHCtcg2w==
X-CSE-MsgGUID: /E8Wbg2XT9euIbPRRFxaIQ==
X-IronPort-AV: E=Sophos;i="6.11,227,1725292800"; 
   d="scan'208";a="30211159"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Oct 2024 09:00:37 +0800
IronPort-SDR: 67198f1d_9wQHMxuNFOnIA6Uq5WNxJJqVH4JoKEzVZXzMgHXRL6taubd
 oABWfYxT6TE9ti6eK0/t3tQLH17BDqAKwkCGTWw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2024 17:04:45 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Oct 2024 18:00:37 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests 13/15] nvme: delete all namespaces in _remove_nvmet_subsystem()
Date: Thu, 24 Oct 2024 10:00:23 +0900
Message-ID: <20241024010025.2216242-14-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_180039_139548_B21C752F 
X-CRM114-Status: GOOD (  11.05  )
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

From: Hannes Reinecke <hare@suse.de>

A subsystem might have more than one namespace, so delete all of
them in _remove_nvmet_subsystem().

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/nvme    | 5 ++++-
 tests/nvme/016 | 4 ----
 tests/nvme/017 | 4 ----
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/common/nvme b/common/nvme
index dce3943..6cdff13 100644
--- a/common/nvme
+++ b/common/nvme
@@ -654,7 +654,10 @@ _remove_nvmet_subsystem() {
 	local nvmet_subsystem="$1"
 	local subsys_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
 
-	_remove_nvmet_ns "${nvmet_subsystem}" "1"
+	for n in "${subsys_path}/namespaces/"*; do
+		[ -d "${n}" ] || continue
+		_remove_nvmet_ns "${nvmet_subsystem}" "${n##*/}"
+	done
 	rm -f "${subsys_path}"/allowed_hosts/*
 	rmdir "${subsys_path}"
 }
diff --git a/tests/nvme/016 b/tests/nvme/016
index 13d2c46..4b01c0a 100755
--- a/tests/nvme/016
+++ b/tests/nvme/016
@@ -47,10 +47,6 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	for ((i = iterations; i > 1; i--)); do
-		_remove_nvmet_ns "${def_subsysnqn}" "$i"
-	done
-
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 
 	echo "Test complete"
diff --git a/tests/nvme/017 b/tests/nvme/017
index 10ee38c..8f57579 100755
--- a/tests/nvme/017
+++ b/tests/nvme/017
@@ -48,10 +48,6 @@ test() {
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
 	_remove_nvmet_port "${port}"
 
-	for ((i = iterations; i > 1; i--)); do
-		_remove_nvmet_ns "${def_subsysnqn}" "$i"
-	done
-
 	_remove_nvmet_subsystem "${def_subsysnqn}"
 
 	rm "$(_nvme_def_file_path)"
-- 
2.45.2


