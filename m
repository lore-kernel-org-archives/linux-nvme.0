Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8974DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 09:28:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510CE610F9
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 09:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 510CE610F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2ffDlONIeFgopBjFibqJahp4l2QZDKCPB4ORdwRGmfw=; b=b8gVIsutyaR8LsO6lXO2i8K24/
	/EQ5eNfz17IEOhqNp820d5W4RV2AA1KyZHOYo+rgnyvtj88SrbBaI9c4Ef2VJmLHnhZOfDhbwZw/A
	fwTaDsc06+gg6mdExEv6FZxdMke/gNaiAU53frgpDUuPnqVTGVrhy6n5cM9nFIiiR42KpSEOOIgMn
	ZHoamJb5dMyRlCFGKdsUs9pmbsSIDEyH6bSCSVhRVyXI4xWCoj1HpFVgJyJhaZc1QgW+WQSflE0V1
	AlBbEBgcrgBkIx4gG19v6nevF8QgT1gX8Y+PJGb7E9WZWQy2VddQXmGzy/ccK7Nbq0VbfFDfWgzwF
	a4JCcHbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1max1a-002MNg-VQ; Thu, 14 Oct 2021 09:27:43 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1max1Y-002MLt-Dd
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 09:27:42 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 1BB281FD29;
 Thu, 14 Oct 2021 09:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1634203656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2ffDlONIeFgopBjFibqJahp4l2QZDKCPB4ORdwRGmfw=;
 b=K7qScX8aKGS57Nfs+EK65uAMgLXtOotTBNynQldRTA+4T5y4aS1vucmtcxQtWdE3lGMchE
 Hv9Y6vgYMMjpHeCURH9zoAkQw/P7L7QLCffEXoPwjK/CUa9UL67ZJQJS326YotdUnh5gC9
 Vyarev7TLOIb++tgq93lkGVgVyTHNTg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1634203656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2ffDlONIeFgopBjFibqJahp4l2QZDKCPB4ORdwRGmfw=;
 b=+UJ7lfLPbTbQoVTjYkmc1mZYOcCgiPdIO8GSsoeEY8yUQ7dZfe5i2emIGqpMUZ/uBR+M/r
 Zs2OALX7LOWOT7Cw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id DC7D0A3B84;
 Thu, 14 Oct 2021 09:27:35 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id CBAA3518F7AC; Thu, 14 Oct 2021 11:27:35 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Daniel Wagner <daniel.wagner@suse.de>
Subject: [PATCH] nvme: rename 'subtype' attribute to 'subsystype'
Date: Thu, 14 Oct 2021 11:27:34 +0200
Message-Id: <20211014092734.138079-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_022740_654732_D972244B 
X-CRM114-Status: GOOD (  10.17  )
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

The sysfs attribute should be named 'subsystype' for consistency.

Fixes: b72529169a56 ("nvme: expose subsystem type in sysfs attribute 'subtype'")
Suggested-by: Daniel Wagner <daniel.wagner@suse.de>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f9a25c61fb8b..4d676b5db413 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2599,7 +2599,7 @@ static ssize_t nvme_subsys_show_nqn(struct device *dev,
 }
 static SUBSYS_ATTR_RO(subsysnqn, S_IRUGO, nvme_subsys_show_nqn);
 
-static ssize_t nvme_subsys_show_subtype(struct device *dev,
+static ssize_t nvme_subsys_show_type(struct device *dev,
 				    struct device_attribute *attr,
 				    char *buf)
 {
@@ -2615,7 +2615,7 @@ static ssize_t nvme_subsys_show_subtype(struct device *dev,
 		return sysfs_emit(buf, "reserved\n");
 	}
 }
-static SUBSYS_ATTR_RO(subtype, S_IRUGO, nvme_subsys_show_subtype);
+static SUBSYS_ATTR_RO(subsystype, S_IRUGO, nvme_subsys_show_type);
 
 #define nvme_subsys_show_str_function(field)				\
 static ssize_t subsys_##field##_show(struct device *dev,		\
@@ -2637,7 +2637,7 @@ static struct attribute *nvme_subsys_attrs[] = {
 	&subsys_attr_serial.attr,
 	&subsys_attr_firmware_rev.attr,
 	&subsys_attr_subsysnqn.attr,
-	&subsys_attr_subtype.attr,
+	&subsys_attr_subsystype.attr,
 #ifdef CONFIG_NVME_MULTIPATH
 	&subsys_attr_iopolicy.attr,
 #endif
-- 
2.29.2


