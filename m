Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDDFCA0FE1
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Aug 2025 06:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jZaX1F5KmT0d2ChbhuC0S9nVyhZ49nZZckVP0Jy/ZVY=; b=pv4lyXr9jD9js+Gsd+vDDxJ70V
	PAheKijr5GHo3egLlsTahUuNIsmomBJtE8O2p+E7txmBIZPuZXNq2HKgT8WI4Cc443fmzWzkL1JDU
	WkeFzEPHlWgkm3oxMvK2r4FBj0iMemIILfHsD5oFZwfLZRpZvsQZ7nGiM32t4LsBFeE5GWrEEK7FG
	rMZ3ZK8OWWzsw91Wq6AbO4UIb1TVLEt+XoQWvI6KrrWimj9OkPwaYa7gDcyVsmKrg9+YX7SVnfaot
	C8BeZQ/uYKuv31tzHgFsa34Gmm4YD77xyvagTlDox2hlpCnZKd4OmgkkmPimfePNztW9bg0YvBIrR
	foiJYxbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uphu5-00000004ANJ-4BLT;
	Sat, 23 Aug 2025 06:39:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upTsq-000000035CW-35ba
	for linux-nvme@bombadil.infradead.org;
	Fri, 22 Aug 2025 15:40:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=content-type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=jZaX1F5KmT0d2ChbhuC0S9nVyhZ49nZZckVP0Jy/ZVY=; b=KLG7wO9g/mcV3sTKTrb6sWX1Hi
	rqXOS+T6gKfGXdh9Utoj2SaVXbCO5oQuEOEqN283NtpFqyfPKXP6vYCVf87FMDYlKWSe/V+qx6K4h
	xg8DrAqS1oCdIq4IUQGQTV60AzYlMW5CqbmFz+OyHEq3fZkOkZT+5xVLLeTAuU0jYu4hSr4CZo3DR
	Kuyp4tikefXijRbkbQcZHGvtQpizOqqpWnD/fuexQbtUlVa3vPfqb+hkYyVlmF8U5e0BVBpUn4bSq
	qafSKBBsB5l2aXB79SKMZpxlI+HaE3fI/By3dwR72PU/YNv/ZhH0eetdg9owaJCPA+a1jBDOZwjWT
	9Fh8DS3w==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upTsn-00000000zTj-2R51
	for linux-nvme@lists.infradead.org;
	Fri, 22 Aug 2025 15:40:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755877246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jZaX1F5KmT0d2ChbhuC0S9nVyhZ49nZZckVP0Jy/ZVY=;
	b=TgZvcXBKUvRLgep0GtptPIhcAT2cWvcXOwXjIFlPNpsJL6AaDjJfrE9qqZckwB7bbrVa+x
	wgFpmDlVb6E6NXHtewpcrHAnFKElzUzrdl6CEQGNj+nRd2aKwKAeDGN/THXVOd6b/E8PtN
	V0Mqh/wpINOS24hI4sPSzj1aPtarTbw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755877246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jZaX1F5KmT0d2ChbhuC0S9nVyhZ49nZZckVP0Jy/ZVY=;
	b=TgZvcXBKUvRLgep0GtptPIhcAT2cWvcXOwXjIFlPNpsJL6AaDjJfrE9qqZckwB7bbrVa+x
	wgFpmDlVb6E6NXHtewpcrHAnFKElzUzrdl6CEQGNj+nRd2aKwKAeDGN/THXVOd6b/E8PtN
	V0Mqh/wpINOS24hI4sPSzj1aPtarTbw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-MtkKw6JyNrSyhGrPD0eoLg-1; Fri,
 22 Aug 2025 11:40:38 -0400
X-MC-Unique: MtkKw6JyNrSyhGrPD0eoLg-1
X-Mimecast-MFC-AGG-ID: MtkKw6JyNrSyhGrPD0eoLg_1755877237
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78C631800359;
	Fri, 22 Aug 2025 15:40:37 +0000 (UTC)
Received: from vm-10-0-76-146.hosted.upshift.rdu2.redhat.com (vm-10-0-76-146.hosted.upshift.rdu2.redhat.com [10.0.76.146])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9FDC6180044F;
	Fri, 22 Aug 2025 15:40:36 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com,
	chaitanyak@nvidia.com,
	dwagner@suse.de
Subject: [PATCH blktests 2/2] nvme/{003,041,044,052,057,058,060,062}: update arg for _nvme_connect_subsys
Date: Fri, 22 Aug 2025 11:11:59 -0400
Message-ID: <20250822151159.3248900-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Tnq8VOzhqo4veuY-ivelwGiCMvYZwSaCOBFgU8Q2K1A_1755877237
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250822_164050_130098_DC1F975E 
X-CRM114-Status: GOOD (  13.70  )
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

