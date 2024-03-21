Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C856C54E58
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 11:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XSwWBqWUSD8+M7SAylRtgq7n47f1ZHfkI43qiK/fNIs=; b=b98+6+s9RJihphKPCXyuP4R9O6
	xt0j5DAS9P4KCExzJAAWEQDjR/E1K3sScfiPP8P7HgsD8RsQkeTgSi7o82Wwve091TmePyqboqSZe
	2gCk4WvIx26t3xofjnNt2CjyjemRpcjDuyUQbjgkLOdeQNkhk8h5m5vpY0X5/mMw11Q2EkHjAMM/E
	lsw4zquL6GJu2Xru8LVnBYW5Z32Imhn42nXjwM+AWrX1an/9fvxabo/NN+ny5uNuIc3BGRsFUeYa6
	BJxwVzuRXPjh7zVKfKAHU9Wpx6kh7Oqx0xyxtmWP93QQvrGKoTsTh7BuyNP52SLflMorgMpLwXrrw
	hzQDFYJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnGBj-00000002hta-12CM;
	Thu, 21 Mar 2024 11:02:23 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnF1L-00000002Wi6-2KIH
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 09:47:48 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 969551FBF9;
	Thu, 21 Mar 2024 09:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSwWBqWUSD8+M7SAylRtgq7n47f1ZHfkI43qiK/fNIs=;
	b=ukkdw13TY8Z8/KJ2TpVf8lc5z86Uf1yT310HRyu/Y4nSNxjrOsUpT3PCPY0GKqSN7LWuxv
	JOhIGWaQvvvVaa+RcBGuDP7wc5yI+YS7F21LvCxvaWO3f2V/0HnRZSszRWJuSfNQaFwXxf
	63PSjKV7klV8Yh8b3LtKAYGKEbPt/ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSwWBqWUSD8+M7SAylRtgq7n47f1ZHfkI43qiK/fNIs=;
	b=J5TuhvC20ceq+u7RdLVTtteGmE2Z+MwU6dVxC4zWD92+SlZHs4CrIafv205pgEBLQXzMVo
	D4u7MbHmjJxFhLDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711014451; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSwWBqWUSD8+M7SAylRtgq7n47f1ZHfkI43qiK/fNIs=;
	b=ukkdw13TY8Z8/KJ2TpVf8lc5z86Uf1yT310HRyu/Y4nSNxjrOsUpT3PCPY0GKqSN7LWuxv
	JOhIGWaQvvvVaa+RcBGuDP7wc5yI+YS7F21LvCxvaWO3f2V/0HnRZSszRWJuSfNQaFwXxf
	63PSjKV7klV8Yh8b3LtKAYGKEbPt/ag=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711014451;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XSwWBqWUSD8+M7SAylRtgq7n47f1ZHfkI43qiK/fNIs=;
	b=J5TuhvC20ceq+u7RdLVTtteGmE2Z+MwU6dVxC4zWD92+SlZHs4CrIafv205pgEBLQXzMVo
	D4u7MbHmjJxFhLDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BE3913976;
	Thu, 21 Mar 2024 09:47:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TcjbHDMC/GW5DwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:47:31 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v1 02/18] nvme/rc: silence fcloop cleanup failures
Date: Thu, 21 Mar 2024 10:47:11 +0100
Message-ID: <20240321094727.6503-3-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321094727.6503-1-dwagner@suse.de>
References: <20240321094727.6503-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ukkdw13T;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=J5TuhvC2
X-Spamd-Result: default: False [3.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[43.05%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 969551FBF9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_024735_791427_C7454A3A 
X-CRM114-Status: GOOD (  10.63  )
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

When the ctl file is missing we are logging

  tests/nvme/rc: line 265: /sys/class/fcloop/ctl/del_target_port: No such file or directory
  tests/nvme/rc: line 257: /sys/class/fcloop/ctl/del_local_port: No such file or directory
  tests/nvme/rc: line 249: /sys/class/fcloop/ctl/del_remote_port: No such file or directory

because the first redirect operator fails. Thus first check if the ctl
file exists.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 78d84af72e73..53fa54e64cb2 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -234,7 +234,10 @@ _nvme_fcloop_del_rport() {
 	local remote_wwpn="$4"
 	local loopctl=/sys/class/fcloop/ctl
 
-	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn}" > ${loopctl}/del_remote_port 2> /dev/null
+	if [[ ! -f "${loopctrl}" ]]; then
+		return
+	fi
+	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn}" > ${loopctl}/del_remote_port > /dev/null 2>&1
 }
 
 _nvme_fcloop_del_lport() {
@@ -242,7 +245,10 @@ _nvme_fcloop_del_lport() {
 	local wwpn="$2"
 	local loopctl=/sys/class/fcloop/ctl
 
-	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/del_local_port 2> /dev/null
+	if [[ ! -f "${loopctrl}" ]]; then
+		return
+	fi
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/del_local_port > /dev/null > /dev/null 2>&1
 }
 
 _nvme_fcloop_del_tport() {
@@ -250,7 +256,10 @@ _nvme_fcloop_del_tport() {
 	local wwpn="$2"
 	local loopctl=/sys/class/fcloop/ctl
 
-	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/del_target_port 2> /dev/null
+	if [[ ! -f "${loopctrl}" ]]; then
+		return
+	fi
+	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/del_target_port > /dev/null 2&>1
 }
 
 _cleanup_fcloop() {
-- 
2.44.0


