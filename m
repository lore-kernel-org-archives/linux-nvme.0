Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24804C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:55:31 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14089221E5
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZpoieC9e";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DeQfcMY3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="V9iY9iAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14089221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=zc3MTRiX0KOt9q3U1IlrJdf6DCxKda9HD2F7dL0A+s0=; b=ZpoieC9eomHpNvwx2HKLKbyG1
	PsJdGYSHQtU6rue7zQ5Z666KLUnrGNY9h+guX+pIWDTatUdtpfgwPzMLyhBRIX3uJothfNPCafTes
	hXfJ56REZASKEQ8zagXsEwN+K61m+Pp1oSkhSpDIVj00BZ6aj+RJZ6rTECOBVh0KxF+DDUjizqkfB
	4SzH+4UlpEi6UgfcMzVw8eujix5yGcMvF/7YcAvJBtGFQnu/WMVTW2k9EpJUDqeseOmvg9ybn8kL5
	KwPSx01MxKExzfc5Nz+3uSpnNFzCxO75haXs/hbllUBpU2C6DiUxWZRwpNbz9qzzyA5Lxg3dCniUz
	M01Ed1ZTg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lz6-0002As-QJ; Thu, 06 Aug 2020 19:55:28 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lz4-00029W-Fi
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:55:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1596743747; x=1628279747;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=FmSkGjrCO6cqOQBKr9qfJNXLhbcqpVVPBrYagLsZR+M=;
 b=DeQfcMY3QDmAZngIiLTQnQVx1idsqKGwHKtWGkP4U4SOelvJ5EuanOIh
 oFSI2Q2CbC9pyxybvS6rz3/rWCsHy7UEG5npOAsG3dp4uOZdWRR2XkiRc
 gS7lKHxrgG+0zekaZL5NkUu5tyj1NxEO9GpxDzRI9lKfDBq5C17BHWPcX
 1xwucM7yM7YuNC/fzFhXotzAKNiDAEbxlM9BB1b1g/PzqLNf7DNkkIuUd
 HMyFQCqLMr7P1iU4AgTE93e+8Lfv83crBEkIM5/l5S+Nv67Kh87TwzpNm
 +uxcBmDWvE/Eaz76ppsf5oGadfCzk//2PUnKSMMZnZoWJypf/iHX4JFnZ A==;
IronPort-SDR: mOZMe9wiPliXrz8cIjfJxQ0ZLyQoqeilEAUt3hPpKDef5IcgX/KBzq365TDT1oeCobsY/oMmHC
 sVC+GHb6KeSE0B3q0psWXBhzY0dy12vFnKLgVpxm9yrG1TtafrJqb3E07ZFoqKE5qF8eziHKMd
 IuhrBW8m8PAwk+udJUSluRJcn1IXSb8C4VnL8+CQf6lwx7DL5fCdzLrLOMRQCh1yFYcGBX7NVr
 GWN9j6Gcvw71J8K7zzBcCBpRKH4qkRFm/vEgYRWsdBVqjhvYD9w+umnanx1bvu7C3iN8W6ZvHq
 6+E=
