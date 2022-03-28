Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B5DDC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 10:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IMFFArrnppYp3jhmmGfpqWKMmrq/zQZgpH9Qz8FYSUw=; b=k9TviyPSzUVCSkqa2K77cw7T2z
	4Pl09WCn0JWDALHwbn3lNdYeUBMNkLqO4Iley+kKTearBwt14hkuCch48SEMWIMPVOZww005ou/Nt
	2Cz4+RR/Nug4kB4znPRUUBtQi8YaQZ2YeR1UnOriciSegSNV5F4IVSi1ld+niQ+k6g03mkvp93/kz
	X+sZFxUmoHxy/tXvFo5VYR2Pej2KdqFR3zNG8axgkJTWeL9pGFoCLpVxYsmupxBJSfrvxFINwLX5+
	0fEwsmZ+DP6B913xBqO+MmdRPUQWlPC1jn7HEXJaU52hs8j9TXr+pSPpnjzVfDDYOMd9S+BBbfwjZ
	qK6hkCbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYmT6-0088x5-FT; Mon, 28 Mar 2022 10:19:24 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYmT3-0088uX-K8
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 10:19:23 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 505B51F37E;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648462760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMFFArrnppYp3jhmmGfpqWKMmrq/zQZgpH9Qz8FYSUw=;
 b=SvnBy4BbBnHhwKFJu1IpkDEeIsG9c0xE+3nPQgkuduYVT6DZxPih1BMpU1FaEGtQ4o3EYV
 zKCrm1EbbtimgbvgIUGrNqyJ/FxaKmnvGffraVadpdQIqsnvxiboYOxQJQU3/9bknXZIg6
 uaCW5MNKMwLTxBNEj9V7xmJMnWGuxzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648462760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMFFArrnppYp3jhmmGfpqWKMmrq/zQZgpH9Qz8FYSUw=;
 b=ggA5kLe5Qn2tz3vACUKyqkGWa9t215IMhFCJDN9UsXot5nfWyTTGR01YMu0SbPzondyFIy
 92RXAey3mAwLhsDw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 44F24A3B93;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 3DD2B51939C3; Mon, 28 Mar 2022 12:19:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@fb.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.com>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/10] nvme/rc: add more arguments to _nvme_connect_subsys()
Date: Mon, 28 Mar 2022 12:18:50 +0200
Message-Id: <20220328101855.73975-6-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220328101855.73975-1-hare@suse.de>
References: <20220328101855.73975-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_031921_913360_CA6CA0A5 
X-CRM114-Status: UNSURE (   8.23  )
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
index 6e08b41..663d597 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -188,11 +188,27 @@ _nvme_connect_subsys() {
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
2.29.2


