Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50800606A326
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=upCEGYZx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=8J0r9IOW1mj4uBZqobUrjHp00LkGbd4UFVk4MIUl4nE=; b=upCEGYZxK2GG52
	sHJh6kOORDdY5BX0kSDZaI2B9lSLshIl/mySxbMOGUJg+5TWUbHFMv+VrQAq4LYWE3wzqWTym/BsW
	PCNPSCfNlaH0hfZfTpwafRY9mSDPI5SaqdD3nbxJzbDEQvj7eXNuzhwirb4k/bJS9pBmRV/tb1gAI
	k/iekC90jfAUPABpTBHsBd5OI5SBf8OHDd5mzxWF/QPzmNA5DMhQR5ZkYpaI+xOfam8cNbZC/fUmS
	pZ9wKi3cdzhsUsp85EzBUX+13LPEZ50V8yKuEJppZJP7ZRx2pF/g1xFDcKERrjG1SgQTqRUxRqQug
	OTbXfU/NSyH2ColQlMww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObvp-00000005czR-3pi5;
	Wed, 04 Nov 2026 14:25:41 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xObvn-00000005cw8-0Kjm
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 14:25:40 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 888F821F44;
	Wed,  4 Nov 2026 14:25:37 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47F27134F0;
	Wed,  4 Nov 2026 14:25:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Y53MCGFA62qLagAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 04 Nov 2026 14:25:37 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 04 Nov 2026 15:25:16 +0100
Subject: [PATCH blktests v2 4/6] nvme/rc: add helpers to count the commands
 on a queue
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-nvme-isolcpu-v2-4-2d59f622a2c8@suse.de>
References: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
In-Reply-To: <20261104-nvme-isolcpu-v2-0-2d59f622a2c8@suse.de>
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
X-Rspamd-Queue-Id: 888F821F44
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_062539_272202_DAA422C6 
X-CRM114-Status: GOOD (  11.57  )
X-Spam-Score: -1.9 (-)
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

Tests for the queue mapping need to know which I/O queue the commands of
a CPU are sent on. Add helpers which trace the nvme_setup_cmd event for
one queue of a controller and count the commands.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 8abd14eeb112..ea4cd500af9a 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -640,3 +640,36 @@ _nvme_ctrl_tls_key() {
 
 	cat /sys/class/nvme/"$ctrl"/tls_key 2>/dev/null
 }
+
+# Check that the trace instance $1 has the nvme_setup_cmd event.
+_nvme_have_setup_cmd_event() {
+	local trace_dir="$1"
+
+	if [[ ! -d "${trace_dir}/events/nvme/nvme_setup_cmd" ]]; then
+		SKIP_REASONS+=("tracepoint nvme/nvme_setup_cmd does not exist")
+		return 1
+	fi
+	return 0
+}
+
+# Start tracing the commands sent on queue $3 of controller $2 in the trace
+# instance $1.
+_nvme_trace_qid_start() {
+	local trace_dir="$1"
+	local ctrl_id="$2"
+	local qid="$3"
+	local event="${trace_dir}/events/nvme/nvme_setup_cmd"
+
+	_set_attr "" "${trace_dir}/trace"
+	_set_attr "ctrl_id == ${ctrl_id} && qid == ${qid}" "${event}/filter"
+	_set_attr 1 "${event}/enable"
+}
+
+# Stop tracing in the trace instance $1 and print the number of traced
+# commands.
+_nvme_trace_qid_stop() {
+	local trace_dir="$1"
+
+	_set_attr 0 "${trace_dir}/events/nvme/nvme_setup_cmd/enable"
+	grep -c "nvme_setup_cmd:" "${trace_dir}/trace"
+}

-- 
2.56.0


