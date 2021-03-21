Return-Path: <SRS0=79y3=IT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE25C433DB
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Mar 2021 07:09:07 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B016192C
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Mar 2021 07:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B016192C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RPy3OpVz7Zo1uKisi9M5lKOi8cfdCjZtW3UIuODYqLk=; b=HmuUV6YXXhYmFQ85fjqIqJIi0v
	6Ar/tlm40a1GrQHDkgSDHPbwKRYcT8f2kzsYZ6KaWs82Ovz8PV7WkcVxNdo681exW8iYHdMZmD9ug
	+hR5lmFWkkjfn/jr4tsdjPu/oVVG4h2guSthV+bJq7jYM83x/zpV/Are9qLywqXkIl/fDcttcqv2X
	bjTYFkymcTdF4dbnce8wxYf2HXBS2dn6B+0NOgmjvc+5mBypIrV/cwMdc85+3NYVvkH1YUnh9JfWM
	uOdqbOBtTE+uT6dN6+1WzpYPFR8jBfiR4LG+V+vz9NAn7dT75P5jCPeVFIWD2r95MEEva2B1cHTgO
	K9/gEs4w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lNsCn-009hTA-C7; Sun, 21 Mar 2021 07:08:57 +0000
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lNsCj-009hS8-As
 for linux-nvme@lists.infradead.org; Sun, 21 Mar 2021 07:08:55 +0000
Received: by mail-pl1-f180.google.com with SMTP id g10so4939461plt.8
 for <linux-nvme@lists.infradead.org>; Sun, 21 Mar 2021 00:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VN1W8Xz1+n8iVHZoIAX3j5SPw7OVuaBJT56JDC14Qvs=;
 b=k9n5n8ysVxgYGJvfY9FAIy9R3fHmGDPVNQHWu5wl2j5u5tW/qbi+Rm3YJ7MVsiprrR
 OtefLGqkg0vIYaVqWOFawNZrEpX6OMs5twh5F02fJgCpxoFDpb3bGrNSw2EGo09zSlLK
 BbJ30TW1YKXbuA+tDTgqC8HeM2yA4AH5W3JLChMSeF6vWmWLg89yq31iC266UiZGkB/u
 E4ggXsvi/7Stb5c6GpYdwkgP2n+ScnOSNyg1FfySZ32E+RGDAxGO4hy31ck2lLiHhyNo
 DkL1BJC3d4vUfMug+z38JUbj2v4pSVQVZFi8qLcZqZhy8k7QL5Z5pfUNnD3Lw2ObpfCh
 lUzQ==
X-Gm-Message-State: AOAM5336RGyNYvQ1DLAaEDw5fjRmF1xPhrTnUo0b/kK5dFUppVTi2AxP
 DLhY2X1BfR5/GluPxK5Uxi0WOBB09Lw=
X-Google-Smtp-Source: ABdhPJzi+2Ah7DnxshYXZql+Ao1dqaldOW3TXHWvg5HgdBSgDTznAAx06lSBbRGcgXBFmGu5wJg1kA==
X-Received: by 2002:a17:90a:db01:: with SMTP id
 g1mr7066279pjv.127.1616310531566; 
 Sun, 21 Mar 2021 00:08:51 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:b1ab:c8be:b97:f20c])
 by smtp.gmail.com with ESMTPSA id
 y194sm9891015pfb.21.2021.03.21.00.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Mar 2021 00:08:51 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH 1/2] nvme-tcp: block BH in sk state_change sk callback
Date: Sun, 21 Mar 2021 00:08:48 -0700
Message-Id: <20210321070849.813104-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210321_070853_782190_65218494 
X-CRM114-Status: GOOD (  11.96  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The TCP stack can run from process context for a long time
so we should disable BH here.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index b81649d0c12c..480e229f627d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -874,7 +874,7 @@ static void nvme_tcp_state_change(struct sock *sk)
 {
 	struct nvme_tcp_queue *queue;
 
-	read_lock(&sk->sk_callback_lock);
+	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
 	if (!queue)
 		goto done;
@@ -895,7 +895,7 @@ static void nvme_tcp_state_change(struct sock *sk)
 
 	queue->state_change(sk);
 done:
-	read_unlock(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
