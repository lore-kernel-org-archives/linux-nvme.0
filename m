Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA93C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 01:09:30 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C27C6157E
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 01:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C27C6157E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=bVbF6NQVZE5miJRXbeWa9yusz6jdFDx/frKSRMMwbDs=; b=OrH3PkFCukBZlTiRs6jYdKcep
	VlMkmWjCuEfKeKeUqVyWq8gzsQD3Lal5vycYXnMotQGK/cOKmDm96AzfN8534lCaPhqT1svvFCGj9
	GchoRz7Af9tUNsHfQhmGz+7dpvvP2jLAw+9SfPQ+zy2EbWg8f0djnskbzCYRpCO9OE/sVOXJ5bxC8
	sN4sRclaZBfMH/GAS4tXB0SuqbSwU9lexsQhrJgxpKAIOLWgliK2tlAoQSAvEYxFkakF7k5h6J4l6
	pAbTEtQjzpYhMaHN616NUDC0sH+YGBcbsGcD3g2bepyNQ5qw1oU4eXNJ1zOeAn4k0AqSCqn5w9+/a
	RszqYTNiw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMh9v-004DwS-37; Thu, 18 Mar 2021 01:09:07 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMh9l-004DuK-6O
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 01:09:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1616029737; x=1647565737;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=jHdJWLplA8AihJRoVeH+BdWj6EyJ0w5RA9FnPXIPIIU=;
 b=ehJIxIcC0OM8c1X2+hLNPV01zHWdQOOj5fjTqaIkLAaY2MnCulJ+zPWk
 EqAVjhNFy/MM7oNhg8+QESIF1FK6f2FJNRDkOlPj7kEb874C4KOpvxajb
 k0y0T/WzTyPpqlNnOHoPFgvTwZdvfhrlADks8OiBcxWjexALUKeviLv7l
 l1aeFFRpIYcyqHsCX/JdMILtla6qERGhUhP0UsPOMQgNOmvoHagbJtaCd
 aXZu0kqrYqFcfuKP4cJL7YlOTXXsx27KEJSyap7Dq5ZGPCcvz5hHfDcMM
 rzDnGuVVxmlF7d5VEDI8bOSX73tCaOPqq1z3X59aX5BUSQYQg+hckhGcq Q==;
IronPort-SDR: W3oasJ5ezmJN34mJGubrHTwQuzz4zi5vYnVQfHYLtYfTPLDSyScr82i7H4VBoGpfCpbfPt1f/w
 hag9eaz/xYn0Bqo505Orwl0pJAtMeMzaqtGNNE0CzLwImjyEWg8wE6z1SuupbMXbdc5ohhAczl
 Fls4KO8wynQaONOmc9hU8/wjq2sfuJGwVPUKVhNI8UqrUPSJFJJ08ooCuyxmsqb/9/4WJF6g4y
 lwQlxM+G1XeJcVrE5ZTiFW7wLUHHccTyGjsuyaM4Srr090EW2bKPbKTZUjKfNcgTw26914B4qy
 Csk=
