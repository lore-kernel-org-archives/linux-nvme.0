Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DECC4363D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:31:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAC5B2087E
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 23:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="swQofBbe";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hagIeFbF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAC5B2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FiJjOGgu69nKYWQ3DSTYn0SozEo3GbPpLj1tXbnU4BY=; b=swQofBbelQpxOrZv/5vHQ9G70
	zYm7joKujCaHfnMAFry2dz8PsZLuSsxNBP172Zd/gTvi2uLp5h/ngWHJNYDxH5yvWpCZoGXWzbBpH
	jEoTE/nv8KU6U05EEj6gD1BNIx4ag9PnvvHoBceFwkN6XYpK8dAP6rlv52wDBQf4W9f1xTz8TOWox
	bUuPA2Tj5Y+8Q9twBnoAJ167qHa/wMwcEiIir3INb3Xs5jjJceKKI1QUxHTRTo7FrKaTTLa4Sfv5l
	OeAN5G7SMzBsMeI/eDzhnhxMm0GYcfnWhQg2YKBRw6vr+1M4Irx+MlW9vDZ4h/OARbD/iM6rl4AIX
	g3xe9YY/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPwQZ-0006HB-Va; Tue, 06 Oct 2020 23:31:28 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPwQY-0006Gh-LQ
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 23:31:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1602027086; x=1633563086;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=wD0nXdzoZGCqncahkM+IkBJvfBVCogZeC72JEvLtCu8=;
 b=hagIeFbFvLxM/vRqNb0r7XpvaHA9oxCtde2Nhek4y6+pZ/ATI5AAyKmK
 wHWpSKfm1On1vCujJ7g0WlMfeH5rPeS+MqijzD/1he7dlgtqkzi9sJ8tk
 kfi7qM8A1vj1G4j0gDCLXrk8Nd0TJUp7FRSy6Ohi5gXvTw3GxSyIII3Rk
 NyR5sKXfwG11Y4o54231KjfUSTzGGAA1gkd6qZlLvPaIgLPbNX3BO5RZB
 dgeK9UbfXknPsxYvbJx5pOvjf3wINEiSucZau1kAfocq7I6joBCkqZkKq
 7vcqNtYm+ksmGDd5WPRDSFjFL4fGFFN+5BpuQ0KIEfVTVfOelk1DUMBdx Q==;
IronPort-SDR: SkwcYpUBD6Qpyfhr+eClkeiQMBqtNAnOjGpgtx6TJFOnNB55ESTyrzEhFmE68nmyVjcgzkgD2P
 lE24XJmiZTC7hq1IFodyrGOTi7W0TvMRude1199Lcy7Mi68cz8WTpct4ELye8cznkF25qAZDcm
 owRt+5tWR6gIt4nY/VBp+rxtCYY/pjQEEKorukRT7nmrpcAk4fd41NlklYwuhR5Ma1lIbBfzOu
 6zkICPNsxIVgMjHkTiAPvC6JLWP9IGPuDJwkybdZ/pzAhQHXZlZUCrakyrPjxQ4hl1Mekw8zzU
 O34=
X-IronPort-AV: E=Sophos;i="5.77,344,1596470400"; d="scan'208";a="153631348"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Oct 2020 07:31:26 +0800
IronPort-SDR: a70lx/eYTHRKkzL/+ztjuNVd0uzhOJJAlzuaDWXT3c8nCqJTVvqJHfP2SYrFxZGoXAO/C5lto0
 /JVQw5pVoCLg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2020 16:17:16 -0700
IronPort-SDR: TZ/KPlVM0QnnpbjQ/UMWCRJsCuppDeaR/cLzZ93Bi4Gc7K9PKUcLuIVc7Z8KcrZMblXMyDjCw6
 tfFnZKrWyArw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 06 Oct 2020 16:31:26 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 3/7] lightnvm: use I/O timeout in nvm submit user cmd
Date: Tue,  6 Oct 2020 16:30:45 -0700
Message-Id: <20201006233049.55458-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201006233049.55458-1-chaitanya.kulkarni@wdc.com>
References: <20201006233049.55458-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_193126_832372_8530E5F2 
X-CRM114-Status: GOOD (  14.32  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the function nvme_nvm_submit_user_cmd() it uses ADMIN_TIMEOUT when
caller doesn't specify value for the timeout variable.

For now we don't set the request queue's queuedata for admin command.

Use newly introduced helper function nvme_default_timeout() to set the
block layer request timeout value which sets the appropriate I/O or
Admin timeout values when caller doesn't specify the timeout value.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/lightnvm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 8e562d0f2c30..784be80ee2f9 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -774,7 +774,8 @@ static int nvme_nvm_submit_user_cmd(struct request_queue *q,
 		goto err_cmd;
 	}
 
-	rq->timeout = timeout ? timeout : ADMIN_TIMEOUT;
+	if (!rq->timeout)
+		nvme_req_set_default_timeout(rq);
 
 	if (ppa_buf && ppa_len) {
 		ppa_list = dma_pool_alloc(dev->dma_pool, GFP_KERNEL, &ppa_dma);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
