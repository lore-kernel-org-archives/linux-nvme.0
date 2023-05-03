Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54122C7EE22
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 08:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4bRFSw9rxVQLqGZBvGuslpAX0iVRdM7aaVOtxg8PZvc=; b=NWz1QMoCCfjWXfZeRLiw3QZPbV
	9ZRxgUrnMwPCCFFP/00uDhDHTWd5V2HMpI2q5UbygkZnayAtqnjcx4W31+AJV2McqiajoePtc3NlK
	J/gkH9kucCjCdz8YJT04KFPvQ7/OY1X157uYGlxDBZiCt6Hs4pIfdLrA9RehRLg6Vnq9wYNq8LK11
	KVzjyNao5IKKs/TyPBTFLvGBPLpvJro4y6xi9UWbRRbnBBs2ZhRwhyXg/LdJOvDHPUk1goZkzmSqD
	9bfRKQyY4J2u7RSgSRF/cbunCV36Sh9JzOgWylc6K2jQzedL4urbYcoJhN/T1TGVp0GaPY10wgBza
	Jt9AQHMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SF-003kBf-1x;
	Wed, 03 May 2023 08:03:15 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SC-003k8t-10
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 08:03:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5393D200AB;
	Wed,  3 May 2023 08:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683100990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bRFSw9rxVQLqGZBvGuslpAX0iVRdM7aaVOtxg8PZvc=;
	b=Ln27yFrqNCXB3yS7H42t6qvVNrubgyGezPoZuHu01peP63/liD61ZkJmTjRFp5/vZzwkHe
	1aF5717Zn6huFHYHIVC3kQh3oielcTiAwvYqT+z9TUMkGsuOgtiuPXzlpJfepGFD5/daAi
	zCwhSEoFgPWubVx7X5hDPgwPjlwI/P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683100990;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bRFSw9rxVQLqGZBvGuslpAX0iVRdM7aaVOtxg8PZvc=;
	b=0urN29/kP+PZyud7Sm9sj1ujYRc5hrDrTJMdcqntuI01TARrTwEcOWpLmh5tuuZqnmO4PO
	eavgtNg7qJdHfABQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 463FE1331F;
	Wed,  3 May 2023 08:03:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id ChkNET4VUmQtYgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:10 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 01/12] nvme/rc: Auto convert test device size info
Date: Wed,  3 May 2023 10:02:47 +0200
Message-Id: <20230503080258.14525-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503080258.14525-1-dwagner@suse.de>
References: <20230503080258.14525-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_010312_498069_5AD2C26D 
X-CRM114-Status: GOOD (  12.70  )
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

Introduce a convert_to_mb() helper which converts the size argument
to MBytes and use in test device require function. This makes it
possible to use user input strings in future.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/rc      | 30 +++++++++++++++++++++++++++---
 tests/nvme/035 |  2 +-
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index af4c0b1cab22..0b15d1fe4c6b 100644
--- a/common/rc
+++ b/common/rc
@@ -324,9 +324,12 @@ _get_pci_parent_from_blkdev() {
 		tail -2 | head -1
 }
 
-_require_test_dev_size_mb() {
-	local require_sz_mb=$1
-	local test_dev_sz_mb=$(($(blockdev --getsize64 "$TEST_DEV")/1024/1024))
+_require_test_dev_size() {
+	local require_sz_mb
+	local test_dev_sz_mb
+
+	require_sz_mb="$(convert_to_mb "$1")"
+	test_dev_sz_mb="$(($(blockdev --getsize64 "$TEST_DEV")/1024/1024))"
 
 	if (( "$test_dev_sz_mb" < "$require_sz_mb" )); then
 		SKIP_REASONS+=("${TEST_DEV} required at least ${require_sz_mb}m")
@@ -422,3 +425,24 @@ _have_writeable_kmsg() {
 _run_user() {
 	su "$NORMAL_USER" -c "$1"
 }
+
+convert_to_mb()
+{
+	local str=$1
+	local res
+
+	res=$(echo "${str}" | sed -n 's/^\([0-9]\+\)$/\1/p')
+	if [[ -n "${res}" ]]; then
+		echo "$((res / 1024 / 1024))"
+	fi
+
+	res=$(echo "${str}" | sed -n 's/^\([0-9]\+\)[mM]$/\1/p')
+	if [[ -n "${res}" ]]; then
+		echo "$((res))"
+	fi
+
+	res=$(echo "${str}" | sed -n 's/^\([0-9]\+\)[gG]$/\1/p')
+	if [[ -n "${res}" ]]; then
+        	echo "$((res * 1024))"
+	fi
+}
diff --git a/tests/nvme/035 b/tests/nvme/035
index d169e351e3d0..eb1024edddbf 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -17,7 +17,7 @@ requires() {
 }
 
 device_requires() {
-	_require_test_dev_size_mb 1024
+	_require_test_dev_size 1024m
 }
 
 test_device() {
-- 
2.40.0


