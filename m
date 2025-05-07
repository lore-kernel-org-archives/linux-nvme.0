Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48D5C3ABC3
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 12:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BXLq9BCIaXCAN0hlznslfQr6YZffUsPs79R2suoGsmI=; b=qDxyhPluAtDOXEEo3BEu3E+TLr
	MxOPKU8Ml9Usn29VD4qqu89xyjwhyeI+kjbqFpI1mPx3i1jUmncED6HqzuhLGWBdVB8Tu4RxvZyYF
	XU7FiEFaR/dD3U78diHRsTQ2HNxjNczRAJLQYB0Em/DJtkfIh1CjFORh3IncPPkDqWmkhU3vS2/pU
	zL24LAG2xeVxzDMEdE6lLiCjvEf8TPShVsOUa1K2/XmJoRB4PGtnJLl6e8XAzQf33ImnedmdrckQo
	aVGZft6Tyz2rNNHJhkbGC3Mcnhro2wMt9INiwjDFi3rrdgVcb0vghK+FcAguCkmziJfHgBGSWV5kI
	egCqhDoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdo2-0000000FMwj-1Tge;
	Wed, 07 May 2025 12:23:22 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCdo0-0000000FMuU-0dZj
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 12:23:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id E27A7437A0;
	Wed,  7 May 2025 12:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC96C4CEF4;
	Wed,  7 May 2025 12:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746620599;
	bh=gsPh10Lo83G0mW4lltW0uPRenCo3upye1tmBE7bC6JA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cg6shGChOnEbATiWv1dIkMBs8t3m6LV4GH/AFLINNjv6GMxS/cAyhr3JiCmcAXSzk
	 unYRSsSx3JMu/Q6l//+aO+gsCUayL0HhnQC7nReODX2pCN6r7uUPWGlzDNb60LlfTh
	 tSObZX3i6GUOJLgqPeTjjsLrkWZfPrkdXq+fCfiqI0iGAliYebeCS7OJ8ukmPeVGF7
	 ZtmVGr72vHwIxPtUABflffter1X/wKmyBriAi/4GUJYZsUtKt4halFTE7AHuhBlghl
	 UYkc2pJ1KlcC3Kl8nvHslusFlZ84biYC5eS9YGHHDL7c+itRkMhWkJcavpOf6MKaLT
	 rOQdu420cFj+A==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 07 May 2025 14:23:02 +0200
Subject: [PATCH v6 06/14] nvmet-fcloop: add missing
 fcloop_callback_host_done
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-nvmet-fcloop-v6-6-ca02e16fb018@kernel.org>
References: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
In-Reply-To: <20250507-nvmet-fcloop-v6-0-ca02e16fb018@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_052320_216619_1AD89B09 
X-CRM114-Status: GOOD (  11.38  )
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


