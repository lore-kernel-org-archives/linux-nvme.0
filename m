Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 607AECA5FA2
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2026 15:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XBU2jM7DrC1QbY7mAZYFQZnTdG21byzKYq2Cu4WLBZU=; b=x9Wa+KlhgmyIuNdWKIp9ysjfGx
	XTNDXnjuwX1B0JtT+82FuPqajjFzraN6p11pRl18IQsodmu7SANMVFVeWTm2/i6y9pnNGI3MYiL3D
	RN1tm+72//JuwzVtuzf8p6FwEW+gH1s8WVP03sJJ3X0UuC2ZoBZZUwQ2inL3o6sCC6VijOukahp+w
	lnjHTiLhcSK86sFpsmC4N0p3EwD+lUfWxjNHpdujg04RAzpRQBBhuwDFmMmPP5qx7r99alP4RSJU9
	E41nUUhhGuwQogTSGtzsR0LQ4Kf6ygzET4EyGpFJ5G1no/vXfBcfRzTa17YiCZcjYeRGsTkWmgu4d
	hMm+oZnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBDQu-00000000vdy-3mgH;
	Mon, 28 Sep 2026 15:38:24 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBDQr-00000000vdN-49Og
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 15:38:24 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so1651096a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2026 08:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1790609900; x=1791214700; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XBU2jM7DrC1QbY7mAZYFQZnTdG21byzKYq2Cu4WLBZU=;
        b=eNkPkbn6pYgFMyVo31yk22nWBa4+gDtU+42zEoe9MLU1Bk9PkbE8g1vopMMDYGYacT
         iez4BEMe4kduYKG6HNWr4XThqj7SyVEtH/0aXou2cq2udbYVpmAIDpmEmM7KLnvve0ig
         48qbrlpdNJ+gW8wXWQNWbkUIync9kjkScnmizf7QXcHZElcLe75SrixmaoGZFRRIcA+q
         ZnykCB80qJlnpvSqboiN0tIAHtPNHSgTZJI2Cfj3Ozb5KQ2apUlwE7rKLUyvC7CI0VmU
         dUhGkf/aAKmJNV0ynKtJygyx+MHgXzDcrfmAVuDwfkLJecUSznk0VhMPSHw8DIBjnzXX
         N93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790609900; x=1791214700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XBU2jM7DrC1QbY7mAZYFQZnTdG21byzKYq2Cu4WLBZU=;
        b=jkqOLW+o4fwceUhGsEl0i9r5hTujoj3uXMwpyZLbLsJWLCT/AlRws/NMg6DGVoeVH2
         k+Gp3YCz1jBlFfQPEHwRh2/ozDDzpcHQ6Pz12HYOXDfp9WSREFHm8v300GB/A+EF/mYG
         jMHx7gwjBokIp3VKoRAu0oC5K0V62aTdo4ZVtx3Whleh86NCMeoVXnyIhqnPQ1B/9v5I
         bu3tySGBc8kuCRdeyQYcsmj/iIN0oPmnArMxzO04CJLb9m7g+dAhgaIGBpQ0+J9yKZoI
         4mx2jhqBrqOhYAhas5H1qLJBcajTNZKZKDCoGXSP/aKIntRX5EljOdUMLStFuxYB/JrA
         JmbA==
X-Gm-Message-State: AFq9FYIdbAuEJaHGrVSzEX5OZLpyfaDNMtOxv4FN6iF1RMXt2PAJqAmi
	neZKU5P7IrUVFCzSjZvXs/SGwGj4vtzc2uIPucQ7NTydD/ioMcjA6JKiCuyO/Sftsx8m7D2UWi+
	+ER+zcH8=
