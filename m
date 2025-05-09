Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC009C3ABCC
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 17:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vah8YBNXc6tDK2i6PxCiQbzusZuURzBuKlfx8mXYQGI=; b=P6lnOxrdahOkhZbwuM4vpJ0ykU
	9Y2PpNl9mhki6FagDsi6fvsAKPtUP3PF2Oq5dnR3hPPKVq/I0jNH0DBVjmWz69vSUKr9WsARbH+wC
	wj4yUzaPeeaR7bJdhgRDtbLbUtK/CGSsWo8NxzTGcjC/QczcV0bgC4Io9xurIEvsKm7b64TEQYKJR
	5KLkEmpZLByNzcwpGKmYgKx3SXZNVson5hTmwc671XaZmSKpIv10D/hubL/sT/ldSVLiO5dkT6kNk
	PJyAFyM/0c84UH3zPlwrNONrbbV0fsJg1kxqIJtkTD9Sh1y7qcYCNjehzUUitQN/0Kx8COLD4ag0W
	9w8+mNNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDRNZ-00000004QA7-1qXr;
	Fri, 09 May 2025 17:19:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDPV9-000000043mY-2h1L
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 15:19:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746803942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vah8YBNXc6tDK2i6PxCiQbzusZuURzBuKlfx8mXYQGI=;
	b=PihqvCdIOHCyBrg4ZtOmd8KQbn2auK/GSGoxmuJlWriEQDDYbmbEueLatpDzuteApWOub8
	YkP12TNgkAb/YjX3a38GtW4gazmADshh6o/cn6vpwrRMYpLP5h3OT8+ck5gzee+Bs45A19
	QJdrSefan8TI7jmAXRBxHbEvdCC4m2g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-f_a_zlwzMKWX_jrThgO6DQ-1; Fri,
 09 May 2025 11:16:34 -0400
X-MC-Unique: f_a_zlwzMKWX_jrThgO6DQ-1
X-Mimecast-MFC-AGG-ID: f_a_zlwzMKWX_jrThgO6DQ_1746803792
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 801BD1800446;
	Fri,  9 May 2025 15:16:32 +0000 (UTC)
Received: from bgurney-thinkpadp1gen5.remote.csb (unknown [10.22.64.239])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCBD73000221;
	Fri,  9 May 2025 15:16:29 +0000 (UTC)
From: Bryan Gurney <bgurney@redhat.com>
To: bgurney@redhat.com,
	linux-nvme@lists.infradead.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	axboe@kernel.dk
Cc: jmeneghi@redhat.com,
	mlombard@bsdbackstore.eu
Subject: [PATCH 1/2] nvme: check duplicate unique identifiers in order
Date: Fri,  9 May 2025 11:16:27 -0400
Message-ID: <20250509151627.20434-1-bgurney@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VVsweHCEHEoggX_S0AOpAp7WOGec3hBQpVtqTvJTS8g_1746803792
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_081903_751750_923F8209 
X-CRM114-Status: GOOD (  14.19  )
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

The identifier check in nvme_subsys_check_duplicate_ids returns an error
if any of the identifiers match; however, this causes problems with
PCI-Express NVMe devices that may otherwise have unique identifiers of
higher precedent (for example, unique NGUIDs, but common EUI64s).

Check for duplicate IDs in order of precedence in the NVMe standard:
UUID, then NGUID, then EUI64, in a way that ensures the highest
priority identifer that exists for the namespace will be checked for
uniquness.  If a lower-priority identifier exists and is non-unique, the
higher priority identifier will be unique, and should be used as the
identifier for the namespace.

Suggested-by: John Meneghini <jmeneghi@redhat.com>

Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Bryan Gurney <bgurney@redhat.com>
---
 drivers/nvme/host/core.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eb6ea8acb3cc..49ca29c64ca9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3577,15 +3577,29 @@ static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
 
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
+			if (uuid_equal(&ids->uuid, &h->ids.uuid))
+				return -EINVAL;
+		return 0;
+	}
+
+	if (has_nguid) {
+		list_for_each_entry(h, &subsys->nsheads, entry)
+			if (memcmp(&ids->nguid,
+				   &h->ids.nguid,
+				   sizeof(ids->nguid)) == 0)
+				return -EINVAL;
+		return 0;
+	}
+
+	if (has_eui64) {
+		list_for_each_entry(h, &subsys->nsheads, entry)
+			if (memcmp(&ids->eui64,
+				   &h->ids.eui64,
+				   sizeof(ids->eui64)) == 0)
+				return -EINVAL;
+		return 0;
 	}
 
 	return 0;
-- 
2.49.0


