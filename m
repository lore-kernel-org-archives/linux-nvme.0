Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C42CA9ED1
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 14:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vUnD1LOeI7J0+oxZWNA094IG/xUwZAT8pRqcJaVVo9o=; b=vyZeeV/rCzO5JmAbqUAcuKN8Oi
	vTl1hZ5PBB4ueYWxup4UVMTVssnIBbcgYsQDNtGLrBQlwTkaRzRo0riymX9NyuWwsKQAkhr2LpmB8
	24UX9PaSMfr2FGij0fD1nAkBz3XLz6v+zz5gF89qJAM99m6187GOq1CQhxp1nxUgZVCQIa+ZZPyyE
	mfrkT9bmEIFEFr0AQVkOXpOJzhSZBv5mHrKBWSA8Xu/HFISvuktSZPbx81cejiqWx0L8lluN/yEPB
	Ish80qvLl46znTnSyAgcwfiPhw2/1aMvgVLRHsouLuNVkSLhzVUZP4EoJ9tRjQ39YTsTZ12XXHgB6
	eI5J3Rig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGGm0-0000000Aebz-2PRv;
	Mon, 12 Oct 2026 14:13:04 +0000
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGGlx-0000000AeZn-11Lk
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 14:13:02 +0000
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso1348679f8f.2
        for <linux-nvme@lists.infradead.org>; Mon, 12 Oct 2026 07:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791814379; x=1792419179; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vUnD1LOeI7J0+oxZWNA094IG/xUwZAT8pRqcJaVVo9o=;
        b=ZGnMDbA1GeAKb6NnN+CKhEafKMtkj1ogDf03db9eKIWOMNbXPR2Qfx0onr3/AlL5l7
         DhayIQFBRN+oYc7nh51yVm7AukZ6gj8AgEyILzWLmOHcYADSp5YiG+284aRRgOFAuPiE
         YBeDiCZ99X2hLiLO4bZFO9ETlT2iqCOFobjkvhIxLDonKjvDDM612IUCcoxsHyK+DmCD
         vPcrOESclbCMYa5Rh1uVNwRMiROlaSidBCQN20OPop2xYSvrfKNL/hjqi1vLeI5B21NZ
         g8Fy3uhG6fUrdUFEJFRC+9/NLWTADdW37vQzz61LYHJ+RZvFKr9YLhajjHKyBilYglfT
         B6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791814379; x=1792419179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vUnD1LOeI7J0+oxZWNA094IG/xUwZAT8pRqcJaVVo9o=;
        b=0/+GQ6r9ihyjnVqdL3bKVx+hs8j1K4yBGqLhTA/skJvzOxzbZyfCWKYAk5VucatgDP
         Z+bxG8xUMHP5qIaw9kb1DIb9RlySducybHatdY9kU6iAh/On5VdqNOMzI9V9Ea828gwh
         K30m0e9VPQMnJldZ6y1ktiRkVMJ+TTJNGbosgqQPvywpuYZLJVsCtW+W6IJr34cxJrKy
         EKo1fe2GvTPyvIM0Mpsn9ZtCX22yX04mMKFI6GbUTaincsak/QJwul9sMtFqnoLhyQYr
         jIfQHfv9p2xpQn/gehlaiS7Gn/Mpq+nQTksrMJkJEhMoMrte+mK21d8I3VOPis9unlOm
         lnmg==
X-Forwarded-Encrypted: i=1; AKwUvBzhuVjfSbdNfTCYa+zWtp8P7NF0UJocnj5nqrKPCyxUBzXE/7brvSVe5ScHFduVv32sxtpo5ozFFyeu@lists.infradead.org
X-Gm-Message-State: AFq9FYId8jvFNy37+OYvdadZ7xAlVzr+k635D9O2vWXjpdkFFe0vKUqi
	1epI1pI919nlOsocJqIhj1M+9hwnxvm8cQU/5HORN0r2KU7VnhpA7WYj
