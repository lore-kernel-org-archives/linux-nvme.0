Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7637C369D1
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BXLq9BCIaXCAN0hlznslfQr6YZffUsPs79R2suoGsmI=; b=mDh8pXIFDXKM8eAnoQXo/dIN7+
	hRnWJIL2CjVzpEg177qBpFHTrC3ANljX0ehaDEK/OTiFt+EDqXz9H0KrhxANb4njxVx9mpStzJedD
	lleTpWQXvBj26JplcPop6nZeTCvJtGXsAvv6ItFVqEOjH6YvZ61aXRSBMAkfM7EqI3N2U4PML7/5t
	FJOzi8AVECHnCKPOw8l/XD+PYpOx9cDoW6Au76ddzU8OzPshWMnSwMZNoLdbrUoxsgldzn0Bz4biJ
	jsIRkCm0JXdK671hH5/wf400zCXkYw6CYS3vrHdjBU/gzim9K76P9467Br32vbPn98PBXcaAi+P7m
	1KVREIvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7aXJ-0000000Ahev-3m3a;
	Wed, 23 Apr 2025 13:53:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7a3F-0000000AalI-3kTW
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 13:22:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1029E5C61F0;
	Wed, 23 Apr 2025 13:19:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB1CC4CEEB;
	Wed, 23 Apr 2025 13:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745414528;
	bh=gsPh10Lo83G0mW4lltW0uPRenCo3upye1tmBE7bC6JA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KBkq7K2rJyvuL1jt09PIBYGy/54y7ZYnlI8v0sWY6YoNX4PvG5i+FLS60XdMel982
	 4i8bTYX8ZwvsiUtwNHJhNiJOHnDzjgNKPBnljDkaEGZaZ15aaP1+rn2/KULnAZ6GJJ
	 o9lu5+ORRvistqyq6TIjk+9xKfFW6ZaDe190lCP6DMIu9zDtc9FI0oZ8ulix5AYUKH
	 aQClkQtSOaLrWOB41a9bGttDT6EAjm2uqWwCJcL9iDMOzk65oEgTc//cENk8Ucqcxg
	 VXDE8qbnkjJlS6rY1JF7731mhiH79sWJHqcnMozRFFuWtijkKaOEpVXhglNjKQqGMV
	 Rsl9C3fR171nA==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 23 Apr 2025 15:21:49 +0200
Subject: [PATCH v5 06/14] nvmet-fcloop: add missing
 fcloop_callback_host_done
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-nvmet-fcloop-v5-6-3d7f968728a5@kernel.org>
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
In-Reply-To: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_062209_988322_6E24D62E 
X-CRM114-Status: GOOD (  11.13  )
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


