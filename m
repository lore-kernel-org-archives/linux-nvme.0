Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9942C77B6E
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Apr 2023 08:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U8Ct3r+MAAuYTQfED7hD0ME3xkyBJsbN9HYSC4zhmVM=; b=ICMIJlnlUZpKFlmiPGTvPtAEbW
	xihuqma+Xw4dUn2VJQVNTLaKRktgoBy3zTfxrbho6h2yDO+IjPsZFP2DMTJXUeEnRB41FLEueFlGa
	S8PROkOj6ra6jsNnn9P9PIYD4foFCNeFWPQtlkVbc/cSgYLoyNR1et+HWGmi10Ljvphb1K0hL6RRb
	RNGsdnNjgT3qgX2JnsTjnuZgVK2csuBf0mq72FHHlu+1yDOKgPXAsdsgZC2A8QByEX8qPQz6ElMlb
	9W2mgUga2GcEC8ZGf2wsrOv1Uy95iJPktIbtDs1ukz+N9kd8sVDOb8/HA6r/GkdV37XdXvgsdCTge
	NAVzUtSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkL1I-006l9e-2V;
	Thu, 06 Apr 2023 08:31:00 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkL1F-006l7y-0m
	for linux-nvme@lists.infradead.org;
	Thu, 06 Apr 2023 08:30:58 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4A28D1FF2A;
	Thu,  6 Apr 2023 08:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680769855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8Ct3r+MAAuYTQfED7hD0ME3xkyBJsbN9HYSC4zhmVM=;
	b=Uom9IRVRB3Sk0OSXDjODRQYVa5fLaLXTQKqTp6xiJTca3IePEAvfCt5vpKo6bcraqW74Vu
	EIyjT725+2GB+JS+pb3/udTXrcC9OYFS/39izTcOJok+CfjAMokbIq0gAq5RWeXPaq6cMo
	WN5w9+5Pfx5x9YIn1VJchZjcDw6Rfxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680769855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U8Ct3r+MAAuYTQfED7hD0ME3xkyBJsbN9HYSC4zhmVM=;
	b=Gr8Z+uw/SyxioFXFUWxB1XuImbuIKJUWd5SKlTn/X+BLWgpqYGWMAtc4LGG+08467RbrJZ
	Ezsc0W+ThUlxSLAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 39C2D133E5;
	Thu,  6 Apr 2023 08:30:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 7r79DT+DLmTRZAAAMHmgww
	(envelope-from <dwagner@suse.de>); Thu, 06 Apr 2023 08:30:55 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	James Smart <jsmart2021@gmail.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v6 1/2] nvme/rc: Add timeout argument parsing to _nvme_connect_subsys()
Date: Thu,  6 Apr 2023 10:30:49 +0200
Message-Id: <20230406083050.19246-2-dwagner@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406083050.19246-1-dwagner@suse.de>
References: <20230406083050.19246-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230406_013057_434218_AA5429E6 
X-CRM114-Status: UNSURE (   9.65  )
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

Add the possiblity for tests to specify the timeout values. This makes
it possible to reduce the test runtime.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index a3c9b42d91e6..b44239446dcf 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -338,6 +338,9 @@ _nvme_connect_subsys() {
 	local nr_io_queues=""
 	local nr_write_queues=""
 	local nr_poll_queues=""
+	local keep_alive_tmo=""
+	local reconnect_delay=""
+	local ctrl_loss_tmo=""
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
@@ -381,6 +384,18 @@ _nvme_connect_subsys() {
 				nr_poll_queues="$2"
 				shift 2
 				;;
+			-k|--keep-alive-tmo)
+				keep_alive_tmo="$2"
+				shift 2
+				;;
+			-c|--reconnect-delay)
+				reconnect_delay="$2"
+				shift 2
+				;;
+			-l|--ctrl-loss-tmo)
+				ctrl_loss_tmo="$2"
+				shift 2
+				;;
 			*)
 				positional_args+=("$1")
 				shift
@@ -420,6 +435,15 @@ _nvme_connect_subsys() {
 	if [[ -n "${nr_poll_queues}" ]]; then
 		ARGS+=(--nr-poll-queues="${nr_poll_queues}")
 	fi
+	if [[ -n "${keep_alive_tmo}" ]]; then
+		ARGS+=(--keep-alive-tmo="${keep_alive_tmo}")
+	fi
+	if [[ -n "${reconnect_delay}" ]]; then
+		ARGS+=(--reconnect-delay="${reconnect_delay}")
+	fi
+	if [[ -n "${ctrl_loss_tmo}" ]]; then
+		ARGS+=(--ctrl-loss-tmo="${ctrl_loss_tmo}")
+	fi
 
 	nvme connect "${ARGS[@]}" 2> /dev/null
 }
-- 
2.40.0