X-Gm-Gg: AYBFou1xIxO69facE19yJLz0IEFjxChvr2YN3y50NwdhiTqe4rBvNaAMkbUtEFAN6FM
	tS/dwllZh6J99ErR70CCANvWPUelSwiGNwfqd6tz6Tq5ozKW+nP4nJoeyaJHxiNAM9kjCCP/laF
	DmH0RQFAhRM4cpZ/owKtu2ovAdej7x8/KeCXAynQV+k+d2AMGc8/j5fQRmOtHsQs9FEcVqddRQD
	1QwJv8kPJ9rZz8/WE0HgYbLHuygh6En9dZhP9JAxB7iNpjWdi9UMaJdJqbquDYP+HNaaw/QgnTp
	IUW12G/IqmQbbDp6bJBNC1B+p87y+jFiWT/vlFKJ7BAXeIrrhj+1i/KLdZA5WVaqEnJdc/3bafE
	I0A5GLQ8jEpuGAY/wrbtS9BF9qDSQI9HQ81JUogWBUW++631QmQR/MA8CTZxHKP+UxBadvbPRGG
	QvjeZnaSUTfDRZ8puiwi3rAXmNKkXMIm3LkQTED8drlgMT/D4Shic5lPwC1UojagE6GTnfDpHbw
	xOIbvN7MOQRC8ZxXPxPX0rnLCT5jWDYm0Ac6GHjUHfy
X-Received: by 2002:a05:6000:3102:b0:48d:ca32:e90f with SMTP id ffacd0b85a97d-48dca32e9b5mr10853775f8f.55.1791814379073;
        Mon, 12 Oct 2026 07:12:59 -0700 (PDT)
Received: from andreayoga.wind3.hub ([151.76.59.204])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ac02cfsm18703035f8f.39.2026.10.12.07.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 07:12:58 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/5] nvmet: zns: don't leak stale memory in zone management receive
Date: Mon, 12 Oct 2026 16:12:29 +0200
Message-ID: <20261012141239.156408-3-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012141239.156408-1-parri.andrea@gmail.com>
References: <20261012141239.156408-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_071301_298931_C301DE11 
X-CRM114-Status: GOOD (  15.70  )
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

A Zone Management Receive report returns the full buffer the host asked
for, but nvmet_bdev_zone_zmgmt_recv_work() writes only the 8-byte
Number of Zones field and one 64-byte descriptor for each matching zone
that fits. The 56 reserved header bytes and every descriptor slot past
the last match keep whatever the buffer held before. A 4096-byte report
covering a single zone leaves 4024 bytes unwritten.

The tcp, rdma and fc transports allocate that buffer with sgl_alloc()
and pci-epf with kmalloc(), none with __GFP_ZERO, and on success each
sends the whole buffer to the host (nvmet_setup_c2h_data_pdu() for
tcp), so the host receives old kernel memory from the target.

nvmet_bdev_execute_zone_mgmt_recv() also never checks the transport
data length against NUMD, so on transports where the host sets that
length, the buffer sent back can be much larger than the report NUMD
describes. pci-epf derives its data length from NUMD, so the length
check below does not apply there, but the zeroing still covers the
report.

Reject a data length that does not match NUMD with
nvmet_check_transfer_len(), as nvmet_bdev_execute_zone_append() does,
and zero the report with nvmet_zero_sgl() before filling it. Zeroing
NUMD bytes is only enough because of the length check, so the two go
together.

Allocating with __GFP_ZERO in the transports would also close the leak,
but it adds a memset to every read command to fix one handler, so the
transports are left alone.

Tested over the loop, tcp, rdma and fc transports with a zoned
null_blk namespace: before this patch, zone reports carried stale bytes
and a data length larger than NUMD was accepted; with it, reports are
fully initialized and such a length fails with Data SGL Length Invalid.

Fixes: aaf2e048af27 ("nvmet: add ZBD over ZNS backend support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
pci-epf has a separate, pre-existing problem with SGLs that describe more
than the command's data length. Patch 5/5 fixes it.

 drivers/nvme/target/zns.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 23a17c02abee2..78d82b6ff1214 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -282,6 +282,11 @@ static void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
 	if (status)
 		goto out;
 
+	/* Only the zone count and matching descriptors are written below. */
+	status = nvmet_zero_sgl(req, 0, out_bufsize);
+	if (status)
+		goto out;
+
 	if (!req_slba_nr_zones) {
 		status = NVME_SC_SUCCESS;
 		goto out;
@@ -317,6 +322,11 @@ static void nvmet_bdev_zone_zmgmt_recv_work(struct work_struct *w)
 
 void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
 {
+	u32 out_bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
+
+	if (!nvmet_check_transfer_len(req, out_bufsize))
+		return;
+
 	INIT_WORK(&req->z.zmgmt_work, nvmet_bdev_zone_zmgmt_recv_work);
 	queue_work(zbd_wq, &req->z.zmgmt_work);
 }
-- 
2.53.0


