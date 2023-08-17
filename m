Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3688FC2FC14
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 07:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/RutsZnzULY+zk55WN6RT3Wp4xjPI+BbRfW6fowK0sE=; b=MV8mndsuKt/CDaZWydv0WHjQzM
	TGIBh1diXz7xnGNCYF+OaCPa2Yq7xOFazAuDcBJA5hp8i1pMjtlDiPh+e9QhpCfJ9frzH9SInWGqr
	DP105vImLeQEOoKL9uC6JZFaaMvkFQgvEqhSimQoSDBeRdJU2nu7MVjb52QB6aR/u9jMFZKxNltuv
	em6WpRtSe9tDUpW+yL2oG0gNQp/DskM4G7cqcoHQSmldA2RZ780Q2ngz0o2YNdDU5X7s1MzhgmKrk
	ZrBZITdfWeDHbeVCNwBg2dc7G8xXa/9KFi+4vSWLpP6BPz5LwgV/sVylrDeONurg/4Hbwvg2LG0eC
	/JpIiGOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWXSv-005ipZ-2Z;
	Thu, 17 Aug 2023 07:30:45 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWXSt-005ioo-08
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 07:30:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1692257442; x=1723793442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UUWnka0lvWrfZ4NWtFcx8XJGzhEQIbMjxWq1Vz1NalM=;
  b=JTtrp9y9nEPPkXUUoNyjN8vJsP13UAmyYPnkvQJI8H5DrevUppCZ6bto
   KznEjYUMl/9GJUP+TGUagOhdaR07olAt7v2Qk47A6coyjUo0fPVa+CFn7
   umR2DeGCjd/daHT7QeSMhUe3jJ4Qi5QH147eqOIdXNmqn8Hb1E7NkoifK
   hJJX3PY2CHL+pIb6yDFaZCfrv4nJDgixEsrNipbXDoVUVvC4E9JUQx4Ie
   I5cdq7ccpyRwygQazXhu2imi77d5tfn2R17sJu8u/Z22bUTelSN6xdj75
   2W2huo7FkDeJ6hg8DrAzj1jpLn5lfk4QuiwZxqZvkH+JOIVk/d/CSHI3m
   A==;
X-IronPort-AV: E=Sophos;i="6.01,179,1684771200"; 
   d="scan'208";a="241697901"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2023 15:30:26 +0800
IronPort-SDR: 061qbfDwcGSHTKb268OpPDaiWRRTRX92syTExwxs333jZ9yrItItM3mSg90UfYLwZSU3InjTNk
 xU4I1cqm5zaxjX4L+iwWongIYKs0HtjzYKM2W5IRbajFBqetSBk+jpQg+elWPVSPwotqNQHA+7
 Xx1yYniVeRXtH542Jm5MTA92awb4JoIO/hxHZDwwV+7UTywSm7xPMHSe3IbPpHwifkAGZB6M7a
 aLJfkseVHe2v36JE3j+AfLdqOZxYkwsSw/a97UWGlwDnsajjDIfvVL7+9mvkXXDQJPr4OZnPqA
 Tes=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Aug 2023 23:43:43 -0700
IronPort-SDR: 8LjGFSSJVg+jApn3yw0OMSkd9bVshYGe6Bu5zGrlSFZELSAdq8SilxFMx6AK0BPuVRVcZtnoJb
 unTVjMuZTsoP9EJlvwi3a5xGvZE7GO3Sf17VnNLzZkOF7h8f0n69pzY1OOuvmkTMzJNaPlVDn4
 +vPK5Fa19SC6KSDWrXYPsQwYjH/8Hp4OjnKKf3ub6ZTtByGPOjIxuLh3b6KLHxAkye+BEvRsVu
 PxPa4ax9BMlX+MMwwEAT4AKLfWKzam4vOB+uUR2M1hBR6C9hYgAzSFWnUe3KScvBgtEpFTQxSv
 gCo=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Aug 2023 00:30:23 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bvanassche@acm.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2 2/2] nvme: remove "udevadm settle" after _nvme_connect_subsys
Date: Thu, 17 Aug 2023 16:30:21 +0900
Message-Id: <20230817073021.3674602-2-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
References: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_003043_141425_FBDABB09 
X-CRM114-Status: GOOD (  12.86  )
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

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
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


