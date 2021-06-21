Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E02C48BDF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 03:01:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9606052B
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 03:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9606052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DwHag+6henCfWC8UCQAdSgV310v+Uv6HQGnSe5+qdlg=; b=KVHIhvoSp6u9Sd
	+gqHwW8cS2V6pSKABl1fA9X9dC25jhdCmdwtLKXGRGTLqpQdJxUdseKVfcyWJQs78dM9bNtfnrfvo
	Tz2XgePWiWCBU5R9LdjVwkg23TDkCXsH3nrc56gdUx9yoWXx841a4GtMu8FjG7jvl+TuXVG17iHsM
	WMnrgblnyFhTe/CtBNWqhqre/+oM9jXFee9ID8HXkQr4HUjAgLEpo4w7f1gDJBqx7KPQgnwA02bLh
	01oQ0lkdu/4tQC30Q01k8YYXm58cs9hoUGMc+EgteqKXHIDiPawgbGYxkne0YIn4/QuJzTR8X0Nk0
	NY5V+aWzhVXY9MxRcaKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvABW-001va2-Qo; Mon, 21 Jun 2021 03:01:14 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvABU-001vZc-Dl
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 03:01:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624244473; x=1655780473;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=86IrHY0RUDVntpoRwO3mXZGsk+MJ8zktAgAdwRP8SPs=;
 b=jQP/gckzwxGhspg7gfmOJr9BbMsx6952E8y1IBjKUKlosz+oa0VDTHS/
 7Rk64vDFejxmkCqUMXuvRXO/or7BXRN5KzYNPE6fi79UzxmNI03X1f5E5
 dmXG5VUzhDHbYnZztFsdQwpKbA36IdEpTSD9NLQnD8Or0u00LYJ8UDa3j
 SQFYLjaaSemNXQtUOV0SfY9ZCTaYS6dFsCFfn0lZ5Q+khj6aUEf/QD98j
 4VsiS5rhfyIisWVVDoz90ZdOmLeq3Y1nDJugftyLvNHl1GiNIc0FXAsSo
 xj2zDM3o/sq1Y5q34ZpXH8RyutpbGH9CoM+qTja5qPSiedNYtiuYX03aD Q==;
IronPort-SDR: 2zX+XI4DIfcK4y1XGpO6SrPojOZvCpfykZcNblXjDnTwMMVoJU5MdPw1ZyXwdALHRrQHDDsXty
 PKQ73y3U4F8wmYl+P5IUMj0W6en4BpKl64/8jfdQKzyt0Cn1n6J4ENQ3U5MYqniFDSoMRrxks7
 g2mdMJp9t9BCqx1kr3zrdW+O+YFi7JTJQfVibvaNuZP7fxd/lvJYIvnF9HKtr7zOYpeqvyY4LX
 8LI1TsFjnf9/o36LeXkBp63oyAwb/6R6wHSlb/yWR5DmDK0sQuBs9Xr4dcB/sTi+jib6sKh9b5
 Bf4=
X-IronPort-AV: E=Sophos;i="5.83,288,1616428800"; d="scan'208";a="276229874"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 21 Jun 2021 11:01:11 +0800
IronPort-SDR: VZ2qF8FlIjNhiuLq5CYSBseMYEfzVNQ84mrd5Nlq4kVX0wUuQAnuIPmnGA1HXx2mh4HSsvyz59
 6i4B82BjBFThWwD/pUdzKZA5sFls6huoeAWC8tiDRh2I22CGE3EuzMC+rpXK42j4HcuHfaY9Lo
 H70e8Wu9dKrpiTO0bQoQJeyvRBEhZeZn5kxKtoIHAI0GWY+YOH8IkvHOId3a/JwpWZzsVATrtv
 3gPjIR/zLSXvF5ao86PJSBD9IkVXlVS00ms3Wn/24Uq9cWwjIL4Fallcyg/LIFNWSxKudpL0Xs
 SvVG3rE+UlF2N2GJzkFyDM9n
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2021 19:38:30 -0700
IronPort-SDR: p2huio7jiWW2zcnmUc/SNcqw5BIt91wNB4FzeygsNIYX97lfDefmxc2QJSn4Nj4AFXQPxrkekn
 x7dltZj5DsFFdTYWO6sOhB4C2+X/V5/gnYaYpQo8+eYn+0bKMMPawYTslYURGFV+CHMORPf6ON
 0HNnxZmp/79rr3RhWVElVwBkB+sQ4hWx9DI94fxZDObkU9Q8nVPcIyIK/2mdxsUf08xNk/3u7o
 GNeRsR3JF8NRCOURHiMJdEgnDJxSFldkOqv/ipqTHcHo/4xknw7tT7POiD4YxjJgbgEC5esrvL
 hrE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 20 Jun 2021 20:01:10 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] nvmet: use NVMET_MAX_NAMESPACES to set nn value
Date: Sun, 20 Jun 2021 20:01:09 -0700
Message-Id: <20210621030109.20695-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210620_200112_568874_B22539F9 
X-CRM114-Status: GOOD (  12.47  )
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

For Spec regarding MNAN value:-

If the controller supports Asymmetric Namespace Access Reporting, then
this field shall be set to a non-zero value that is less than or equal
to the NN value.

Instead of using subsys->max_nsid that gets calculated dynamically,
use NVMET_MAX_NAMESPACES value to report NN. This way we will maintain
the MNAN value spec compliant with NN.

Without this patch, code results in the following error :-

[337976.409142] nvme nvme1: Invalid MNAN value 1024

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 363e357d2f20..0cb98f2bbc8c 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -422,7 +422,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	/* no enforcement soft-limit for maxcmd - pick arbitrary high value */
 	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
 
-	id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
+	id->nn = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
 			NVME_CTRL_ONCS_WRITE_ZEROES);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
