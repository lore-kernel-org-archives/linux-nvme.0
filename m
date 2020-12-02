Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AAFC64E8A
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:26:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E0FF20637
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 06:26:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0FF20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=X2bo9u1RCjAtvonys8jbk/FDDYk4mjLAkRETBaBvNQ4=; b=eOiwPFOMJVIcIKpXsqfrtRFOC
	rzGQA1oQygT6uqDWcgMRfqetBf6DnzRub95cS+6fWFOBsPTScKrAAJ4/5ZwGIV3J7xHLMD3ztKfTk
	/a60sRxsehPKpbfvn96zLTXWPnsFJ0BX7FQCxe7nJf3Q2PKSIHECes5In3O9cWZvxUk0PRGJ9mFZR
	YnPY3kuUAyDAoTfy0YSgXYX3OcwUnp2W4HgpUBzhbykPHq2p6uQyzlWuF8Eo/1BOoM2dLLWftqP44
	KatctiH848fto7NJH2Rmmu3nF4cA5tx+xUC04zTIiFqbL7Im0gQmhzoVzxBpsN0zFAGfUWdFjxRyQ
	/TN2LIY4A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkLaf-0006IX-DJ; Wed, 02 Dec 2020 06:26:13 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkLaZ-0006Gx-M3
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 06:26:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606891069; x=1638427069;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Ew9788z/nBsJGzS+61yRC6b5ftV3Fn0UHMavnZ1ifpw=;
 b=T9ivAE+bwV5mVqj+oZoADIOenDx3+joIocNW9zfVp7Pjl9co9LUpxiHV
 Zei4ASUrF5EhsBbLY7UEwqIrIlJWaY6pGNVLSxLNuQYFgmLR1jsF8ZUs3
 oftXxVpv6O5QJ5uMnWwXcQEgPMLpEs0kiGOphQ+o9zVEQ8Tov0CrmxUsC
 j6eqU8seUUA1ICvEgVSOsCtj14W8G1nUq1EjeTWVcb091kjYrokxbDmpZ
 nVVN14qN6ngObbnUAAc1edYTTGP/6f74qUlcDwXXGcJgc6Thm1IYkniN9
 bbU4a4/De4CmZzSk0mmRBFXOcmNANR4HJFHYdbCadfcbKLqaExn3g2IIs Q==;
IronPort-SDR: gQqld4WIgJ2KbdwSmlvNCLmgGQ20NwtQC0xejsI7JtnxHjiOjoFmL23CM87k2DfOOidzhgo7hi
 3GbPVhXnS69CuRXH/mAKGk5VUYVskcL4QOrer/Zqn+VQl+0rDZlHcYN5AqD7tjjBafMiR6YRUI
 DnnI8FA/o2qfHzuhLmr/vD586N7fGyDdjsH4BafsHsOzmul9yqZNHQiWofCe8l+GID915wYaSC
 iosWvalR6OmPaycak5aifck73LY1iC6qWsBehj0MC0+ms478KYlK9oQiYQ+25IiKcWj8EazgMV
 Rfg=
