Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87323C54F54
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RTqF2Y1g9qhorvzshaAVm+gXEaPPh+f9UXW2dSENYhc=; b=JzMm7mOrxynhQEaQOe85f4o2zK
	IY3rTPJIF8SkmXVlAglDdnzC5toOIosKdBsqfPXcNrrSVWjkrB0fHK0ehYfalahbvpMh3PMYD5NId
	AJKU18jXlE/SEIq93zMeraSOmcFaDJR3xss3o2dOOZ1INTgoyer3OYBDgw/SjklV0GuhJXGS8g0z4
	rIgOWmULJrHNOe63eQTzvUKdjL+FzS26Inex7JG3VNTn8luci7I/4z59zVHYC/gMCG7eCg+kIDYIx
	iYMqZu+rgZVKHEH+LHY5lsoSDganQgT8s4IhJP8AKQbxb++l7BykQPcD3dvVSMi9OB+RqMH/zsdLx
	BkIuGjZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpoHD-0000000CiY3-3g16;
	Fri, 31 Jul 2026 14:31:55 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpoHB-0000000CiWI-18Fb
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 14:31:54 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2cc61541f8cso21832455ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 31 Jul 2026 07:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785508312; x=1786113112; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RTqF2Y1g9qhorvzshaAVm+gXEaPPh+f9UXW2dSENYhc=;
        b=RCQtfifF/qrTcCORXI/Tln4uBxTGbnRJMDtOANiJpCEpsbuorhIjduqXQdq8dzTIW4
         CKTlZsuyxakMtmDHn4cWz8ouDFheeWbThIpOxsF+CZspD0vbK+9qesr8++clv85G0qtn
         KLCxWNL3I0lHfCCTj9WpFBzgIX9VJJ48bTWKaQHivfg0dBObD4UfzzDJ19HCUzyYXuvX
         icMmsosJBw2M7QOExqaoengQp7QkOWeqkRQqHtO/pQBLqOwqhN9AGPsf2XpfIsmKJbgG
         ZKOBju1j93KLF1vr4ABb08HDdZsnQFprQI34QHBTTHIMKW8gze5AVg7XXV+U9M+N+KgZ
         A/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785508312; x=1786113112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RTqF2Y1g9qhorvzshaAVm+gXEaPPh+f9UXW2dSENYhc=;
        b=HX56qE3vh8Q6jRl0LZogQ+3PupgsuDfhX3nbl/dvYOw+uhoNS0TdmmyNpoBmxxKFNP
         7faAVTpvcj8naNVPjG17NBGDq/q4lR9d+K+ZWz7Oh/Yc3DLXpD0TuuzxGki1KCdeNgUW
         8n8UQ1Bv6VvUMd4aILYCbT05iGNCsI0LZ0le1R0FWGZkTqplA5cpKR5pX1ommoFdCDAv
         X9YEt5WJBbRUFVfmEsCDrgeOzHuwwy4LzAwbs1kjvMmPsjwscoxoahG8wuN5rrfZEDXu
         rXkHEJVPfYegLvSRND42j1eoRvRlcn7fQBQynSYj324+CO0lL/ukS6ZKSsT4Lt5qCZGq
         4YUw==
X-Gm-Message-State: AOJu0YyY3ykOpUKNsGNNHbdEelpvFgyAQbqbd3QqckclaXAGT9Se2jUC
	rG1jnsH5bAq9OerqJM8Qrkh3917m/rsz8NNxYWO6gatVS0+ilt4X0W/PFv/mX6Khjm0cxqKllLs
	IpL25d/+CzQ==
X-Gm-Gg: AR+sD13Hx2gHPTjEJ7cQiVQF1XU0627KXdKI7mr+vM3AzIiAE5nqG+3CLIk4tCYSAIb
	ZIPEPEfiqnE6h2bWLhUUwy6d9aK9pXwkP3l0of3gY+Och4FYF/6/TxtvBTsCx40QVtNKoofqzFK
	/jWk5a8ssCBUSRuXULL8GyMrE10PWirRhrh0132taLjygQOFovkXqs9MfAOy/XqMM6tdxbTaAY+
	WLz1z9gsvmjbmpE9LFYu/wQI0dsX79f2dFvG52I6hnyaxMQPB4Irjrd3WjXRR6dQ6TNr3da00Es
	zQKx1NtbRa/bxJz6BUasBMy1WIEiLXYUriCQZbk4xwVwmlx41bPmDrJT3QBTaERmBxhcNtlGc4t
	Ib5Agpp3KEG4+HBHZ0XN3VBNfehzl4jmCPrp1Fepv7LsdFK4pDxB8BEPhMAI6kpiN72n8aUl1gn
	HhxLd4TzH197czMA/Ms7ofSBgYGGXzzy2bWJsJFxraI20uE2NALwjfvbz0xmkR0X2kLGQz
X-Received: by 2002:a17:903:b50:b0:2cf:8aa7:7810 with SMTP id d9443c01a7336-2d0482ce66dmr16049695ad.2.1785508312279;
        Fri, 31 Jul 2026 07:31:52 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae19b82sm6203185ad.6.2026.07.31.07.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:31:51 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] nvme-tcp: do not accept C2HData based on blk_rq_payload_bytes() alone
Date: Fri, 31 Jul 2026 23:31:16 +0900
Message-ID: <20260731143116.1870962-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731143116.1870962-1-yhlee@isslab.korea.ac.kr>
References: <20260731143116.1870962-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_073153_314399_D2F6877F 
X-CRM114-Status: GOOD (  17.02  )
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
without first checking that the request has mappable physical segments,
and changed nvme_tcp_setup_cmd_pdu() to record the result of that rule:

	req->data_len = blk_rq_nr_phys_segments(rq) ?
				blk_rq_payload_bytes(rq) : 0;

That rule was applied to the send path. nvme_tcp_handle_c2h_data()
still reads blk_rq_payload_bytes() on its own.

The two differ for REQ_OP_WRITE_ZEROES, which has no physical segments
but a non-zero blk_rq_bytes(). Setup therefore leaves req->iter
uninitialised while the receive gate lets a C2HData PDU through, and
nvme_tcp_recv_data() copies into whatever req->iter holds. The
driver-private area is zeroed only when the tag set is allocated and
never on tag reuse, so that is whatever the previous command on the
same tag left behind.

Reproduced with a test target that first leaves a residual iterator on
a tag, which is behaviour the preceding patch rejects separately, and
then sends a C2HData for a WRITE_ZEROES command on that same tag:

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

Test req->data_len, which is the value the rule already produced. It
subsumes the old test: data_len is zero whenever blk_rq_payload_bytes()
is zero, and additionally zero when there are no physical segments.
nvme_tcp_setup_cmd_pdu() initialises the iterator only when both
req->curr_bio and req->data_len are set, so the gate tests the same two
conditions rather than data_len alone.

Fixes: 25e5cb780e62 ("nvme-tcp: fix possible crash in write_zeroes processing")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/nvme/host/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e93f015fa785..63a734efc2b6 100644
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


