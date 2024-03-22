Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40830C54E71
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 15:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1LciYTeStZ185FK8QBYDz5Vn9SOmgKuJB3FpoJGzxkA=; b=G0okR423CS9hvxi0WdyulNl4P3
	RhtcabD0pNGErIVcNS72QySzb5HPV6J1eOKb0ttsTpvCFwrU/mtoWd2ihoNs3/lF5T1Sgmy7xKAc3
	TC3NTRwoFHfbrqz52TnNB99JZBagsYElLtOWxUVhaFppHvXa7UXi85YX/9pJutAIxU16FkTwQMKN2
	mzCxeEJ3I2bvmOCBi3+arAKbjXzah6j73wNO/gl0AfiZZk4K5U6PZxgLp3O41ZP4b9HfMaCx9Ct5V
	/mZo75qGAF+MDJft/UizBxAOcbUQmx7T3ahrNrtk4TyCugzGhQdjP23Zdk0DgkBQLkOFr5aaLhatu
	XRrFOtsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rngPk-00000007f6I-1lhF;
	Fri, 22 Mar 2024 15:02:36 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnfHs-00000007PnA-1COb
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 13:50:38 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DCFFB5FE1B;
	Fri, 22 Mar 2024 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LciYTeStZ185FK8QBYDz5Vn9SOmgKuJB3FpoJGzxkA=;
	b=F11eDfqa9I33Gq/KFQGIN64y6G+xrIB+C4yXoKjNFJCCS0W6pYmqhsn/grJA9JIYs0UaUk
	8PIL2OwIEPqV6SajDdDq/y0Yvq2XLQ5P+9L21PKKDB89nCpl+fFemxzBbCNJpOdV2Kyj/4
	ZmA5194nvXQXK1QoL6vIh9JZ2zlfeVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LciYTeStZ185FK8QBYDz5Vn9SOmgKuJB3FpoJGzxkA=;
	b=xNR7D7SuF6974Cqsat31O9ynJAjzScF//Tf+rZvUINs6YMGrBynGyllMQH/kUuqKmpvWcx
	tsOjpg88sCy3TiCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711115420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LciYTeStZ185FK8QBYDz5Vn9SOmgKuJB3FpoJGzxkA=;
	b=F11eDfqa9I33Gq/KFQGIN64y6G+xrIB+C4yXoKjNFJCCS0W6pYmqhsn/grJA9JIYs0UaUk
	8PIL2OwIEPqV6SajDdDq/y0Yvq2XLQ5P+9L21PKKDB89nCpl+fFemxzBbCNJpOdV2Kyj/4
	ZmA5194nvXQXK1QoL6vIh9JZ2zlfeVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711115420;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LciYTeStZ185FK8QBYDz5Vn9SOmgKuJB3FpoJGzxkA=;
	b=xNR7D7SuF6974Cqsat31O9ynJAjzScF//Tf+rZvUINs6YMGrBynGyllMQH/kUuqKmpvWcx
	tsOjpg88sCy3TiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CCA47136AD;
	Fri, 22 Mar 2024 13:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AfmiMJyM/WWAJAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 13:50:20 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 03/18] nvme/rc: log error if stale configuration is found
Date: Fri, 22 Mar 2024 14:50:00 +0100
Message-ID: <20240322135015.14712-4-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322135015.14712-1-dwagner@suse.de>
References: <20240322135015.14712-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.82 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.52)[80.41%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_065024_557160_F390E59E 
X-CRM114-Status: GOOD (  11.16  )
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

It's possible that a previous run of blktest left some stale
configuration left. E.g. when the module unload doesn't work (the bug
might in the kernel we are testing). In this case error out and avoid
confusion.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 tests/nvme/rc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 865c8c351159..e67bb846ab77 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -658,6 +658,11 @@ _create_nvmet_host() {
 	local nvmet_ctrlkey="$4"
 	local host_path="${NVMET_CFS}/hosts/${nvmet_hostnqn}"
 
+	if [[ -d "${host_path}" ]]; then
+		echo "FAIL target setup failed. stale host configuration found"
+		return 1;
+	fi
+
 	mkdir "${host_path}"
 	_add_nvmet_allow_hosts "${nvmet_subsystem}" "${nvmet_hostnqn}"
 	if [[ "${nvmet_hostkey}" ]] ; then
-- 
2.44.0


