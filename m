Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A60C4828D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 13:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dHaPxclIhI0hjj2FtR7xauVb1lby62iOVX7RO+KLhA0=; b=S+Gc9690te/JTsZtK1BUIWroJf
	LHYDpQvzXKAdTkHZmhEr2Nr7lt6LvrSGa4rAKtzcvmfBMYkuGXo/F2HjfgsizGyijslbLdvgIGkUl
	HvxzoSugMD82qZWv1/hxhDCoRpbPcN5SAOqflms4WRlNGq7BpVdEkWxvliQzpCCbhioUA2C2Zp/fY
	PZ3yyd6i5CT7graRPZFdDr7m5vUJOLZrT1mXEluEdz6xVXLj8KWZXP/HFZodjjYmN5LP31a+H6Ykd
	H/wIUneXeG6heGN6chXMaIsivIuEIMDkVT/Dj+V8+PPw7cY/7Stc57XUbEwlTRDtjKOHbLpfLVrGt
	5bOnHacA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXLKE-00000007gtf-3Wab;
	Tue, 06 Feb 2024 13:17:22 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXLJz-00000007gie-0uvj
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 13:17:16 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8D95221B6;
	Tue,  6 Feb 2024 13:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707225425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHaPxclIhI0hjj2FtR7xauVb1lby62iOVX7RO+KLhA0=;
	b=0B1n+p6r6cirVgvHxUj/0XZ6kGCfWe5q2s6A8+RrNq17J0enXkh1isctzOBM/5hz07zP2z
	2/FILAeWqrMDPdEh0UcMVbZ9lW776qr0UoOkggPNSciKXvlrLcGTqEY/sIC5odWCiZqOLH
	SWf5fMqP2M685q0fDtsyGu57vlYsNTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707225425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHaPxclIhI0hjj2FtR7xauVb1lby62iOVX7RO+KLhA0=;
	b=Hfg5g6eomPTIU3ayWFG1irg3it7FEzUBy/CwG2JNvxNrxIBC+/dAArFl6mw1Tm7UPpJcLD
	RQBzptaL738eAhCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707225425; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHaPxclIhI0hjj2FtR7xauVb1lby62iOVX7RO+KLhA0=;
	b=0B1n+p6r6cirVgvHxUj/0XZ6kGCfWe5q2s6A8+RrNq17J0enXkh1isctzOBM/5hz07zP2z
	2/FILAeWqrMDPdEh0UcMVbZ9lW776qr0UoOkggPNSciKXvlrLcGTqEY/sIC5odWCiZqOLH
	SWf5fMqP2M685q0fDtsyGu57vlYsNTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707225425;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dHaPxclIhI0hjj2FtR7xauVb1lby62iOVX7RO+KLhA0=;
	b=Hfg5g6eomPTIU3ayWFG1irg3it7FEzUBy/CwG2JNvxNrxIBC+/dAArFl6mw1Tm7UPpJcLD
	RQBzptaL738eAhCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B628E132DD;
	Tue,  6 Feb 2024 13:17:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9G4TK1ExwmV2OgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 06 Feb 2024 13:17:05 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 3/5] nvme/rc: do not issue warnings on cleanup when using fc transport
Date: Tue,  6 Feb 2024 14:16:53 +0100
Message-ID: <20240206131655.32050-4-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240206131655.32050-1-dwagner@suse.de>
References: <20240206131655.32050-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.44%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_051707_445750_D5BAF63D 
X-CRM114-Status: GOOD (  12.47  )
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
are running.

The cleanup code expects that all devices are under blktetsts control,
but this isn't the case. So just disable the warning as it is reporting
a lot of false positives.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 9cc83afe0668..ca6a284a1e25 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -352,7 +352,10 @@ _cleanup_nvmet() {
 		dev="$(basename "$dev")"
 		transport="$(cat "/sys/class/nvme/${dev}/transport" 2>/dev/null)"
 		if [[ "$transport" == "${nvme_trtype}" ]]; then
-			echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
+			# if udev auto connect is enabled for FC we get false positives
+			if [[ "$transport" != "fc" ]]; then
+				echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
+			fi
 			_nvme_disconnect_ctrl "${dev}"
 		fi
 	done
-- 
2.43.0


