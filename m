Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8746ACAC5BB
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 07:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lUHxgqSyEvKf28sFIukGo2rylsr1Cqyyyd5JTf/+jZI=; b=r2QTg14OQA/fjmiyqUQRp4Q+wV
	GH/NRVL2yvlG5LWwv2zcsKuxrQKA1bKx+tAT2Jn1QIVqDa7sC0yeYY2GW08jFSzCiI1dgGxlo4DzK
	0a53tjuDPX7rublCSxKASEPDtq4WJpH783UsMrWI5O8D47U1vKJikboOW2co8ZhRaKjQFo7Q8+QNF
	qzFjVjBHAU6LHAW/CmbNiInJe4NQENMZBRHmu+QfBuZk4EzZJUXtpXg2T19D21/CmPQN9rhCJ2PSd
	YJKZtTjT4SVd6xqGbvkcJ0vVVTxN3E6QWZyK1rQThR2KREr+x4Nn704cUez7kCxPzIlQbSQnRsJoN
	JU+vfk0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3qpY-00000006rWI-2sde;
	Wed, 01 Oct 2025 07:00:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3qpW-00000006rVv-0Msn
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 07:00:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759302048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lUHxgqSyEvKf28sFIukGo2rylsr1Cqyyyd5JTf/+jZI=;
	b=J4maX0YkLZqvCfjpoFb3ccRL7V6qpG8uND/t3vA8usQkuc1QAq9y6QKELrPBJaYX9y3j04
	+KmdsujVdP/K/XQPH0OXAQjL2cdgRl8SKZRQMPcvAtzy0BhT/1ByBQH472ai38uALuvDpP
	Q7ylLhvI+3RUU6ALKN+Bz8EpD6ZKkj4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-PE17-Hx_PWCiabQlGl-m7Q-1; Wed,
 01 Oct 2025 03:00:47 -0400
X-MC-Unique: PE17-Hx_PWCiabQlGl-m7Q-1
X-Mimecast-MFC-AGG-ID: PE17-Hx_PWCiabQlGl-m7Q_1759302046
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9CAF91800578;
	Wed,  1 Oct 2025 07:00:45 +0000 (UTC)
Received: from jmeneghi-thinkpadp1gen7.rmtusnh.csb (unknown [10.45.224.121])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C6851800446;
	Wed,  1 Oct 2025 07:00:41 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: hch@lst.de,
	kbusch@kernel.org
Cc: bgurney@redhat.com,
	axboe@kernel.dk,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	mlombard@redhat.com,
	sagi@grimberg.me
Subject: [PATCH v2] nvme: check duplicate unique identifiers in order
Date: Wed,  1 Oct 2025 03:00:36 -0400
Message-ID: <20251001070036.152194-1-jmeneghi@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UB-n51B7Z3wR2BP7QkZh6byDFuI04VMeTXESKyHBIMM_1759302046
X-Mimecast-Originator: redhat.com
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_000050_205947_F6A03E02 
X-CRM114-Status: GOOD (  13.31  )
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

The identifier check in nvme_subsys_check_duplicate_ids currently
returns an error if any of the identifiers match; however, this causes
problems with PCI-Express NVMe devices that may otherwise have unique
identifiers of higher precedent (for example, a NGUIDs but common
EUI64).

Rather than enforcing a policy that requires all identifiers reported by
the nvme device to be unique we return success if we find at least one
unique identifier. We zero out any non-unque identifier we find before
returning, thus preventing non-unque identifiers from being reported in
sysfs.

This allows nvme device that return multiple non-unque identifiers to
work as long as one or more unique identifier is reported by the device.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Reviewed-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 37 +++++++++++++++++++++++++++----------
 1 file changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index edfe7a267a4b..8e7d1ca349e6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3797,18 +3797,35 @@ static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
 
 	lockdep_assert_held(&subsys->lock);
 
-	list_for_each_entry(h, &subsys->nsheads, entry) {
-		if (has_uuid && uuid_equal(&ids->uuid, &h->ids.uuid))
-			return -EINVAL;
-		if (has_nguid &&
-		    memcmp(&ids->nguid, &h->ids.nguid, sizeof(ids->nguid)) == 0)
-			return -EINVAL;
-		if (has_eui64 &&
-		    memcmp(&ids->eui64, &h->ids.eui64, sizeof(ids->eui64)) == 0)
-			return -EINVAL;
+	if (has_uuid) {
+		list_for_each_entry(h, &subsys->nsheads, entry)
+			if (uuid_equal(&ids->uuid, &h->ids.uuid)) {
+				memset(&ids->uuid, 0, sizeof(ids->uuid));
+				has_uuid = false;
+			}
 	}
 
-	return 0;
+	if (has_nguid) {
+		list_for_each_entry(h, &subsys->nsheads, entry)
+			if (memcmp(&ids->nguid,
+				   &h->ids.nguid,
+				   sizeof(ids->nguid)) == 0) {
+				memset(ids->nguid, 0, sizeof(ids->nguid));
+				has_nguid = false;
+			}
+	}
+
+	if (has_eui64) {
+		list_for_each_entry(h, &subsys->nsheads, entry)
+			if (memcmp(&ids->eui64,
+				   &h->ids.eui64,
+				   sizeof(ids->eui64)) == 0) {
+				memset(ids->eui64, 0, sizeof(ids->eui64));
+				has_eui64 = false;
+			}
+	}
+
+	return (has_uuid || has_nguid || has_eui64) ? 0 : -EINVAL;
 }
 
 static void nvme_cdev_rel(struct device *dev)
-- 
2.51.0


