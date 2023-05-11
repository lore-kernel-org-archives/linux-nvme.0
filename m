Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AFB9C7EE2E
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 14:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MPFdoG7uuwmTENcS5c7mzPwTN+daQlG3WR9cD+OuVis=; b=gOhtVPDyOMUtx7KayToehnKnw4
	4tWvRjGGlmwJJRm/Ot/XhLpb3N79PeCAPTLkTgAV+hY2rHOseMuxIj89RqE7GK+vd00KLDcmbLTVU
	fL6k36FcDAHqwcslj09mUuYLLa5naw0eIMAO4+NWtqbNhXWiEtPe7v5BthJFTIdl3z7L94bHfkM+u
	QYi7p26qpCTF6+jF1sx6Ah5qy0IR92KFOHYPSGHwi2iQ/+RHz7GYkbhlWnwacNR/SQvEqI0dQ/wXa
	wUffglElpRCAyz+zwcz0bw3QXD68ugO5AXeryT13hkU8pDMuMrlz6DZhoFCwUzRSY0KOIgc2C0ZYL
	f/+BSsgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px6zh-008ycI-0I;
	Thu, 11 May 2023 14:10:09 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px6ze-008yaK-0t
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 14:10:07 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1630E1FF01;
	Thu, 11 May 2023 14:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683814205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPFdoG7uuwmTENcS5c7mzPwTN+daQlG3WR9cD+OuVis=;
	b=toY1DqJ8OXiUnTuxMprmlb768/WiFuR8Fgv5JorerOUXMJLXNygO2QJ4KRuvO5NFCd69xA
	3gxYFL4BjiB9gTiA5VMaibe6tVJLyVwLEq4bCIWfqoi++a/Q5rHkcMmTYOh3kDPca8IKr6
	gxK8K1zprtA7TFDW36FJkryuWbQaN/8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683814205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MPFdoG7uuwmTENcS5c7mzPwTN+daQlG3WR9cD+OuVis=;
	b=edArzHalbYJ0YCWUqXQHPzrXCYAjuGpVO8zS1Uat+b/rOjI1ekAWmiDJS2is5JWals7Ro1
	BpysYciPXR0ReeCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B9618134B2;
	Thu, 11 May 2023 14:10:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id MGSDJDz3XGRgPwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 11 May 2023 14:10:04 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 03/11] common/xfs: Make size argument optional for _xfs_run_fio_verify_io
Date: Thu, 11 May 2023 16:09:45 +0200
Message-Id: <20230511140953.17609-4-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511140953.17609-1-dwagner@suse.de>
References: <20230511140953.17609-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_071006_458765_387DE728 
X-CRM114-Status: GOOD (  12.12  )
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

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
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