X-IronPort-AV: E=Sophos;i="5.75,443,1589212800"; d="scan'208";a="247435989"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
 by ob1.hgst.iphmx.com with ESMTP; 07 Aug 2020 03:55:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHfY7/Q0oXi1r9BFLOsMp+vVTNLtidcjkLkjSjSYpuHwsHWjkCxftZYUITy4nZTtKsbbuBfe/WlgYVdRpVnOHKVS03kTODALSpL18j68kTu9FYhlU4PfXcBsZAOT+ue+sPKKiPUeYWA8O9rYLLOw3A53LBFfDgLA8asFU9X+Ycrko3fyGi7lmaG+KlYVwzozPxvV2L9TAAyzZS1QqPF1T+E49mt2QE5JeomgSrSnYJo6OTn8K2PfVBtzEREZ6Rx9kM+MK6HCKV15g+eLnS6/jM/nQQ55z8Cz47nJCsJljbsg3TNvhSVfnDD2PsULWgoiCa+fidblDQXLrXzYl7q0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmSkGjrCO6cqOQBKr9qfJNXLhbcqpVVPBrYagLsZR+M=;
 b=fyfk9CZ698sHDejfC9v7OyXmQFGOn0AJEmwQLsM0xc0/arxxrWKiTFNtvBBk0z0AH+LGbQU/eVmF4ay1fjbY7GWIwAgaIdkAlc3xa/1RGWU7VqBkHqOduDCRb2IHmq+sBOxcQv5D1/yShwZJRhy0/nx84MyZ3OG+LRUJ+WZjmqfiRoBiguu1PiwY3CV+eU/M0FUMtM1eLMN4uzr4DENMNx+sXuwziaB5fGFZ61bqgd2uBP6egmjSmYibSNR6AwAu5Xc4c1U/zeSq3GfpsRc8Od0PI9IpKWSvyN9fbfW70Ae7TlwowyHdaUMZPN6Siv/EMmSLrmeV2Bk3nRz75kWadQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FmSkGjrCO6cqOQBKr9qfJNXLhbcqpVVPBrYagLsZR+M=;
 b=V9iY9iANOThjixF85PEJ3gKL0pGA/AC51G1JTDvrRNZFGj7iZ4oFdm/SqAOx+VkZUCnZfLJFfJsnkQ5N+WyjShdGHcCl969uOEdTAVQpFB5xrMoq6VF8hnhGm/kPGsgjdu3V8slOoFI1R1K+nxeR86tz/eFmDDmsEG2V4M+0nUo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4037.namprd04.prod.outlook.com (2603:10b6:a02:aa::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 6 Aug
 2020 19:55:24 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.019; Thu, 6 Aug 2020
 19:55:24 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Logan Gunthorpe <logang@deltatee.com>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Thread-Topic: [PATCH 1/2] nvmet: fix oops in nvmet_execute_passthru_cmd()
Thread-Index: AQHWa8OqKK/52UoSzkecfpDi4eSGxA==
Date: Thu, 6 Aug 2020 19:55:24 +0000
Message-ID: <BYAPR04MB496557078F831A733E5C84D986480@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200806073151.56061-1-chaitanya.kulkarni@wdc.com>
 <20200806073151.56061-2-chaitanya.kulkarni@wdc.com>
 <20200806154247.GB3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <1f6a1c73-fd0e-d05d-3254-03d0592ac998@deltatee.com>
 <20200806162602.GD3075319@dhcp-10-100-145-180.wdl.wdc.com>
 <BYAPR04MB49654162034AA3CBA2F4E49B86480@BYAPR04MB4965.namprd04.prod.outlook.com>
 <5dd8cdbf-8864-ecd4-928e-daa74a9cd166@deltatee.com>
 <f6944200-35cb-e38a-b799-92bb4036698e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9328a4e8-decd-4621-bc3f-08d83a42a87b
x-ms-traffictypediagnostic: BYAPR04MB4037:
x-microsoft-antispam-prvs: <BYAPR04MB4037147D6F64A7128603EBD886480@BYAPR04MB4037.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F63gXEtAEdl7YDKl89V/xr3obl/N/p56V+Jr1nn6zhxnKmpKAOCfYyL4nrXQr/5aU62XrcKM9Q+o2Od/Oe5Gm5rKQPk133M9cA8D4fS6nSRIGKwnve3P+0czTuUsHp04yqzQowxgV6mUm+5BiN69E+/CuUzWIcsvBP2fenGVWrSlYPF5zznidwDXZxs4zsZT6UAdYyNGJBxuNzV5WI7/TzehTYY+vZdtfAvqdAFEjI6hI7q+XPJIGBk+YcyzbYBkZrLGvvuP0oZdvuSLrtDrwVy2Xb5S9rXdpZx7xH1RI3IiXgwdNomhUGi/r2YUAbQd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(558084003)(7696005)(2906002)(6506007)(64756008)(4326008)(53546011)(66476007)(71200400001)(66446008)(186003)(66556008)(76116006)(66946007)(478600001)(26005)(86362001)(52536014)(54906003)(33656002)(8676002)(9686003)(316002)(110136005)(8936002)(55016002)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 76HKOMvplTU72WU2Rr0GXh/uJiCpLGi8s60UC4X9jnGVVun+HmvILTVyBX7lZxzg/wTM8+wAeQwSU2+WN+R2JXcYQ3M8sxxz1cd2LZ+bo7RRxbfGctEd6LODSxEr8un2BM2+M+jxsEXxYV9NG/9QMAUF3d34jqhVqy9qbMhFW/BHKyFMvyx8/tj4j2Lbg1bjdDP75y8Nf9p3hffWx3MtUrjhHkqfImdfivtaRqIlrr7pP6TIly+DtPbU9yolOJdfoaJgLOJ8k2PZ73nLOQEtt3LRYUgJhFxhzq4ou27K4yRLXi28iBDApGYVS0gf6pEO/MNXWsLbtJB3ERvqw6FSZmIHofzkQ3e29fPg8ORtuM4XVrJD6IRw3LkZJT4yP7z7cy2ESMQXC9q3sr0T+DpcxlKmZHDdovhDYgNBwfBnudYDO1bjndIfr4HsNg5RfXPLSHzmmQiQ1QKlueOEg9Rewhd8WMiocC51Ml/MLoeoJW0I0EXc1V0dOK5Q4P+vBiUxu0ajFHbcGZOQwF54T1wdbuuPWss24yFav+SIx0tJ8NbNj4v4sk49RFZLnU28gZCierj/f40cEUpzhQWio1KqkbeBH3zuCiwjfTUTmiYODtDoHAu/5Ri9obaVCgCIG1f2+d96Sd9wI+8x4xpeb1Y0zQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9328a4e8-decd-4621-bc3f-08d83a42a87b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 19:55:24.0999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e6SDf7xZ7IZQ4e5yXOxlUMI/Z7euZcP1ynIPgdG65Qy8GZsl1aJJHUy4slG4oNqsa0O3VIu3BY+JA6Ghe/lgYbsxDEt4HjuP0wThQkwRaQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_155526_777307_BA9FB2A7 
X-CRM114-Status: GOOD (  11.03  )
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
Cc: "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/6/20 12:54 PM, Sagi Grimberg wrote:
> Can we also add a label to remove the if (ns) condition?
> 
Sure, as it is we are adding label not we might as well do it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
