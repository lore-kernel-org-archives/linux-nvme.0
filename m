Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49ED0C77B7F
	for <linux-nvme@archiver.kernel.org>; Wed,  3 May 2023 08:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OHyLoSeY6bQ/dWfNCp2pJm0/BcIAe4YZOdyK2WISgIM=; b=2R+/gVT4/qYZXfZihsM4fpcRqg
	npzDwM6AbQJX4qPqgCwbQSdioBJwipNyzsRVbzfqdLWDRhEoRGClCVdE3JtX9dvIuceeoA/zYloJe
	Drsr8WhVQGCgFlTKUgHGAP9jF4lFs5agbYUgyhxVp5WtV2Wdm4jsTqc9goLjyUos3QuudwTXE8fX4
	hky6Y1+ubh8eowMUDKudmmHQER5Ad4C8KkP0siCCl6Pu181CCj6JJiHD/myMZsJRc3pXWyU/6K1/F
	qpyVldjS07U6PBMa3jigceUy8J59Ssum2MK/qs3xIVOljMZI0aMPbMCTFgTE2WdROcqmxXHxsnZF0
	x2o7uWbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SK-003kHK-2i;
	Wed, 03 May 2023 08:03:20 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pu7SD-003k99-0S
	for linux-nvme@lists.infradead.org;
	Wed, 03 May 2023 08:03:15 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A71921D04;
	Wed,  3 May 2023 08:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683100991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHyLoSeY6bQ/dWfNCp2pJm0/BcIAe4YZOdyK2WISgIM=;
	b=f3nOzPgqtMoGfGKUson9CJmdn1/wwMpH0YXr3JSHfjDI/HRASmNz349PqaRZTYuIwlQkUM
	HWm0xIVnr8CU+fduiQiLan9Rnoc9pbansSCRyZc/J02HeQGdxUc29eZtrLuhe43SiyHs89
	rsep41uspNt3NUT9LGl6+hc/Jd08cWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683100991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OHyLoSeY6bQ/dWfNCp2pJm0/BcIAe4YZOdyK2WISgIM=;
	b=G4aoxJpgAAjFOBndkq6a4W5bppQvIZWy0v1cVsnPyvP0G1TxIaziNOQ2sljJ5m+Ny0tiio
	K8REybhEj7KRziBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E0861331F;
	Wed,  3 May 2023 08:03:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id O7J2Hj8VUmQxYgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 03 May 2023 08:03:11 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 03/12] common/xfs: Make size argument optional for _xfs_run_fio_verify_io
Date: Wed,  3 May 2023 10:02:49 +0200
Message-Id: <20230503080258.14525-4-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230503080258.14525-1-dwagner@suse.de>
References: <20230503080258.14525-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230503_010313_322589_6A502C60 
X-CRM114-Status: GOOD (  12.35  )
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

Make the size argument optional by reading the filesystem info. The
caller doesn't have to guess (or calculate) how big the max IO size.
The log data structure of XFS is reducing the capacity.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/xfs     | 14 +++++++++++++-
 tests/nvme/012 |  2 +-
 tests/nvme/013 |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/common/xfs b/common/xfs
index 2c5d96164ac1..413c2820ffaf 100644
--- a/common/xfs
+++ b/common/xfs
@@ -24,10 +24,22 @@ _xfs_run_fio_verify_io() {
 	local mount_dir="/mnt/blktests"
 	local bdev=$1
 	local sz=$2
+	local sz_mb
+	local avail
+	local avail_mb
 
 	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
 
-	_run_fio_verify_io --size="$sz" --directory="${mount_dir}/"
+	avail="$(df --output=avail "${mount_dir}" | tail -1)"
+	avail_mb="$((avail / 1024))"
+
+	if [[ -z "${sz}" ]]; then
+		sz_mb="${avail_mb}"
+	else
+		sz_mb="$(convert_to_mb "${sz}")"
+	fi
+
+	_run_fio_verify_io --size="${sz_mb}m" --directory="${mount_dir}/"
 
 	umount "${mount_dir}" >> "${FULL}" 2>&1
 	rm -fr "${mount_dir}"
diff --git a/tests/nvme/012 b/tests/nvme/012
index e60082c2e751..c9d24388306d 100755
--- a/tests/nvme/012
+++ b/tests/nvme/012
@@ -44,7 +44,7 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
+	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
diff --git a/tests/nvme/013 b/tests/nvme/013
index 9d60a7df4577..265b6968fd34 100755
--- a/tests/nvme/013
+++ b/tests/nvme/013
@@ -41,7 +41,7 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	_xfs_run_fio_verify_io "/dev/${nvmedev}n1" "900m"
+	_xfs_run_fio_verify_io "/dev/${nvmedev}n1"
 
 	_nvme_disconnect_subsys "${subsys_name}"
 
-- 
2.40.0


