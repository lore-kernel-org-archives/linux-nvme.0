Return-Path: <SRS0=yO6k=IU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19141C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 19:13:45 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D866191D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 19:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D866191D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=BJ+mvbweVq+dJtK2AUMa/Cxx44J1pUsNxXfuGYxvYCY=; b=SyNmSNvjNefL5fB8XWs32STJu
	t5IoNyShYW+msG7wMfg2Hkx8mIgfHI303+CD1KkllmtZTk4sLdtnmxVk9J6ykJXsG0JqEV7Gmz1xe
	yjgAriWaJnyzCpr1JAXKnwmFWVzAMC8ZK6JCLskNDD5rFg8Cr2YKgJzg/48AyryhDsHVRKJd25MP1
	Br1+MlYJFGZPqyTiQzKiB3otDEiEYPowFV1noPimyIZZnOXHAwa0Z1zCSHMOUk17PxYjtBMVvTW6J
	Eh10uFlWXhg9vMZTP+p+AvzG+Ui0Kwz7YYdZZJfa5CqF94hKxdingXDRPn0W05Gnlo8IzpN8HxqWh
	1f3mLUjeQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOPzT-00CPYe-RW; Mon, 22 Mar 2021 19:13:27 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOPzP-00CPWu-6Y
 for linux-nvme@lists.infradead.org; Mon, 22 Mar 2021 19:13:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1616440428; x=1647976428;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=MN2Sq86e4wnLnxwsAD5mJmNCt3izvuYziDwWXvbXbro=;
 b=DduNZ3yqv3Rwdz6ZalU59GQSStXS5lMhjKtMsIiiOQ/ElkG4TIBNW1ee
 88r3dpVfeoTgJ/6YGoMcVSdwHQLFoZLvYUUkDq9gYIQWxVbKbQqmT2nK7
 o2FsMG0iGwM5DnGlSX91F2GMzNVVtaehnQnPWirWfoNC8ghKDvZEc3awG
 uePcGTXHsGdR/3UqYh/KnUffv0uJ12nIWTHS4uWVo8bqJL2hzaf1BOgrZ
 wb5AuX2+ZLkRPajuOnn0VukfswGsLCtisS63IHDxRzYZ3hhC6HuxDfWzl
 vdKWiW9Ra1qi+5SZu7UQzfIcZ0JBPfa68nhEfaFo0s1yGap8nipstwDvu w==;
IronPort-SDR: mgp94KLfKhJKAnSBInyE6X5Vu/7Fdg5aK9M4rH4ip1itDcmmXCI0YWj9lUGiVJlLnUfdC6rAm3
 ycJxckxi/FO8Qiqph3qMO5Ay0eo37ce2wCz+3ieRIHi0vTdZZu2ji80vF8YRsdKqC+1I8GFm+s
 0C0werB7m+HVvaJlvxajT1pQxmAbb8HNrtUTSKdV/pXcgwizmjMBrpORUFz9E16NUE0plXioD3
 gF2xhaE4phGuPE6Rhq7/xiOBKYq5DTwlcnOG2E8L3OKIvryYqTwP4K2Rtdo3ZSNDz6VxEO90s2
 UYY=