X-IronPort-AV: E=Sophos;i="5.78,385,1599494400"; d="scan'208";a="257684318"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
 by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2020 14:37:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCDowHMASyN3EqnN8o9sEcus7K6Jo+p512n3cALZDcVWbC39IxaPqFblTWKZHmOyR245/LXzINP33nxbJrgJty4p/oJ/vq0zK7CL/dsAxZrP1bCVj7MfYYIStagGAMJ6FEQ8JWSTChRvGnouoKcD7hEkMtBgZeDkI8X7aPO2AwnCvtkB4LnjYRUyntbkB7vzYyuetILKOebvUnYmy6meHgvAr8DK6SHKOegYKr0l/j4D7XwZJjYtdWJSjeEho6+/97zDlTU6PvPyC0QEw9djnBvoPN4wHxRR+j3pZDiJkDFXgyIt+w7TyWeFbVOmBQK+ILX0Rddzc9R/i3KTl4NVtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew9788z/nBsJGzS+61yRC6b5ftV3Fn0UHMavnZ1ifpw=;
 b=NE1GtY3Jx3fII1UZHz9Rr57g+ORVoUsjSmtLJ3t52WUp6qtQu2zE4P73vJtY6YZMNeyTRDNHxQHkdXkC1NA0VzU53f03huw8/8WFyvJLKKe6EeYJA7KcLNTxmB2xtfOFVZ0YAiO22R2Vnih/jOiK187uRVKevUGWd+aOIGJIGkoi189ebxDDTB9A9RK7P5CUNZRKJwWsTRAp1E0eY7Uwwo6/zUcROs2xRKxG9pYx16Jd7Mf4dkdjfeyYqkctn2Wifwk9xCD1F0BBdC45tfes+fG9lIJ5sx40c/eKm0BmZHeVmzs4zzuU44r4BhYVsDIKounYeo3IaluD1D6G78CcUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ew9788z/nBsJGzS+61yRC6b5ftV3Fn0UHMavnZ1ifpw=;
 b=FZuulrSDrJvqqP5DdsAxltPGU08EyPLmdt1vvXiBERlbN+/hG/96ksttoyxKhRK5uT8l6zsM0EcXJuqAoocKqYEJJTzsbSaQ/zV5pQiV/Usa+gqnvZFy9jrdsMdvjvjXJ5//v+psBNS0P0GbhO+Tc5LbiEHg2bLe8m1R4fLkp+E=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6552.namprd04.prod.outlook.com (2603:10b6:a03:1d8::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Wed, 2 Dec
 2020 06:26:04 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3611.031; Wed, 2 Dec 2020
 06:26:04 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V3 0/9] nvmet: add ZBD backend support
Thread-Topic: [PATCH V3 0/9] nvmet: add ZBD backend support
Thread-Index: AQHWx5hxEAbfrfG/GUqQyO0qzymqDg==
Date: Wed, 2 Dec 2020 06:26:04 +0000
Message-ID: <BYAPR04MB4965A797CFE6FE2E03522C1886F30@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201201041416.16293-1-chaitanya.kulkarni@wdc.com>
 <CH2PR04MB6522A2943EFDF118FEBA264EE7F40@CH2PR04MB6522.namprd04.prod.outlook.com>
 <BYAPR04MB49651C09824B2C82E44DB79C86F40@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CH2PR04MB6522AD27DCACDEBC04EF6A00E7F30@CH2PR04MB6522.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bd810bae-36ee-419e-4662-08d8968b2569
