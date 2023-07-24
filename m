Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5B8C001B0
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jul 2023 09:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zq2IhI69YHD1Hh7JPVYvnZdNVD3lQLNNF6RikHayIf0=; b=2DP4R55ES4Q8DT1LZBcGHy/Rf6
	8ycvimRiAz43OVxtk5D+x0nTWdPLZUlfgo0ZY3FzDPTp2Ur0oVSPrLPZUIbkuqmr7zsg4bphuAQgv
	m4VhCzZqCOCWJIPTc2gM+koHxCTUdBALmv6TKHxFQeUPvxwDKl4pom+UBAv5z7CZPbe4/hNc3l7qI
	Ca/X5bQ22Q7K9MM0FTXXmegRhOzFguwfL07R3b9ul2L1USgXDkWlT9aKREzIezkvbZ1FobYXd+il6
	c35/3Ep6h74tEhKmhNk995DJK0nqGveEUP2CPEwd3O9EGBnBiZftHTLh1vlboqmvOBbLcm8TOnu9E
	c23kNFlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrkB-003Ntw-2k;
	Mon, 24 Jul 2023 09:20:43 +0000
Received: from mail-lj1-f180.google.com ([209.85.208.180])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qNrk8-003Nox-1Y
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jul 2023 09:20:42 +0000
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b83c673ab5so11262981fa.1
        for <linux-nvme@lists.infradead.org>; Mon, 24 Jul 2023 02:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690190436; x=1690795236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zq2IhI69YHD1Hh7JPVYvnZdNVD3lQLNNF6RikHayIf0=;
        b=cKAvTs6RwPrfQS+OSHoVB1FlNNj6W+gjakZet5gJAF+nv74lQUcvEulZTwd+skHYTB
         9QcJdMu4Joj3GuFQJUEzlXkCIWCQBZlbTEt9r2zJ39hwsxBZqC4p5Mz8qpZh5D4qmJRk
         a2j6oVztBK+d+5rdc6RIFaQ0CvPf1fa56SWBR8fo2KXk/qiT58LHTAGK+0GbhqDLFzTM
         lYhVa1mytEyMntv1xwnZzd8DE/lbKjAQM8D0KFgA9X0QHGFhPoyGFEtEHdeMHgJ6rEwC
         ghetVpHutL6qrXjGPQMmx39g7kUyFExPI5KsXV+EU7hn1X5yKmGUZTq4oEYwiYSaQpch
         AB8Q==
X-Gm-Message-State: ABy/qLaFnT9v9J2jh/p+w7LryX6PR44kMpiVga6vISlHIyxNK+p1wCju
	j/VYa6ixygLiI09R1G+p266OyThqtuQ=
X-Google-Smtp-Source: APBJJlFAEyQPFuMU6ODWNnkpvemomnk2QQHCREQC4wbOYZAWM/YT4ZFLWi6AMbYYlDeD1RdrSUknqw==
X-Received: by 2002:a2e:a267:0:b0:2b9:3c1d:6ec0 with SMTP id k7-20020a2ea267000000b002b93c1d6ec0mr4253045ljm.4.1690190436481;
        Mon, 24 Jul 2023 02:20:36 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x21-20020a05600c21d500b003fb41491670sm12354052wmj.24.2023.07.24.02.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 02:20:35 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH rfc libnvme 7/6] fabrics: pass traddr dns name if the kernel supports it
Date: Mon, 24 Jul 2023 12:20:23 +0300
Message-ID: <20230724092023.708335-8-sagi@grimberg.me>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230724092023.708335-1-sagi@grimberg.me>
References: <20230724092023.708335-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230724_022040_530523_C336D8A4 
X-CRM114-Status: GOOD (  16.41  )
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

If the kernel supports dns names as traddr (i.e. able to query the dns to
resolve the ip address), pass the dns name down to the kernel.

The advantage is that if the dns resolution changes to a different ip
address, the kernel will be able to reconnect.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 src/nvme/fabrics.c | 10 ++++++----
 src/nvme/private.h |  1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 2a9d8dc7f23a..0e9b4a15858b 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -736,6 +736,7 @@ static  int __nvmf_supported_options(nvme_root_t r)
 		parse_option(r, v, traddr);
 		parse_option(r, v, transport);
 		parse_option(r, v, trsvcid);
+		parse_option(r, v, dns_ip_traddr);
 	}
 	nvme_msg(r, LOG_DEBUG, "\n");
 	ret = 0;
@@ -900,8 +901,12 @@ int nvmf_add_ctrl(nvme_host_t h, nvme_ctrl_t c,
 		}
 	}
 
+	ret = __nvmf_supported_options(h->r);
+	if (ret)
+		return ret;
+
 	nvme_ctrl_set_discovered(c, true);
-	if (traddr_is_hostname(h->r, c)) {
+	if (traddr_is_hostname(h->r, c) && !h->r->options->dns_ip_traddr) {
 		char *traddr = c->traddr;
 
 		c->traddr = hostname2traddr(h->r, traddr);
@@ -913,9 +918,6 @@ int nvmf_add_ctrl(nvme_host_t h, nvme_ctrl_t c,
 		free(traddr);
 	}
 
-	ret = __nvmf_supported_options(h->r);
-	if (ret)
-		return ret;
 	ret = build_options(h, c, &argstr);
 	if (ret)
 		return ret;
diff --git a/src/nvme/private.h b/src/nvme/private.h
index f4992a48a41e..e58736b1e18d 100644
--- a/src/nvme/private.h
+++ b/src/nvme/private.h
@@ -152,6 +152,7 @@ struct nvme_fabric_options {
 	bool traddr;
 	bool transport;
 	bool trsvcid;
+	bool dns_ip_traddr;
 };
 
 struct nvme_root {
-- 
2.41.0


