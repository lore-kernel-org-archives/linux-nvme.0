Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC8B606A328
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=er8C2Gj9;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JoxawIZr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-ID:Subject:
	Date:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=GSGmQRmMcvmuTPAQVq01e7diuVSeXlw1FQweBrM5GfI=; b=er8C2Gj9lWE3IbvKnFk4KR7p4+
	PmIYO8ewAFUsLBBy5oTCpJfro94Jx9jXiVm91JkWGpSsH5FtbJqPnUAxOBMmNZwNZMOHbl1LPyiOe
	ymqAi9alZfSIUuNwMSjfGHTJTMQJiK2E2gr5QqX9JH1oKfhgB/dBUxQPu3G9RFm2J2+fv/xWnBLCJ
	IpS+sepGE0VJfcof6PCq/TGdSlHhFBWNicw+dpRmR5bR+SwUV8AxdL3lJFTogez0mx8y2zmoW/UA2
	NJnQEzq5LdIRjRGEnq9/k8bthp1LykTYs4/Rlczty7JI3cHP0vsA+bKGH4oCZEgHBtKhfcp7bpzul
	DC5SPbog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXeT-00000004vYq-0V2A;
	Wed, 04 Nov 2026 09:51:29 +0000
Received: from mail-dy1-x1329.google.com ([2607:f8b0:4864:20::1329])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOXeO-00000004vYF-45np
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 09:51:27 +0000
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so864447eec.1
        for <linux-nvme@lists.infradead.org>; Wed, 04 Nov 2026 01:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793785884; x=1794390684; darn=lists.infradead.org;
        h=cc:to:message-id:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GSGmQRmMcvmuTPAQVq01e7diuVSeXlw1FQweBrM5GfI=;
        b=JoxawIZrBnNNx0/AHNFj2ztjT/V113N6cXHuDZARaKCZRUwknGyxhCERCtWyGEgt0M
         DZPU5Qwc6FWj09nydAe3SsvmgFAO1S3ys9XFmybStlwOP5rU3rvv22fcScgMl/sPaDXY
         lpW4qtu8NzS4FtduVkD3grT5G8tyZWY8ifAgPlstVLfwhsvTJZ1xPA3fRxX/gCsPCFhJ
         JkFgxTVxDf809TikGgznu+cJYgMd8eWs/stKXw23mPFe29LTThP/ROvodHS8iqTvtxec
         CYjtkqLXO2EylUFkFRiqMV2B+30FEbnKBSGFZwpbIjUGkNouqO+/Y2DM4BgQQ+0sPqnH
         jbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793785884; x=1794390684;
        h=cc:to:message-id:subject:date:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GSGmQRmMcvmuTPAQVq01e7diuVSeXlw1FQweBrM5GfI=;
        b=CbU11MVBp5Rwmbl83vjJP1CnqKni8V+JJwGhtqE5rfrURrOUXqCgJqLXOHMuuIqRIS
         U/yTXXIL+MoXv7Up5gPrmAAp20BKIjZKXKzb6aDuc78o2+Oy1wwNFttcwhW8w0IChc+T
         lj3MSZZEzGwzfGOhztBP4xgqwympExrElltpanf+UgJz1IWccSwTXMIiBigIjHCUQmI3
         U11IrPR7FyM7GTNRKHLYi0pVKystqM21iW3CFaumnNIw1Gx2MV396rD4YvactwnYZtv5
         qNo12ZMhgaY7IqV6DZGP9nbAggC+7z7I+SDJ3sTejatb0beT+3YlU7zCbqtMCeU0kEkV
         Y9fA==
X-Forwarded-Encrypted: i=1; AKwUvBwMTiwDbEKJd+OyzCxSYB7xD+w7e15gZqQpNak/9SC0fxvYMq1XsKG/LxxhWPuQZVyDpmPrYwEFR/7x@lists.infradead.org
X-Gm-Message-State: APuU4Z8LYGEPOStwmI4sp1I9J6kgD/+1G7QALaKwu2YecmJaujC92R3B
	4Ff2EcPJvi0ob95kVTJjEuCdwfGl8VCa/ESbiU+UbFp/GejS+SzAWLRT
