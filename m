Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD18606A320
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 09:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bDWXKadY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=n0+WD7MnmNpawjURDbchI2+bOPOVbb2oYCqZjNWipHg=; b=bDWXKadYAqFFHJ
	WvtSR6HIykAg9Q2GV3yYnOumG0L2PaFlB36TiPyHA+/e/00azmhP6XYSpOZ4TgoJwkHRM4cV8Tqia
	9pWt0N1tEXmyyiw+M9lwyJsTzkKZfARP0gJdqW0swo4W18tydupaHiyNWKN9jToP/wdpbSZJ8YGLW
	Ff0wCO1fGGPTRVp02YL0WmHubF/0at/rEq0yAy7PcNbUeUFO66Y14dV7AUJNh0EYv78swuMHKw+TL
	EjhKe8Sy83NUR8u4UT7NQHz5j+p1LcAADxIulhPyyEOQocOr9g/FrkEKKWR6Hv7OiVsTVlshu+EkT
	BodVjQ9q+2BkGSvgrwtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbwI-00000008Laj-0sv3;
	Wed, 18 Nov 2026 09:26:50 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbwE-00000008LZr-48vL
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 09:26:48 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE34C1F387;
	Wed, 18 Nov 2026 09:26:44 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B74B1334C;
	Wed, 18 Nov 2026 09:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6FyuFFRv/Wo8fgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 09:26:44 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 10:26:40 +0100
Subject: [PATCH blktests v2 2/9] contrib/nvme-target-control: pick a free
 service ID for new nvmet ports
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-nvme-target-control-v2-2-d191bbbf5dd6@suse.de>
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
In-Reply-To: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Queue-Id: BE34C1F387
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_012647_182414_CD5E2167 
X-CRM114-Status: GOOD (  12.07  )
X-Spam-Score: -4.2 (----)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The nvmet target derives the service ID from the port ID. On a target
that already has ports this clashes with existing ports, and nvme/003
connects to a service ID nothing listens on. Use the lowest free
service ID starting at trsvid instead.

Fixes: 79c32fb31b7b ("contrib: make nvme-target-control a standalone project")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 contrib/nvme-target-control/README.md                       | 13 +++++++------
 .../nvme_target_control/targets/nvmet.sh                    |  7 ++++++-
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/contrib/nvme-target-control/README.md b/contrib/nvme-target-control/README.md
index dc421b00b788..9abd7f30932d 100644
--- a/contrib/nvme-target-control/README.md
+++ b/contrib/nvme-target-control/README.md
@@ -61,12 +61,13 @@ is set, the namespace is a loop device on an image file in
 subsystem, the ports which don't export another subsystem, the hosts no
 other subsystem allows, and the loop device and image file.
 
-A new port gets the lowest free nvmet port ID N, starting at 1, and listens
-on `traddr` at service ID `trsvid` + N - 1. The first port of a target
-without other ports listens on `trsvid`. The nvmet target implements all
-port commands: `add-ports`, `add-port`, `remove-port`, `list-ports`,
-`show-port` and `set-ana`, and `set-host`, which changes the DH-CHAP keys,
-hash and DH group of the host.
+A new port gets the lowest free nvmet port ID, starting at 1, and the
+lowest service ID from `trsvid` up which no other port uses: the first
+port listens on `traddr` at `trsvid` unless another port of the target
+does. The nvmet target implements all port commands: `add-ports`,
+`add-port`, `remove-port`, `list-ports`, `show-port` and `set-ana`, and
+`set-host`, which changes the DH-CHAP keys, hash and DH group of the
+host.
 
 | Option | Meaning |
 | --- | --- |
diff --git a/contrib/nvme-target-control/nvme_target_control/targets/nvmet.sh b/contrib/nvme-target-control/nvme_target_control/targets/nvmet.sh
index 33f383eb17f0..7d6e9cd40da0 100644
--- a/contrib/nvme-target-control/nvme_target_control/targets/nvmet.sh
+++ b/contrib/nvme-target-control/nvme_target_control/targets/nvmet.sh
@@ -59,6 +59,11 @@ add_port() {
 	while [ -e "${cfs}/ports/${port}" ]; do
 		port=$((port + 1))
 	done
+	# The target may have other ports, take the first free service ID.
+	while cat "${cfs}"/ports/*/addr_trsvcid 2> /dev/null |
+			grep -qx "${trsvcid}"; do
+		trsvcid=$((trsvcid + 1))
+	done
 	case "${traddr}" in
 	*:*)	adrfam=ipv6 ;;
 	*)	adrfam=ipv4 ;;
@@ -68,7 +73,7 @@ add_port() {
 	echo "${trtype}" > "${cfs}/ports/${port}/addr_trtype"
 	echo "${adrfam}" > "${cfs}/ports/${port}/addr_adrfam"
 	echo "${traddr}" > "${cfs}/ports/${port}/addr_traddr"
-	echo $((trsvcid + port - 1)) > "${cfs}/ports/${port}/addr_trsvcid"
+	echo "${trsvcid}" > "${cfs}/ports/${port}/addr_trsvcid"
 	case "${tls}" in
 	none)
 		;;

-- 
2.56.1


