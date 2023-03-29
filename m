Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003F3C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 09:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jk3PG6dsDOaMBSt9to7fTwjCmC0NKhIOpn13Uj2Vb90=; b=VaXfOV3mphAIn+DHBoSdBgZwNP
	SZZ85YlHIgrySqlULzvwQbgdS5iIPO3rfxxgzZNxPSEsnLBD0GyAEvCxDQpsMX7E/h1VccSAk9/il
	OKpR5q9vOSqhfNg+folJKDwf6jmhFG/AtYpmdr13ze1L5DnxZ0HtskavH9uGv3TVVgRRxdmJ+ukEe
	DZGxVtfmkfPTc4C1FEqDJ/T6mbfBGMV4z3U/BeY6Eg0KcGh3C3M+YRLqsIBhJC0Jtwj6exKyvujno
	phn29LyWDsFcUA8vFtE2N9OSEIl9kgliuEDsFv6a1/zb7VhcNPibThEnZV+Wzn9Ta7t831XWSD8eY
	VVgttUhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phRh4-00HFEG-2U;
	Wed, 29 Mar 2023 09:02:10 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phRh1-00HFCO-2a
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 09:02:09 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A3511FDF3;
	Wed, 29 Mar 2023 09:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680080526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jk3PG6dsDOaMBSt9to7fTwjCmC0NKhIOpn13Uj2Vb90=;
	b=HCs1XiXy1XZft0Nw2Qd+IA/J+g31khMYoMuZPzQwqM/ioKZdF8BWvYCYZ/PLbggj5gL53v
	JDawbF7FHsr1wkKQL8tghoJrK8zO+6Goy7CkDqXahZbzS9eKdfyMFcV/jGCwjI0S1Ei3kh
	shvdtN+9bWB3elT5q7XbY56YthQt/30=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680080526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jk3PG6dsDOaMBSt9to7fTwjCmC0NKhIOpn13Uj2Vb90=;
	b=pSXi2vDw5NKtwrk5OPMUJbmGA+F3uBM1Jgq1ez3J6AgqBbCbMeticYqPuW1HT0FhA0JpO7
	NiNtg3QQL/QDJGDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DA2C138FF;
	Wed, 29 Mar 2023 09:02:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Aa7UEo7+I2RcdgAAMHmgww
	(envelope-from <dwagner@suse.de>); Wed, 29 Mar 2023 09:02:06 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 3/4] nvme/rc: Add parametric transport required check
Date: Wed, 29 Mar 2023 11:02:01 +0200
Message-Id: <20230329090202.8351-4-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230329090202.8351-1-dwagner@suse.de>
References: <20230329090202.8351-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_020207_989086_B9F32026 
X-CRM114-Status: GOOD (  12.92  )
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

Not all transport support the same features thus we need to be able to
express this. Add a transport require check which can be runtime
parameterized.

While at it also update the existing helpers to test for trtype to with
an explicit list of transport types.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index c1bb08be511a..a3c9b42d91e6 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -93,17 +93,26 @@ _require_test_dev_is_nvme() {
 	return 0
 }
 
+_require_nvme_trtype() {
+	local trtype
+	for trtype in "$@"; do
+		if [[ "${nvme_trtype}" == "$trtype" ]]; then
+			return 0
+		fi
+	done
+	SKIP_REASONS+=("nvme_trtype=${nvme_trtype} is not supported in this test")
+	return 1
+}
+
 _require_nvme_trtype_is_loop() {
-	if [[ "${nvme_trtype}" != "loop" ]]; then
-		SKIP_REASONS+=("nvme_trtype=${nvme_trtype} is not supported in this test")
+	if ! _require_nvme_trtype loop; then
 		return 1
 	fi
 	return 0
 }
 
 _require_nvme_trtype_is_fabrics() {
-	if [[ "${nvme_trtype}" == "pci" ]]; then
-		SKIP_REASONS+=("nvme_trtype=${nvme_trtype} is not supported in this test")
+	if ! _require_nvme_trtype loop fc rdma tcp; then
 		return 1
 	fi
 	return 0
-- 
2.40.0


