Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83ED8C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 06:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TDj/DsY6ftY5pTSVXUjMAr5NG/KeLZjWJsjXPLSPRS0=; b=v/0Ak99c9J4XnqYkBQF3MifvJ6
	bqZPaua/vIWIcA9g7MOFsV6v4LR5z/ZBs0LZ+aRIVT0R8hBGBMGFBgfU4G2sZAARl+ro/JYVioCby
	4VRzHBmSVBdKjbbCnT1mf3YyLQD4X/Jubc+e9YP/d9yibQV05dGDyk92CON8D1xp1fCCahmd/2FDn
	BaqnMKM+oDavMp9XQxwht+1wy+0m1/4j8KLd5fsZEuKi2L/AzBSfKdNLHy0GsbAaoPgTdWFuDByuw
	CIStxyKND7/MsznhZLuazWIRjYq29YmNo7BydiHMMdZbYKWf0/Ux55LAUXBHD3dZsKGyl8WqdhF9K
	x6uFIH7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrZcC-005HB7-VB; Thu, 19 May 2022 06:26:28 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrZc9-005H8l-6R
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 06:26:26 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 602911FA0B;
 Thu, 19 May 2022 06:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652941581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDj/DsY6ftY5pTSVXUjMAr5NG/KeLZjWJsjXPLSPRS0=;
 b=XeAQma14T6SR7+CiKDb68QH0hx2QpJvgUO5r7GV46hT79F2hTQPdfRoiH0XdyC8nRz4THz
 I/Gfsse8p1RL+ge/wiRyZ3TULCFCx7obNi0ic6QvfjerO2T6uUuupwIEogP8AxezWBiDyE
 7B53enFfLuPsQSPcajTd4Ht6RphQSiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652941581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TDj/DsY6ftY5pTSVXUjMAr5NG/KeLZjWJsjXPLSPRS0=;
 b=Z5TnBwsFCuxAmEQrMZjUo3SksZp16KbHtFBx2UnMTZc1ny+C7vawyjeccQRz0qTr8njNAi
 QAFhgjaCl9epCgAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 534952C143;
 Thu, 19 May 2022 06:26:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 81AF55194539; Thu, 19 May 2022 08:26:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/3] nvme-tcp: Check for write space before queueing requests
Date: Thu, 19 May 2022 08:26:16 +0200
Message-Id: <20220519062617.39715-3-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220519062617.39715-1-hare@suse.de>
References: <20220519062617.39715-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_232625_490378_D837A90D 
X-CRM114-Status: GOOD (  10.62  )
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

The current model of always queue incoming requests lead to
write stalls as we easily overload the network device under
high I/O load.
To avoid unlimited queueing we should rather check if write
space is available before accepting new requests.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ede76a0719a0..606565a4c708 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2464,6 +2464,9 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(ret))
 		return ret;
 
+	if (!sk_stream_is_writeable(queue->sock->sk))
+		return BLK_STS_RESOURCE;
+
 	blk_mq_start_request(rq);
 
 	nvme_tcp_queue_request(req, true, bd->last);
-- 
2.29.2


