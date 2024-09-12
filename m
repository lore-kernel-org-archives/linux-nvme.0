Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07126EE6452
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Sep 2024 06:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DMbqE4AgM7uFFSUHnc+6EB98VaNiG/nfbUpqcREF+fQ=; b=Syd5dqshEFTgX+3/G3kGmmEXzL
	XIKu/L6mAxCNzPIDTUxYuW+xRQK/DdCEFUMWD4x2uqtMZR3T+c+nAyvYEdcXMv7t93DRfg75RvTut
	mT1282F8oSLqwyoC1nYHFKXIA9pQbYfxcgW4TYMKlSq2n9D0F+JlFwpR1cn2tpAwQzyGN7/Ay7IYp
	yFtUKFRj5BpJzta6kEAFOtfW4ftwMhlVNcBwMlFWmePgbhVEO6mRpdOrPJwJqy/TUbFV1LvEKzlcW
	UDt87txVAKD5jbmfaWwJVxWHjY1UdzZ9Y2JfpPQWaNVBS1AorRQbOMigV0l05IL7SftFRy4t2Q8Z0
	5k/cFdFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYf-0000000C3NT-0Msa;
	Thu, 12 Sep 2024 06:44:01 +0000
Received: from mta-04.yadro.com ([89.207.88.248])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sodYa-0000000C3KZ-1ASn
	for linux-nvme@lists.infradead.org;
	Thu, 12 Sep 2024 06:43:57 +0000
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com E834EC0005
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-04;
	t=1726123434; bh=DMbqE4AgM7uFFSUHnc+6EB98VaNiG/nfbUpqcREF+fQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=M54UKfu/JShxCgIZ5sPzD4SqfVi9rXQ1C/2TsdDCqoj+KSw1AnutrsWe5tYcD/V8Y
	 S3ssHmR/fNtswRMyFzhSy0A5myfMiOssTwFafDqiehOt9HmQnbEp2BpzxIm6Qvpd82
	 ZjsVin8feBLPpa6elU4xsOExWLuNZzsk+IO0PGSMKIPoiwIeWdRt/wWbw5BSKGxXLd
	 +qvTHwusGP7O6HtwkLAhx8d2d44xD8tf9N8uGc2Uf72HpKmax5aCh6xNZnHN4gEHip
	 ucXOXUMJ0swoNxXAJyfkMi8GQARtiyx3D/O48gYXD0JbPx+C6L8Ko3tXUlQSf+rmFK
	 J/pnc6+M0Q9sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yadro.com; s=mta-03;
	t=1726123434; bh=DMbqE4AgM7uFFSUHnc+6EB98VaNiG/nfbUpqcREF+fQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=mc66OyUGRaj9D7c0win878qfR10cOiakT9jcyygm4eJLYpUK6/YNcXjy+5X7hmKLB
	 9I73MKgzoTkG92z6jI+zMehsCUU/F8h/FrQOX6IAewRv8hxFJ+Pk1r7juDp3t8NeTQ
	 afWd2F35lIMvyXyGsLA2h09uH45zwfHdxir95NgTgYKfp/FEsChxlcAO3oh1ESa1Rf
	 N8ETME6nyeIwalkpoRg7onO56SQe8gHTZiyXn4sgbL/dlzPS5bJg0BxMu0UhOuSAXr
	 IJ6CxBaclZlSycg00UDCzhmkU2PW7p3hLwdn2ToJ7rp4xB/8i0J21lYYLhrroCBmkF
	 EBBK3L0qRuMUw==
From: Dmitry Bogdanov <d.bogdanov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, James Smart <james.smart@broadcom.com>
CC: <linux-nvme@lists.infradead.org>, <linux@yadro.com>, Dmitry Bogdanov
	<d.bogdanov@yadro.com>
Subject: [PATCH 6/7] nvmet: make fused commands be atomic
Date: Thu, 12 Sep 2024 09:42:58 +0300
Message-ID: <20240912064259.5228-7-d.bogdanov@yadro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912064259.5228-1-d.bogdanov@yadro.com>
References: <20240912064259.5228-1-d.bogdanov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-09.corp.yadro.com (172.17.11.59)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240911_234356_514757_3D8E3594 
X-CRM114-Status: UNSURE (   9.96  )
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

Ensure that the fused commands are executed in atomic manner. One Fused
pair per whole namespace.

Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
---
 drivers/nvme/target/core.c  | 6 ++++++
 drivers/nvme/target/nvmet.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d5cc760ba2f4..1ab6d8f7a7b1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -705,6 +705,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	uuid_gen(&ns->uuid);
 	ns->buffered_io = false;
 	ns->csi = NVME_CSI_NVM;
+	sema_init(&ns->caw_lock, 1);
 
 	return ns;
 }
@@ -872,6 +873,8 @@ static void __nvmet_fused_req_complete(struct nvmet_req *req,
 		spin_unlock(&second_req->fused_lock);
 		spin_unlock_irqrestore(&first_req->fused_lock, flags);
 
+		up(&req->ns->caw_lock);
+
 		if (first_req->ns)
 			nvmet_put_namespace(first_req->ns);
 		first_req->ops->queue_response(first_req);
@@ -1376,6 +1379,8 @@ void nvmet_req_execute(struct nvmet_req *req)
 			if (req->fused_pair->fused_state == NVMET_FUSED_STATE_EXECUTING) {
 				spin_unlock(&req->fused_pair->fused_lock);
 				spin_unlock(&req->fused_lock);
+
+				down(&req->ns->caw_lock);
 				req->execute(req);
 				return;
 			}
@@ -1411,6 +1416,7 @@ void nvmet_req_execute(struct nvmet_req *req)
 			spin_unlock(&req->fused_lock);
 			spin_unlock(&first_req->fused_lock);
 			/* both fused command are ready to execute */
+			down(&req->ns->caw_lock);
 			first_req->execute(first_req);
 			return;
 		}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 1278b81c85a7..1dc9814c7a8c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -85,6 +85,7 @@ struct nvmet_ns {
 	int			pi_type;
 	int			metadata_size;
 	u8			csi;
+	struct semaphore	caw_lock;
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
-- 
2.25.1


