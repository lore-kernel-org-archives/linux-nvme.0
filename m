Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843BDC3601E
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hq/VSDygxUvqusiASIxz5VUwIaO2iFyZjJyGjGC2vUg=; b=a/XLfNs8yjq+7tmOM/wGYUMvw3
	dvYv1PHEJyACdqMPn+r6ShQT+L/bqRz0FrTG6Nn5x+yIErhedxraUS4Q4AN6csdCoELHJXLCA4nvN
	htQGpY/J4lcI5kIKz0QpByV6UOSYcE//8lkV1tyvjqKHJ+fqaxdjCObs8bAvdSpr1Slb65NsqwnsH
	e5HZ3HnqDpKoj0pxAm02RUCWFmABj+mGofz2OFtw7iaSqTgVo2Ey4uprhLpuhrwf0SZuiCTkHhfpn
	mw3wahlG9iNtEdp7TzwiK/qEIde7j7LXVmStO8P/Ze9W+pWvotzVrhHBkDV63Y/fWcRaVqpi1DK2K
	Ehq1bnQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2vQH-0000000BKbT-4099;
	Thu, 10 Apr 2025 17:10:41 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2uRl-0000000B89L-2s8c
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 16:08:11 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-223f4c06e9fso10984965ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 10 Apr 2025 09:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1744301288; x=1744906088; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq/VSDygxUvqusiASIxz5VUwIaO2iFyZjJyGjGC2vUg=;
        b=TDBp+NDsy+IGt/P4JDXM/cSpsPte4/EovuXGwSNqXaR+/99+w+JhbzRGXhSAgUdN4Z
         Q4a8csZgDf0mHvmuSWl5YBb2e9daD8Me3UsV0j8IjKacuOHsdLJK7522NOk8ijCopzJd
         c3xLD+n+ycCc55xo0Si0zsQLaiF5t/K6L2GvlLhdXljCPpX2GlB//bhOMUHege3DAeC+
         UBY9HIGMjeWMBvR04GvR8Vqas6+jENg0dA5k5+nC7NtURUTHgoN15BsjVqYe8oKyARqu
         T7R5Pmy1fDQ+H4l4bUun4B+iSp/n7djTD1FewRDpv/BRGlXNcgSjAIQ39H0fcdPqfmUS
         QWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744301288; x=1744906088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hq/VSDygxUvqusiASIxz5VUwIaO2iFyZjJyGjGC2vUg=;
        b=Vqk/YjYf+J+j9GQTzHh/dPHZdD5kHfc+P/E1zkh+DwRRK52QxaAMHOqtOa70i7Vjwv
         U1RAkDMJo2X8qxWtuhGEUVL8KiKGy0OMm7fkyw9iTQb47qFnAbJlDAt3w7TXZ5yzOMs8
         2I1319Q8FpwNwgmkqSgixVLxmC2yfBtSAT4IMAOnz9E8bE0FcY5Q024gFjXGMq+Szoth
         4qe8KKhWlcrIoj81AF4r6HOQ3HqqyuOK5lRoEVhWUrwiGKtxfFYJHg+nggePw526yloa
         mDp7ntg1w+qE/kyZBMhcg1Nguymi2RbA3x3b7eO97Fh33IJT57AZR8JIQkI5BPdi28G3
         NTZw==
X-Forwarded-Encrypted: i=1; AJvYcCXLw3mXBNd561vowp4//++rfEeFqqBTxZyuqGfxyz5gHQk/3YGh06x+yFkpYNjVMIAlnn+q+mkFwrlh@lists.infradead.org
X-Gm-Message-State: AOJu0Yx2ZDfbxnuQl39PKh7P6VtKg21XuP1hwRxQOEAtbJjaPhm4S3Yn
	2oe+9R9k9Jk5h2rcuPBzGbTg4uqHQ/xcrClHozgNhRoL7iPZOuhVDN7cGEpxUcs=
X-Gm-Gg: ASbGncvHPKltY0wcBXjRW8mqWcPqX37RyzNNSv4EZPtAytrppyHw/v+Q343bsOaP9Zg
	dXMsh5qzovOV9G7jnKTmVxERz0CpqCbk/5qvBBTiNaJVx0qCeX5iWMfhfdSc8w5TOj3Zxsd2VAT
	R4Moj0FBWWvpQY0HmiPBXid6Af08nZzg5anszZpQ9rCzRb/f+BFv1D+oU5WSkkSCywxe/V2Dmbp
	votA472fzSQuwz/qKtCjo8PDPSf3QcboGQ6CRBxOcwXQepfw0QVDZtt0seMau1+Mg/kD95nIUAr
	GfaI3lA0w+60gcd/VQwwF/nF/GJ8t16ZydkE4OZdjchiHV4etgQD7A==
X-Google-Smtp-Source: AGHT+IGPEFfzuYGsKFWjoyUUk7FN1CYFyByM7i9vyd1ThL+ecYguA91ljiuUWfeE5IQtgQhbj5/kRg==
X-Received: by 2002:a17:902:ef02:b0:215:58be:3349 with SMTP id d9443c01a7336-22b8fd48490mr54741595ad.14.1744301288183;
        Thu, 10 Apr 2025 09:08:08 -0700 (PDT)
Received: from localhost.localdomain.com ([103.85.74.92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccb5afsm32488185ad.226.2025.04.10.09.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 09:08:07 -0700 (PDT)
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
Date: Thu, 10 Apr 2025 12:07:57 -0400
Message-ID: <20250410160757.2567493-1-jiewei@smartx.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
References: <20250324-tp4129-v1-3-95a747b4c33b@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_090809_989725_F1030142 
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