X-IronPort-AV: E=Sophos;i="5.81,257,1610380800"; d="scan'208";a="166897000"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
 by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2021 09:08:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1jON5aVMguk4mmes2hJ9lKz8Y550Xinzy+BPDo7RIdwKacojKnZ+Jsvb0Qw1PxOgpa/QElaGSsPraBuykGKW2YEukrN1/UP/wh7cW9Unsm0T9DK7z/OfcVDKqIT6ycTaJXKT0SgTrVcjtdvQ4CdJ3wiDkzO9+flx+HX3xi9/XlvZ5n3jJhtpq0JvrakWlbCJHpspoQPPCJYkY4UQ6DP0wf7Y0G8MsJQh+e8ymoiN90hA5VEnK6eTC0qFupe1wCiOA2QmTW8v7y9Qt+oM5kSXaL/HDzlwytfgbnYsaFnSmqfcKuCITEW594auQDHutr6QPdfdWkuUlAZl6g3miIoWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHdJWLplA8AihJRoVeH+BdWj6EyJ0w5RA9FnPXIPIIU=;
 b=Ry/awJxEG6ulFN/6eRvYtDVHXqrxjZBroHJmg7z0wEHvkkyaaEEokuLNJw6CF8eJXDnCDI5KYAAf5pvbFQRhg4TmJXGU+K8ugqzKeuFzx17EWeCnFjCSo/FVXrZOF3D1j80uJAjOffp9ONjwnQiLTNkgOpmNHC0XZ7lpQBBV2Ze1LZXBcWJqfR8Fee8sAAkT9MBe+srgkWUo8jFFIBSV9n4dFgYCPXLf+Q+DNuIHw1XTtkA4wj2YjTZwbTGlUimcPywWrhO2s+CZpkAko5FfgEhk8QNAuH0jI9LPiC/RXc2IO0+R1gM1JTnCY/SPO30iz2FIHC0FTOINOkcWbqhu5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHdJWLplA8AihJRoVeH+BdWj6EyJ0w5RA9FnPXIPIIU=;
 b=h/d9iD2WdvhxmvYa8bABaPL00htNyYjN9xt3oGvj+gCnVraMX4ckBk8bPcmet8wbXn1t9mScP6QT06iRcxUGqIyzKN7Fd+4IPDK+Y1BPI3Rpf73YY3U3cpemGcL4qM2LAv3Bi0+lM86EK6fChkKoA4hUxMedGZaMC9CrLsckPCA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7501.namprd04.prod.outlook.com (2603:10b6:a03:321::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 18 Mar
 2021 01:08:54 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 01:08:54 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Keith Busch <kbusch@kernel.org>, "joshi.k@samsung.com"
 <joshi.k@samsung.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv2 1/2] nvme-pci: allocate nvme_command within driver pdu
Thread-Topic: [PATCHv2 1/2] nvme-pci: allocate nvme_command within driver pdu
Thread-Index: AQHXG3EUXmkpUEV3Wkq3BokJrT0Zpw==
Date: Thu, 18 Mar 2021 01:08:53 +0000
Message-ID: <BYAPR04MB4965F58264BF3AC4CAAA32B286699@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210317203703.17391-1-kbusch@kernel.org>
 <20210317203703.17391-2-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f445d113-ee44-4a66-c458-08d8e9aa662e
