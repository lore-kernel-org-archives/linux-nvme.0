Return-Path: <SRS0=ia7R=ZO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8B1C432C0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 07:42:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F43E20708
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 07:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hoVM3oFX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oFiBr7l3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F43E20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=5XXpNCRMUEg1r+XzUQPle3glZgBZRHNvsZgrKVok2BI=; b=hoVM3oFXkckL/j
	zxqGifDO89oyPe0ktEO5t8dXjWmsieVYip9xU9RzlyqqjFjEz7oK88aWguRGWg9/2vwFi/o0B/tR3
	XVsk825KeLAND+G3MjFhtza4mCxdr9ivl/aWIzUx298hloW+SYzZPMC0fcdtd/jxEC0toqEptDUCg
	DEZq/Jk32dTTTW9quHMwdRrTa1T1gXSgb1JjQof+vnosBd4V30RQecs74sowgqUDsm782mjMfsSaa
	raoDGxlxWELMSLv8Ja0Ee3YCCngBWiUDNFGd9t/O4v7WXnZECg1G09QNyGj8TmHDSZziHdQ3f0fcl
	3EV5zFkliL4MAsFOw35Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iY3Zr-0003NL-05; Fri, 22 Nov 2019 07:42:03 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iY3Zn-0003ML-7W
 for linux-nvme@lists.infradead.org; Fri, 22 Nov 2019 07:42:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1574408519; x=1605944519;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=d/wz6Ixvjyqp9GLMG9/w9j8zMYs2hkxi4tVz9jZgr38=;
 b=oFiBr7l3uAwJMeUEHEGpWxIkVUKjI712Bj4ZYVel9AQOlIzPPAJqbUI7
 8oST81Hf0N88X0xrxSbneHO50ld/i5JgYjYVOVvVNKNhvHrvf7EsQfoYK
 F66bD16gTo3oFakYoW9Xu0AocngMboSlmPIKavYPynCD0sThk1Go8yipV
 NTe2MaDyoSOJt44qL70e6tVuxBaMeyNM37eqlfW89dC4lpi/jqQL72+A+
 D/zovnjzreb3W1A604C2LCZ92IRcYPywLKg9fRouD6zLU2Vir7+WB0a7o
 ziYq9RHQyHEyqKnXQ0sbYFi/JYsC73JVN1TEKvr8TbY+EgKgoRs1kBO8i Q==;
IronPort-SDR: 6YJ3xC3d1YjcjwGOzFL9+Zuv4WddH1bIdsKuJIJozY00buYEPuWyxMTi7pKieYrfPeh9Ykxy6A
 9SkXwnGkgH+52h5EWmIo0lzAXqWL215AhM0f3ayw2BN3tND6b1oXyjMFFYUvBjZEKK8Kq/GPOW
 EAJQARlL1fG1LzlZHBiExi/8cmjtWbhE/sBE+/VrRBrOG+EoxpDpE8uTC93U3aYKQkT57FqTam
 gN8q3tFzpHOTY9jZ0ajRi0vYiioXrQjUDtt3wcGuJJSKumnuwcZdv5G0HR5VUR9GcJlpRUfakw
 i4I=
X-IronPort-AV: E=Sophos;i="5.69,229,1571673600"; d="scan'208";a="231139190"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2019 15:41:57 +0800
IronPort-SDR: SCl97tQ4EeNDEMSsqSRrbPz9OSbLtrGKEweMqa6/yUBuTlziSWNqJDnVWuWG9PUFUvo6JKnyrd
 ondLnX2UxcW5jfLXTchNQATSJRzMmuMspv7xEBAtDtygB3Kgw5xrY1kcE+5t/eow7UxLpK05L9
 pk/SFont6KnLYGPBVCVl7Rrs8OW5GMRxeN6bOyns1WIlLULCL9yGu16STlUHC8/+NW3vKQmDIn
 qOvYKiDl29FnVG1BCzPvYZNV7xSMAMHMfE7hui8CdM01nSuxyatwlS2udGXdb3NUeQ1eJRmpef
 a4xyFfo06HnVsyF5le7wyl/j
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2019 23:36:43 -0800
IronPort-SDR: dx4tqg/4jK7Dtum7cCvCqXqo7NxXP5avxY3TdOeVwEnlIx63BV0e2rvJGWxG6cxUbZ1Rk0Wzwv
 zonS1athMiFS1XLyi4OuiXXshRSM+PztHdWtnhRFHjoVLQE8J8kZYgEiNeKJTph03zw2WGZ6Os
 SFubFcqqOwies8Bq/FEvrHHwZl27Jsdf9l1LuZoISa2JykcTsX0wlFYbInjw3u9yXtW/JBBMEp
 1/EJUS5ohZngXzxvy8xInMUZ7DiJcrphFFWL8ZhEeDoQvWTmcQVkySEBqnG+wfxoO5pbseZUIH
 BcU=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 21 Nov 2019 23:41:57 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 0/2] nvmet: make model and ctrl-id configurable
Date: Thu, 21 Nov 2019 23:41:52 -0800
Message-Id: <20191122074154.12159-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191121_234159_300792_FFA1B7C4 
X-CRM114-Status: UNSURE (   7.37  )
X-CRM114-Notice: Please train this message.
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

Hi,

This is a small patch series which allows user to configure the
model and the controller ID.

The changelog is present in the respective patches.

The patch-series for the nvmetcli with new attribute support
will follow this one shortly.

Regards,
Chaitanya

Chaitanya Kulkarni (1):
  nvmet: make ctrl-id configurable

Mark Ruijter (1):
  nvmet: make ctrl model configurable

 drivers/nvme/target/admin-cmd.c |  12 +++-
 drivers/nvme/target/configfs.c  | 115 ++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  10 ++-
 drivers/nvme/target/nvmet.h     |   6 ++
 4 files changed, 139 insertions(+), 4 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
