Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72225C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 01:57:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2EA64E02
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 01:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2EA64E02
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aq9xVkPgluZK0/7t8yGKAFEXhaqvaAkDG6/GyGOBeeo=; b=0mlMvj+Qdt8Wn6Pg4eBoykTpd
	1CKmPpld05GE+mnriBher50jGbRt0KsCktkisK6jKTQ/iebz5O8MhEZLfjgqBu4tXXjKxP/kcU4SM
	4WDKF6HuiRJU6cC5Qop5VZ/sCMDJm1V8qwVKTLf4Mex6glewfsMAa42JDkfpXIAFYL/OnHcBfwWyH
	FaZIwnnvY+duuU2rIzWy0S1U6AGXKq2yM36Ie1wByzpJglLSp8iMrSoCcWhuHU7tOskp4ln3bxAYA
	wgVNNTFZ+z2ZM74A60JhqoHNK8ZwjW+pArexoh+g5ibUr/R8IpwX0FU9d+a+1pxD3ObBRefp1EfHh
	BxRm76xOg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lF5tu-0007i3-KL; Thu, 25 Feb 2021 01:57:10 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF5tq-0007hT-VI
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 01:57:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614218226; x=1645754226;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8m5ffGu31/X2BXpV1TEkqfAOUd2sImstETaK4fnequA=;
 b=gfhcvzG7b2tMU1CWB0XupD1ETKGJE+Mzah2j3Yk5Qqr0i1Tt5+cB7hpB
 SuM7Yio+SA0J1NcyefWPtwKEzHgcVMwGE3WTU7FgdDW/lqa4Gyc2QvFbg
 5PfWAepHQPRaetUhcRpSNLMw0EFInGZifjIbSAm/YqzknjqvU3B84cx/2
 UzxL34GZiawoq+RSD87gtO/ldd38F52Yf9qyCU+wv+G7y4E0dvyeZHWpO
 0JJsQ6m06gGXn/1fZYHkQI+zP/jLesB4Gg5kZeyr3qSeVHnURKnEyKXZR
 kbW7EtEI77spBfCAt0dqHMcdNLROvfwYAMsPa7jDoN8o8iGCRJl0MFpOp Q==;
IronPort-SDR: FYBPf4Qx/tfIwAagMqNleyWCrCeCLXDG9oKIim7Hll9SsTch1fNvTAbvFYpg9xfBM9ReGQK1tc
 CnWeWyVxd/KuShXJEERvaimDydXE1pXYTllpiYFe1D16/Odi+NHd/6q548G/WIY2bjHrcBme9w
 5dm+sM5yQyEDrs7M6ynkAPoRvbxJHI53liS/EGoULj5oiu2o4iNy+IERBxvcf2GYKmsle9zfHI
 ifC3jHTydPaUuuaG7CyP6X3lclcGRS01pxIMIuSN6p4rFqiQPO0CRjpx58XRgda8Ns4ckdWcbK
 bD8=
X-IronPort-AV: E=Sophos;i="5.81,203,1610380800"; d="scan'208";a="165227756"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 09:57:05 +0800
IronPort-SDR: wW9rv5yifDI+5sRbo7vUH30zsBZOJpGgFntYWkqu5vNgqC0uieYhHSeJKPYjTGw20+x/Yt0Eki
 boqLb9YqDNYxlUcZlLgbdIhgL4sWjGAwT77qibaWFaBe7H/XVLD5XXmtyBxhURJJtZroZFnThO
 GES34hj10EYROYrW0nUhoBN6R0j4CikPSWuZC/9PUkMHflf1xSbKAHXsVrVgu+foFzB9SFyjv+
 /zdh//iiM9IghY+MN/kgmLXgS2skTS0pyQEKeUX1cxZcDgADud4rvoLZmwvvV48BT3k0oJeXtW
 8yauQVDsXpnNjQ8yKSicEsCd
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2021 17:38:27 -0800
IronPort-SDR: GQod8ouJvlCpLUNfGpvMe/xvvaNBaWSG2p0Swd4mDYN7k5iQNbmSsq1r4TE2+N3Q3ZqnPg/cZq
 7V+X5jnmTTKJ3zgWGjttEE7tYCS9nFeaHVkDZmriOXwafvZd+4k8yQFBF447TTYTIrRRIS2vYD
 26aO/SKDK5M5PVP0icfSq9KRU9iiZTBelOuZ+NJPeSIzD9uL5JxE4/nhZEA0ULRVpsCH1SSAen
 aJdayxV0t77+cbZMpeowCTZNCoUUwcAz7opP0TAtcgUx6eacHKAJlHaqjiXpspxCefrzmN2Y/W
 KaI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 17:57:05 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/6] nvmet: update error log page in nvmet_alloc_ctrl()
Date: Wed, 24 Feb 2021 17:56:38 -0800
Message-Id: <20210225015642.29288-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
References: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_205707_441780_8C44903A 
X-CRM114-Status: GOOD (  13.27  )
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

Instead of updating the error log page in the caller of the
nvmet_alloc_ctrt() update the error log page in the nvmet_alloc_ctrl().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c        | 2 ++
 drivers/nvme/target/fabrics-cmd.c | 6 +-----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e3b8ec535eb4..c4238c08e912 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1311,6 +1311,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		pr_warn("connect request for invalid subsystem %s!\n",
 			subsysnqn);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
+		req->error_loc = offsetof(struct nvme_common_command, dptr);
 		goto out;
 	}
 
@@ -1321,6 +1322,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(hostnqn);
 		up_read(&nvmet_config_sem);
 		status = NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR;
+		req->error_loc = offsetof(struct nvme_common_command, dptr);
 		goto out_put_subsystem;
 	}
 	up_read(&nvmet_config_sem);
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 42bd12b8bf00..d2289aa26645 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -190,12 +190,8 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 
 	status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
 				  le32_to_cpu(c->kato), &ctrl);
-	if (status) {
-		if (status == (NVME_SC_INVALID_FIELD | NVME_SC_DNR))
-			req->error_loc =
-				offsetof(struct nvme_common_command, opcode);
+	if (status)
 		goto out;
-	}
 
 	ctrl->pi_support = ctrl->port->pi_enable && ctrl->subsys->pi_support;
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
