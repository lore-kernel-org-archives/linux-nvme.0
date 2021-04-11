Return-Path: <SRS0=56zt=JI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7C4C433B4
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Apr 2021 03:33:15 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C65610CF
	for <linux-nvme@archiver.kernel.org>; Sun, 11 Apr 2021 03:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C65610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=o6fKX80f4Kn+E4WUQ7D0GXEKBoS9xevspYob1yfjMw8=; b=hh9+9t35RkCDJXizBqluPlpxi
	Aybor4ZfLEVdq3ZoSz9l6eti+iTEXD0nAjXR2X0xkHNenwmVrUfMxYrDe4qTSr3UT3P6vfeoq2aUV
	RPSFuML2Qk0TmBYeO5Xx5KJgxMIlIUYvrp2VDs3T3waf4P1GAfEmCvSEfHF0Rotl1OpTgpQXdBhpa
	GjscJAolKc3jAYX68Iqxgw2FRw0Cvset3Q9W2JNfxdg3sMy9ulaz8TtvPAW14ukPowTWiG1+axW80
	Q0vg3S54NHbwq3JbFPaigjIF+9csouFVtE5+0AGfiHh+kqgRdUTmwu5qTtFrEHkjEkaSy0UU8KP8/
	442ZRJipw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVQqK-003sMJ-Ub; Sun, 11 Apr 2021 03:33:01 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVQqH-003sME-MJ
 for linux-nvme@desiato.infradead.org; Sun, 11 Apr 2021 03:32:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=7Oycix69vRqexdNy94FuWSuvqWkKDUzRdrMev/2773k=; b=Yt5pmzsy6ZDySIbpux0TuxJo1c
 RLTGsim0FdrGGRGZ9p1OP4CE4nAjs65WGw0lsTcWtWudUd5MIFgtmlPjkZPtdvXMqlXyM7dMiZLfZ
 obVnIq2z1HfMYRvQluI+fFvytg9nSmmnjV8mh2Q0UqaoRaAr1O6Vf0lAzble8JTB1Yh6lpa9WMahB
 sh3dWNrpaKu4bOs31gheEGmI65e12VYwhUOgNIwkze+PKImDNTRpGyOyJPnEigu/KchKyHMTKPTxJ
 kkI0DJu9ccwlmUTsRj+Upftjd0WGNM5V1uUcx/7mUE6MYo+jCeqRL3krRVH8ByROiX6FB2x3T1Zge
 zJRWVZZw==;
Received: from mail-mw2nam12on2061.outbound.protection.outlook.com
 ([40.107.244.61] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVQqE-005Lr2-7V
 for linux-nvme@lists.infradead.org; Sun, 11 Apr 2021 03:32:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjXhUuUXRefDTH70T80u1sid36TUAecU5yeYKTCrZpd+Sp8Chp+tPI1iI7EhJYcry5dKB09MBsEcV5xaStCgjqtfqDyopqonnVIsPrMMP5Qxfm/wRO/PLEOKRLCYYF58Bs+md8ELwW+cHwccTitpDZZ4V06dhjlKCQxE8vyWXX1gLrocjXN31cNxBWyip8z0bPZQ/ZPjLo+fOxa9xKhKN2dStomJRqSDerwdfadxd+K8RrgsQHWFOkOxCA9lP59/rCAFYqo7OjyYiAzKdtbygkwD8orVnjrkYidDMQQNfI8vVRg5nqLAUSxoc19t2I6MgIhSoSXD+VBUg7ylmiZndA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Oycix69vRqexdNy94FuWSuvqWkKDUzRdrMev/2773k=;
 b=GUVj9mdJkOhWCVCc0J4ME5oz9bv6+/HTGhmZgQl54hj1lOHoTtuTIzYEyMRJl5Znc72YqsUvm2YJHL+RuyoZyctXWrYtczcQa3WEMjxnuVRFam/cgzkCa9DzmacbzPudKLrkG6RGeJ3ns4QxLw1FFDGQcdiWsTif75ANfvb7apbOyAGkdLYWwpMA2bnBsDjvR3BTtz+65KN9XAPjRvmhnPmP/pCMpU3XXUv7Jbb3EsqRk3nwbtaXEMvFTyCTcgbSSrv5jl01c5XC36GegKH2lvR9xr4YWwh0lb0FfRp9M6C9J0Q3Rk7QcwJ3JZjO6ZBdn+KWdMl7wZLDboYQKRrhRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Oycix69vRqexdNy94FuWSuvqWkKDUzRdrMev/2773k=;
 b=iJnkNQ6rb7+AmnA52FF6RUny2YHwPxjaXted18sqXiL5K6GCZu1anWtpEqJrHsYhw/LXuCLNuS0x9veuKtfbfyO6b0I2ay5NlhuqUMEFX4mhj0opFpYVtkmLtZexYpDBKoVVgLzRfqUFbZJMi5qhzusymAjzcf9H5lJgbo1bskM=
Received: from BYAPR12MB3238.namprd12.prod.outlook.com (2603:10b6:a03:13b::20)
 by BY5PR12MB3713.namprd12.prod.outlook.com (2603:10b6:a03:1a6::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Sun, 11 Apr
 2021 03:32:48 +0000
Received: from BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c]) by BYAPR12MB3238.namprd12.prod.outlook.com
 ([fe80::5870:fcd6:b13a:c49c%5]) with mapi id 15.20.3999.037; Sun, 11 Apr 2021
 03:32:48 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "S-k, Shyam-sundar"
 <Shyam-sundar.S-k@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH v2] nvme: put some AMD PCIE downstream NVME device to
 simple suspend/resume path
