Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17924C369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Date:Message-ID:To:Subject:From:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BrTueyvSv030EN4sYt0wA9U0PjYlqyc0AfIs6yiLAkI=; b=axjhiJ5KC+Fk7lhFAvff5zXxx4
	XfiD0JYVvCF2GAC8yFzUbAwds+g2pNIkHR262Hw+p33Q8vUIXJ5BBRyg0o3qmWXqDCKFBD3aTRhQa
	Oiwjl6J7aob4ejhJaU4vxnGKhuw1/6+EyOURTaRs0C51/IXdMEEUAVtEqYSUEWNAr7wynqTzUJIzV
	Dzt9EVCYQw89ye5fLIjEJjF9jBYF46NpTg/nNl0xyx/gTkcWKlTLpAlVNy+rbr/CzGOvoLiPWUFbj
	CSQMGAgFL1W44r5ikonMzdADPm8W+WMtaPaFwLtIJdZ/VtHORw9Zs4u4up/N7hrsNmny86K1LI3f6
	cX61ficw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Is6-0000000HEa4-2XJV;
	Fri, 25 Apr 2025 13:13:38 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Hkf-0000000H3KP-2aIr
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 12:01:54 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-30332dfc820so2537112a91.2
        for <linux-nvme@lists.infradead.org>; Fri, 25 Apr 2025 05:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745582512; x=1746187312; darn=lists.infradead.org;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:to:subject:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BrTueyvSv030EN4sYt0wA9U0PjYlqyc0AfIs6yiLAkI=;
        b=EBXeXRtI1n+ABi/b5a1Wwet8MR2rPBzoLz5oAcGL6JecfCbGfiUjUjObmQ5yorRL0B
         mbw1mvSqta7x0cpESIeCdiFK3CeuRcUDYgLubJx9aQxOsrbQhFdwHQEi6UrUN+0rOxk6
         EQ7bkHYozEzjuZAXKqZ9mlYimqr3B06kYD40lnF4Qt5+EdnaMBleMOU/lz0bfY/b7MyX
         JVjpdS9oJL3IeCQHYKXOuq0biuSEw+6ai7RljILNWmdMLK/fSqmz3/mDnBMJr2vnRSWh
         Tue8A4PK4bV0raOynmHL3Tn19LSX/q+maH4aUEkeduRkl/Tl2pXuIzKVcAQ8IUjoc5S+
         oxkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745582512; x=1746187312;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:to:subject:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BrTueyvSv030EN4sYt0wA9U0PjYlqyc0AfIs6yiLAkI=;
        b=br1sMwZZ2n+zDVoqQ1Rf+mfaezE8x7wECTUR9zhooYHQxh76Yb3sJfv4Tp17dfqia3
         fv+OfnawqvNORuIH0OEQjSPvwjLheXJQ1F+vqZvjK9/9AyQhChn+1lRM6EQ0efZpMtE7
         kmQ8/RbuvWdzi4KaVpA90aSqTRN+tLXwkARHa97Dg3BOXb1QSroHm6u9hE3bGIxiUKrj
         sDgaCpsKPkBTPa3Buoi+faq1nzzAmtve/HT522wQsb5ryu2uh9FOXp9Uoy7oooJWETbU
         3JPxytjhWukr+aAHguTUHOrZ9KX+LYX1oZjhx5lqnzZjBt3L19wthwSFAvForpHw7Ll1
         oyFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTlP/TDxA6awOGTSzSbS1UqmIdN+t8pCDYlH50GqMqPEutuXp9/j5zKL3UFzlf+4jTCiMjG8DVHtI/@lists.infradead.org
X-Gm-Message-State: AOJu0YxEn8F0mGNbc399dSunYZed91GjiDaBmQ5yDlyTVOzigj0RZMmq
	9Hd/ropsv7PBX/HbycvXnFAQh55JQcOx5ZCNAOD1kdVVi4EmnBP92IpliKlWib5NbuSZ
X-Gm-Gg: ASbGncvkiJTC8e/uo9LE3IkMoQXAQgT5GLTHJe5e1hpZQBJAEx2j/qgUQUms8/1y8Hn
	9R7W9yKpoyI3pjgfjbvCaFiuInPEg8FL5qn6Sf1AmkpTE9PAIvbG3S+883HdhzOBD3Zwce+bscr
	j221pj+cShK9OojbbbS/AIVUIS83qIvnWUHzvagS/1R+u8wqv7tlLF0EM1YU36I1C3NL1BLbU/0
	wcaa2/y/onOK9eu5DaGY2PPJmcDZjsKqm6KC/WONTh/Az++W7DQ7V2LRFr7stuLVbDo3SWXAS6P
	uu/4nl4zr9Xpa9hnivxFGC6WnXaXasYfBmEfcp8V/gQKHfIDP2ZQw7nOtCx3A7NH
X-Google-Smtp-Source: AGHT+IFA65zpC6I246Bhs6NDqqDCpEpSzSW86iFMSwfnyo2YHD7VdT33U3Mu3SHxOk5pVCgE/dfnAQ==
X-Received: by 2002:a17:90b:3a82:b0:2ea:7cd5:4ad6 with SMTP id 98e67ed59e1d1-309f7e9ee30mr2795131a91.32.1745582511610;
        Fri, 25 Apr 2025 05:01:51 -0700 (PDT)
Received: from [0.0.0.0] ([103.127.219.137])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d771a8sm30328495ad.22.2025.04.25.05.01.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 05:01:51 -0700 (PDT)
From: Linjun Bao <meljbao@gmail.com>
Subject: [PATCH] nvme: avoid missing db ring during reset
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Message-ID: <fa04f3d5-56ff-62bb-0afd-ad94e961ddee@gmail.com>
Date: Fri, 25 Apr 2025 20:01:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_050153_659943_BE1CEA2E 
X-CRM114-Status: GOOD (  14.80  )
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

During nvme reset, there is a rare case, when user admin cmd such
as smart-log and nvme_admin_create_sq from nvme_setup_io_queues
happen to in the same blk_mq dispatch list, and the user cmd is
the last one. nvme_admin_create_sq is dispatched first in
nvme_queue_rq(), nvme_write_sq_db() is called but immediately
returns without writing the doorbell because it's not masked
"last". The subsequent smart-log ioctl fails fast hitting
nvme_fail_nonready_cmd(), skipping both nvme_sq_copy_cmd() and
nvme_write_sq_db(), so no doorbell write ever occurs. The
nvme_admin_create_sq fails timeout finally.

The proposal is that do not treat user admin cmd during
RECONNECTING as non-ready, through it to the drive, thus no
doorbell missing happens in case above.

Signed-off-by: Linjun Bao <meljbao@gmail.com>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3cc79817e4d7..fc550226ed77 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -750,7 +750,8 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	 * sequence. until the controller will be LIVE, fail with
 	 * BLK_STS_RESOURCE so that they will be rescheduled.
 	 */
-	if (rq->q == ctrl->admin_q && (req->flags & NVME_REQ_USERCMD))
+	if (rq->q == ctrl->admin_q && (req->flags & NVME_REQ_USERCMD) &&
+	    (nvme_ctrl_state(ctrl) != NVME_CTRL_CONNECTING))
 		return false;
 
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
-- 
2.25.1

