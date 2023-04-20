Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38593C77B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 18:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Piq20gmCbu/sfasT+BJykUx1CpQBqc0w9RDrikSeIvU=; b=xdOVV+GqgCgn9fw38ymP/EAvNF
	oe0cPL/I9lWRcyzt83SGc94GP86yyc/rduLBMzXIYNIcPAUIO2CP7em/YiSdvtWyuF3RfhfL0CyTS
	QwChuyENw6jWf+Z/xDcbIC5rqT64VZ+qlPzm+gCFNmGVYktborsK++eYVCfJCvzA7oCJkcmFRLLZX
	f676A1L/zGLfXucJtS6CuRCIss6FxXp4lothuvf4xkVxSiFbUtTjNaGGivYU+5I0uloP3gumKYKB2
	F5x9ikw9sdrLkF97cE+9+7Q1v+bGNU1eknqSAUsrhVRnJfeF/ubNEsSp2UEmCCRc8daycws/dYew8
	BFLomYPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppZ4A-008jr3-1j;
	Thu, 20 Apr 2023 18:31:34 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppZ44-008jlD-0O
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 18:31:30 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E212B2197E;
	Thu, 20 Apr 2023 18:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682015486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Piq20gmCbu/sfasT+BJykUx1CpQBqc0w9RDrikSeIvU=;
	b=FqlAaB7VQf937XJ4IqGhpNSFSf9GkwmOUmwjwLXKVuyPN33waFQzqIb6giB1RLQNmAncYu
	FQ4+nhoKkYpk2yDVHCXhmOfPLW8bZ3gAudBZuyqQcK0EoiLBPbC2JMWeGE9eohNvotrwcF
	KtsnOtDjILUgDRZCxh87EhxNUwBfz0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682015486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Piq20gmCbu/sfasT+BJykUx1CpQBqc0w9RDrikSeIvU=;
	b=ajRf4HRB9pmqcBDtcDAwVAA2xALAvOT7YK/t98otENHzD1fch2kAnSyNLhlwfoQuA9s1SM
	Vl4npiaPmgIlK7Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3BAA13584;
	Thu, 20 Apr 2023 18:31:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 4ZacM/6EQWSrNAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 20 Apr 2023 18:31:26 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 3/9] common-xfs: Make size argument optional for _xfs_run_fio_verify_io
Date: Thu, 20 Apr 2023 20:31:13 +0200
Message-Id: <20230420183121.4489-5-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420183121.4489-1-dwagner@suse.de>
References: <20230420183121.4489-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_113128_303036_F923797E 
X-CRM114-Status: GOOD (  12.40  )
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
 common/xfs     | 6 ++++++
 tests/nvme/012 | 2 +-
 tests/nvme/013 | 2 +-
 tests/nvme/035 | 2 +-
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/common/xfs b/common/xfs
index 2c5d96164ac1..ec35599e017b 100644
--- a/common/xfs
+++ b/common/xfs
@@ -27,6 +27,12 @@ _xfs_run_fio_verify_io() {
 
 	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
 
+	if [[ -z "${sz}" ]]; then
+		local avail
+		avail="$(df --output=avail "${mount_dir}" | awk 'NR==2 {print $1}')"
+		sz="$(printf "%d" $((avail / 1024 - 1 )))m"
+	fi
+
 	_run_fio_verify_io --size="$sz" --directory="${mount_dir}/"
 
 	umount "${mount_dir}" >> "${FULL}" 2>&1
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
 
diff --git a/tests/nvme/035 b/tests/nvme/035
index eb1024edddbf..8b485bc8e682 100755
--- a/tests/nvme/035
+++ b/tests/nvme/035
@@ -32,7 +32,7 @@ test_device() {
 	port=$(_nvmet_passthru_target_setup "${subsys}")
 	nsdev=$(_nvmet_passthru_target_connect "${nvme_trtype}" "${subsys}")
 
-	_xfs_run_fio_verify_io "${nsdev}" "900m"
+	_xfs_run_fio_verify_io "${nsdev}"
 
 	_nvme_disconnect_subsys "${subsys}"
 	_nvmet_passthru_target_cleanup "${port}" "${subsys}"
-- 
2.40.0


