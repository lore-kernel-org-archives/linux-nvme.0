Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB107C36013
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 19:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3dHTI/nP8LMuZ8lpB+l5y9cpis9uyfq0/6jTpKt1DVU=; b=dVj53ZFi2BKROYqvGA3mxPYJ1c
	co2VUAl/fDSg3lI9NWr06qOC+D670kzajlQajIMsgynxUmWhMQE5DRV286YLYkMZPSgCv/AwWdrW1
	ZxFf8Fg3qlMuJWEnYnBNODarH8yB2D4op8DUt9XmUwTuHnLkAblnElE7CJ+GPZYzj8xyyRojYMR02
	s0T5OZuLY0c6JFUAfjPebtjflxK3J2jryQEOxxH0RvBO3ZG4d9PT5JOP8MxUM5O4PXUHooF+eF8Nb
	PC9aIAXeg8KO+v14FZ3PfK0H8EZjb2zgOl3Ajy0PPzRlfSNvO6Td48K+as1ySfNLKz3BCMijud4vz
	m87Ajplw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyFZE-0000000EBlW-2EIV;
	Fri, 28 Mar 2025 19:40:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tyFXM-0000000EBON-22SU
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 19:38:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743190719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dHTI/nP8LMuZ8lpB+l5y9cpis9uyfq0/6jTpKt1DVU=;
	b=hLi39gfIOeVtxs7UA0SCmr7kV1HdsvXjXHfBBQfQe+Hk6FdL78Qo8N+GOsvNuU4JP885qw
	KMpF9ZbsyWF+oGXFBRdeyqIx4QtXa9xH46UB7H/XjX/vPOQACV4VoHDvgK1RHi/2kjAdhJ
	FSN88jSUTWIUiDZusclXY6fAuI6CU9k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-HLhNiB8GM0SPuww9IMEElA-1; Fri,
 28 Mar 2025 15:38:36 -0400
X-MC-Unique: HLhNiB8GM0SPuww9IMEElA-1
X-Mimecast-MFC-AGG-ID: HLhNiB8GM0SPuww9IMEElA_1743190714
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78D8E196D2D0;
	Fri, 28 Mar 2025 19:38:34 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.17.17.223])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 84FCF1828AAA;
	Fri, 28 Mar 2025 19:38:32 +0000 (UTC)
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
Subject: [PATCH v3 1/5] nvme: update the multipath warning in nvme_init_ns_head
Date: Fri, 28 Mar 2025 15:38:22 -0400
Message-ID: <20250328193826.356257-2-jmeneghi@redhat.com>
In-Reply-To: <20250328193826.356257-1-jmeneghi@redhat.com>
References: <20250328193826.356257-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250328_123840_591507_EC8FCCA8 
X-CRM114-Status: GOOD (  11.48  )
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

The new NVME_MULTIPATH_PARAM config option requires updates
to the warning message in nvme_init_ns_head().

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 870314c52107..b2bd8e1673ac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3824,7 +3824,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 				"Found shared namespace %d, but multipathing not supported.\n",
 				info->nsid);
 			dev_warn_once(ctrl->device,
-				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
+				"Shared namespace support requires core_nvme.multipath=Y.\n");
 		}
 	}
 
-- 
2.48.1


