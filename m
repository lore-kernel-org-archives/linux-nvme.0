Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA0EC433E1
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 02:37:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5FBC20672
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 02:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WsE7xDZV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XVBtc6MB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FBC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zxyYZFoCfHXCrGv87m+aMNAOd5PGTDuHnJW1ieC3bO8=; b=WsE7xDZV/jJybG8hbbdQ3NXwt
	5QdWZIjF01/Tz7SqENxzGm9+gmTBcyamd/o/3fvxrU8o2wW4rC8iX9wqMT8CHtrjYS7qOYUdAXY7q
	u+ZxaCBN+yygGNHPR16ezrgPIAVw2vhgSltXeNg9iSVquohgJSnHLpQOJW/xlu8nEdHzlMR+fJbg+
	g2lZPYOugKEcqWiOtNiNMQwF1Y2bbKd4EeX226BSh6Zy7DltZxAqPEbVluLEBAggoGQ4IV0w1lbcN
	awGXvEAKCurhor/Ztwxz1HM7DLyOJ+pphehu31lnMoUzSErakBXrJ/3esDU41eYKopvyA5zfdkuby
	ovbDpE/2A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0bxo-0006D0-Az; Wed, 29 Jul 2020 02:37:04 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0bxl-0006BO-92
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 02:37:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1595990221; x=1627526221;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=yAc8o0F2BYLwYc82y2fnWMlWNIs9nXaoL2QTdCxSdpk=;
 b=XVBtc6MBs57FeCH0zpy6ekaguf3A7MoJiJEhzUH6hafudp8qPPycfn+7
 GdrOgy6j7heMfXg2QX3dq7nSN62esV+hqwi7fQlRhA5F/VL2Xp1fllwV+
 6etaalaHBV308fTeskjWDm8bmfQN9C4sfl7H7Zhx62f4oLtMcUvJhogvX
 zKl+6CYiuCJAHnnmdHzGIUsSYtkYK2Q7Sr4J+xRmbRvaECzo9e5nXC+UK
 H43eid4oXBFRvoCxX2vuqnZ3kxhUSAbs+AGMVrtw4/F7tucsTLR9+Zr16
 TsU5NpcbllbQCtRLAtWat2jmDjwu0FP+38O85PY9JYT+w6TNQ7ypNkxqO Q==;
IronPort-SDR: Ei/zi2SV0bwS9wjjfdGmve5WvjQhlKuWmxt3mwaxLDdgSk8YqAkr87f8xNbOhLB+TmPKUSu82q
 Rfypdw6OKd1odzkVl1i1T6GxS03/gsyaPQWxfli0tKOqtbmMp0n+b/1k+c5R4WTZLOJy7UoqdQ
 T3GQAigLxf51EiCL6P2GEI56qRhFcHKcL8r8oXew4j7sMwlESfpNLZ4I1Fc2plx1rvKIscmDHN
 0W9eInHgku8Vdvrfy+2a6Gi3W/CISpXn65TwfjM0NRi2m0GrkKyQ2V2SSKj8e1Pf4hFL3WOesL
 UOA=
X-IronPort-AV: E=Sophos;i="5.75,408,1589212800"; d="scan'208";a="143706167"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2020 10:36:55 +0800
IronPort-SDR: LROUZ8v2vPEcEs30wAwGEoiHF9CPhL5jUDyx1rNCQaDCig0YvQPvNej7dXlH6QvZVMWXz5ZeF7
 VMTSMuiJQJCJaLSIwO6aUAJFt+WFveVx4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2020 19:25:04 -0700
IronPort-SDR: RzS4LhnYW17u0JCXK5XqzUnBdbpgBGG4x8L5wQPiM980IOgFPVp7Fpslzkyq2Fq1xAZhrXTadu
 HhNEjrt5aP7g==
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 28 Jul 2020 19:36:55 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme-loop: set ctrl state connecting after init
Date: Tue, 28 Jul 2020 19:36:47 -0700
Message-Id: <20200729023648.38677-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200729023648.38677-1-chaitanya.kulkarni@wdc.com>
References: <20200729023648.38677-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_223701_481842_9D8C4CCF 
X-CRM114-Status: GOOD (  13.82  )
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

When creating a loop controller (ctrl) in nvme_loop_create_ctrl() ->
nvme_init_ctrl() we set the ctrl state to NVME_CTRL_NEW.

Prior to [1] NVME_CTRL_NEW state was allowed in nvmf_check_ready() for
fabrics command type connect. Now, this fails in the following code path
for fabrics connect command when creating admin queue :-

nvme_loop_create_ctrl()
 nvme_loo_configure_admin_queue()
  nvmf_connect_admin_queue()
   __nvme_submit_sync_cmd()
    blk_execute_rq()
      nvme_loop_queue_rq()
	nvmf_check_ready()

# echo  "transport=loop,nqn=fs" > /dev/nvme-fabrics
[ 6047.741327] nvmet: adding nsid 1 to subsystem fs
[ 6048.756430] nvme nvme1: Connect command failed, error wo/DNR bit: 880

We need to set the ctrl state to NVME_CTRL_CONNECTING after :-
nvme_loop_create_ctrl()
 nvme_init_ctrl()
so that the above mentioned check for nvmf_check_ready() will return
true.

This patch sets the ctrl state to connecting after we init the ctrl in
nvme_loop_create_ctrl()
 nvme_init_ctrl() .

[1] commit aa63fa6776a7 ("nvme-fabrics: allow to queue requests for live queues")

Fixes: aa63fa6776a7 ("nvme-fabrics: allow to queue requests for live queues")
Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/loop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f2c80a51985f..14d820c9a276 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -583,6 +583,9 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	if (ret)
 		goto out_put_ctrl;
 
+	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
+	WARN_ON_ONCE(!changed);
+
 	ret = -ENOMEM;
 
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
-- 
2.26.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
