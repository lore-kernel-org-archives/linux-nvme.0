Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3320C4828D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 22:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wc/5vvZu5C2yoz80u8VnrJgqZ4LyZxa9OZ2/+R+0oMo=; b=iLQZtVLvJCWCfus9aEHLtiZMzE
	6MB1Hyq5ZqUpPgzev+NahzZs9jCSPDsq/La1jaCmJ2eigHzuguBjTrx+a8CD5apprsRpW7FQdRkr5
	hDNpzzZuvVLL2cs2wNXyeWdsDJ0zf5PjnYGclZdRZnthr9bo7VMyLo3W/aIzBlFgwX++7kVrJg8pI
	cobXYcVw+va2iWclMa8tNhvhpumTilj+XX/yaJuUlMh7yHi4w13kWIWzXovTK2svCI11h06O0T3hC
	k7fMqnmfAuG2IAJaahqLe06KJTqX/xoUO3USQRyiMO3je3BjpXJ2qvEewJwjEH21GAyvKoRuXlw/f
	4cUsBR6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXqS3-0000000C6wQ-44uf;
	Wed, 07 Feb 2024 22:31:31 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpOu-0000000BrPH-48k2
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:24:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=wc/5vvZu5C2yoz80u8VnrJgqZ4LyZxa9OZ2/+R+0oMo=; b=CRY301R3/0KY24sVTYYUFS/OZL
	WXcNoj6cGqIgWbtr/JZaiidUYqt0tr5sdPEMD3DPBm0SPQ/GE7k8vIVJS+HXeT5I5gxRynhsqoiEH
	KvVey59HEfyrRg7FEmxgT3VIRwfvHM+tua6bHaZHeALexT9Os0vYy0bzWAnoLAOKjrLcfKaNsALgt
	TDtC++UAoXuLOceMcH9HQyNmEPCiVmyLuRLOHkEAYJv7Cc0sB5D8oyCO62dVBq9r2/VecMtD8dCWG
	SrYUZxWzaUsTj2fjk0BNxzGsCimUIim9VKbgCsmCDGQbEY78PPUb9I1OTk17VF8sArMtepnVFLHdq
	tJ+03EIg==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by casper.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpOq-0000000G80H-0NX6
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:24:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F029D61AA2;
	Wed,  7 Feb 2024 21:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69148C43390;
	Wed,  7 Feb 2024 21:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341042;
	bh=i/lCxb5N+Eu7fAfBjRlrdAQLF4uSmeZXYbLchKgQDRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IO1kAHKLSS/kJwx0ynhpGqiXHSM8ELWM94BuxsSxlOkURoK9c6iaQTyAQpDKHk4d+
	 KJ756LK59TQLq9uS930gJjpxTYqe7FciAXHBTWGuLJUj22SRMNNiYM+sn08+Mcraei
	 xbU2vHr8dWIRvZGlP+jzcPpOXECsjv4pPBpxE09WDA0r8hEyNPn16d0cC/m82NccXR
	 pThTx4pQ4oL//APHG2zE5SnDlB8XE607mH2Kuu81ZANOINfAoR8mAF8UVhl548N24k
	 c1kXO1NUTtJUP/kiLXn0bkEWg7HNU+8kBmpUM/O5CIhLKcJ5zu1pYwGZusYgsMZ/sO
	 gZU53S7e+Vf1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guixin Liu <kanie@linux.alibaba.com>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 13/38] nvmet-tcp: fix nvme tcp ida memory leak
Date: Wed,  7 Feb 2024 16:22:59 -0500
Message-ID: <20240207212337.2351-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212409_676823_E62CC847 
X-CRM114-Status: UNSURE (   9.21  )
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

From: Guixin Liu <kanie@linux.alibaba.com>

[ Upstream commit 47c5dd66c1840524572dcdd956f4af2bdb6fbdff ]

The nvmet_tcp_queue_ida should be destroy when the nvmet-tcp module
exit.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a4f802790ca0..8e5d547aa16c 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1927,6 +1927,7 @@ static void __exit nvmet_tcp_exit(void)
 	flush_workqueue(nvmet_wq);
 
 	destroy_workqueue(nvmet_tcp_wq);
+	ida_destroy(&nvmet_tcp_queue_ida);
 }
 
 module_init(nvmet_tcp_init);
-- 
2.43.0


