Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D059CC4829A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 13:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iMcT+pci9fKU96u1P4Z6cSU9WUkUsvXausIPa2n6xGI=; b=fOnQgE/9L9iP2FuurxiMoXWIyH
	60RfRCRgV1VVEQ7N/gdXm/ntGWOzYDcK/cuJctNkqpNtFjKftxpqZyweswiN3nODtyiiDy34wRC+3
	e54BgEebiCA8KNuirKEXb17VEjCCMrUOz5RcRIWK0xI59IBF46fY+Bz4Nhp+0EUIStdar4usxicf/
	xpeaBflhPAtdCxMIOblSokn0WKxvc3W7yY0fZtEV5ZU/tLl38AQz8zIc5Jf1hHby6O+driMQCRE5E
	S3hniFPML2JRLt4vqB4jlOZo8QfFZNR3fvKLXQhrw40m8ujYyf17HJlBoHNJQ5gvHhvl78pQfbsa/
	E7Rlnhig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXLKB-00000007gqN-1WZL;
	Tue, 06 Feb 2024 13:17:19 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXLJz-00000007gid-247W
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 13:17:15 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 380F51F385;
	Tue,  6 Feb 2024 13:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707225425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMcT+pci9fKU96u1P4Z6cSU9WUkUsvXausIPa2n6xGI=;
	b=voXOhrLpyCMvH+katTJ7JXo91KMWauGNPnOmSMaLqsxGFd7pMZrdcDX7LnqF2p5i6jXPwe
	wOoFPPUPfm2wMJlWxtUa+kfmXwXCR7rvKaic6O1HWnDIcF8mOu3eAENVS70vjjM9OMum1D
	R8b/r4rCYC0V58d30dDxK8zLH9FB7UQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707225425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMcT+pci9fKU96u1P4Z6cSU9WUkUsvXausIPa2n6xGI=;
	b=/U8FEUylyR/YKVllKObbSeMW1vjM2+ZqrRyI7Ap1cEoRqLf5Cw7Ydssujii55wAoL8sHS5
	IwdvLU48pTSUw0AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707225425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMcT+pci9fKU96u1P4Z6cSU9WUkUsvXausIPa2n6xGI=;
	b=voXOhrLpyCMvH+katTJ7JXo91KMWauGNPnOmSMaLqsxGFd7pMZrdcDX7LnqF2p5i6jXPwe
	wOoFPPUPfm2wMJlWxtUa+kfmXwXCR7rvKaic6O1HWnDIcF8mOu3eAENVS70vjjM9OMum1D
	R8b/r4rCYC0V58d30dDxK8zLH9FB7UQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707225425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iMcT+pci9fKU96u1P4Z6cSU9WUkUsvXausIPa2n6xGI=;
	b=/U8FEUylyR/YKVllKObbSeMW1vjM2+ZqrRyI7Ap1cEoRqLf5Cw7Ydssujii55wAoL8sHS5
	IwdvLU48pTSUw0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 18D8E132DD;
	Tue,  6 Feb 2024 13:17:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gWZoBFExwmV0OgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 06 Feb 2024 13:17:05 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 2/5] nvme/rc: filter out errors from cat when reading files
Date: Tue,  6 Feb 2024 14:16:52 +0100
Message-ID: <20240206131655.32050-3-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206131655.32050-1-dwagner@suse.de>
References: <20240206131655.32050-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.87 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[56.89%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_051707_763114_7583D801 
X-CRM114-Status: GOOD (  12.89  )
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

When running the tests with FC as transport and the udev auto connect
enabled, discovery controllers are created and destroys while the tests
are running. This races with the cleanup code and also the
_find_nvme_dev() which iterates over all device entries and tries to
read the connect of transport and subsysnqn sysfs attributes. Since
these steps are not locked in anyway, the resources can go away in
between.

Thus filter out 'cat' reporting non existing subsysnqn or transport
attributes. The tests will still fail if they can't fine the device etc.
But without filtering these errors out the tests fail randomly.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index e0461f1cd53a..9cc83afe0668 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -350,7 +350,7 @@ _cleanup_nvmet() {
 
 	for dev in /sys/class/nvme/nvme*; do
 		dev="$(basename "$dev")"
-		transport="$(cat "/sys/class/nvme/${dev}/transport")"
+		transport="$(cat "/sys/class/nvme/${dev}/transport" 2>/dev/null)"
 		if [[ "$transport" == "${nvme_trtype}" ]]; then
 			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
 			_nvme_disconnect_ctrl "${dev}"
@@ -840,7 +840,7 @@ _find_nvme_dev() {
 	for dev in /sys/class/nvme/nvme*; do
 		[ -e "$dev" ] || continue
 		dev="$(basename "$dev")"
-		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn")"
+		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn" 2>/dev/null)"
 		if [[ "$subsysnqn" == "$subsys" ]]; then
 			echo "$dev"
 		fi
-- 
2.43.0


