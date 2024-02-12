Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DE2C48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 10:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FFggav3UdwphxqxkITKQjzcWtQGpfLWKc9311B20mcI=; b=p+KAfunuuZtkxOkxqKbxnETlGj
	U2NoKYsCblwukPdya2opSLc9Qy8utSe6f2xi6IGjKAW7iUbodO4JYIpCx876cUw6YEOTn0r9hRw44
	4ZwTmk/r6HraN5BDLM4/d5iUVRBbLx2x34MxWXh6tOt1IR4uDyEi7g4nrdGcLn4eGQhPv38W02th7
	BbP2ZOM5jXNFrX5dUZrlhPZANFgSO/q2B5QXS3dBnI8HCDvDa8pSboKpF3IfT4dw4zB+2hJ1Zicai
	3J7MCne0F6KCy1IRLYftWkPDNt6EFBrP5qPMFk2TjAyqJlDbpBRlycLEmcE6LQLrXBFAErS+/RIdd
	DdkhR5tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZTkI-00000004vkn-0Lwu;
	Mon, 12 Feb 2024 10:41:06 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZTk6-00000004ve3-3Vmb
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 10:41:04 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1DB3622156;
	Mon, 12 Feb 2024 10:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFggav3UdwphxqxkITKQjzcWtQGpfLWKc9311B20mcI=;
	b=xtiuk9NOpemU3uORvgcriN7381bzxyPbmSc7Unpeahcts0tYRG4d5XmIGxCkjgIF141CVn
	q+d3ary0uXW03uKtEr99wbAfplyKaaAQZwkNNjWvVVmALX19huHA8tKrqhe5EVd03DqW8G
	MQMUyC2UmShvBTd6qHp0alq8oQ3YwKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFggav3UdwphxqxkITKQjzcWtQGpfLWKc9311B20mcI=;
	b=lJkMiqkx2bbwFf0k/qAHaIHynMCMqEg1gTZIpgbDeDXuSNoOIbfWyq5jX5FCxLWDcArrq6
	FkoJdJTYoZv5W+Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707734453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFggav3UdwphxqxkITKQjzcWtQGpfLWKc9311B20mcI=;
	b=xtiuk9NOpemU3uORvgcriN7381bzxyPbmSc7Unpeahcts0tYRG4d5XmIGxCkjgIF141CVn
	q+d3ary0uXW03uKtEr99wbAfplyKaaAQZwkNNjWvVVmALX19huHA8tKrqhe5EVd03DqW8G
	MQMUyC2UmShvBTd6qHp0alq8oQ3YwKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707734453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFggav3UdwphxqxkITKQjzcWtQGpfLWKc9311B20mcI=;
	b=lJkMiqkx2bbwFf0k/qAHaIHynMCMqEg1gTZIpgbDeDXuSNoOIbfWyq5jX5FCxLWDcArrq6
	FkoJdJTYoZv5W+Dg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0092913A0E;
	Mon, 12 Feb 2024 10:40:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 4pJKOrT1yWXxCwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 12 Feb 2024 10:40:52 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 4/5] nvme/rc: do not issue errors when disconnecting when using fc transport
Date: Mon, 12 Feb 2024 11:40:45 +0100
Message-ID: <20240212104046.13127-5-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212104046.13127-1-dwagner@suse.de>
References: <20240212104046.13127-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.55 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.15)[68.81%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240212_024055_071984_68537B82 
X-CRM114-Status: GOOD (  11.24  )
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
enabled, discovery controllers are created and destroyed while the tests
are running.

The cleanup code expects that all devices are under blktests control,
but this isn't the case. Thus filter out disconnect failures as well.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index ca6a284a1e25..cdfc738d3aec 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -356,7 +356,7 @@ _cleanup_nvmet() {
 			if [[ "$transport" != "fc" ]]; then
 				echo "WARNING: Test did not clean up ${nvme_trtype} device: ${dev}"
 			fi
-			_nvme_disconnect_ctrl "${dev}"
+			_nvme_disconnect_ctrl "${dev}" 2>/dev/null
 		fi
 	done
 
-- 
2.43.0


