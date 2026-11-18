Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0DC606A320
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 09:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IEA7DOpi;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=c9z+jyaK;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lYFHtoWI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dAxAIRxo;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=lYFHtoWI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=dAxAIRxo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=h761RMndxgOojiHI0yfEQhOUWEyCFrsuMNP4Yd/Fwao=; b=IEA7DOpiuKH0YI
	Yl2TyhJtH+aG9b3xmnrd/6dvXzIvuR4tP/O101vi7watAmio5H2yV/1Z5Pf0WuK+maTWpH9GhQ/D3
	RmDVi4rGofLJiply0A6vwMkBnxt0OclzOdt00rClrrbqiKuUj1/gvR42SRqlJ9xL0+6VBGLk1ZoHT
	cYUSruG4x79ALWQf5c4o7Rfz5tiUfB0jb52QJIPiGC6pyV3hRgQ8wLnwn2jLFqZaQrPXmLLzrrM7L
	qIi+A7Ks0+u9M3Kn+75O5zazlorTRkDxXKg8Mpv1s/PIMJ/5kBorKZVT2HvcQbfLHFIqayoi7PLsl
	1FuBvUlefuL19yBCfNFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbwY-00000008Lu9-0Dok;
	Wed, 18 Nov 2026 09:27:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbwU-00000008LnF-0IaD
	for linux-nvme@bombadil.infradead.org;
	Wed, 18 Nov 2026 09:27:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Sender:Reply-To:Content-ID:Content-Description;
	bh=h761RMndxgOojiHI0yfEQhOUWEyCFrsuMNP4Yd/Fwao=; b=c9z+jyaKKQ6Hp7BMNVS8H8EUTz
	qUqozOtoU56ffxO8gaZ4uzsaJqh13jfzrbfWMBh3wXp63Y89M/NwiJfGo2W3SZYjKHzSP2TS4Y1jx
	kRP+T33rcFZ/rmEbbRpUee3KBuy932Syr+17iGBQBfehHBGFBmcJlOnlTw5NyObLGSwksn8afP11Q
	387ukMkyKbD+kAnW7iKKhRmlbxdEHv5Rgu8KIkyPSWipl0Ppp1e7cbp6rsMzNDiEz5jlBEk/hK16U
	8JJGFtjCQqeP/BtV03aVfTRLO/IEJK1U8N/WFVyxCWl88kLez65d9S//SHEg5T/h2U0CVLGulYHou
	aSN3ecfw==;
Received: from smtp-out2.suse.de ([195.135.223.131])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTbwR-0000000FrPj-2AA4
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 09:27:01 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 41AA41F769;
	Wed, 18 Nov 2026 09:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794994018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h761RMndxgOojiHI0yfEQhOUWEyCFrsuMNP4Yd/Fwao=;
	b=lYFHtoWIBpE3YFqefH0ha99gNesdH0cGI2PUtKDhnJY3kar4/H7cRyPqZZLLx4xznFqFzS
	PxCj4PizSOo3uYvqjiZUJ8l4zdnfyeRKgDHQcKy32sJZfysBAT+CpNyD2Izgvs1f2GoJ9d
	UABnxOIBTBQkOwIIrcT4+ME2NWghuEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794994018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h761RMndxgOojiHI0yfEQhOUWEyCFrsuMNP4Yd/Fwao=;
	b=dAxAIRxojwDYFkJn7ABB+6Gf52qxSgDe7XY34NjyEGmytZe8K/4laSitHcYhuaRy4FIfR5
	vfdsTXlMawdPbPDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794994018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h761RMndxgOojiHI0yfEQhOUWEyCFrsuMNP4Yd/Fwao=;
	b=lYFHtoWIBpE3YFqefH0ha99gNesdH0cGI2PUtKDhnJY3kar4/H7cRyPqZZLLx4xznFqFzS
	PxCj4PizSOo3uYvqjiZUJ8l4zdnfyeRKgDHQcKy32sJZfysBAT+CpNyD2Izgvs1f2GoJ9d
	UABnxOIBTBQkOwIIrcT4+ME2NWghuEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794994018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h761RMndxgOojiHI0yfEQhOUWEyCFrsuMNP4Yd/Fwao=;
	b=dAxAIRxojwDYFkJn7ABB+6Gf52qxSgDe7XY34NjyEGmytZe8K/4laSitHcYhuaRy4FIfR5
	vfdsTXlMawdPbPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1EAB1334C;
	Wed, 18 Nov 2026 09:26:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LfbVMWFv/WpWfgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 09:26:57 +0000
