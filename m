Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C7FC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF995206DC
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xsKTzzT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF995206DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vxHR44EFL68Di+7VnSc2J2A+OesjxfSK82IC+B0FdJE=; b=xsKTzzT8AaoN3rDLmjxyyeFuG
	ghFdazdKjHvsbRbPTFEBMPUVBjwipAO2+nqua2NfscBnu+8qlcUOaSN44r4fio+H4u6ZPY+oH7nLN
	Qbqh9IbyXpTD96Oxn9vFPcwcHtx8F7P0g6KqW1/KhA8VdWV8wHiCGc1/AXSI+7fRWVDtt6sWYoEW9
	lmp7usKE1CK4lR1oIRaFzwmR37IkliMw9wmauU9ptvXgM4DAOUmqZ99o3B7dxtarprfqvU6+F8Z+0
	JiHEGPHI2IErqDuT7vdO2rPZJE2djcf0p4HBqZjqIqW+ni/CQlAJ+GCYtrHpQoSBYYjGjb2dVE2pV
	qeizvk9Ow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5bOh-0005M5-Ue; Tue, 11 Aug 2020 21:01:27 +0000
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5bOb-0005JH-DB
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 21:01:22 +0000
Received: by mail-pl1-f170.google.com with SMTP id z20so111983plo.6
 for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2020 14:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YzAZ2SXXLc7iNppHmhrxi1E4xPI3+ZrsxT2yh+SoN/c=;
 b=Rg6My2yCJ0zgP+gbkSnG2XrLLey54RzrWLd6PrzV1GwiUUK0J2zDC80e9Jaf8NS8c9
 hnGE0eSsR7/Ew2YyYHzQPBS9ENKZJwxLRDDTElGw81aBxPL9wzBXzbm1YgwJLuXCzJLo
 SgeucI3XiBJCUQdYNYfZ7mbXkOWzCqCmSy9PdSynRHMYNlP5pZKwmIFZAJU+O69AUueA
 LuJESbVkU8XIY+m0ZHvNy8MgZDrnEu/mwdO1mD+nXbn6JgwydbrPA6RLLTbwXf9yaNMW
 8KtOseVgOCN7S/zc6vxpD+DtpKxVKZuRKC0gV1ng2ERUxK4Vk/UNVwo0DDdYTsvD4EOf
 qzbg==
X-Gm-Message-State: AOAM531j3zOLudSO5ayXUz4MPnnFn+pha9v73gqUW/rEpDCX/kQ9yBI0
 GIJfCQdEaU+7Pobjra3tMKzjzkHQGPE=
X-Google-Smtp-Source: ABdhPJxY9sueg5kzkDkt4NCP10V5sw8acM0u87BVwAs9ESkt4Ym5QoHUmynh+dofgCRrexyUD1okyA==
X-Received: by 2002:a17:90a:b986:: with SMTP id
 q6mr3009212pjr.54.1597179679649; 
 Tue, 11 Aug 2020 14:01:19 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
 by smtp.gmail.com with ESMTPSA id o17sm59370pgn.73.2020.08.11.14.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 14:01:18 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v3 7/7] nvme: support rdma transport type
Date: Tue, 11 Aug 2020 14:01:02 -0700
Message-Id: <20200811210102.194287-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200811210102.194287-1-sagi@grimberg.me>
References: <20200811210102.194287-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200811_170121_489380_A589841A 
X-CRM114-Status: GOOD (  13.31  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 3e97801bbb30..675acbfa7012 100644
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
