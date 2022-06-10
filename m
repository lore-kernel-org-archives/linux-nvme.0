Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505C7C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jun 2022 11:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+Dt5HrQjdSHkAHLp/TCArZkpK3Lqzo0uHbCYE3lXM3Y=; b=G94LEXbF1ASRGIkIltmstG+oYv
	7cg6/NKmjnm/XZbmQEv/67j0pJw6GMW0FUy20tHjTZ542Nsrfc9Xy6LrHzI9GiAxP5Pm5n9bwdusP
	VrkVy0H4AdlOiLw8cN56Pm/vakRAKwxy1xxNRnbrxvErHzhBKU17wR7D8WWOdo1WmR3cE7eL3LwCy
	ABG23B1Lm8ZOVH2ceKJUvGXeQ3y+wFNM0emzx56LJU28Q/5sMtfDCzo0uHcKU0vKu3Lv/Nt9Eywac
	PGJmJPqld0b53AIXjLk5kHmvfizOSBsLlyAap+rESfQr8yfbCGdjzqi1vX//oUSFVbmE3F7EgTuXi
	bCpS1aOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzctg-007vor-Na; Fri, 10 Jun 2022 11:33:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nzctT-007vin-3W
	for linux-nvme@lists.infradead.org; Fri, 10 Jun 2022 11:33:41 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id CE9421F98B;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1654860813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Dt5HrQjdSHkAHLp/TCArZkpK3Lqzo0uHbCYE3lXM3Y=;
	b=hojalCfqJDAtK7jK61VBang+AvkeiuOYlheok12vVQ+WmTPEpJ/4GhirFj957K6s9VVUut
	61XXzL80qFoMK4cy/X2Zrhz5MNIyY38viKBXS/Ov1OWEx6aNF4dqunfYXaPCh+W8K4dR3y
	d0U6wCCqfhbqaCS/Fn26YTjQHNr8T5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1654860813;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Dt5HrQjdSHkAHLp/TCArZkpK3Lqzo0uHbCYE3lXM3Y=;
	b=5NWzVjEvaDiKJseP5QyMyLpCEsaWoRvkVt7/ygZ5jHHqP9YTqsJT9FQ+89jWiMxwBKwEHB
	QVGOv+/KUlO9RbAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id A6C952C145;
	Fri, 10 Jun 2022 11:33:33 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 9776F5194A3C; Fri, 10 Jun 2022 13:33:33 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 03/10] nvme/rc: clear hosts directory in _cleanup_nvmet()
Date: Fri, 10 Jun 2022 13:33:17 +0200
Message-Id: <20220610113324.10294-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220610113324.10294-1-hare@suse.de>
References: <20220610113324.10294-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220610_043335_399318_9C033086 
X-CRM114-Status: UNSURE (   8.11  )
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

When clearing out the configuration we need to clear the 'hosts'
directory, too, as scripts might have added host configurations.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 tests/nvme/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 454609a..cc48802 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -124,6 +124,12 @@ _cleanup_nvmet() {
 		rmdir "${subsys}"
 	done
 
+	for host in "${NVMET_CFS}"/hosts/*; do
+		name=$(basename "${host}")
+		echo "WARNING: Test did not clean up host: ${name}"
+		rmdir "${host}"
+	done
+
 	shopt -u nullglob
 	trap SIGINT
 
-- 
2.26.2


