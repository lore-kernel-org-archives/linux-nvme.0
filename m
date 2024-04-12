Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D5DC4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Apr 2024 10:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MHdqmslrMZWmrsPq2kjbv6ij8xZwuHO9co97Zc1jZbk=; b=qzZ13lwECc6GlzJO6OXfeiyUYy
	GwP6IapJ5r/4htf+YuV7zn52WHB8WzEyJWzCfDm2L+A9ctRQgpZLqogvpxdFNsarCHDcRbuUJ0VL/
	SETefMCnW4phbRLDvTnC5LA331tP4e0vT7nNmaRKcRAfw+0mGUwGW45jRiVQmLtjj6O8WEzZ+zsTj
	rBpY4jj/N0gaI2mJwSBI9XqR2gF+bze7Tre1sh+iOWx4WxKzPXrxacHKEDbSklBSlklqx+KW6GUcp
	PxuAYHrkXkYqoA8kUHXBcPBzuLcmuR/nByEI1TD7eNeWSaYampXK3ahMkRW9Mbu9NAl1MbrSWlEAo
	wG1Xpfdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvEZn-0000000GoGy-3sOm;
	Fri, 12 Apr 2024 10:56:11 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rvEZk-0000000GoG5-1xjy
	for linux-nvme@lists.infradead.org;
	Fri, 12 Apr 2024 10:56:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712919368; x=1744455368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZeZfVoQOeCG52okLjp8InIt6Tf7TBDWbBy7HJ5p+uYw=;
  b=PHwYFgFu5AkseP7Lnn/7ACx+h/lmxxZYF9uCzlKpaqmnN+4Thk7SVrnm
   ViIbEjSaqXoii+DHolTKI6fUt6iaYajFMGqCIp+3enMshd4qRnE513fVS
   5riwA2ucczk3jZjByepOetKBiWBJbf9AAZw018VRjlmC5IajOQFvhpuOu
   CUHKDvL4mH7wDk4oKef1sr/PL0jqDlb3vKVmFdLN5q78Zrh88NunGD59l
   P1IE6cSPCQbp/iNfHGBcW1FIjBiKaVOIfbiLZJPZ4t+lDdnxI8CEvE6T4
   d1N0V/nxf8BH69zQawZd2R1U8jhFzpIxjQz2g8+TA/XitZyf8giU7eTYC
   w==;
X-CSE-ConnectionGUID: P6i8RHlBRjKibyuoFvdGgg==
X-CSE-MsgGUID: nrH3AO6CTn+FhiMG+rjfKQ==
X-IronPort-AV: E=Sophos;i="6.07,195,1708358400"; 
   d="scan'208";a="14547741"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2024 18:56:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dj58i22EJqo1CXnkogi1LegsqdWMxHzA+eTnu+IfDb+rnGGxHhrfdcMOVHM9FF2j9XcneShva8kmJ2E6eS0XteoeDjM3oiJHRB+R/PexJl6KwiOYBJul/lxlhjxmq3mIH8cyNArF5qUE83K42aKtMCu4oe9L0FCxdSQTxw/mily86h1Wc1DMhCfeDlCRb4AYn9VMFyxFGC27EceA+Hb+S/beXndON9CHYOV1ou3M8eQnUmzUJpl9L1xHz/7y45qJdDKnKxarKiXIuS9QvWXOBrag0+BsxyLxJwOa8mMhv12Dyzu5hgVVOaLsFDoI47PZoonTS6mGbcoUJO1TnEm35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHdqmslrMZWmrsPq2kjbv6ij8xZwuHO9co97Zc1jZbk=;
 b=OXKGgVG4HYyAvQMrTmpGfnLcpF+9TJm116VQyL3NueQ0+H1/U+1DXfcsdzQSsXb3CvyiBqQnA+xpnjz2PXtO8fXt0xf8Ho8vfSwh+iZlrxGKjdNm++qYu3oRFHlfBx4MZA7mUOAk3bF4bUWgeoTJnC/KkBUVhkhSGDlWySJ3tWajboKSlc60I9hdlH7LMcwR8nlcztFk6j4toz0crJZvFG7QCTk8YB8wK+YDw30MhqwdTxOWUNWzD3WMMcDcrQ+o5hA7GqerowVN5EUby7SUOuwA08wC6XEW6+R93cKFljflJAgpBg7fwEd8Xo+HFUmmzi5oAO+2yxSyHRmmBhagEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHdqmslrMZWmrsPq2kjbv6ij8xZwuHO9co97Zc1jZbk=;
 b=UmtL8SLuLJuphtSUc6DeL3sg3cLOv172CNOENVF11r7laZYz3o1T6L8Mdp6nfQzYP1N+W6VTwjalDDf0sFMSN+ywxrm9eKWEPekj7IuSx7C+vB2H13qRba8o9dAtIHT14xjOiJJgmU46QFmJEVDeEZVdewJfBva8imxDpo2maks=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8706.namprd04.prod.outlook.com (2603:10b6:510:24e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 10:56:01 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c75d:c682:da15:14f%3]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 10:56:01 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya
 Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Topic: [PATCH blktests 05/11] nvme/rc: introduce NVMET_TR_TYPES
