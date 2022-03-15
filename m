Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C03C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 13:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0HFh8RqYa1CuHUvNyq5/+XOo5d/ddhqL8MT53jO1wtk=; b=WO2sB7dfOESg9dm4qNHw4Npodz
	yub4SlHQozuPHhZbGf3i1aAwnPwe/ZXkSOlJoS4piMaqH/p4aQt4KmlmCHkvDkJae12XjRaY/ZqrN
	z52//iWpgpybkEHos/El6bzxqE4saV56rmnWoKirsu2v9W0jU7AzoWN2lv99Ag9wh0Ke3G5Ima74V
	d7eXzTYVi9PCblHUPaCG9yLpXeC6q1y6NaYawkjny5kHEEt1sBh55w/LG+9vxZ3wOc2y8T4BD1hOe
	VDyk8DAelFDZ/LShmb8cuL9mEzFN2FJLB0R4gPfY7C0BrDLsFdGWAGe1kRcIPR/DeO5htzx5+l3YQ
	QbMVc2UA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU70w-0098OQ-Qs; Tue, 15 Mar 2022 13:15:02 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU70t-0098NI-Fh
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 13:15:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1647350098; x=1678886098;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0HFh8RqYa1CuHUvNyq5/+XOo5d/ddhqL8MT53jO1wtk=;
 b=HPLtSL46j/YHMYa4RkqrcaZXZgko1JYsgi52ul6hsdOy044KDL4GjK4Z
 kwScwK0LQx/cjgHtjOaXSRPfEcM2LEeInDrKv67uRWexOtM1Base7q7J1
 ql9s7EYEYZog0S6IpHORoFIVwwuvvuXJ17uvFPNeLkPcNeS99CCad4yqV
 rimbYWtWcrDZGxtpGTDG4j9gSTWyrqxitdWPtQg8AyuJ3NQBCpGPRwWui
 OR+HXlEFzY4aP0zIRPS/E51ptdMKdhjxRtFUbxdkvxTV0eHE3QeUhYXSd
 DxALyUBQipfwoPAFK418KV6D0RQc05wlHByiL2T2V84pT5n72Q3mjuuOn Q==;
X-IronPort-AV: E=Sophos;i="5.90,183,1643644800"; d="scan'208";a="200250742"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
 by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2022 21:14:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWZZ6jLyNqp733Zyo9lVU6juK4jdEHPLycm9oOVM3iPbk1e5Wrcpab+5K9HBxQx6wjQ1tPE20Dw54T8nhCpXkOvkVR1GIYaGrc4y5QLImUnlvG0S/4LOLC+iLcbkoTHJsdLGrsAYwgBe5dYn7pMBMiJT4WkyUiW8DfHpJ1aTHS1DU2W9qrErFdGW1lHp1KOfoRs3ikRaua5bmwIq3tWewxZmojgSBxCHolEbAuDza8oUhMn1ZgvAfUX7yJuF19ss3zoK7DCR1OYnEXRG/XXAdQfL5y5icHLsOzyX+quZloqfAQwWymNXHLYrGz+MYpeo5sD9qSd9nlc15XYh5q1gPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0HFh8RqYa1CuHUvNyq5/+XOo5d/ddhqL8MT53jO1wtk=;
 b=XWFzAvxnqKlAinvHTwA34niqgp2YEO0NGrAEutb59BfvZl5/nHq7ezQIgUAbCqeC2aZYYYLHkVptvXURvlII9Bcfqi7RscXeCl8IJnA+ryK1INa1zx10lIjsNMlf4cyy72MmT5z7HFbd1lkysWvndvTQBkzrf7ulbmo1ZiY4yV8BtCxtRHAxP2CsQglyMf89Zo2C9/Hr2N0zc2I1ajLdc7Ck7djslEOYkbSNWy54rc0KjJnK1tpSBXYnaaFJFB+ylSJrz/RqLTt0SJWmjwYBk4/JkUAK0JPMH4+R0igyBDwflEtq8FUShQjBaTkwS8OYUYBNIeDt0ChPAnLPMqhc4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HFh8RqYa1CuHUvNyq5/+XOo5d/ddhqL8MT53jO1wtk=;
 b=Ash6TWkE3zj2dRGtcQ/BpkCW6EpP5YIpD+Z4w3zou0yjpvpNMvDV+R7KfNFDclE5Wyc/qsQ7zqFd04R1gXSFrjKIx4IFZY0uPFdbVn9Jr6y8Ldjhck9lGwPA+lL8/RHPf81Pu8X967RoKCHReIhFvtLs5lwih/FyrEYcjP3BrZc=
