Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18ABEC77B7A
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 18:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LGJ8+x4oOv8BH7OP38itoB2VZdEGzcVipLnzQChvils=; b=u+BerGiEqABUuTQn+CtjLm/3np
	P6r0LuNMXo0IHzQNuFTz5H+A6gZCj9QFyeSl+vhlnQONxYfQCEEKE1OMVkXCWycdeFW012DM5TUyv
	C7jJDodyIk/lEGxTDEACC3APSsqZm4cijOgTJSyI1gPcO1B5W3TvTsuuK3HYJ8MAkgOu+2SGnIvUZ
	ZE2BByA+E5+vV2kezGTX8tuF3fcMy50W9csNUsNmy/WAt+PzEBA4DujeHBZoaMw32QnJze/CR9HQp
	2XyMtspwriLKC2RY2dd8RqTBAvLuKjyjTlVJXhZVD2Ndko7GY9/GCj8Chhx7i9o3LV/tOMoIlFKtH
	XqnmZgtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppZ4C-008jsJ-1Z;
	Thu, 20 Apr 2023 18:31:36 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppZ46-008jma-0Q
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 18:31:31 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B482F1FDCB;
	Thu, 20 Apr 2023 18:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1682015488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGJ8+x4oOv8BH7OP38itoB2VZdEGzcVipLnzQChvils=;
	b=l9N3KLMhHYSFD3EuUHevu9MXorcwyrBrWsVF1kw+2tZ4S2J3Lh/2IdQ+FvnDcE22UWXIXA
	jTN5PphopDbn+N9KE/8ljjs+j/rQPv9JsFLdGXm5q7Ia4UJwlWUGVGAlVDJRp2eZRiPNwD
	/s3jVjubpHLFYlBer8F3rDGWTaXQwt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1682015488;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LGJ8+x4oOv8BH7OP38itoB2VZdEGzcVipLnzQChvils=;
	b=OVcBqu8rfqHUFlbT+Ez7DCSA+YeVH3uJzhBPBXzg9IYEpPjYebiVKXStHqfdw6+oRivJfE
	c4drv3zwXdwHx3AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A5EE613584;
	Thu, 20 Apr 2023 18:31:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id HVkxKACFQWSxNAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 20 Apr 2023 18:31:28 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 4/9] nvme: Use runtime fio background jobs
Date: Thu, 20 Apr 2023 20:31:16 +0200
Message-Id: <20230420183121.4489-8-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230420183121.4489-1-dwagner@suse.de>
References: <20230420183121.4489-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230420_113130_326651_615832CB 
X-CRM114-Status: GOOD (  10.77  )
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

The fio jobs are supposed to run long in background during the test.
Instead relying on a job size use explicit runtime for this.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/032 | 2 +-
 tests/nvme/040 | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/032 b/tests/nvme/032
index 017d4a339971..81e074cc11bc 100755
--- a/tests/nvme/032
+++ b/tests/nvme/032
@@ -39,7 +39,7 @@ test_device() {
 
 	# start fio job
 	_run_fio_rand_io --filename="$TEST_DEV" --size=1g \
-		--group_reporting  &> /dev/null &
+		--group_reporting --time_based --runtime=1m &> /dev/null &
 
 	sleep 5
 
diff --git a/tests/nvme/040 b/tests/nvme/040
index 04bd726cd309..8d29f905adb5 100755
--- a/tests/nvme/040
+++ b/tests/nvme/040
@@ -38,7 +38,8 @@ test() {
 	# start fio job
 	echo "starting background fio"
 	_run_fio_rand_io --filename="/dev/${nvmedev}n1" --size=1g \
-		--group_reporting --ramp_time=5  &> /dev/null &
+		--group_reporting --ramp_time=5 \
+		--time_based --runtime=1m &> /dev/null &
 	sleep 5
 
 	# do reset/remove operation
-- 
2.40.0


