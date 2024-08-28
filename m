Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C3C6C54FA6
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Aug 2024 12:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=A4X1lxvhPQj6/lvMEODITEomFfKbDtvcP493x/EbfWU=; b=CC5eKQ/MSBptQQlVqyEbGelwb8
	OPISprOsTK1177xasH8bHXzCCINmb202nDImzRuGyVVnVxaKTFfpyCzigDlT416KunHAXi8B+CWcL
	N7JtVAf6pH4zY+vUpe8bYlGMDe13j3PzUWQtXrhWyPDQZ1U3U3lhfxXdViAwfAwqTGbMYxegB52e9
	fwamWMPy/r+vNvPsBgZfa0NT+9WpgkZ9M9aklb/iR5q37QR3EkBr1B5VC/viwxp/9UWCZa5XheImW
	hAyepLHzAGHa5V7ynZAEb9vJn8Qzy/n3Ebowhz8uveC5OU+qtde5uvBvvHpYXFe7nbkkUF9Fs6irH
	gaXSSrmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjHim-0000000FIEZ-3NRR;
	Wed, 28 Aug 2024 12:24:20 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjHgC-0000000FHdj-0r57
	for linux-nvme@lists.infradead.org;
	Wed, 28 Aug 2024 12:21:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724847697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A4X1lxvhPQj6/lvMEODITEomFfKbDtvcP493x/EbfWU=;
	b=UhTquV6vKNPdgb7liuj6ScTjeW75xu2jYSud+nFrISSczbt4DnT2oZlwfA4b1gqmawk7if
	4kutyUqiEfiunpX0ZtYFDu5eBRU4tFfw47YGoXjhKeLyV44NQGnG/MGykBvnZWV3AhmPXR
	YFvDc1Of1IY0F/BVjifnt0JPSGiuRSw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-HeNx5ZnzNsWACOT0mKrKaA-1; Wed,
 28 Aug 2024 08:21:35 -0400
X-MC-Unique: HeNx5ZnzNsWACOT0mKrKaA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B80F1955BEE;
	Wed, 28 Aug 2024 12:21:34 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.45.224.216])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E5C219560A3;
	Wed, 28 Aug 2024 12:21:31 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: hch@lst.de
Cc: sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org,
	kbusch@meta.com
Subject: [PATCH] nvmet: Identify-Active Namespace ID List command should reject invalid nsid
Date: Wed, 28 Aug 2024 14:21:29 +0200
Message-ID: <20240828122129.10788-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240828_052140_337950_71C4C42A 
X-CRM114-Status: UNSURE (   9.42  )
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

nsid values of 0xFFFFFFFE and 0XFFFFFFFF should be rejected with
a status code of "Invalid Namespace or Format".
See NVMe Base Specification, Active Namespace ID list (CNS 02h).

Fixes: a07b4970f464 ("nvmet: add a generic NVMe target")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/admin-cmd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index f7e1156ac7ec..d37bb1cb94fa 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -587,6 +587,12 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req)
 	u16 status = 0;
 	int i = 0;
 
+	if (min_nsid >= NVME_NSID_ALL - 1) {
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


