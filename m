Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07671C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 11:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k/Mo50C17UHVkLQ+zkfZChtWQAKfcjubdo+pJdBbSdM=; b=jT5svda4wY2lIev+l7jlB8xUth
	RBerjT5krBNVJToMStBM+sMrLkT4SfdTeSJO1GhwT4hYhS7lmNd0xX71USg3gWtXclG+tHBP0M+o8
	l/o2F1zyzdE9agL7uhw/NIc4CNqFrswTnRO5qFxL5Wm6nLjJMSmRgGUwnHhvCLoB17sDiDehP8Ldf
	I8XiSCPRB+p8EsjQBS5xQHIxSPjL93fMaP5efXpA1m2qyeO82VT2YJFN8lTx85s63HoehlmSr1Iw/
	k1EU/C2XqfSe6KCfoVegrq/DMRBejqXOV0d9J2FNqFYb0bz4U5iOlbFNqnZUNaQb10fFshRpUvMfn
	6aVRkNxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzctb-007vmb-9X; Fri, 10 Jun 2022 11:33:43 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzctT-007viq-3V
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 11:33:41 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id D834C1F9A7;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654860813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/Mo50C17UHVkLQ+zkfZChtWQAKfcjubdo+pJdBbSdM=;
	b=kung3n27eAjtz2zfT436PBHO89LE21OUfdHJ50VhXooFYr4q7zBumpjh8KwJsbOOIujLnz
	1fROuVwVeNEHUS7I7qLDp03GDL6v9sjPKUZgRl4sVEKAl9oy0ap/iAxrEeLg/7a7FeuVR5
	p0w4ZML3p4yXi1+CALEhWq8fYJGNqXo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654860813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k/Mo50C17UHVkLQ+zkfZChtWQAKfcjubdo+pJdBbSdM=;
	b=6loUkokl7sEUMv3vjrdjQtbfWFsv/Bc4t7Zl2ZoiGizaAZ4yRaCvamQDa4OPVnoAoFRjXi
	miiTM5CHvSzMU6Ag==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D113D2C149;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 9FFFE5194A40; Fri, 10 Jun 2022 13:33:33 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/10] nvme/rc: add more arguments to _nvme_connect_subsys()
Date: Fri, 10 Jun 2022 13:33:19 +0200
Message-Id: <20220610113324.10294-6-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220610113324.10294-1-hare@suse.de>
References: <20220610113324.10294-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_043335_362262_FD18E3F2 
X-CRM114-Status: UNSURE (   8.64  )
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

From: Hannes Reinecke <hare@suse.com>

Add optional arguments for setting 'hostnqn', 'hostid', 'hostkey',
and 'ctrlkey' to _nvme_connect_subsys() to make it usable for
testing nvme in-band authentication.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 tests/nvme/rc | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 2873037..b7bb3cd 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -190,11 +190,27 @@ _nvme_connect_subsys() {
 	local subsysnqn="$2"
 	local traddr="${3:-$def_traddr}"
 	local trsvcid="${4:-$def_trsvcid}"
+	local hostnqn="${5:-$def_hostnqn}"
+	local hostid="${6:-$def_hostid}"
+	local hostkey="${7}"
+	local ctrlkey="${8}"
 
 	ARGS=(-t "${trtype}" -n "${subsysnqn}")
 	if [[ "${trtype}" != "loop" ]]; then
 		ARGS+=(-a "${traddr}" -s "${trsvcid}")
 	fi
+	if [[ "${hostnqn}" != "$def_hostnqn" ]]; then
+		ARGS+=(--hostnqn="${hostnqn}")
+	fi
+	if [[ "${hostid}" != "$def_hostid" ]]; then
+		ARGS+=(--hostid="${hostid}")
+	fi
+	if [[ -n "${hostkey}" ]]; then
+		ARGS+=(--dhchap-secret="${hostkey}")
+	fi
+	if [[ -n "${ctrlkey}" ]]; then
+		ARGS+=(--dhchap-ctrl-secret="${ctrlkey}")
+	fi
 	nvme connect "${ARGS[@]}"
 }
 
-- 
2.26.2


