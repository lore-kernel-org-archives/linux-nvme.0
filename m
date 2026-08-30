Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7F0C61DD9
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 13:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hBwz1JGKS6AosuLs2+eWbdC5bsNU5Uv1Qp9D4GtVYpc=; b=ySe9J9EPUtZSxwNqE6QVUMN3Vu
	oCAyOJFQR6FisTuxP4nbeUioH8AqwDqJdGDhjq07nB6Aserfo+U1KGw+RhuTsGZ20B7OXC62bh6BL
	YYxfuS2u0b43dTZIRDEHN3rlEqe8tY67MdEI80RMXULO5TvomRkDDIoBsmJ0QQTp9Y51vHbqx5lmV
	HVTTX2WTZKADDCxqWBEKOrIhLG/RrvVYL4+eXJlAbJ+jpGCdjRB+m7RuE3cbz8Yj3P/0+iMg10zRO
	1YEN4JRXv0M+dFXPyfSwTAf/ZN7lAblW1NAgoogShrmk5wuVMZVG3D+nhGH3TShIZr7ruZkGv923i
	k0nRWH3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0fJj-00000007jo2-1wEW;
	Sun, 30 Aug 2026 13:11:23 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0fJg-00000007jn8-2XNQ
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 13:11:21 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-39682983a0fso3147880a91.3
        for <linux-nvme@lists.infradead.org>; Sun, 30 Aug 2026 06:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788095479; x=1788700279; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hBwz1JGKS6AosuLs2+eWbdC5bsNU5Uv1Qp9D4GtVYpc=;
        b=YOEdlzJOOAOSNzB1a20RQepdB8W6xaIdvbqVzFJFVoHZSuTL49LnroriTQAsQWxxid
         qASgVbiepArRy2WWxQYOmTy2mg7F+yMaxzy5XAd+MaLv/dwkdfEOx8iXYp2Xqpor9sbS
         /mQVWh4zruLjAeNxM/3zJ6KjYvRn1XfFscEf8QH2CFOob56NO4HZwro5RrQevRDJAo0g
         duApgTH8pa4mbzPrGV+6YMHNUYGxxG1fuxibhOdodGOc7Z3fsOT3XYELadpuMKyxzBFu
         VA/jHYwlsCLBGG0P9XoAQaCUVinyxf8cdI3IYnA5ynWRF7cZC47uVRmxq7J3XrMWKsxw
         Etmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788095479; x=1788700279;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hBwz1JGKS6AosuLs2+eWbdC5bsNU5Uv1Qp9D4GtVYpc=;
        b=Mm4mm2bYmixeac7Uiyem6wBZcBtRPfNYdBhow5NmXfmNQvGSl8uHIVsmr0y0LR39D2
         +czgznf0K7rzd8hn3DaoOh9zyN4Tpib1hFYz4UcZxIfk2ql0U+Jcf3jiZQmoq7kORMTE
         +XBegYm1agRDIsZVDMe3IPm1DQT4MUvrvgZE09xUyeSG/sEJqOQAQKm5CBxgTVIoQxiJ
         aUgAGzqmlyebWNC4p3dvwCcB6MjQJTa58tfQQucElvFEQDW4UgIGtWQKJgqO4PEobXkh
         Ockqa/ZmsTN0LWEipwdgAUpqvbCQi7MIiRdRr6vrYAWRQo7dkI3iSm7quY4HyvFh9Y3v
         zqvA==
X-Gm-Message-State: AFuF++mNsK6E/ztOMl3of87I4ZEOx8GG5BPpK6GwpCNdc/MfBtZ21L1F
	Myka559kf4McAZv5BXf2uDWPKukXwVkxNfI9XmPr1geQ2VA49JTVGJ0i5uwGsoz9
