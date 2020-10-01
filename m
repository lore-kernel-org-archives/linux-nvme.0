Return-Path: <SRS0=dhBa=DI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9496C4727E
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 18:54:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A65720872
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Oct 2020 18:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0+WBy0DR";
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="cUeKgBvd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A65720872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4A2OkmF/4LOfIGIr1V0cCETllw7vGjaqF/6ReV0Kdlc=; b=0+WBy0DR3KfrxsGMOVmc46c1Uc
	Q5Esr2PVqmDmcyetbqBrV7IRZcOt4l0qWOIAPJVmVb1Fpj3HmSuTxGalycrHk634fmlzzKwfgB2EA
	eDvh6qKWth2xgNI2zI95d++64a9qEQMNvUEoAEcMyrGHhxElgmUC9iBHK7qtFMlFa7XMjs+6J/SEG
	cDE5Hr1b957PaP2R495MBfmxiYYO4c0JEPlPH2kGeOM+tTy0korK/l+hiiUy0u+HY00nF3LcdSFw+
	FWjfLMmQNfoYKEHqNiy8xKxL8jt4cml/dEnEdicKYJBCqZGumrJljo8yEirvY9ti3yOXoF6KnZN8I
	Aymwso0A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kO3j0-0007Wm-2h; Thu, 01 Oct 2020 18:54:42 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kO3it-0007WG-Ui
 for linux-nvme@lists.infradead.org; Thu, 01 Oct 2020 18:54:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601579397; x=1633115397;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=uJ4VYIctnoQhkdWZSs3K/JkJVvGWRPwKhBrqTfHzI4Q=;
 b=cUeKgBvdwMLk360shUkVnzeZWhxEFJKfeQ55GzRdEm+jEG7d+pvijmmt
 Oeq89oKrsWcztO0iaii4alstNsrqBaFBCGXV8JKdNTkPF6Ge4zDdI7dKP
 lA9DTfHoei4AA1mwyijqc8lxb2AD03VZukfeL7KuBbra2S7r+hhKU9Tt/
 IAeADRmCsVzZ0kSAjqqrPV5X/IUCXXMMhhJqSVSH8c/dZUaopAY0Vy7Ob
 mwXG0M2M30l8KzP+n62lM8Y+F7lno+5KaC/I8WcorJFxsNOpBV+FUqb7Z
 kjtrp6SzPqqoWVv5Ix3SGvPlEhE1FvVdWEdDhnkwj2moeIQg2Fyih1QEl w==;
IronPort-SDR: VTUewO2gjd8OXBJ66QjvtPy0aJEHjBddOc1Aj1ghslzHuPLmZ4+ZYJ8f/QJkGhr4dyXcwyXhPW
 pvc/aJwfSyYY3+X9pHiiP+4h9Jn+vR/e2YirfnNfRIYEGn7JS/vjYABSyYLuM7pq2mJ92wUaMX
 Evu+TRH64+jLIrf5XqAP3Nidddyt8fsXgxupILBMq0CuKp2tOgOWoSm5w795qfLjjAMB9OFtV8
 S5sIPZy+ZbXxcNPAvpkr4+6mltSMln1fVHKTyknyd4SDxWXyOhDv4i4aZlhgwaRuAw0bs3xFjE
 K4o=
X-IronPort-AV: E=Sophos;i="5.77,324,1596470400"; d="scan'208";a="252242077"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2020 03:09:55 +0800
IronPort-SDR: wj0lH0ah4loqSB3mW2B4MCKgIfU46wcAuWLEE6xIteMrqy4LxD6SxpWUgN5LasatIFFrGCc4IY
 TgRIGN4mfLeQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2020 11:40:31 -0700
IronPort-SDR: OdEnoryBZURVQtE3XjI0RxYXpjUADZWInESv6wbkXpARpTvUxTO8ftyoUlAWl/5nSpX50xzwBZ
 z8ONw26AacEw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 01 Oct 2020 11:54:34 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 0/2] nvme-core: increamental cleanup
Date: Thu,  1 Oct 2020 11:54:30 -0700
Message-Id: <20201001185432.5464-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201001_145436_164546_026695F5 
X-CRM114-Status: UNSURE (   9.91  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This is an increamental cleanup which was discussed during review of
"refactor the nvme scanning and validation code " [1]. This fixes minor
nits in nvme_validate_ns() and nvme_set_queue_limits().

Regards,
Chaitanya

* Changes from V1 :-

1. Remove the use of ternery operator in the second patch.

[1] http://lists.infradead.org/pipermail/linux-nvme/2020-September/019886.html

Chaitanya Kulkarni (2):
  nvme-core: remove extra variable
  nvme-core: remove extra condition for vwc

 drivers/nvme/host/core.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
