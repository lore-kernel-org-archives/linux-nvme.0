Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F76C369A8
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BXLq9BCIaXCAN0hlznslfQr6YZffUsPs79R2suoGsmI=; b=ipwxRb8fzvw0EdUXaRZRhpiJXz
	zUcFIzlutq9KN+1ZkaQpgewh8+wQN0E5nUKqgSkeKVjmRGbfnlDZrN3qxjnPLPxoeJrGbxU6SALSy
	rdf2PG/WOhaJrZG1x2xRMVwvaSCgWdueDwkg/5qmgT4ygEXkAHRT9Di7bk4JpbdTvdQgcunyGNh2p
	uPNtsvY4AjxBNOKKQpC+wflGuIvaEJ3mjr6QFX/IiO3Dw1X9nahd++7wJE3PcX4BI5rpiP7qEexVJ
	Q0s8x/jOxkMxr5hB6hwH1kbN6A8NRNF+1CDSm94ANAd5kLfMMT8/3fJjEkPm1sykX9P7Cnf2BED2O
	F5Hr0h6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qN3-0000000AM4V-0bZB;
	Thu, 10 Apr 2025 11:47:01 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2qHe-0000000AKs3-47KG
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 11:41:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B6DC0A4A787;
	Thu, 10 Apr 2025 11:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADB1C4CEEA;
	Thu, 10 Apr 2025 11:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744285286;
	bh=gsPh10Lo83G0mW4lltW0uPRenCo3upye1tmBE7bC6JA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uTocnAdOBpZdHRCjpIy9DsGg7NpJQLu63ymhBc829iPlAgqT9PR9MoJD9kdBXJZtX
	 R+y0KDrnvCQca4RurmBVtkrfxNzp3S5YWICZbtYzsvV7BGfEGvzch+2HPfeaP8uBbb
	 eYTnMJ5rzf3XkBr/TgYY87pFsNDj1G0lgGVk+N6ZQydYva92LW7eciwKqhTEld8+/1
	 IvJXXGYWx2GKi1GJ8Oc1DdOfqtyltAPleyq2gE0MG88xF+Ln9dVUgFmRPImYdqWYrV
	 LxLwm+kPj3AXqMXKSPRAtKWtJcoMdkFZ6RUQ39mnIANcEOLm4OcbF0NHcEgT+uC/i7
	 vCAKQS1RF7vig==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 10 Apr 2025 13:41:09 +0200
Subject: [PATCH v4 06/14] nvmet-fcloop: add missing
 fcloop_callback_host_done
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-nvmet-fcloop-v4-6-7e5c42b7b2cb@kernel.org>
References: <20250410-nvmet-fcloop-v4-0-7e5c42b7b2cb@kernel.org>
In-Reply-To: <20250410-nvmet-fcloop-v4-0-7e5c42b7b2cb@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_044127_089743_9659F45E 
X-CRM114-Status: GOOD (  11.19  )
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
 drivers/nvme/target/fcloop.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index b54467b285181d6909c6592eb166cf4fe6fbe54c..0c0117e03adc81c643e90a7e7832ff087a4c2fd7 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -966,9 +966,10 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 	}
 	spin_unlock(&inireq->inilock);
 
-	if (!tfcp_req)
+	if (!tfcp_req) {
 		/* abort has already been called */
-		return;
+		goto out_host_done;
+	}
 
 	/* break initiator/target relationship for io */
 	spin_lock_irqsave(&tfcp_req->reqlock, flags);
@@ -983,7 +984,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 	default:
 		spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 		WARN_ON(1);
-		return;
+		goto out_host_done;
 	}
 	spin_unlock_irqrestore(&tfcp_req->reqlock, flags);
 
@@ -997,6 +998,11 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 		 */
 		fcloop_tfcp_req_put(tfcp_req);
 	}
+
+	return;
+
+out_host_done:
+	fcloop_call_host_done(fcpreq, tfcp_req, -ECANCELED);
 }
 
 static void

-- 
2.49.0


