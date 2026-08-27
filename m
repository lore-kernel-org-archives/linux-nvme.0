Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C3DC61DC4
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Aug 2026 18:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ex+RB5aItdA3h/bx30wNaWsAq7n74S1CMmypqWLJ+1k=; b=bdIdHuLNSShJoKHLDIg52GD+TJ
	wKBjNkltc/IgYGKqUd1i/ZI1Re0/vx3f+A8p9rhjW6VjPTDE5vfzognNO+as441iGRC5Zg75X3+zr
	HL9jB5rTvyUVwYfUj6q+s+tV5/m6nem0q3RwT+5dmTnYmPIPRanQXE6sR0zdV3G3krSJk4jiEoZmP
	Opw9QDA0yI16eWL7DM6FiA5YreO6OMwnrHysk4ynZMVhURyHdd/g08/0t2XoDuNmjSFtH9sdRB12m
	B5CABS17cvKhvkCgCLxD57OiBimJKQ1XnUd9Idyc6uZt8KH6Dwu+aWmxGbuCpSvMYB3N21j9shHOR
	xW0mS5Yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzfIB-00000004emZ-2OEO;
	Thu, 27 Aug 2026 18:57:39 +0000
Received: from mail-pf1-x464.google.com ([2607:f8b0:4864:20::464])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wzfI5-00000004ekZ-0QK6
	for linux-nvme@lists.infradead.org;
	Thu, 27 Aug 2026 18:57:37 +0000
Received: by mail-pf1-x464.google.com with SMTP id d2e1a72fcca58-85457d780adso28299b3a.2
        for <linux-nvme@lists.infradead.org>; Thu, 27 Aug 2026 11:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787857052; x=1788461852; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ex+RB5aItdA3h/bx30wNaWsAq7n74S1CMmypqWLJ+1k=;
        b=I/XZNrqLJPRkZRNQjqVjNzgAbRgUxA4IALuP2iitNXL4VspgjHFJ3yoxyAAKHR+frB
         nFO/0izZaRfMh01Agtq29mnfZ+VOMUG4refLFleRKDQaReHTI+YzkLajb97Y9F9uDDNT
         PMMf3p675QxEnTRJUmllFweYMR0W0bHk2Sm2AwGC2yuf7E5+CIhMhjprOrZUe5a5WwnZ
         ORqkPq+R9w3AHQ4MyVRoDxnrvfX7gzrKUFgySP7GHw2WImh6ugHcT1L6Ea4kVJyAW0YV
         CBhMZtGOMwp8JEE+FEEasVINVqvCQw0PaBRPOiu9oXGPunQgfiDRh0PAcFimo2Rpb4IW
         oq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787857052; x=1788461852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ex+RB5aItdA3h/bx30wNaWsAq7n74S1CMmypqWLJ+1k=;
        b=lccwIlPxlHpg7ck5IhAJuqh1tLW/mTfdB07pqQJtuD/S1LmsAJQRWHpCfLQaSwmGJ1
         kJZ4QJ4AK3rv/qw+t9LNyd0i+104vIdCTaZtPkb6geMTD0k8k7YIPlRg0g8Z5yUBmMHi
         k7AMvHuu4gbGBPZNSLrVK2rxc8EO5uPiknHfOt+j5ZJ0ry1y5brlRikiyXF1jksDRrdi
         q4CQqsjDbbcPYl2wzl+hhC5DuGyPO7WXv5pt8MoAuHV+3aKXIt9adAUy9nZ5eEeFJNGV
         StqgyYhOuu0bry2DEU/6Jnn6DY8yfHqhvUmMDl9uTzovUFwRQb5tOQXQQYRuWUOPX2VW
         iDAA==
X-Forwarded-Encrypted: i=1; AHgh+RoJB7y3m/Bfa0TqZjmwLzFz6t5wdiwzQp47Yg/eWWGKOkb1zjZ5EU7FFnkMiq+aPwqu29MLZQNK55Oj@lists.infradead.org
X-Gm-Message-State: AFuF++lhiCM3F7M+DQiiTkcHE6drQRlY6XrvQk4QMCBOMiarmC39oZtJ
	14lBzq4Kbtd/k6BzpsSbgIJ884cio/WBQLujCgest1HMhq5VU2jrAtVcuuIRbTQlgs04BHyWkxj
	IYUV/Jz4ePdKLNVyUTpAD6Rv+DJs+xXYh7hOCbIqWIUq3pccCosE0
