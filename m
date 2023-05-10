Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9304CC7EE22
	for <linux-nvme@archiver.kernel.org>; Wed, 10 May 2023 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dAUpi3dTxz0YMNo7RtsiZf0aVapCl3pVk5TsbeT2w6U=; b=hnPJ6JioBKxwELSbDZfm3twajf
	4xJXMwSvS/W7IOvijP6Gv/6Jo7Hj7LOHvk+GkVNiZJorg5zgYjlm6fjLwaIgMmPbXyz0xuKROOoCt
	W2sljFcEnufAydftXTDtAKueQgipB0wGmC/Z+Wy/1lNZ01GwY5cjPX3FqpDcMwT4oUhsE/eCqOgqR
	ad2uy0gh8NUgpT+p0+mqYcS4dWXukf11G/k3GYL1OawO+v6cT3+H/lA2wPTlWDoVgJDJz/g7BQ2f1
	IWRTjLTa9MbXuIBWwlbHolX4+R7pAEocDU7bnYygV4Sp3/wwg5Ga+xEa+Gcvw0F/6dgNul7UWKxRi
	M4IojBCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwmOE-006XHH-0p;
	Wed, 10 May 2023 16:10:06 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwmO7-006XGa-1i
	for linux-nvme@lists.infradead.org;
	Wed, 10 May 2023 16:10:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683734999; x=1715270999;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0JdVKVH59TBhzb94GQJqNZQRRLLX/6R5USpLBGM5VP8=;
  b=LnL83XxU9ZXvSyREvKLluOOY/QkjyM2uV+FwREq1N4mJrB+9V5/QKH7T
   +N/1D0EK/PPccC8/289ZBGT9GO5BK/TRYLq+VbSfWn4FXR700nCxTjl1g
   9H+9VYyTfq0oG83e/dVk9o7iFx+4ua1mD9YWFzlSAJw/oHDmzJy9FN99y
   HffuaNSQrNPZPkUTGqoiFrYMym4fj8OlHkAzvwMif4QiI6CpXMK/2LyUd
   3MpXG7+jDHh2ngBVObfB4+iPOOmGXoezc6ayp5tQttrI2Hno2rgV6Gxi9
   7D4cngU0t2wo3vQp2qYedin19Duq+Th/+LhpVTnHa9JrZXEQnbNdsC9IR
   w==;
X-IronPort-AV: E=Sophos;i="5.99,265,1677513600"; 
   d="scan'208";a="228549501"
Received: from mail-bn8nam04lp2045.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.45])
  by ob1.hgst.iphmx.com with ESMTP; 11 May 2023 00:09:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9nWrlBf3YPFf7mpVe+inNoaPqCvQUbS5vOuOBpak79qbXtQVe4DLaow9+MQTOsM2IE1kq8D4bU64HCyF84fR9ZS4EUuezXgDxqztCFQEGe+ZYIu5Aws96K4Px4yRN52KEMxyokVlexVw1MAaHOkBAD1rP9yBSgPXnaNSIbD2Ycd2Yaghv9Kf4DUPmN8eLYEi/njFwEmEEl/MSsbPfYiXGU5Ttz8nuEKSYPxkPNE3ItPHFz3JaQUrWow/oUAKLED7wE1CblmiYxAhVuxGiY6h3Td0Rb4HBimTv1AKkW2yYKxEcUXgqDwrZaPhdzpYuc4o2h4E0JXTEOVBS95CF1XDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAUpi3dTxz0YMNo7RtsiZf0aVapCl3pVk5TsbeT2w6U=;
 b=Rp8un1wI4CayX425GKbL3lIiTNKEEixedKKgUBQUHm+SMlw9CC/blOqKHD2NOcEhV8ZxTYqd6guM+T6xhJeWAiHSZ9lGFJP9B1VOTiOXLduY8hjRGNnt3ZwDYBp8WiFvAOEX0oeds+Soum32GzEl7EKAD4X+ZMsAoDiR0auKBvQb/q/SJGIwQjP9zJUNqe+PLW91ZqxQ9MIqE71dQqC4N/IIrkuTRk/8E9b7gvAMiERMbW/4oKWwNmDFFEQS/I/AdLnOKMeCrAyJj8T4dE44uyBo0ui9sm5FJcLUOXEbqkbhGH6YFRjaz0ZCGUKJQtiIfyjmN1+meRYol35jSuf/Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAUpi3dTxz0YMNo7RtsiZf0aVapCl3pVk5TsbeT2w6U=;
 b=GBA6JBoUpAKMqrX9pCDQslbdYVQkIC9yHSOI21QN+k+Nz4M9EJuAOI9IzOWDmcY3iG2Fc3vM+1wygAYaiLA6n70yRFqu7wGfZYrBK+LQR/aFtynwEpf0gxemWV5yzMSden3Whc7DsZFY1K9qnGGD1ZbmyqtxUqIPcAdPRfdlmwU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL3PR04MB7929.namprd04.prod.outlook.com (2603:10b6:208:338::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20; Wed, 10 May 2023 16:09:51 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%6]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 16:09:51 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Max Gurtovoy <maxg@mellanox.com>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvmet-rdma: Suppress a class of lockdep complaints
