Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B644C433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 19:30:04 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B88DC6113D
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 19:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B88DC6113D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=A7sjifEYoYuAh9UFZBggS1C1f+1+SuasID4+vlFS/90=; b=DQnidHtWGZnNzcXTKrnWCg46Yq
	HRribKU3ihDC/u+SHIu+UlH/QZIEJwRmH9MKH+WcBhuVNSRXwIQdtTx6d7msGDjHJMTFiy7BDIezS
	pJ6P6GEu/d4T92PK5cvNQ3tLTc3Eaka3q4A51m6TjM540xNbr6orWPtyWZF1xzWGrgZH75mXC+vy4
	KKuEwkfy8aWCsyHHqNvC3G6XjxYcZDN249P2mg+f5uwjFK8PCTHOKBeUOVkcCEOTCHiF7Vznshux3
	cqwf8IDvKan3zmIuRFRUF8HF2w7QjioABAa7mOc5ExuGb4n/IZb/pYTM5Tt6AjPIhQGW/+8ukLPXt
	IGBedu2Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lX7gI-00H8Pb-Mu; Thu, 15 Apr 2021 19:29:39 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX7gC-00H8Ow-FW
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 19:29:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=e1z/Kxxrt1zrptPqDsWnD38S7AfHW54CjbEQWcjUdW4=; b=RGiM78SxuilQ/5z5L3sv1IVbpy
 jdcgLrpzUeIj3aTtiXgvk8IVOPQzB4A+FgfMVQbu+3RgO+m30Zh96LKqN30PXA/bLXJQolUlFolq8
 QEE8LXT3hm8eS8GOTpqQlSDKHLZQXGQ6aywXQYYvKWR2hsUwiqvdO2TQNrsOpFKmdKc5ZX8YQ+1eP
 EjX/vJkyX95M2Ygs7fxVJ/h0WtwnxQgQxKCEJ7G8urW/9obTxeF7eBJ28JFnktX7IX4+XOjxivCTq
 03JgFyJk+qc9hkRDdbO/Ga+Pt/vgljeKDZK5x+oCK2vinhuw9HEuGWxmtMeKKki+tIgwFJvzZkwgb
 89VYqljw==;
Received: from mail-dm6nam11olkn2030.outbound.protection.outlook.com
 ([40.92.19.30] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX7g9-008qWB-Mb
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 19:29:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0xiEG+3zEgUf3GKlyNjS81Sdd0i8bvlOxcf87YNR0rv932aiCgFjd5A/O0XvAM6fBXZjgOFbUFQzME6J3QObH3wvUrIhiFFXxjM1FZT+TSc96jj058IJEmdCtZgTichPoix2OlrjBBxxow74Xpt7gaeVgT3fyvc+CHiip8IObyH9rOHA4iTYg2rnXico6TctnWjRpoIWK8SW4ivVcI8ILS3FQEVB5unYNw1GAZwsfMKT0g2vyh+v2VRg4pJszeUOk2iOJBmwSpMJ2d74wtzSXMkS5hIlqce8lxRU+4cedMEozakMyLcjzG8OK6Ulq/YyETZggcj64AGBJklVQDf0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1z/Kxxrt1zrptPqDsWnD38S7AfHW54CjbEQWcjUdW4=;
 b=Nmzi6PNgBuL0g63UkKKrYnBwkbMApRA1N8yElLLbyfWoFak6+2hp+7kmpc6TobRPE8bwA64cD8DwDBheq4W13l4DtpT63qDUw8OIUgzctjfMnExtio7aUOHk/H6r+eTq4rmXFXVT3enX53rOoePDmAU0hzbs6x9HVbVMKOJYLdzRGko/+GnUlflZprXdzPwXM0FZwdeV2/QOcnPiucevX4q3YzxEY6LfvGVk+c/CW7j96XGtEeJDMVmj2YV5pIF8AV1Jr6QTSR8aLQx4du2gD+irRZSpy2IV9iRmrGkOTYfz/KuTFovqeRk2x3+nJa246uTj6xixKm26TmcmBH3NuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1z/Kxxrt1zrptPqDsWnD38S7AfHW54CjbEQWcjUdW4=;
 b=AuoagPfrSSrgM8VOyKE78k3MTn9mps6rUObcQEN3XusbpKGh5zXlVyq4fcNgUT3rPWIcG8/VnW0PsLJg33id2ldReyNZQYoiSLHkehvEltNtUYIlAFdVaHn+7rZhveogF97gSN1tLwznolGeDhZczEb4OqBVhGN+1vQoq6yptvXtYy/AgVvUM5bMOqjHjVuJohFaZyKywIRIuWJftL/hViLZXBZaQ0z6UJiWu5IhtE7DFEEgvJG1xPIYEgYTmW305Ius7x+E3GmGO2URRwNLh0ViszcYBxfdmkvW73omFOvTWm66lSuEmxM8sRl3wqtfUlgATX5kLeOskFhB0fFNjw==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB3869.namprd13.prod.outlook.com (2603:10b6:208:1e0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6; Thu, 15 Apr
 2021 19:29:27 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::ad8e:90ea:1f15:2aeb]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::ad8e:90ea:1f15:2aeb%6]) with mapi id 15.20.4042.016; Thu, 15 Apr 2021
 19:29:27 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH 0/1] Add Host Transport Interface option (host-triface)
