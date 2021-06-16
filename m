Return-Path: <SRS0=zgHd=LK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9306C48BE5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 22:16:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6382F613BD
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Jun 2021 22:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6382F613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ze7scQn39h7v+5R/XYXwjkRDcoVzeVb27Y2MrVvm02c=; b=HPDnqfbipMwFGk
	76eDto3KLdayGYaUhMXINuVYHCz3flDLTaeQgDMkdtI7ivpJTxxPe5cxRI4vd3LyuDK/tzLM9RDqC
	A5gb90eJdXtbZp8hfiExt1Gbm/m8BGM8ZUBv+Km4rkQwOSFUnwKNV6rQhZOPZHTL8+0qM0+wUk1l9
	67FCkUiKtzr6YqvHsbMXk3h1e45DWDV8EvdeisiXOfiBNHaytTQAjg1ntFuv8kOD6u5t9xXTb4RRO
	U+2SstMnYrl9CZsgvmI8LseOJstax2lcIgudLWfcGC/l8+cGcXKOf6PmhNW/dRdqTXMJqzpFV6F5V
	MMz3fCFHzgM0HdGg49hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltdpc-007qVb-1H; Wed, 16 Jun 2021 22:16:20 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltdpK-007qU5-HV
 for linux-nvme@lists.infradead.org; Wed, 16 Jun 2021 22:16:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1623881762; x=1655417762;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=EBSiDZOoQF+a5DGEHzkIwjz/cWeg+hMa0V2nwzGC+yo=;
 b=ppA5v6z9u/G5duDl7U06eqjqZsOgg49D3fh36aao0TdAdRje723CDpPh
 USM7RO76xXAcWVMQB+veW3jaD+H8njsegq3XB/sbRUnMMsf3X6p4fUvmK
 NUBUmRzWu3XO/8euM+IjQuJvw5tFolJmIFOSOIzxIqMOnMabxI9xGx20F
 5ENTf8AnTfaMQ+0XxIp3pUscoHaap7Hsl64W4YBcWLVyCG9bfdXwhG13J
 PnaFoaxfqnXNx438QW0zprvNWz4U4y+lvEF4N148XXjC0ulJn/0iU7EqF
 aog/aoBMgAMEGGHUp2DaakrNYWL9a0exI3rBIw3TA24bqCYSgH627B90T g==;
IronPort-SDR: XE6U7ie6IOQ/PRHZemC22jEWs3ibZwjUviimuoLdzVwd9tuL4JwCJz5+MHv/RxZO2a2GXWc80v
 dYecikNC+jvEXQpURw7K5fxrzOs1Ckkw6FDRL0DtdH/j2RYTVManS+Q9sw3Tn0hDpwclrTeI/O
 SviLrs5I0W6aolsDtt2EyzkuBdtFIrMUYqn4tGur6vIVH+SN9aweOJkLrSALuiYvv407ltiEUM
 ikHBMxvr1b8T1NJCGFUTxjHf1Ya9tmqmCpvX+9El0tPyu58r4IxER00Bq4kX0TARQEvLClg/+L
 TvQ=
X-IronPort-AV: E=Sophos;i="5.83,278,1616428800"; d="scan'208";a="172703052"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Jun 2021 06:16:00 +0800
IronPort-SDR: jsy/mEEbR9eIOTS6wqSkOtpjyaGK5QYEAUpyGwDRtTp2J0bljzFbTU9m7tUM9fmHlfRjq/DwQT
 qFbvs/I/np6zGSc9yOE9yz4nSNbB17358PEc74Ay4SBhBrsQuqz9EYD6UeXiFmpFBlnKYiszhS
 Gs0lsglKgQKTfnikH3zYJLS5dnGBsL/njUzp4x//Q+M+RvwG7gL2WX6Jhl849oLyEUu0kMFnXB
 Ki1WbgMgGcWNuBnNpG+8k2Ei/tOBHogRXS8mV5mV/R7can2+GNzaI/obU6ptnyi5mlou+hCypa
 Mb6g0hHQg6Jqw9hyR4Rn7s/B
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2021 14:53:27 -0700
IronPort-SDR: BwtSJ70DcZV9WgVPMGJofymp8roI0LoqhGgRlpGP+omWKaF2iwvtcqOjvjzVBRyOjsdJt0Dyj7
 NnjeBozD36zsixyUdVUedgBVF88LQLN4bVDJLxsjjU6qdGx9rL56/nz4Q4Spja3XDkLgO6yPld
 mAPbM0nym+o6ELiciGt6BnaOn7oiBDPOo+UkP0H6PBNu3plr8mi4D+Lw2IHBJkSKcWPhAZXTyg
 TBdfh9L5rtYwlD/kXWUFXKcPPVgVls+9ZsxkGA6XoIWAlLoQndLWI6XqQmL97HlJFTb5AX+kHs
 iXo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 16 Jun 2021 15:16:00 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 0/3] nvme: remove struct zeroout memset calls
Date: Wed, 16 Jun 2021 15:15:50 -0700
Message-Id: <20210616221553.55914-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210616_151603_533939_E1B40A04 
X-CRM114-Status: UNSURE (   8.61  )
X-CRM114-Notice: Please train this message.
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

Hi,

Initialize structure so we can remove the zerout memset calls.

-ck

Chaitanya Kulkarni (3):
  nvmet: remove zeroout memset call for struct
  nvme: remove zeroout memset call for struct
  nvme-pci: remove zeroout memset call for struct

 drivers/nvme/host/core.c   | 19 ++++++-------------
 drivers/nvme/host/pci.c    | 24 ++++++++----------------
 drivers/nvme/target/rdma.c |  3 +--
 3 files changed, 15 insertions(+), 31 deletions(-)

-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
