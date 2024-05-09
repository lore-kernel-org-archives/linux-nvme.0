Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EEE4C10F1A
	for <linux-nvme@archiver.kernel.org>; Thu,  9 May 2024 20:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u1GlnK+q8TY5qrTbDgo/iJ68l+D3mRMbytA6rZ1uGIY=; b=oTpbO1B42aim/HmQXwNHPNYEGe
	MHuxsse4p+UQN8wS2jV0YX9+J4yqd7VNQGvrrsPE71pzeCuMCGFC6FfeklNI9WvQECqds0cAC+Ek9
	dSlanMJJ9SrZ5Ws+ID3lrG3qkjETgDc0PE6SyX38iOyFvQpX0dNFJjW8kGRlU7ZL9ZiCq0/FGZktV
	Qa31of1cmIasScxmloBMjX96kCzO/nS5m0Vs5exfjjBToC8g8e5QzglU3oDKO0qqijKlNShGK9blb
	rgaMvyDwPBovvwGzJUF9Kh8J2a/1wWzFW8R4bx6KEaFBcpKlyXLtQKFAXDErxlBch5NbxDr2MgFXS
	4LrPq9jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5AOh-00000002lsR-1QtP;
	Thu, 09 May 2024 20:29:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5AOd-00000002lpS-3Vhr
	for linux-nvme@lists.infradead.org;
	Thu, 09 May 2024 20:29:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715286581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u1GlnK+q8TY5qrTbDgo/iJ68l+D3mRMbytA6rZ1uGIY=;
	b=Okgu+oTJUmcNeyXtc+pEaodi+06YTWdWKgwZtlOlmFCjys4hDSuCxZ3gx6tOAvtMDgcTqY
	35HD2NnWf517K36NZwIKH4EEO2/WsPWCQI1rmji2WgKzY6ksppjsmJdZKPiXqChxlkkeLk
	lKZW5CMgOJtxXffcnVEY7BO8w/ymLhE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-bcSsqWtJOcuOP4joco4laQ-1; Thu, 09 May 2024 16:29:35 -0400
X-MC-Unique: bcSsqWtJOcuOP4joco4laQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AEA7A8030A6;
	Thu,  9 May 2024 20:29:34 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 30C4620A4CC4;
	Thu,  9 May 2024 20:29:34 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	hare@kernel.org,
	constg@il.ibm.com,
	aviv.coro@ibm.com
Subject: [PATCH v2 3/3] nvme: multipath: Invalidate current_path when changing iopolicy
Date: Thu,  9 May 2024 16:29:29 -0400
Message-Id: <20240509202929.831680-4-jmeneghi@redhat.com>
In-Reply-To: <20231107212331.9413-1-emilne@redhat.com>
References: <20231107212331.9413-1-emilne@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240509_132944_044595_684E334C 
X-CRM114-Status: GOOD (  10.30  )
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
index 02baadb45c82..d916a5ddf5d4 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -862,6 +862,7 @@ void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
 	mutex_lock(&nvme_subsystems_lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
 		atomic_set(&ctrl->nr_active, 0);
+		nvme_mpath_clear_ctrl_paths(ctrl);
 	}
 	mutex_unlock(&nvme_subsystems_lock);
 }
-- 
2.39.3


