Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403ACC55174
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Aug 2026 06:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/FE8ttUnLC4/HPgKY+wP8Klu+NVFl8eobi0/CL9TYD0=; b=yclTD56uev9zVN7HZar1rlT6TX
	BsDOu8w7CqxsWxKFSe9Nqhkvm/uAYYjJ7/QpYVS3ofcjAHJrRkT5tmp0uXQkt0NCVugbPsMA63mYq
	5U08/pdxjas6yTdS5CTOzqQm03tRlFn3goArYGA3XKPwdiYislcK+T42llQI5yuM4jzfyurOyzpmn
	AiI7AK1zXe3Bj5iuoOX+TQE42kFrUZISqqEp1/9MTH81+76w3sd2rrvVuD+h2GAbEtPaPBozWXrhM
	J9xN1mtcAQ7TWNgeU1VmrGlvkVq2KEATeLTUgYw7Wodb7Eslo/cb9G/mWHqUVL+n9HNxP2nXe+8YU
	NT3aPYaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq2o7-0000000DvYu-3RVE;
	Sat, 01 Aug 2026 06:02:51 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq2o5-0000000DvXc-315t
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 06:02:50 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso15190305ad.3
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jul 2026 23:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785564169; x=1786168969; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/FE8ttUnLC4/HPgKY+wP8Klu+NVFl8eobi0/CL9TYD0=;
        b=b3kDVh46NRnye6iKlqACtrACYjCXb9ppdXlH+xUSaA6v8APJ89y7xmhn5HN2qBlht8
         P6tQbhvhUsHIvMZT2RoXXJJX7mpyfnuVqK4hHl/Tkl8WuVG7MAaZarDoxDf6b+ynYzMB
         agBJ6YSAIaKw0ivhuiw3tC7M0UOZb5TbUgWCzjYEJMUnODtJJtTOeBeI1+dWB5mpdrPQ
         bk87hW/D8HWx8Uhk1oPb7kbeEMYBuZVmEtUMknvFAGN+hw7mWCFSZsw97+BvuyMKPlMm
         +C9rXRpsgagdtz6HZCNm8IE5UvlbC4Hyl1F6PDiu5lQu7qDHP9hfaPEgJaTJLrke9ylz
         UoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785564169; x=1786168969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/FE8ttUnLC4/HPgKY+wP8Klu+NVFl8eobi0/CL9TYD0=;
        b=mbsUSIXwXlkkGZgPEXlPt8R1iGv16kxUYA0ynC70f/zkRiHPb5/65MJhKnpP7NLkHP
         dQUVACr7J7sXZF06KFPbmvZcKByAKCDjdtSaDzjiJDlZ7yvyouFnCimAMnytiVHni86E
         6f8ntCEiimN+zcmUlUDjpOeUvOtczIME992hjkHPSosIDWk/u6ayXM3jsIRHNDgo/NgA
         8d2dp4zuU/JRN4d7aXagtl4JVAQ5U88Vif6PLiKDDegrqY4nnrWz6t8gvdVrEibuFQF3
         3QigqawcxVe+GDkK47mff156TTZaWO8NXpxT8P6QAlmatdMu1pFXwKBBY4yrYh9rWDD5
         r/EQ==
X-Gm-Message-State: AOJu0Yw+BOdmdqDpjZnNNzyg2nxBo6Cv81P4vUr7gKuRQFYv2z6p5V9c
	AN/VQyNQoNBgDNd8dizhP5q+ogxHpQbh8Jys+vz/llcm+Kboc73OZKoWN968aFc2Jb4gtdboFQG
	TlDzwsxA=
X-Gm-Gg: AR+sD13GdJrk8lONFnqcCmbwazMFgbssGM85sCCnWwbsP+Jjdsg3qB8m2hYOeC+a5+T
	OoFitqSsoWpmz5HqY6RGgtVozDY6V0DQjAz1lQuib/PXCXmpZ3zMuJoYgdBXGKTOkrN7rQo4UXk
	RjrxJ0YprAwMHwCAjOQ2NdPYVy6OvzGsFd0bS1udfYSCxK4+w53WHYTfmOzEQvw2eTzgMNjZhBV
	zFUOKw1gIOon3JKCsXLM16Zj6k/fKs+0a9/8P5IPdHPNKTfRPfmrCK/O9K44K5M2QNXCRgTBqM9
	pWdUAAOJjt5Adm98sRZBYEb8zD8wg2y3DzKWeeU+UIeTv2mrNU8qkMhr8DDmxlVGmOeeulHYzQ0
	6yDkgvtSb2BbcLhMZmBGCaf3DlxdWbwsyAwgpCtDn8ag2W9liMApDu7p+CN6M7GTQnR2vlDOUqK
	K5PolgbN8kZR2LShoxYziyMi72gD+pzo7Uo5vYhE3AUMe3kIaUb3UqFcFOFR4neTDX32aaRChYW
	7MHRg3+4xD2t2Wlg+KtESQ=
