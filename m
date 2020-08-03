Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E1FC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:49:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6EF2075A
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gRP7Cioj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6EF2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L/B9lb8jjz5EvegrP4M+8umzaLoQB0S9KKdjZF165Ug=; b=gRP7Cioj/SMOjubgZ0tw9jPxis
	xOmgUzLtn/cI9lAJiPHyd0GEvA1PVn6V8OF1MRJ0tvaEUcj3A4Zi3YgzAf+9oIw4rOLTsPqGPiUcF
	KGouOpzbwaZAXhmZQWclfH+wRtQmkH2MwPjLUkzqGZrr+NJhkXGzgVXJHLzZ2bECVdPqmXgVWVawS
	hrUTEozsZpzR2Wa/bfbXYFBO1RzqZ7honibLhUW3Zvu0NGDvt/Rj0z9B6+ez2Ad/ZZy1wqhixB+Dg
	82F5EC5tYsOrwMJTmR41b3E5B1c9HNyNBeaXz4JVk3+kbuBEYD31cDhkrY525xLXFEB9Kmn5Yw4M8
	x5Iom0Dw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2UHQ-0002qE-JH; Mon, 03 Aug 2020 06:49:04 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2UHM-0002oF-2f
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 06:49:01 +0000
Received: by mail-wr1-f43.google.com with SMTP id z18so29527112wrm.12
 for <linux-nvme@lists.infradead.org>; Sun, 02 Aug 2020 23:48:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qtS7GN/DmlJ0+Y1Zkb7lIX2+dO3mjZPVKKexH9jrXr0=;
 b=gIxy8gj+0v9mv3hCoJtZZ61TOvQ+gL7/mVndWo3PA8v03JwTQ0eQAwePP9tNpu0R6X
 tYxEaJ1ZplzceGWN77SYZDKZIxtV4BEDT0zHb42wGYSY+08W8yz9OGmo3hbsn5fQlKZ0
 eVIK9wdBKgJruhLYi14xU2gFBgrZILOoSsEaVTPmCTri+HIbNbFInXFfNj4NqmkEpVj0
 SbZZbZ2pmVTNkAqx2o8P5jR4NajhHrC2VFE4g66Mx+i73zjodNAKbdTeteiisexxbWJt
 JY7Wiko2U0D2RxniXvkXCfgRDmY3dxAda7qLZpzZfXCfX0nDCFZmp1JHDJGHju0LCoc2
 T1mg==
X-Gm-Message-State: AOAM533f18ZRunF/xhJZXDqb6q5zWVLa9kc6xcjueLSfQxZULUopCSkr
 dx6gK8sdPmZYgIyC25qWcuogm2p8
X-Google-Smtp-Source: ABdhPJypqA/h8Mho0nbJ2LD2zxCA6+EjXKvj08IlOjpKbpVi8B6BCN1ES5tR9xGTeJywKsCOPJzLlQ==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr13598497wrs.384.1596437338648; 
 Sun, 02 Aug 2020 23:48:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:6dac:e394:c378:553e])
 by smtp.gmail.com with ESMTPSA id z6sm23740647wrs.36.2020.08.02.23.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 23:48:58 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH rfc 6/6] nvme: support rdma transport type
Date: Sun,  2 Aug 2020 23:48:35 -0700
Message-Id: <20200803064835.67927-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803064835.67927-1-sagi@grimberg.me>
References: <20200803064835.67927-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_024900_183688_703C652F 
X-CRM114-Status: GOOD (  11.25  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 69ab7d2f3964..31d02fefa70e 100644
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
+		_have_modules rdma_rxe siw
+		;;
 	*)
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
 		return 1
@@ -115,6 +122,9 @@ _cleanup_nvmet() {
 		modprobe -r nvmet-${nvme_trtype} 2>/dev/null
 	fi
 	modprobe -r nvmet 2>/dev/null
+	if [[ "${nvme_trtype}" == "rdma" ]]; then
+		stop_soft_rdma
+	fi
 }
 
 _setup_nvmet() {
@@ -124,6 +134,11 @@ _setup_nvmet() {
 		modprobe nvmet-${nvme_trtype}
 	fi
 	modprobe nvme-${nvme_trtype}
+	if [[ "${nvme_trtype}" == "rdma" ]]; then
+		start_soft_rdma
+		rdma_intfs=$(rdma_network_interfaces)
+		def_traddr=$(get_ipv4_addr ${rdma_intfs[0]})
+	fi
 }
 
 _nvme_disconnect_ctrl() {
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
