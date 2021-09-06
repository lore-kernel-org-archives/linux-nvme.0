Return-Path: <SRS0=/f9n=N4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528B1C433F5
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 07:04:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 098C960F6E
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Sep 2021 07:04:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 098C960F6E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=eMekNoC4YjV4uhRwSBRL3fEWlsSysuxhCNtb/K7xVkQ=; b=p+wA2lCjkAmFT3
	A2F0EeGhYT3Qooxu6vCrZtKeEvcd6RvHMMIzNfQB8OC7bBLIxzESTsu0rjrZ8dhtond1yCTkrHqY3
	hlHvIaFdCm3Keu76QD94UfmUrlBKN8tyVE9YFE8SkQwkO1aMYUmxFzp7cDpXelsljVLVCUhlrcZ3/
	oSx39y5BbVlWYjLE2jI6ga+K6yKYe5kfVsxK8G7gVUOQMtmox6BuzZwVsjR2i4Rp5gYYuAjzfMbqV
	pUKrFotBweGpGrQ3uqds9jHYvWDtTpdoR75C9791ex6MW3nfPpQOeKIQpRZqw3t1OvIljthb3K4TQ
	I1rcE2iUsXuqY1J0kFmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mN8fp-00HUwg-9X; Mon, 06 Sep 2021 07:04:09 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mN8fm-00HUvs-Av
 for linux-nvme@lists.infradead.org; Mon, 06 Sep 2021 07:04:07 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 0607022105;
 Mon,  6 Sep 2021 07:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1630911845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ltCRmfxPeZUL8HfWdCWL5pbBTJ4uUixm3BCrlyNepf4=;
 b=qTnGFqqRRTvHQ4gd5CWF5EV9hc2MapcxEWkNYO86IU/AQV/v6w+gKCYaGLkeqJQTokp6qn
 BQMCmGKfLs8VLi3Bzs9q2DJXIrvQCkObQYKPuDUmWa7lop9FTruwIM9iJ6fT94B2Cy08/f
 fqU2MbIOe8xitnU4I8concdD+gzQOZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1630911845;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ltCRmfxPeZUL8HfWdCWL5pbBTJ4uUixm3BCrlyNepf4=;
 b=h8HhYe4iryWz6X8c/XhQ7cDgF6fF7cZ7ABH+h2hyQBDnQoelqHACRBphjCx69uTKpll0qD
 XqliADSDylxehTAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id CDF0DA3B8E;
 Mon,  6 Sep 2021 07:04:04 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id C18BC518E10D; Mon,  6 Sep 2021 09:04:04 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2] nvmet: fixup buffer overrung in nvmet_subsys_attr_serial()
Date: Mon,  6 Sep 2021 09:04:03 +0200
Message-Id: <20210906070403.28159-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210906_000406_566853_6E605880 
X-CRM114-Status: UNSURE (   9.98  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The serial number is copied into the buffer via memcpy_and_pad()
with the length NVMET_SN_MAX_SIZE. So when printing out we also
need to take just that length as anything beyond that will be
uninitialized.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 008be02fbac9..49f85e829c4a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1113,7 +1113,8 @@ static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
 
-	return snprintf(page, PAGE_SIZE, "%s\n", subsys->serial);
+	return snprintf(page, PAGE_SIZE, "%*s\n",
+			NVMET_SN_MAX_SIZE, subsys->serial);
 }
 
 static ssize_t
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
