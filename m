Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41CB1C7EE26
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wXg62EC96ajQDdHpd1YF2tGo6DqtEOKYIRcHTFG94OY=; b=PG+ccZEIIBLwle3x89sMwQgKcK
	gzDvOq5YAqKxQcejFeQqPU9dy3C58rEwBXQ/oLGijsA6RuLVM+KaOO/STt/XoL5cs4oKepGoIFMhE
	4n9vqNLQ14yHKxFh9B1BtMNZezXBIj2sIcudmJMBvpAcfDzRnOwNflDPMmnk2e1UBsyBq+1XB+nic
	xkH6ualcRNFFN8LqDiLk1+TiWcfrrIpK9XXQgrVhvaMTwy7ncc14XuEylHBRa6xwg8xNWid9PFFmB
	P/s/URhlV3BdaGOaSmtCqJpbQM7T4rLWXrDWqpHdE4mE8n6CE0UL+YsMwm//xLFW9T6rFAUxTKWr7
	Dug0xRjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px6zf-008ybF-0r;
	Thu, 11 May 2023 14:10:07 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px6zc-008yYv-1m
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 14:10:05 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BD9BE21D13;
	Thu, 11 May 2023 14:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1683814202; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXg62EC96ajQDdHpd1YF2tGo6DqtEOKYIRcHTFG94OY=;
	b=cMSL7Vm67GcoZAg0LdTOd732b0V5Drf1VRqpTeENJC4jAnIVOaFkYkJFIAPsqjE9ViJGCk
	SeuKhi5wzO2xQ4/zvvCb86YapD5N9CtIEpb9/FLF4H5uruDcmh03w0inW/881BLtbPuiOb
	yzWW7I+7a9e1OZxTpHkbz/vOpvkGTQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1683814202;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wXg62EC96ajQDdHpd1YF2tGo6DqtEOKYIRcHTFG94OY=;
	b=CzjJMIC6iAg1E/DwNiH3JJbvV3i/DKdswjiwf9ov8BYYh1JIBOR0W9bKfUkb3DXOqlLhW5
	ooNJNDPMiNK5hDDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68AFC134B2;
	Thu, 11 May 2023 14:10:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id WS7NEDr3XGRTPwAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 11 May 2023 14:10:02 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v4 02/11] nvme{014/015}: Do not hard code device size for dd test
Date: Thu, 11 May 2023 16:09:44 +0200
Message-Id: <20230511140953.17609-3-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230511140953.17609-1-dwagner@suse.de>
References: <20230511140953.17609-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_071004_732497_0E78ABC6 
X-CRM114-Status: GOOD (  10.07  )
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

Read the block device sizes instead hard coding them,
so that the device size can be configurable in future.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/014 | 10 +++++++++-
 tests/nvme/015 | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/014 b/tests/nvme/014
index d13cff7921da..875e99eea346 100755
--- a/tests/nvme/014
+++ b/tests/nvme/014
@@ -23,6 +23,9 @@ test() {
 	local port
 	local nvmedev
 	local loop_dev
+	local size
+	local bs
+	local count
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
@@ -41,7 +44,12 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	dd if=/dev/urandom of="/dev/${nvmedev}n1" count=128000 bs=4k status=none
+	size="$(blockdev --getsize64 "/dev/${nvmedev}n1")"
+	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
+	count=$((size / bs))
+
+	dd if=/dev/urandom of="/dev/${nvmedev}n1" \
+		count="${count}" bs="${bs}" status=none
 
 	nvme flush "/dev/${nvmedev}" -n 1
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index bb52ba2598db..8cb343e1d31c 100755
--- a/tests/nvme/015
+++ b/tests/nvme/015
@@ -22,6 +22,9 @@ test() {
 
 	local port
 	local nvmedev
+	local size
+	local bs
+	local count
 	local file_path="$TMPDIR/img"
 	local subsys_name="blktests-subsystem-1"
 
@@ -38,7 +41,12 @@ test() {
 	cat "/sys/block/${nvmedev}n1/uuid"
 	cat "/sys/block/${nvmedev}n1/wwid"
 
-	dd if=/dev/urandom of="/dev/${nvmedev}n1" count=128000 bs=4k status=none
+	size="$(blockdev --getsize64 "/dev/${nvmedev}n1")"
+	bs="$(blockdev --getbsz "/dev/${nvmedev}n1")"
+	count=$((size / bs))
+
+	dd if=/dev/urandom of="/dev/${nvmedev}n1" \
+		count="${count}" bs="${bs}" status=none
 
 	nvme flush "/dev/${nvmedev}n1" -n 1
 
-- 
2.40.0


