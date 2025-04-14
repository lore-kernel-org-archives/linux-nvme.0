Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FFF7C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WcVKOa6uzKjWcfjGyX6N8w7ZHTDNC2bLoxQEbomEtcY=; b=Mace6vadJW6hM5iowJlu2WiJvp
	VDRuPIy42AKnfFM9k2uEGMkGWVtzeDVYiS/9uVqA6nxXiDI3k7J/oDOetm+Uc2TRZ7sZ6VfePmILT
	V9FdfeMLsb+JeejbNQhfhFF5unNOtUgSm7y6r09sxjBrac2WacJdRk0JHtEilVlNIA0UJrOVP6HTj
	1SsERhmcXD0YorgZD+fsIEdYWSsChxdARy4qeG3o+U3DZqKo6tlugR+sr1kvJdATX5Ofb0wovcy9N
	cJqt2o1AAbGlEdHHP3KPmXBhtz4n9lczMbgtf27LnMJa9A5ggjkbfEHL7GcwV7XXH7Cl+JjqzKFMZ
	ECnaMN/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jur-00000002AU1-3NwQ;
	Mon, 14 Apr 2025 13:32:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Juq-00000002ASK-2DwL
	for linux-nvme@bombadil.infradead.org;
	Mon, 14 Apr 2025 13:32:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=WcVKOa6uzKjWcfjGyX6N8w7ZHTDNC2bLoxQEbomEtcY=; b=odqbdVTVFmtoO/2+0CIUY8fLo8
	QUNhJMXtGdZMPjn65ppqo20CJd9eCVeXkdBpJ3+bg3GDg5KK/9gr3Os/i+jlDlAeawkw/PA3V5G2x
	zAqGzSpyFICiznF6+rzmNv/tyRRGd1KlnQNEGHgDWJ02Qrc4YWBulTTbe+buPGYTLGMIUHZPEp6yl
	X/WJKetogCPaBYQpjY9jxfrOpMQ6dnweVKRbhrtniidDJcu7lByovSapgNIllU852WEhfwTmwVLLa
	5utHrsUE+KpZIyEsQwX4OUSEM586SSnXRWX8PCQatqkH0jDxixRW/TgEV/fIK74scacNjq0lX4jX6
	T37tIJXA==;
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by desiato.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u4Jun-00000009hK6-2Ubm
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:31:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1AC4CA49E80;
	Mon, 14 Apr 2025 13:26:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81C8C4CEEB;
	Mon, 14 Apr 2025 13:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637516;
	bh=Kt7NhyquizgXgPlH6ZDGEhzHM6pEp1YYaxQTCPWhVnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGB0Tx+6ypmGEDsL4S/Ofuw0inMvUzfnKjNv6xyh7jQM9m5bVoeIuSRefXGpwUCLO
	 ARD2o9FJUGlPU9mdn5vIFRM4i+t2WPYLnIDVG/TQo6LdZGDQluNt9CVJFZHksITa8r
	 XL21f3zB0RWMvEYL1VlSOJeh7U5qusqtpVbsi7ZCpdgW9svUNUUj70VyugbKuBetuv
	 nBkR4v8/a1wPrpdeBnbaU7zn5esHbs5R24gL6tCpXgF+XCSZQ11hmGigoTphrWsaib
	 10twjqi+l0E+0NcfnmrafLk4gmSx5j1zD4FXCdCLaNP8A3wZTQDIrq+dPG/L19HSUW
	 rxwJwZzwDbWoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 14/15] nvmet-fc: put ref when assoc->del_work is already scheduled
Date: Mon, 14 Apr 2025 09:31:24 -0400
Message-Id: <20250414133126.680846-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133126.680846-1-sashal@kernel.org>
References: <20250414133126.680846-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.180
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_143157_880777_42C8F2F2 
X-CRM114-Status: GOOD (  10.69  )
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

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit 70289ae5cac4d3a39575405aaf63330486cea030 ]

Do not leak the tgtport reference when the work is already scheduled.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 606fdde21d629..3fb51fef64733 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1105,7 +1105,8 @@ static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (!queue_work(nvmet_wq, &assoc->del_work))
+		nvmet_fc_tgtport_put(assoc->tgtport);
 }
 
 static struct nvmet_fc_tgt_assoc *
-- 
2.39.5


