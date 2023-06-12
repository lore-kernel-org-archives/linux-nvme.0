Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203DAC7EE2F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jun 2023 14:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ez66F1snArM9P0uDmhUnqyiFlGNOsdEpoDZ1RavyOTI=; b=XGXl+2YzaxBfci0Sswhi37MTMM
	oPTlccpZVJe/lZd2054QBnHseX4s+/ypyiQ2NCPiCijNRs3hUtJbVMUOqc/6RqYzxHI68MCBdoE2S
	ytz3T/6vA2pH1uVR04f4wa2PIy66q469MkUquLGcwXX8z57cFkNUtXTi4UTn3ukMZP9aBnsRfY0WW
	VDzib7AuM8UpSJ0r/58IuE8ugLY+Ov3zrPVxrhbGn+EN7EoYZ07bx8RriPSUrAxomIYz71o5FXrdT
	ylWvMSVmx44XrDjvOvK1ouQ6AUdy7jyThSbQfbtJwIUusWStJ3iMVuns79LxS52uQbv2qv21XIFZH
	J/mIUsrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q8iYo-004Irz-0z;
	Mon, 12 Jun 2023 14:30:22 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q8iYl-004Iqx-1H
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jun 2023 14:30:20 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 089F72030A;
	Mon, 12 Jun 2023 14:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1686580216; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ez66F1snArM9P0uDmhUnqyiFlGNOsdEpoDZ1RavyOTI=;
	b=uMCG4NIphRz5S9uoYRnrCKvCoLcECjXLKwv/y+2qRIDSRCUEZB/s3XnMysKHqh1rorDplR
	o6uoD5y4crk/iS3qWSpk0cohTfUEv5zH2L6lm+KHby8xOeA3LwnkK6QJFg2MAl6Z4RmZON
	gBo5wTc0XPDLbeO0n4SFCKd/6r71Dv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1686580216;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=ez66F1snArM9P0uDmhUnqyiFlGNOsdEpoDZ1RavyOTI=;
	b=JiMidvkXJ3mEhkDjsK2YlVtA/LX5S4jU+WNFUTcO6nJnPx0/wh8pvt9y4ZKBHQUU+dsZ7r
	N301rxdG4Tsiw9Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED40B1357F;
	Mon, 12 Jun 2023 14:30:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id p6GzOfcrh2RrIQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 12 Jun 2023 14:30:15 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1] nvme/040: Free loop back resources
Date: Mon, 12 Jun 2023 16:29:45 +0200
Message-Id: <20230612142945.10969-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230612_073019_589532_FAF5C1BC 
X-CRM114-Status: GOOD (  10.81  )
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

The tests does not cleanup all resources after it has finished. This
leads to rm not being able to remove the TMPDIR cleanly:

  + rm -rf blktests/results/tmpdir.nvme.040.m2J
  rm: cannot remove 'blktests/results/tmpdir.nvme.040.m2J': Directory not empty

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/040 | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/040 b/tests/nvme/040
index b6ab34d611ba..688a0939a376 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -18,6 +18,7 @@ requires() {
 
 test() {
 	local subsys="blktests-subsystem-1"
+	local file_path="${TMPDIR}/img"
 	local port
 	local loop_dev
 	local nvmedev
@@ -26,8 +27,8 @@ test() {
 	echo "Running ${TEST_NAME}"
 
 	_setup_nvmet
-	truncate -s "${nvme_img_size}" "$TMPDIR/img"
-	loop_dev="$(losetup -f --show "$TMPDIR/img")"
+	truncate -s "${nvme_img_size}" "${file_path}"
+	loop_dev="$(losetup -f --show "${file_path}")"
 
 	port="$(_create_nvmet_port "${nvme_trtype}")"
 	_create_nvmet_subsystem "${subsys}" "${loop_dev}"
@@ -57,5 +58,9 @@ test() {
 	_remove_nvmet_subsystem "${subsys}"
 	_remove_nvmet_port "${port}"
 
+	losetup -d "${loop_dev}"
+
+	rm -f "${file_path}"
+
 	echo "Test complete"
 }
-- 
2.40.1


