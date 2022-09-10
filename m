Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8EDC6FA83
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Sep 2022 21:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CfEl/VJEvaUaHjYnwNiS9uMp1zAvXY7jAtw6STM/MNM=; b=Q7sN6+tUzjhWWlsecqKV8OS6Pf
	WPM12S6uU5fTD/vWhxu3sNIa7C6lywXy1q5BiZZkksA5pVLzwE8s3YPYjcGmdypRNy2uy3JGnrWJH
	aC7CAqJI8r9GC8dAEIXY/lN3EmqhDFobz5idPa/0SfklgdnwOQKzyoerl+EaiccpV6txO2Wm0G++4
	OCPna9zF8gLnF0EazhMVVmTzIqqj+jfcjPh/b00vJtuQeyhwuXGDiV6W3rRJu8pec89JJhIsTRy6G
	ABwTIbo9yRBdVcOsr6g0l0vzrmOiPB8O93MdA6CWPUUGihrbkDvP8Ax24xuM/NFkCEK4A8xuLtZEt
	3Fqj4kvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX7sR-00DSqI-Lm; Sat, 10 Sep 2022 21:18:59 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX7sO-00DSnW-Jb
	for linux-nvme@lists.infradead.org; Sat, 10 Sep 2022 21:18:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 3C509B80949;
	Sat, 10 Sep 2022 21:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16EAFC43150;
	Sat, 10 Sep 2022 21:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662844732;
	bh=PHg8TP2ivrzlT0uLMEYPZheBZrjwK7FNCKdBeLRWa4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TnvWiJxPprN9LqHNKhUgNeV4x4zlVx3lJYPGuqhPpGaxbsnDbyT2VLiOxZ65w8F3D
	 JqHiXzMbNdcrst+/67U9YZweuwq+taykJndHseUV57cGpfuKPMTp0kpi1p/Ld5LKrN
	 PG2KPU3UgSdolDon1076deZSCYXrmHIBTQB20EzkEI5uIzvyFIbpPgULvs5dxnW26X
	 Rwkk2GpYya3QHbHsUiy/gPlh+JWKYFqNbo0bXBAElaSUsFp50SRDieMbiC+ZQJFm2k
	 UvyH+V2+EvU1gL2fLGlDaSWfwYDvcqq4DF8OnVtY/5EH77Rg0WxnzwusOflcsje/0U
	 d+wL7ONEhX6MQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 10/14] nvmet-tcp: fix unhandled tcp states in nvmet_tcp_state_change()
Date: Sat, 10 Sep 2022 17:18:28 -0400
Message-Id: <20220910211832.70579-10-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910211832.70579-1-sashal@kernel.org>
References: <20220910211832.70579-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220910_141856_820499_A06E70E3 
X-CRM114-Status: GOOD (  12.62  )
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

[ Upstream commit 478814a5584197fa1fb18377653626e3416e7cd6 ]

TCP_FIN_WAIT2 and TCP_LAST_ACK were not handled, the connection is closing
so we can ignore them and avoid printing the "unhandled state"
warning message.

[ 1298.852386] nvmet_tcp: queue 2 unhandled state 5
[ 1298.879112] nvmet_tcp: queue 7 unhandled state 5
[ 1298.884253] nvmet_tcp: queue 8 unhandled state 5
[ 1298.889475] nvmet_tcp: queue 9 unhandled state 5

v2: Do not call nvmet_tcp_schedule_release_queue(), just ignore
the fin_wait2 and last_ack states.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d030d5e69dc50..e3e35b9bd6846 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1471,6 +1471,9 @@ static void nvmet_tcp_state_change(struct sock *sk)
 		goto done;
 
 	switch (sk->sk_state) {
+	case TCP_FIN_WAIT2:
+	case TCP_LAST_ACK:
+		break;
 	case TCP_FIN_WAIT1:
 	case TCP_CLOSE_WAIT:
 	case TCP_CLOSE:
-- 
2.35.1


