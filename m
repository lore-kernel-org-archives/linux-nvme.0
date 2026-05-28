Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 805D0CD5BD0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 01:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dN8Z9T4IWkrtYoaDxqA3HhPpfCsTpRrl/bezOTTtp0I=; b=h0Qo7K7HNslKgvqs52M0knVQUR
	CWb7dZkbRq+bmhuJP5cf3OgPZwI0sTguS0k7c31Uc2qJl5Jchug/GFCAil5iiUOmyEvqKtMP4C9Hh
	ABnnylh45iEYW0x5jU0+ARGdQr290C0FrNI0dOzA5Ob91RWSm5ZMAyMqnIBkZoJxZD4TExW7Fe0Fw
	lm1d182SOgxmhtUPWWFgLsG31un8NX3uWmdsGCKUKZctTbXre3YkCWzLuHg4W0vj70odB+Y4TNJXZ
	oF6qT665d7NUtjoEKxhYgG2VopzEkW3cqsJACaKwFHgCpxz3sJPC0SI/b3cNqT56ZOBgoHX9KxMcC
	E7BVWjvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSPmV-00000004xHW-2RYB;
	Thu, 28 May 2026 01:43:31 +0000
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSPmT-00000004xFw-05nJ
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 01:43:30 +0000
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so7072915a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 27 May 2026 18:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779932608; x=1780537408; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dN8Z9T4IWkrtYoaDxqA3HhPpfCsTpRrl/bezOTTtp0I=;
        b=VgyRI/c2CWBmOPGCN9fiIN1ArP0Gxgc6lfilyE47Ufsi/pjngAprrV5jwA6GYrrswn
         o5UM1BKYPqdxpY+IJGfG6arEXIALKnaZg8VeqO9UfaDbBzAYXJAzc6U67FSAUgnZpcIM
         SXSkmum/FAhOgflvmg6v1zwAGmgHKls5APyDcWEQcJXcVVL5Ah24XVTz4o2l2Ag84CAy
         uzBDXFPlz1xogTIuYhwpnYY2nKr5JuSzG6dgJbv9qKCiIJRSwhH20UaTpk4ZHD63K++e
         8G0mKgdH+omRIktYx6t1iiO/VVUyJEGaH41QpxSzlMzNHoQxpC9KNM2UCz28aVOb+e6p
         +ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779932608; x=1780537408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dN8Z9T4IWkrtYoaDxqA3HhPpfCsTpRrl/bezOTTtp0I=;
        b=ZGYT7/sa9OeJ8kYefaHMQlV5fJQ1x4zttmGsK3pWJkaeytuGpylX5glLyrls15G9oB
         mnmGkLIFsiwMxcSK/oJIAw/AhShCzh4iRCtBEjCIaWRg/bENXO/HJ8Crn6YFbKaKp8aF
         QzLCsQS681EF0phVa/oNdIVfB4QwjQQQarHmQk6Oe5Z23P6nysJZOw+TFkXPPVi27Ne0
         n2PtIWXeprCOwDt1ctya4se3YD3GrwZ/w2SsNSwCT1bJjsL8BlkaFqB3IkStrsv1foOd
         /REJxPHV8Lhi79ctSBSyRhGCz5KFKz696rFIJuUkHeKgYIyBpdogvoMQpmoR26ygFI9y
         RDZg==
X-Gm-Message-State: AOJu0Yy8HnPY5Lw1o6deIsKZz+G3CMt2KleyD6aqvMuoA4x3rg3BxBKw
	gnxc2Cq0sxabOx0+MJ8b6ZlZpcGdqNiEfg33vQ+dpxeYYVanLYs0oGjOuMBA2daSnIA=
X-Gm-Gg: Acq92OFx3aNNnIZNvLNdL2vmneSmhBaMRZMi9/vxkUiy0OoeGLusc/kRRJrOY6VwDkT
	/wyj9jDUDwIuqZrSQ9/hhR0dTXi7xyQey5v+5eQyzblhY9NQ4JzrUsNqej4L7DVF/bPQ6gFzFaV
	AAGJ8F4PmPk0QoPj5gqj3EYoII23SLu+ZExz7ujtafG3YWSc0YiLyXk2IE0CUUFV2R/S3JkUBGt
	+wY2k1LIMsC/84HizjEdsspCCp5Ao8mRkBVCjqib8FD6CURkV9IQ80U3HL8aYLS+Zn0OiAYLpG2
	N4Yg0588B6spzIkgL/qjMZrj8BkVW3/f7nWit8Hox4w8OG9XHDftRORTIE66fWdfNIjFnYpTXUK
	mqfwXDxYLqIXaPIOKALHXPQ7WIeA6WUjWsz4C6trAHa+z3jzXipzqE45t7rDo6gxZBMWaLcW97u
	w/vz0HV/0C3fqlMjMtDc1hRLwYa9Qq
X-Received: by 2002:a17:90b:5404:b0:36b:769c:e5bb with SMTP id 98e67ed59e1d1-36b769ce696mr1893080a91.5.1779932608152;
        Wed, 27 May 2026 18:43:28 -0700 (PDT)
Received: from [127.0.1.1] ([221.238.56.51])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b908e4013sm214003a91.1.2026.05.27.18.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 18:43:27 -0700 (PDT)
From: liuxixin <gliuxen@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, gliuxen@gmail.com
Subject: [PATCH v3 2/2] nvme: validate FDP configuration descriptor sizes
Date: Thu, 28 May 2026 09:43:26 +0800
Message-ID: <46b82f1d635ed01017fcceec5d56d5cfd5cfcb79.1779930057.git.gliuxen@gmail.com>
In-Reply-To: <cover.1779930057.git.gliuxen@gmail.com>
References: <20260527133205.GA12042@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_184329_064039_3493EC45 
X-CRM114-Status: GOOD (  13.89  )
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

	<cover.1779930057.git.gliuxen@gmail.com>
From: liuxixin <gliuxen@gmail.com>
Date: Thu, 28 May 2026 09:00:37 +0800
Subject: [PATCH v3 2/2] nvme: validate FDP configuration descriptor sizes

Validate descriptor sizes while walking the FDP configurations log so
dsze == 0 or a descriptor past the log end cannot cause unbounded
iteration or reads past the buffer.

Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: liuxixin <gliuxen@gmail.com>
---
 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 766157ba6..40e87b563 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2275,7 +2275,15 @@ static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
 	desc = log;
 	end = log + size - sizeof(*h);
 	for (i = 0; i < fdp_idx; i++) {
-		log += le16_to_cpu(desc->dsze);
+		u16 dsze = le16_to_cpu(desc->dsze);
+
+		if (!dsze || log + dsze > end) {
+			dev_warn(ctrl->device,
+				 "FDP invalid config descriptor at index %d\n", i);
+			ret = 0;
+			goto out;
+		}
+		log += dsze;
 		desc = log;
 		if (log >= end) {
 			dev_warn(ctrl->device,
-- 
2.43.0


