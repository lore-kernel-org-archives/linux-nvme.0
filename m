Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB02CC5516F
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Aug 2026 08:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1lwZlW3FZpQI3GTqv3UD9QOcWZj0C5mMeHQ3vQ2kJj0=; b=NZ85n7Tvp7WOGJTGfWB3FqZrqF
	rz8ZQ2jwDmrbH85WmO+0AyDAIxVvVF9V9Drp4wo/loUmd0sgijPRWwsY7P83Hn8vrXfssttHKiGmx
	vfUYfSgS9Q+vmDhjB0Pmqfhdno2Nl7n8+MEXwJWa7QDHNgQoxgI8q0cdl6eEledZULjgAy4bvXBvX
	mXLr2E6YT4g8SQ1rrKYiSVK523KGYzMpOsFRnShfIvvPMaGs1UMMPSN48t/PI3+fxSScNEE5vKZ8B
	yn10tNfH9aBT/ellsINIqtmu+fn8dRIwD1FeaUYxO4IdOHU5nNZ56lEEues9XD3HR8O/gba7CPLRq
	hrM/rdKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq4vf-0000000E2n9-17Xg;
	Sat, 01 Aug 2026 08:18:47 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wq4vc-0000000E2mc-3Hxq
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 08:18:45 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-848479c9bd5so1555010b3a.3
        for <linux-nvme@lists.infradead.org>; Sat, 01 Aug 2026 01:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785572324; x=1786177124; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1lwZlW3FZpQI3GTqv3UD9QOcWZj0C5mMeHQ3vQ2kJj0=;
        b=bcSV51mS+CmGoYP9/ScYWY0lC8ScZow0gY/KS8+esAXBDhcLvkDNsPIM5w86d2tmhN
         TKAEnRbgh9NxxF8zqYrbLbtC1plN8GuJpJZXyNtxCOmJ8x6zIK2ZIy2cfgCajZiTNMuK
         YA12bf+JgKX3n1+ACGUDGSZ11n8t/4Zxhwwdz9HyBca+/rURSeJOEonXNA/jr8fbhmaw
         HaHPa4p8UR6vlHgloMcWN8Q7AtRSotKxMQrbzag5Gjmcfc7HWJoNHjAUeEf5B+Ag1S98
         0ADGUv9SUcIFbmTGpMy28t46DXeMXI1uO5DXgMyzmm8Q4D2MR9GlE9C4to047prA3IXD
         AItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785572324; x=1786177124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1lwZlW3FZpQI3GTqv3UD9QOcWZj0C5mMeHQ3vQ2kJj0=;
        b=TH5f5HnAA4HdvDrmtV1m8vM2Pg35m6pvOAC6Mv9xDNBMDVMxVgcSv7zJ8ESXp19MMT
         Zw5oMPZ1kILHwcYSw/9rptNN9CCUZyBBSMKEHHeuA83cC0TH8AZtaKibFQJN4ZouDyN9
         UGOWfTgu4rXC+M/dRrTF4eO32uopvkvgUr1O3koVavXzBKMMikPdAXBkYdHmkmh90ff0
         pwMqt1jSIMLMdlk+96E/2uR62SoKhxuqiuG3DuRuThr/UNJiEyUjvSWOTSpHl2HE/jZs
         xjfT8yiKrF3FT1IEXAv2dZkkuUBLtYIi6M+ssHWnxnhcWTKFt5GF0mOtDm1E7X0Clqww
         PNfw==
X-Gm-Message-State: AOJu0YxPOz6ENZR41AX0nOKzhUY4hJuOsCXUGB6U3ZDuH2cWkELPsihD
	hvGu+/bdbROx915hOlctfKuxsljNhTYABJB0TkuGLtuFxVu68sQhJBE7P0ZUG6p85fEHJO7hZwJ
	e6XlS
X-Gm-Gg: AR+sD10BUMXYHERevPxHaBn7JpcRqJ+pQ9/cyLcDgWes8AlcMJibkWU7ZcVSKw0TIeh
	V5wsl9CGL0rVgZMo6erKjsLi05LmuZk1waoRVnPkinCW2fg/OyVXe70g/+CbjiWIerUeDaC9haO
	sTKWwnwU5FZLUOXGN+eL2heMo/6gvhIM/Bcnf144PFFUMI65/MX2dkd900EpuH+oMe0QUSb3I6H
	KP7FSgTEgGjPKSpchRmi54lua/pQ+V0e1kGct4ILZP/+AVA/aoP6HG/CzVzNQp/34OoE9ot5TEd
	T3afnH/CI7bwRXeyIvLPcsJwj0EAaAYv0aHbuKyF0lE+qmbY38SIcfFhtQ6b9COBLhDwZ7QXFVs
	3b1Gl3iau+yHGJXDgan3ZUQLlDdHOL3NebLFQNI5exThLWHoZVDjEe4MsXtffuGY508mwR6GP7r
	sFqeV9Oy09+yHQ6u8GsRFDAIpJHqDWrZt5KBnsakBfyD95UhD+7QDO0D37Bb/r0J6FzouEuAdVt
	WENIMp95Q0=
X-Received: by 2002:a05:6300:14d:b0:3c6:3c5b:f301 with SMTP id adf61e73a8af0-3c92a9519f2mr2907018637.68.1785572323922;
        Sat, 01 Aug 2026 01:18:43 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe39ea9a40sm1433003a12.25.2026.08.01.01.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 01:18:43 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] nvme-tcp: do not accept C2HData based on blk_rq_payload_bytes() alone
Date: Sat,  1 Aug 2026 17:18:18 +0900
Message-ID: <20260801081818.1884199-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801081818.1884199-1-yhlee@isslab.korea.ac.kr>
References: <20260801081818.1884199-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_011844_833310_84F965C5 
X-CRM114-Status: GOOD (  17.28  )
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
was left as it was.

The two differ for REQ_OP_WRITE_ZEROES, which has no physical segments
but a non-zero blk_rq_bytes(), so setup leaves req->iter untouched
while the receive gate lets a C2HData through and nvme_tcp_recv_data()
copies into whatever the previous command on that tag left there. The
driver-private area is zeroed only when the tag set is allocated.

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

Keep the blk_rq_payload_bytes() test and add req->data_len to it. The
old test is what rejects a C2HData naming a tag that is no longer in
flight, because blk_update_request() zeroes rq->__data_len on
completion; req->data_len and req->curr_bio are driver-private and
survive completion, so they cannot stand in for it. Setup initialises
the iterator only when both req->curr_bio and req->data_len are set, so
the gate now tests the same two.

Fixes: 25e5cb780e62 ("nvme-tcp: fix possible crash in write_zeroes processing")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v2 -> v3: keep the blk_rq_payload_bytes() test and add to it; v2 replaced it
and lost the rejection of a C2HData naming a tag that is no longer in flight.

 drivers/nvme/host/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c4fe06d424d1..85a87ed6df93 100644
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
+	if (!blk_rq_payload_bytes(rq) || !req->curr_bio || !req->data_len) {
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x unexpected data\n",
 			nvme_tcp_queue_id(queue), rq->tag);
-- 
2.43.0


