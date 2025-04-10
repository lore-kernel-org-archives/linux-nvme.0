Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA7FC369A9
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 18:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hq/VSDygxUvqusiASIxz5VUwIaO2iFyZjJyGjGC2vUg=; b=wzGOZ+Q3SJALtXNqRDczXrzRjy
	1W8YRdUckZw7IkacQrUmDzlkzttrihxvVAT/agsAiX4adk3Yc3PBW90kpDJhCA1E1nAuLRs5KelfV
	56C4sWBNmB43DajVudoUg5CQNKrAT+dfpgicS01ySwSKHa47wS1k2fi3cpPpVAjwD+mLQyFPnUwhH
	4LE4b7RMpLurf0F2hgitI5npMK4DFuUdn2Kbrt8nuGmPby5bgPKSzihgT4u/ILafPbhSRAjPTYShK
	cJaJDFGSl6MsUtEw2lCyE5abh3uNJugOs53A/4FcGJqFLPJkQq/frDuQ/0hOK8EIPIPgCDhhAWuLR
	PuQDdtgg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2wDA-0000000BTNE-3IrP;
	Thu, 10 Apr 2025 18:01:12 +0000
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2vTO-0000000BL56-1IG4
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 17:13:56 +0000
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-224100e9a5cso12739735ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 10 Apr 2025 10:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1744305233; x=1744910033; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq/VSDygxUvqusiASIxz5VUwIaO2iFyZjJyGjGC2vUg=;
        b=JZYOe4JPJbge192XfyNlYwi5YkH91HlPcPlsFZ5odAY9OpbZeLhKStkfC+9Jrf2hXi
         H3fM6ySP975GljL34HVW+uLE2DxWuQ8+ftcCThAFbL8GzAcFTmOQ1duU52XhKM2fk89E
         XFYtrF4V9c9RSyOVrvYEGba5UeTA/TtuL57ICEwpFNp4YlCfxzLAyCaDYndQY35Eqmcx
         SsWi8O0+G29vW9pN3aLrByNq9B/48mcIauVQNJwh9QvuSPwvznHtc4N7rVt3B8ZadUIt
         OOEVgr4RcHMOu0Zs6vMYpkAEY0B5KbpkCwMCg3CI9rcx+OlNPXXVtDF0/gVsfbzuVur5
         evJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744305233; x=1744910033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hq/VSDygxUvqusiASIxz5VUwIaO2iFyZjJyGjGC2vUg=;
        b=Av1X9+sQl1HDh2y5DUmYhTtPGPPwGDTlspCMe1mBS781njxXu3vtHedcO7RM1nS8Se
         RsILY9PaaP4QNEsun3l2tEOEyu9wZTDji1lc0ZjRnLtud5EqdJ4ALdvDgP02cBnc9j64
         vvUlH+UEclsWKAsMx2w0XD7k4436R0XlDpyGpKdE/V6uij5XPxlGHVLU5UMcgnOT6ojk
         bO3OflaqeMIiPDfKgJOOaUjvG/kkaATqA6x484K8J1/tz0VkAKm6zadFCBl/SBFfpX7S
         R4j7fs/xsKrq8KtDag8Nztp+6m9UG1uL87rGCP4/Lg7KCDpcN0E7hqQ/RAJrtPVfZEve
         gcDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMy0AvmxcGKWMiFfTmJN9+4A4Cwhg+69dTK0t/CiHpkXsNwN7Ol6oDOa+Gt6D0xyQZ+rth7Z+Vqzxb@lists.infradead.org
X-Gm-Message-State: AOJu0Yx4pWvc8joBuaJr7aFx+A1mvZyl0TKQDuoo4UDTbEiqlwtE99Cr
	1NtS0PK9LDIpFTBH4yduJ9wjP5vvjuAQn/xyJfJHhFAFufFfmHQeqAw3TmEHtXZ1Mzmxa54ou+A
	IrkMKFgVckNg=
X-Gm-Gg: ASbGnct5B2c1qb8fkYcXzM3tUcEaDzwra9ipitXS4zXLCuJULSWnHyEmkx+yQGoo0OW
	CW77/AufvcYfDyn6etQTzZraoBCJaM2enbAX1kwUIhUG8PujBcvUt70bJPTy1TmypKgmuxWxqWI
	jIbAV/4fMylFAz0e5lt39beCgWdyHGA8YzdPvcAj3adPLKEqhnx6JtcSq/n7clBC+N8l1sy4cgp
	RpPAz8/dWSvKP6sER8WLdOsAY+PggZevA8SENHmpTEyJ8uTLV1pSVxizSwskkV3ia16U77JtJ+U
	+oMrbSa98qEYf0XVCQbQXagqQMJ7d0P3/g87dYQ3pue0LNhtn90sTQ==
