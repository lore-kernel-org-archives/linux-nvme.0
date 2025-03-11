Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19293C28B2E
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mGGtSS84cKjSy2ss88fSOQbMeo/q2iGPCqW1iabkOm4=; b=KBP3Q4FmtkvS3dKxHihJAvtSKk
	OH7vySgH9qvpYyPU8fLO1C7hJ0qKvivsWlQPg7nJTpYZKIXe+T+Ldr5CtiMYFVhNamoen2vq9PYGT
	diC7lgJ7XMzMZqC+3/4m8XshBSePWP3jTIIqdY5TAmxOvmuwcfaqfE/nDjiA3CoLni84uEpeiBYah
	nYYw1FGpNJk6LmgqXaeoX0ws5pAk2+7Hi9b1IAWOyZC/qTWmW/CBrjXZFfrUzbJGkepcI4lIENwpf
	1HbEY8kX9rZqSa0ylmuleT/8W+eeuG/1ZF0NttVu9vVKWCm+7thGY08PSnh3W9uA3urJtbyBnUueH
	dGUQ4miQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trwb1-00000005GhC-0I0C;
	Tue, 11 Mar 2025 10:12:23 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trway-00000005Gc6-1YcL
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 10:12:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 7E9A1A46A4D;
	Tue, 11 Mar 2025 10:06:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE3BC4CEF1;
	Tue, 11 Mar 2025 10:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687939;
	bh=Tc4yT/fkA+4P7tfX7RUfHYar8v78W+3VZGN+UEnur9M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=utqnP/xQ9/lTpgV87K3De8tlqcSbG4rOAGdbLOA5S2d7WvnDQEwvCv07cOS1p1q/3
	 T7098XIQW3LlAE9Gn+xBfqZq6bE4FfKX+IwEQEchkAfKRMjCffgUwOL8abfjDqAzK7
	 XRM9ZQib+1Bdyg+EBfDbhkezqoiL2Gdh/sYFkH/dP8jy6tBuGvUYk7tGNcMwVRy/mu
	 j8iLzRS2042yAUKXBa0S9cb7VIo7TCLCP/tImbqv9VYQaw/UF3o9tfXQ3SIqQTlEih
	 APEnKr23xvn3wXNnsjJd4Bxs0mR6z59TfHegcU3JaTmamo+3mByl/QK6V2PCr4xt8a
	 1nYNT4HVaaUWA==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:41 +0100
Subject: [PATCH v2 15/15] nvmet-fc: put ref when assoc->del_work is already
 scheduled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-15-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_031220_499384_67B7DDFE 
X-CRM114-Status: GOOD (  10.72  )
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

Do not leak the tgtport reference when the work is already scheduled.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 50cfa02bf8cd1bc39ee8ca3f0b260c5a8733a9df..a948e0856502686294e42826669fd9bd71121c62 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1089,7 +1089,8 @@ static void
 nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 {
 	nvmet_fc_tgtport_get(assoc->tgtport);
-	queue_work(nvmet_wq, &assoc->del_work);
+	if (!queue_work(nvmet_wq, &assoc->del_work))
+		nvmet_fc_tgtport_put(assoc->tgtport);
 }
 
 static bool

-- 
2.48.1