From: Daniel Wagner <dwagner@suse.de>
Date: Wed, 18 Nov 2026 10:26:46 +0100
Subject: [PATCH blktests v2 8/9] nvme/rc: change the host keys on a remote
 target
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-nvme-target-control-v2-8-d191bbbf5dd6@suse.de>
References: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
In-Reply-To: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spamd-Result: default: False [-17.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -17.30
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_092659_559791_42F3FE87 
X-CRM114-Status: GOOD (  11.79  )
X-Spam-Score: -2.5 (--)
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The helpers that change the DH-CHAP settings of the host write to the
local nvmet configfs, so a remote target never sees the new values. Use
the set-host command of the target control script instead and document
it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 Documentation/running-tests.md |  9 +++++++++
 tests/nvme/rc                  | 20 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
index 8300d9aa4842..149b3656d7c8 100644
--- a/Documentation/running-tests.md
+++ b/Documentation/running-tests.md
@@ -296,6 +296,15 @@ set-ana: set the state of an ANA group on the port
 
 If list-ports prints nothing, blktests connects to the address config shows.
 
+The authentication tests change the DH-CHAP attributes of the host:
+
+set-host:
+  --hostnqn HOSTNQN
+  --hostkey HOSTKEY
+  --ctrlkey CTRLKEY
+  --hash HASH
+  --dhgroup DHGROUP
+
 contrib/nvme-target-control implements this interface. It configures a Linux
 nvmet target over ssh and can be extended for other targets, see
 contrib/nvme-target-control/README.md.
diff --git a/tests/nvme/rc b/tests/nvme/rc
index 0d74c427313c..47710efc5096 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -285,6 +285,11 @@ _set_nvmet_hostkey() {
 	local nvmet_hostkey="$2"
 	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		"${nvme_target_control}" set-host --hostnqn "${nvmet_hostnqn}" \
+			--hostkey "${nvmet_hostkey}"
+		return
+	fi
 	_set_attr "${nvmet_hostkey}" "${cfs_path}/dhchap_key"
 }
 
@@ -293,6 +298,11 @@ _set_nvmet_ctrlkey() {
 	local nvmet_ctrlkey="$2"
 	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		"${nvme_target_control}" set-host --hostnqn "${nvmet_hostnqn}" \
+			--ctrlkey "${nvmet_ctrlkey}"
+		return
+	fi
 	_set_attr "${nvmet_ctrlkey}" "${cfs_path}/dhchap_ctrl_key"
 }
 
@@ -301,6 +311,11 @@ _set_nvmet_hash() {
 	local nvmet_hash="$2"
 	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		"${nvme_target_control}" set-host --hostnqn "${nvmet_hostnqn}" \
+			--hash "${nvmet_hash}"
+		return
+	fi
 	_set_attr "${nvmet_hash}" "${cfs_path}/dhchap_hash"
 }
 
@@ -309,6 +324,11 @@ _set_nvmet_dhgroup() {
 	local nvmet_dhgroup="$2"
 	local cfs_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
+	if [[ -n "${nvme_target_control}" ]]; then
+		"${nvme_target_control}" set-host --hostnqn "${nvmet_hostnqn}" \
+			--dhgroup "${nvmet_dhgroup}"
+		return
+	fi
 	_set_attr "${nvmet_dhgroup}" "${cfs_path}/dhchap_dhgroup"
 }
 

-- 
2.56.1


