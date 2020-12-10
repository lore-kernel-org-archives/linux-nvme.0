Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D23CC4361B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 17:16:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F12723D56
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 17:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F12723D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sZUz187TXTb5G/PyxwWtSV3Q60nbCDTe/jZFe9HQt68=; b=3ejXWjSy+FqcepmjvTNd46JEQ
	qLxghj0rT2Hnpr9scOxGMjyUbMt6SFPo+g62qC+GeZQKL5QbJTcB2r/FNVQT6/QSfIaiKvYZkjByx
	Unl97mkU6xv4tYG8+GAOgR8HhfMqb1t0Ub1bTiqavfDRHSHgsZWunBfovi3dK0q7TvsNVkGV0SZqJ
	Rh+3Y5pBwNiNol4BPo44Ml1Tb6Hg0sHKez7TiTzlsB9jCvR/PGcBe0C9aeDGAiKQ2jON9P9wMWuBj
	n4y7IVf2stK8bUd69uITU1v2W4koLwS4CCLu+TCPE4xlaZ8R5n0DxaWMolt4EVU9V/GYwFaNSQAnN
	x/tU3HDRA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knPYK-0007Us-Od; Thu, 10 Dec 2020 17:16:28 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knPYH-0007U8-0b
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 17:16:26 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0BAHAw9Z016752; Thu, 10 Dec 2020 09:15:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0220;
 bh=CuiPH2Cz033m/atfVMgfZDTo8M88EX0cJmseDeFxPz4=;
 b=Uu1jOHmZoB0LtKTiG8vznqgueJadaSCTlZBSVrE9SrbmCU8BO/Rofv1mYdtM0YvZvbQ1
 YO1Y+QXOZJBs3A8wQ6lLYxXlqh3Rh1H++b8wxkj/OCrwrr7w8vBSQKhvfcvg5AwDK4Kj
 EoWF52bIhQZs5eQjhwsvysbEU+RutnORPB4Yf3ND1erei1qjwsIxEbbtvRmkzZjYnZIh
 hTnKqVMlqV18K6zZBJMMpIK2EnyVMB//k+7bXDVo2JVur6pV8WPAbYiF3SPuhqigIiCK
 GMIItDXjSEr04swo+1UHYij402VEe1ctr4POURnPZenibv59Nu4uJPP4AtboHSe8qwyt qg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
 by mx0a-0016f401.pphosted.com with ESMTP id 35bhfm9b3e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 10 Dec 2020 09:15:33 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Dec
 2020 09:15:32 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 10 Dec
 2020 09:15:32 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 10 Dec 2020 09:15:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fs2RbLM6kjyDYMLb3kbyehZokD+qmEB4VxVjDWeYOG2Hkd0GVJKZqHgugjKRJAhLY4KUuyq8ZmyrsNLEBpdqn8KpmAqp5djZiri6RacCySdWUWOzVvq9Os1vb2OTUzrBgg2FdKFwRIEJJSkEllkUh6o/TLTEpg8yva286FPrg/xGC43jlhEbmf5pzwt2u+TnAnog3yOkNRY994PN/G2mU8ULZzXLxFvai5ku0yAOGerBa7lRu+VUAPxv9aV8lOCHrSAD2P7tCK9rgYmJ2aK2Ov7j0+v9D4/L20UCvoR8jT2pHtOOibrHVKppCL2mq8MwUZtQ3r32mZ7Fch50cogmkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuiPH2Cz033m/atfVMgfZDTo8M88EX0cJmseDeFxPz4=;
 b=PSEq9Q/4ZZU7R/eDctnD+Jhzo1wQWEstBdl1vLRUfpXoziAWMXmt9t7QU4/D/Y8eEC6yOYkoju4cuQmMvU7sNUysMqn0a0p0Ge3Lh6zI1vj+rDyQ3SVbhusWApEPopa1tpK/K+EqkJS8dhhXtqCf2/3EUNIrVHKDpD8gsArV6b93OiZushfqvnfbJgth5yEkNDef3KVQ3gO5YMhiRNBExSR/HuqlJfq1ZGDCJRtsSWcYdhxIYX8hJucrkkMwXb+kcNthUedY0indLPgbxSURRcRbuqo/jB6HNzVb/0RCFcBy9PBvx+2Pn+7fClcka4bkPiD/BHBUZR+dLBQbJqC+6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuiPH2Cz033m/atfVMgfZDTo8M88EX0cJmseDeFxPz4=;
 b=qlwG9Yxl3mI4+Akye518vJKaRpY8opIq1pN7O0ZM10FyX5oOSzK+T8w7znU1V5J7Vr0HsndHgbH55tGc+6p1UZYuhQ5uv77eey82iPkRypqgIimivCyNxke/1gpVts4MvoXrWMo+eJvu7bYYgSjkcc1RerrYbRFxJNt/HyJielc=