Received: from BYAPR04MB4968.namprd04.prod.outlook.com (2603:10b6:a03:42::29)
 by CY4PR04MB0249.namprd04.prod.outlook.com (2603:10b6:903:37::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Tue, 15 Mar
 2022 13:14:54 +0000
Received: from BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0]) by BYAPR04MB4968.namprd04.prod.outlook.com
 ([fe80::70e4:4413:4d68:a4c0%3]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 13:14:54 +0000
From: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>
To: =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier@javigon.com>
CC: Damien Le Moal <damien.lemoal@opensource.wdc.com>, Christoph Hellwig
 <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>, Keith Busch
 <kbusch@kernel.org>, Pankaj Raghav <p.raghav@samsung.com>, Adam Manzanares
 <a.manzanares@samsung.com>, "jiangbo.365@bytedance.com"
 <jiangbo.365@bytedance.com>, kanchan Joshi <joshi.k@samsung.com>, Jens Axboe
 <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, Pankaj Raghav
 <pankydev8@gmail.com>, Kanchan Joshi <joshiiitr@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Topic: [PATCH 0/6] power_of_2 emulation support for NVMe ZNS devices
Thread-Index: AQHYMw0pKwzLiS9sG0y93Ei4j88vWKy4YZeAgAA1PQCAAB3agIAB7+EAgAAI7YCAAAOigIAAB2QAgAAO1ACAAKBiAIADHl+AgAACrQCAADOIAIAAHFbggAB8RoCAAPimkIAAJw4AgAAAYaA=
Date: Tue, 15 Mar 2022 13:14:54 +0000
Message-ID: <BYAPR04MB49689803ED6E1E32C49C6413F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
References: <Yiu5YzxU/PjxLiUL@bombadil.infradead.org>
 <20220311213102.GA2309@dhcp-10-100-145-180.wdc.com>
 <YivMBj7+j/EZcMVV@bombadil.infradead.org>
 <bc0e53a9-f623-c69f-002e-d62e697a43d1@opensource.wdc.com>
 <20220314073537.GA4204@lst.de>
 <05a1fde2-12bd-1059-6177-2291307dbd8d@opensource.wdc.com>
 <20220314104938.hv26bf5vah4x32c2@ArmHalley.local>
 <BYAPR04MB49682B9263F21EE67070A4B1F10F9@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220314195551.sbwkksv33ylhlyx2@ArmHalley.local>
 <BYAPR04MB49688BD817284E5C317DD5D8F1109@BYAPR04MB4968.namprd04.prod.outlook.com>
 <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
In-Reply-To: <20220315130501.q7fjpqzutadadfu3@ArmHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b40c3887-b3f7-4481-b79c-08da0685cba1
x-ms-traffictypediagnostic: CY4PR04MB0249:EE_
x-microsoft-antispam-prvs: <CY4PR04MB0249DFB9D23D24973D170FB5F1109@CY4PR04MB0249.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C9UZzVN0BlPrISede75MnSuaTR2yQ37SXFaPqCnGqbAwWpSkZyQHbntVWpi0yJ/+/l8INO2IQTVsupLu0hEGla8wXTvIwZ9rzeQN0F86IUDorZvqCCWrx4T0PVxhpOqgHhoW8CULkPQJtE/WHStRGytKKRWFa+g9t0dCaYjO81ukoqyLjFW1qdmU96UD00igz+zTnzFG83G6BJyYUopllg2l/6Dlm3FWCirel85U4l/fe4BQ19slHIU8hZBxkRcTB8gFa9mFl4ar7ouVZfH5nrKp56kfrsRL7AOiWj8fHJNktP63dF1LNhEqC1BZjZpCWYcGqlx+1eqmvrgU4q7kIahzpn2oWXWXxHEptJT+U6MmduxTuQIyPGwyXLl6iHIGIgHRX2LvX+5d6VLC6y02KpUO6FsN32Ba2/0NavrQQD+V4BIDuaMK0FQLoDKCUHorgNih2Z6YReIiQK+HyIspfeEtlnIjPleWeimjpODgQajRkF+mLimIydY+4cFTsVM4YNtNdMzxtU7uGGjjHLcckPXkpyBjr/Dp4oclcX1gqY7lpSSTsvJSKvE0Zfndfo8zFpAVfpiFhUl8zqWjdBEeA6EMrMEdIKBUMbDObnpz/g4lYZnuaeWmU2gK64mokkMemH5ffvBcKkqLo6jkLrqFQz8MLGNnOgxUPOO9JmlIfRVf0Z8tzjJi9SxtCymLyXt4qLbQ6HRnqD/gIzdxIdvZ3w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4968.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(7696005)(6506007)(83380400001)(9686003)(55016003)(5660300002)(52536014)(7416002)(85182001)(2906002)(33656002)(85202003)(8936002)(76116006)(66556008)(38100700002)(66946007)(66446008)(66476007)(64756008)(86362001)(122000001)(38070700005)(71200400001)(82960400001)(508600001)(4326008)(26005)(186003)(316002)(54906003)(6916009)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mk51ZHBsSklpV091dUNnRWt5T01UVytlQU5taURKMnVDSEU5UCs3cFg2UDRK?=
 =?utf-8?B?UUExWW51ZmhUSXk0RUxmTGRKMGVzS3Q0TG5HdkxlNGFtUFBuTENTWGFmZi9P?=
 =?utf-8?B?aHV1bHNucUR1Q3d4M2FlMGZ6N3ZLY3BrN0JxSVBwT1NUelRNcWlVTmNBT1Bl?=
 =?utf-8?B?eGdnamlVRHY3ajZLdWVVcFZFc1E3bVhxZFE5WVJySENNc1Z1ajdkeG05M1ZN?=
 =?utf-8?B?bXhSQ0t2bGF3UDJScnJQTWlxNnd6dzhBK3FmdmdwTndMWEVwT29jZldvd2FH?=
 =?utf-8?B?QUdjV0R1QzhGMXhRSDRoK24zdHRGT2ZYWmxwd0NqdktiQ241Nld4WXVLSXJ0?=
 =?utf-8?B?STNsT0J1emVPbHVHUGg1UHV2YTVnTmlzdU1DdTBVNHYrNmdaSk5QR3FCemx1?=
 =?utf-8?B?QnJoUkJ5YVNqUXh0TXJhU0d1NWFNR3g1b3JNc2FyaG1POTFNSDdTZU9ZcEhJ?=
 =?utf-8?B?MjBpcGVDNXNab2ZyREJiZ3lhckJaTVA5d1RFMnFUcGUrd0ZGa1hMUU92VEFi?=
 =?utf-8?B?MSs5b2NrblpteE9md0dBS1JWV0dvSWRjek5ScmtHeDRySytZK1A2WHV0RmpB?=
 =?utf-8?B?cnBweklsL1d0VkpJckRGc0VzeXRPT2J0ODI4VCtmL1BvYW1TS1A2cExIdzJi?=
 =?utf-8?B?aVJSOVdBcDg1QkJLZ3F3bDQ4TDM1V0t5ZkRwQTFrSXJoV2Y4N3lZc2RTeEtR?=
 =?utf-8?B?ZjdGeVQyTHRQajFEd2JBYVBOTHZ1enkrWmNVWW1pazhKRGVURUhjVWduYlJM?=
 =?utf-8?B?T1YrSWp4UjlPcjNiZ1B3Ly9ISExhamxHNjgxN01wYTRWZm9pNm4yQzRPRG1G?=
 =?utf-8?B?cGZjVGFtV2tNdkFEbnQ0T08wc0I2dkYwMnRKL3JYOVpESmdpeEwrcnN1VUhn?=
 =?utf-8?B?M1FBbVBGMzU5aWs3UjBLendTQU5jd3EvWXlNdjZHMFZTZWdJZ1NiWTNTQ3I1?=
 =?utf-8?B?emJIWWRYeDRVQmtnSVZvZ1h4VGc3eTBUZHJDZ1luSTZSdy9TQlQxRWV1akVF?=
 =?utf-8?B?K0E5cmgzS01iYjN6UkVnVVg1b3A0Sjl5OEczQU1WMlRrUkJwMkV4N1BzUzl5?=
 =?utf-8?B?Q1RxZ0ZZdHA2cDRDSUV0MVJDMXJHSDdBaGdRL0Q3c3Z4eTFpckpNT1AreVpW?=
 =?utf-8?B?emNnQk90c09zRlJDYzVPQXNWd2c0YnFGSmlMSGEyQzBaTU9xcXl1ejBObk9N?=
 =?utf-8?B?R0p1U0NQR0RFdHNTZzRwSTlPRXQxbUhzTnA0QWFLSHFFSTVFN293cXR5VVFq?=
 =?utf-8?B?OUIwRXV1aEExQjZpN3NXQnFiWi8xdStxa2grQ0dPUk1teHpkK2I5R05RcElv?=
 =?utf-8?B?ZkxzWkMxbHJBYk1MR1BUNE9vSTRuS1QrMlJWRVQ5VmlRMTVqdzVLYmc1ZDJi?=
 =?utf-8?B?QkF3eGNzUk5NNHE5QjQ5S2pxMjN3MGt3VFlxWVJkM1VkRW8zVUQvaDJlL3Iw?=
 =?utf-8?B?RkwzaUtZVDY4c2tVNDZWTUFkelhUdkZYZ3hmZmtGVTRMUUs2dWFhcGNtdXR0?=
 =?utf-8?B?NjVXZksxVVo5eUtsQnlYOVBDTlFXbGEveDFzOXpMd0RIbnI5RmIwS2phVFhY?=
 =?utf-8?B?TnVLS0creHhiaHdkbm52ajYvTXpmZnVTQ0Z1YXRyeEswdW1scks3Y2xQT0Vr?=
 =?utf-8?B?eExXYnBTdlg0VTZKRzI0anBvUkQza0M2NFc4RGFsNE5HOUY1eDRabGlhdDBs?=
 =?utf-8?B?RE9IWHh5NnJZdDVycS9GRmZvMnkrSysrSWhSTjVnRmhtTUJKNGRyS1pOSjRk?=
 =?utf-8?B?WCtzLzlRdnlHWHovbkNzdzZOMGl2NWxhK213NlJmeDJpNW1yQ2gwbXA3K2NU?=
 =?utf-8?B?WEJ2U0J2QlErbi9rLzZaZkFwaFQ3WkxpQXBCSXhSY1JHeVVldXlucXVuVThy?=
 =?utf-8?B?OEgwVy9saTZyMUYrN1NFV3Z3aGFpODBUbjRTVW4rMlNpTGQwWCtWSG9JVzA5?=
 =?utf-8?Q?rxi6z3h8gvF7muPOJE9M+MhnG+FFkRAV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4968.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b40c3887-b3f7-4481-b79c-08da0685cba1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 13:14:54.1105 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mHf8lWgI9sxVSZ6EF4HvvY06UNXGYKQduF6hZypNJSJmgR9CxDayW0DTAzCcxiWVjp8Idz25/afUEH55XgVP7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR04MB0249
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_061459_568146_140B4EBC 
X-CRM114-Status: GOOD (  25.00  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

PiA+DQo+ID5BbGwgdGhhdCBzYWlkIC0gaWYgdGhlcmUgYXJlIHBlb3BsZSB3aWxsaW5nIHRvIGRv
IHRoZSB3b3JrIGFuZCBpdCBkb2Vzbid0IGhhdmUgYQ0KPiBuZWdhdGl2ZSBpbXBhY3Qgb24gcGVy
Zm9ybWFuY2UsIGNvZGUgcXVhbGl0eSwgbWFpbnRlbmFuY2UgY29tcGxleGl0eSwgZXRjLg0KPiB0
aGVuIHRoZXJlIGlzbid0IGFueXRoaW5nIHNheWluZyBzdXBwb3J0IGNhbid0IGJlIGFkZGVkIC0g
YnV0IGl0IGRvZXMgc2VlbSBsaWtlDQo+IGl04oCZcyBhIGxvdCBvZiB3b3JrLCBmb3IgbGl0dGxl
IG92ZXJhbGwgYmVuZWZpdHMgdG8gYXBwbGljYXRpb25zIGFuZCB0aGUgaG9zdCB1c2Vycy4NCj4g
DQo+IEV4YWN0bHkuDQo+IA0KPiBQYXRjaGVzIGluIHRoZSBibG9jayBsYXllciBhcmUgdHJpdmlh
bC4gVGhpcyBpcyBydW5uaW5nIGluIHByb2R1Y3Rpb24gbG9hZHMgd2l0aG91dA0KPiBpc3N1ZXMu
IEkgaGF2ZSB0cmllZCB0byBoaWdobGlnaHQgdGhlIGJlbmVmaXRzIGluIHByZXZpb3VzIGJlbmVm
aXRzIGFuZCBJIGJlbGlldmUNCj4geW91IHVuZGVyc3RhbmQgdGhlbS4NCj4gDQo+IFN1cHBvcnQg
Zm9yIFpvbmVGUyBzZWVtcyBlYXN5IHRvby4gV2UgaGF2ZSBhbiBlYXJseSBQT0MgZm9yIGJ0cmZz
IGFuZCBpdA0KPiBzZWVtcyBpdCBjYW4gYmUgZG9uZS4gV2Ugc2lnbiB1cCBmb3IgdGhlc2UgMi4N
Cj4gDQo+IEFzIGZvciBGMkZTIGFuZCBkbS16b25lZCwgSSBkbyBub3QgdGhpbmsgdGhlc2UgYXJl
IHRhcmdldHMgYXQgdGhlIG1vbWVudC4gSWYNCj4gdGhpcyBpcyB0aGUgcGF0aCB3ZSBmb2xsb3cs
IHRoZXNlIHdpbGwgYmFpbCBvdXQgYXQgbWtmcyB0aW1lLg0KPiANCj4gSWYgd2UgY2FuIGFncmVl
IG9uIHRoZSBhYm92ZSwgSSBiZWxpZXZlIHdlIGNhbiBzdGFydCB3aXRoIHRoZSBjb2RlIHRoYXQg
ZW5hYmxlcw0KPiB0aGUgZXhpc3RpbmcgY3VzdG9tZXJzIGFuZCBidWlsZCBzdXBwb3J0IGZvciBi
dXRyZnMgYW5kIFpvbmVGUyBpbiB0aGUgbmV4dCBmZXcNCj4gbW9udGhzLg0KPiANCj4gV2hhdCBk
byB5b3UgdGhpbms/DQoNCkkgd291bGQgc3VnZ2VzdCB0byBkbyBpdCBpbiBhIHNpbmdsZSBzaG90
LCBpLmUuLCBhIHNpbmdsZSBwYXRjaHNldCwgd2hpY2ggZW5hYmxlcyBhbGwgdGhlIGludGVybmFs
IHVzZXJzIGluIHRoZSBrZXJuZWwgKGluY2x1ZGluZyBmMmZzIGFuZCBvdGhlcnMpLiBUaGF0IHdh
eSBlbmQtdXNlcnMgZG8gbm90IGhhdmUgdG8gd29ycnkgYWJvdXQgdGhlIGRpZmZlcmVuY2Ugb2Yg
UE8yL05QTzIgem9uZXMgYW5kIGl0J2xsIGhlbHAgcmVkdWNlIHRoZSBidXJkZW4gb24gbG9uZy10
ZXJtIG1haW50ZW5hbmNlLg0K

