Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 874ECC04FFE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 17:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vFxooJ/Wd2kSlfPg0r+rfS28FX2xdaR0dGl5yZTVUZc=; b=oOS2r6z7NL5240KEOdrwiE9aXr
	haTfDXdnwv0FAHZKW13+HSnBtq6UjZT7trc/XYNuqDWxi+soX3c1zJ4OEvPgCjIgCJtyglDpygNNO
	h6gOoXVIciCyqQ7uZTyLssJlEpAYKR0ZRVYNh8YTi8Nry7twLaySuBa3AqmdFRhLyvuzaKbOPFSa7
	nGALox408cld1poChD7BY9aBdX5uzqqVsq1pDc/5b5EskHxbLTP+9rf0a99tvTD9wbEJIlccpi9Hv
	aYZr092O8CyGuL32ddm50blyXW75phlIb1RTWzHWeqsxU3N8SjQZEYUU37FbPzCp13OoRxoZUZIuX
	lPy38izA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6wLN-0000000Gj7i-44AF;
	Tue, 14 May 2024 17:53:41 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6wLK-0000000Gj59-0SNg
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 17:53:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715709217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vFxooJ/Wd2kSlfPg0r+rfS28FX2xdaR0dGl5yZTVUZc=;
	b=Xp8E3WrYFkRUojrbhZcb11uyZkNqcdWq0UY7rIeZ43QJ1WcO8iO82TPuEGcqzI3ivLDkef
	Q388o8rKKPKo4hQNTp8m1PDwrvGMUuQH+3PrhjlYTMPflkyB7AMriQtXuEhAWWpIQKSc8s
	d2Y6PCFJEx6kCE6OfJGFjKEtgoY2H9c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-cAwzDMOuML6LGk8vAbX-0g-1; Tue, 14 May 2024 13:53:32 -0400
X-MC-Unique: cAwzDMOuML6LGk8vAbX-0g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 118E08001F7;
	Tue, 14 May 2024 17:53:32 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.2.17.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E87CC400059;
	Tue, 14 May 2024 17:53:30 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com,
	hare@kernel.org
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com
Subject: [PATCH v4 3/6] nvme: multipath: Invalidate current_path when changing iopolicy
Date: Tue, 14 May 2024 13:53:19 -0400
Message-Id: <20240514175322.19073-4-jmeneghi@redhat.com>
In-Reply-To: <20240514175322.19073-1-jmeneghi@redhat.com>
References: <20240514175322.19073-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_105338_325855_5813D387 
X-CRM114-Status: UNSURE (   9.68  )
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

From: "Ewan D. Milne" <emilne@redhat.com>

When switching back to numa from round-robin, current_path may refer to
a different path than the one numa would have selected, and it is desirable
to have consistent behavior.

Tested-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/multipath.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 1e9338543ded..8702a40a1971 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -861,6 +861,7 @@ void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
 	mutex_lock(&nvme_subsystems_lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
 		atomic_set(&ctrl->nr_active, 0);
+		nvme_mpath_clear_ctrl_paths(ctrl);
 	}
 	mutex_unlock(&nvme_subsystems_lock);
 }
-- 
2.39.3


