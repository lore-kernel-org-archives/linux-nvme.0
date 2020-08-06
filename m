Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71086C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85E002177B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="y8e9LYv3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lsweflfQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E002177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6yitjyM5/0xN89HjsXRLJWm+be4tnHqoAlmkCM1JXCM=; b=y8e9LYv3PocishX3a3ENmNdZL
	75TuLWck9aroveMSoWGjqpkt5mrprMP5BCMhXGwOIB08aeYM5mJs9k/FSuOyqeaRfSVSpNN6ldgth
	zWSkDY0Jp7daOeWQOHAPuaxDhYKaOWligopCfbQmwJ8GGXZlGym4Bbx+DdMdawsWgdg8qIHyd2sU+
	HZ7hMUryrV+iZRraPvaKtLN1P3BniGrCte4J/+5sJUlPjAQN8Wen+qCXjNYSYdzTIoZ6nLNfDi3Y/
	8CG/Io2J79D5k+drYgPpzAXfBx6mCvivOG2atynGjGN8IlL6DQMmt4vfRu1p7W0x9+dTlTuTxQ3hk
	TGp5MRtHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lMp-0001BE-0T; Thu, 06 Aug 2020 19:15:55 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lMX-00012l-VC
 for linux-nvme@merlin.infradead.org; Thu, 06 Aug 2020 19:15:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=mQg0QW5Ii5wVrkyjrYOAVjHAU5a8a/Cp+IYFCQV4S8g=; b=lsweflfQcz8uVXwzFkRDDl++YQ
 7+gk7guzJx38PO3qUBO7mkqoJQmKqBgmFsCBhAD3RZiu7KL6SVOcVUsELRlwEToepRYqibzKULKey
 PuGQt7DNS5EXT8kHxJkGk9tSkGjVVw6aLlOosAdfACOsVsGLCCeW8wspDHZ13ub+09/D6tXtmxxtn
 MwdyAH1SuBGMMJV86gfbyV7yQfL3SXegwdmarAnA4pQS+fAoFmy1EtFygnMJ+BhkuGo4ViWguBPCQ
 Q1fZQNSueuueTWgzXgImjq0PkhsMKvrSqPeQnR7DA5djeSsMO6JZOHzAegxAbNhF0hp7uyNivojhJ
 7B18RQ9w==;
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lMT-0003DB-RR
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:15:36 +0000
Received: by mail-pj1-f67.google.com with SMTP id d4so7171529pjx.5
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:15:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mQg0QW5Ii5wVrkyjrYOAVjHAU5a8a/Cp+IYFCQV4S8g=;
 b=Fkv2rVE6nYLhuOFdaQWXZSveB/YccgqsNTInODdOD71pO8PFR1V0lhSYPmotw5QdLL
 DZN5oj2Uwx3F9YPTV00z8zwnhw7A3LpM7FaZvdDf6m1qpoBFP6q3xoGlU8BTQ8XWyxjE
 C+aFiBVJM5ddLQZwxfL30ZA1g18nkzni//axm8vcUj5viATRBO0wO3ICn6DEkUnyNu1L
 jCWoKwIMqvR6kUxQspkG1/jDBDCGBPbxve03LSASfvsDVFIhgMWzlahX0qqHaosod3Z/
 7ybNHiHpWvyGCX6o6Bd3KFdClEbDJFSYh7tFRgPo+Ab8aZ2YOALhUMFyern3+VSy7WOr
 Ll1A==
X-Gm-Message-State: AOAM532UZjtUr2iqedx56xAMLCY0VD0G7L1R6XSAEMC7BrT02srdtfI+
 D7qVOAwZJHHa6WZg992l7s1q4tHw
X-Google-Smtp-Source: ABdhPJxpKsWTAykfSJ0wzqMbrpgSPDXpwHBHIA/FIMsyOECQU+LDMn/kUKmdUMP/fDjvNhnD6Ap8RQ==
X-Received: by 2002:a17:90a:fca:: with SMTP id 68mr9362904pjz.12.1596741330403; 
 Thu, 06 Aug 2020 12:15:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id q16sm9784014pfg.153.2020.08.06.12.15.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 12:15:29 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v2 6/7] common/multipath-over-rdma: don't retry module unload
Date: Thu,  6 Aug 2020 12:15:17 -0700
Message-Id: <20200806191518.593880-7-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200806191518.593880-1-sagi@grimberg.me>
References: <20200806191518.593880-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_201534_251849_58A68A36 
X-CRM114-Status: GOOD (  12.83  )
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

There is no need to retry module unload for rdma_rxe
and siw. This also creates a dependency on
tests/nvmeof/rc which prevents it from using in
other test subsystems.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 common/multipath-over-rdma | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/multipath-over-rdma b/common/multipath-over-rdma
index 676d2837fb06..e54b2a96153c 100644
--- a/common/multipath-over-rdma
+++ b/common/multipath-over-rdma
@@ -457,7 +457,7 @@ stop_soft_rdma() {
 				fi
 			done
 	)
-	if ! unload_module rdma_rxe 10; then
+	if ! modprobe -r rdma_rxe; then
 		echo "Unloading rdma_rxe failed"
 		return 1
 	fi
@@ -469,7 +469,7 @@ stop_soft_rdma() {
 					echo "Failed to unbind the siw driver from ${i%_siw}"
 			done
 	)
-	if ! unload_module siw 10; then
+	if ! modprobe -r siw; then
 		echo "Unloading siw failed"
 		return 1
 	fi
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
