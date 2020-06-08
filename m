Return-Path: <SRS0=Onny=7V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5B9C433DF
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 23:16:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 506FF20820
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2020 23:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NIvQell3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJlh3yd5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 506FF20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GkqC6tU1DP7W0WLztZq4bwFM1JxPJp2mBjCHlSs2D8M=; b=NIvQell3Yaj2jW
	CR/OlTxgVV3BfanS6RhJ1XjIE0r+U+1GIMwsw8jI20fLsFl+s6HpPQ2naZ93SySaUUFz2r/PprK5u
	zRbv73+wlsqVsQf1WyyYFWFSZxVRhmXIDg7El2HXd8OhU64KeLcfQgLrkktb9RsUneH1znmfLgp2H
	wNDGGTbWf2palwjniql47FriVVyGaU/6i2SEDCCGkOVbU1zJqFFNKyr55DtFH8mX0vbe+abFWGJzk
	lrbHkni3kBuoyjfg+cB1Z4JWE3QfpI5qLdX/dqJbzMPn+cPdDIj410IVRNpY75JTBjp9I0vttRCoJ
	iIMgkvVJHHXwGBm1BjiA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jiR0B-0003Hh-0D; Mon, 08 Jun 2020 23:16:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jiQu9-0001su-2V
 for linux-nvme@lists.infradead.org; Mon, 08 Jun 2020 23:10:11 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 085FD21475;
 Mon,  8 Jun 2020 23:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1591657806;
 bh=jBjbkxP1iiBAvE6/2yxT7Dz+8SrZGpJOC8QuAynfkJg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iJlh3yd5WIbE+DTy8OIJfwMVrSYJl8biQCYJWZyD20KTjGH2NXiBjc9rZ4EYBC9cQ
 lQB/UKzKyZB1ieVanEytud1jIow5c258sIFYgfcVHG/aV8h5h0Fz2Dyppoh1kzxsyM
 jZsYVdALjx97LIW3Ix9hw8o4I5WXGuoeQSI/UvxY=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 183/274] nvme-tcp: use bh_lock in data_ready
Date: Mon,  8 Jun 2020 19:04:36 -0400
Message-Id: <20200608230607.3361041-183-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200608_161009_316933_F4055E9A 
X-CRM114-Status: GOOD (  10.90  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 386e5e6e1aa90b479fcf0467935922df8524393d ]

data_ready may be invoked from send context or from
softirq, so need bh locking for that.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c15a92163c1f..4862fa962011 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -794,11 +794,11 @@ static void nvme_tcp_data_ready(struct sock *sk)
 {
 	struct nvme_tcp_queue *queue;
 
-	read_lock(&sk->sk_callback_lock);
+	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
 	if (likely(queue && queue->rd_enabled))
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
-	read_unlock(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static void nvme_tcp_write_space(struct sock *sk)
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
