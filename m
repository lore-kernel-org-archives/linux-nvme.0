Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB44CA5FDD
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Oct 2026 20:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XQAG52tLeZ0GNDhAmphKWmCU33aC81o6qoj3pL6Jx8Y=; b=jo2NZttsbcKv3WoBRGgyZQDMHN
	y/2fHeeatnKlpFpjgGtkE6THZCOE66I6tw5OaXAQQEK0W8rucJkuiSWhxhJw/iRVvbxjNRtBqiB3d
	xylfXDCOYNdnDTRAF3oYMDzBMOqW33cIjzv95shnWzwwKQ8SEIcyTvvLeWmtXR4Xoh37NsD/ZySAd
	8MP2TDnUNUUigQFBp1NXpHfPbdMBImQvm567aRKGJpiW1FQE0vTyvMOWJXU/wL3t8x9kHIU6jDr2+
	75stfYZdRZh81LLWK8iFAl+f7JmI1WmonGwOYQzVGE4qXOE3qyyrYugKPX9L/QTjqelgi5dGZt5Xm
	NcldIkTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCk9e-0000000CVG8-1Dlr;
	Fri, 02 Oct 2026 20:46:54 +0000
Received: from mail-dl2-x0f.google.com ([2607:f8b0:4864:38::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xCk9b-0000000CVFi-2EIQ
	for linux-nvme@lists.infradead.org;
	Fri, 02 Oct 2026 20:46:53 +0000
Received: by mail-dl2-x0f.google.com with SMTP id a92af1059eb24-1460bcc512eso8275c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 02 Oct 2026 13:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790974011; x=1791578811; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XQAG52tLeZ0GNDhAmphKWmCU33aC81o6qoj3pL6Jx8Y=;
        b=hIUfYSDxHVvxEe7b1vaHWsdGLP1xGLUe4Qpcu3y9xHUDtGQCsLyoVOmf8K0/jrCsN/
         1gyElkB2Bd87thSsuKFqYPvLQDrpPsJHgF5jeBsnfWCHrbtwTcwJO6+FyMePSwkOy584
         h36ay53IhCXrFlanKc2pehwR41YymqY8lc7gysetv0sKnwa7IaeszWSmdrc3fry1Sd4y
         17nT2xwTSgRndB+Pp8ZGq4DSz/YFGBaz9ljK2gdjwkql8S+eRHU9OGld1NhotGDmK8pF
         hQo2amak5uCgsi5q9FIsa6IbDeVxtjPp9cor9EUfeL/ytW0Ew1vMMhUMDKvPtf92L6/c
         ryLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790974011; x=1791578811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XQAG52tLeZ0GNDhAmphKWmCU33aC81o6qoj3pL6Jx8Y=;
        b=hVbf5uD5kVsyezq/fviazeYp1OWW4FOs0SSdVQuql0XCCVcdNCK/REqlN5qYhOeqX0
         NQWCntV23AWxhZMaI3ViCNILIc+O56L4me83fK3pQ99Ex3nHfdxXSySdmGoLrbAPpbVP
         7gDJl2F3nLSFEaT+hHV9eaRA7LjtwqawWmF/7vI8zwtlz9qNRgR7GmeDOVFbnK8XPHMP
         uYq0dzzk3/41cFPP/ohoX+QKbKq/GNdEXreASAbLtBfDzOnNjVk8HqwIJ7duN0EEUKJz
         vVWYk/Cjc2kry4CNWWthK6HIH3CTosc3laqKppUXW394vR7vaVxuA4plXzfqZlYwdYPI
         xDdQ==
X-Forwarded-Encrypted: i=1; AKwUvByg8L6witwAFMj/Nr9b3xGBrYfUNNFb8PGlmMjrs4iKEKjrFLaLUz309YG+OJs1aSGxzwRuWaCyKy8H@lists.infradead.org
X-Gm-Message-State: AFuF++kKARSkd0/SrVzjv4rn0t4XKrD3M9oql3fjhI3s1iU/N87l1P8z
	TWVJMG/bRw/SwSE490EA3CjOOmhNuKO0Php4ZlC4HM/688VJNMkM1dhATku5S4koESI=
X-Gm-Gg: AYBFou0ERZdftmcnMyMXMCJ83z9BSlqbgDDls0s30T+uRRFWOOhWlEXX7f2R9K/xnBh
	Mt4q2Yh6NFk82eGZ2jdZUfLfcQHRLlbiy9vJFwqziY4bKJAiqgYOaqt2PBZy99uFWwvXeV1NFjK
	1XdHzCH9FsADvvnX/EggeXECQt6AZaSXDudTaNtq4D+xh4cHwtXaH4YY3VoZAnejQw+JVTGkgBv
	zX81f6hgCIR75jT3fzZiehkYRlf2JAEqvAbJjVg48mMQwxkug0Fwn0mDfywqBsryF8iShS6+9Z7
	WK7XWKCsriBpAcltxcEa5JG2VaDxxUp0fsCs8xak0+57090lDHH7oDyWiHrTSTBjcstXn2+oypF
	e1wjddZplLjBp7jtePTmrzzidx6BWOfqrl4s59gJr8uWAo80kVTMM1QrQYiZJNHlletZXr6GX3g
	UbXldbxcUMf7Dt6XSZmQ1t59XZS7SqqguWF/aGGh+1ciiiA7xT5vkx2za/7f5ZDrN72K80YIJnu
	fptYc9L/awaH83P91m4gT4ukMsbiWu59txhD3vHhCpuyJ8eV2CS1moQlhaSde1K8wKj15g=
X-Received: by 2002:a05:7022:f503:b0:14e:9cd7:92f5 with SMTP id a92af1059eb24-14f5bbfa0fcmr4281433c88.16.1790974010316;
        Fri, 02 Oct 2026 13:46:50 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:a1e3:ffe2:b35a:69a4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f4766f92fsm8317213c88.16.2026.10.02.13.46.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 02 Oct 2026 13:46:49 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.1.y] nvme-fabrics: use reserved tag for reg read/write command
Date: Fri,  2 Oct 2026 16:46:45 -0400
Message-ID: <20261002204646.26451-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261002_134651_577577_00D116BF 
X-CRM114-Status: GOOD (  17.87  )
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

From: Chunguang Xu <chunguang.xu@shopee.com>

[ Upstream commit 7dc3bfcb4c9cc58970fff6aaa48172cb224d85aa ]

In some scenarios, if too many commands are issued by nvme command in
the same time by user tasks, this may exhaust all tags of admin_q. If
a reset (nvme reset or IO timeout) occurs before these commands finish,
reconnect routine may fail to update nvme regs due to insufficient tags,
which will cause kernel hang forever. In order to workaround this issue,
maybe we can let reg_read32()/reg_read64()/reg_write32() use reserved
tags. This maybe safe for nvmf:

1. For the disable ctrl path,  we will not issue connect command
2. For the enable ctrl / fw activate path, since connect and reg_xx()
   are called serially.

So the reserved tags may still be enough while reg_xx() use reserved tags.

[ Backport to 6.1.y: used the older BLK_MQ_REQ_RESERVED request flag. ]

Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and nvme maintainers,

I am working through the small CVE backports still missing from 6.1.y.
This one addresses CVE-2024-41082. It reserves a request tag for
controller-register I/O during reconnect and reset.

The corresponding 6.6.y backport is already in the 6.6.y stable queue.
The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not
in 6.1.y.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.1.y?

CVE: CVE-2024-41082
Upstream: 7dc3bfcb4c9cc58970fff6aaa48172cb224d85aa

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 drivers/nvme/host/fabrics.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ffe433c4708941..2d0dace26d8f78 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -153,7 +153,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, BLK_MQ_REQ_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -199,7 +199,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, BLK_MQ_REQ_RESERVED);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -244,7 +244,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, BLK_MQ_REQ_RESERVED);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
-- 
2.39.5


