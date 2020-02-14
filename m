Return-Path: <SRS0=f2Gy=4C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A6FC2BA83
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 10:48:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA800206ED
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 10:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cogaGMU4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVLJtFrD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA800206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZxMus2EWufBimp7TmMOx8NRy1Iz9b4JSq4I0CuZMcYo=; b=cogaGMU4v0aQKY
	Jqt8uBd01tGpLB3I6LyN4L/uol1zg4ojyk72uJCmP27Ud12kJbJOyJmJd8weNc9SdVEAg10zO6dlO
	2N9GG95+/Mls7LWklw5dKm1oxiY7RqCWKYJv2fycVvHIae0/XXQ6nOQSgQC5IIWWdfUPjc3KhYuPK
	JIdgROQWa/kFJq2m2LxABC+7R7Mt5hWnKLfxHvuhd12yjCIRH5nWtZ7kFVfrVDboLrhuouLtvpP4C
	ZG+I842Ze/9URhSBZNAJyMuX/ESafv4MnPbjsbztFcid3bjqKJLDX6exJHOaBssZoAdi0gB8s7Bep
	KMwlllQ/5rmmZl4iXdHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2YWT-00032a-8n; Fri, 14 Feb 2020 10:48:37 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2YWQ-00032A-5t
 for linux-nvme@lists.infradead.org; Fri, 14 Feb 2020 10:48:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581677311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yenjNTLaCp+Oq/CurPl++sQjHS0vhkhDHXhrbIO9J4Q=;
 b=EVLJtFrDMx2/TDc4eL6TiG2spVBzf061hgMe+P7cRkfNBtTwcjtcpuClm2QHaQRNbM15E4
 +qxkqvLgJbTtCAJFXXwqHI10yGzo2UdCCaD222L8L1HbWV2Q/rWDlh2E1aTO+exU72e6Tb
 vut59fkcLUNKJoR3JVNjiElQNqHTzvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-d2vqe_G4P-e6lrpWsf8CTA-1; Fri, 14 Feb 2020 05:48:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0D718010C4;
 Fri, 14 Feb 2020 10:48:24 +0000 (UTC)
Received: from dhcp-12-105.nay.redhat.com (dhcp-12-105.nay.redhat.com
 [10.66.12.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6FE0C1001B09;
 Fri, 14 Feb 2020 10:48:22 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de
Subject: [PATCH] nvme: fix the parameter order for nvme_get_log in
 nvme_get_fw_slot_info
Date: Fri, 14 Feb 2020 18:48:02 +0800
Message-Id: <20200214104802.29209-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: d2vqe_G4P-e6lrpWsf8CTA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200214_024834_294767_E836A914 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: dmilburn@redhat.com, sujith_pandel@dell.com, emilne@redhat.com,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme fw-activate operation will get bellow warning log,
fix it by update the parameter order

[  113.231513] nvme nvme0: Get FW SLOT INFO log error

Fixes: 0e98719b0e4b ("nvme: simplify the API for getting log pages")
Reported-by: Sujith Pandel <sujith_pandel@dell.com>
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5dc32b72e7fa..641c07347e8d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3867,7 +3867,7 @@ static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 	if (!log)
 		return;
 
-	if (nvme_get_log(ctrl, NVME_NSID_ALL, 0, NVME_LOG_FW_SLOT, log,
+	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, log,
 			sizeof(*log), 0))
 		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
 	kfree(log);
-- 
2.21.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