Thread-Index: AQHajD/xHKCgSe6kfEa5k1xtmLrU0rFkd4IA
Date: Fri, 12 Apr 2024 10:56:01 +0000
Message-ID: <sacgb2ysujrkf5qlu3hlqywg2jzfqkg5ljlbai2tb7srakvi2l@axrmnjehzkma>
References: <20240411111228.2290407-1-shinichiro.kawasaki@wdc.com>
 <20240411111228.2290407-6-shinichiro.kawasaki@wdc.com>
 <ccnazevlqz6dybzhe6asib3rtlz62ynv24jc22q3cgsf666b4e@6sd6youpsrrb>
In-Reply-To: <ccnazevlqz6dybzhe6asib3rtlz62ynv24jc22q3cgsf666b4e@6sd6youpsrrb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8706:EE_
x-ms-office365-filtering-correlation-id: 5d80c9e5-1477-4ada-56d2-08dc5adf2466
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N/t2CyeLbr+e8jNCy0U5OR8w9K4sYVIJBz8TD5IyJxPrq5NeYsEDhUmJN/YBQCdQi8sh7TzjPC3fINbOS5lYWZSOAzI1E6CGEj/r1X8auf0n45dtJNFFRV8BBxf2L061AoG7oM6ZNPSvswyhui6dKL2I1JhR/ga0Z6PUH2Icg/Ji51TDPSd945BkeojKHvJkdEmNM5tfM8pG1FkKh6rriUQNFSc4uwl4kXh1LjRNP1Zm/OUZ3CkhUbMC1TNDcoZMbRmcXJJagOQqtqaqQ709HCdlcw1kp4LigASGXQlx+/s9qOVTgtbgbTFGtB1vEYmRHZOrQk8CvhYhQ8RANSKMeu6vPWG8GUo7eA+jVw39NaBh6Cg6eIRjwNWnMssbzEpIpsJBUGPYI2XZ5INk8uunlh3oPoMMKPDTyDyEOxN0NhKvOdCDou0ie0VL8R38h7mC8OUAbFi9EfBAXfC1ynqTXyQ206a33YYGcne8VcjqZpRa+h1Atlycb2gX9tBKeYoPZAF8k2xwB+4VhEHjl4kRlklTwtqrTR/fkRkOoRLK3Wvoanv/0X8fFYMUgY1xrO9ZVFp6xDrJDdw4y/8phdopBFWK/r/c/oyJb8mYHuqpxgGNdbtcgkxU5h0N30y5olQ/fs3HIBR1W0nBmtIJHgBFZWXpU2VHwqAlIWG/ihERbtuUdijiFDOP3mfKoEgnSelgUN3dws1H5iHGzbkjwMvFMRj4s0I7e7Slhv5c+Oei4ARk5V+6HXAHIh4FMDUUo0A+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009)(27256008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xbR1z+zxB3i6RRodpqpFDfVa+4drPFK3Li5LIBww0LkXX50H3WwgNM9NM2zy?=
 =?us-ascii?Q?+04ZbZ2KQe51t07INOCux08i/8kKdnzSXPEz/lQC+pDcyxYb51IS+5ibEIxL?=
 =?us-ascii?Q?DkotnoN7izMHccpANBEsKIVrToisa+Hv8ZwUnQi0/0TiJcgg/+3q4Lp5Bc0P?=
 =?us-ascii?Q?789b0+nqeweU2YbXHD1NANWEiAjFcgDyQx13ypxoL0vhpKsi7GKNoBwECQR/?=
 =?us-ascii?Q?YXykh2IpErsR6+H+bvvtG64PKL5xhWZMJV3MK+JpMXe4hy5ChG6y8AbbaxkU?=
 =?us-ascii?Q?+YR5yQYmd4/Fe5BDCcAhJ7GrbgEeJyP49wvqgQeJvKq8zWWXr8nqVwqVuA6l?=
 =?us-ascii?Q?tRoJbo5r3GFqPi2AYDZv0jmzdVGTyziJENt1GY59czgy9CabLMO22DKV7Bx3?=
 =?us-ascii?Q?k3cD4SXm1o1nVFJNpREq+zZbbAdE7AQQSrMit3cLPfd9vPyLZTrFpKg/dwt9?=
 =?us-ascii?Q?xcrGoikBH48dMRgjxy9q9dBvcwc2ocSSXkOLYNPnqV/RezmncnZUYXt0u3/B?=
 =?us-ascii?Q?nhSkLk2YKzM2OJ5geF00T4N+KF+Bg5dwqWk6a3oiMyfw9BqJoCBsVDXmXMEi?=
 =?us-ascii?Q?Q8sOQx715Xe7KzuPjqxJYvy4pO+kbaP1kFpYTJNEu1Rm51mhHxPyD70uNFkA?=
 =?us-ascii?Q?OG37VyfsD/aRtb9obZJx0nVVO8YCaVjVXbmeGwngvV+fO4bgcgf8KjLLa4P9?=
 =?us-ascii?Q?QR3o/fkUjGjD377eAFYldAuWMK0ugXx6jILOFbi2d2c88T6NEcdlmWhESrOv?=
 =?us-ascii?Q?z+xw/i/ID+tUIOb5lLyiycD2f8Zlat33nHcmGmxNaOmqUxYVpx/vun/vH+SJ?=
 =?us-ascii?Q?i+Ox/ZbziOaeGy7vulxL0iqUXEi4WkENQMqT6z8ePimQnqTYg4kP6hlHjhTR?=
 =?us-ascii?Q?hA3f+i551kqcZvE8A2WDwj2UugEDYQcwkgbxUsTPI/QwdLTWIQoEI0TGei6t?=
 =?us-ascii?Q?6Q+dfdCebYK7He33DE9ptdDwMEm8Dmvuvc8mQOzdYt3pjdGZLM5hGo5HelYC?=
 =?us-ascii?Q?IWAQJcjEceu7HPCKgegDbiHq/dmR06uFXLZVF/xuaiTu7orbAogsC4uT5X3K?=
 =?us-ascii?Q?lVvx+r7aMdsDapjzbPAbx8wTiAtLeq6jpp20dq5h7kDZqJxa8GzJjmylrpgn?=
 =?us-ascii?Q?IgNr1JhndU92qo0VAxznMBLycFKipyg5HMQZlt/cmk8jp+d7qUSxJSC5Ix/Z?=
 =?us-ascii?Q?L2/n9YHr7QhVGLhOcMlK4obEV/YAqP21691SX7c8Aku6JU0mnSixbJwV6VYN?=
 =?us-ascii?Q?BQDvi+7FzVIOsw7czkPcyqLUTtLA/dT7OFtMAOXLZEWAWdpg2dFTz1OHiJh7?=
 =?us-ascii?Q?o9/FqQvlFzfg3LcNdOjljQEajRf94CTX5UuVqmFRt39VIsgVeHyNEKrxpBg/?=
 =?us-ascii?Q?asG9mQiBlwDxtK2WQCwEWN/R6K/ZHKJt5JGCt1FDrejgDwaeJqIkXQR+pwpA?=
 =?us-ascii?Q?LKrWVFwGRdQ7CI0OGVGFlPwnB2TNv0aZvPaYnHJapWMQJE/rDNKLXndDETZt?=
 =?us-ascii?Q?+2ZWrxvPl6jbguapi9aT96CuXZjo1syz664IuGIAQFwbOZvoZaOsl3fWpcWm?=
 =?us-ascii?Q?UzcYGlhwbWeMFu1e6A/qmec2qG1N5ziXJbICeIZ9UvogWu37MxySTblZ+Bev?=
 =?us-ascii?Q?strR/FqpzfRNVUWxxmiDOhU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DA339EA37B47A34DBBD9D15F4B1CEF89@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: PG9ZS9SsRJR5HocjVcUD7xy6l6sdUcaxdj4LPGTTSvbyKicuAfuYdO4bnByxk/vO263d4DazVY13q4DRU5cVVROrXFeShDJFPqX1PBRPN0ggYFlFTEbK+O52oUVFGiU51hrceOrEtjLahZSJ76JNpij/jFWTlPkTLCindH85//AReFZZKKnVg/Okrd7cjM7Rre/ePUwKHcYARJiMX331tbNWxvqsEbOhkZ4UaLB3UBLMRsm5wtJ5C0zBY02XNcuTTR/UsMuaSL+hwHogZsFsGpaSwHNOIj439pG++jWHoInFDaj7mjKZgyC6IEeIQ8xHbWkscFK7YfCRqOtI91UsEnqHV4gWJbPkJRaRVm1LG8UIJ8WaZJSecXRWSb7g5hichieuoHct30uytCk5RnbKzQZ0rDX933c5ZaFJTflYdM4+ZU9LbnStNjiIjKCFQqavGPtpoba1+ntIpih0u1ztbdM4QvRgMVbRdZqCROLg3z7xLIzokCymO8s7vmO9qUu+fqaMbkTppb96aEQWqBRhVeZPpZQqKMq+sEFan6DAXRZzcaoShmvg0RpvJeQv0efJNywxWQaNw4+Ple+KKfthUXnCstcEuhRr4j0LG2z9Q9QnnVMbKqu0dnuwzNF8x6vc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d80c9e5-1477-4ada-56d2-08dc5adf2466
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 10:56:01.4300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5h9sMY2u7a9bS4+T6qzc/3YjV5Bw9oQacROH0MZY4BTp4AqUE5aAIQRcqxk2tw0nlMAG0g6OKHUx5Skfo7yNByIh1R+D15+kT8mY89tH2jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8706
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240412_035608_583174_53C7D797 
X-CRM114-Status: GOOD (  17.21  )
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

On Apr 11, 2024 / 20:41, Daniel Wagner wrote:
> On Thu, Apr 11, 2024 at 08:12:22PM +0900, Shin'ichiro Kawasaki wrote:
> > Some of the test cases in nvme test group can be run under various nvme
> > target transport types. The configuration parameter nvme_trtype
> > specifies the transport to use. But this configuration method has two
> > drawbacks. Firstly, the blktests check script needs to be invoked
> > multiple times to cover multiple transport types. Secondly, the test
> > cases irrelevant to the transport types are executed exactly same
> > conditions in the multiple blktests runs.
> >=20
> > To avoid the drawbacks, introduce new configuration parameter
> > NVMET_TR_TYPES. This is an array, and multiple transport types can
> > be set like:
> >=20
> >     NVMET_TR_TYPES=3D(loop tcp)
> >=20
> > Also introduce _nvmet_set_nvme_trtype() which can be called from the
> > set_conditions() hook of the transport type dependent test cases.
> > Blktests will repeat the test case as many as the number of elements in
> > NVMET_TR_TYPES, and set nvme_trtype for each test case run.
>=20
> I suggest to keep the naming of the variable consistent, e.g.
> NVMET_TRTYPES.

I see. I can think of NVME_TRTYPES and NVMET_TRTYPES, and I'm fine with
both. If there is no other voice, I will rename to NVMET_TRTYPES.

