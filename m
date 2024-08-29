Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1F0C83026
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 09:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=akdsIgKI6MCphk7qMqhXoOLgQD3uYWJcX5VRu/FPDsU=; b=jtBgxlIjD5R/elxhORYQheYYUB
	OqKFmxyFsyKsUeVBXk2EX4Epjzk3uKKTsgbDdVSrEENmD7HXqG3efKViVPDHE0TmcHwkE5poKOuWU
	g0v/+4urQG48GlGHfu0t/uN/VgzzUhJEYVxxi+yyFidx+uiyc1a3Yz9X+XtAk8O2dKpBW/b6pAkQF
	j84/u3YzPqeogkRtSM5jPFbyfkoUHwyTyB+8wZPcDEFoSO7rmond0N+hvlNH7SaMAIHStsiX7LuKw
	09fi6DnWV8dhkguX47wkrJknPdbUiSo4y0szLQTHo5OEyP5mJNqZE45vuUylIhSZw6dFa259ilyUr
	W4SevXGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjbpJ-00000001SRF-2KP6;
	Thu, 29 Aug 2024 09:52:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjbpG-00000001SQj-3d4H
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 09:52:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724925141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=akdsIgKI6MCphk7qMqhXoOLgQD3uYWJcX5VRu/FPDsU=;
	b=XtWPjuVzmRb8xCc3MkN6lr4MyBoIwCLlHb4pH35PnOG+9R7z1iPn37LPlJS4i/nI9Gxe3R
	MaD9ydEw5+zBWC6WLR4OWoLps7btrvhLrwlm1Kexq631j/IUTTdx1aMQ8WndFDx/eUtrTd
	jW8Np7g9/oYf9mVPgvgqhu/UyN0ApgQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-eYVEQ-NjNWi-fC0naTiN4w-1; Thu,
 29 Aug 2024 05:52:19 -0400
X-MC-Unique: eYVEQ-NjNWi-fC0naTiN4w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A2A61955BF2;
	Thu, 29 Aug 2024 09:52:17 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.45.224.216])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A85641955DD8;
	Thu, 29 Aug 2024 09:52:15 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: hch@lst.de
Cc: sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	kbusch@meta.com
Subject: [PATCH V2] nvmet: Identify-Active Namespace ID List command should reject invalid nsid
Date: Thu, 29 Aug 2024 11:52:14 +0200
Message-ID: <20240829095214.48915-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_025222_996915_D55D6D66 
X-CRM114-Status: GOOD (  10.88  )
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

nsid values of 0xFFFFFFFE and 0XFFFFFFFF should be rejected with
a status code of "Invalid Namespace or Format".
See NVMe Base Specification, Active Namespace ID list (CNS 02h).

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---

v2: Explicitely check against the two constants, add a reference to the specs

 drivers/nvme/target/admin-cmd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f7e1156ac7ec..85006b2df8ae 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -587,6 +587,16 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 	u16 status = 0;
 	int i = 0;
 
+	/*
+	 * NSID values 0xFFFFFFFE and NVME_NSID_ALL are invalid
+	 * See NVMe Base Specification, Active Namespace ID list (CNS 02h).
+	 */
+	if (min_nsid == 0xFFFFFFFE || min_nsid == NVME_NSID_ALL) {
+		req->error_loc = offsetof(struct nvme_identify, nsid);
+		status = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
+		goto out;
+	}
+
 	list = kzalloc(buf_size, GFP_KERNEL);
 	if (!list) {
 		status = NVME_SC_INTERNAL;
-- 
2.43.5


