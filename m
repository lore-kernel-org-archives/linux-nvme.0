Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AADCBC282EC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 10:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=osOIQNy729jsNZ+RxNDOvw349rB1ce8681U999j87Vs=; b=NggCU2p32OtFU5TXhM4bhXyYqe
	MJGjDUq6LEZxwAZFEN0Lu3LNkUUZaumxMV2mEac0Rti/g917aqxqOKuYQF+gOZFTqzqa5uaKp6RfL
	KYCHXHNyzu+XCdMaPwS4gR6hjzwQu+9JqHzLmYzoA6tlAVu3wSfufQFhFB/WX+LxNPVSxTyeyiQW9
	T+kTg9TH1i91YOInzFGGfbusUjd5Ir672XXISdvT4sXJeUoZQi3KNDqk7GLOrlOzNJQmKL4fsE7wI
	gGMXjxjcadaeiwsnTV36YW56Qz0yffuDAtNbzOkDunE644nPMd1Dvws4EuP/41x7J3AOxmZ7c97xf
	JLjt6U5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trwaW-00000005G4r-1HW1;
	Tue, 11 Mar 2025 10:11:52 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trwaU-00000005G38-0fBW
	for linux-nvme@lists.infradead.org;
	Tue, 11 Mar 2025 10:11:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 38BDFA46966;
	Tue, 11 Mar 2025 10:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3939C4CEEB;
	Tue, 11 Mar 2025 10:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741687909;
	bh=nXaB5vvPFCz2xSu00c+z/SDRSsoqIHfuwDLjamISevU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p9mWPN3FkMNQ7Hs0jzoIWSyYB1srGj4Naei5AY8JcFHGDTJD9lFLC0nHUIBojKxrY
	 +sq0vh76OGFfkNRJgXdR6RXU20JKCTI2Zsln/s0fAPCQrb5svSGQ+IvZ1nx1EOhPrV
	 l2LahPqw0/w3v2Qrj1qTHAZW2f4ZBV9JuwrJZ9vY7Ypaw0mXM3yzSuJsPSFW3DuoV6
	 X9R1MfjsLibW8Vq7Cba/4EYAIHwcXlHCXlpf4AiU1EUFyVXB+j2srB1RSpYas3feHd
	 h5uNxBkoyrOAioOrwnwaHs+seSRlKcHHaGqPLCeexuOSJI/Z2aRqS9/jgbl4hNdbl+
	 KDEsPXzZSJpxw==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 11 Mar 2025 11:11:29 +0100
Subject: [PATCH v2 03/15] nvmet-fcloop: add ref counting to lport
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-nvmet-fcloop-v2-3-fc40cb64edea@kernel.org>
References: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
In-Reply-To: <20250311-nvmet-fcloop-v2-0-fc40cb64edea@kernel.org>
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250311_031150_346168_5A17DADE 
X-CRM114-Status: GOOD (  14.41  )
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

The fcloop_lport objects live time is controlled by the user interface
add_local_port and del_local_port. nport, rport and tport objects are
pointing to the lport objects but here is no clear tracking. Let's
introduce an explicit ref counter for the lport objects and prepare the
stage for restructuring how lports are used.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/target/fcloop.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 762ba908130b37bbd41f6888c9cb2a56ef3b7afe..f02b5d7d9d56f1c91ea8ace254a51654777968b3 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -208,6 +208,7 @@ struct fcloop_lport {
 	struct nvme_fc_local_port *localport;
 	struct list_head lport_list;
 	struct completion unreg_done;
+	refcount_t ref;
 };
 
 struct fcloop_lport_priv {
@@ -994,6 +995,27 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 	}
 }
 
+static void
+fcloop_lport_put(struct fcloop_lport *lport)
+{
+	unsigned long flags;
+
+	if (!refcount_dec_and_test(&lport->ref))
+		return;
+
+	spin_lock_irqsave(&fcloop_lock, flags);
+	list_del(&lport->lport_list);
+	spin_unlock_irqrestore(&fcloop_lock, flags);
+
+	kfree(lport);
+}
+
+static int
+fcloop_lport_get(struct fcloop_lport *lport)
+{
+	return refcount_inc_not_zero(&lport->ref);
+}
+
 static void
 fcloop_nport_put(struct fcloop_nport *nport)
 {
@@ -1023,6 +1045,8 @@ fcloop_localport_delete(struct nvme_fc_local_port *localport)
 
 	/* release any threads waiting for the unreg to complete */
 	complete(&lport->unreg_done);
+
+	fcloop_lport_put(lport);
 }
 
 static void
@@ -1134,6 +1158,7 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
 
 		lport->localport = localport;
 		INIT_LIST_HEAD(&lport->lport_list);
+		refcount_set(&lport->ref, 1);
 
 		spin_lock_irqsave(&fcloop_lock, flags);
 		list_add_tail(&lport->lport_list, &fcloop_lports);
@@ -1150,13 +1175,6 @@ fcloop_create_local_port(struct device *dev, struct device_attribute *attr,
 	return ret ? ret : count;
 }
 
-
-static void
-__unlink_local_port(struct fcloop_lport *lport)
-{
-	list_del(&lport->lport_list);
-}
-
 static int
 __wait_localport_unreg(struct fcloop_lport *lport)
 {
@@ -1169,8 +1187,6 @@ __wait_localport_unreg(struct fcloop_lport *lport)
 	if (!ret)
 		wait_for_completion(&lport->unreg_done);
 
-	kfree(lport);
-
 	return ret;
 }
 
@@ -1193,8 +1209,9 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 	list_for_each_entry(tlport, &fcloop_lports, lport_list) {
 		if (tlport->localport->node_name == nodename &&
 		    tlport->localport->port_name == portname) {
+			if (!fcloop_lport_get(tlport))
+				break;
 			lport = tlport;
-			__unlink_local_port(lport);
 			break;
 		}
 	}
@@ -1204,6 +1221,7 @@ fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
 		return -ENOENT;
 
 	ret = __wait_localport_unreg(lport);
+	fcloop_lport_put(lport);
 
 	return ret ? ret : count;
 }
@@ -1629,17 +1647,17 @@ static void __exit fcloop_exit(void)
 	for (;;) {
 		lport = list_first_entry_or_null(&fcloop_lports,
 						typeof(*lport), lport_list);
-		if (!lport)
+		if (!lport || !fcloop_lport_get(lport))
 			break;
 
-		__unlink_local_port(lport);
-
 		spin_unlock_irqrestore(&fcloop_lock, flags);
 
 		ret = __wait_localport_unreg(lport);
 		if (ret)
 			pr_warn("%s: Failed deleting local port\n", __func__);
 
+		fcloop_lport_put(lport);
+
 		spin_lock_irqsave(&fcloop_lock, flags);
 	}
 

-- 
2.48.1


