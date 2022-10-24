Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4504C38A2D
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 15:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oCPF+FD9jiffBw0NtRD29UzmjHy8C95fMf0S82lcDuM=; b=FxQFI2WkD8GtfNNujAaQOiqtYN
	5ZWczjFe75sL77Ezx/TOmGdL+ImBsFH6ROqCeidU3IOI+qIlRLRwTmcUWyd+yIycqs9xQkTpx4IRl
	1aMAa5f5f/4/603GjDEh4VYozxHlYUOgQJI2CP3ozcjevklUjqpcD80WAE9PBeGd4KG90LsAlw3kz
	nKJinFOJRtWRlneihwtlv9Y5Rn+z+MUcWv3PYqAdGYvR6W0tGdBOTc2vtHtvQBNAbJR2UOsr6nTPi
	ATKCQKA5pwJm0yvogEq+p12oHCpM5DZLDLdM99EtOiRsIfWsAr2hgUAFg1bDEUYfxX/K5rN672rd5
	40tayaIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omyza-0022aJ-P3; Mon, 24 Oct 2022 15:03:54 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omyzX-0022W6-Oz
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 15:03:53 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC5EF1FD8F;
	Mon, 24 Oct 2022 15:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666623822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oCPF+FD9jiffBw0NtRD29UzmjHy8C95fMf0S82lcDuM=;
	b=faxQ0cYUGHiVZC22tnQCPnZxUfq4aTao49W/Plz98SKImdVxJ32jIGJygLHJpVFRJ8LBhs
	zgDfPj/2C4aVhtlxofzNRXbpgtCuw16OkRxRpyv2zB/ros0CscGP21JzbxzLU+OqxvOHWx
	gtbj5RSFgk0BRcx4+DBXHm3IDe6+z6Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666623822;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=oCPF+FD9jiffBw0NtRD29UzmjHy8C95fMf0S82lcDuM=;
	b=uBg78yt41R+VlkMIadU0NZCnZe86SJuF4HHMbgHEt3AfC8zXe2n1DMycYDipxZMHZ5SLvC
	UeHHoa4gcTm1bgCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE57513A79;
	Mon, 24 Oct 2022 15:03:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id M61UMk6pVmMTNwAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 24 Oct 2022 15:03:42 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2] nvme-tcp: send quota for nvme_tcp_send_all()
Date: Mon, 24 Oct 2022 17:03:34 +0200
Message-Id: <20221024150334.29215-1-dwagner@suse.de>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_080351_981221_6989CECB 
X-CRM114-Status: GOOD (  14.19  )
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

Add a send quota in nvme_tcp_send_all() to avoid stalls when sending
large amounts of requests.

Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

IMO, this patch might still be a good idea to add. At least in my test
setup where I only have one ethernet port it makes a big difference
when accessing the system via ssh. When nvme-tcp is pushing a lot of
data via the network, the ssh session is completely blocked by the
storage traffic. With it, the ssh session stays responsive.

I suspect a proper storage setup would use more than one ethernet
port.

Daniel

v1:
  https://lore.kernel.org/linux-nvme/20220519062617.39715-4-hare@suse.de/

 drivers/nvme/host/tcp.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3e7b29d07c71..84a66ca208c8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -308,12 +308,23 @@ static inline void nvme_tcp_advance_req(struct nvme_tcp_request *req,
 
 static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
 {
-	int ret;
+	unsigned long deadline = jiffies + msecs_to_jiffies(1);
 
 	/* drain the send queue as much as we can... */
 	do {
-		ret = nvme_tcp_try_send(queue);
-	} while (ret > 0);
+		bool pending = false;
+		int result;
+
+		result = nvme_tcp_try_send(queue);
+		if (result > 0)
+			pending = true;
+		else if (unlikely(result < 0))
+			return;
+
+		if (!pending)
+			return;
+
+	} while (!time_after(jiffies, deadline)); /* quota is exhausted */
 }
 
 static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
-- 
2.38.0