Thread-Topic: [PATCH] nvmet-rdma: Suppress a class of lockdep complaints
Thread-Index: AQHZgn4Rs1M0AvndvUq4yG9OZZfZr69SecAAgAAN2ICAAA4rgIABGPGA
Date: Wed, 10 May 2023 16:09:51 +0000
Message-ID: <3mo7ptzamxuwbg67xogmqy2mey7evrcby57oiejiazds7h7xz6@7d6gvypprr5z>
References: <20230509135615.2061227-1-bvanassche@acm.org>
 <ycdptic5i3aerzpzml7eitzb7wn7wj3vwk3bric2ogus6m3uaz@33zh62c3mmco>
 <a7458945-5187-ad13-e75c-bfa6966c5e44@acm.org>
 <8355cb08-08fc-d3c2-8fba-520d294ac38f@grimberg.me>
In-Reply-To: <8355cb08-08fc-d3c2-8fba-520d294ac38f@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL3PR04MB7929:EE_
x-ms-office365-filtering-correlation-id: abd77451-f3ea-4463-a248-08db5170fc8c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  ppJLomsNfaPIgyn+dPRfTRqIGMR5MLOG5vm2oGAvZZxm4dbdRfD3sHTV9VtXI6SV7JUxgszaxRjEqVYLZTTMH5cjKxpmDLm7wS/5Z7SGok0ntDj7AePPUwuTN0gczKZq3jnGctsrA9Mz2T0SDraKJzGfv+FJO6Ook61dMVU6e98ACrE5k0t6S2XHxScvL1MUbVF+3+AaeM4E8vZOXIZ1IyQRjVdUs4zrURsgggZ/CgHTAL09sYpIfTNn9mVTEWSr2aTXDw7g8d0Cj3FOV5hL8+HLwnrbjxoCtoWUPa/qbhUs1QI8MZCcGSGN3E5b8K9at7ABCpbG9gAvG7U2EOvcru+bvgEZz84B6zY5ts1m1pjjoJUU3pMBlf2dwKZ69IQg2SzBM09o60SLbR5y2pDNa2cusoz5xyATL1EGvZlsmRvNIzNDpDMCXfwofELar5HbsNaHa438CDXwar6w3i3o7zayuT/CDGcrbAlEwzSNuDE3bca7ZGz75/DD6CT7dC1vle/seBpQS0gPLwP1a4mAJf2uhn4bdrGsJZ6jZ06JYfEAtaud6oARU/MZ9hz0abFfpJaNhtHITQY/NhWI8ykVNPRzMEGa5q3pKl8YKQNYLevkv+PdSzW1qfC0OuCmAx0s
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199021)(83380400001)(33716001)(4326008)(6916009)(122000001)(38100700002)(41300700001)(38070700005)(82960400001)(8676002)(316002)(8936002)(6512007)(6506007)(9686003)(26005)(6486002)(478600001)(66556008)(76116006)(66946007)(64756008)(66446008)(66476007)(91956017)(5660300002)(2906002)(86362001)(44832011)(30864003)(186003)(45080400002)(54906003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?vDzRsLir1CQaYCCdpLUex3QDfQog+cZtl7BQEF46YjH59+ln0DvK4nsXBHHL?=
 =?us-ascii?Q?MIMdqrf7dk079Rl9sqXjbSt9fAiW8T6ONAOBYRaX6CcP/Um0fBt5mSXnUQvl?=
 =?us-ascii?Q?rEfZgsw3RLelD9bchkIKGbMBZcnDlrrOqJsWDwT0M0d5P1vkLJHFDyl4G1RS?=
 =?us-ascii?Q?nUWkB48QD6uWvuUXxcBACYtC7/gVD1qmG8a62K19bqI6oFg7W2VrsNbG3sfW?=
 =?us-ascii?Q?zhxWpcjBNrAUZZmmOETMMl6NVZn1od0Cev51PUMrcRnfpe7BGmAhurefPP7O?=
 =?us-ascii?Q?o5yzNsOoMdMYkA5iLr7n2DAqSeHBjP+sdh6hWHevJ0qjT0SvsqBEt8laFHGf?=
 =?us-ascii?Q?7F0t9M1FQctgPw6zQclfFkAQOtV6suh19F5gPZ0uXmRRo6Ik39ga/Z5BVvu0?=
 =?us-ascii?Q?oUY/rggBKo2PJVR9eQEjOovyp0hjpXauHrjNxYDrdpqqzXzuKOIj6NR+0zrT?=
 =?us-ascii?Q?l33StfdUKXruN8KSdMANvcybnxn22IaRCwBepbMnl7Gc9/0ELufXxkSE9Jt2?=
 =?us-ascii?Q?p/1mypt6hZTqoMVd3pCgsykt2R0CEWXVPTsuMo6QOAVtCBrvFxghiQof6vDP?=
 =?us-ascii?Q?ksXLr9CaWncA2gWyFAuMCXEZLPaI6RHOvfXRPpa/NlyZkTKtz2AUrbpTgr5N?=
 =?us-ascii?Q?gZvj39BO8IFamqI41+dS5iiRKKhj28uN8ePH0H+6dH+Y3oG5dqhnbDA0CrLN?=
 =?us-ascii?Q?6MHwylthSG/TmAudipRhKGVCVhwpuP8TWImmj2bJgXu2QKrLq1o99BTKTMXG?=
 =?us-ascii?Q?09wX7STvNAhx3phfEj6QBMdupC+ljxP7t6fXTrEvzBIAKujyx5zONg/T9aHL?=
 =?us-ascii?Q?xVEHwIux2gvieEckzL9Kjr5akUcRYTKEyVxg4oO2VeQgoJJELyNXV10zvRly?=
 =?us-ascii?Q?zpKRcY3+F39UjeAq+YeNBapuMAhVgvRFiQHkPC4dYphTc4qRqPeadjtD7U+H?=
 =?us-ascii?Q?EegYGNxse+gyLrz04pHrT5czuv2FEbhwUxy7T4LHZGVK1IhocGAdDzez95ZB?=
 =?us-ascii?Q?0S7nBr6dQGnAuhiebSMHnE04wosQSFmivFlGskGmE4qni2y8PpjlfRtY/Cs7?=
 =?us-ascii?Q?JUQZG8hFBNukyp4RPOFa1xmGkhk7+6fT70abmKCVGbfb2unPmtag7rFp/IqJ?=
 =?us-ascii?Q?THoohQCLaN1aGnkRbA0YYdt2SJ3vKfgthpMhbyhYRdfcmHoOLinVck1kXQ/B?=
 =?us-ascii?Q?CoLGlaBwLRWHdKzGMQlTPNZ25FLR66JOuX0JjN1Zjinaq29w4SXS/YCsNgla?=
 =?us-ascii?Q?FyLZeYYY5L/c83VFjQigu5OdOtbT8L2pOE+LyTvAWzYJ16ulu1SVEIUYnFbD?=
 =?us-ascii?Q?dvn4iCahKPHeDl6APUDmzI6HVWr/okxStboH8wccAGSyuFtuu/nfHdYUOyf2?=
 =?us-ascii?Q?4dC0PuOfzYSayNdJSYo+vp+sK2peSVwetCimx9IS9o9yQn5vLLxuDVwNk5uK?=
 =?us-ascii?Q?CQteqvDGhGGIrRd4oCrBaYYMlLSIzOwkHHGQe1y+8j+W81p9HtFjovk2IvLa?=
 =?us-ascii?Q?3zcQMzrM8pfPvHq6YJUMJa0Eh/ud65DEDGKte4rVRosJEWMc1doy/KzhTnlU?=
 =?us-ascii?Q?hKub0RvQ8TK4NhPwmKoC1wvzgbZyunRaWFU8IWSdn18MSMP8nakdF05i9kM4?=
 =?us-ascii?Q?QA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E40ADACB683F644AFB3DD901C8F344C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	=?us-ascii?Q?wJqFdalgkZzk0fi97hq1SgBzGG5Am5DuJxBQ/ep54pEETl3g0P9c/+e067ok?=
 =?us-ascii?Q?E9pHN5ynpaviYjIGZs9Y+0Ibryg7PjcqCwj4gOcke4aoSTQ+GZ6AvmEcZi0S?=
 =?us-ascii?Q?jsQWC6aJ6kKpFk0GRolkDt/pWu8Rvw3//1WCDpQ6XGnYdHa1bFPnuerthexB?=
 =?us-ascii?Q?3E82KUUJvD6Z82NIJ51CWIenoQeJUW1fcBZ4WnmK2+2isdYFgIv0OdZrJcUA?=
 =?us-ascii?Q?VyTo8DGzmhX4MTNjsIxq9IQt+4zXRHQsNc9Tt7MIJk8leoDaDVemr3o37GhT?=
 =?us-ascii?Q?61YglR6OLPbtqNHIWQaEf1p41Ics+4i1KPsfbXmQb068SdCSBc+GR0HFDhqh?=
 =?us-ascii?Q?5Zpt0KQr6GWYxVRZu12xidZ6ZtZ68AgOe+mnlmFovbCF5+kTb2yJmcxeyT4X?=
 =?us-ascii?Q?zluAY4f0lWwC0V24ZTn0ak7Q4MRpJDwMf/d0DL3PpYikj4i4g4DXwSfWt/zv?=
 =?us-ascii?Q?9/uAJ5I3mbmjqFCsKVntakrJuadfsZFlqNgdC+MvX1xJbZfBi7EYCWqX8/5r?=
 =?us-ascii?Q?FFkXLi3MKl2qM72/0FplAuMkOweZSAovVbz3pFXp4EYWSrOkKCpcnIWpLXdz?=
 =?us-ascii?Q?PEOhRC5q2FveDyrOOl05xq4bj4gFlm2BATgj8UNf0C08kGEAyBtz2UewiaKp?=
 =?us-ascii?Q?fTn0/pEZl7F7V/507nzEfbqLZLuyHE9OLA+OcjIFa60sk29NPf6gmXAVZi0W?=
 =?us-ascii?Q?kE0J0v1RK2dlSL2q8sJ74PnRMdunJ9ApNhUc4mepG1gMgambIli6yyNZ2kTN?=
 =?us-ascii?Q?Iz2sRGiRnkO1VJNleGtaUEciL+dXW+pCjWiq8hvIZUJr2uWV6MC7+5oQN5Fh?=
 =?us-ascii?Q?3fGcEBr88Y7aTOxz4k7Rb0LPvP1wbZ8PbVBHnrHLfN5Wzp0SD/SWhaMzimVg?=
 =?us-ascii?Q?wBXvjb++62P1L6Eh+i8sisCGGNn4ggUc1f6Ti3cMqEpXk1ywE+ds2t9dGxIG?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd77451-f3ea-4463-a248-08db5170fc8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 16:09:51.8185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhQVKzkycz3Y8SzkcpVXSmuxrlhgLPtpH2mMWjB8QSIl9V1TKqNRs57Ztl1RncYoiFKG0D8jOY/WS1LILXvQOWOvfGhmnQTG6FtRxThsRH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7929
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230510_090959_768655_4BE63322 
X-CRM114-Status: GOOD (  29.17  )
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

On May 09, 2023 / 16:24, Sagi Grimberg wrote:
>=20
> > > Bart, thank you very much for this immediate action after the
> > > discussion at LSF.
> > > This is encouraging. I applied the patch on top of v6.4-rc1 and ran
> > > the test
> > > case with various transports. Unfortunately, I observed kernel
> > > panics with rdma
> > > and siw transports [1][2]. Also I observed another lockdep WARN with =
tcp
> > > transport [3]. It looks that your fix unveiled more hidden issue/s.
> >=20
> > Please use siw instead of rxe when running blktests - there are known
> > issues with the rxe driver.
> >=20
> > Please apply these patches on top of kernel v6.3 instead of v6.4-rc1.
> > The hrtimer_interrupt() crash shown below is a v6.4-rc1 regression and
> > does not occur with the v6.3 kernel.
> >=20
> > Since my patch is for the RDMA transport, it is not clear to me why a
> > report for the TCP transport is included in a reply to my patch?
>=20
> Agree,

Sorry for my misunderstandings. I've tested again with siw and kernel v6.3.
Still I see the kernel panic. Here's the kernel messages I've got.

[   59.567730][  T935] rdma_rxe: loaded
[   59.614648][  T915] run blktests nvme/003 at 2023-05-10 08:48:26
[   59.714402][  T948] SoftiWARP attached
[   59.801368][  T969] nvmet: adding nsid 1 to subsystem blktests-subsystem=
-1
[   59.810654][  T970] iwpm_register_pid: Unable to send a nlmsg (client =
=3D 2)
[   59.813025][  T970] nvmet_rdma: enabling port 0 (10.0.2.15:4420)
[   59.861254][   T61] nvmet: creating discovery controller 1 for subsystem=
 nqn.2014-08.org.nvmexpress..
[   59.869998][  T971] nvme nvme1: new ctrl: NQN "nqn.2014-08.org.nvmexpres=
s.discovery", addr 10.0.2.150
[   69.939259][  T982] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvme=
xpress.discovery"
[   69.963920][    C2] ------------[ cut here ]------------
[   69.964368][    C2] DEBUG_LOCKS_WARN_ON(1)
[   69.964382][    C2] WARNING: CPU: 2 PID: 825 at kernel/locking/lockdep.c=
:232 __lock_acquire+0x28a4/00
[   69.965436][    C2] Modules linked in: siw rdma_rxe ib_uverbs ip6_udp_tu=
nnel udp_tunnel nvmet_rdma ng
[   69.969849][    C2] CPU: 2 PID: 825 Comm: kworker/2:4 Not tainted 6.3.0+=
 #5
[   69.970389][    C2] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.2-1.fc38 04/01/4
[   69.971100][    C2] Workqueue: nvmet-wq nvmet_rdma_release_queue_work [n=
vmet_rdma]
[   69.971671][    C2] RIP: 0010:__lock_acquire+0x28a4/0x5eb0
[   69.972090][    C2] Code: 08 84 d2 0f 85 52 22 00 00 83 3d 42 c2 18 04 0=
0 75 b4 48 c7 c6 20 17 ce 85b
[   69.973525][    C2] RSP: 0018:ffff8883aef09ce8 EFLAGS: 00010092
[   69.973980][    C2] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ff=
ff11075de1370
[   69.974565][    C2] RDX: 0000000000010003 RSI: 0000000000000004 RDI: 000=
0000000000001
[   69.975155][    C2] RBP: ffff8881215bc108 R08: 0000000000000001 R09: fff=
f8883aef3084b
[   69.975744][    C2] R10: ffffed1075de6109 R11: 0000000000000001 R12: 000=
0000000000002
[   69.976331][    C2] R13: 0000000000000000 R14: ffffffff8755632c R15: 000=
00000ffffffff
[   69.976922][    C2] FS:  0000000000000000(0000) GS:ffff8883aef00000(0000=
) knlGS:0000000000000000
[   69.977576][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   69.978063][    C2] CR2: 0000563bf892e000 CR3: 000000012eb74000 CR4: 000=
00000000006e0
[   69.978651][    C2] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   69.979241][    C2] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   69.979830][    C2] Call Trace:
[   69.980074][    C2]  <IRQ>
[   69.980290][    C2]  ? lock_acquire+0x1b7/0x4e0
[   69.980641][    C2]  ? __pfx___lock_acquire+0x10/0x10
[   69.981030][    C2]  ? __pfx_lock_acquire+0x10/0x10
[   69.981402][    C2]  ? update_process_times+0x158/0x1d0
[   69.981804][    C2]  ? __pfx___lock_acquire+0x10/0x10
[   69.982192][    C2]  lock_acquire+0x1a7/0x4e0
[   69.982528][    C2]  ? hrtimer_interrupt+0x100/0x810
[   69.983794][    C2]  ? __pfx_lock_acquire+0x10/0x10
[   69.985043][    C2]  ? hrtimer_interrupt+0x339/0x810
[   69.986262][    C2]  ? kvm_clock_read+0x14/0x30
[   69.987449][    C2]  _raw_spin_lock_irqsave+0x47/0x70
[   69.988673][    C2]  ? hrtimer_interrupt+0x100/0x810
[   69.989922][    C2]  hrtimer_interrupt+0x100/0x810
[   69.991111][    C2]  ? __pfx_sched_clock_cpu+0x10/0x10
[   69.992319][    C2]  __sysvec_apic_timer_interrupt+0x146/0x3f0
[   69.993581][    C2]  sysvec_apic_timer_interrupt+0x8a/0xb0
[   69.994853][    C2]  </IRQ>
[   69.995882][    C2]  <TASK>
[   69.996900][    C2]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[   69.998122][    C2] RIP: 0010:lockdep_unregister_key+0x105/0x250
[   69.999323][    C2] Code: 7c 08 84 d2 0f 85 29 01 00 00 8b 05 75 7e 19 0=
4 85 c0 74 02 0f 0b e8 6a e7f
[   70.002306][    C2] RSP: 0018:ffff88810ad67ca0 EFLAGS: 00000206
[   70.003521][    C2] RAX: 0000000000000002 RBX: ffffffff897afb78 RCX: 000=
0000000000001
[   70.004921][    C2] RDX: 0000000000000000 RSI: ffffffff85ce0fa0 RDI: fff=
fffff85fa7100
[   70.006259][    C2] RBP: ffff88812da24ae0 R08: 0000000000000000 R09: fff=
f8883aef45c2f
[   70.007590][    C2] R10: ffffed1075de8b85 R11: ffff8881215bb280 R12: 000=
0000000000000
[   70.008924][    C2] R13: 0000000000000246 R14: ffffffff89939550 R15: fff=
f88812f5c3118
[   70.010209][    C2]  nvmet_rdma_free_queue+0x2e/0x390 [nvmet_rdma]
[   70.011363][    C2]  nvmet_rdma_release_queue_work+0x3e/0x90 [nvmet_rdma=
]
[   70.012535][    C2]  process_one_work+0x7e4/0x1390
[   70.013568][    C2]  ? __pfx_lock_acquire+0x10/0x10
[   70.014594][    C2]  ? __pfx_process_one_work+0x10/0x10
[   70.015661][    C2]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   70.016745][    C2]  worker_thread+0xf7/0x12b0
[   70.017730][    C2]  ? __kthread_parkme+0xc1/0x1f0
[   70.018687][    C2]  ? __pfx_worker_thread+0x10/0x10
[   70.019645][    C2]  kthread+0x29e/0x340
[   70.020517][    C2]  ? __pfx_kthread+0x10/0x10
[   70.021427][    C2]  ret_from_fork+0x2c/0x50
[   70.022323][    C2]  </TASK>
[   70.023111][    C2] irq event stamp: 3790
[   70.023976][    C2] hardirqs last  enabled at (3789): [<ffffffff85a00e86=
>] asm_sysvec_apic_timer_int0
[   70.025311][    C2] hardirqs last disabled at (3790): [<ffffffff85907a9a=
>] sysvec_apic_timer_interru0
[   70.026609][    C2] softirqs last  enabled at (3158): [<ffffffff832483be=
>] __irq_exit_rcu+0xfe/0x260
[   70.027887][    C2] softirqs last disabled at (3151): [<ffffffff832483be=
>] __irq_exit_rcu+0xfe/0x260
[   70.029108][    C2] ---[ end trace 0000000000000000 ]---
[   70.030101][    C2] general protection fault, probably for non-canonical=
 address 0xdffffc0000000008:I
