Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BF5C636D4
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 16:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FwFwAIVqNH4ULmv6UWV6ri51RBFBbxgGtma65urn+gg=; b=JZISMbZIFWvgwI12O0JaIZPZCf
	FIGEAAgjpTtvFCQLxC6l8VtHnGoZDGla4wgu568+NNENrisn50kP/OVeAVr9vI9jZzWmpsM0fVvql
	m5ituRv8Ywx3QtHRS1S4l+JRkeRp321q4++1blRGy+yAW9t8ZDQo2l8IzSF3NtaO1ZGgAic4iakT4
	r37Che2w/eVqXP6/8leizr5tiB0y6SeILtzTLoBSzd4bodkpBuQjDzKuVARBReCRERm5ga0NMlY9Z
	QK6g3INOP+OZcu8p0VCnc298GDB0d01f/Aj03qQUOI4hs+4HQVhEweJ5UZ3JxrTeRjbxkg9BYynKT
	DLyomkOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMtet-008ifd-RL; Tue, 31 Jan 2023 16:38:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMteo-008id6-N5
	for linux-nvme@lists.infradead.org; Tue, 31 Jan 2023 16:38:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675183130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FwFwAIVqNH4ULmv6UWV6ri51RBFBbxgGtma65urn+gg=;
	b=Ez2LyYfFfmEPccu9wqgtASTz9ocStEXe4q8bJB+80fW4ps3Iu6aVSxtdBchsv1MkvO1Xew
	UzYhJY4PYpfnq+cvAVsNB/SarDI95elIKTAnlJS+pOSZeY9fu/w9S5YIfybQAiD3kDvUgk
	moBJefey2dygTOaNqBcv0vsCMYZ0R1E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-lgKgVjQLONGjSOFe0jk74A-1; Tue, 31 Jan 2023 11:38:44 -0500
X-MC-Unique: lgKgVjQLONGjSOFe0jk74A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 03FFE811E9C;
	Tue, 31 Jan 2023 16:38:44 +0000 (UTC)
Received: from raketa.redhat.com (ovpn-193-129.brq.redhat.com [10.40.193.129])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E892C140EBF4;
	Tue, 31 Jan 2023 16:38:42 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: fix a potential invalid pointer dereference
Date: Tue, 31 Jan 2023 17:38:42 +0100
Message-Id: <20230131163842.431543-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_083854_943114_4944A737 
X-CRM114-Status: GOOD (  10.76  )
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

In nvme_alloc_io_tag_set(), the connect_q pointer should be set to NULL
in case of error to avoid potential invalid pointer dereferences.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 505e16f20e57..aba432c58fed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4983,6 +4983,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 
 out_free_tag_set:
 	blk_mq_free_tag_set(set);
+	ctrl->connect_q = NULL;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_alloc_io_tag_set);
-- 
2.31.1