X-Gm-Gg: AYBFou1LldmFSx2MEXQoHr14f9aGvtQg63LE4eLVt8A9WqYrvYYTfOVzWaVVNoZmixj
	/vbRuGVcFFBiE6N3/nlNaI7jhVAgCKUShWbHh7U78ghglZvi4OwgcRYn8L2BBpqRX/NLdC4gwZx
	cKY08nkg2kHYZf2ARuSSfKHiVmx7zAAlsC+id1ghUiSPcWT0zeayzr2tLgspOuZIo1XMFW6PwvJ
	+x3NDfHQlEMvxs5BL8D0yitAFXWQchhg2o3QJ0hdxA1n6B/VubJp4xrjr//rm2sUMuDeDveLYxS
	dvstPgac5lVJamMM5QPAmk47SLFoK+IYFDTRsi55Mkk/r0ZYOWnsZCcVrzVZyuSl21bJ4+qEKEq
	81Y8zwjyoKWNbteRdaDhUohQu4Qlo0UU0J2fu07BRB1P9q0O9R3eOZteDhz057zWHFaOJxAoLzZ
	x7EnaVjsM7XiX6t2ncbMHocaMFV/f0pPIyX8MCWP/LBXRU25F6DuxRu5e7z+yTH2p4W3AZYKjxk
	0TgwlTp/cIjyb25yz9rc8sE1zY+hk9Z3nhSPXppxrY=
X-Received: by 2002:a17:90a:da87:b0:36a:5d1f:7b6 with SMTP id 98e67ed59e1d1-396d0d4c42fmr34049069a91.2.1788095479333;
        Sun, 30 Aug 2026 06:11:19 -0700 (PDT)
Received: from hnkz-ubuntu-vm1.mshome.net (flh4-125-195-69-140.tky.mesh.ad.jp. [125.195.69.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fcfa3asm16265468a91.6.2026.08.30.06.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 06:11:18 -0700 (PDT)
From: Kazuki Hanai <hnkz.64@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	Kazuki Hanai <hnkz.64@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-auth: Synchronize timeout work during SQ teardown
Date: Sun, 30 Aug 2026 22:11:05 +0900
Message-ID: <20260830131105.680566-1-hnkz.64@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_061120_650036_BC93BBAB 
X-CRM114-Status: GOOD (  10.96  )
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

nvmet_auth_sq_free() cancels auth_expired_work with
cancel_delayed_work(). If the work has already started, cancellation does
not wait for the callback. Transport teardown can consequently free or
reuse the queue containing struct nvmet_sq while
nvmet_auth_expired_work() still accesses that SQ.

Add a teardown-specific helper that synchronously drains the delayed work
before freeing authentication state, and use it from nvmet_sq_destroy().
Keep the non-synchronous helper for in-band authentication state cleanup,
where the SQ owner remains alive.

Fixes: 1a70200f404a ("nvmet-auth: expire authentication sessions")
Cc: stable@vger.kernel.org
Signed-off-by: Kazuki Hanai <hnkz.64@gmail.com>
---
 drivers/nvme/target/auth.c  | 6 ++++++
 drivers/nvme/target/core.c  | 2 +-
 drivers/nvme/target/nvmet.h | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index edb9627d97b09..a55319bcdbd13 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -238,6 +238,12 @@ void nvmet_auth_sq_free(struct nvmet_sq *sq)
 	sq->dhchap_skey = NULL;
 }
 
+void nvmet_auth_sq_destroy(struct nvmet_sq *sq)
+{
+	cancel_delayed_work_sync(&sq->auth_expired_work);
+	nvmet_auth_sq_free(sq);
+}
+
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
 {
 	ctrl->shash_id = 0;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d74c01c98f194..4b48ca78ce5a8 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -980,7 +980,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 	wait_for_completion(&sq->confirm_done);
 	wait_for_completion(&sq->free_done);
 	percpu_ref_exit(&sq->ref);
-	nvmet_auth_sq_free(sq);
+	nvmet_auth_sq_destroy(sq);
 	nvmet_cq_put(sq->cq);
 
 	/*
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e362d7913a380..dbda55895f4fb 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -924,6 +924,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset);
 void nvmet_auth_sq_init(struct nvmet_sq *sq);
 void nvmet_destroy_auth(struct nvmet_ctrl *ctrl);
 void nvmet_auth_sq_free(struct nvmet_sq *sq);
+void nvmet_auth_sq_destroy(struct nvmet_sq *sq);
 int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dhgroup_id);
 bool nvmet_check_auth_status(struct nvmet_req *req);
 int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
@@ -950,6 +951,7 @@ static inline void nvmet_auth_sq_init(struct nvmet_sq *sq)
 }
 static inline void nvmet_destroy_auth(struct nvmet_ctrl *ctrl) {};
 static inline void nvmet_auth_sq_free(struct nvmet_sq *sq) {};
+static inline void nvmet_auth_sq_destroy(struct nvmet_sq *sq) {};
 static inline bool nvmet_check_auth_status(struct nvmet_req *req)
 {
 	return true;