X-Received: by 2002:a17:90b:440d:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-38fbc438399mr2464915a91.14.1785564169033;
        Fri, 31 Jul 2026 23:02:49 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb2bae2efsm1598856a91.11.2026.07.31.23.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:02:48 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] nvme-tcp: do not accept C2HData based on blk_rq_payload_bytes() alone
Date: Sat,  1 Aug 2026 15:02:01 +0900
Message-ID: <20260801060201.1879499-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801060201.1879499-1-yhlee@isslab.korea.ac.kr>
References: <20260801060201.1879499-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_230249_798016_E0094852 
X-CRM114-Status: GOOD (  15.78  )
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

Commit 25e5cb780e62 ("nvme-tcp: fix possible crash in write_zeroes
processing") established that blk_rq_payload_bytes() must not be read
without first checking blk_rq_nr_phys_segments(), and recorded the
result in nvme_tcp_setup_cmd_pdu() as req->data_len. The receive side
was left as it was, so nvme_tcp_handle_c2h_data() still reads
blk_rq_payload_bytes() itself.

The two differ for REQ_OP_WRITE_ZEROES, which has no physical segments
but a non-zero blk_rq_bytes(). Setup leaves req->iter untouched while
the receive gate lets a C2HData through, so nvme_tcp_recv_data() copies
into whatever the previous command on that tag left there. The
driver-private area is zeroed when the tag set is allocated and never
again.

Reproduced with a test target that leaves a residual iterator on a tag
and then sends a C2HData for a WRITE_ZEROES command on the same tag:

BUG: KASAN: wild-memory-access in _copy_to_iter+0x642/0x1330
Write of size 512 at addr ffe728c2175dfa81 by task kworker/0:1H/103

CPU: 0 UID: 0 PID: 103 Comm: kworker/0:1H Not tainted 7.2.0-rc5-NVMETCP-gf5098b6bae76 #1 PREEMPT(lazy)
Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: nvme_tcp_wq nvme_tcp_io_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x53/0x70
 kasan_report+0xce/0x100
 ? _copy_to_iter+0x642/0x1330
 kasan_check_range+0x105/0x1b0
 __asan_memcpy+0x3c/0x60
 _copy_to_iter+0x642/0x1330
 ? __pfx_sock_has_perm+0x10/0x10
 ? worker_thread+0x45b/0xd10
 ? __pfx__copy_to_iter+0x10/0x10
 ? _raw_spin_lock_bh+0x83/0xe0
 ? __pfx__raw_spin_lock_bh+0x10/0x10
 __skb_datagram_iter+0xf3/0x820
 ? __pfx_simple_copy_to_iter+0x10/0x10
 ? __asan_memcpy+0x3c/0x60
 ? skb_copy_bits+0x58d/0x830
 skb_copy_datagram_iter+0x37/0x120
 nvme_tcp_recv_skb+0xa07/0x4320
 ? __pfx_nvme_tcp_recv_skb+0x10/0x10
 __tcp_read_sock+0x1ab/0x810
 ? __pfx_nvme_tcp_recv_skb+0x10/0x10
 ? __pfx_lock_sock_nested+0x10/0x10
 ? __pfx___tcp_read_sock+0x10/0x10
 nvme_tcp_try_recv+0x152/0x1e0
 ? __pfx_nvme_tcp_try_recv+0x10/0x10
 ? __pfx_mutex_unlock+0x10/0x10
 nvme_tcp_io_work+0x1e4/0x6c0
 ? __schedule+0x181a/0x49f0
 ? __pfx_nvme_tcp_io_work+0x10/0x10
 process_one_work+0x633/0x1030

Test req->data_len instead. It is zero whenever blk_rq_payload_bytes()
is zero, so nothing the old test caught is lost, and it is additionally
zero when there are no physical segments. Setup initialises the
iterator only when both req->curr_bio and req->data_len are set, so the
gate now asks the same two questions.

Fixes: 25e5cb780e62 ("nvme-tcp: fix possible crash in write_zeroes processing")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/nvme/host/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4b72f555495d..dc2aa9b01f20 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -668,6 +668,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 		struct nvme_tcp_data_pdu *pdu)
 {
+	struct nvme_tcp_request *req;
 	struct request *rq;
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
@@ -678,7 +679,8 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 		return -ENOENT;
 	}
 
-	if (!blk_rq_payload_bytes(rq)) {
+	req = blk_mq_rq_to_pdu(rq);
+	if (!req->curr_bio || !req->data_len) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x unexpected data\n",
 			nvme_tcp_queue_id(queue), rq->tag);
-- 
2.43.0


