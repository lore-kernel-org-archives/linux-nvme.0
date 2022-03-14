Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B88CC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Mar 2022 10:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8J3TkMlhXxxs522kZNQUyh06Nl8jtdyuEfPoHe/8YDQ=; b=aBFmJwsTNQ6TC0M7J+H7IsSCuv
	jfxD6kDbgTylVyXbdsoGNKd7vOsFCfa+sBevbSro0zoNGMukITp8b6Egy8Ho//ITe0CVtlBkdbExb
	mNZ6kL/8fbdVwnlY6fOciVwerBQsLogEV+PjKMx4r5D3nl4csgMkxnchxeOGq2rvYPfkiVMKsjog1
	YjkvSS2jL5asaFesuhPsnAYfqm1IPxAr5aSst5Asz4jJkLq032TKTYJTooj0jc/4bRyv6Qh+FCVZs
	1FBiExmB0g1WXlCkEMfNNfuCG7R+OO1M5MiWBZmYd/5HVPGeuDjpGGsQGHkp7SBU1VOKToNujZ0f4
	8TlLxpyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTiKv-0053BU-59; Mon, 14 Mar 2022 10:54:01 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTiKX-00531j-Lc
 for linux-nvme@lists.infradead.org; Mon, 14 Mar 2022 10:53:39 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5396321900;
 Mon, 14 Mar 2022 10:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1647255215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8J3TkMlhXxxs522kZNQUyh06Nl8jtdyuEfPoHe/8YDQ=;
 b=cXE/Iew7Doi70MpxjoUlQiXRD/LG1vecY6dfdJba4xSXv0OF67Nhc8WpPTuZWHCvsrSniE
 XJRp3Dbn928sXL7G9WJC4oc76oTgi5m7JZ/iaJw7fLjKXr+86nFfVL4njjM+YXoPgxW7++
 yQ4kCAZVhYS+EAC8HxWJIQ9STQwukjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1647255215;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8J3TkMlhXxxs522kZNQUyh06Nl8jtdyuEfPoHe/8YDQ=;
 b=qH7WNSu6Kufp4ivmCuMVDurrhXqf4PkM2BLFM6bPKC54y9aeJF7HuGbVsdIyd+vKooTYUS
 +S+6IiueE5l5SiAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 2334BA3B88;
 Mon, 14 Mar 2022 10:53:34 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 58ED651936B1; Mon, 14 Mar 2022 11:53:34 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/3] nvmet: do not allow to create a subsystem with the
 discovery NQN
Date: Mon, 14 Mar 2022 11:53:33 +0100
Message-Id: <20220314105333.56714-4-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220314105333.56714-1-hare@suse.de>
References: <20220314105333.56714-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220314_035337_914041_C9853170 
X-CRM114-Status: GOOD (  11.67  )
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

configfs will only protect us against duplication of subsystem NQNs,
but discovery subsystems might have two NQNs, the standard discovery NQN
(which will be used as the configfs directory name), and the additional
unique subsystem NQN.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 58124abdbf62..617ab027ae2f 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1434,6 +1434,9 @@ static struct config_group *nvmet_subsys_make(struct config_group *group,
 		return ERR_PTR(-EINVAL);
 	}
 
+	if (sysfs_streq(name, nvmet_disc_subsys->subsysnqn))
+		return ERR_PTR(-EBUSY);
+
 	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME);
 	if (IS_ERR(subsys))
 		return ERR_CAST(subsys);
-- 
2.29.2


