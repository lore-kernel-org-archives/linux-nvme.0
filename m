Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901CEC32771
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 05:05:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62982206ED
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 05:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MjRma+29";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="egoxWxpH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62982206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=bS6QEasLVOyt8uPamOVCyN+OxlKBqzQcwR7/iTapijQ=; b=MjRma+29pnEf9X
	CgXbU8EYv9JDZpw+OhmfT4p+vlI5DQh6cztOCzMklOH23NUpqFRzEyvoXxWJv7ZSXPzaQEgo/MxFJ
	GSIxI3jv3J5c7FB9fd8XvWCrqzmXeXRb4WN3HtS9oAP8f7qcNZF86JTd1uzcjq/4So273ViImdr9X
	IYe/0l3NOPG5QbRiO3gYkIa4fMp/oIBeVVngqpa6yf+ffcGj6YxudtsdLEPRHxwWKNTnSUiXzhHWJ
	gricYr2XbRKUHZ0ud9Qfeo6F+M0saRAmjX7EYdrewTIJgJkNqAZi3loxQ+w3oDS2qjWg8gn33Qd8b
	vBxjNv9h9xm0gR7NH/tg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipQ0R-0005pu-PY; Thu, 09 Jan 2020 05:05:15 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipQ0C-0004Tx-2J
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 05:05:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1578546300; x=1610082300;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=HCjAywswqovhdsPys+Bvgm9UingQFPrVMVUk4cpO9ao=;
 b=egoxWxpHxG7GnuAcBdxUyaYIWdQjaOcm6Wqq3AnQlZe+fhgehcinOcdd
 GCpjirPnL2x1kIApdGcc01S8M+zDXOVm8kExRLlqEcQ7uaG5oyUS3+mlE
 qgYfbjWWbCbOgWn5VEbovonWlFvb4UiYiYQv4iN/196+m+7c0JLQ0TBwg
 aiDUef+566K2mhhECQNEgCkze1SJ/zxL8iZ2obatOrsvPXEkNgvdBCjVw
 P21u1dXHycU3hYn002wyxo89P/8AI1moZk8IAcuPGtO5K6gEjUXUr+JJo
 M5iB8uOWDx6pMpZfgFjiavKDhxoGLyxkyoaJ+bODwtZGzWNwMQn/w+hQm Q==;
IronPort-SDR: HZcC21pmCWHaM3E9vQfaZ73WEumVQLXXaadDjZChEM3ju+xiFt5yQ3VtEAMPC/vKRIZMuyYYMO
 gY1C2AyPyAf5f5YUNhB37yrxaukBZYy6v/mAN1D4h9lBUG9W08FTsG9MuvjBBwydWvt1Nqh0Me
 lC6wgEq74A16Nthi6EguDH+ppO0/zBz3teEcP9yUjYK90lrYhgbl/mW4i45jGrA8We4tQmGCFZ
 yaG/VQda0InMgcb8uvfVqbDwVcHs/7CySAV5u47su8N33xDPJiv+QLtMxYx31XPg69IiozC3ef
 tIc=
X-IronPort-AV: E=Sophos;i="5.69,412,1571673600"; d="scan'208";a="128585946"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2020 13:04:51 +0800
IronPort-SDR: dSlAbul/LWr37STuRRH4FUoK7p6HO9SB1nZ8RBZ8rvz7V8QFRKroNLTcVAneX65VqjKKiWxc4S
 uwRayBZxqRAOmv7YDCjGbmGUSHBgazPcB21QB3fjVe3pOO7x/+v9oWB+3I+C0j3iitEbYIkCNG
 co67RyeNCkCc2wfBuPRPc9Lc5suMNvZscmKnpIZLskkjYI6WMhSkjKND3fViQenN5fMxCzIOwg
 D7AKW/JAc7bYwpeSeECUnOlrzw2PPls8L4bigGptDz4T63Q1bdWAY+EL2PTMIS9JMLLoX1A6O1
 Y/3NSN4nRMdaL6Kb1ijspyqB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2020 20:58:37 -0800
IronPort-SDR: Z/uOLLKC+Cpv51VX5HUfM6+Cy4GVhFu/k/tRfo2cortgOfwKTcHd8r7+Y/11BfFKgFXhejQ4pj
 WP6hjq+ArDltEqcVYUH30sjH8D+0wLEa9IIdKl9l5NWE/xskNb4Lw6ovC0drr+I2QMnUSw+Y1p
 7JA1+uGL7KXzFgtcAD2hWIsf79rZqoGIAjZzJJyRQqJaPmSxd+xAclMmXOmgKI68zMiqwYQuIn
 cuwW94chP8lXMtUI4nC82NONUlm2L0/l9+U/uNC4Q+hH5yzV/W9B/r5xuw/ujTk/tn1IUEJyXa
 aFY=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Jan 2020 21:04:50 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH RESEND 0/2] nvmetcli: make model and ctrl-id configurable
Date: Wed,  8 Jan 2020 21:04:46 -0800
Message-Id: <20200109050448.5758-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_210500_143832_B7279038 
X-CRM114-Status: UNSURE (   6.91  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi,

This patch series allows users to set the subsys model and ctrl-id
fields.

Chaitanya Kulkarni (2):
  nvmetcli: allow setting of the cntlid[min|max]
  nvmetcli: allow setting of the subsystem model

 nvmetcli | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

-- 
2.22.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
