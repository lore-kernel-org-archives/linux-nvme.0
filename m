Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 824FCC77B75
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Apr 2023 06:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9lIVFZmI6Kd5BjqNKBTjO2IfwGUAsCicokfMeR7skIo=; b=NYlux5v2LdqpZRkW0e90MRAQru
	Uwl1UD5SHWofPJuWuNdN7xeE1kfBAzhhMZPzt+9ItAqjjpLFS360RfMPEfx/6ZxqOFn0hne2wjxGm
	ywfXCwa82nSQvPUvHZe9jUvkauVhI3v7GmvXBOKkjrBp33E+Up6PMn2dzoqFjHSW7dC1SfjqngK/R
	oAqodNW79FkjPt0y45S/vjMNx4QJ+x+w131MJqm9IaH4s50SJWiYNxVEs2piSlNRP2Am6ejEUHyyE
	aiwSsjhWxd8qCshMoUqh2FDXSi4C7p11qJILWcE8luyW0rbTtHTLma5+6TcU9XpnSzwCFj8OuGoKg
	2/1CfpeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppjte-009kix-36;
	Fri, 21 Apr 2023 06:05:27 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppjtY-009kcc-2g
	for linux-nvme@lists.infradead.org;
	Fri, 21 Apr 2023 06:05:22 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 15D6021A46;
	Fri, 21 Apr 2023 06:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682057117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lIVFZmI6Kd5BjqNKBTjO2IfwGUAsCicokfMeR7skIo=;
	b=GEw6TKHoazlhD6fIfZGSNs5r3O+3MOd9mphNy516ylLPLONcYrxYz3YNkm63nd5uvjR7Wb
	ZTvT0IacChM06xccvg+/Aw/Qon+oJwhgRiq0yywrmCRONJAocqWG6emA8WUMO6U3RNYlq6
	M8LKXIUWL+K0Y+YHEdaof16GtVVQZkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682057117;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9lIVFZmI6Kd5BjqNKBTjO2IfwGUAsCicokfMeR7skIo=;
	b=7Rygyhert0Lviw6K0Vm49y/D7gG0WOqgrud4pzBkv+TULlnm/BGxLzv3dQYu4JS33hGlys
	1s0gAphw2aAZ6WBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09A0C1390E;
	Fri, 21 Apr 2023 06:05:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id JKFXAp0nQmRsZgAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 21 Apr 2023 06:05:17 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH REPOST blktests v2 2/9] nvme: Do not hard code device size for dd test
Date: Fri, 21 Apr 2023 08:04:58 +0200
Message-Id: <20230421060505.10132-3-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421060505.10132-1-dwagner@suse.de>
References: <20230421060505.10132-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_230521_024057_A2895F24 
X-CRM114-Status: UNSURE (   9.43  )
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

Read the block device sizes instead hard coding them.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/014 | 10 +++++++++-
 tests/nvme/015 | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/014 b/tests/nvme/014
index d13cff7921da..28913641ae40 100755
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
+	count=$((size / bs - 1))
+
+	dd if=/dev/urandom of="/dev/${nvmedev}n1" \
+		count="${count}" bs="${bs}" status=none
 
 	nvme flush "/dev/${nvmedev}" -n 1
 
diff --git a/tests/nvme/015 b/tests/nvme/015
index bb52ba2598db..2f7957caac88 100755
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
+	count=$((size / bs - 1))
+
+	dd if=/dev/urandom of="/dev/${nvmedev}n1" \
+		count="${count}" bs="${bs}" status=none
 
 	nvme flush "/dev/${nvmedev}n1" -n 1
 
-- 
2.40.0


