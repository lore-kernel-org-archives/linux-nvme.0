Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15858C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD21C20756
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="St/IWESl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD21C20756
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3tIlnDocxbqOMWAxz4SU4XJ7isSpzM+TkzKSKuml6Vc=; b=St/IWESlG3eGhZ+m7VFEM1Qil
	VR3p2lqtoSBlFGAGN9DCqNZN4zHKQjV856HkmrVZ331Umo26diqNFYtFUp6UBHj+AvN71fqvSiTkK
	mp9B9pO7f4Lnd/LIer9tYds8fkAksZvZbt7v5vJGG9Y0Cv0JAXQIBvKggLIpBnUsPrtBjphZuc+Kh
	VjJ/EfTIOzhV51RC5l7Z+K99heUtuCJB5TUYmg4erBZek4bw76eLDKWzQQnJcMyCTzCZUMNQ6Qs3F
	kLMryOqdBabRpd8r5KWevjIE5RlnIeoY190v3eAwEASVzXlF81gEb45FhQxmF+HnNFA9iDLQ8WOeN
	wZ87c0KbA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5bOd-0005KP-CB; Tue, 11 Aug 2020 21:01:23 +0000
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5bOW-0005HO-P5
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 21:01:17 +0000
Received: by mail-pg1-f172.google.com with SMTP id p8so7273000pgn.13
 for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2020 14:01:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+tQe9TzFSzp924C10rfbzh+cSEn+WNgbe/z0aeO76DU=;
 b=s5XtGEazPp/04qhS81nYBI93wnIUxusgQ20tKSqvZthoaS+3h7uelFMG9crvtTAlwB
 g8z/o22ERvcjVDia5N1TmVNJppAFaYNOxfe3OQ3jmQK9IUsPkcHMoXs72YvW3ePeIykc
 B9S2H5gXzRDVcOcTTfw0TI53NOfPbJOQdhvfK66KxcWFqZdpV7KqwAYZs6cDIoMevHBu
 ALYd4xTDSM55rCbzfFl1WnlSoPuwY8kVLEcOKnud7ZB71RJrAZH7M0a8kBcnc00E3ICF
 z4jkWhP3dyJzWtZa3MwuXhf/u/+g9tMaTzaNVwuVSXC88m3PxQ3i2IRBHUyV/V2+IIZ0
 Fx6A==
X-Gm-Message-State: AOAM530igHOBPLPkjpb7mB1875wQ6hKV+YLrcWfiv+pPHrlrVloH97nq
 qMHYL3gUgyZyqa9pl0BNva9BXdEqG04=
X-Google-Smtp-Source: ABdhPJz0IVfqtwXq/pYkI3RFdFDyCJD5oNq5jI4lmtPWYBfIHC9/BQ3wpGyFzuwGenv6U5BYQvrB0A==
X-Received: by 2002:a63:ec04:: with SMTP id j4mr2261308pgh.393.1597179675107; 
 Tue, 11 Aug 2020 14:01:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
 by smtp.gmail.com with ESMTPSA id o17sm59370pgn.73.2020.08.11.14.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 14:01:14 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v3 5/7] nvme: support nvme-tcp when runinng tests
Date: Tue, 11 Aug 2020 14:01:00 -0700
Message-Id: <20200811210102.194287-6-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200811210102.194287-1-sagi@grimberg.me>
References: <20200811210102.194287-1-sagi@grimberg.me>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200811_170116_873570_CED0D070 
X-CRM114-Status: GOOD (  12.70  )
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

run with: nvme_trtype=tcp ./check test/nvme

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 tests/nvme/rc | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/nvme/rc b/tests/nvme/rc
index 306a12440c20..3e97801bbb30 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -21,6 +21,10 @@ _nvme_requires() {
 	pci)
 		_have_modules nvme nvme-core
 		;;
+	tcp)
+		_have_modules nvmet nvme-core nvme-tcp nvmet-tcp
+		_have_configfs
+		;;
 	*)
 		SKIP_REASON="unsupported nvme_trtype=${nvme_trtype}"
 		return 1
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