X-IronPort-AV: E=Sophos;i="5.81,269,1610380800"; d="scan'208";a="267147026"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
 by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2021 03:13:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTudcs5t0vzXFBcJFIibQzeQj0MWd9/SbysSnQpk77TJlLPmtblQ6ss7sKvwCudR0/BLHYFZGW5nphtl/AS8zC4BiE73yeqjfEMhpEiqILEphgYMgBhgpLDXFc299TvyL+EKOF8UWfna7vnW8h3jLaaySzVeYda4L84zzcAjTQZAYXh2PTpmjmNsamlmtS5Kel7M4vQeJ+3Vc7NTlEXBAp//shEbOVlE6ULcf69ztyGRwYvaD1W70amhXqanU1gYUPWTN6NNCqqRMVIE3FA/xJhH9bWn4CaGmYNxsHg/Xrn49K6D2WcwKvqxp90p7iDljr92moqpcaD+n0IkPmckaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SJNte7UT6se4iSMqwK2cdEaHHBJ5iPK5zOTmRcVDS8=;
 b=bjaVG4AJiFfShFhxLzyeHlZDMGKPdb10zqzaBsytU0U5y1LtDSi+pn6mlnot8KiTdAy5Sr3Gq7XwV8HJ5PZp48tjhIo736mWBKFZXGjFPcDAIqvPnOOF0vCpVoNdBybCrftlabxFm7KzQ3lAIK3tqbATO7Sy1SMJVz+YzIALWqsFg7wNIt+dg+WqJg4hY6LChivCZvNMzRhCbTbtGc/GcB2puTxyizbP5pS5T0nZqNhPKW/94OFAUwj0ZCbNa/BtmA4TEgi8diYVek2xI/5qF8mhJQKvREHMwfxRnhYxcF/yDw9MKgKUh0sZ49ZkKfSH3SqSlTFixrOMV6jD3UAheA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SJNte7UT6se4iSMqwK2cdEaHHBJ5iPK5zOTmRcVDS8=;
 b=iPwuK8LPArl0c/fynV/cfR52hrCt5Z/QJusdKmj3ZWSZDdmlr+PLhmNjmX+KeCr8KOEK1cusVOMt2bivzZ84W0mukuaTQcruH2/yNGRlBlE+s+SkMlSD3GWEBsQIRx4XJDEduyzu9b7aVAqYQtioQzHV9w+8EQK5QMbG+KiBLps=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7027.namprd04.prod.outlook.com (2603:10b6:a03:225::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 19:13:15 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 19:13:15 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "amit.engel@dell.com" <amit.engel@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "james.smart@broadcom.com" <james.smart@broadcom.com>
CC: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Topic: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Index: AQHXH06tqYHC8w0QLUOi6S5SvvpPqg==
Date: Mon, 22 Mar 2021 19:13:15 +0000
Message-ID: <BYAPR04MB4965D54387B025204D60CF0786659@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210322185945.10364-1-amit.engel@dell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dell.com; dkim=none (message not signed)
 header.d=none;dell.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a31f8e4d-58d8-4389-4c1a-08d8ed668ba5
x-ms-traffictypediagnostic: BY5PR04MB7027:
x-microsoft-antispam-prvs: <BY5PR04MB702750E783FC3B8053DB613086659@BY5PR04MB7027.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T5xC4D1R55ae447RwDd+omOxTPbndy6v7q9rsIgWQm4Y5VGT85CgpZNjJCUVz9NlaXQ517b1GYGZozUEuNfNu3kXHxZc/gBNF7hjZz+hR2yhENImE29hZ4T5f36VZ+A4AZ78beyl5SaUAqygbjlAZCHdchyTKkKwZIQ+8L763Ys8A8ZDkYEcSKPqnmoG5CVlbm+Ud8jQO38/Sp/u9pcqhOngeYnaPyNJpEFutvtVl1ueT0VT3E6mo9CAHKKNf6Tfj8RUbd1Pbe6sf/QwVE/7ui/GkD3HRWX4TrAuIrfa0j1AHr5wVHvbwHWmQhHJEpZd/zmfwse3LVcXpfwjoyBX/qqk1rBb+jTTuduxgSb19KjDqPyK0a/86y5fKtMkZCYxmr4cjrYpSC+0P/CrzaHyNXImpd6mp2ZeXVhLcN2wtWylyJu12t41hKylfdyVcMc4pqcVl0LEzkOXNMQJI2fKJb6fsw93WeovQxs+WKbUOZtOK1kw3pdN8vJ7kA43PUXlPJgdm/+H/Ydn5XXGQMAHWW8DhkVCJHw0sXqrj9on0zyHnbfWjk8MLJl2faicUGD/1IhqYvgA4CXvU1zM2rLGNLFIjCjgxNt5Rl7Ri35aOhV3dt/274sM0trKb1PFfYP8vOVbzZ+civF1YaVGO3LptCVIV2qUpRudFzOQMbEIVWY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(6506007)(86362001)(26005)(52536014)(66446008)(8936002)(7696005)(55016002)(316002)(66556008)(33656002)(478600001)(9686003)(66946007)(71200400001)(8676002)(4326008)(76116006)(66476007)(64756008)(186003)(53546011)(38100700001)(558084003)(110136005)(5660300002)(2906002)(91956017);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GNraDOkyEaSP8jxvTq2CTfeFzCIfisXHNInp5m/3KCxINIJeAoXu2PgbX0fe?=
 =?us-ascii?Q?DjpL0OJtkFtibPSE2K8jllGhpSieEMIRw51MtMKmrSsf+TBZIfGmPtgjX2yI?=
 =?us-ascii?Q?jIkCS1chv4Slg30BoFLmJBWndPFJhR1S+B59aa/CtJOlP4et3XsKKMwAPzfx?=
 =?us-ascii?Q?kDEysCxkwG0r2sRkh7b6PngZS2ZfpElpS0x18iZ39MZ9d1/W4vxXHbkJ2Pu6?=
 =?us-ascii?Q?PwHT/pqlj6sDjKHEtrTaLYbKMW876+P2zhzZaolxjL099OZsH2gF/Wpd/yBs?=
 =?us-ascii?Q?dGI00Pswd2fKbsC6qZZGZWfyzVShf/x6aSE00WuCVfmUk2hVfN2HjiYVq5zv?=
 =?us-ascii?Q?aCHBlydg7wh7O+70yD1dkDjeqV3Re2Lw4tP7SNSPVRtB6mWzLTt0Oi7JpVO8?=
 =?us-ascii?Q?FdrFFaYi8MOGiXrLQruvjXVEcX16uVe/WKqXbGKBiiD08XKOzcNljFUUk+MD?=
 =?us-ascii?Q?EgnSmQ9A341AtQrcrTrG3lzRohjYeBo2+LbCDLMn71VZvnSORvEDlUHukfOS?=
 =?us-ascii?Q?LPPsJ15rALFPGsJeglw8HcIibOIqbbfRxoGdXRNV+qeLTFDGbVZMJUL3zczJ?=
 =?us-ascii?Q?PbOgpZ8btkKQrFmgEC3Vduij/0eEVlWGsm46iGoo9i4hAdCR9ihLvXqVVSMO?=
 =?us-ascii?Q?uSKkIkqfTjccJRaZWRo3udt4BQAty59A9jeOMPkgQ0qVCvlBEO70VuOME8sX?=
 =?us-ascii?Q?umCknuLilNMftJzZjLWJ/A/chLwknkgt89Ay4+zWbFhuTomBCXZOAntUhwlb?=
 =?us-ascii?Q?xFlcXllBvjxDf/oREv6yxiC7SIjMfoOIYrN8Z2pr7Xc+EN/MqInhgyY2ZUYD?=
 =?us-ascii?Q?c4HSmrrC3AO//tKDibfCcQ+0ZvN9vACFBJ2EY/nYvPTyAWzaAX4Fv6G4dDVt?=
 =?us-ascii?Q?IB5RD2fYWQKqE7wmpRE+mCabURnKjO+EHC7Qwlfv6AM/aTSMjzq7w5KfYDlk?=
 =?us-ascii?Q?JRz40XaGVG/LasBI4LBAAxOLk+8cVOdgUSL2i1obaJojRoCkNUtPsM+zmx8K?=
 =?us-ascii?Q?sWXh/FyGxWBiEF4ycWZn15AEIiy9F9X9WbJeKlhbwGWfna2IvZDjZtR+syZu?=
 =?us-ascii?Q?2hourcfhGdU+rNVHu/2yWm3og9ZuPCsc+7u9XNr2qVqTUASYGI+bxVBYJgHT?=
 =?us-ascii?Q?uHGdl6tBHtF+T4CoE+TpxNVFxWzef4hPHDp4IShpPZ1Xn3SIZt8OLfx85hhc?=
 =?us-ascii?Q?VibCaA9d23lN+aH8I5DQJlLQu2Tr+I1xZ21Tg+zQHn4GoRmwVQy47HJk2xfJ?=
 =?us-ascii?Q?LluotQ8csIHlZAERtMBcRrToTvjfUSLTmxkQ0t3IUabOgbXpuzYBfxbE/l2a?=
 =?us-ascii?Q?T2LgbmlWU4uW3kfHUCw6sfmP?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31f8e4d-58d8-4389-4c1a-08d8ed668ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 19:13:15.7318 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Io5iHWruQGE8F39g4o/fbRP5e/vD5Qbqj7lNdrRM0LosrGHa1BJxS48HMq/pslT3z43lgC+nom0+xt4lCYpB3cWam4ETHuRs9dDwLyx2hS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7027
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210322_191323_561908_41F03748 
X-CRM114-Status: UNSURE (   9.23  )
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

On 3/22/21 12:08, amit.engel@dell.com wrote:
> +	}
> +
> +	return (NULL);
> +}

nit:- no need for () around NULL.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