x-ms-traffictypediagnostic: SJ0PR04MB7501:
x-microsoft-antispam-prvs: <SJ0PR04MB75018C7B4445B4536CFD1EB186699@SJ0PR04MB7501.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UqNV8zfnYa+BYJsMce+tZwF/VXCi71vfWOENbHOBCJopsI+GImtw2y+BxzR5ss3mg1+GgkGfK+tI0MO+gzM2Od81bGX+zyqOvBIF4R9Y0nFoiovdVc7emzoU2QtMrtxXT25LpAcSewKTTHOtxABPYhKSKWn0uR2GksCSNwUedXQVkFZ+kOzm/GdsZsToqkJRjZ/AbN8mcMo3fePSVVZP/y5LZlxwntTqTklKf40sg2r0eEvOZTy9ojb7rMDASyhcw7gjDrmjGpsKBXndmZMKaNenGoRUDtzdnyg2fKIyASk4HWxQUtiDTi9euxUzCo9nEws2ZSTS1obv6f1W4nXGhPMpED66FoIbPR/fL+9jwSHDg6sU7XjrFoBkBGiGoJRAXE6SAsZBjAHpsDQ9kWM80HfaSeJD5jxjPmaijJMFUCuvqdP3LwA/FZxNMQlba8jN7lfZkONF4QxKvrdErO1St4u3RWjerab25NMnZ6DztbMfy4Y5+wYJ30KHuqI+OAqnk2aq1cGBQaAjZZTm/bVi+8WiSQ92orWlFiq5miaRr3iuL1MZw5+4SV1DQgxI5dqp00/GkxtgrA+u18Up1QWMESK3NUE3AdFE++B/4z7BuOkfxjzCg5ok/a5UGRh6Jswx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(8676002)(33656002)(52536014)(76116006)(66556008)(53546011)(186003)(4744005)(316002)(64756008)(478600001)(6506007)(2906002)(86362001)(66476007)(66946007)(91956017)(8936002)(5660300002)(66446008)(7696005)(71200400001)(55016002)(110136005)(26005)(9686003)(38100700001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?86L10STyo3IMlJMLK2Nv54a4Oj+f//S+aCQayebQv/XsG/cpQTWBCnc0bNTZ?=
 =?us-ascii?Q?3amsRR3ZA7NfIswRd/dcD7VdHAeZgo/C2AFvUENqkLWseBWR1CXmv8n1qwNk?=
 =?us-ascii?Q?wJmEeLTj80LdmuTpyC9b6TquRUGH5I7GdchMC9In8wOSyibblPa8aOC/pgX2?=
 =?us-ascii?Q?txXFomZpfEYFteGH2613ZZuKaJZbfwlrwn5eX3PWI95+hNPGRairE2ujVv7Q?=
 =?us-ascii?Q?k4MHwo38/bTWpRn1iX4hfhM2lRoEhPX/owgvXWbFMhdS8hYXckQfLK2bpYPW?=
 =?us-ascii?Q?d8KyNI0EyuMrrjGP9kzt42oVhLEGLErRRED5AGw40AYfAYl8LEiiA4u3w8sA?=
 =?us-ascii?Q?8Og7ra4eO8lFORXislKyUjHMvEieei1HSxft0G7YL71+8OoXZ3nXaao6pBZu?=
 =?us-ascii?Q?hJktcCRh9rXDw0E3WQ6bEV20hSKwHpHce5jSLfgnW1Y0LdyxFAB3eYHHzTjl?=
 =?us-ascii?Q?zN/uD/dcTl4PH8PQLfXCL10Xshrnzj18I/peF6/5O0fhaJKH3WQuCN4KLQw3?=
 =?us-ascii?Q?Y6LQA+OdxlcjIXvbk1jNbi5TsuI00tZIzvjFU2S0TsG4pZ/05QJw5V46ncRo?=
 =?us-ascii?Q?yEMXmnyd7WiQxTHLkkGSMU9Ky97tsRTBKniOHF0zhxKaJ8qjGE6bvZufe6jr?=
 =?us-ascii?Q?CvrhCNS+wXjVtPISjN2KpZyTNDc3rs0LqkJEbsJw0zstG+hIqWXHdxSLIJPC?=
 =?us-ascii?Q?p/qq4N8SkpORsr4NT5wHnNvqZp0RT13ohV2vHesomG7A3zbnj/8K3+oEVAbY?=
 =?us-ascii?Q?vw8kb5Cz0XWuv0JGLz+6lLD2ZrvF4G1ayJlK3dJ5BOEOGHqmIcXYcebvuxcI?=
 =?us-ascii?Q?Qe+XVQg1RWuPKWiH77T+rYlvuYJKvhzMh8U5HieGzL5c9yAjzoJWGerFTwHI?=
 =?us-ascii?Q?XRQ/YFkmK4T4dssFgl/bHU9tByjQQevAK9qS+zVPN6/SS2uRME/lFmhuaJS8?=
 =?us-ascii?Q?Ai4AXVLNAi0c3/rRnBwhA6LUCe9Ko0csPttRBoR4m+WWDwL8UjRU5dczOSZq?=
 =?us-ascii?Q?RycKorOqMmwGYlITwa/T6CCifncYNv6yGK6G166ehsth9JHdDna4Je3Apswd?=
 =?us-ascii?Q?jlZi6MeofHRak+hpoS1GUT2/nrnHkA6JaC/dr64AKRXj3QQ+4pMsEflz7X8R?=
 =?us-ascii?Q?Xio3SGtyv4EeKXoTzmh32u5Bs2CTxBVTDy2oFucdJFpGPLLVL+pIh45SKFdy?=
 =?us-ascii?Q?HkXRn0XWKFYHph5XxiBFqKSRBtYEsgBFsNyNmUzU2xq0D0aQr8PS7SYWIZVI?=
 =?us-ascii?Q?x3xJo8mXcNkkTGmVanM1OERNJKRaCUtWHlQ37Er9D59co5lxVirpsfwuXX18?=
 =?us-ascii?Q?9H+Gxq6m1RUHSm+QAtKX1+j6?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f445d113-ee44-4a66-c458-08d8e9aa662e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 01:08:53.8947 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /e2eheVHBMgDJCRbAraucrvF1IUWvi2lAFJ+tc+G0nSXM6XyT6IapCMZIVkYwZQ3R1ellnLzW3GnVtQd23Ds9U3n3wVUAFmtryl8E5VPx+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7501
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_010900_901412_E02C3A8D 
X-CRM114-Status: UNSURE (   9.93  )
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

On 3/17/21 14:04, Keith Busch wrote:
> Except for pci, all the nvme transport drivers allocate a command within
> the driver's pdu. Align pci with everyone else by allocating the nvme
> command within pci's pdu and replace the .queue_rq() stack variable with
> this.
>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
