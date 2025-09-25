Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35604CAC5B1
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Sep 2025 17:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A2qJ3u9F3WYpp3Qx7MbbugDMzN7PLrs8CIX1/6KerXA=; b=wVbCjGNHkX8gggab/78wvxGqG9
	I2A3a8puzGfVsYTX4y5EsOE2fo72c/6F6CCq0pXJzxA+xF3hoVBx2Hpyqa01tUsEYR7BQGVErWbWK
	NfQ+VyT2sh7a/U1nDCwX8JFQtoOancSyy2TDmnvh/8eaYOO6u5o6QLNcDCCplT+q/jzunJ6hbl/LK
	IQngSX14Sc0JwH0nZ/faoAeyeLyNM0TFvOZKptOJhRWeGC6tGfqS2Clk9BjONW2m1A38ZSGUVrgwo
	zBwOAAIdxR4Fx48Y1piFjEZIR7nd8/XFleTrbq5yKm1/JxtYokonMZ3+/dmWVIaVRIVNqGHRbbtcQ
	FPDMduiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1pOJ-0000000BN5U-0SNw;
	Thu, 25 Sep 2025 17:04:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1pOF-0000000BN2l-0n2l
	for linux-nvme@lists.infradead.org;
	Thu, 25 Sep 2025 17:04:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758819857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A2qJ3u9F3WYpp3Qx7MbbugDMzN7PLrs8CIX1/6KerXA=;
	b=VyYYN6THWepKXjTSVoffGCWNyul/MDMfN68QWNlgwQvuZI2UsKFvSCqI6jtBp27NzIL2FU
	zy+O3oA4RBMhmFxvBd5vnOeKQYONz8q2Q5PgG8QG+XUZ5nWl3So0hvZ80ZL/dVpJAAxlgF
	WAR/ybeqOccCgplzqQ/C6Q8qtUU6o10=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-hDWnK08sPC-P-6jFGEozZw-1; Thu,
 25 Sep 2025 13:02:39 -0400
X-MC-Unique: hDWnK08sPC-P-6jFGEozZw-1
X-Mimecast-MFC-AGG-ID: hDWnK08sPC-P-6jFGEozZw_1758819758
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E6CA018002D1;
	Thu, 25 Sep 2025 17:02:36 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.44.32.119])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABAD7300021A;
	Thu, 25 Sep 2025 17:02:29 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: james.smart@broadcom.com,
	njavali@marvell.com,
	linux-scsi@vger.kernel.org,
	hare@suse.de,
	linux-hardening@vger.kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	bgurney@redhat.com,
	jmeneghi@redhat.com,
	emilne@redhat.com
Subject: [PATCH RFC] scsi: qla2xxx: zero default_item last in qla24xx_free_purex_item
Date: Thu, 25 Sep 2025 13:02:23 -0400
Message-ID: <20250925170223.18238-1-bgurney@redhat.com>
In-Reply-To: <fbbef12e-fc43-464f-b92d-f42f3692a46c@redhat.com>
References: <fbbef12e-fc43-464f-b92d-f42f3692a46c@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_100419_343295_01F336A6 
X-CRM114-Status: GOOD (  12.55  )
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

In order to avoid a null pointer dereference, the vha->default_item
should be set to 0 last if the item pointer passed to the function
matches.

BUG: kernel NULL pointer dereference, address: 0000000000000936
...
RIP: 0010:qla24xx_free_purex_item+0x5e/0x90 [qla2xxx]
...
Call Trace:
 <TASK>
 qla24xx_process_purex_list+0xda/0x110 [qla2xxx]
 qla2x00_do_dpc+0x8ac/0xab0 [qla2xxx]
 ? __pfx_qla2x00_do_dpc+0x10/0x10 [qla2xxx]
 kthread+0xf9/0x240
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0xf1/0x110
 ? __pfx_kthread+0x10/0x10

Also use a local variable to avoid multiple de-referencing of the item.

Fixes: 6f4b10226b6b ("scsi: qla2xxx: Fix memcpy() field-spanning write issue")
Signed-off-by: Bryan Gurney <bgurney@redhat.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 98a5c105fdfd..7e28c7e9aa60 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -6459,9 +6459,11 @@ void qla24xx_process_purex_rdp(struct scsi_qla_host *vha,
 void
 qla24xx_free_purex_item(struct purex_item *item)
 {
-	if (item == &item->vha->default_item) {
-		memset(&item->vha->default_item, 0, sizeof(struct purex_item));
-		memset(&item->vha->__default_item_iocb, 0, QLA_DEFAULT_PAYLOAD_SIZE);
+	scsi_qla_host_t *base_vha = item->vha;
+
+	if (item == &base_vha->default_item) {
+		memset(&base_vha->__default_item_iocb, 0, QLA_DEFAULT_PAYLOAD_SIZE);
+		memset(&base_vha->default_item, 0, sizeof(struct purex_item));
 	} else
 		kfree(item);
 }
-- 
2.51.0


