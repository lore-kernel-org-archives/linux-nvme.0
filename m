Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85C5C04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:43:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22877613D8
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22877613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJ+N24fljNZo8UyyPfuQn6kVTP9p1O1emGr7E27mPTM=; b=hKWOoTjdw5BKW+hZLhdoEF6WN0
	pEBzkKwHrhEdvnQ1Orxijk5S5oa+n+XpcBQww1ZJLPKEJF8Pq0WMFWrEap0kRgIC4NdnU3EmDs4Ph
	2PBUVNOxRJcYvpwmG8D1YX2WAkoG0zQ1ZFqjXFBMY6/u5Gkv/Msr3Jdltn/bicR3YBrvzTTTsRpVZ
	QpdXGMoX+ubYPhzzB/KSCgIo7hcdnxxgVNACQkAU3xkkkosgCxACbxOF3B2xH+n3LZ1kL4m7ka57R
	Bv0NUX4lRNFx9ydD7EvMFQxGDh5HkmixyjTp+r2hFyZ+kB3BeHu03F5w/3CWGVjLwWJr7gEgm4MYx
	vwcv2IGQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkDr6-001Gzs-CM; Fri, 21 May 2021 22:42:56 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkDqU-001GsO-8F
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 22:42:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=sBrEz/KOnImnuSjL69jtj1PIPs+W93ho23YytCiU4oI=; b=IqLGLn52oie4g8lHJBTeHr5F3L
 KXnBjwNzthcGYGGlDSwduzXIIQFh7PoB8qdT4avpbD+s4BZBIRqTmUTxSlF/r8hKIWI/DfozG+GFE
 AId0TRw60Ui7uNvifeuyNaYVrHG24/qjUZEW6q8/bqVW5m+8dYFR//0EZ2Uc7SYnUDl5lf3/JHA+s
 w6UWGICKrjeovmpQFd0NwY+ES2jqbSLM9e6qn8Bbo+E2D64FgAGkNGHnuKnoaTrwSUj30ikS5kzU9
 DVJt9QN4Ql/NOX8NeOMAyIoLIGD8FjR3WtXUxkC9MnjbC/6JpX0opuPmJ82LTjX2ON2XTce+Mu77a
 2bHWj/Yw==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkDqR-00HTfb-NY
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 22:42:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621636936; x=1653172936;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=a0+s9c1DqdiEF1wjzcDQAwFRbCu1SljxFvLKyKBN8V0=;
 b=GMoMz8SZPCbDBYEFsLHltIuYUMNu5nhhSysZMlwovln3SEOcx8soQCps
 U2fSms+ca0m29h7HxfVz4g+0jGMrP1/U6qZs3ml/FrABETV6BC2uDNo0/
 Ni8h80RA8T/1CEBKxW5lEo5E4mfrcrq8WFomjiw4wM0p0ZsVKf7Z1YXY0
 R/Nh9hScwxkTpQWmMHfujF4MV7g567t+y0+A5AZN774SAvHWigw/lteLm
 sl24w1NWRW9wffU3IvleajObbxj1Bbnth37Bz2+CfqGZLr7/XRC9rxGQZ
 3pOxLaG6TvbUitg+kPcUvVeYKn6CSiC+brNA3epvZ+eG1qPruPNIdPkP3 Q==;
IronPort-SDR: B4NT3lGN4A322j4UQe+LAhDyR/vY8hKXAc7FJN7EkppTwy07zzOGWras8jFFjAMlYzB/x1qsJX
 JMquq9U2KH13noax5eQgAIszWyCRNUCqFD515D3NG/mO0bfpukZhJXsdQtOAmwAXjAV8zeyRGh
 darm6xyxTQ+FfXXVP70R9qKGapVPNMf7SDHOWEygnBcmalULW7Ji+GaNMjTW0N0ZFIwdaOQSQg
 4MFBnAcKENFXRmC4r1Re0thUeRwzeDf6MX0xynPfjjz//DzB5HLTHZ3o4DCNPZ5IKr+vBOdtDb
 D6A=
X-IronPort-AV: E=Sophos;i="5.82,319,1613404800"; d="scan'208";a="169598959"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 May 2021 06:42:16 +0800
IronPort-SDR: 8W4FywBrihe+2qJ4nQdFlBfmePzqgTRPL7Gl+SUI94f8IXziD+6c33l420gekeuZ7U4AwzojVS
 bYbmUDMpfIL/ZTir98NmIHXU4HlhlqWZfief0q8HtX5gDIgka4btX/yhkLmKfdbZsRUfEnEthh
 1CKy86rqD6rBbdKo6Hzx1BBKSDSsFBpVGQiRkOag3MmOiGkABNWkuG0VPqBl/1hoTmmltbZiQp
 6bYDfbIkL4CWiJ+8HUH7HF8SWg/UeNtpWr8yHfWA2YnI0jpdtuYy7BoT8yifWg3/gIVBp96/4t
 JDZSlH+iKgaXYnA9huEIKshu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2021 15:20:37 -0700
IronPort-SDR: 4y0HbkptJAd8wgfka8f/r2t+0YAZuRvtmGvnTTL5nAw0d75mx41Ccx9tHf2qX0GIIZnoCgMibk
 pjqMnOIg3j04A9MH+Ec1ZqD5xstWiudgQGgmtHSPvJVJjQ8sxifh0xPtAqurWLKdF+oAvmRVi4
 SEffwH/jO+0sWU1K1OW/z+ZYcgGKidcOI/w7MiISlNmZ/mJ7lUBT8k0J5V8Z5aG8/lHAp8FrOu
 6o1UAaSA4Ru8XkYTQmsZrmcey/HgQr8vPSfZJo4zVxgCbZXKOVqm5ixSD1Jd3zhz5xEW7DthFH
 B+Y=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 21 May 2021 15:42:16 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 2/4] nvme-fabrics: remove extra new lines in the switch
Date: Fri, 21 May 2021 15:41:58 -0700
Message-Id: <20210521224200.7380-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210521224200.7380-1-chaitanya.kulkarni@wdc.com>
References: <20210521224200.7380-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_154215_854512_497BB8F0 
X-CRM114-Status: GOOD (  12.20  )
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

Remove the extra lines in the switch block that is not common practice
in the kernel code.

No functionality change in this patch.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/fabrics.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5a1b8a1bb145..86004036bce7 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -271,7 +271,6 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 	int err_sctype = errval & (~NVME_SC_DNR);
 
 	switch (err_sctype) {
-
 	case (NVME_SC_CONNECT_INVALID_PARAM):
 		if (offset >> 16) {
 			char *inv_data = "Connect Invalid Data Parameter";
@@ -314,24 +313,20 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 			}
 		}
 		break;
-
 	case NVME_SC_CONNECT_INVALID_HOST:
 		dev_err(ctrl->device,
 			"Connect for subsystem %s is not allowed, hostnqn: %s\n",
 			data->subsysnqn, data->hostnqn);
 		break;
-
 	case NVME_SC_CONNECT_CTRL_BUSY:
 		dev_err(ctrl->device,
 			"Connect command failed: controller is busy or not available\n");
 		break;
-
 	case NVME_SC_CONNECT_FORMAT:
 		dev_err(ctrl->device,
 			"Connect incompatible format: %d",
 			cmd->connect.recfmt);
 		break;
-
 	default:
 		dev_err(ctrl->device,
 			"Connect command failed, error wo/DNR bit: %d\n",
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
