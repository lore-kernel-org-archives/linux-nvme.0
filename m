Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A7606A320
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=niguV7Ys;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=HpV5+Y9E
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JAN09A4NdRS/dWBT+5quorGPx38n8JUk5SBa8hafTS0=; b=niguV7YsPe5F2V
	H3nRSEfeMybMaFDuHSoZhZ6pnNhefjRqn7scgFh7M61Uauso2iExokgrYnyO1eRu3VTMsT/Zh33ZE
	XBHAH11XZWjcSDfABkyi16iVmYQ8WUx9MAJ9N8+8h+iDzM5RUs3OThVfnTBGjjxY0p/5DsChUtQ9G
	TWh8QjXPwCB/36tAQkMOuQt8XcLbb+JNkZxTckm9jMUZvREIySO29m8CIKzVtkYRaLDZjTDkHaRjN
	OcaXGC7f89OIb6rjLbyA1/cNEKz6xyY83bSpXlHouvtEAmGUXNJqeoHM6y/zNS0mdDEgmTy4myRxz
	Cv3R3xT7J99QinTP9+SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbwK-00000008Lcp-2i9N;
	Wed, 18 Nov 2026 09:26:52 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbwJ-00000008LbL-2I3H
	for linux-nvme@bombadil.infradead.org;
	Wed, 18 Nov 2026 09:26:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=JAN09A4NdRS/dWBT+5quorGPx38n8JUk5SBa8hafTS0=; b=HpV5+Y9EM7wOPAEa1mkMElgAgp
	lJ4bbs4PTjXSwFmyTn/P/hIntrOGBaEWBrcfYydaE2C3pzHqUf3D6U9wpb+f12mT3pb3Anpu6gGCX
	moKiDMroNomA4h+4EElwEmEmyhTAM6nz9QId3jl8zNz9lTYkdTdITly0GF9NpTCBDG1XiVDD7ixd5
	nWEP8NOZxPzlKH5pWTz6xERyAeSgNwiUeFtBfAauqghqaN00FnL1Bcg7uVRWfl1sciaHuHalvA4Kj
	bTHhH9Et5N+yE4Pk1jxqpHYNKx2YHMUyjWQ2KGMNjAOypTM++IYD/HPpzVfg05h9f6U2UGR5oKt9S
	rqw1WgEA==;
Received: from smtp-out1.suse.de ([195.135.223.130])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbwE-0000000FrMq-3Grs
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 09:26:50 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6673722258;
	Wed, 18 Nov 2026 09:26:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 237CB1334C;
	Wed, 18 Nov 2026 09:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kUIjO1Jv/Wo6fgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 09:26:43 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 10:26:39 +0100
Subject: [PATCH blktests v2 1/9] nvme/047: look up the namespace again
 after reconnecting
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-nvme-target-control-v2-1-d191bbbf5dd6@suse.de>
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
X-Rspamd-Queue-Id: 6673722258
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_092648_590755_60D4D60E 
X-CRM114-Status: UNSURE (   9.92  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.3 (--)
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

nvme/047 keeps using the namespace name from the first connect after
reconnecting. The name can change when other controllers come and go,
and fio then fails to open the device. Look it up again after the
second connect.

Fixes: 7497d8b45817 ("nvme/047: Test different queue types for fabrics transports")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/047 | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/nvme/047 b/tests/nvme/047
index 433090f2d6f2..2aeee2f0f1aa 100755
--- a/tests/nvme/047
+++ b/tests/nvme/047
@@ -42,6 +42,8 @@ test() {
 
 	_nvme_connect_subsys --nr-write-queues 1 --nr-poll-queues 1
 
+	ns=$(_find_nvme_ns "${def_subsys_uuid}")
+
 	_run_fio_rand_io --filename="/dev/${ns}" --size="${rand_io_size}"
 
 	_nvme_disconnect_subsys >> "$FULL" 2>&1

-- 
2.56.1


