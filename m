Return-Path: <SRS0=QQ4x=HE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B077EC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 07:57:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E20B64EDD
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Feb 2021 07:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E20B64EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=+meUU+neE2aGZqzjXrxUGK/a8sbyTcQ4fubYHvxnykc=; b=oMuDm7O3SmmpHGmCXZuhua0Ag
	MfWSS4Gd457vnhfCrawh7kiBYGzcW3kPNs5fRwjjIdm5tq40Lg+h+xdDabFx7cDOVwupjp4yyxOtn
	qsERYnRLuNuy1boDAHO1z8dsu8JF7SuyUJIF6oXXFDljoMTPDfbJBXCbLtOGl4dD21E/cIezvgBr9
	dO5UnyJ7bzl6BeoAJM1aqtAB4kOIvTQdBq6EfvPLbvYVu7VaaCHLM0Ml8GtumA8Gs9HQsjFkDc/Ud
	3/LuoWo3bzRwgsWKE39DUMGCwpmPCgS8nwWbn8JSh9jM24qDDzk+Z9Xb6EL9ZIIPMPPGdLywDxvQJ
	TP3n4FQ3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6qYc-0006kV-B2; Tue, 02 Feb 2021 07:57:06 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6qYZ-0006k1-Ia
 for linux-nvme@lists.infradead.org; Tue, 02 Feb 2021 07:57:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612253279; x=1643789279;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=gbHagc/tqvRY2AwIRipS03O8JYxCvfetnlvbqdc1oRo=;
 b=bo+YvRnChsSNE7ZeXu4bJ7D3/BWKYBvkpB8WluOCtN+gttesABJtQZmo
 QUWDPtjUC0eD+Pr/h1On+Hnwv3ncXa1ot270L2sphaX3JJ6ZbygIOlFMu
 /+o2MjpwNGS5FhQi2buX5CdUtlX0Z8ERKw19rPSDUlVOXz34FoG1Us8xB
 vhrqiTMY947+D7cVN2XB2r7B8GY91r1oYSiU0HZVgiqa4SYg9dMotMZXD
 7FK4dC/BI39421x6V6JZ8BIW38tVh/2mF11DGMXeKw/RK2xPD/ZqxY6e4
 QrNS5oV6B3IaVulX0EeSqYxCxbzC7DRMenL3GpG5mLoohdnV8t8ndJrCA g==;
