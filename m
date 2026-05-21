Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B1FCD5BAC
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 15:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sxBcn2zVAegJxcpLqdsi427uF5vH4pdkVEZlrDZRZo0=; b=jcDiRBYo6nbHEIhB1JYI8nowfO
	CQN4sZVW9jX5jPDI7QNP+U5j05Vvl77DbH/Vfx+8DtKNKp4lfjE033p5eUXHOhS5444QJEcL0HqQW
	C2uia2LbVjPlJoNHpvueBT8VcLI6Y+turXgkpHWeLypZ6IyzwPdu8qzIW3Yu+OEOFWraUFnw0mVWD
	AlOdTs135WfjBlbCDReNzNUwJ8NtPdhXtIiawLBdqyheThWKVuqtegriDgkQfH0kic16gu8Ds73RR
	u3R3SMSzxIpFLWlIGhnjAVrpzEwxqyVI2wjwm8JYGzhYVaF22oJB91QV9ooPwT+NRyvHqZRkuz6/u
	fUuUFvXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ5Sn-00000008LaC-1dBL;
	Thu, 21 May 2026 15:37:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQ5Sh-00000008LXN-2dyx
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 15:37:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779377846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sxBcn2zVAegJxcpLqdsi427uF5vH4pdkVEZlrDZRZo0=;
	b=KH4fb9jn15WI1idHAftAWA9xBL//T/CV2/VqZfI0mmsuBdM1GTeYPrUbLg5qr2PKobTg4Q
	NFko0t4yFTUl5ywfqe4s9/CoPbcYgicI2guuD+PYaeCc7jECafDoatw97EerdbuLZrSUMg
	Rroik5X+34dcfijBbVKzaLroMzJTkUE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-cTMS_sgKPrejRM9IMsRI4A-1; Thu,
 21 May 2026 11:37:24 -0400
X-MC-Unique: cTMS_sgKPrejRM9IMsRI4A-1
X-Mimecast-MFC-AGG-ID: cTMS_sgKPrejRM9IMsRI4A_1779377843
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 963FB1956059;
	Thu, 21 May 2026 15:37:22 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.48.57])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AA44E180056E;
	Thu, 21 May 2026 15:37:18 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: dwagner@suse.de,
	mkhalfella@purestorage.com,
	hare@kernel.org,
	hch@lst.de,
	mlombard@arkamax.eu,
	linux-nvme@lists.infradead.org,
	error27@gmail.com
Subject: [PATCH V2] nvme-core: fix unsigned comparison warning in nvme_wait_freeze_timeout
Date: Thu, 21 May 2026 17:37:16 +0200
Message-ID: <20260521153716.548351-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bWZ-X9OtYJNt_JPklp4AlaHb12td6Xz8T_L14sS53Dc_1779377843
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_083727_744407_84408DDA 
X-CRM114-Status: GOOD (  11.04  )
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

The timeout variable in nvme_wait_freeze_timeout() is an unsigned type.
Checking if it is <= 0 triggers a compiler warning because an unsigned
variable can never be negative.

Fix this warning by changing the type to long.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202605211257.STzj2Ujv-lkp@intel.com/
Fixes: 23b6d2cbf75f ("nvme: remove redundant timeout argument from nvme_wait_freeze_timeout")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---

v2: keep the <= comparison, change the type from unsigned to signed long

 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 72c50d5e938d..554649ffe430 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5246,7 +5246,7 @@ EXPORT_SYMBOL_GPL(nvme_unfreeze);
 
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl)
 {
-	unsigned long timeout = ctrl->io_timeout;
+	long timeout = ctrl->io_timeout;
 	struct nvme_ns *ns;
 	int srcu_idx;
 
-- 
2.54.0


