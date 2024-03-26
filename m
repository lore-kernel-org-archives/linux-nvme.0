Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2786CC6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Mar 2024 13:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1exT17DU8HZ1V3VVIR43LcqgZanC+D5kbkzjJRcLqa4=; b=NDL3opORrRZVuKvJ+BUt+RC/+4
	EQTUqVIn+p5vDlFKg1axeJQ/nIq9w42AarmRZ+PVRFTKxZXzIC8vCM9tT2E7RZjn/PQypcx9A5uPr
	cSChqXN9QgZ4DSPFFCCsVALsBTDBIndvt9CzJGkd605hSxNzIRaTIIWJhlNGV0aQrGjS8CWc01Prm
	gyaZSAPUR0k9Czz+l3B7KPuYGuBnfAiRhzQ0M9SFWhXIq58TOe23JSan3uyv0gdGn84u6MWE2KOwg
	RU0S0Nk96dO3Xs+5RrSs6Kq+8IUy8xhvryISrakWfvPoew6o0XWRxxas6ElLKbXcZ/YfrJ3Pree/v
	K3lwuTEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6do-00000004cCa-1022;
	Tue, 26 Mar 2024 13:15:00 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6d5-00000004c2P-1uLl
	for linux-nvme@bombadil.infradead.org;
	Tue, 26 Mar 2024 13:14:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=1exT17DU8HZ1V3VVIR43LcqgZanC+D5kbkzjJRcLqa4=; b=gFOEYajVEF0DCkES59jabofl+3
	5l1IyLmHInTUrHqbiJhgz92MhTVpNJmLTve+zx78RnEUcPSAxJrRYrJB7DRVDCZaLkt98yzF4irlZ
	D533n1qglLC0KoTClRhLs2BsE1X4RYDDIc5H4YaXBIuk4oj+4N8KulgJipafaNx747zRvgEj80fJM
	JZ7QWyQvdi34xhcLP5ctCPtK7cn012mbUgAM1A4gyrShb8yhagIq+gaUzzFUTP2vH3ryA0sKi8yTQ
	JRHfDAKXnzMaxpJVX27z172//wLIf7i5g8yQq49GWsiNMIhMHHFoDAGr6+crYOs3ubH2ukC89AUq8
	KqzOUq1A==;
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp6d1-0000000HAwy-49mG
	for linux-nvme@lists.infradead.org;
	Tue, 26 Mar 2024 13:14:13 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A03E65D65B;
	Tue, 26 Mar 2024 13:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1exT17DU8HZ1V3VVIR43LcqgZanC+D5kbkzjJRcLqa4=;
	b=tGzPAElWRME7fltT1u2z++CApOPF0DF+YxVqrojlLCdUjTx7onso9vPdEOHGv7+GBy7Yv/
	5DlsqFr0gmHmx4BLreEob7aGCbAn3VTEnXPBSSj1DoqJlUT1zYSctD5//mQMeb6g43/rag
	PQPaR+iGLWj444wt08q+mfhEJTF4q9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1exT17DU8HZ1V3VVIR43LcqgZanC+D5kbkzjJRcLqa4=;
	b=QmfnFJECWfQucLkRQRHl02zrM3xXJPtr5VDBTJNfxZc7W1xcYL6MBr/9oa8IV64bUD6mj8
	YhFwtdw5tVWvN3Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711458850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1exT17DU8HZ1V3VVIR43LcqgZanC+D5kbkzjJRcLqa4=;
	b=tGzPAElWRME7fltT1u2z++CApOPF0DF+YxVqrojlLCdUjTx7onso9vPdEOHGv7+GBy7Yv/
	5DlsqFr0gmHmx4BLreEob7aGCbAn3VTEnXPBSSj1DoqJlUT1zYSctD5//mQMeb6g43/rag
	PQPaR+iGLWj444wt08q+mfhEJTF4q9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711458850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1exT17DU8HZ1V3VVIR43LcqgZanC+D5kbkzjJRcLqa4=;
	b=QmfnFJECWfQucLkRQRHl02zrM3xXJPtr5VDBTJNfxZc7W1xcYL6MBr/9oa8IV64bUD6mj8
	YhFwtdw5tVWvN3Aw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DC4013587;
	Tue, 26 Mar 2024 13:14:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pbcWISLKAmYONwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 26 Mar 2024 13:14:10 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 08/20] nvme/rc: connect subsys only support long options
Date: Tue, 26 Mar 2024 14:13:50 +0100
Message-ID: <20240326131402.5092-9-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326131402.5092-1-dwagner@suse.de>
References: <20240326131402.5092-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tGzPAElW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QmfnFJEC
X-Rspamd-Queue-Id: A03E65D65B
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240326_131412_153084_48BD7BAE 
X-CRM114-Status: UNSURE (   9.24  )
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

There is no user for the short command line options, thus
remove the short options to reduce the parsing overhead.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 6bf2e3ae37c5..535bd869bf58 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -428,55 +428,55 @@ _nvme_connect_subsys() {
 
 	while [[ $# -gt 0 ]]; do
 		case $1 in
-			-a|--traddr)
+			--traddr)
 				traddr="$2"
 				shift 2
 				;;
-			-w|--host-traddr)
+			--host-traddr)
 				host_traddr="$2"
 				shift 2
 				;;
-			-s|--trsvcid)
+			--trsvcid)
 				trsvcid="$2"
 				shift 2
 				;;
-			-n|--hostnqn)
+			--hostnqn)
 				hostnqn="$2"
 				shift 2
 				;;
-			-I|--hostid)
+			--hostid)
 				hostid="$2"
 				shift 2
 				;;
-			-S|--dhchap-secret)
+			--dhchap-secret)
 				hostkey="$2"
 				shift 2
 				;;
-			-C|--dhchap-ctrl-secret)
+			--dhchap-ctrl-secret)
 				ctrlkey="$2"
 				shift 2
 				;;
-			-i|--nr-io-queues)
+			--nr-io-queues)
 				nr_io_queues="$2"
 				shift 2
 				;;
-			-W|--nr-write-queues)
+			--nr-write-queues)
 				nr_write_queues="$2"
 				shift 2
 				;;
-			-P|--nr-poll-queues)
+			--nr-poll-queues)
 				nr_poll_queues="$2"
 				shift 2
 				;;
-			-k|--keep-alive-tmo)
+			--keep-alive-tmo)
 				keep_alive_tmo="$2"
 				shift 2
 				;;
-			-c|--reconnect-delay)
+			--reconnect-delay)
 				reconnect_delay="$2"
 				shift 2
 				;;
-			-l|--ctrl-loss-tmo)
+			--ctrl-loss-tmo)
 				ctrl_loss_tmo="$2"
 				shift 2
 				;;
-- 
2.44.0


