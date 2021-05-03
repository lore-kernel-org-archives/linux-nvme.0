Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91646C43460
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 15:23:55 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3F46611CE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 15:23:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3F46611CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BL281YmfQ5H2W6GYK+gMt3NRZvRNYaIosNe0ti4U0w4=; b=df24ie7BjMeulj/qKlTN1XfISA
	qKTPs7AuEPyLqWqkaIICscXRVQ15W9vblniMj4befR7InsOt+eZ9KFOhGDbdnbJlrYoGmZkwO5PKb
	4JNvieXgvvI17IRbQOsVGtghbwzUxZR1DOI6hvgTYN2FxoQrhHXbl/urRtyH3FBXT71VtaBLnk58u
	VSoBWoB0RDYkhi4r1L96toMif4nlOeCo7wIfT4IWlMUlgWMh4F9dStEfUFn6fznBe3Zr3037rSMSJ
	jz2An4EQH9rmznlHFqAzwB8Xi2axpx0OFvEplu9B860ieHD9j9PHCFqdhMLx8SbLgmgSBnSANTFC1
	ObKj2TfQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldaQ3-00EDas-Hz; Mon, 03 May 2021 15:23:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldaQ1-00EDaN-Fs
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 15:23:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=PDKnjb7HMvMH/iSdygvi9wKhcuCl0hGGxj76EWBb86w=; b=X8yyuXSMULnjJZaYW0dWbjXGCq
 D/3urJBDh0bTIQY5PWSfOoa0w5g8SD5y2ftkm+LAIz9m8hZJd5yi9cUOcacBYCM/dN4j2CMXX5RFC
 Qd604OiQk9Dw7dzJDXgZtBTEpvi/DPU8V5gpsm/CgNweG2ZBPJnCGq+JN5QwoDWddTcbG+PxjkY/z
 G19+Z4ZTi2AUgmeyWZ8jA8gghT9W1wd7RNUmgwgKH2+Zt07n9JljRp9pT+tpwVZSJQEN1TSaAk+os
 vJxGpjGh6Nbj1/HT2PxhUiTN0Rpv5tTaqfmQeIcrAYXmP6Zi7QO1GTmvPbD0tecw9ly797GiY+bQy
 bDul/J1g==;
Received: from mail-mw2nam10olkn2078.outbound.protection.outlook.com
 ([40.92.42.78] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldaPv-003Abw-Iw
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 15:23:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMp2Ll6BApAoljbeIyt5J9OH371d8Ixl7XteOVJFg3K93bSALZmlUxVziYmWHCUgmP8HDJUv0w0SU0faQS5p8s+qQBVB0Ym74V3kcTslO1w5mmybybQ4BgCsrmA17dz6/PQwhqkJKqFCivHTMgFk6faeHeawCFrCzU7bgI2VfGD5IvlOcvexyyOmIh61Jx9ctElinEezTjXSYnQ+aQ3ZJrd7YPGZPbMLq+kOEot9NZdGwB9n4EQPAq8p07bzTkCCPVRRKVZaYhl1l4tk2FiQbHZCDID70RXNcT2C/x/hBBsARxd6nsp2OLdWgWsVEoDWVRMqCP1XlFShdFOhutyXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDKnjb7HMvMH/iSdygvi9wKhcuCl0hGGxj76EWBb86w=;
 b=UUvy7JHl1Ba7PTMJE0Rl3iP9jaA0z29+5IRWXe3DslZzANh5HxZE68SmZHU/PQ5+sZL3mbTaqTkBUFalDi5CT9N/XMcwyH1byxpQg2BcO9SZY8bVgr5/bNG6CprWrzGRkMcwTf8zPXrZYiLEvthLLpoyvSMQvdktzsimAGXrlQ/Ax/WiCsSCao1IAAK+CiYx4GcO3nGSdUxFpsKSW03mwJXpCubU/qIB0/fAYb9qpWnNUO/S6VafbFxnDhN+m8cYnwuQlCctAAjgXxCsX5FtBCFtnFOB1j5JigFIklR3mKl0ORrLstxxR633F1iJXvDAX4Fko64yuQSZKR2zt0+Nzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDKnjb7HMvMH/iSdygvi9wKhcuCl0hGGxj76EWBb86w=;
 b=Mec5L79jc4LkGx7QypUBG0D08OR19tuLPboAD95EWhByYCn7/WauyBC3mZOMI2mO8u81rjoD5ojOeos7hB8j+MJPVj5FRgA9/fchOWqqdEyUMWgQAlPOKusekvNloHxlXszKA2nlpSmCvosks5C1h5/26FWxqVrjBC7x/bgt6nITjrYw8I9CWISxNyEkcnCzvZxAFVW4Zrz18W2rNrjCTKphmWwXDd7hxK9idP5hbYh1kPN4SAX1u8MNRPlLwkCaTFJPRl5o7s5Za0i0L2/w2YOBYPhliAKFvHfwokZnm0DwwBcJ969UWrJUcgFHIWyr/JuiJSAJii2eT5Ww+anXnA==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by BL3PR13MB5091.namprd13.prod.outlook.com (2603:10b6:208:33e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.17; Mon, 3 May
 2021 15:23:20 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::558e:d92d:d944:473b]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::558e:d92d:d944:473b%5]) with mapi id 15.20.4108.024; Mon, 3 May 2021
 15:23:20 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH 0/1] nvme-tcp: Add option to set the physical interface to be
 used when connecting over TCP sockets.
