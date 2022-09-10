Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4839C6FA82
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Sep 2022 21:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CYvTxLdra1Yxb8VbXYQLg90VHl4wQvlSFpWaLXdAE9s=; b=fgG/DqU9hKz3OQBshJP5IVmCW5
	Nb8w1hgd1zszDoZf/8KYf0gpBXWy8daYyOmgNoEzfoiTioVHxKd2jdosvsXdFRfSer50UOb1X2TC4
	XJmLaGCfTktBHynCA4nwO0dRDtOVvAGcpVYgXnDUKkd0FnH9UPwZ7gscsfESP3zmHNicwJM9lxF0u
	d5x58pP+RqzrpJRIDwXv90c2Ft4hXaHy36vdpc+lK6hT9fZnhdiy7YCVCB/+6DRhdijUVpo4yCXBg
	Bp9KEDUoNC50Ko00Ou4SpWGjAZCSKjpc+z/oCvSPZP3+8RupuP+OwQE7Ipj9YFgiRV9iyoU3ZWmct
	QRknL5SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX7r5-00DRr3-34; Sat, 10 Sep 2022 21:17:35 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX7qw-00DRnJ-4a
	for linux-nvme@lists.infradead.org; Sat, 10 Sep 2022 21:17:27 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BABA860EDA;
	Sat, 10 Sep 2022 21:17:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1CEC4347C;
	Sat, 10 Sep 2022 21:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662844645;
	bh=h2JJsDOxp0+rL1U/L7fiyquP3/111TM89S4s473Qksc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvnKpRoJU/PmU3qnKm5gGVgoo/bFGa8CQcWXmBioeT0zrzLwOKBg3MEGrAiCZshaE
	 SiPQKlhta6Asfe1PG+dQt0G6BsVTxdZDFUlq5iFc0bYJGyIwCsZeDTtKO5uLDfR1Kf
	 mKVpJV/OyZ1zex4CiRjLgrlMEhkv6qyegZgQHy3FyF30SbryX+5Fb9isuxDTnT5ZaE
	 qUQJHRskS5AH/tdqLiW0jrJn/RybUGESitYsuhH1yPUb+B1+zO0ton/fl4VSTv1CiN
	 Sy1uWBuvnsmaEwU4yH2ZRahJapALA0HpYfskBFa5yPTqpzB98g/NA6kes2hJ5CVaDR
	 WCPx4qwHQWQlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.19 27/38] nvmet-tcp: fix unhandled tcp states in nvmet_tcp_state_change()
Date: Sat, 10 Sep 2022 17:16:12 -0400
Message-Id: <20220910211623.69825-27-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910211623.69825-1-sashal@kernel.org>
References: <20220910211623.69825-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220910_141726_236617_DDE2C4D4 
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
index dc3b4dc8fe08b..a3694a32f6d52 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1506,6 +1506,9 @@ static void nvmet_tcp_state_change(struct sock *sk)
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


