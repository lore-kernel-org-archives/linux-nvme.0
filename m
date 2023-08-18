Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BACC71133
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Aug 2023 04:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ri4HV5lJvqLdJGCBFTB9NoMUMErF/dRhj6X9gdPDQZo=; b=XleT+PvDh4KuDJlOagdtOh2Wzt
	s+Pr4KQZ54LejtknAY87G7w1yoV+G4FNaGUsKPctoAZZ84ytXsSfH7FW1bUG/MNJ3cHQETNZ6q+bR
	d3XTY3GOD+oecTpXqSqEy81TVR9g4kqSU+obkw8T1xPgu4D0BGgPvLcwtO3MrDDZmT+7rrQ2rTkpl
	LLWD4yNR4SjBw0+AYDfsV5Bw5eRBk26p3IthyHK51T4NbenKZsoyPS+6oA36v8HBwVZKyGQsr345g
	dSCsmULF4GJx21GA/Df6J5IrAulNN2zI4JN9WJdswPHxCG2GPtEqxr25ygRFX0gJTccN/DQik3HEB
	JTLMTlOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWrIT-007gRk-25;
	Fri, 18 Aug 2023 04:41:17 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWrIQ-007gQF-2n
	for linux-nvme@lists.infradead.org;
	Fri, 18 Aug 2023 04:41:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692333674; x=1723869674;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LyNRwf8ssMynfsyFtHTj7f6WyJDWVTzXFNCD6YowvTE=;
  b=qMol9cmO3t28XMt5Cs5mbOi45Zi4w93FmpuLqgVRqsjam0JHdknXdpKq
   eVX1nIKFAz0LFZ54niu19gFrSc91CeUHNelMDuLPoLf57nnZ7ePBrVdvC
   2K+gHwaMpg0cJF9/nSTsS1Vq4mYmfpI+oiWNeVY5fd0CYyd0SeqsnT9Z7
   JSZzJpmSL1mg0gmfkOP3S++fFqi9V/AqReW4MQA8tBzlDkEmRqHEl7Vv2
   rkGmTVQaHfEe13sbUhYcUpM5C/RGu5q2yWVMmonRwKIVtWrR/rNoCuP9W
   mc8AZd+T6pSxaEwOd7zLPnEM9W1IABNqMWRcniljzRfuaMQugX/DIGbpt
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,182,1684771200"; 
   d="scan'208";a="241793468"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Aug 2023 12:41:00 +0800
IronPort-SDR: WP3SVh7hm6+HJAhf1vooATXi4+2B8S2Wf6OtCnyDL0a9NnaPV+yizeOOyJxk+MvL4Jts9eLTnV
 qpADSNFdvduVM9n2Tr6KiN/ko6pE9aLSP/OTLeI2ghWahGNM5w41jeQYq27sA7uoQaNZ6sRnX0
 XGMQEgNjvo+mwCoos4Rwd7bGv1tFghV/mYCHoAYU7qsM2hK+Kk4CWkMempGkn1da70m9iPTDKt
 /ozBT8jJO0dbUc9nZQ7EfKxqtRDKdIOIGlSaV/8GoecqIv2jRWGSHKWgKBfsKpMx9fVkZ9swHp
 mPY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 17 Aug 2023 20:48:36 -0700
IronPort-SDR: ctxTS/nXU+6yvVnIZOsyLhN+sMXQP9TPdxjTp6pRZjvraxfTgQZGoNgnF2MfHXQZ8fq5qt7NiO
 UE71mxIFB5Zpb92qKbPYOf5PuD6lm5M4PIQOj0rnYQNEHwJxK7e7/zsD5DS7HGY8jmZsUK25/J
 eg9XtRL2FZOAIofscuv/4+tvNYFrDOuTva3b565H5xvPgWQIlxueOEhwJqeBXewZ2ZNy6ozKTx
 ROOGKHJvlyGm3mQF+VdQBhSqOtCSzkYthO2EhrzvBXAOdE9TJ/OsiptK4Lj2J+TWdMtyuM4yyk
 l3Y=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 17 Aug 2023 21:40:59 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3 2/2] nvme: remove "udevadm settle" after _nvme_connect_subsys
Date: Fri, 18 Aug 2023 13:40:57 +0900
Message-Id: <20230818044057.3794564-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230818044057.3794564-1-shinichiro.kawasaki@wdc.com>
References: <20230818044057.3794564-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_214114_970477_38214948 
X-CRM114-Status: GOOD (  12.95  )
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

The previous commit introduced "udevadm settle" command at the end of
_nvme_connect_subsys. Then the command is no longer required after
calling _nvme_connect_subsys in test cases.