Date: Mon,  3 May 2021 11:23:02 -0400
Message-ID: <BL0PR13MB42918D11A0A3956FA8BC549E9C5B9@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
X-TMN: [DUu2xICAcXOlwCqGWpSt91G75CXiZ9uH]
X-ClientProxiedBy: MN2PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:c0::35) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20210503152303.23166-1-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (174.19.123.177) by
 MN2PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:c0::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.10 via Frontend Transport; Mon, 3 May 2021 15:23:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ec41dde-e1eb-49a1-1a72-08d90e476209
X-MS-TrafficTypeDiagnostic: BL3PR13MB5091:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLb//b0xFBIQoQ/Z5FgVKSuXDtaGbFdGepS4Gd3j5+GubsKuYxcD8MKA7yOgV2/LoPIf63sF4O6664X5cCKu7jlzX8F6vVmWlE2/HabDFOJlq5vbw8bOh/QCLXcb7OXAnY1ul4p/ocK35jLB6w8ligX8X71BFx8mPusbSQqrsgFN1JKMf101TFbeFFs+2N65Y97EUffXIS65T9zc1Z/WjqOEr/Lf3SEq95HNA+/LYeC4zxIGn88OHXgPy8RnUSYr1U/y3rV1jdqDqazqvoj9ZqYYbpUYTOvNKISU3wfzmfI+m3P3jzWvA+yAE5T1X8tEdXdyJ3b1HwcSFSQPTIVsaeBT57T0YNg1b3SAYBzshuql1CjLNsExCQyRZgaI2DJXzWv6PxwRfVnKW5PllvxA0A==
X-MS-Exchange-AntiSpam-MessageData: bKQQdq4PeMgzorEfOAQkGbzd91IJgXcGpYu+PRz7CP1CVrV9/hgWEAbKhoWyVNa6HdWItsVDxd51DQ+2XJ68QQ5nEUlaxsRktXWH9C2xVQePqUqmgFwO874AKKgtPeoH+cyyQRAF++pY38baYL/MDg==
X-OriginatorOrg: sct-15-20-3174-8-msonline-outlook-32ef5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec41dde-e1eb-49a1-1a72-08d90e476209
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 15:23:20.9061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5091
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_082327_734603_0FF83468 
X-CRM114-Status: GOOD (  10.97  )
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
specific IP interface instead of letting Linux select the interface
based on the routing tables. This patch adds the option 'host-triface'
to allow specifying the interface to use. Note that corresponding
changes to the nvme-cli utility will follow.

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
