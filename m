Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDF5CAC5A5
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Sep 2025 22:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bKPFYFmsxRdO9nBgPXgYLA7v0FY+/aO2JSwgPvlvRAs=; b=QNNC4oP190IRbjdwzwHEdKL2cV
	kj8ljEQMjnlRyi9JpxHLVRmnecDyA/FlTHy0CCU5WLFNX+RbrjOtwLlOvhnuUThHhwQmXCs0lylxx
	GoXYZ+tu6iY3I9rwBfL5xvaL4j+2NoxSUShzd97mMX4wovLoF/OnNCV52K4e8uPE+/PVsQhZIn3Q9
	7APX6fr1KL7AUmi339s03MejhTUkTsseh/8Q4kSpzh48VsDdMk/3c2afZ0krC9w/4eRhs8yMznNXp
	X+aDqb4vemvc4TeaixbfdImMXTv2wsV9xk+24kVhFY7y0E+8YIdaahme98asL2BI+10Ly0vX93zzt
	t3z1Qm9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1YEh-00000004OfY-1PCr;
	Wed, 24 Sep 2025 22:45:19 +0000
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1YEe-00000004Oep-3owA
	for linux-nvme@lists.infradead.org;
	Wed, 24 Sep 2025 22:45:18 +0000
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-afcb7322da8so65694566b.0
        for <linux-nvme@lists.infradead.org>; Wed, 24 Sep 2025 15:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1758753914; x=1759358714; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bKPFYFmsxRdO9nBgPXgYLA7v0FY+/aO2JSwgPvlvRAs=;
        b=QSyDTN+NQr+0+oigzKPV/LHU5WasFmqZpfpQxtiJXM/8yZMX/HGnttz/90bZVEor0R
         JO4q+XSWH35zHXooO8TZemH1rnm6udkMlcd16vrPXxCJDy//Fw/WygFTMt76qHyZARK4
         xU1nnVVRyo7Fe8IlojKKwm6+MXwMIXY+cHc1aeZ6OM5rHi9DPxiQjl2JKtZkCwU3vjHH
         Fp/zt7xmLhlJI8LV1FL5bgcD1wsD4ynJKEpY15edKX4LCHAgFoc/PfmB0KJYWDvquGc8
         3PVQRjXSPrWhHMqI2xtRKkVXJRxpZFFh3b4perU7bbH0b2eBjSYYufZWF3QuxPVLLzp7
         z5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758753914; x=1759358714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKPFYFmsxRdO9nBgPXgYLA7v0FY+/aO2JSwgPvlvRAs=;
        b=fRTZWokRXkTEJ9Jyx8R0un6TYjIq1SPyi1b0jOTvHGznam4Us2w1ZCwWfXdz41LCTs
         cZJLR3t2/Qh7zVWTw2qOViIvbUL5wxgac+0z6QehOWzLQ7Hy/rCUvm4VuH1WeRRAPG9L
         jOGQXGKnEFf4kc8/oktnhX/I7981jLT9ZXtbIARufZfJOIADGoAtIrink1vfej5Vd9CD
         uSrfNCR5RiQaYRd9dRfBCCkOHo1N9dom62eJ3w5bZ+7uwSOfQllvxUkhw3yUdHhG4AbD
         4OXiwcV0iOsUMRwjPW2LvBlQNLHJIvqPYupeyv6Hb5PlYaQAx0o315QlgncyKmg1R/ds
         gKew==
X-Forwarded-Encrypted: i=1; AJvYcCUzOy3bT4enMAB+u0m+PLhobeL8yCKwf8hmuslYnpWZwrRtaS5wqMwUvhdViuZRts2Q/zsuGNBhzoJO@lists.infradead.org
X-Gm-Message-State: AOJu0Yw4XTyP4K5Y3oQokwHyp39r6rEB4BpNU6wTUhH0Bp/Cwzwpt0xK
	qNg6jh1ojNqC7wECmZGgTXwt9qVe96dfvw6FpnbGpSW3MjZFNjxwS+xzi2nnaPDS7nw=
X-Gm-Gg: ASbGncsBKNT00WyK0qrEGq251nLsRwWBXPpbHZixjKbqcWC9zQco7+D9d+1KjyO0+oL
	ZGE4PIhqea5W84crbA/g/mJ01tY0DOMB86I1NHNC0gZmatSedf8fg2Oy6lEXtdWa3u72dLJ9h25
	p0sVbSS1eHUcKigMUEUE7Jt64EVBoQOu91gF8IREW4y5ewCYo0Gdfwd74cBaNv6s79fxY8Z5wLn
	69RCysT2uKErADLfg9obe6KV1ByYdo0OpWl4QezIvx8YZIPe1HB2dUVfUzkeahb9Oqs9Th8soKu
	ZOsa/4aESsFAKqEvN132qn3DuZtGhHgUf/3aQwXZ4oHyyf+fNKTjSzfTVimm0X70KDNX6Iv7avY
	FAjvKXIZu6vwoN9RU4W3yefxsGJ39cjuKzSMozylv4f+n9+LIEQLPs0sWHn8=
X-Google-Smtp-Source: AGHT+IE7W0spmlGgfXfGrubqgWuRi3YX2/w8uBTG3/ofbbW3nX06nZJT0SJrS8Lxa16DZfIsr1NfFQ==
X-Received: by 2002:a17:907:9447:b0:b1f:ecda:b79f with SMTP id a640c23a62f3a-b34bd43f746mr140156766b.38.1758753914406;
        Wed, 24 Sep 2025 15:45:14 -0700 (PDT)
Received: from 8745f5817b94.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b353efa494esm31398366b.25.2025.09.24.15.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 15:45:14 -0700 (PDT)
From: Amit Chaudhary <achaudhary@purestorage.com>
To: achaudhary@purestorage.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: mkhalfella@purestorage.com,
	randyj@purestorage.com,
	jmeneghi@redhat.com,
	emilne@redhat.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] nvme-multipath: Skip nr_active increments in RETRY disposition
Date: Wed, 24 Sep 2025 15:43:18 -0700
Message-ID: <20250924224319.4557-1-achaudhary@purestorage.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_154516_998083_3117BA66 
X-CRM114-Status: GOOD (  14.75  )
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

For queue-depth I/O policy, this patch fixes unbalanced I/Os across
nvme multipaths.

Issue Description:

The RETRY disposition incorrectly increments ns->ctrl->nr_active
counter and reinitializes iostat start-time. In such cases nr_active
counter never goes back to zero until that path disconnects and
reconnects.

Such a path is not chosen for new I/Os if multiple RETRY cases on a given
a path cause its queue-depth counter to be artificially higher compared
to other paths. This leads to unbalanced I/Os across paths.

The patch skips calling nvme_mpath_start_request() on a RETRY disposition
if nvme_req(rq)->retries counter is non-zero. This avoids reincrementing
nr_active and also from restarting io_stat start time.

base-commit: e989a3da2d371a4b6597ee8dee5c72e407b4db7a
Fixes: d4d957b53d91eeb ("nvme-multipath: support io stats on the mpath device")
Signed-off-by: Amit Chaudhary <achaudhary@purestorage.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 102fae6a231c..6ca6529ba83a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1150,7 +1150,7 @@ static inline void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
 
 static inline void nvme_start_request(struct request *rq)
 {
-	if (rq->cmd_flags & REQ_NVME_MPATH)
+	if ((rq->cmd_flags & REQ_NVME_MPATH) && (!nvme_req(rq)->retries))
 		nvme_mpath_start_request(rq);
 	blk_mq_start_request(rq);
 }
-- 
2.43.0


