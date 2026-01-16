Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C00D4A60A
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jan 2026 07:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Uw5SQo76I/dUoQRmEd0OyonqVhtHtUJXX1WXGNe3MCg=; b=IjW2ptQ05hC/cORZ0Rh2m2GU5S
	xGcKTp+/fgvqLKa7sYk6nJ9nQFzPr769HMCxbiEnQhcwZhCFoNLGeM7V3yj8Fy9/QVFLF1sXW494z
	8d6XkokWVIb1LuiFLL6fn1h6bGyclmjSClKLdUrBGzWtIgl9w9Gye0JZRTtvN6LfkrET0ksRMDDX7
	QpVVfegZjtX4PTrTY9qXryPp6lX6f+VJjZ3zt/kSyQ2SVYC++1Eocfu3R1Ffv/vB8E4dbfD9z7JZL
	I82SDaPCr/0cGk63cgRrcnRusi1UkqrqO6kHpIAe/leUuvnVNFcPcHdGhnMhjFngl2lkfRVamw8JZ
	Z/XkqD4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgeXw-0000000DiBt-3iUV;
	Fri, 16 Jan 2026 07:47:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vgeXn-0000000DiB5-1YNr
	for linux-nvme@lists.infradead.org;
	Fri, 16 Jan 2026 07:46:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768549613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Uw5SQo76I/dUoQRmEd0OyonqVhtHtUJXX1WXGNe3MCg=;
	b=OrLjk2oOIJ1atRw6/AyYhR6gKc3ze5W42R44lk5/SLLlhwWl4fiQTwuOXvh3+5jCcTKEvT
	qq8G6a5T0HFgmfASOJa7im1APhBYIiihxrasGuPiAJhPdgqp7uNIlVEFQYyXWM4VLyNlY2
	zxfcbwrgdb05fr5Qcd7xzEUe6VQIoLM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-MBclx_u-PRKJq80N7d865w-1; Fri,
 16 Jan 2026 02:46:50 -0500
X-MC-Unique: MBclx_u-PRKJq80N7d865w-1
X-Mimecast-MFC-AGG-ID: MBclx_u-PRKJq80N7d865w_1768549609
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D3601800359;
	Fri, 16 Jan 2026 07:46:49 +0000 (UTC)
Received: from localhost (unknown [10.72.116.198])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 74E031955F22;
	Fri, 16 Jan 2026 07:46:47 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/2] nvme: optimize passthrough IOPOLL completion for local ring context
Date: Fri, 16 Jan 2026 15:46:36 +0800
Message-ID: <20260116074641.665422-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260115_234655_535433_C5D4A4A4 
X-CRM114-Status: UNSURE (   7.49  )
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

Hello,

The 1st patch passes `struct io_comp_batch *` to rq_end_io_fn callback.

The 2nd patch completes IOPOLL uring_cmd inline in case of local ring
context, and improves IOPS by ~10%.


V2:
	- pass `struct io_comp_batch *` to ->end_io() directly via
	  blk_mq_end_request_batch().

Ming Lei (2):
  block: pass io_comp_batch to rq_end_io_fn callback
  nvme/io_uring: optimize IOPOLL completions for local ring context

 block/blk-flush.c                  |  6 ++++--
 block/blk-mq.c                     |  9 +++++----
 drivers/md/dm-rq.c                 |  3 ++-
 drivers/nvme/host/core.c           |  3 ++-
 drivers/nvme/host/ioctl.c          | 23 +++++++++++++++--------
 drivers/nvme/host/pci.c            | 11 +++++++----
 drivers/nvme/target/passthru.c     |  3 ++-
 drivers/scsi/scsi_error.c          |  3 ++-
 drivers/scsi/sg.c                  |  6 ++++--
 drivers/scsi/st.c                  |  3 ++-
 drivers/target/target_core_pscsi.c |  6 ++++--
 include/linux/blk-mq.h             |  4 +++-
 include/linux/blkdev.h             |  1 +
 io_uring/rw.c                      |  6 ++++++
 14 files changed, 59 insertions(+), 28 deletions(-)

-- 
2.47.0


