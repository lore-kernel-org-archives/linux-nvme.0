Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F068C67861
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 00:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qYVzCaAUKfosHyAtib3siHJ/Eqz+SwafXUqYj59ntNU=; b=D1kFe0OJh4urUrnE9/pUAHVclV
	d91PAEjFtqcsA+iE433cVslBTQxFjmNcuznk3odxdxfO4cktgWLNUKwn/Caa2swlr7HXZmMH58BlF
	2z/pDXnpWwpKnGQ/Qrz8i1oM+G40PlDPP+ilAzPCnM4EiZYQFcgHYTrWEScJ7x2bRGzjA5JbwJyID
	cbcnqIo7nsLF52w1IcpmF+HjV/epAQC7BnBmCJ05y0hipbCLRQ/huEUAL4b2CSY9KNSiMW68+VJKa
	NSMMDnHcnPDavvHjj20V5w78U8f6PrRgpo3O3apn42HGyqfoBCxdjULepeaJMc9qsEysGTrX3enp4
	nFun04Bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruMHt-00000004VUj-3k3w;
	Wed, 10 Apr 2024 00:58:05 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruMHp-00000004VTi-1vzM
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 00:58:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712710679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qYVzCaAUKfosHyAtib3siHJ/Eqz+SwafXUqYj59ntNU=;
	b=JXpyLsbiLjooLu3N0HuiBtS5EG4gV7nPFbBgM0D0aNuHkidVi6I3In1y3O1rF1WMS59pv+
	UFKFZrveb2QSw+yA6Odwj28ZRwRw2RimUwGx84WJonevrR39m/JMkfPzwa6Ghv7Vu96p3I
	Zn+YM9ZgJzOM+EgK62QEgjrro20ulLM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-z4PwVFh5PpOemxDLylqnQw-1; Tue, 09 Apr 2024 20:57:57 -0400
X-MC-Unique: z4PwVFh5PpOemxDLylqnQw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35E781805BE2;
	Wed, 10 Apr 2024 00:57:57 +0000 (UTC)
Received: from fedora34.. (unknown [10.66.146.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1EEEC47B;
	Wed, 10 Apr 2024 00:57:54 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	chaitanyak@nvidia.com,
	kbusch@kernel.org,
	axboe@kernel.dk
Subject: [PATCH v2] nvme: fix warn output about shared namespaces without CONFIG_NVME_MULTIPATH
Date: Wed, 10 Apr 2024 08:57:14 +0800
Message-Id: <20240410005714.4112157-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_175801_673206_26A0A679 
X-CRM114-Status: GOOD (  11.57  )
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

Move the stray '.' that is currently at the end of the line after
newline '\n' to before newline character which is the right position.

Fixes: ce8d78616a6b ("nvme: warn about shared namespaces without CONFIG_NVME_MULTIPATH")
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
V2:
    - Update commit log as Christoph and Chaitanya suggested. 
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 27281a9a8951..e4bec200ebeb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3681,7 +3681,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 				"Found shared namespace %d, but multipathing not supported.\n",
 				info->nsid);
 			dev_warn_once(ctrl->device,
-				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0\n.");
+				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
 		}
 	}
 
-- 
2.34.3


