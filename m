Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 142D5C7115C
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jun 2025 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0zaFqRg/iXhIUEsepKOph+hj22aPgLsPlwmKc03n2to=; b=DniITPfA+7hQn5Rg0NGyBK0TFV
	NGn+fBBe13szPHnamRRfHaZUC0ohdKMp7QdcRPRgwcgwBQinGL5G18XI8/wpEajkC9kUSUNUC67UR
	Tlm32dz5bmPtf2YRF7HtfLF9Ii3bveQI7cSEbsOfdfhiGdKwU5h29mcxVYjoy/9vBY1hXqFheGLeC
	aIe69mm5rv526yj8NwKb6BHPz7Kk9zxcy4RbG7NxNzb6u6mamNJ5HGld8oKEekc1brrj60qElZN6G
	2mmHqQ/X7qVofhO++5W/4LUnh2y0fsCE3rupLdQa+mixRLmQu2f2TDYo/aNL7R8toR5Pf1GUqRtWR
	b2LaPPVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSg0i-0000000GJdz-2CwN;
	Fri, 20 Jun 2025 17:58:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSg0f-0000000GJcU-33gP
	for linux-nvme@lists.infradead.org;
	Fri, 20 Jun 2025 17:58:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750442320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0zaFqRg/iXhIUEsepKOph+hj22aPgLsPlwmKc03n2to=;
	b=S19Zvf7P58Ua2jPBm3nrg6XWbTIM4M9hYls7j/bAQWBwQBigwqFY2UJx/filpiZWAzpoiO
	5LrJv06hvoCPSk2Lv9JKMCs09TFrE9GaNzxqksjeFjKMOLMVvdiMkF95vR+inajWPtIuTN
	ghwRyCeLggyF6dLRsOZB8434j0URAyk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-8yblL3FUMUKQ_GqT8V14dw-1; Fri,
 20 Jun 2025 13:58:37 -0400
X-MC-Unique: 8yblL3FUMUKQ_GqT8V14dw-1
X-Mimecast-MFC-AGG-ID: 8yblL3FUMUKQ_GqT8V14dw_1750442315
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCDF11800289;
	Fri, 20 Jun 2025 17:58:35 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.22.80.187])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF623180035E;
	Fri, 20 Jun 2025 17:58:32 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: james.smart@broadcom.com,
	dick.kennedy@broadcom.com,
	njavali@marvell.com,
	linux-scsi@vger.kernel.org,
	hare@suse.de,
	bgurney@redhat.com,
	jmeneghi@redhat.com
Subject: [PATCH v6 6/6] nvme: sysfs: emit the marginal path state in show_state()
Date: Fri, 20 Jun 2025 13:58:20 -0400
Message-ID: <20250620175820.34795-1-bgurney@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250620_105841_852518_38B44617 
X-CRM114-Status: GOOD (  10.90  )
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

If a controller has received a link integrity or congestion event, and
has the NVME_CTRL_MARGINAL flag set, emit "marginal" in the state
instead of "live", to identify the marginal paths.

Co-developed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Bryan Gurney <bgurney@redhat.com>
---
 drivers/nvme/host/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..4a6135c2f9cb 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -430,7 +430,9 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
 	};
 
 	if (state < ARRAY_SIZE(state_name) && state_name[state])
-		return sysfs_emit(buf, "%s\n", state_name[state]);
+		return sysfs_emit(buf, "%s\n",
+			(nvme_ctrl_is_marginal(ctrl)) ? "marginal" :
+			state_name[state]);
 
 	return sysfs_emit(buf, "unknown state\n");
 }
-- 
2.49.0