X-Gm-Gg: AYBFou1pIBUhCvMNLi5sgGa7rxKTDnpdx8Bcqa5tHCLjc9Ky5KGlnhrBovIlT1sHOns
	kHgan9KNdLj9PqNRRzWyVhwVlTXG5epHQIdPY2Uc1l77yXG60nHv8VJ7tF4YAVH54IxxvVEIYJY
	gnLAxjLAmknPjyVKlf3NETD1oCfbPgNz7BmRUJjlNtI+vzqkq26plt/3bfzhh33d/m7O7uG///U
	7O6vda9QmNmC8DYyW1Zp5x2F3uDXo0LdXBIiOcJ2Kn7cngNQsEodJv/Ro8gN29q/so9PohRctAN
	7tnCxzBJwSnReUDb+JLzPJl72YTRX+qUMf3vpcOsXRvnSK1vNehpVqShgKu1NoH2FhAFNr6HUTY
	J022V1tzT6LMNHOqy9jS99vuAJRuiqE0jUDPRC+FoERxrpN09NBp86Ue5OLdOyNCWLjj9RlrTFu
	k/QCE1LaySNOtcjcLvAmeMWO298H96GzCiIeLt5sZI9n7LV1VvXartoAyEZfI+4L31zI54I4mnk
	O/m6DGQ6nXdrDEaKbQf3Q==
X-Received: by 2002:a17:902:ebca:b0:2df:9e2d:8629 with SMTP id d9443c01a7336-2df9e2d8cf3mr52153435ad.16.1790609900356;
        Mon, 28 Sep 2026 08:38:20 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:d08e:5326:b1b4:da35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df90fbc951sm44209335ad.8.2026.09.28.08.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 08:38:19 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-rdma: don't complete a request after a bogus remote invalidation
Date: Tue, 29 Sep 2026 00:38:11 +0900
Message-ID: <20260928153811.1466359-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_083822_193397_5CAEC35A 
X-CRM114-Status: GOOD (  16.65  )
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

When a remote invalidation names an rkey that is not the one we handed out
for this request, nvme_rdma_process_nvme_rsp() logs and schedules error
recovery, then falls through to nvme_rdma_end_request().  The request is
completed with req->mr never invalidated, and nvme_rdma_unmap_data() hands
it back with ib_mr_pool_put(), which only puts it on a list.  The rkey
stays valid and still maps the pages the completed read filled, so a
controller that sent the bogus invalidation can write into those pages
after pread() has returned.

Return instead, the way the local invalidation path below already does,
and leave the request for error recovery to cancel.

Fixes: 3ef0279bb0031 ("nvme-rdma: Check remotely invalidated rkey matches our expected rkey")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
Reproduced on soft-RoCE (rxe), two nodes.  The target is modified to answer
one request with the rkey of another request that is still in flight, and
then to write 0xBD through the rkey the initiator has just reported as
bogus.  The NVMETHOSTILE lines are that scaffolding and are not part of
this patch.  The namespace holds 0x5A and the reader re-checks its buffer
after pread() has returned.

initiator:
  nvme nvme0: Bogus remote invalidation for rkey 0x35f4
target:
  nvmet_rdma: NVMETHOSTILE forcewr POST LEAKED rkey=0x35f4 addr=0xffff88807ffdd000 len=4096 ret=0 n=1
  nvmet_rdma: NVMETHOSTILE forcewr DONE ACCEPTED n=1
initiator:
  BCHECK[B] CORRUPT iter=350 poll=0ms pre_clean=1 off=0 p1_bytes=4096 p0_bytes=61440
  BCHECK[B] DONE iters=392 clean_p0=392 ioerr=0 CORRUPT_HITS=1 POST_COMPLETION=1

pre_clean=1 is the buffer intact at the instant pread() returned, and
p0_bytes=61440 is the remainder of it still holding 0x5A.  0x35f4 is the
rkey the initiator reported as bogus and the rkey the target then wrote
through.  With this patch POST_COMPLETION stayed 0 over five runs.

It is a race, so it is probabilistic rather than reliable, and every bogus
invalidation also trips error recovery, so the corruption arrives together
with a controller reset.  I only have rxe here; I have not checked how a
real RoCE HCA responder treats a write through an MR the ULP has stopped
using.  What I saw is an integrity violation on a buffer that is still
mapped, not a use-after-free.

Invalidating the MR locally before completing the request, which is what
the code did before 3ef0279bb0031, also closes it and is the other way to
go here.

 drivers/nvme/host/rdma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9cb811a2ce1f7..5b9b540693b51 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1748,6 +1748,7 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 				"Bogus remote invalidation for rkey %#x\n",
 				req->mr ? req->mr->rkey : 0);
 			nvme_rdma_error_recovery(queue->ctrl);
+			return;
 		}
 	} else if (req->mr) {
 		int ret;
-- 
2.43.0


