Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C316FECAAD3
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Sep 2022 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sFDgh1mwSv0HQ6Blg5lO+/bzScD3wYZZ4WTEsVryUao=; b=xBJ42Maqu3QYJgl8Adhlay/vWI
	m8aE86e8dPbvC+LsgSLrNHF5Norq/an3d2R6M/tSfE/7X+fYzj1mEJVYGmy+GiXi3CMN4TN6/npCB
	h/E8uzyUrK8/P5MKrG43piJRB/uuK1wY9wUSEKm8FHQQBufwoprjP9HysW9+pi0AgHwIH6A8VAWU+
	YeNT14mFEXBRM8/q7oL2CMq8xAmZCL/uNmumUWuB2W5RmJDgoaqTY9htrxtpV42lXu3xqpiZ09++S
	C1VUK2LQA/67bUOtOvVGfHL96okQIw3txIeSrL6fltX7olL90Q1a7dhrPtyjdJE+qnkZbh0c12stp
	a0p3p+cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX7rt-00DSPs-VU; Sat, 10 Sep 2022 21:18:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oX7rr-00DSNw-LH
	for linux-nvme@lists.infradead.org; Sat, 10 Sep 2022 21:18:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 39B9F60EC7;
	Sat, 10 Sep 2022 21:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7919C43140;
	Sat, 10 Sep 2022 21:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1662844702;
	bh=zGUf+dIncbfBmDbOFyCW2gzyXF8Db5DU0ihwD6D1D48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bb0jMHsSXwztoXhVvZAP77nVR3frfwChmpuqGn3kq7Ttw+mU6W/MHKtw4jOH34iJY
	 /mhs9Bm1dTgqLNvm/QkWIiomPxVQbdleakpI8uQlJd0E9k4uJ13mHKxdeifeqCJYYM
	 vceQEMxtZ2jXfwk/xYiJgWM5G2gYepWVrnVy9BaC8oUwdeSMecCXS9vn+0y66OLQmF
	 NFlhfLIvhnsGLC7Kh/1Hwb23SZQeGqQ7vOC95V/Mvvw7yjjl+MgSpwLSbDV+chpXmc
	 MmIKzlKbHIPO374awXpzBo3kjkVtd602ZMjFUYuR/sx7RRuooISmXjtfaCqfhJY2+U
	 LIec+0qrgdfrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maurizio Lombardi <mlombard@redhat.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 16/21] nvmet-tcp: fix unhandled tcp states in nvmet_tcp_state_change()
Date: Sat, 10 Sep 2022 17:17:47 -0400
Message-Id: <20220910211752.70291-16-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220910211752.70291-1-sashal@kernel.org>
References: <20220910211752.70291-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220910_141823_758549_49404E5A 
X-CRM114-Status: GOOD (  12.11  )
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
index 889c5433c94d2..fba5a77c58d6b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1501,6 +1501,9 @@ static void nvmet_tcp_state_change(struct sock *sk)
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