[   70.031556][    C2] KASAN: null-ptr-deref in range [0x0000000000000040-0=
x0000000000000047]
[   70.032794][    C2] CPU: 2 PID: 825 Comm: kworker/2:4 Tainted: G        =
W          6.3.0+ #5
[   70.034045][    C2] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996=
), BIOS 1.16.2-1.fc38 04/01/4
[   70.035360][    C2] Workqueue: nvmet-wq nvmet_rdma_release_queue_work [n=
vmet_rdma]
[   70.036559][    C2] RIP: 0010:__lock_acquire+0x2481/0x5eb0
[   70.037617][    C2] Code: 0f 83 a7 03 00 00 48 8d 1c 5b 48 c1 e3 06 48 8=
1 c3 e0 3f 7b 89 48 b8 00 00f
[   70.040455][    C2] RSP: 0018:ffff8883aef09ce8 EFLAGS: 00010002
[   70.041629][    C2] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ff=
ff11075de1370
[   70.042955][    C2] RDX: 0000000000000008 RSI: 0000000000000004 RDI: 000=
0000000000040
[   70.044233][    C2] RBP: ffff8881215bc108 R08: 0000000000000001 R09: fff=
f8883aef3084b
[   70.045519][    C2] R10: ffffed1075de6109 R11: ffff8881215bb280 R12: 000=
0000000000002
[   70.046855][    C2] R13: 0000000000000000 R14: ffffffff8755632c R15: 000=
00000ffffffff
[   70.048148][    C2] FS:  0000000000000000(0000) GS:ffff8883aef00000(0000=
) knlGS:0000000000000000
[   70.049519][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   70.050776][    C2] CR2: 0000563bf892e000 CR3: 000000012eb74000 CR4: 000=
00000000006e0
[   70.052120][    C2] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   70.053428][    C2] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   70.054774][    C2] Call Trace:
[   70.055795][    C2]  <IRQ>
[   70.056779][    C2]  ? lock_acquire+0x1b7/0x4e0
[   70.057890][    C2]  ? __pfx___lock_acquire+0x10/0x10
[   70.058980][    C2]  ? __pfx_lock_acquire+0x10/0x10
[   70.060031][    C2]  ? update_process_times+0x158/0x1d0
[   70.061089][    C2]  ? __pfx___lock_acquire+0x10/0x10
[   70.062128][    C2]  lock_acquire+0x1a7/0x4e0
[   70.063114][    C2]  ? hrtimer_interrupt+0x100/0x810
[   70.064133][    C2]  ? __pfx_lock_acquire+0x10/0x10
[   70.065138][    C2]  ? hrtimer_interrupt+0x339/0x810
[   70.066153][    C2]  ? kvm_clock_read+0x14/0x30
[   70.067127][    C2]  _raw_spin_lock_irqsave+0x47/0x70
[   70.068136][    C2]  ? hrtimer_interrupt+0x100/0x810
[   70.069135][    C2]  hrtimer_interrupt+0x100/0x810
[   70.070114][    C2]  ? __pfx_sched_clock_cpu+0x10/0x10
[   70.071129][    C2]  __sysvec_apic_timer_interrupt+0x146/0x3f0
[   70.072201][    C2]  sysvec_apic_timer_interrupt+0x8a/0xb0
[   70.073246][    C2]  </IRQ>
[   70.074097][    C2]  <TASK>
[   70.074941][    C2]  asm_sysvec_apic_timer_interrupt+0x16/0x20
[   70.076012][    C2] RIP: 0010:lockdep_unregister_key+0x105/0x250
[   70.077089][    C2] Code: 7c 08 84 d2 0f 85 29 01 00 00 8b 05 75 7e 19 0=
4 85 c0 74 02 0f 0b e8 6a e7f
[   70.079842][    C2] RSP: 0018:ffff88810ad67ca0 EFLAGS: 00000206
[   70.080983][    C2] RAX: 0000000000000002 RBX: ffffffff897afb78 RCX: 000=
0000000000001
[   70.082242][    C2] RDX: 0000000000000000 RSI: ffffffff85ce0fa0 RDI: fff=
fffff85fa7100
[   70.083498][    C2] RBP: ffff88812da24ae0 R08: 0000000000000000 R09: fff=
f8883aef45c2f
[   70.084767][    C2] R10: ffffed1075de8b85 R11: ffff8881215bb280 R12: 000=
0000000000000
[   70.086040][    C2] R13: 0000000000000246 R14: ffffffff89939550 R15: fff=
f88812f5c3118
[   70.087312][    C2]  nvmet_rdma_free_queue+0x2e/0x390 [nvmet_rdma]
[   70.088457][    C2]  nvmet_rdma_release_queue_work+0x3e/0x90 [nvmet_rdma=
]
[   70.089629][    C2]  process_one_work+0x7e4/0x1390
[   70.090651][    C2]  ? __pfx_lock_acquire+0x10/0x10
[   70.091665][    C2]  ? __pfx_process_one_work+0x10/0x10
[   70.092698][    C2]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   70.093717][    C2]  worker_thread+0xf7/0x12b0
[   70.094656][    C2]  ? __kthread_parkme+0xc1/0x1f0
[   70.095592][    C2]  ? __pfx_worker_thread+0x10/0x10
[   70.096533][    C2]  kthread+0x29e/0x340
[   70.097392][    C2]  ? __pfx_kthread+0x10/0x10
[   70.098286][    C2]  ret_from_fork+0x2c/0x50
[   70.099170][    C2]  </TASK>
[   70.099941][    C2] Modules linked in: siw rdma_rxe ib_uverbs ip6_udp_tu=
nnel udp_tunnel nvmet_rdma ng
[   70.107198][    C2] ---[ end trace 0000000000000000 ]---
[   70.108252][    C2] RIP: 0010:__lock_acquire+0x2481/0x5eb0
[   70.109319][    C2] Code: 0f 83 a7 03 00 00 48 8d 1c 5b 48 c1 e3 06 48 8=
1 c3 e0 3f 7b 89 48 b8 00 00f
[   70.112125][    C2] RSP: 0018:ffff8883aef09ce8 EFLAGS: 00010002
[   70.113284][    C2] RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ff=
ff11075de1370
[   70.114588][    C2] RDX: 0000000000000008 RSI: 0000000000000004 RDI: 000=
0000000000040
[   70.115899][    C2] RBP: ffff8881215bc108 R08: 0000000000000001 R09: fff=
f8883aef3084b
[   70.117205][    C2] R10: ffffed1075de6109 R11: ffff8881215bb280 R12: 000=
0000000000002
[   70.118517][    C2] R13: 0000000000000000 R14: ffffffff8755632c R15: 000=
00000ffffffff
[   70.119840][    C2] FS:  0000000000000000(0000) GS:ffff8883aef00000(0000=
) knlGS:0000000000000000
[   70.121226][    C2] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   70.122449][    C2] CR2: 0000563bf892e000 CR3: 000000012eb74000 CR4: 000=
00000000006e0
[   70.123791][    C2] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[   70.125131][    C2] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[   70.126462][    C2] Kernel panic - not syncing: Fatal exception in inter=
rupt
[   70.127873][    C2] Kernel Offset: 0x2000000 from 0xffffffff81000000 (re=
location range: 0xffffffff80)
[   70.129488][    C2] ---[ end Kernel panic - not syncing: Fatal exception=
 in interrupt ]---