Received: from PH0PR18MB3845.namprd18.prod.outlook.com (2603:10b6:510:27::11)
 by PH0PR18MB3864.namprd18.prod.outlook.com (2603:10b6:510:26::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 17:15:30 +0000
Received: from PH0PR18MB3845.namprd18.prod.outlook.com
 ([fe80::cd9b:85b8:cef5:e543]) by PH0PR18MB3845.namprd18.prod.outlook.com
 ([fe80::cd9b:85b8:cef5:e543%7]) with mapi id 15.20.3654.013; Thu, 10 Dec 2020
 17:15:30 +0000
From: Shai Malin <smalin@marvell.com>
To: Boris Pismenny <borisp@mellanox.com>, "kuba@kernel.org" <kuba@kernel.org>, 
 "davem@davemloft.net" <davem@davemloft.net>, "saeedm@nvidia.com"
 <saeedm@nvidia.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "axboe@fb.com" <axboe@fb.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "edumazet@google.com" <edumazet@google.com>
Subject: RE: [PATCH v1 net-next 05/15] nvme-tcp: Add DDP offload control path
Thread-Topic: [PATCH v1 net-next 05/15] nvme-tcp: Add DDP offload control path
Thread-Index: AQHWzN1HG/NZMJlMnEO6aRrtWts3nKnwjXFQ
Date: Thu, 10 Dec 2020 17:15:30 +0000
Message-ID: <PH0PR18MB3845486FF240614CA08E7B4CCCCB0@PH0PR18MB3845.namprd18.prod.outlook.com>
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-6-borisp@mellanox.com>
In-Reply-To: <20201207210649.19194-6-borisp@mellanox.com>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [79.182.80.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b541bdc-543b-40e6-2ec8-08d89d2f327c
x-ms-traffictypediagnostic: PH0PR18MB3864:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR18MB38643CD1625087DEAEDCB7DECCCB0@PH0PR18MB3864.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZpUESW5xq3jzolYp1RU+uzqlSPL+RByTXeqpfvJ33tzh/SvqiHSoYJ65dz+Bui4PZZg3tk48/CPVMlz2b3NlcywyW6MXy+H9iWCQEDYsxFDZuoXcBxbDuj48gr/iV3R18O+am72nPU5aqN7Qj93rdg22kuNXJSIgdVF4z5KkLHNfkPurw74zi2tNSYCNu3Y6RIskie1k/vPxCbEWFThUvSiUPpj0uKOteT76cVz4BKIsiBf38F20L/f1XOQt+14DhQwhH3TJcZxX8hqomc54i8ipJuJ9OOY9DiaCEpTGcb9aWiubRWwA7v0NptCD0huCHLLe0/H7GUtX5TKhcyW+HefordIyas3sU3DfHOMQQd+IT+tVr77vpq+vOqEuF3o3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR18MB3845.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(4744005)(508600001)(26005)(5660300002)(54906003)(33656002)(110136005)(186003)(71200400001)(7416002)(921005)(7696005)(9686003)(86362001)(66476007)(2906002)(64756008)(66556008)(55016002)(66946007)(4326008)(66446008)(8676002)(6506007)(52536014)(76116006)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?grxxmBagXy4Lmp9iz/GdcqY48HuPEfDMOm/U663/jh+wxSdNvQ5/DUXlkHmG?=
 =?us-ascii?Q?tt21X0G0mtDJ7OqOOSvVHUCrBMPs/QNYmSHgy8BbzZwgeCnaxjdvWJP0cRpS?=
 =?us-ascii?Q?AlKXMEgzBxlfo3Bul17JecYK+QzmhGVlp5z9A9RCRH77qyMSlu7Xuw5xy/J/?=
 =?us-ascii?Q?VldhYYMz6fWg/7mbBn9jDoVLIJAgPdwRvn5Pfv3CKyQomkfsXoyxHhVoibG1?=
 =?us-ascii?Q?iq405Ttwth5ThNg/UJ0vYDePoWQH4IVoVjvA6vPN21Oho4tJAGFhSLsom6BI?=
 =?us-ascii?Q?sD3MGKU1NuH1qnNEq7i+EW8enbOl34zSWEMEq+LNhSv8H9GW+rOYxPpoM+7S?=
 =?us-ascii?Q?HuwhhfovdCCR7WhMh17EQUzbqY1ZeuKg99OtrIF9LScNG4kUgRuDyrtYZ3rB?=
 =?us-ascii?Q?t75dXkRTYMFbJ4hCTNCZZ4rhkAh6FeYduZtNm4ouaFaSwD1tSRPeWWz0aIK7?=
 =?us-ascii?Q?5Xa6U+dHb5kKPKBuVzO9B8hYsKpuoYFcmiLhO969cmzoSKEz/p06yX/vTbnZ?=
 =?us-ascii?Q?9sspOjv3teUM1m0HynRQXDE4OJitYkx/b/9GnFphQfezAUR+G5AXKoBbBrQi?=
 =?us-ascii?Q?m5uBDayonbiheyrsU6OS7JgC9M8rGO73WbwguZDoVNsy3nPKeiUryqDVC7mU?=
 =?us-ascii?Q?lNejD5OHA+Qjm46TL0qT3FuIfbHkRMXQE9U8YZ89qqFJjhH30ZCoM5r8LnSb?=
 =?us-ascii?Q?T119mjrM4mecfI0QFtjQzak4DexTOSA6ZX6+K+h0UfuvmEaF3CV9/QX83T4S?=
 =?us-ascii?Q?WCgayRpTgg6q+sJQJmCdDB4t0/TEDNiH7w6oADzpzHa1vmZp/XfUhcXsFjXb?=
 =?us-ascii?Q?rYAMvZxZdx77Yjtqje7KKFrvuZgXkNxH1MefCFG8YPWCgMs06W6AUfPIUILm?=
 =?us-ascii?Q?M+VHcwGwaMP1pRbKSvB6ig+QmSexrsA48CZ9IFUSHD3nCgXfYqu7dAQ8VZVj?=
 =?us-ascii?Q?rcSZBaNoG9eZjzcr8pHKR6AFpyOfk9LzN65I2ATQigs=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB3845.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b541bdc-543b-40e6-2ec8-08d89d2f327c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 17:15:30.7414 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPl0zE4Ivbhp9NW9OocJIxy2cmPVbYV+DVMrlxkBLf+3VRqIEUNPEfDUxmsMVbgn8bOQcTqt7DZm+bxVXbZvdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3864
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2020-12-10_06:2020-12-09,
 2020-12-10 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201210_121625_316384_46245E9F 
X-CRM114-Status: GOOD (  12.53  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ariel
 Elior <aelior@marvell.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 Michal Kalderon <mkalderon@marvell.com>,
 "boris.pismenny@gmail.com" <boris.pismenny@gmail.com>,
 "yorayz@nvidia.com" <yorayz@nvidia.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "benishay@nvidia.com" <benishay@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Or Gerlitz <ogerlitz@mellanox.com>,
 "ogerlitz@nvidia.com" <ogerlitz@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c index c0c33320fe65..ef96e4a02bbd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -14,6 +14,7 @@
 #include <linux/blk-mq.h>
 #include <crypto/hash.h>
 #include <net/busy_poll.h>
+#include <net/tcp_ddp.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -62,6 +63,7 @@ enum nvme_tcp_queue_flags {
 	NVME_TCP_Q_ALLOCATED	= 0,
 	NVME_TCP_Q_LIVE		= 1,
 	NVME_TCP_Q_POLLING	= 2,
+	NVME_TCP_Q_OFFLOADS     = 3,
 };

The same comment from the previous version - we are concerned that perhaps 
the generic term "offload" for both the transport type (for the Marvell work) 
and for the DDP and CRC offload queue (for the Mellanox work) may be 
misleading and confusing to developers and to users.

As suggested by Sagi, we can call this NVME_TCP_Q_DDP. 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
