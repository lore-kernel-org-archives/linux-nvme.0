Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0B3C54E5D
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 09:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YI2CBx8BIa8CSsKBnOyhZ/dTKMZfvGnVLkV71KB7Krk=; b=MdNgNCkMvyEGQPXrmVRveiROLm
	ukrRa1ImKgcZUsWIZFrBIMZJYN//20KINIMFhf7VDtmeqw7O8morL3gVL3kGSP2keH8wDZ+XWW/LL
	6zjpU82cAnKKlVVIRfTdCMuSJDsmL4QQt4zYj9IeobeeBwXFNJbvMKBTRKHOoKIkNIkfbEzhzwfoh
	u/m6WjYmlRg9NFF2bDiRvlG4gN775L02S2QxWmzKQWr+c9Hgt/fGLnJuWTmGbeBlTTjaTwoKWhNmw
	y5HDOLapgF8fuNrWODUox4ChEmm8wzQttEAT8tDOp1CpUlBeDYmWI44sqC0LY0oyY/zEWWR1q5dAU
	6jj9vyCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm9Sa-00000007xH9-23bk;
	Mon, 18 Mar 2024 09:39:12 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rm9SW-00000007xDP-3lyK
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 09:39:10 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED0C25C336;
	Mon, 18 Mar 2024 09:39:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB2431349D;
	Mon, 18 Mar 2024 09:39:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oOoPNLgL+GWlUAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 18 Mar 2024 09:39:04 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [RFC blktests v1 01/10] common/xfs: propagate errors from _xfs_run_fio_verify_io
Date: Mon, 18 Mar 2024 10:38:46 +0100
Message-ID: <20240318093856.22307-2-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318093856.22307-1-dwagner@suse.de>
References: <20240318093856.22307-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Queue-Id: ED0C25C336
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_023909_184633_A9BCC780 
X-CRM114-Status: UNSURE (   9.74  )
X-CRM114-Notice: Please train this message.
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

If _xfs_mkfs_and_mount fails _xfs_run_fio_verify_io will continue to
execute and fio will run against the local file system instead against
the block device.

Propagate all errors back to the caller.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 common/xfs | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/common/xfs b/common/xfs
index 37ce85878df2..569770fecd53 100644
--- a/common/xfs
+++ b/common/xfs
@@ -16,7 +16,7 @@ _xfs_mkfs_and_mount() {
 
 	mkdir -p "${mount_dir}"
 	umount "${mount_dir}"
-	mkfs.xfs -l size=64m -f "${bdev}"
+	mkfs.xfs -l size=64m -f "${bdev}" || return $?
 	mount "${bdev}" "${mount_dir}"
 }
 
@@ -27,8 +27,10 @@ _xfs_run_fio_verify_io() {
 	local sz_mb
 	local avail
 	local avail_mb
+	local rc
 
-	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" >> "${FULL}" 2>&1
+	_xfs_mkfs_and_mount "${bdev}" "${mount_dir}" \
+		>>"${FULL}" 2>&1 || return $?
 
 	avail="$(df --output=avail "${mount_dir}" | tail -1)"
 	avail_mb="$((avail / 1024))"
@@ -43,7 +45,10 @@ _xfs_run_fio_verify_io() {
 	fi
 
 	_run_fio_verify_io --size="${sz_mb}m" --directory="${mount_dir}/"
+	rc=$?
 
 	umount "${mount_dir}" >> "${FULL}" 2>&1
 	rm -fr "${mount_dir}"
+
+	return "${rc}"
 }
-- 
2.44.0