X-Gm-Gg: AR+sD13yRkgpFp5HCZzsDlDWRf8SjVxa9LgA9pVILWBjxY/ykVaPPVfHPzkZUe173Oo
	sKS5CIhl5OnCbE6rMT0u2D+Iu7wDjiJA9RV0KhlY2BWDzm11OluNkGxi26zxD9HQvV2iU/Q41G4
	OXFmnX33aoAfVsJG0OeTDMSQ3gMF9DkInTLWzdzX7z3SKbOA5e/lVP3q5SbNAh7ZpB8dIabktPL
	s53NO/0UoQUhVDDUvygSCMn5us2o/ZccrqvA/9QarKDORUaEZTVgkTGF5TNN2MHr7So0Iz/OyE3
	NrC+KyYidN5Le5KwgbA+aDHqPKv4mJ5aw2oBzfsy46tb6U4kO239TvrqjzR5Sfg3+cjoVde3tJq
	OnOMWubNxfzjLCOfn4Q==
X-Received: by 2002:a05:6a00:4449:b0:851:c2bd:43d1 with SMTP id d2e1a72fcca58-85628a85b9amr829996b3a.1.1787857051450;
        Thu, 27 Aug 2026 11:57:31 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8538d0c4935sm2212871b3a.7.2026.08.27.11.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:57:31 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.12.104])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id A24254030A;
	Thu, 27 Aug 2026 12:57:30 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 9F60AE404C2; Thu, 27 Aug 2026 12:57:30 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Ming Lei <tom.leiming@gmail.com>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Bernd Schubert <bernd@bsbernd.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	fuse-devel@lists.linux.dev,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/2] nvme/ioctl: call io_uring_cmd_set_res32() in ->end_io()
Date: Thu, 27 Aug 2026 12:57:21 -0600
Message-ID: <20260827185722.3234622-3-csander@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827185722.3234622-1-csander@purestorage.com>
References: <20260827185722.3234622-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260827_115733_211143_3E33C5F2 
X-CRM114-Status: GOOD (  15.45  )
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

io_uring_cmd_set_res32() only performs loads and stores to the io_uring
request state, so it's safe to call in interrupt context. Move the call
from the nvme_uring_task_cb() task work to nvme_uring_cmd_end_io(). This
unifies the 2 io_uring_cmd_set_res32() callers and removes the need to
pass result and status through struct nvme_uring_cmd_pdu, saving 16
bytes and a couple memory accesses.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/ioctl.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 131959c00287..b50bba207818 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -421,12 +421,10 @@ struct nvme_uring_data {
  * Expect build errors if this grows larger than that.
  */
 struct nvme_uring_cmd_pdu {
 	struct request *req;
 	struct bio *bio;
-	u64 result;
-	int status;
 };
 
 static inline struct nvme_uring_cmd_pdu *nvme_uring_cmd_pdu(
 		struct io_uring_cmd *ioucmd)
 {
@@ -438,29 +436,30 @@ static void nvme_uring_task_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 	struct io_uring_cmd *ioucmd = io_uring_cmd_from_tw(tw_req);
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 
 	if (pdu->bio)
 		blk_rq_unmap_user(pdu->bio);
-	io_uring_cmd_set_res32(ioucmd, pdu->status, pdu->result);
 	io_uring_cmd_done(ioucmd, IO_URING_CMD_TASK_WORK_ISSUE_FLAGS);
 }
 
 static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 						blk_status_t err,
 						const struct io_comp_batch *iob)
 {
 	struct io_uring_cmd *ioucmd = req->end_io_data;
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
+	u64 result = le64_to_cpu(nvme_req(req)->result.u64);
+	int status;
 
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED) {
-		pdu->status = -EINTR;
+		status = -EINTR;
 	} else {
-		pdu->status = nvme_req(req)->status;
-		if (!pdu->status)
-			pdu->status = blk_status_to_errno(err);
+		status = nvme_req(req)->status;
+		if (!status)
+			status = blk_status_to_errno(err);
 	}
-	pdu->result = le64_to_cpu(nvme_req(req)->result.u64);
+	io_uring_cmd_set_res32(ioucmd, status, result);
 
 	/*
 	 * For IOPOLL, check if this completion is happening in the context
 	 * of the same io_ring that owns the request (local context). If so,
 	 * we can complete inline without task_work overhead. Otherwise, we
@@ -469,11 +468,10 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	 */
 	if (blk_rq_is_poll(req) && iob &&
 	    iob->poll_ctx == io_uring_cmd_ctx_handle(ioucmd)) {
 		if (pdu->bio)
 			blk_rq_unmap_user(pdu->bio);
-		io_uring_cmd_set_res32(ioucmd, pdu->status, pdu->result);
 		io_uring_cmd_done(ioucmd, 0);
 	} else {
 		io_uring_cmd_do_in_task_lazy(ioucmd, nvme_uring_task_cb);
 	}
 	return RQ_END_IO_FREE;
-- 
2.55.0


