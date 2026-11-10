Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E13606B272
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=R+SwlcCk;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=gXTUv1ES
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Subject:Cc:To:
	From:Mime-Version:Date:References:In-Reply-To:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QZB0q+GEpidbmtHQLrBeax2DjC60l4QpR8AzTM4Nb3c=; b=R+SwlcCkr2zHIaMbCBsG0PIysO
	WgvPmFRs1WxIYesOYw6tN2kLD4Wul//lMPpAWZG9oYiG+d9qGtl4sZHJLed3ILJ9aBtQ04ZgUNELg
	aygcd2ufvSnSW26iio5+uSL4t9zq92ffvoBEBHIndGwkJ16esl7RSpVr3sHmNx/2o3hckVAE9+rsh
	AEMANF6lPGFHZ7dLbTCfOZryEhyNOqKFprK1M8BqsmBbKurhMLjypDhpW8QWdud7hXosQJLVXYOXl
	rsF63ZRdCiv83kiusoEw9FKrlkonk/EDasiPY0D0K7jV/huN0d+um6GN0mriyyPStG4kkU/899F5U
	gBA4FEsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFhv-00000007lRh-3NmJ;
	Wed, 11 Nov 2026 21:18:15 +0000
Received: from mxhk.zte.com.cn ([160.30.148.35])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQnNV-00000004J5q-2GMq
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 15:03:18 +0000
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jP8zP5jvlz8Xrnw;
	Tue, 10 Nov 2026 23:03:13 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794322993;
	bh=Q5o/fJZPR3UnMWbcd2NNFI+2ETviUTMVjsZraiBnuZA=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=gXTUv1ES9voehtz+xpZmiudAhL9Tg9uZP0lgp7Qvsl55en7pVNQm/GNYL7yeWRRyR
	 cuRzY5VreybII2Y35+qRQR+gioNhkYKYky6E16bLhHGsAsCaLciCUqlJ0YuP/H496c
	 fzmOcI7RcJdVJo+Q9HyFfrSlgRopHUdzuoWHMSqBAFdGUJQWusjpKwY6rKA84wkcGR
	 KrFTYvgVIiCWQWqiZS/JThzR5GB7zYvfWZ5alam75xmuFtmHeLQFgvBfnG9NBLnZMM
	 g0QHHXneLyJEkVTigX1Tr0l8dJx5oNaTjUgfAvsIdWmiwXdQKEbyF8yCEuYbnwUqZF
	 RlKSjbfoe5zbg==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6AAF35mh011118;
	Tue, 10 Nov 2026 23:03:06 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:09 +0800 (CST)
X-Zmail-TransId: 2af96af3322d603-01c47
X-Mailer: Zmail v1.0
Message-ID: <20261110230309524NeYut_cyzQcD3jcjj_beq@zte.com.cn>
In-Reply-To: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn>
References: 20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn
Date: Tue, 10 Nov 2026 23:03:09 +0800 (CST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <kbusch@kernel.org>, <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>
Cc: <justin.tee@broadcom.com>, <nareshgottumukkala83@gmail.com>,
        <paul.ely@broadcom.com>, <kch@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDEvNl0gbnZtZS1sb29wOiByZWxlYXNlIHRoZSB0YXJnZXQgcmVxdWVzdCB3aGVuIFNHIHNldHVwIGZhaWxz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6AAF35mh011118
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 10 Nov 2026 23:03:13 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF33231.001/4jP8zP5jvlz8Xrnw
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_070317_777290_414436C8 
X-CRM114-Status: UNSURE (   8.26  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Wed, 11 Nov 2026 13:17:03 -0800
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shao Mingyin <shao.mingyin@zte.com.cn>

nvme_loop_queue_rq() calls nvmet_req_init(), which takes a reference on
the submission queue percpu ref, pins the namespace and, for a
reservation-enabled namespace, takes a per-controller PR reference.  If
sg_alloc_table_chained() then fails under memory pressure, the function
returns BLK_STS_RESOURCE without calling nvmet_req_uninit().  blk-mq
retries the same request and nvmet_req_init() overwrites req->ns and
req->pc_ref, leaking the queue, namespace and PR references taken by the
failed attempt each time this happens.

Release the request before returning BLK_STS_RESOURCE.

Fixes: 3a85a5de29ea ("nvme-loop: add a NVMe loopback host driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG guest, 8 vCPUs) with the loop
transport and a file-backed namespace on tmpfs.

The scatterlist allocation was failed with failslab, narrowed to
nvme_loop_queue_rq() using the stack-trace filter.  One request is not
enough: nvme-loop caps it at NVME_LOOP_MAX_SEGMENTS (256), i.e. two
128-entry chunks, and the sgpool mempool keeps two elements in reserve,
so the allocation only fails when several requests are in flight.
Eight concurrent 1020 KiB passthrough writes on /dev/ng0n1, with
non-contiguous pages so that every 4 KiB is its own scatterlist entry,
hit it; blk-mq then retries the same request.

  unpatched                              patched
  delete_controller write never returns  completes in about 200 ms
  blocked in nvmet_sq_destroy()          -

The blocked task is in

  nvmet_sq_destroy
  nvme_loop_destroy_io_queues
  nvme_loop_shutdown_ctrl

waiting for sq->confirm_done because the submission queue reference
was leaked.  The failed attempt also leaks its namespace and any PR
reference when the retry overwrites the request fields.

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index e579a307798b..e95167a13708 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -159,6 +159,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 				blk_rq_nr_phys_segments(req),
 				iod->sg_table.sgl, NVME_INLINE_SG_CNT)) {
 			nvme_cleanup_cmd(req);
+			nvmet_req_uninit(&iod->req);
 			return BLK_STS_RESOURCE;
 		}
 
-- 
2.27.0

