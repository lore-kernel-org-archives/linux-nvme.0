Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0445AC433E2
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 21:27:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1CD6206CA
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 21:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tCoDeH+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1CD6206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pznOVyLCTWp4GG3pjW0KQncwRkkJCLN6J2i58jp9VXE=; b=tCoDeH+PUroo+6UJkFxmEyJkb
	/nNXQ3bAKvm26XuSUj2W7NEzDaL39r+HX3Ve9v4KzFy3x93paRFnvIoXw7bZ2AHbPsgiM/3+IHOZT
	5oMRndc5dc0d7fQEKDu5XZzLj/GBO7AWVY9j6ZhO9P9QFhlwUl/le7lsHbXYYTunGmRcuzaArSLEu
	ZsXM8R59xrb+xU3Zc7AoZ0e3UXZMV6axQRWVesW/YpdcKsVeByF6I3y0VtZYkNTS1z2GvX9GLBnD6
	gb0MuVAeC0Qv688xLLZ7ViC59VFdVXTddM96lJc8Im3OkqX/beiqgNjx8keWGs5d3XITa+tQ+L5fm
	8SzXamHiA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDwlS-0007x2-Ru; Thu, 03 Sep 2020 21:27:26 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDwl5-0007lj-Hs
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 21:27:04 +0000
Received: by mail-wr1-f51.google.com with SMTP id m6so4741902wrn.0
 for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2020 14:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=GGRHXecKyEwJ0IWVPv7h1H7Pqf9T7gYv3gOTweg7S7M=;
 b=ZvdO9yDLxjXc7QBm5nLmz7PzPjTAbh8dPm6WIhbkfQlsHbegaXit/AVjpze+irrtLW
 qXzyyAofzIseQYkdzi2QOzke3sq1Gh99rwlCrPpuZeFUBDKkU4B2irfpLrbZQrvrA6WO
 Jpg1UlwFHKwe3TY1yQPkIZKanrpKWLLMfS7kjcah3cS393k8vaEDrsqs5YpStVSRjF30
 qV8rdBcw6TzWSAnUqFmetNgY2W1M79zvp7WnWQqkXwnXrg2smFcIBW31v+SSaD4hNM/H
 bLTomI/+kmJrL7kSO8DJydUH2aYWe+4amcrT2SZZf8jLPpklBsmVz55rRvJPJxq/8k2t
 AO5g==
X-Gm-Message-State: AOAM531V4JrYWy/e2eE4zQ1FX2bilbJCUY0pApMIxyADQ5yuDddwkVX8
 J2zyg/TCZOEmdXGIVyW3+LY=
X-Google-Smtp-Source: ABdhPJxinPpGoWsLe2zb2myMj8nVc+8JdhOke0PrCJPRy4WkxwnKGhX/oAF1zjom+G5P/vC6vfwQxQ==
X-Received: by 2002:adf:db48:: with SMTP id f8mr3269083wrj.144.1599168422212; 
 Thu, 03 Sep 2020 14:27:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
 by smtp.gmail.com with ESMTPSA id v204sm6659896wmg.20.2020.09.03.14.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 14:27:01 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org,
	Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v6 7/7] nvme: support rdma transport type
Date: Thu,  3 Sep 2020 14:26:34 -0700
Message-Id: <20200903212634.503227-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903212634.503227-1-sagi@grimberg.me>
References: <20200903212634.503227-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_172703_608381_447B1FC3 
X-CRM114-Status: GOOD (  12.51  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 2b267f1d6ae6..009621eee634 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -5,6 +5,7 @@
 # Test specific to NVMe devices
 
 . common/rc
+. common/multipath-over-rdma
 
 def_traddr="127.0.0.1"
 def_adrfam="ipv4"
@@ -25,6 +26,12 @@ _nvme_requires() {
 		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
 		_have_configfs
 		;;
+	rdma)
+		_have_modules nvmet nvme-core nvme-rdma nvmet-rdma
+		_have_configfs
+		_have_program rdma
+		_have_modules rdma_rxe || _have_modules siw
+		;;
 	*)
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
 		return 1
@@ -115,6 +122,9 @@ _cleanup_nvmet() {
 		modprobe -r nvmet-"${nvme_trtype}" 2>/dev/null
 	fi
 	modprobe -r nvmet 2>/dev/null
+	if [[ "${nvme_trtype}" == "rdma" ]]; then
+		stop_soft_rdma
+	fi
 }
 
 _setup_nvmet() {
@@ -124,6 +134,16 @@ _setup_nvmet() {
 		modprobe nvmet-"${nvme_trtype}"
 	fi
 	modprobe nvme-"${nvme_trtype}"
+	if [[ "${nvme_trtype}" == "rdma" ]]; then
+		start_soft_rdma
+		for i in $(rdma_network_interfaces)
+		do
+			ipv4_addr=$(get_ipv4_addr "$i")
+			if [ -n "${ipv4_addr}" ]; then
+				def_traddr=${ipv4_addr}
+			fi
+		done
+	fi
 }
 
 _nvme_disconnect_ctrl() {
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
