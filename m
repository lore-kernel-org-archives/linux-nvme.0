Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B190CC04A94
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 02:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tJ8545IssFbWueuUcmmUcgXLhw5QdRNS2Iahf8d+nLg=; b=Q2qYXKM7+0L8uZvzA3v7TNzsmK
	oTR3/Yi2PouXMbEDp66cyvXacimBXCRDYHykuLhA6Yy8K+c0uvPZ6x1wPvOszwVGlHsWfWTfFbdB9
	yeEOH1JHOb0F1tFPoLMRFZHvstRosl/6lKrfzyG80nHMP4LvOq9jJKs6D5vRlusY3jf4fNvU8VCTq
	eYAw2AKuEkOZyzP80ej9mey4mOs0/7C5EkhH64J6+IybH1yyT3WxSlDKEpQy3XPvg6q6AFqmjNkJR
	HhNHNpVxEBjz0y+33x4/alERtfvIbu7T8pptRcJO9jiOT+9V3Vf3ggxhM4VDUngB7W0uBXT7DvnIy
	pc2BldBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTYZA-003rLh-1R;
	Wed, 09 Aug 2023 02:04:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTYZ8-003rKh-0m
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 02:04:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1691546689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tJ8545IssFbWueuUcmmUcgXLhw5QdRNS2Iahf8d+nLg=;
	b=X9t5OEYAerhS9AY7BU/CVWwwq9EMQgaUdtMbaIM0NPjU9lPSICfuXH2kGPcrRooBjQ9mhP
	Ze8xOVhm9TbvHkWWqdJ+vEQrUbtyk7LbHUNcktTvFnyNMAL7uWdGLplZbMR+pkfI9Byvee
	Yz4y6JpR9x7SMqOBkQzq0QZv3YqCtm8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-263-UROqMraSMF6kHOv5_GuS1A-1; Tue, 08 Aug 2023 22:04:48 -0400
X-MC-Unique: UROqMraSMF6kHOv5_GuS1A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FFFA8015AA;
	Wed,  9 Aug 2023 02:04:47 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E5F6B40C2076;
	Wed,  9 Aug 2023 02:04:45 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Ming Lei <ming.lei@redhat.com>,
	Guangwu Zhang <guazhang@redhat.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: [PATCH] nvme: core: don't hold rcu read lock in nvme_ns_chr_uring_cmd_iopoll
Date: Wed,  9 Aug 2023 10:04:40 +0800
Message-Id: <20230809020440.174682-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_190450_347297_11583280 
X-CRM114-Status: GOOD (  12.22  )
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

Now nvme_ns_chr_uring_cmd_iopoll() has switched to request based io
polling, and the associated NS is guaranteed to be live in case of
io polling, so request is guaranteed to be valid because blk-mq uses
pre-allocated request pool.

Remove the rcu read lock in nvme_ns_chr_uring_cmd_iopoll(), which
isn't needed any more after switching to request based io polling.

Fix "BUG: sleeping function called from invalid context" because
set_page_dirty_lock() from blk_rq_unmap_user() may sleep.

Fixes: 585079b6e425 ("nvme: wire up async polling for io passthrough commands")
Reported-by: Guangwu Zhang <guazhang@redhat.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/ioctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 5c3250f36ce7..d39f3219358b 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -786,11 +786,9 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 	if (!(ioucmd->flags & IORING_URING_CMD_POLLED))
 		return 0;
 
-	rcu_read_lock();
 	req = READ_ONCE(ioucmd->cookie);
 	if (req && blk_rq_is_poll(req))
 		ret = blk_rq_poll(req, iob, poll_flags);
-	rcu_read_unlock();
 	return ret;
 }
 #ifdef CONFIG_NVME_MULTIPATH
-- 
2.40.1


