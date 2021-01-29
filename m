Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D18C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 05:25:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBF7D64DFF
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 05:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF7D64DFF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=94sm7BwiP1+f0AlVF50vQrFM77/BOlVxPER6f7F+Pxo=; b=ukY06/aZ21KnOub+IoY0Sa1r7h
	TmXno3K/n4qAN70Moe2DrpfHxax4nRk8uE1TyGhSaeL1p9PnXQe8VRY7VdpDk8CeNmmsT0QGW+KgY
	k06veZMwIU4/TvcZIZAelBAihIOcWXxTgYPNrUqCN7VsBg3YiX0rnFOaOdHqAyB1verIMywF3tAZm
	XyuVFLGlkgp8bepTn0Voy8xhMOMb9gKhTiVx10UhODMmL6JyI6YFEBEy0lJa7Qb01K64ftykkBYX1
	gpi5WYYwpTppMwkGAg63W5F7RHqLQN9sdNIDNhWTzVkLTiRxZdiPhDNt3jzjHtXG1fQi4El7Yz1wd
	rlToeBMw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5MHA-0008WF-4o; Fri, 29 Jan 2021 05:24:56 +0000
Received: from wp530.webpack.hosteurope.de ([2a01:488:42:1000:50ed:8234::])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5MH6-0008Vb-Sr
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 05:24:54 +0000
Received: from ip4d149f6e.dynamic.kabel-deutschland.de ([77.20.159.110]
 helo=truhe.fritz.box); authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 id 1l5MGx-0002RQ-9k; Fri, 29 Jan 2021 06:24:43 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-pci: add quirk to make Kingston A2000 SSD avoid deepest
 sleep state
Date: Fri, 29 Jan 2021 06:24:42 +0100
Message-Id: <20210129052442.310780-1-linux@leemhuis.info>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1611897892;05e96e2b;
X-HE-SMSGID: 1l5MGx-0002RQ-9k
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210129_002453_057970_8564C185 
X-CRM114-Status: GOOD (  14.24  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Some Kingston A2000 NVMe SSDs sooner or later get confused and stop
working when they use the deepest APST sleep while running Linux. The
system then crashes and one has to cold boot it to get the SSD working
again.

Kingston seems to known about this since at least mid-September 2020:
https://bbs.archlinux.org/viewtopic.php?pid=1926994#p1926994

Someone working for a German company representing Kingston to the German
press confirmed to me Kingston engineering is aware of the issue and
investigating; the person stated that to their current knowledge only
the deepest APST sleep state causes trouble. Therefore, make Linux avoid
it for now by applying the NVME_QUIRK_NO_DEEPEST_PS to this SSD.

I have two such SSDs, but it seems the problem doesn't occur with them.
I hence couldn't verify if this patch really fixes the problem, but all
the data in front of me suggests it should.

This patch can easily be reverted or improved upon if a better solution
surfaces.

FWIW, there are many reports about the issue scattered around the web;
most of the users disabled APST completely to make things work, some
just made Linux avoid the deepest sleep state:

https://bugzilla.kernel.org/show_bug.cgi?id=195039#c65
https://bugzilla.kernel.org/show_bug.cgi?id=195039#c73
https://bugzilla.kernel.org/show_bug.cgi?id=195039#c74
https://bugzilla.kernel.org/show_bug.cgi?id=195039#c78
https://bugzilla.kernel.org/show_bug.cgi?id=195039#c79
https://bugzilla.kernel.org/show_bug.cgi?id=195039#c80
https://askubuntu.com/questions/1222049/nvmekingston-a2000-sometimes-stops-giving-response-in-ubuntu-18-04dell-inspir
https://community.acer.com/en/discussion/604326/m-2-nvme-ssd-aspire-517-51g-issue-compatibility-kingston-a2000-linux-ubuntu

For the record, some data from 'nvme id-ctrl /dev/nvme0'

NVME Identify Controller:
vid       : 0x2646
ssvid     : 0x2646
mn        : KINGSTON SA2000M81000G
fr        : S5Z42105
[...]
ps    0 : mp:9.00W operational enlat:0 exlat:0 rrt:0 rrl:0
          rwt:0 rwl:0 idle_power:- active_power:-
ps    1 : mp:4.60W operational enlat:0 exlat:0 rrt:1 rrl:1
          rwt:1 rwl:1 idle_power:- active_power:-
ps    2 : mp:3.80W operational enlat:0 exlat:0 rrt:2 rrl:2
          rwt:2 rwl:2 idle_power:- active_power:-
ps    3 : mp:0.0450W non-operational enlat:2000 exlat:2000 rrt:3 rrl:3
          rwt:3 rwl:3 idle_power:- active_power:-
ps    4 : mp:0.0040W non-operational enlat:15000 exlat:15000 rrt:4 rrl:4
          rwt:4 rwl:4 idle_power:- active_power:-

Cc: stable@vger.kernel.org # 4.14+
Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---

Once this is out I will post a link to it in
https://bugzilla.kernel.org/show_bug.cgi?id=195039, maybe someone there
might be able to confirm that this fixes the issue.

---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 856aa31931c1..421735e16870 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3257,6 +3257,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2001),
 		.driver_data = NVME_QUIRK_SINGLE_VECTOR },
 	{ PCI_DEVICE(PCI_VENDOR_ID_APPLE, 0x2003) },
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
