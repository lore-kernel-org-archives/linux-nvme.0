Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D023C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBE4620885
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 18:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t5Jn3Xy+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DKaL2WBp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBE4620885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=yqMFm5k+GF+GRLx/0uGsUg1i3P7L3RShpwOAvgGKO6M=; b=t5Jn3Xy+pOJLaac/ajD76b8sP
	Dcy0N5g3H+v79/j61kL3gzfJZA0PY4O0kvXpgEI90WmO3m3drO6EC6K2d+mHVJ4Q4P+1t0+7Zy9wi
	1g0xew1r9kCGvItxrfIHCxRWWoU5Z5awrDO8TcB4gMEVFhT8TFm710yqGHhJoxPJz64jMsASKJiAH
	wdWuB+FHeC8emie0aZynSKDQL5bXfd8QD97vvPEbV3diZdxtt7go3XpK1vUoMvL++tI2T9X4UTYXg
	kq4EY3AwdRNPk0h2mC50ZqbLPIYGWOHxOPIoQAsSezbUlNAWabfqzIwSmtvXVFc5817V9ATSxvBcy
	KD8jl0yuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5Cx6-0006xS-0i; Mon, 10 Aug 2020 18:55:20 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5Cx3-0006wV-6r
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 18:55:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597085717; x=1628621717;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1YMQsd4gVfq5LgiaFM095nVJn02xwFg3SKvnEZPZdgY=;
 b=DKaL2WBpirFzLDQxLTE+ixh7C8JTMqUyVjZrIKjaQp09FYE6s3EDWWPz
 St0Z6pm5Ig5hFTssAA/1D4KXS0TuyjOBkPmKBaZ6Tb+U+c3o5e1Jns+IG
 +cTs1dN5bV8N4tj7t2quhAdjuj9H8miCFYORbzqm+kkKgg/NY749vWX0t
 6nDmffMC8hTa1lcJzwUhz2QoLr733ed+Fy1ZmMfpdplWU6mVRCdltbI76
 bpbZ+4TzStX/gk6/mozWOp/Me9z0wx4LTkh7D0+OR5sNYYqlNhImjFZkY
 Or/jO1sHhJMaAB6/7VLdc+RWlSwNSayooDUIBiIlaDVhnFWSYEAJPwJGD Q==;
IronPort-SDR: bbm9oqiSxfVEjO71UdY4I2aJwucnAF3nff6HzmBRQM1Rjsy/0iFiauQ2RUFmOJA8VbEjHbbSdJ
 d9ULseBWrR/F7NkkzFr8IIwmio3a0EdM6mz3zNHgwtbjJ1TW17CTc0juPgYZnOI2jV2p1zu5gB
 Q1gdFWVA9kuppphX0Qij18v9GQIzlNCOKbXRubtWD2cfcbhuqT0R8ge8zxVaLMgHLLzkQH5gnU
 MI+IPyaMSGR/XF/PHEjmTOL6iNf+TeFvWW4Xqo31eo+2TkHwbVTLi6XXC9PdYl1CvOCIAbsKpW
 P5E=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="144602271"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 02:55:14 +0800
IronPort-SDR: Xj+yySwUXqWB44PSFSdqaaAGQ267SoWcld5/ViI9DdhMp3DFLMSa1HPM7qn65uxTbeZdMBLQ4R
 7FGcRfnNBreQ==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2020 11:42:25 -0700
IronPort-SDR: jNxLAVDIiKZNLyAEOjnIWgoSkaT4fFxYK0FZv3yZWRjHlqmO+NUpS5EaZCXCCjWUsIU+/jmocY
 JdxA/dfjiPpw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 10 Aug 2020 11:55:14 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 02/14] nvmet: for pt I/O commands use likely for ns check
Date: Mon, 10 Aug 2020 11:54:44 -0700
Message-Id: <20200810185456.7713-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_145517_403452_B7B6068C 
X-CRM114-Status: GOOD (  13.37  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I/O commands (nvme_cmd_read, nvme_cmd_write) are most common commands
when accessing passthru controller. For I/O commands ns is always
present. Annotate post request submission ns check with likely.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index fd1f754de5b4..b675662654ae 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -268,7 +268,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 				      nvmet_passthru_req_done);
 	}
 
-	if (ns)
+	if (likely(ns))
 		nvme_put_ns(ns);
 
 	return;
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
