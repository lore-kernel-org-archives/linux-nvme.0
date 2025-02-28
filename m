Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA53C282C5
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 03:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YKStR8dsG/OBwzMqbeiTBAwfOm05XDTOH4bItz+QaXw=; b=vEQAfq1xKU4kuV4j/N6MzhTZSZ
	5iXrJ7fqGbjLpmO0k1QPRFHKUzk4WhX7OLbxOeoBnB3GLdce3Lk+6neQHGNO4rWfdObs0/r11NgRC
	3mEW9Z08tb3btk9fkDnW0zBLIv4/Tvx+we5kr99Dt6yHn5D/iX1nFdsBt/giKtjv/QERucoFFQyHZ
	JCcapGepQ7j7+XohEbHH6DWIE0ZWxHexjkrTOJv9G+iIEd2LPVT6TPwMebn1OngfRP3TXNbuvK7iD
	Mx0KEHA+hxXABLEsyUK694Lqd3OTj8/ujKfaujIAXJ8InN6hZ9FqJDtArkMV8ohrHWT4WA6N4PIt3
	yNF4rqlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnr0y-00000009ZWR-046g;
	Fri, 28 Feb 2025 03:26:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnr0v-00000009ZTu-0DJA
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 03:26:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740713172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKStR8dsG/OBwzMqbeiTBAwfOm05XDTOH4bItz+QaXw=;
	b=eDXfyGX7AD5JYX2NYPuJv43UIJyG8I3kY+/N8vpkNzVkGAhoJz8i8Bz4jOAMpfao2pHfXA
	64aYwEilLflN2Nkur9vBcv0HmopnIvk/YE+6sidTI25/BiEyCXYOYbwbszn1T1Vp6/09bQ
	54at6igumwvRFWTnWPuuk6WuB9aZCUE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-QhSVW3QPPf6pyUxRakNLZg-1; Thu,
 27 Feb 2025 22:26:07 -0500
X-MC-Unique: QhSVW3QPPf6pyUxRakNLZg-1
X-Mimecast-MFC-AGG-ID: QhSVW3QPPf6pyUxRakNLZg_1740713166
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B27D41800570;
	Fri, 28 Feb 2025 03:26:06 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.88.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C37D91800988;
	Fri, 28 Feb 2025 03:25:59 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: loberman@redhat.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	bgurney@redhat.com
Subject: [PATCH 4/4] nvme: add mulitipath warning to nvme_alloc_ns
Date: Thu, 27 Feb 2025 22:25:41 -0500
Message-ID: <20250228032541.369804-5-jmeneghi@redhat.com>
In-Reply-To: <20250228032541.369804-1-jmeneghi@redhat.com>
References: <20250228032541.369804-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_192613_159270_219C6EAA 
X-CRM114-Status: UNSURE (   9.32  )
X-CRM114-Notice: Please train this message.
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

When CONFIG_NVME_MULTIPATH is disabled, add a warning if
we discover a multipath enabled controller with an attached
shared namespace.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2b7e6834535..465069c0f6a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3938,6 +3938,15 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	} else {
 		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
 			ns->head->instance);
+#ifndef CONFIG_NVME_MULTIPATH
+		if ((ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) && info->is_shared) {
+			dev_warn(ctrl->device,
+				"Found shared namespace %d but multipathing not supported.\n",
+				info->nsid);
+			dev_warn_once(ctrl->device,
+				"Shared namespace support requires CONFIG_NVME_MULTIPATH.\n");
+		}
+#endif
 	}
 
 	if (nvme_update_ns_info(ns, info))
-- 
2.48.1


