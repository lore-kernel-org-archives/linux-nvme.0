Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138CBC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 305C62177B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yrqLko1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 305C62177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L/B9lb8jjz5EvegrP4M+8umzaLoQB0S9KKdjZF165Ug=; b=yrqLko1owL0UK/ISCPg/2t607
	oOEWI0aICzaZKjNn9MU+bcN8MRrMAXCYWrqS8s09A3+k84OIJU+LYVmMlAzUN1PhPIqJqpYDHOqXd
	QX4ufvPy+J++eGUlXsIROEipk6YhL0QeCRRfuVfDTLaQSi+L2nyAUad7BJMVne9YCvpV5jxIW5EvK
	5aBv6rPUmRVmlcKq3zwJmw+VohkKMEg3xZuwuOmBnLt3ufHwiD3IrLybwHJRVViVD4a1aXf3ccsGI
	NnfMzAVtG/7SaixclD0ibaziNnU/95y3/CSg2F3S0Fqv8bryP+U3HSc8Hg+8EGZBIu/plOoxU8o5g
	noj63V+yQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lMl-000195-Ue; Thu, 06 Aug 2020 19:15:51 +0000
Received: from mail-pg1-f171.google.com ([209.85.215.171])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lMT-00010n-Gr
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:15:36 +0000
Received: by mail-pg1-f171.google.com with SMTP id p8so11356913pgn.13
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:15:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qtS7GN/DmlJ0+Y1Zkb7lIX2+dO3mjZPVKKexH9jrXr0=;
 b=CXQgzu5cZpnK9Rgckq0eM+N3Hbce8+UfIGXRWLiZHughdpKsWePZamrtABl2JJ31x5
 P52N3Tejx7NQ9uxryJgNyqgnGwY/NlvZSo9hkaLPIIombKmhlK2h8usB/Dr7+lkJnXCE
 DwnDB4dGfcX/JWObBlvCXwv1qNbf04Cgt6wXt55zmjwWDLSZkPNh3sZFF692LZlaG1VK
 /rwLGYYA2sz8ns3thly0CSy+Si99EeF2gdOMHXEAsKhtAY53/gPXbhqsbTpNa9cLYrns
 X5qpEvOI9fMc+2wbS4a/3qS2fGr8y/82UajN5PgK+W1TSeZHrxhAPaFBXOQUm2dkRmA7
 gC8A==
X-Gm-Message-State: AOAM533ZhyYuOIO0fvVmzWvRJcOeOwj1itqazAV9nAnfrjDKFfDEeVaK
 oF24551zdOhka2tQ+AbdfaWhERhn
X-Google-Smtp-Source: ABdhPJwUfzHJygCkt/ZSQ/NWtPPZ6XqymFrerPVgKv9FB03oB+ePVKrT3K5BtKY/Z6wfaoIjcAZ++g==
X-Received: by 2002:a62:fb0e:: with SMTP id x14mr10096870pfm.34.1596741331662; 
 Thu, 06 Aug 2020 12:15:31 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id q16sm9784014pfg.153.2020.08.06.12.15.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 12:15:31 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v2 7/7] nvme: support rdma transport type
Date: Thu,  6 Aug 2020 12:15:18 -0700
Message-Id: <20200806191518.593880-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806191518.593880-1-sagi@grimberg.me>
References: <20200806191518.593880-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_151534_339862_6EFAFA79 
X-CRM114-Status: GOOD (  12.37  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
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
