Return-Path: <SRS0=+fzK=CF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B914EC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 19:50:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D75F207DF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2020 19:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0uSzxwP/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Xs4cqqnI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D75F207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OhWfn4g9MKMq07CyML7kZTgcwSPqtqjTBQGwbiNPuPY=; b=0uSzxwP/sveMlsCZkIMaE6ton
	VvcRikAFZYvDc3AbatXT+s6TGM4AwpKGBp9MYLKI/77hDuhXuhNfl3jPH9DjOVyJG7euu3Ow39JD1
	ODO2akg9mcG8kzGIaE4se/i9czmmO+3Unoi8NR6+76Zpw1PSO4DECfrdf9bVax0Em6nnw/sGH7OjF
	aoJGpncHQ69uWa6aQAjVNHpsc7zSS+DcDQizq0NtQsRzT1af2F5VkVAjsXuWVktRNw5ZhnVE6bb3M
	5i73U3Q6voz5ukqsGXhp+eFYeNEaBN/1J/Yu4qgmwBc/I16vFrqRnUKkhoeB5oHTOE412qvVivAxt
	woWvtoN6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBNuM-0006ZA-J1; Thu, 27 Aug 2020 19:50:02 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBNte-00067v-IP
 for linux-nvme@lists.infradead.org; Thu, 27 Aug 2020 19:49:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XImuR7L+3/WKl3KBtMcLmfV9ts5RH84zlT128RPd+rU=; b=Xs4cqqnIE59fD0G4CxKxNq7UNW
 EML9iJ1kV2crjguvRbTpfN0Bfp8HclSVN7uvK4+hpzrJw9gCgv8s/bSwcSzaPELKLE+OUcpcZgkWR
 5rgeOSc5KbIfqQG7t5YfzCvBglG9opePnOepi90rr8qwhmjV59VDiXWXpKbtV2PNIyI1yLA/KFbxc
 QW6XPw9V6fCjremy9fg2lBYOALpWNSRSRB0TSt5EyobKjzpdAjJzk8oVvwmJsdj7FCDH4/KIOQELk
 XikT7at+frWRFSLdSPhn7a+1k8Rvh39FHTrOBtNKZTeSzH9pUF440uBzDPSMcn2Q9jBdIz+FPdRdk
 SQzbxZ4A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kBNta-0000Cg-Tu; Thu, 27 Aug 2020 13:49:16 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kBNta-0001c2-2J; Thu, 27 Aug 2020 13:49:14 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Date: Thu, 27 Aug 2020 13:49:05 -0600
Message-Id: <20200827194912.6135-5-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827194912.6135-1-logang@deltatee.com>
References: <20200827194912.6135-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, osandov@osandov.com, sagi@grimberg.me,
 Chaitanya.Kulkarni@wdc.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH blktests 04/11] nvme: Search for specific subsysnqn in
 _find_nvme_loop_dev
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200827_154918_804917_200579B0 
X-CRM114-Status: GOOD (  11.78  )
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
Cc: Logan Gunthorpe <logang@deltatee.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This ensures we find the correct nvme loop device if others
exist on a given system (which is generally not expected on
test systems).

Additionally, this will be required in the upcomming test nvme/036
which will have controllers racing with ones being destroyed.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 tests/nvme/004 | 2 +-
 tests/nvme/005 | 2 +-
 tests/nvme/008 | 2 +-
 tests/nvme/009 | 2 +-
 tests/nvme/010 | 2 +-
 tests/nvme/011 | 2 +-
 tests/nvme/012 | 2 +-
 tests/nvme/013 | 2 +-
 tests/nvme/014 | 2 +-
 tests/nvme/015 | 2 +-
 tests/nvme/018 | 2 +-
 tests/nvme/019 | 2 +-
 tests/nvme/020 | 2 +-
 tests/nvme/021 | 2 +-
 tests/nvme/022 | 2 +-
 tests/nvme/023 | 2 +-
 tests/nvme/024 | 2 +-
 tests/nvme/025 | 2 +-
 tests/nvme/026 | 2 +-
 tests/nvme/027 | 2 +-
 tests/nvme/028 | 2 +-
 tests/nvme/029 | 2 +-
 tests/nvme/rc  | 7 ++++---
 23 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/tests/nvme/004 b/tests/nvme/004
index 0debcd9c7049..0bda90f60dd2 100755
--- a/tests/nvme/004
+++ b/tests/nvme/004
@@ -35,7 +35,7 @@ test() {
 	nvme connect -t loop -n blktests-subsystem-1
 
 	local nvmedev
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "blktests-subsystem-1")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/005 b/tests/nvme/005
index 8c79d234bb1d..82d920596439 100755
--- a/tests/nvme/005
+++ b/tests/nvme/005
@@ -36,7 +36,7 @@ test() {
 	nvme connect -t loop -n blktests-subsystem-1
 
 	local nvmedev
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "blktests-subsystem-1")
 
 	udevadm settle
 
