Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7223C77B76
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 12:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TKANE2bTfIsb9mX4f2a9ewBTW7h0uoTrVWYzSg0VVIE=; b=uv4HiSdQIbyWM82hSPjJ8RrB5b
	3mC1th6HoViPSKnz7VC5YJ29wKqH/rPBQWu6lpHkvGkxWzG0ZIsSKVbzlrJjgiTXOGCLL0+impRgI
	+M4uarkXbcPLwbNLYvISPRtKZy7Fn7R7/eQ1wquyZWAy+GQZow1z+LiQaps8QvzMO6hYhMj79gJ04
	WMWNpbz9RHiKhxnGZC+yfQb58cgx54jxk8QmOvLQx6zEh9FfFgkzCObnUrPTOv0LqVcjkWZExq5xF
	tQHLs8p6Q8oLbo64YlYNu1maNlhwR7fvK8wr5K6aYvfrESDjtOIcZQGcL6xwfSSds8Mc+KxK5U1zh
	Cvu1x8HA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pokWJ-0028na-1l;
	Tue, 18 Apr 2023 12:33:15 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pokWF-0028mB-36
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 12:33:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 899EE1FD65;
	Tue, 18 Apr 2023 12:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681821186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TKANE2bTfIsb9mX4f2a9ewBTW7h0uoTrVWYzSg0VVIE=;
	b=AaCaJCo36MWVmb5P4KbEspPvTBse5UObHptMB3rNppGTDR0aDEcmAWuOCrjkJkXkBW9uRM
	mWCf/u7WUzNTz/u1Fi7wV0jQvNYOfyzftIgfhsWsGA1IxTwmYH6grMyZs8r4AMk8QEqE2Z
	vxphRCzZvUAtEOz5MLpap436Uc6z6fM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681821186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=TKANE2bTfIsb9mX4f2a9ewBTW7h0uoTrVWYzSg0VVIE=;
	b=8SNKKT7SExK2ZZZ1METk30iTpWGh8sQdgOh6sVDpIZRILkMI3vNPgm0YPeP/zUGJQ5GixI
	NdvmvxpiC/YZzJBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 77ECA139CC;
	Tue, 18 Apr 2023 12:33:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id PTU9HQKOPmROFgAAMHmgww
	(envelope-from <dwagner@suse.de>); Tue, 18 Apr 2023 12:33:06 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests] nvme-rc: Cleanup fcloop resources in reverse order
Date: Tue, 18 Apr 2023 14:32:52 +0200
Message-Id: <20230418123252.3725-1-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_053312_159099_D11C5BAE 
X-CRM114-Status: GOOD (  11.09  )
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

We need to free the resources in the opposite order as we allocate them.
The deleting the rport first will also free the other resources. When
we try to release lport and tport they are already gone.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index b44239446dcf..ec0cc2d8d8cc 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -204,10 +204,10 @@ _cleanup_fcloop() {
 	local remote_wwnn="${3:-$def_remote_wwnn}"
 	local remote_wwpn="${4:-$def_remote_wwpn}"
 
-	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
-			       "${remote_wwnn}" "${remote_wwpn}"
 	_nvme_fcloop_del_tport "${remote_wwnn}" "${remote_wwpn}"
 	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
+	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
+			       "${remote_wwnn}" "${remote_wwpn}"
 }
 
 _cleanup_nvmet() {
-- 
2.40.0


