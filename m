Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC5DC433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Cf7EnMx4OWIW4fa613U+0/vJA7tFR1NEv0VW67tfL4=; b=jOqMFN2khSWtSZk6dX8vuqRUBl
	FtHm5PT/6Bwl/BGS6kYWaTaIrXXN4gmh6R7fG1g/xDnIsK6tTNRHYqY5iXjCPW84fJ3xzgHfFnRCr
	gvAUgRbpp5oLFk1yYVB3VinIQfxTEHiU4nJfQo3klsUhNKYlwMqRHKJEyL8vBsIpOGqfSDBBLOW7S
	+UhaFqQVa9OXoPbilEeyp3MkSUPt6fGH5W7phoc2rW1aTp/S9iU0vFFd8jHcSZFRYfN8PwBCfO47r
	CRevZogakqjimyqfu6HBGsNwB68+6TSeYjCXOrrqtUcWP6cN3dy/H+NXni0B1U51NdN5Lyj1+2RS+
	dT6khWzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouBAl-00B8F9-3P; Sun, 13 Nov 2022 11:29:11 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6W-00B6UH-SN
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:50 +0000
Received: by mail-wr1-f45.google.com with SMTP id v1so12368776wrt.11
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Cf7EnMx4OWIW4fa613U+0/vJA7tFR1NEv0VW67tfL4=;
        b=woUNHBsirGVP21TT9dXwQLYhlqy3N6OHA1UNBiLazx/7ZqjvenlZpVaWe+i/N0rq6I
         e2iaN/e5tnh1GhFjPh6kDweDHbhifut2ucufZ6156WgPmOJSDnBrjW/ApTIkiGLDAWq/
         72h/P69XQdcpluiQuL0bmCIrISnTlUQuUr6nS3jSboY1fvIAyAgFMXIAoX4T8eaw4HJC
         IcxpxCCHfVqbjLbMXYD3k5ymWc4/ATIDz3feKgltajzKqEztf29X3bQLdP0VPaqAI6/D
         LkcmWyUf3JqK/+IjpgpXsExoZAdPXLRRXrnX5t9VwN+3/Ju01ykRQ9qsrIr/pXdZL07w
         QFig==
X-Gm-Message-State: ANoB5pmIJKihWwtuAC55Ozqjzn+GOo6fWpTgH/3mokK1xlUA2/jbuwEo
	RIdgfRo1X/5JMfNk1NAjuK6uFTtInrY=
X-Google-Smtp-Source: AA0mqf7Rjn4KeR6XTOVXXFASjttiCXYs27d0RzTDmEqvOxKH3QXKMF6MBOCtweZ3uRd7DbjZIASPJQ==
X-Received: by 2002:a5d:484d:0:b0:241:6f01:ad47 with SMTP id n13-20020a5d484d000000b002416f01ad47mr4884503wrs.222.1668338686963;
        Sun, 13 Nov 2022 03:24:46 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:46 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 17/20] nvme-auth: remove redundant auth_work flush
Date: Sun, 13 Nov 2022 13:24:21 +0200
Message-Id: <20221113112424.1049834-18-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032448_933405_9EE4CA0C 
X-CRM114-Status: GOOD (  14.05  )
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

only ctrl deletion calls nvme_auth_free, which was stopped prior in the
teardown stage, so there is no possibility that it should ever run when
nvme_auth_free is called. As a result, we can remove a local chap pointer
variable.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index eaa294376247..2fd1641b4c67 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -959,15 +959,11 @@ EXPORT_SYMBOL_GPL(nvme_auth_stop);
 
 void nvme_auth_free(struct nvme_ctrl *ctrl)
 {
-	struct nvme_dhchap_queue_context *chap;
 	int i;
 
 	if (ctrl->dhchap_ctxs) {
-		for (i = 0; i < ctrl_max_dhchaps(ctrl); i++) {
-			chap = &ctrl->dhchap_ctxs[i];
-			flush_work(&chap->auth_work);
-			nvme_auth_free_dhchap(chap);
-		}
+		for (i = 0; i < ctrl_max_dhchaps(ctrl); i++)
+			nvme_auth_free_dhchap(&ctrl->dhchap_ctxs[i]);
 		kfree(ctrl->dhchap_ctxs);
 	}
 	if (ctrl->host_key) {
-- 
2.34.1