diff --git a/tests/nvme/008 b/tests/nvme/008
index 71ff4d962b00..bd0e2f2e6d5b 100755
--- a/tests/nvme/008
+++ b/tests/nvme/008
@@ -36,7 +36,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/009 b/tests/nvme/009
index 25c7da2ab854..9d93888f5c91 100755
--- a/tests/nvme/009
+++ b/tests/nvme/009
@@ -32,7 +32,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/010 b/tests/nvme/010
index 25c79089e092..5a47b1f02b35 100755
--- a/tests/nvme/010
+++ b/tests/nvme/010
@@ -36,7 +36,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/011 b/tests/nvme/011
index ad360d095ffc..0b1465984dde 100755
--- a/tests/nvme/011
+++ b/tests/nvme/011
@@ -34,7 +34,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/012 b/tests/nvme/012
index 1dae795d17ac..fd0bfc491cfa 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -37,7 +37,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index c7b0f16ef504..bed00482f2f5 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -35,7 +35,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/014 b/tests/nvme/014
index c255d5f12205..96e1dc39407f 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -36,7 +36,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index a8497a2ba400..dc129b6aff36 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -32,7 +32,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/018 b/tests/nvme/018
index 67d89a6f0b24..9544f0ba0b73 100755
--- a/tests/nvme/018
+++ b/tests/nvme/018
@@ -34,7 +34,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/019 b/tests/nvme/019
index a8b0204ec0eb..92dc25fbbd8b 100755
--- a/tests/nvme/019
+++ b/tests/nvme/019
@@ -38,7 +38,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/020 b/tests/nvme/020
index b480ee1b92d0..eea19a11b4b3 100755
--- a/tests/nvme/020
+++ b/tests/nvme/020
@@ -34,7 +34,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/021 b/tests/nvme/021
index bbee54d16ff1..880ef3df6cdf 100755
--- a/tests/nvme/021
+++ b/tests/nvme/021
@@ -33,7 +33,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/022 b/tests/nvme/022
index 9ba07c1cc50f..c6ba18472afc 100755
--- a/tests/nvme/022
+++ b/tests/nvme/022
@@ -33,7 +33,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/023 b/tests/nvme/023
index ed2a5ad7653f..9161e81b95e9 100755
--- a/tests/nvme/023
+++ b/tests/nvme/023
@@ -36,7 +36,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/024 b/tests/nvme/024
index 538580947c5c..99588b000b30 100755
--- a/tests/nvme/024
+++ b/tests/nvme/024
@@ -33,7 +33,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/025 b/tests/nvme/025
index 0039fefa5007..d640e43ac350 100755
--- a/tests/nvme/025
+++ b/tests/nvme/025
@@ -33,7 +33,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/026 b/tests/nvme/026
index 7e89d840529c..10488952feb5 100755
--- a/tests/nvme/026
+++ b/tests/nvme/026
@@ -33,7 +33,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/027 b/tests/nvme/027
index 4d293beb8b47..47a1ec1c34c0 100755
--- a/tests/nvme/027
+++ b/tests/nvme/027
@@ -33,7 +33,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/028 b/tests/nvme/028
index 1280107ed5df..845b52759c6e 100755
--- a/tests/nvme/028
+++ b/tests/nvme/028
@@ -33,7 +33,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/029 b/tests/nvme/029
index 65eb40031888..b56c131016c5 100755
--- a/tests/nvme/029
+++ b/tests/nvme/029
@@ -69,7 +69,7 @@ test() {
 
 	nvme connect -t loop -n "${subsys_name}"
 
-	nvmedev="$(_find_nvme_loop_dev)"
+	nvmedev=$(_find_nvme_loop_dev "${subsys_name}")
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 6ffa971b4308..8865d543f4c1 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -162,12 +162,13 @@ _remove_nvmet_subsystem_from_port() {
 }
 
 _find_nvme_loop_dev() {
+	local subsys=$1
+	local subsysnqn
 	local dev
-	local transport
 	for dev in /sys/class/nvme/nvme*; do
 		dev="$(basename "$dev")"
-		transport="$(cat "/sys/class/nvme/${dev}/transport")"
-		if [[ "$transport" == "loop" ]]; then
+		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn")"
+		if [[ "$subsysnqn" == "$subsys" ]]; then
 			echo "$dev"
 			for ((i = 0; i < 10; i++)); do
 				if [[ -e /sys/block/$dev/uuid &&
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