Reviewed-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v2:
* Added Reviewed-by tag

 tests/nvme/005 | 2 --
 tests/nvme/008 | 2 --
 tests/nvme/009 | 2 --
 tests/nvme/040 | 1 -
 tests/nvme/041 | 2 --
 tests/nvme/042 | 3 ---
 tests/nvme/043 | 4 ----
 tests/nvme/044 | 8 --------
 tests/nvme/045 | 2 --
 9 files changed, 26 deletions(-)

diff --git a/tests/nvme/005 b/tests/nvme/005
index 6646b82..4ca87ff 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -40,8 +40,6 @@ test() {
 
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 
-	udevadm settle
-
 	echo 1 > "/sys/class/nvme/${nvmedev}/reset_controller"
 
 	_nvme_disconnect_ctrl "${nvmedev}"
diff --git a/tests/nvme/008 b/tests/nvme/008
index 3921fc6..bd5e10f 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -40,8 +40,6 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	udevadm settle
-
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
diff --git a/tests/nvme/009 b/tests/nvme/009
index aac3c1e..c9a4b57 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -36,8 +36,6 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	udevadm settle
-
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
diff --git a/tests/nvme/040 b/tests/nvme/040
index 1a9be5c..ed6df3b 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -35,7 +35,6 @@ test() {
 	_create_nvmet_host "${def_subsysnqn}" "${def_hostnqn}"
 
 	_nvme_connect_subsys "${nvme_trtype}" "${def_subsysnqn}"
-	udevadm settle
 	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
 
 	# start fio job
diff --git a/tests/nvme/041 b/tests/nvme/041
index cb27666..bc84412 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -57,8 +57,6 @@ test() {
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}"
 
-	udevadm settle
-
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
diff --git a/tests/nvme/042 b/tests/nvme/042
index 9180fce..47e1b95 100755
--- a/tests/nvme/042
+++ b/tests/nvme/042
@@ -50,7 +50,6 @@ test() {
 				     --hostnqn "${def_hostnqn}" \
 				     --hostid "${def_hostid}" \
 				     --dhchap-secret "${hostkey}"
-		udevadm settle
 
 		_nvme_disconnect_subsys "${def_subsysnqn}"
 	done
@@ -69,8 +68,6 @@ test() {
 				     --hostid "${def_hostid}" \
 				     --dhchap-secret "${hostkey}"
 
-		udevadm settle
-
 		_nvme_disconnect_subsys "${def_subsysnqn}"
 	done
 
diff --git a/tests/nvme/043 b/tests/nvme/043
index f084229..15676f8 100755
--- a/tests/nvme/043
+++ b/tests/nvme/043
@@ -55,8 +55,6 @@ test() {
 				     --hostid "${def_hostid}" \
 				     --dhchap-secret "${hostkey}"
 
-		udevadm settle
-
 		_nvme_disconnect_subsys "${def_subsysnqn}"
 	done
 
@@ -71,8 +69,6 @@ test() {
 				      --hostid "${def_hostid}" \
 				      --dhchap-secret "${hostkey}"
 
-		udevadm settle
-
 		_nvme_disconnect_subsys "${def_subsysnqn}"
 	done
 
diff --git a/tests/nvme/044 b/tests/nvme/044
index 5eb163d..9407ac6 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -59,8 +59,6 @@ test() {
 			     --hostid "${def_hostid}" \
 			     --dhchap-secret "${hostkey}"
 
-	udevadm settle
-
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	# Step 2: Connect with host authentication
@@ -72,8 +70,6 @@ test() {
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${hostkey}"
 
-	udevadm settle
-
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	# Step 3: Connect with host authentication
@@ -85,8 +81,6 @@ test() {
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${ctrlkey}"
 
-	udevadm settle
-
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	# Step 4: Connect with host authentication
@@ -99,8 +93,6 @@ test() {
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${invkey}"
 
-	udevadm settle
-
 	_nvme_disconnect_subsys "${def_subsysnqn}"
 
 	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
diff --git a/tests/nvme/045 b/tests/nvme/045
index 8364d5e..396bcde 100755
--- a/tests/nvme/045
+++ b/tests/nvme/045
@@ -61,8 +61,6 @@ test() {
 			     --dhchap-secret "${hostkey}" \
 			     --dhchap-ctrl-secret "${ctrlkey}"
 
-	udevadm settle
-
 	echo "Re-authenticate with original host key"
 
 	ctrldev=$(_find_nvme_dev "${def_subsysnqn}")
-- 
2.40.1