x-ms-traffictypediagnostic: BY5PR04MB6552:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB65524F0CEA0A78CBA8441A1D86F30@BY5PR04MB6552.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zDa5VmD+Vx2TlBLKL0C04nAbbxwXD/wMVlEnN/xCuBV+hyO6vNdXiX6dmGekKbkbWaPBKAl72BOLuOMJaug27sntxqXEBb+3QKx0BH1I5WofJgsFTO0PI0+099HHUG2E/a7WQ8WGZhR8YyOgBOZOpg1v+pQfrZIV5zNq7MOKa+zkQ/YjW6rhwMjZKaX+tOoWr78C6Oj0nWaMZLdgsp92D8wl9U1x1gPNofuaVaJtl0Z9prKrCZ7UcUkfZ7DnmSKF3WCds1/QqDmlzRUeF7/IZaUmPtz7wscNQ+dveFopMbl8sG23UyCRR7zpHGOOvTEt
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(316002)(55016002)(33656002)(2906002)(9686003)(558084003)(8936002)(8676002)(5660300002)(26005)(4326008)(76116006)(54906003)(110136005)(6506007)(64756008)(66556008)(71200400001)(52536014)(7696005)(186003)(66476007)(53546011)(478600001)(86362001)(66946007)(66446008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?F1qtg64kgXzDXhFAuGpAW96CZ7VqEduG/g0wV9u3rIibzM4axXperkinExCG?=
 =?us-ascii?Q?+feFu60atMRYSMBScZ8myZiyrOqqtgz43hIwGHZFNMAvnXh/GJkXR/4rwWPr?=
 =?us-ascii?Q?jag/v8j1u/ra5WyvEcyumBtClLKkJpYJtGBL7/ReQc6CtwT+UV5O1lfuLclg?=
 =?us-ascii?Q?BCvuucVCeChubbkPlGFKw5JV0/9z+vkEKaWW+1qdUtYihlV1HAYKDaubi/1p?=
 =?us-ascii?Q?5Bhr8PF2lXT3CBqcHa82BE/mZjWU4BPV95mTrJTlRqaUQEbbt5i2AJdeFSc7?=
 =?us-ascii?Q?Dx2GKYUaYXSpLnhm6pj+m5+xL1tyWJyhf/ir+cyjffvtbK9MchBU4/ecRNmE?=
 =?us-ascii?Q?mi06JLK6wCw1yboL0jSrDr6YvXkoLtvQCGe8lDPfUbV59trvAhjjpAJnEOeZ?=
 =?us-ascii?Q?ZOSVdfAg+uw+duVhITVmKzzm0xe5ZE5ngfxQ2/yKOvNZG6HvlTiPYUd7BIpy?=
 =?us-ascii?Q?/IutfGtzwRx2WVswGdAU/IrRpMe3QkJKxbQHk0ieRuvNUw0GY36z9YAEj5xz?=
 =?us-ascii?Q?hban3K4OLZWeaKqcnoTjIbfyRbTyN3p0SKv/I7A0D6vzCyYpwgJ0dNZXrx1W?=
 =?us-ascii?Q?cs1Smuz8mvaccYQPsoJqsJEPQX0e+7O2vPxxT64g+S17blsuMBTULJ78GIAP?=
 =?us-ascii?Q?Fvy/nccFCR8I5C68+K7teTiLy+E5NICcrHx7oUL+RYlS3gPM9gSwtD0XApj7?=
 =?us-ascii?Q?5IRdd6qQ0ZJdFU2D7BgyUcNFNkPMnxvUHKJ7x2y3WdjZZ+F9aJ1EpzOWDV4U?=
 =?us-ascii?Q?tVW3/h5GEbvtMXxtJfKJ7s5taIKCeyRQhgdJ7iqFvEGkMfBcciz4BrQY5sbG?=
 =?us-ascii?Q?6uxg1BlxJgnyNZlrRzlDIkUE8Vl3kmoT5glOhkCq9Aztj0NxWHD/lQYEgcki?=
 =?us-ascii?Q?anCp78k3kHCC20CCO2j5+HV6fQ12WFcJcIiuvVYHdTSwH042gClFMuiXl/r5?=
 =?us-ascii?Q?6m77VK1UbBI99ijObBI63wPpDZRGHiyh2BOOv16y+tfl2kWl+7BuipmoNaEF?=
 =?us-ascii?Q?hrI0?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd810bae-36ee-419e-4662-08d8968b2569
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2020 06:26:04.4372 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3nhrxscNJA7IlmY7OpOkjsFk/k5pXVljIcNrKXsbYpkf4YiLIkIbgIUI8VvMF2S7qEWW3OyWkLm//cpHro8j4gx+z+9SJBTn8t0JPk3vJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6552
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201202_012607_851212_B341C343 
X-CRM114-Status: UNSURE (   9.64  )
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
Cc: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 12/1/20 20:17, Damien Le Moal wrote:
>> bio checks as per your comments and I'll look into this.
> I pushed in zonefs test fix for this. Please try again, it should pass now.

All the testcases are passing, thanks see v4 log.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
