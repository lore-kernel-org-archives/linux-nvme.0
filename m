Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7B606A31A
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Oct 2026 21:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=sNRH6tsn;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YlJFk8Ua
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=MWhF1KWrf55vCpf16EXuustcrkVB/1ZS8QurJvWheCo=; b=sNRH6tsn2n8SFyC4KFAeyCs8S8
	rxeIOPBNBuW7CxNG5uFcrFlD0aE9G210qVClcrJ+8yqtE0mxSxIBD/atJSCmpKN/gRyYR3+R7HSpa
	4St8uJvmKcyUzJMsBthJuJI8iMgcBOD4qeXGvnqrsPDzc+CLp2pfAHo5eUHKTr9bIAwKyoPgqM65h
	91xftR+2utEKe874HTTzVas7iyY1tx0q2biXrHEfRO3FkgLRh7/1vvM2b+e9ha4b6vEXC2kt2EI8w
	/0QLEim8iX9gZhVM2aYIfldsPpD5Xq4dEyEzTOSvJTc3Y2gOMUCGO3GvhCzU/lupmibCvdfDsD918
	fmPvy1GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKjSE-00000000Yw4-2Kh2;
	Sat, 24 Oct 2026 21:39:06 +0000
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKjSC-00000000Yvj-2y6K
	for linux-nvme@lists.infradead.org;
	Sat, 24 Oct 2026 21:39:05 +0000
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-98c6e050c5dso974835241.0
        for <linux-nvme@lists.infradead.org>; Sat, 24 Oct 2026 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792877942; x=1793482742; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MWhF1KWrf55vCpf16EXuustcrkVB/1ZS8QurJvWheCo=;
        b=YlJFk8UarESuShKGX6iR33l9o/WWMwtd8tSaHOIpOCLHwSkRr4iTf5pC47jqaAO/+h
         Hc805QgWW4By2ZpJ7b6YcwepSxOeoarYzoBPUIbHmsqFPFXnSATJt4kSy79MUUv9jERO
         +Zw60Jz25CfAHychyADvrZVENDlBr9RCIz3b5o9UrZIguKwJ9f08lgBZOW/G5DpmwdLr
         770ng+hoC5RqptLIDTflYPNH6CLOQ/1hNNynzNcQNqKDx4Wi63p9gUrNFzZVG0p96B2E
         IOgxmUOJqIFxBro40c4CowD5ik0Pnwx69X65zCgMQe/yL2rsLbahLGTtK3uo+/tcMuDz
         NI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792877942; x=1793482742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MWhF1KWrf55vCpf16EXuustcrkVB/1ZS8QurJvWheCo=;
        b=OmYIvKBcFkEvVgnQuLevsPWU+G/oPNdOjf3dxIDZvvhMEQHq6pzK7Ws/QTs4eb4Mgg
         CJdkdY9cdox5lr++KpDLnFoOcpXaWflhuX+vzr/gQX0NXW+TAMOCeK+rKhnU4v46x+0i
         uyL9AzsETzl00CIjyeolL5kadqf3/YvuZHxTPE2akPRJA7Ty4O6QRwA3j+lnA4xzhU3L
         GG6o886D7Sz0V4YNs8BPDIVphLqxb+j/WiumeSQiopsFgfJ/24XmDq/WTOJ275OX1g2T
         qOXONG2nY/4hXh2lstTTwcowsA4TYWAseeV4YD+F2Td91z0haPo8uZstAQ0EZn8vagkf
         ohjA==
X-Gm-Message-State: AFq9FYI15MwN2YQyG2c190p+uLHiMS0OXb0hqxwOR3uHpjOiUinanEgJ
	Qpd//MU3A+XapoH7EhbtdqdSPwlDdEaV40LU0z3y+nKKxWtiP9MQNN8KOv/18fYajX4=
