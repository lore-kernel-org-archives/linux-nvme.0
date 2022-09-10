Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF7BEC6FA83
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Sep 2022 21:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ANrFwsHJezeIWQ5WEjiwRs8a3XCRmWK8A1hUobLEzRM=; b=oKwCEj13Mi1T2EZGjTDz79R3VE
	+07h71EwyHgBwQvGF2KqnNImmpt6mXF4VCowFu//AyVCfclRCcZ2t5jTdmLPkvSZPkpa+Jz40kB6U
	+rDhX2jRmw09ari+gevmnZIsv2+4vLheCOo771v17tIx50ftFWBO1Zyao3Se9A5cuJPZ7JUrZDkRq
	RGDZb/2Cd9bWUGv/Hi0aVeEWCS4F80U17n9YYeUuNH/8BRKoZ5jvwpUxDqmFgC+9HwgkmkJN5DVSN
	1zEFGN+Ryu3vfvl1otxp37XFBZYsHXDpLZkXx4riQCETh0VI05191jm0bbOfeQHTb0iS6qVCkmgqY
	orOxe4MA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX7tV-00DTl1-GJ; Sat, 10 Sep 2022 21:20:05 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX7sm-00DT7q-Fb
	for linux-nvme@lists.infradead.org; Sat, 10 Sep 2022 21:19:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 1C082B80951;
	Sat, 10 Sep 2022 21:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054F1C4314E;
	Sat, 10 Sep 2022 21:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662844757;
	bh=GCShRCnTLQE4vixCcjzwPmhD/eX4kUQGFemHCnjlSIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PJzsDwAv8lBOaqY3krf7WKbi/q90jWtmk/zZzitQ3VmpmF/wmNh1PhGFD62ix2jcm
	 RCe0c5XBtB8TCWyFjwDpG/9fxCHDU3RAx0UA416MC/nBrr9KPUsg5rFcFyhQYs1CNe
	 XPDYi8bzGjeqBSs6w1aPqc7Q5SLU4GcK0u1d4cq8YP94/ZO60iRPERY+HJgWMdwFm8
	 m/vAwRVd6ogjAKS87BhbxFP7/pZrvXo8HJh4DtAK9r8x/2m6/JVPkP98n4XyTtwpjn
	 HbnNMVrwVDTuU5Ik748K6u1qq2nG7kUmQS8CV1TT99yRyF6I9q2qumREVO0kTfTWZ1
	 0HNwc0tYkWzzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 07/10] nvmet-tcp: fix unhandled tcp states in nvmet_tcp_state_change()
Date: Sat, 10 Sep 2022 17:18:58 -0400
Message-Id: <20220910211901.70760-7-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910211901.70760-1-sashal@kernel.org>
References: <20220910211901.70760-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220910_141920_696112_770595EC 
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
index e9512d077b8a8..eb5b39c2bba84 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1416,6 +1416,9 @@ static void nvmet_tcp_state_change(struct sock *sk)
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


