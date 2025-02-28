Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D6DC19F32
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Feb 2025 03:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IP0rVGLccAQop086ZZXP2hGbaZD9tbaXKoP4vlHgFdg=; b=IKLNEffSWuRbuslYtegCQ5EiSv
	wRtxi6JxATZyP62J3tprLLBZMkY40Ov9xStA89QU5JZE23CiCn0Vppaghoc2zdXwbdPuyNpsRijJP
	YF+0uuqemRSGtkKtON6jMkPQxzRBas+HdexHNqhelzTGDdUbvimSyIGktCtsYPGNY2htFJugBB3XS
	ciIU7o+HsVXaQN5LkBxTruzor+HsOCklJ/cSlVSf4M+EBrLEr4rsMXD7gccAbzBMULQnoGIbSv8u6
	9o3p77Px7qbt6ULVZHSE6uae5nlOKQHRwo5msWvP/8yYDPgXOfnkE4lLKyI6Mr2jewIu3jN62ENzs
	kT0t0h6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnr0q-00000009ZQj-0Lzs;
	Fri, 28 Feb 2025 03:26:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnr0o-00000009ZPl-1Cpk
	for linux-nvme@lists.infradead.org;
	Fri, 28 Feb 2025 03:26:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740713165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IP0rVGLccAQop086ZZXP2hGbaZD9tbaXKoP4vlHgFdg=;
	b=SwAHtvMkdHaPBldrAf84v44EJG9DKDWP5qAcjh2w5hz7nlktmTvxN4SvmMEEJ36Xd+ftEZ
	WjTDI3uUDTF4E+HcQgJ2m9ARp8rt0k6ATAAKtOOWmnOo/+pRcCEEVrKGkde2GTnR+kE1IQ
	rr84v0Uf6JEhzGlzN4vwr3fpvS4sRLw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-H7aDcUvoO2-qvES-9l8rIg-1; Thu,
 27 Feb 2025 22:26:00 -0500
X-MC-Unique: H7aDcUvoO2-qvES-9l8rIg-1
X-Mimecast-MFC-AGG-ID: H7aDcUvoO2-qvES-9l8rIg_1740713159
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F1A5191815F;
	Fri, 28 Feb 2025 03:25:59 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen3.rmtusnh.csb (unknown [10.22.88.31])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6DA6C180035E;
	Fri, 28 Feb 2025 03:25:57 +0000 (UTC)
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
Subject: [PATCH 3/4] nvme: update the multipath warning in nvme_init_ns_head
Date: Thu, 27 Feb 2025 22:25:40 -0500
Message-ID: <20250228032541.369804-4-jmeneghi@redhat.com>
In-Reply-To: <20250228032541.369804-1-jmeneghi@redhat.com>
References: <20250228032541.369804-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_192606_395964_40ECC0EE 
X-CRM114-Status: GOOD (  10.63  )
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
to the warning message in nvme_init_ns_head(). Remove
the old warning message and add new ones.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 818d4e49aab5..c2b7e6834535 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3823,8 +3823,16 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 			dev_warn(ctrl->device,
 				"Found shared namespace %d, but multipathing not supported.\n",
 				info->nsid);
+#ifdef CONFIG_NVME_MULTIPATH
+#ifdef CONFIG_NVME_MULTIPATH_PARAM
+			dev_warn_once(ctrl->device,
+				"Shared namespace support requires core.nvme_multipath=Y.\n");
+
+#endif
+#else
 			dev_warn_once(ctrl->device,
-				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0.\n");
+				"Shared namespace support requires CONFIG_NVME_MULTIPATH.\n");
+#endif
 		}
 	}
 
-- 
2.48.1