Date: Thu, 15 Apr 2021 15:28:47 -0400
Message-ID: <BL0PR13MB429178ADAA0C3C8AA2AA05379C4D9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
X-TMN: [J8a1OI5uQX85j6T6uwWECEoa6KP1bgY1]
X-ClientProxiedBy: MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36)
 To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20210415192848.962891-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (174.19.123.177) by
 MN2PR01CA0023.prod.exchangelabs.com (2603:10b6:208:10c::36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Thu, 15 Apr 2021 19:29:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8e72230-8aae-4716-628a-08d90044c86d
X-MS-TrafficTypeDiagnostic: MN2PR13MB3869:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: THJIOsQa9PS39RpKkvU42+I0aGHuMgDKny3/iZ0OxKXiywRg9eAikSqbCjLS+i+2h9M2qnPun44CbA0Km12KeRA0q4vKnDcr8sVe8Ngb9NLmw786BSZb67Z7dZKHEmUkyKbSlUlfldqhB36rippicmTYtZ64XZF0uXW6IlG+gij20eAiACGhn7JD3fFDT8n1Kw0lfUauA6kGNwM+Lktv0oqzpECB1bTMb3wbRBL4ZvdHO3kjR+TDZ6v8TeBlZiH39YdCza4f95TowmPTL97Y1/MUKgY8It+6q+D6M3W+klivozVFTmJNQL+68OgOAFomvSa4ySFGWCIbN9VAG5rg/DZyMACNuT/WCJJKaSWf9caLpXIIJbsem271OuKzjrAffy0MZdkqilrET/X4TMLcyg==
X-MS-Exchange-AntiSpam-MessageData: oDE/aPUAQgVPYrgXMf5m8Df2A5+mbh7zF+1YB8tqzPs0fAFZOYiCY2xIQuhCX2ICENcSrv4lGousfSpH9ByX/wNPDC+Bj2XDyfg0hdsIhvFSTtKf6PUd7dd9PPoQ/XPRoFD7vaHsjohfyBaZmValSA==
X-OriginatorOrg: sct-15-20-3174-8-msonline-outlook-32ef5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e72230-8aae-4716-628a-08d90044c86d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 19:29:27.5150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3869
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_122929_765485_0A260154 
X-CRM114-Status: UNSURE (   9.91  )
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

From: Martin Belanger <martin.belanger@dell.com>

In our application, we need a way to force TCP connections to go out a
specific interface instead of letting Linux select the interface based
on the routing tables. This patch adds the option 'host-triface' to allow
specifying the interface to use. Note that corresponding changes to the
nvme-cli utility will follow.

Martin Belanger (1):
  Add 'Transport Interface' (triface) option. This can be used to
    specify the IP interface to use for the connection. The driver uses
    that to set SO_BINDTODEVICE on the socket before connecting.

 drivers/nvme/host/core.c    |  5 +++++
 drivers/nvme/host/fabrics.c | 14 +++++++++++++
 drivers/nvme/host/fabrics.h |  6 +++++-
 drivers/nvme/host/tcp.c     | 41 ++++++++++++++++++++++++++++++++++---
 4 files changed, 62 insertions(+), 4 deletions(-)

--
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
