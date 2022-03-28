Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C12EC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 10:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=txgVtOYe8itrttqCBTGEOY4AR6fYy1qjlGff0NfMl7s=; b=Cyaw1zv8L8SiFL9OJlqvukJ7O2
	pqVdbEGkZ5rofijbTjuj3XAvzh69MrmdAf0ec63oJDcQqgA/h8RA/caAwKMoGjr2hQknd5+FW1pvV
	UEARYGSiraVo4dns2wPkyYxCx0fqMfweJ2ZUuo4Z9EXtJ961yaaLcYqAlFyr7Nd00USXrWCq+LG+b
	y85aMWucfCT2TuZo+O04o57mXmB8ZAqYv4jP21TJyxAvERqexADm7XPyFUnMxPstzWjgpsLu1I7+F
	gZS1HRGpQgUHiRdJNbnznQp1Pz0fi/ZurC71URh0pEoA/UQO9/uS45TdwbzwYj920Dk5glDnQnDro
	zmXlNfIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYmTf-00899I-FH; Mon, 28 Mar 2022 10:19:59 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYmT3-0088uW-O2
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 10:19:26 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 48E69210EE;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648462760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txgVtOYe8itrttqCBTGEOY4AR6fYy1qjlGff0NfMl7s=;
 b=fIkc9bZHv8sLvwv2WRgwqxy4Sm3TtxKopegAQilt2dY5oYlBCxmqsOAzCc1yTeHbcKRw7a
 F3EDxd8qG3Ec+6yLnI/mTjZfIKv4BVir+SJm/qJskfeJ5DfKYA0XGU1wFjJEk3tBlaLapL
 jGoxzajxFHYWO8y/GCe7FMs5cbeNgSA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648462760;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txgVtOYe8itrttqCBTGEOY4AR6fYy1qjlGff0NfMl7s=;
 b=Q8M+JT58NE55ZXyJi05m91kr9HGu54gCoH3wvEMTIIdoD4C2TrnzN72E5SOUQqqUEN2ib/
 adbZen1ENA/CFrCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 3922AA3B89;
 Mon, 28 Mar 2022 10:19:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 2A10D51939BB; Mon, 28 Mar 2022 12:19:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Omar Sandoval <osandov@fb.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/10] nvme/rc: do not print error message when no nvme device
 is found
Date: Mon, 28 Mar 2022 12:18:46 +0200
Message-Id: <20220328101855.73975-2-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220328101855.73975-1-hare@suse.de>
References: <20220328101855.73975-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_031922_110956_F2E223EA 
X-CRM114-Status: UNSURE (   9.48  )
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

_find_nvme_dev() will only print an nvme device node if one is found,
so no point in printing an error message.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 1c27cde..086c094 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -306,6 +306,7 @@ _find_nvme_dev() {
 	local subsysnqn
 	local dev
 	for dev in /sys/class/nvme/nvme*; do
+		[ -e "$dev" ] || continue
 		dev="$(basename "$dev")"
 		subsysnqn="$(cat "/sys/class/nvme/${dev}/subsysnqn")"
 		if [[ "$subsysnqn" == "$subsys" ]]; then
-- 
2.29.2