X-Gm-Gg: AYBFou08dEeam5MUnR63ArGF/wJSshGBlfKlKlmZmVqdi3DfaFLhVXlh6GBE2THc5QW
	NDJPaBMs+rguQ0vzETGRNbk1TiXGHs7DDCOEFlNAUirN/Yds0SvI/uMC/HuYFYzXx/guFu/RROI
	Kia7njhEMfz8lyy2m31S482nIIjf9c4UlGgb6eu+BVSX9xOGsbAOJZTPbTLdMDkcjjbbl8nBtSZ
	j7R88jiX4w6bco+9tc9EUbh+K2yK+1Y6/1BVu2pykLIX+yLJ2mnCla7sLkr5REoDXqUwxS5fbsn
	VGGsofrTzPEebXsKAzxnYl+pziPjLrhuUE4JKC0c/+OrQMn/AfV/C4ZBLcNAx+hKGHQ5vNrOHI/
	lONkBc2FZJJTZleyAEM/tiCOj9e8mmZXYpcd97g0Q3rZI6EmExzO0gU+lh5zRT+5ge9bZqn59U2
	eJ5LAMJbGkl5pcdhexo9sRiCzAjNiL+36+kz1RNqdSTySalygqgHrpz+aWO0OOTYs1qetJ5jICz
	BaziSHSDMFC9HEVmC1VW+6RRStvcI3DMN8yr1H3W/YMiC5iKN8O1BQQtQ7R+xre
X-Received: by 2002:a05:6102:b10:b0:7cc:2712:cb0b with SMTP id ada2fe7eead31-7ce5cd41502mr969522137.17.1792877942564;
        Sat, 24 Oct 2026 14:39:02 -0700 (PDT)
Received: from bridge.. ([2804:14d:ba6b:8339:de12:7640:de42:74c])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ce5e23b13csm3128627137.8.2026.10.24.14.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 14:39:01 -0700 (PDT)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	sgogte@purestorage.com,
	mgurtovoy@nvidia.com,
	israelr@nvidia.com,
	wagi@kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-rdma: fix NULL metadata_sgl dereference with T10-PI
Date: Sat, 24 Oct 2026 18:37:37 -0300
Message-ID: <20261024213737.506824-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261024_143904_760510_82446776 
X-CRM114-Status: GOOD (  15.13  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation
and startup") the I/O tag set is allocated before the I/O queues.
nvme_rdma_init_request() only sets req->metadata_sgl if
queue->pi_support is set, but pi_support is only set later by
nvme_rdma_alloc_queue(), so every I/O request is left with a NULL
metadata_sgl.

With an RDMA device that supports integrity and a namespace formatted
with protection information, nvme_rdma_dma_map_req() then dereferences
the NULL pointer on the first integrity I/O, already during the
namespace scan when there is more than one I/O queue.

Queues that a later reconnect adds for the first time have the same
problem.

Check queue_idx and the controller's max_integrity_segments instead,
which is what nvme_rdma_alloc_queue() derives pi_support from.

Fixes: 2a8513091d2f ("nvme-rdma: parallelize I/O queue allocation and startup")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---
Based on nvme-7.4 (aaedcff90148); also applies to mainline and v7.3.

Found by code reading while looking at the same reorder in nvme-tcp.
Without PI-capable hardware (only mlx5 supports it) I could not
reproduce the oops. On rxe in QEMU, a debug print showed every I/O
request initialized before its queue was allocated, and with the patch
connect, I/O and a reconnect growing the queues from 2 to 4 still work.
A Tested-by from someone with ConnectX and a PI namespace is welcome.

 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5b9b540693b5..07216890f75c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -313,7 +313,7 @@ static int nvme_rdma_init_request(struct blk_mq_tag_set *set,
 		return -ENOMEM;
 
 	/* metadata nvme_rdma_sgl struct is located after command's data SGL */
-	if (queue->pi_support)
+	if (queue_idx && ctrl->ctrl.max_integrity_segments)
 		req->metadata_sgl = (void *)nvme_req(rq) +
 			sizeof(struct nvme_rdma_request) +
 			NVME_RDMA_DATA_SGL_SIZE;
-- 
2.43.0


