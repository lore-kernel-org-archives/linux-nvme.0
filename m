Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAFF3C47DAF
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jan 2024 11:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7ss+eoBN13IqXpY52+RqcTQNsBiI0HwcuEe49HGw+L0=; b=eDLwY4Y31uDC4TRGKEJz23hBzF
	T2PVgc9cC+9ByfvayY6g/F1lu6I+NMN1bl8Mmre3JY1qJTZLhWh6jtZzaC5Wr1g4ik+NYxiyOksCG
	cIUMKt50eW265XF9ujSdQDs5qSSL0gyUnaZWinY6/GlvXAB2BsVWhEELGZ+k6IBeKMOOOx/qi6rAd
	MpY+upCTilyEx929ELLhLm/oYTJqXPHU8F/5xMo4rc+f7oWvES5fIQJ6aqV5CrZCb9tmiaBs0ZtdQ
	aO6XWuM+q4mGBtZ664USrPMm/IOkcN8ShFBwpaNIS9GbNXQgttr+sAwxRWIJVODJHg3wkMENKbFMP
	S/iAinIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQQtT-002eqC-0q;
	Thu, 18 Jan 2024 11:49:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQQtQ-002epR-3A
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jan 2024 11:49:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705578543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7ss+eoBN13IqXpY52+RqcTQNsBiI0HwcuEe49HGw+L0=;
	b=Q9IZd8WcnzNQUkxYAqRgECkrbJWSszn38z8aOMxeuc3JidT5TbQI4Tisv0zFqFfi11ye7j
	Oi9nP7HBCfX4dN7cExZ1TUgbRhyElAatHZLy2jFIZYyHePSderv/l/fohEn+c6Yuz/FBWk
	NlU/tWkHw6U8uiu03xHjR30V8gKClcY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-iT0zfUZYOjeq6K6uZOBQMA-1; Thu, 18 Jan 2024 06:48:58 -0500
X-MC-Unique: iT0zfUZYOjeq6K6uZOBQMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5374983B86C;
	Thu, 18 Jan 2024 11:48:58 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 320EE200BC63;
	Thu, 18 Jan 2024 11:48:55 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: dwagner@suse.de,
	hch@lst.de,
	Niklas.Cassel@wdc.com,
	chaitanyak@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-host: fix the updating of the firmware version
Date: Thu, 18 Jan 2024 12:48:54 +0100
Message-Id: <20240118114854.672748-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240118_034909_109610_C4E94796 
X-CRM114-Status: GOOD (  16.55  )
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

The original code didn't update the firmware version if the
"next slot" of the AFI register isn't zero or if the
"current slot" field is zero; in those cases it assumed
that a reset was needed.

However, the NVMe specification doesn't exclude the possibility that
the "next slot" value is equal to the "current slot" value,
meaning that the same firmware slot will be activated after performing
a controller level reset; in this case a reset is clearly not
necessary and we can safely update the firmware version.

Modify the code so the kernel will report that a Controller Level Reset
is needed only in the following cases:

1) If the "current slot" field is zero. This is invalid and means that
   something is wrong, a reset is needed.

or

2) if the "next slot" field isn't zero AND it's not equal to the
   "current slot" value. This means that at the next reset a different
   firmware slot will be activated.

Fixes: 983a338b96c8 ("nvme: update firmware version after commit")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0af612387083..44b0f665d49d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4139,6 +4139,7 @@ static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
 static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 {
 	struct nvme_fw_slot_info_log *log;
+	u8 next_fw_slot, cur_fw_slot;
 
 	log = kmalloc(sizeof(*log), GFP_KERNEL);
 	if (!log)
@@ -4150,13 +4151,15 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 		goto out_free_log;
 	}
 
-	if (log->afi & 0x70 || !(log->afi & 0x7)) {
+	cur_fw_slot = log->afi & 0x7;
+	next_fw_slot = (log->afi & 0x70) >> 4;
+	if (!cur_fw_slot || (next_fw_slot && (cur_fw_slot != next_fw_slot))) {
 		dev_info(ctrl->device,
 			 "Firmware is activated after next Controller Level Reset\n");
 		goto out_free_log;
 	}
 
-	memcpy(ctrl->subsys->firmware_rev, &log->frs[(log->afi & 0x7) - 1],
+	memcpy(ctrl->subsys->firmware_rev, &log->frs[cur_fw_slot - 1],
 		sizeof(ctrl->subsys->firmware_rev));
 
 out_free_log:
-- 
2.39.3