X-Google-Smtp-Source: AGHT+IG7qAV0tWMqHzjYRRs/ciOYKMfjBxdBqsj5qeEnoYzZvY7nHBvNuiM4SI4rYfKRFkQl7QhunA==
X-Received: by 2002:a17:903:1ab0:b0:220:c4e8:3b9d with SMTP id d9443c01a7336-22be03902bdmr44796655ad.37.1744305232795;
        Thu, 10 Apr 2025 10:13:52 -0700 (PDT)
Received: from localhost.localdomain.com ([103.85.74.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7caf838sm33169365ad.162.2025.04.10.10.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 10:13:52 -0700 (PDT)
From: Jiewei Ke <jiewei@smartx.com>
To: wagi@kernel.org
Cc: hare@suse.de,
	hch@lst.de,
	jmeneghi@redhat.com,
	kbusch@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	sagi@grimberg.me
Subject: Re: [PATCH RFC 3/3] nvme: delay failover by command quiesce timeout
Date: Thu, 10 Apr 2025 13:13:44 -0400
Message-ID: <20250410171344.2579478-1-jiewei@smartx.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
References: <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_101354_339412_E5951A64 
X-CRM114-Status: GOOD (  16.61  )
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

Hi Daniel,

I just noticed that your patchset addresses a similar issue to the one I'm
trying to solve with my recently submitted patchset [1]. Compared to your
approach, mine differs in a few key aspects:

1. Only aborted requests are delayed for retry. In the current implementation,
nvmf_complete_timed_out_request and nvme_cancel_request set the request status
to NVME_SC_HOST_ABORTED_CMD. These requests are usually already sent to the
target, but may have timed out or been canceled before a response is received.
Since the target may still be processing them, the host needs to delay retrying
to ensure the target has completed or cleaned up the stale requests. On the
other hand, requests that are not aborted - such as those that never got
submitted due to no usable path (e.g., from nvme_ns_head_submit_bio), or those
that already received an ANA error from the target - do not need delayed retry.

2. The host explicitly disconnects and stops KeepAlive before delay scheduling
retrying requests. This aligns with Section 9.6 "Communication Loss Handling"
of the NVMe Base Specification 2.1. Once the host disconnects, the target may
take up to the KATO interval to detect the lost connection and begin cleaning
up any remaining requests.

@@ -2178,6 +2180,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	nvme_disable_ctrl(&ctrl->ctrl, shutdown);
 	nvme_rdma_teardown_admin_queue(ctrl, shutdown);
+	nvme_delay_kick_retry_lists(&ctrl->ctrl); <<< delay kick retry after teardown all queues
 }

3. Delayed retry of aborted requests is supported across multiple scenarios,
including error recovery work, controller reset, controller deletion, and
controller reconnect failure handling. Here's the relevant code for reference.

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9109d5476417..f07b3960df7c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2449,6 +2449,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, new);
+	nvme_delay_kick_retry_lists(ctrl); <<< requests may be timed out when ctrl reconnects
 	return ret;
 }

@@ -2494,6 +2495,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	nvme_tcp_teardown_admin_queue(ctrl, false);
 	nvme_unquiesce_admin_queue(ctrl);
 	nvme_auth_stop(ctrl);
+	nvme_delay_kick_retry_lists(ctrl); <<< retry_lists may contain timed out or cancelled requests

 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */

@@ -2513,6 +2515,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	nvme_quiesce_admin_queue(ctrl);
 	nvme_disable_ctrl(ctrl, shutdown);
 	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
+	nvme_delay_kick_retry_lists(ctrl); <<< retry_lists may contain timed out or cancelled requests when ctrl reset or delete
 }

Besides, in nvme_tcp_error_recovery_work, the delayed retry must occur after
nvme_tcp_teardown_io_queues, because the teardown cancels requests that may need
to be retried too.

One limitation of my patchset is that it does not yet include full CQT support,
and due to testing environment constraints, only nvme_tcp and nvme_rdma are
currently covered.

I'd be happy to discuss the pros and cons of both approaches - perhaps we can
combine the best aspects.

Looking forward to your thoughts.

Thanks,
Jiewei

[1] https://lore.kernel.org/linux-nvme/20250410122054.2526358-1-jiewei@smartx.com/