The previous patch changed the default behavior of _nvme_connect_subsys
to wait for the namespace ready, but we have some cases that don't need
to wait for the controller or namespace ready, so add
--no-wait-ns/--no-wait for these cases

Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvme/003 | 2 +-
 tests/nvme/041 | 2 +-
 tests/nvme/044 | 4 ++--
 tests/nvme/052 | 2 +-
 tests/nvme/057 | 2 +-
 tests/nvme/058 | 2 +-
 tests/nvme/060 | 2 +-
 tests/nvme/062 | 2 +-
 8 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/nvme/003 b/tests/nvme/003
index 2222ad1..3d1415c 100755
--- a/tests/nvme/003
+++ b/tests/nvme/003
@@ -28,7 +28,7 @@ test() {
 
 	_nvmet_target_setup
 
-	_nvme_connect_subsys --port none \
+	_nvme_connect_subsys --port none --no-wait-ns \
 			     --subsysnqn "nqn.2014-08.org.nvmexpress.discovery"
 
 	# This is ugly but checking for the absence of error messages is ...
diff --git a/tests/nvme/041 b/tests/nvme/041
index 94f84f1..6855a47 100755
--- a/tests/nvme/041
+++ b/tests/nvme/041
@@ -41,7 +41,7 @@ test() {
 
 	# Test unauthenticated connection (should fail)
 	echo "Test unauthenticated connection (should fail)"
-	_nvme_connect_subsys
+	_nvme_connect_subsys --no-wait
 
 	_nvme_disconnect_subsys
 
diff --git a/tests/nvme/044 b/tests/nvme/044
index 7c08328..1352910 100755
--- a/tests/nvme/044
+++ b/tests/nvme/044
@@ -60,7 +60,7 @@ test() {
 	# and invalid ctrl authentication
 	echo "Test invalid ctrl authentication (should fail)"
 	_nvme_connect_subsys --dhchap-secret "${hostkey}" \
-			     --dhchap-ctrl-secret "${hostkey}"
+			     --dhchap-ctrl-secret "${hostkey}" --no-wait
 
 	_nvme_disconnect_subsys
 
@@ -77,7 +77,7 @@ test() {
 	echo "Test invalid ctrl key (should fail)"
 	invkey="DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVafdfaS7YQOMYhk9zSmlatobqB8C:"
 	_nvme_connect_subsys --dhchap-secret "${hostkey}" \
-			     --dhchap-ctrl-secret "${invkey}"
+			     --dhchap-ctrl-secret "${invkey}" --no-wait
 
 	_nvme_disconnect_subsys
 
diff --git a/tests/nvme/052 b/tests/nvme/052
index 22d8a9e..dd498b6 100755
--- a/tests/nvme/052
+++ b/tests/nvme/052
@@ -30,7 +30,7 @@ test() {
 
 	_nvmet_target_setup --blkdev none
 
-	_nvme_connect_subsys
+	_nvme_connect_subsys --no-wait-ns
 
 	for ((i = 1; i <= iterations; i++)); do
 		nsid=$((def_nsid + i - 1))
diff --git a/tests/nvme/057 b/tests/nvme/057
index 525193c..db011bc 100755
--- a/tests/nvme/057
+++ b/tests/nvme/057
@@ -65,7 +65,7 @@ test() {
 	failback "${ports[@]}"
 
 	for port in "${ports[@]}"; do
-		_nvme_connect_subsys --port "${port}"
+		_nvme_connect_subsys --port "${port}" --no-wait-ns
 	done
 
 	# start fio job
diff --git a/tests/nvme/058 b/tests/nvme/058
index c230045..997ff7f 100755
--- a/tests/nvme/058
+++ b/tests/nvme/058
@@ -81,7 +81,7 @@ test() {
 	_setup_ana "${ports[@]}"
 
 	for port in "${ports[@]}"; do
-		_nvme_connect_subsys --port "${port}"
+		_nvme_connect_subsys --port "${port}" --no-wait-ns
 	done
 
 	# Simulate unmap on one cluster node and remap to anther one
diff --git a/tests/nvme/060 b/tests/nvme/060
index 87315c0..997512d 100755
--- a/tests/nvme/060
+++ b/tests/nvme/060
@@ -51,7 +51,7 @@ test() {
 	# The target reset is triggered with an even number timeout, while the
 	# host reconnects with an odd number timeout.
 	for ((i = 0; i <= 5; i++)); do
-		_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 1
+		_nvme_connect_subsys --keep-alive-tmo 1 --reconnect-delay 1 --no-wait-ns
 		sleep 3
 		_nvme_disconnect_subsys >> "$FULL" 2>&1
 	done
diff --git a/tests/nvme/062 b/tests/nvme/062
index d7424ac..7c88719 100755
--- a/tests/nvme/062
+++ b/tests/nvme/062
@@ -72,7 +72,7 @@ test() {
 
 	# Test unencrypted connection
 	echo "Test unencrypted connection w/ tls required (should fail)"
-	_nvme_connect_subsys
+	_nvme_connect_subsys --no-wait
 
 	_nvme_disconnect_subsys
 
-- 
2.45.1


