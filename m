Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F8EC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:19:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F35C20838
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WGW4DpUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F35C20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vxHR44EFL68Di+7VnSc2J2A+OesjxfSK82IC+B0FdJE=; b=WGW4DpUxa8UMU9lnKoolTdI0i
	+6SD+5WCKDUmR/a4nkg2mHzQoXPOz/2spKoO+PptljPv1ADhqwq+pkb5QZJDCIXDUdxESrH1NLDxj
	3fv2opNQZAm32cDMfUhX50zW2Jgvw6RL4p6C90Q/FrRKcTkcGd9Rbg8z45XDWxbe79snJ6phX8JNO
	V5A8TK3ZZ5xGGJp78qtEJH4mKaNbrh8FK3iK5ezVibdZtLiYk58HRCzF2ZAdFZA6zVlAAf/yAgP2i
	w71IGIZobTnU+6X/Vq+yamrbToJqBY1gUnxOCBM9pqs0uXsOMAweWH2RJm7Uup9H9WX2S2SoTwksu
	d2M3JhnfQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6T3O-0002Ra-BL; Fri, 14 Aug 2020 06:19:02 +0000
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6T3K-0002PX-M3
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 06:18:59 +0000
Received: by mail-wr1-f47.google.com with SMTP id a15so7308900wrh.10
 for <linux-nvme@lists.infradead.org>; Thu, 13 Aug 2020 23:18:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YzAZ2SXXLc7iNppHmhrxi1E4xPI3+ZrsxT2yh+SoN/c=;
 b=BcXbnnm0na8BCqb2mP0ZVrQX/LtD+TfOq6KhgwUH7nzyxNSOmU7ITlQ8g6JQNm6BL5
 wXJ+cXjNBIzg7isWutF9HuxELQupNYOfJ/Sg2PrNLc8PAffjKLU83NmFKhBe94LMcLF6
 yKP1aCjIso0mjp61Y2TVveqezrmuTTxHedvx5GBXVsQTCbjfANJj+HgonDF3K3er+luT
 iB8GTfrBNYUqFrU5hx30rwYhYWX007Fc9IEPiLv/WYYf9QMO2Zh3thDPdu0fNgYCnLfa
 43z1cGBxalJQmlJj/6jHoCYAmu2iC3dPG3iEqCGvPJ/iTgGlE6OQbRiw4H+ilAg0UjUN
 /98g==
X-Gm-Message-State: AOAM532fAhdzUeG4mew9B3PeHGBRAx310qhP0svIgcMQC+81syO7/0Lw
 zSc+OZLF04YLCiYXO72e5R6+yWIghqbYmA==
X-Google-Smtp-Source: ABdhPJwvevobFTXZKCncDxkecs7/zrYPqWEQIV4UrRGbv7S4JgR4CgFY/JcVrtSe8e8OH7ZAIwKxNg==
X-Received: by 2002:adf:eb05:: with SMTP id s5mr1367225wrn.0.1597385937091;
 Thu, 13 Aug 2020 23:18:57 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id
 l21sm12278131wmj.25.2020.08.13.23.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 23:18:56 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v4 7/7] nvme: support rdma transport type
Date: Thu, 13 Aug 2020 23:18:15 -0700
Message-Id: <20200814061815.536540-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814061815.536540-1-sagi@grimberg.me>
References: <20200814061815.536540-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_021858_773393_B33487FF 
X-CRM114-Status: GOOD (  12.63  )
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
Cc: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>
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