Thread-Topic: [PATCH v2] nvme: put some AMD PCIE downstream NVME device to
 simple suspend/resume path
Thread-Index: AQHXJiww8yAELa3I40uYp87vDTMXuqqfYyCAgAe6e6A=
Date: Sun, 11 Apr 2021 03:32:48 +0000
Message-ID: <BYAPR12MB3238461139F6DA569D038156FB719@BYAPR12MB3238.namprd12.prod.outlook.com>
References: <1617194885-459-1-git-send-email-Prike.Liang@amd.com>
 <20210401091645.GA2934@lst.de>
In-Reply-To: <20210401091645.GA2934@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=2109e129-e9b9-4cba-b278-47685ccc19c0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-06T07:18:28Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [139.227.235.92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03cce610-6ee7-4284-7e52-08d8fc9a7a71
x-ms-traffictypediagnostic: BY5PR12MB3713:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR12MB3713B01D7F92186BB5C97955FB719@BY5PR12MB3713.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vBGGfoRbErUF4j+UkNtl77haewcGIwP9O3+APLngZRuL2gTS0dyJ73JV7OR9H5rCYC3RduHtRFoJ0oV7Gk/oZ7TE55KmoK1YnBnzzZ8Tpau1eweaqDGs8GGYSeRpFZPC1F5TbasfCo9wJpAXHW4X4K2BYiLQi6UFaOk+uiIMv260wdz7iYlEo6Dwcy76CTfpHdeeRKC09ANycXGa4lEPdWkwrMtB2lKhU7fWpZdIjiTgE4GX7F8MtMCSY7w6PrK1Vpi8DKkobuSiPnlKY6GbncD9dtXoESBV1ddGW+HXmF5Z0LiuQVieWYLIDwOtNpHFMYH7xO5BMMBAYAdZaIVSyXRpMqMC5ogEbDPjKhbKIR7C7BWHj/D63Nbtl5SG55E8ydA7IPEX31aAQa0lJ+QpIOCgsXJOMDCVxfCe92/0aF93Cps9RYk+MqrZXnWXSlvX7Irjw9YUTem2IEKhUNy5L4jfQ5beD+sret/TnmIbHRFRXBPrehicsyh96t++I+L/UzkW6E+CdFc4b73WxQ6ALaspkJwqQ/tJrGgJKoItdtrqxLjKL9sYTD9AcqKNXrpXrRSUNgnBwqmlkSwfKfChfehE29Psz10C7DF2FmIAGJY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3238.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(396003)(376002)(136003)(86362001)(66556008)(55016002)(54906003)(7696005)(9686003)(83380400001)(33656002)(5660300002)(8936002)(4744005)(316002)(64756008)(186003)(66946007)(4326008)(478600001)(71200400001)(76116006)(52536014)(15650500001)(2906002)(6506007)(26005)(6916009)(38100700002)(66446008)(8676002)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?euM/RmF3xvGBIDKkbi3fNlIDL2ljitD5zq2BpwsZMqd64nzo7TgANJb8LBpI?=
 =?us-ascii?Q?ERKBGq2Sr8AATxi0TSNX1zobN94Si/qLqF8VYp3IB3in88CUAsULAg6wVTeT?=
 =?us-ascii?Q?IAFh0iH6+1hD1Qhvnjo+W0+Ve4JScOnpU2DggMxTRXvqtu4UGyrx66idbdi+?=
 =?us-ascii?Q?yVTqhehAQcfOehj+k7s6al+rrCTsiQ/9xh+jdB+3pTJ8SxAZ1JjBhqqem+ew?=
 =?us-ascii?Q?XlI+rtiVywGlV3+cHYVnRS47z6AtduPdFc6D9a7GJ0iA+WqwgsH0pse0Bjfh?=
 =?us-ascii?Q?vV0tYiRFmxFf5e2I75xVe7ztnFOMrS1xQ9QIG0aUwV7wizURow+t2fT6C9Tk?=
 =?us-ascii?Q?iLc/svlXEgI9IoQIEgeshcRKPVhmxl2k1o5AUvFtQj+R41Ow69ssaGx7j15L?=
 =?us-ascii?Q?kMaODRISiooQWjXTbSKwyjtuIJmIIluJaRMUCUL9qtcasG6SRlgiPpoT3QuS?=
 =?us-ascii?Q?krsP39cpvjWpGUXPb0NfceFZU2SHaGTEE2H0K62sv5PuBqfFak4TotqkK+PU?=
 =?us-ascii?Q?qcSTPH1B4HI9r0gdi1fLAekqsI7HOj7dzdqZFP5qC/1XorYjXAFOZ9yMBrzZ?=
 =?us-ascii?Q?JnAt6FjU3gUYQIQ/x/DEQWAYSTVbgaSqUKQ4fa0/06nYb5Y+/8JI25LSP2n+?=
 =?us-ascii?Q?676LUOpQrbqvirMlNutxC3GxaUuqCq2IIVeyEZpT5QzK6dJe3SA2dzVeCHm2?=
 =?us-ascii?Q?uvlpQ6MGdgcUKmG+ctclTXcI5jYYEB2orWdeFnSGC9VkxfXV2Elu83biB8SW?=
 =?us-ascii?Q?NFfZT86oTI0qzkD/PI9IBRGX5L+IO86QSFnYmk5hHdJuEAmgBv82EARJWOpG?=
 =?us-ascii?Q?NKIx3WKn8PZ5RHb9XGHClgRpWwdcXUx/TkL0cW+Eys+Lo+bMQVCEbeLdWTVc?=
 =?us-ascii?Q?5v2r+AT0PwObfNt6jEY6k5WklM5E9ja9wd7il9+qoKUYOKSaJukmKq4Us0lZ?=
 =?us-ascii?Q?SJ+94YSIkaxQbAr0bwdFrJcDMOrDXtdoH/nHz5I8zl/ehAJILiF/CLmGFnAw?=
 =?us-ascii?Q?CLkNAD5rXhczY8XRIaAkplnyet3l4pQt/TQ/yg9VGGaSVN3O+RQ8E1CW4Acn?=
 =?us-ascii?Q?FNm+pejrn/w4oIVh+I2vTJZZjJBeKKccuv8lgNDTmGJLDJUriUVP9pOyDK9D?=
 =?us-ascii?Q?LycsXOBYllg/FI9e+3DluizB5BJYUZbka6tEYoi+an4BTwiRhXqHdPjFATGR?=
 =?us-ascii?Q?QzZZaPVXPMgytcd6D6+t2k5WylxN5DCYRrw/z8DUkUxMBpq2/N+t/zQWZJog?=
 =?us-ascii?Q?CJbAjykFsy4K6Y3vDyY+7ZlFeYXOVV6racAJ/XEGycAdRZ48dK8iUZjIJdmC?=
 =?us-ascii?Q?wbY1qxWOlia80zQcBPJJnenv?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3238.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cce610-6ee7-4284-7e52-08d8fc9a7a71
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2021 03:32:48.1846 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hlse7lyx2VQiTdFTz3P+kAKv7FiRGRfhM3uMgtHbwSJKl8FVinx0ySvGJNVrEEdY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3713
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210410_203254_478248_90EA7668 
X-CRM114-Status: GOOD (  13.40  )
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

[AMD Public Use]

>
> On Wed, Mar 31, 2021 at 08:48:05PM +0800, Prike Liang wrote:
> > The NVME device pluged in some AMD PCIE root port will resume timeout
> > from s2idle which caused by NVME power CFG lost in the SMU FW restore.
> > This issue can be workaround by using PCIe power set with simple
> > suspend/resume process path instead of APST. In the onwards ASIC will
> > try do the NVME shutdown save and restore in the BIOS and still need
> > PCIe power seting to resume from RTD3 for s2idle.
>
> Looks like this is a generic PCIe-level quirk and should go into the core
> drivers/pci/ quirk table, with NVMe just looking at the quirk flag.
[Prike]  Thanks proposal, put the PCI identify to PCIe quirk out of NVMe seems more modularization but seems may not simplify the logic. Will update the v3 patch according.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
