Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AAD6C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 07:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IMFFArrnppYp3jhmmGfpqWKMmrq/zQZgpH9Qz8FYSUw=; b=ZpZ6fjw17QLosgbCZkfJQAigMT
	+jgqdDyl9MusXIZbP4gXJC9e/4XdDYMRkBijIEkHk3DKbGFAqIGPAKVJTlM0Dva+/nMz6r49sFSJf
	xPxngCAwJJ1YHILWV/v5QNXnubBxXpPrbYAA2lhttvQe8PsQUZPmBQZRfBq5MZqCXnwcDjDNCJkDw
	ConzLvYG2svBykiM4vAj0AYUaYPN1agiKZgl6uUb4784xdAi1d8ioN6oQUEpz7+eLfVHxWvfvBSg9
	P8MdfzGsF8huOvo+eEyb/qdppLn1BdfQn/DEhB2yH94UrS3YpYGwisJKc1MgnPlUNKVEDrkE9ff1O
	D1gPXAEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpQaK-0017Bn-V1; Tue, 23 Nov 2021 07:51:25 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpQYp-0016hG-VV
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 07:49:55 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 2C78E218E1;
 Tue, 23 Nov 2021 07:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637653788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMFFArrnppYp3jhmmGfpqWKMmrq/zQZgpH9Qz8FYSUw=;
 b=JqU6/MUzlfbjIELNiFgovkHGwh05YHyRRUIbjkvPeC9BjqF0i5KGj6oZpRokqCptwOfQrR
 tv6I4+rCHQp5/GwGAF4TPDNyXA40b3j8c7+zYaeV0dJWitx9NYXV0Mrq0dqSCwYgo3t87e
 1M7smzEWB5YQg8PzwYFefF4mc8ACDDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637653788;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IMFFArrnppYp3jhmmGfpqWKMmrq/zQZgpH9Qz8FYSUw=;
 b=biiyDkygB6EWWsaLAQWKYBGgA5RRXV711Cep43+iALWW0gvJFleAOBJxDxs0L/GXx8gbJy
 Zi3ZtCWii4cJm6Aw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 1BA13A3B8F;
 Tue, 23 Nov 2021 07:49:48 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 270F5519188B; Tue, 23 Nov 2021 08:49:47 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.com>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/10] nvme/rc: add more arguments to _nvme_connect_subsys()
Date: Tue, 23 Nov 2021 08:49:35 +0100
Message-Id: <20211123074940.113390-6-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211123074940.113390-1-hare@suse.de>
References: <20211123074940.113390-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_234952_289122_D4645FCE 
X-CRM114-Status: GOOD (  10.14  )
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


