Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B644DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 15:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZBMNlmNCwhArR7wzRo4X8TO9Duy5gdLmmGSXNc4GFhs=; b=G0M0HXVd9b02CIqLNCM05X/G/X
	Psne5E7aPiJxlAzVj8CT6xMD6QEdBuE6OcBqNEmN4pjAGS2x9MW1zPeqglEEGnvuibRmUBZTNlexu
	sRg8O4NdXo9VUNLG+jwGhRbQm0ZynatjGIIH9wug36zKOiio27fFZl9OQ/EEBZYxiIW/YsHQ6fFW6
	MJoffUvXU65t4AHP0dK641q5zj8eqoQC9FwQl93qjZ9XXzEchao07D87POKDXMydzqjWNb63lPN5m
	O7hfACZKd4Spr2qDVcoLsEbV7y5NzP7J+5jwVsyZTArscG8d+sUdN64yTIIKJu/0pTsUIIVAYj4nT
	Yv8N6I2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ms4ce-005ktv-0e; Tue, 30 Nov 2021 15:00:44 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ms4Te-005hT7-IM
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 14:51:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3CE51B81A4A;
 Tue, 30 Nov 2021 14:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD08C53FCF;
 Tue, 30 Nov 2021 14:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638283884;
 bh=wiHEs+Ws9zJoSPVN+Gr8NlOunVPYd93tWM951MdfUdU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IxvvgOld5OYn1/4jQpGU2RiPOplkIRMB+gH8P1aBCg2cYZb+Z/dfVNj19+WQV/gZh
 nj0hF66G15pDElV/c5N3619w05AqZAz3radKHF8UeL7p4NSsy427+sUHFwmgvtTiZV
 c+GancBQaZ/PtTpFxBfsYZEh4U/ja2arEErgyu9F7tNa3T+kuN55CYr9o6bpXij5oi
 kFFRXBv/HWa/maHI4teSqxJG+GsxN50zjUT4TfHBkaDNbT81l/To6t9nc+3qtknmZ7
 NiV0a6lOyzRt6v1bR//Tv3KRvutOq0Hd6x0tgg/pdy4rEgqtYbRrKFbyPpfVKVQt1w
 eMQAm0FD8+aQA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, John Meneghini <jmeneghi@redhat.com>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 27/43] nvmet-tcp: fix a race condition between
 release_queue and io_work
Date: Tue, 30 Nov 2021 09:50:04 -0500
Message-Id: <20211130145022.945517-27-sashal@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130145022.945517-1-sashal@kernel.org>
References: <20211130145022.945517-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211130_065126_803403_2A36758C 
X-CRM114-Status: GOOD (  14.03  )
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

From: Maurizio Lombardi <mlombard@redhat.com>

[ Upstream commit a208fc56721775987c1b86e20d86d7e0d017c0b2 ]

If the initiator executes a reset controller operation while
performing I/O, the target kernel will crash because of a race condition
between release_queue and io_work;
nvmet_tcp_uninit_data_in_cmds() may be executed while io_work
is running, calling flush_work() was not sufficient to
prevent this because io_work could requeue itself.

Fix this bug by using cancel_work_sync() to prevent io_work
from requeuing itself and set rcv_state to NVMET_TCP_RECV_ERR to
make sure we don't receive any more data from the socket.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 1251fd6e92780..f726964b56555 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1407,7 +1407,9 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	mutex_unlock(&nvmet_tcp_queue_mutex);
 
 	nvmet_tcp_restore_socket_callbacks(queue);
-	flush_work(&queue->io_work);
+	cancel_work_sync(&queue->io_work);
+	/* stop accepting incoming data */
+	queue->rcv_state = NVMET_TCP_RECV_ERR;
 
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
-- 
2.33.0


