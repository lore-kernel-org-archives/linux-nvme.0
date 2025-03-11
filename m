Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F54C35FF1
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UupW78WGfad8KJ6pDaqTYyYUxiFt6OUBUOlimiyaY4Q=; b=UNuKLh5y2WqqRT5mKBsMYnpmsx
	jzOnwy97W0gX0jXTfuw3gSuUfPpculNGzyte7cpTlkqOppP7LgHNV9LTI4lodNuxdbVXsijrG9Q9t
	Jn9YoFiPW9J5iyR76s5QKNu8Tm4cexKz4SnTIru5Rs/XOq2p2HWjCPYyJWkXPItZWiPc0pjh1oBAp
	XsE9HA2/sfRjmB7WNDt0RZfwusidx0UyL9e24WbgcjsG1JoYwtpH56FCE40ibp+zMk9ELviEc+PpF
	ncp3BZhEPHCgK23TIaoQIUy+2DJyRLOVjk/nArFsSoYBNz1jL6ZD82DRtFsuW74fC8vXbmKhFpaE7
	Kg7TBFiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trwai-00000005GGY-26az;
	Tue, 11 Mar 2025 10:12:04 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trwag-00000005GDR-1vuH
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 10:12:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A9206A46A7D;
	Tue, 11 Mar 2025 10:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42FF6C4CEEB;
	Tue, 11 Mar 2025 10:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687921;
	bh=Mkhlppx0FsVphIwJbAtHmS+qw0+FM0F2IkB19SZNYoU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LU6a9bF04DUMcwQHC9ppkDQ0WpF6f8jtS4aiIbCejVEtC93HoTkXHQwOoAVc7kN2t
	 bFms3o2SGkc1vFtJV72wDXS2+yfwzvMGNVsXYofLvd4m3cbsFwF4+urQqeUaUmj7fq
	 qpjclOXyTlztwO18/ZSAScr1PKijOqDRj0tk7asxwkd4JMc9wYhFPOaaNEIp9DN9Vv
	 lzr4zYyA1a3WS3TuU3uxZPsZQfaEGYwy/Hwh4Zbzd/cjlaPjDMiKGMiHLjUnH1CL3h
	 MwYjZ2Twbl1wkLlvkXc4p9SBS2LbONYhjr9+hdqrpIERZcXL3MqIOKuEl1HETG9A0v
	 daja4sz5T1Vyg==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:34 +0100
Subject: [PATCH v2 08/15] nvmet-fcloop: add missing
 fcloop_callback_host_done
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-8-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_031202_580598_7D500483 
X-CRM114-Status: GOOD (  11.69  )
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

Add the missing fcloop_call_host_done calls so that the caller
frees resources when something goes wrong.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 4ba75f7f51e0bd95ab806b6e82452e75593ff0cf..e6d9474f72c8c9f17b544e4d63039fd33f820db6 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -969,9 +969,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 	}
 	spin_unlock(&inireq->inilock);
 
-	if (!tfcp_req)
+	if (!tfcp_req) {
 		/* abort has already been called */
+		fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 		return;
+	}
 
 	/* break initiator/target relationship for io */
 	spin_lock_irqsave(&tfcp_req->reqlock, flags);
@@ -985,6 +987,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 		break;
 	default:
 		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
+		fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 		WARN_ON(1);
 		return;
 	}

-- 
2.48.1