X-Gm-Gg: AYBFou0QrXvgd5LH7nEG8XygHV6JXm7OcFCQoj57e0cW1ZNPPceR+r+L/0nbQNNlNTs
	nIMZB9NYMfxu2SlcdLF+RgCrEnK6i60Thw2INblsqAWn2uxh/tjOcpiBZh4+AyaSpNvCm0reVK1
	8rz8Wr8w0Hn2I/kXa3lbdnHQdAzvuP30UyULwEPK8F6jDyxIrXBiVFkgGgbCj/vvazw+pcSF0hj
	vm/hKn5GpDoivCDSO+TYmebWN8dKWcQDtrz8BWWO+af8Rva2/T3BMrFysvS3St6+/f2MI4+QGHQ
	CIhVug90NfwUmrKAzdUOoQo8SzGyf45rNJlt7j/QiM4WkoDuktny+FzByl0G+jjFmBkqI3opWOW
	M/sR4y2SD/WbKlCi3oP3mwXq6Uf5n+k1h73lJdbpP1WmxBeUzBDV4pBUW8cYpp0SMeQ/N2f6NWd
	vH55mU8rtywiBnGhP/SQCSCXQLLRf0qPjvgQXcDnGvpaeRwoknBB12xY9SbcEpp3H3z4v3mRusw
	43jpE8wOuyC8e4w92PHICsMZZ7QrlJrm8jdG0ZLELK5sBMREg7Vxnugrhf/qgCZjAhGOjwv9gpQ
	jUMR7ZBmb5+caCKr3T46+DTbczUo5J4LFhqJSr5hc6sIRQsLnmAGifIitWh1z2OcOWI=
X-Received: by 2002:a05:7301:6193:10b0:369:a162:af96 with SMTP id 5a478bee46e88-36a4238974bmr23603741eec.17.1793785884084;
        Wed, 04 Nov 2026 01:51:24 -0800 (PST)
Received: from [127.0.1.1] ([23.247.137.158])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d3580sm6308351eec.10.2026.11.04.01.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 01:51:23 -0800 (PST)
From: Yaohan Li <shunsheng1218@gmail.com>
Date: Wed, 04 Nov 2026 17:51:10 +0800
Subject: [PATCH] nvme: stop asynchronous event work before ANA teardown
Message-ID: <179378587000.73780.18152328009023418065@gmail.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: jthumshirn@suse.de, mkp@kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261104_015125_013149_6B8AB5E1 
X-CRM114-Status: GOOD (  10.51  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

nvme_mpath_stop() cancels ana_work, but the asynchronous event worker
can enqueue ANA processing again while controller teardown is in
progress. An ANA work item can therefore survive the final
controller release and access freed memory.

Cancel async_event_work during controller uninitialization, after the
controller has stopped accepting new events, and cancel ana_work
again before releasing its ANA resources. Draining only ana_work is
not sufficient while the event worker can requeue it.

The race was reproduced with the in-tree NVMe loop target and
scheduling injection. Cancelling ANA work alone left reports; draining
the event source and the ANA work together removed the reported
use-after-free under the same test conditions.

Fixes: 0d0b660f214dc ("nvme: add ANA support")
Assisted-by: ZCode:GLM-4
Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
---
 drivers/nvme/host/core.c      | 9 +++++++++
 drivers/nvme/host/multipath.c | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a7a4d09644c13..017aae1189de1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5182,6 +5182,15 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
 	nvme_stop_keep_alive(ctrl);
+
+	/*
+	 * Stop the async event worker before the final put: it processes
+	 * ANA change events by re-queueing ctrl->ana_work, which is
+	 * embedded in ctrl and cancelled in nvme_free_ctrl(); a worker
+	 * running past that point would re-queue it onto freed memory.
+	 */
+	cancel_work_sync(&ctrl->async_event_work);
+
 	nvme_hwmon_exit(ctrl);
 	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9e0a0fd77c56e..44bd1a1ad5940 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1610,6 +1610,13 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 {
+	/*
+	 * nvme_mpath_stop() already cancelled ana_work, but an ANA async
+	 * event completing after nvme_stop_ctrl() can have re-queued it.
+	 * It is embedded in ctrl, which is freed after uninit.
+	 */
+	cancel_work_sync(&ctrl->ana_work);
+
 	kvfree(ctrl->ana_log_buf);
 	ctrl->ana_log_buf = NULL;
 	ctrl->ana_log_size = 0;
-- 
2.34.1