IronPort-SDR: B6xRgxjQwW9KzULsC73gsLVPPnarj3uY3I7S+/7xUL+bRmWRmtb2DBaTZRM1uCPDxgDIZpa0L3
 EpShxl3BF28oqk+Fgvb1HQzaeMHsldH6+3RpYzO2Hg8nTaA7PoaNk8soMNQLTQUYA1mPoEHwKN
 hwpBzFYrXnSd+Z5QQudceLQdhLjzaCFVwkZJNmNYGTES45cmT1mG5lL4PmH3O9sf72sdI1ubbX
 nG0GS9hVe247CdF4GUbXgm9OSQXMCWCxUtdcinhKAhr/x7jfaS1rInK3R3Wu9lnuPrJFokIvX+
 wYM=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; d="scan'208";a="262972340"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
 by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 16:07:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJEb3PAdQVEtXEKSvJqbbQa+eQBC7oYifwCUtmHisuL188HyDDUwhkJNUM8x5erg9bbycR9lEx8QVspbtCfvze2loXe2TLPr7nmh7IGRv3OWkoOnGH9ao9CKWX9KAU+zhWAYxo17HAu869MW9pF//18c3OqAW8ff5Dhc1fiKyQCbA/oSc2ch+rYib/F62DxCjkaCIPEDCLqB0TZsB35ARN/k8WKZ1ElP96aZ0Ki56IUo7N0vRYf5MPjF9Bn6Mfa06rEqgfBhmsJsk4dikuyaq7Tv/P65bxEadH7sbXWcl5WyVrlCRpvHUs05j95NdXBj+SFC4YbKfgCfOm/QAubbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbHagc/tqvRY2AwIRipS03O8JYxCvfetnlvbqdc1oRo=;
 b=XyoQBrGjokmoGzHAHDXAD3sLe/vhlVybGYEwaNsbxZAdqA7zyLqj296i7+d2+uF8VnM5AzXTGBSc/mHoN8+ZkJgUEKe15OA7Ae2w5Lgr6ptYXSvvbEeMeiZuBlccmbL1+Rl4UWL7qMlpdMPgobsTpHD7dAUVrs8VWIehHObG3DCeKkety4FV7YFovki/1RWU5z2LvCpkpE94zdGPob7aSAxE8mnmKXYpujav2CeCFGYIgWaOSBFE+66yFw1NPz9n4H9k9BUCfuJV++9a/nmjtglUx02KDAIJrn1jdwLClLLepmnHCRaNWchKNuthBC3nZ9v0nG+DF5+lOB+FQVa+yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbHagc/tqvRY2AwIRipS03O8JYxCvfetnlvbqdc1oRo=;
 b=ARQgEhnMP+v+45505eLIUutxdvYcifyB/juds+0auZI6vDRpTrbnWxKx1DpbHR+ZAE5IdtjGOy6kJ+Br5mHbnNMQLCp1s3mhICbME5pPXgOVyi/qKgizDIOAcy50ttst/EQ/V3ujEiHoMjA+FtEf5zbJU2pt4l9O+P9sNbEJ6LE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5592.namprd04.prod.outlook.com (2603:10b6:a03:10a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.26; Tue, 2 Feb
 2021 07:56:56 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 07:56:56 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, "kbusch@kernel.org"
 <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: convert sysfs sprintf/snprintf family to sysfs_emit
Thread-Topic: [PATCH] nvme: convert sysfs sprintf/snprintf family to sysfs_emit
Thread-Index: AQHW+TK2/5rGGHwNtUm7nWW0H7DSsQ==
Date: Tue, 2 Feb 2021 07:56:55 +0000
Message-ID: <BYAPR04MB49658C9E558544DAE549D64286B59@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1612249577-66130-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6845d9cb-3d42-47f8-58b4-08d8c7501c62
x-ms-traffictypediagnostic: BYAPR04MB5592:
x-microsoft-antispam-prvs: <BYAPR04MB5592533727AF96CA3F25BC7C86B59@BYAPR04MB5592.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:747;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: adU/P30hEPzFropNj8vgQ8NIp66VfMrL0k0AEky+bUCLUV568IGbNjOrsjZ0ElycL1qoonPX64XIRoGueMjx5MMJjwZSrvaiNx28EWIPnLPRVpRvALRtg0mKgE8y3LDdB4N/8CVkdGReG7BkdeB9yfUTWs32YO1fcdvDnSbSuWqFfItj2EU9Urw+9zWl297xtjGRrCEjai3+akIB7mQPzfpRAw66fsTimONG9XSCDpkn9TyyvnN1ECuVdkV1ezpYVVq3eEuKRhiYUvpbleiDB3p+6Tji0XjR9uh1IAZNpMZ/ZLB4VsYKi/fxIy7B4stx3hKswk8iOBfPoZ4MFL3tvIUiLXrEvwDajHNzp60qlwu7SNLJtL4WyQVS2KE7p/uTX9zShOrHCrz8g1A6Q89slHwA8p5kKtiPz2yBfsEd7MO7p71tdNLswDDHfRYEku8ctOCkJAtE40VvP+DY3E++1nf+6prxECusG47aaxrGNspc8T4EfLUhZgqo+7zlinANJ0ZJQAWalRW9+xbx7MZd3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(33656002)(7696005)(110136005)(2906002)(5660300002)(71200400001)(478600001)(53546011)(91956017)(6506007)(64756008)(83380400001)(4744005)(26005)(316002)(76116006)(66446008)(8676002)(8936002)(66946007)(66556008)(186003)(86362001)(54906003)(4326008)(55016002)(9686003)(66476007)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?EwnJoOAG5/mBcv/jqfGqVOIhVFB6UIIrxTuQqW30+GiIg4twbwrTLG+wancr?=
 =?us-ascii?Q?k15y9EaBeNZBKbe26b2wa8cC04Df6i4Jq/sb5Jsx+AGE/cGlop5BUFMz89Yg?=
 =?us-ascii?Q?v2e9NyCHFJtrBOUyTBoz6n96LNoA4pnBw6EFmhxSVsSacR2jAk2HLp4jOo8/?=
 =?us-ascii?Q?ur/tY/2SigDFkLsLxWQ8ySn5axa1fAtDLk2KQQc2RtIYzvNbWNjqlEBI6C7o?=
 =?us-ascii?Q?DkfNnDIQ6bm1YVEYH5PXOXB6krrPXN8CZ7ueO0YGMljhoHQ2kzJWzk9p21x+?=
 =?us-ascii?Q?dHv362FOtugxZwobzp7LC8FD9DQhSq5OjzEwf0vvjBOlF3e2KSq3tssnFSoJ?=
 =?us-ascii?Q?VyI0xBCzT8rqjqfTEuSWzj1Ds3V1bMM8tgfVp3pyf3X+L6ZK/2P77YoRs++N?=
 =?us-ascii?Q?f01TjYEQH23hC/G2UJLCXTE9ivmuSoT7gosUfjCdk7u42le0DzDW8ppNiarv?=
 =?us-ascii?Q?+1myIVO/vezNNg/9ik99bXObFKPYq8cD6/0Gj38CnU/PVvdwyDflHoNQTbQ3?=
 =?us-ascii?Q?BuEDsRFJnWH3P+cUSfsKAM1I/1qszURGheoRyhJNJhdHiHaDIITaAFlooz4z?=
 =?us-ascii?Q?SmV6yxMdIzFEgIRuOuyONAsHOSaoLJzdoNfck+Y4B5NIJG3ZKJhwPi+k8Tyn?=
 =?us-ascii?Q?XCUqI/fb0h+wvuTH3kIPzKJPZUjDPFNv+A0QX7jAsu8uRDwZGjO8KV1ZhMqd?=
 =?us-ascii?Q?kDmKzqq1xfGimbhMy+3m0r1tnv5CEyLpAankRtaY9I5cQDG12vyL7l2IL1xO?=
 =?us-ascii?Q?TZonaK0KbDfuu7tHtQQBKEQMKlMcpkBouTbe7+VYhqBj08imHmlNC0lN8l1Z?=
 =?us-ascii?Q?Jj5vkXkJz7oum3uBTHjWkKK0Lv2saa4iQ2akMpI1ghc7vD5o3bLBRmPJvweP?=
 =?us-ascii?Q?BPoCdKvdXJojBHHtCWJtRLx4EGU7JIbpn7AhuKZCRWVN8uGrrSVkNhNzakMx?=
 =?us-ascii?Q?G5t6u1lsDdt17epjO4j4MFjUmY/+jdYLnkITJ/Fb5drGWv/ghG241ZVWVQ3/?=
 =?us-ascii?Q?N+LKoyIaA2PtoxOKcyYN8CgN9IWQfw1PJHkDRpDPQjP57+Osi11+BcmcSrwl?=
 =?us-ascii?Q?QGIT5qRGhHZ0hCtCCskEDv/pHHVX2A=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6845d9cb-3d42-47f8-58b4-08d8c7501c62
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 07:56:55.8684 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c9dy6uWSXf1VryDPiTuKR4hGiXuFL9qBSNxQQgroTDBxGehJbYCp0Cf6sIyJiJ1YbGliEH0JW6yTfni74dm1IuIS3jCHQ8JLF4fxelITSck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5592
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210202_025703_747270_2EBDE475 
X-CRM114-Status: UNSURE (   9.03  )
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
Cc: "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/1/21 23:12, Jiapeng Chong wrote:
> Fix the following coccicheck warning:
>
> ./drivers/nvme/host/core.c:3580:8-16: WARNING: use scnprintf or sprintf.
> ./drivers/nvme/host/core.c:3570:8-16: WARNING: use scnprintf or sprintf.
> ./drivers/nvme/host/core.c:3560:8-16: WARNING: use scnprintf or sprintf.
> ./drivers/nvme/host/core.c:3526:8-16: WARNING: use scnprintf or sprintf.
> ./drivers/nvme/host/core.c:2833:8-16: WARNING: use scnprintf or sprintf.
>
> Reported-by: Abaci Robot<abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
