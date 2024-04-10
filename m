Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F95CD11C2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Apr 2024 05:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zOdy6FgVxIEvyRlcwLEmrC4JA70D+lunKIMv9EXWFxw=; b=4V0zU29Jp3Q0usCNt2MvjuO0uD
	Q7LAfUj9734iVoAA/9VwochIyaRSUcsmiQpxCMJ/BIjd8X5iwcpnceHjsvvRPBq1Gc6udv9kJmNog
	ypJt8P7f1sVuINVLCO3d3Xb2U+4vJ/SBJK+dP0upSdMxNZ2J8bka7yOdav2QI83qv3FxtdzlHvHjA
	uFpmNb4mbFfOD/YAry45BBCavg+TSN4U4q29sQ1OWAySzhGl6brcXSXm7B4IFWQ7kkLI394twv/F7
	AfR/KzCVVjYdV4Go7BUD2UkNZUfQV/s5h+JkTlbdrn4+lZeW6yR5MKYXZtyz8oH11Ja2n8Izx2MA3
	XVigoL8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruQZn-00000005D2S-2mtz;
	Wed, 10 Apr 2024 05:32:51 +0000
Received: from mail-sy4aus01olkn20800.outbound.protection.outlook.com ([2a01:111:f403:2819::800] helo=AUS01-SY4-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruQZj-00000005CyS-0Nll
	for linux-nvme@lists.infradead.org;
	Wed, 10 Apr 2024 05:32:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgESbiiRHo6wvSKi3mObJSPrIReFaRro0rjWNG2Y2meTdIsWpGLyeBnE5BTHLb25if8UeooE2zKKdFXPQ6+agiioL+klB85/QKURr6gG+2doMl0drQv80WahT9h6Nv4+n5UAiYn8ePxoERkQE2x0n/Nuw4/lqbgZY/iTGjCj5z0W/UmdLNQVuB82O0XYWFS3T8VHhZRhZyPSxSahe4TgyfYPIebWFCeykdC6Sw6dyPCaBKMTcnPqwNHOBg/6ZU0OPYK3kbzPWkQ6g8O4HHbMLb4kMZdYXq8Fltt82Rz0vTCnKURGA4ZiHVzQp1amkXdKiSfjQ8PBXDjubFRlZHebNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOdy6FgVxIEvyRlcwLEmrC4JA70D+lunKIMv9EXWFxw=;
 b=jksUy867EBlC3Pip/HMZCeQbNZeCXX6VZ3z7ZUEA09DTL8MYz3OEn0IR/IllS36oD2yFFvEJtNZonj+1BlUDprDrF+ycIzX13+sjg5rz6mZzv5t4NYMQ6oPg3ex21/SIA7X6E/LTt1rjm3uszBW4qKZ3IVHy99G1MikslEtyE3EEjvp9XEJtJY84CHzbO3igQcyc/7xtNzCsIdKZaauWDZiyXQ+Uq0sbVQFV/WRkAPNRqNaYEryDNehYZOACPTi6HNGv314TFBy3AMVCyCXkmoh5azEJB0kFB0GICwzWQWBhogslEUFlkbCg7EriSLIyAp6Ta8Gx9snt2B3IhXRzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zOdy6FgVxIEvyRlcwLEmrC4JA70D+lunKIMv9EXWFxw=;
 b=bx5zQk8yGjmOK80ejj7aBswvETiJFyEXxZpRX/WBzMay1uf+6HALPCsnoguxgFXJQdi62FaB49NPReER6qGmurLnt+xejvlePkfyzjNXiNH+3v3mtBlveyQWswKtRef/0CGGzl3LwiJDw2ZTPBHZMn5/KzX41P3ZdWxJP0hedPKZWXLT28dlrkW9QfmTtUPuLMA0HoTfbMFLJlQ/FNWsK6HHj70xi8uRIoRwRvENTXnMJFPC5PGRO+YwA+F7s7FPeC1Z7CGSI/fb+VeEK7zJVzpd8xaO+3SwP6onsb30+z1xPL1OFN0Gz4iMatyVo8OLrvLWBOEn+o1ZtTHJ++ghXA==
Received: from ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:108::8)
 by ME4P282MB1349.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:93::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 05:32:26 +0000
Received: from ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM
 ([fe80::9f2e:2acc:8692:8c4f]) by ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM
 ([fe80::9f2e:2acc:8692:8c4f%6]) with mapi id 15.20.7409.053; Wed, 10 Apr 2024
 05:32:26 +0000
From: Holger Huo <holgerhuo@outlook.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Holger Huo <i@holger.one>
Subject: Re: [PATCH] drivers/nvme: Add quirks for device 1cc4:6a14
Date: Wed, 10 Apr 2024 13:31:50 +0800
Message-ID: <ME3P282MB2481225B8B95249FB92E4981B5062@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>
Organization: DragonCLoud Networks
In-Reply-To: <ZhYCyuP6vTJq-TZq@kbusch-mbp.dhcp.thefacebook.com>
References: <ME3P282MB24818FA28E7C73BC01302882B5072@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>
 <ME3P282MB2481C1DC0506D154FA3AA3D2B5062@ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM>
 <ZhYCyuP6vTJq-TZq@kbusch-mbp.dhcp.thefacebook.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-TMN: [WD7fAMrRZTrpDIlyBlQqxLN64gu+CYWqbFWffEHJ+Vs=]
X-ClientProxiedBy: SG2PR03CA0100.apcprd03.prod.outlook.com
 (2603:1096:4:7c::28) To ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:108::8)
X-Microsoft-Original-Message-ID: <12416368.O9o76ZdvQC@arch-thinkbook>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ME3P282MB2481:EE_|ME4P282MB1349:EE_
X-MS-Office365-Filtering-Correlation-Id: 63c71ac8-011d-4ff8-cca1-08dc591f9b1b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7l4t8du0ijBPeZK3LfBQtF1RfInjSdCxoes/uocTmUWQxILN6mTBwnXs0fEaTCKLYRJz8cPbAykflebMSxLMnznWD+YpBp35eDQN7Ra/zDWU0MOSILmZlSnSc6YMMVsLQdA3C2onhRkSNQ0Wt7C18HVwUl6t5TV3YVdByCMg7QnjPwXHnN36qJ7noku+kIGPHdSA68ghnIfG8W8H5x8emR+RKBi3tGUMgJgMlxAQUlROZTZpZpytDs7TeDZ0mRVZftG20qLvOfkTKOhGCZO/OXlvEg1VK6qI0dKZSxhdifSL5RgFVxBqc3wH9wwro1PZ6igGVb7VissyVqdPIdTquINlXuemedP9kNTkCOC+6XCYJ/NPW9DA/Rch+5C2rckllfF401yb3bKZbXqvlkBh6uOaT4Bk0VRd9p0oAhIKk+qMNWXVDAzCts3XHHebi4xPnETL/Ddd9/N21UaRrxhdFVBvNp1VPrgCM9BHXLkkpSc5vLCUSN2Y5N5wHH01LYLG9XdoW/iBSoHCSrtxpzSdb31XtMpwBy/6N6du0Gr+2O/Y0CEYBA8LvZ7Gs/m/XY0
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YjU2TGZYR3h4dVRNaU1STDZqdFU1eWJuZm5WTHVMVTJSTjU2dnZiWTBrTjJZ?=
 =?utf-8?B?K3RGYXRTQm93RGtUNHFPZERsR0ZpWG02SXVVbEphUjJrWHpKRVpmYVJmbEtr?=
 =?utf-8?B?enpYQTZxL0hoSGwwQWpSWjJRWDBLTk41dUxEOEw3bmZLZHZnM0VITmdJM0x4?=
 =?utf-8?B?d2NlYkVwcU1oeFV2Tmx3SHRDSUk0THo4ajE4REJSWkxuZEtKakZ1b2hYckds?=
 =?utf-8?B?NHc5anJKWDd5b0k0SHhTRnB5UmtNMkZ3eGhQdzF3MXdjN3Yrb0VGb0hnb0F6?=
 =?utf-8?B?N0xUWG1DV1BPNG1mU0UzL1FJcC9UeVZhVzNHdzkxVXNoNDludzduSFZCNGMy?=
 =?utf-8?B?NkJBRmR6VEFNUHBNYlRRa08ybHFvVEVLZDdxb2dlSXl3RGUrNm5oK1M0RWRI?=
 =?utf-8?B?K21Xem03MUdSZndqQ3hIeS9TWnNWQVBVUkxUd3BJeVZjcGVNRmlnNG94NWJC?=
 =?utf-8?B?UkR4RXlCQ3kvOG85L0tEZG1lVTZzeURlY2ovTUVBSU9NU3dEOWh5d0Y5WE1a?=
 =?utf-8?B?dlc1L1hHV3JhWkgzZUVEdnEzTjdvTVVQaDRmNFlsM0llRVU3RS9mRHRCL1cr?=
 =?utf-8?B?UDk0Rzd0UTNkcTVCSHMvMWlYVFRUVHlaZ3N2ZHpCUmUvOEM0WjhzTWlxVWY1?=
 =?utf-8?B?TXpmam0yT200Q0JOMFU1V3FsczRnUmhsQVFaY1o0UGVzY21HVkdYWVZ6Z1hp?=
 =?utf-8?B?YTVHbE5UZ1kwQlRuQ0FmOUF1dWgvMDFUeEp6eEtOQXpQenlLWXB2SGdzaXJM?=
 =?utf-8?B?TDJhdkxBWjFkODB1ZWZBS3NJSjhYTlB2cHdsMnM3czgvdng0amp3OHhBNlRY?=
 =?utf-8?B?N3Urd3VWSFQwSnBXeEJCWlVzZndrb1Nrd1pPekQ2cXVOWmhZNEcwdWxXNXVt?=
 =?utf-8?B?bVloQlhLcyt4ZDFydnJ1YTdpTXdQMjFSTEtQVys2bC9PY3hKVXlFelhIMDRO?=
 =?utf-8?B?RXRaM3R2Kzg2dXA1MlNQUGFuYitKbGtsOGJRSU1GR1B4MktwQTVsV0tMOWxu?=
 =?utf-8?B?VEZ1MkJTRXQ0WlRWNzM0blo3cHV5aTB1blNGbmJ0cC9sUVl6YkorNmZlbHBX?=
 =?utf-8?B?RUdNUEN2aHhIdGVISGhybENrZTBZc0t4TmE2aDBkTlRSbURHM3htQWY1Qk5s?=
 =?utf-8?B?MWxKUUk4azBURjk3TVRFSjBHRHRJaHdxZkpOVitPOFpwcDMvVnlHSW8vUnJB?=
 =?utf-8?B?SHI5YVcwcDM1YU9JM1BGNTBGdHZLUTVhakdLcE9WK1hXUmFiQzRhY0htZWhw?=
 =?utf-8?B?K0tGRE00ci82RFlhb2FEZkxXbXFTdDdadWtxSXhtOUFZN2gzUWJnK2tNei8x?=
 =?utf-8?B?RW41ejBhRnVEd1VKejIrSTBub28rcUM3NWpHaW5qWU9oQkRXNm5HYkVRakYz?=
 =?utf-8?B?Q1orRDViKzBGT3VPVjVQZGRBQ0hMOWthUllEUUk1RVZFK1BxSkFJZDJxV0dm?=
 =?utf-8?B?ZTVLSmpNQ0VxU0YvTERIVnBsN0tHU1I4TzBScEd2SWUzdU1GMGdsRUowcEtB?=
 =?utf-8?B?KzgrcEpXNVp6VXFHNjE5TkpSay9zZ2dDUVRPcUJ2dHRUeHROQStVb3hyRXk1?=
 =?utf-8?B?VEZJS085Z2tPZDdCQ2ZVK2d6TW5aTW5hbG5vd0FzbE5FY1FhUEtGR05GTi81?=
 =?utf-8?B?VnNzTGwxS3VkUzBJS0xTbTdtVjlNSnRqcS9LZDF2TEtHTUEwWGRnckVHcTZt?=
 =?utf-8?Q?78USdcI8acaWTRHBdayh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63c71ac8-011d-4ff8-cca1-08dc591f9b1b
X-MS-Exchange-CrossTenant-AuthSource: ME3P282MB2481.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 05:32:26.8845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ME4P282MB1349
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240409_223247_138245_0116477A 
X-CRM114-Status: GOOD (  23.89  )
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

On Wednesday, April 10, 2024 11:08:58=E2=80=AFAM +08 Keith Busch wrote:
> On Wed, Apr 10, 2024 at 10:05:46AM +0800, Holger Huo wrote:
> > On Wednesday, April 10, 2024 4:14:42=E2=80=AFAM +08 Keith Busch wrote:
> > > On Wed, Apr 10, 2024 at 03:28:50AM +0800, Holger Huo wrote:
> > > > This commit adds NVME_QUIRK_BOGUS_NID for device [1cc4:6a14], the
> > > > Shenzhen Unionmemory Information System Ltd. RPEYJ1T24MKN2QWY PCIe
> > > > 4.0 NVMe SSD 1024GB (DRAM-less), which can be found on many Lenovo
> > > > notebooks. This SSD produces all-zero nguid.
> > > >=20
> > > > Other SSDs manufatured by Shenzhen Unionmemory Information System
> > > > Ltd are likely to face similar issues, but I currently have no
> > > > device to test.
> > >=20
> > > Are you using the most recent stable kernel and still need this patch=
?
> > > These quirks shouldn't be necessary anymore unless it's advertising
> > > multipath capabilities, and it doesn't sound like this one should be
> > > doing that.
> >=20
> > Yes. My current Linux kernel version is 6.8.4 by arch. After further
> > investigation I found these quirks truly had no effects.
> > But my nvme drive still freezes with Device not ready; aborting reset,
> > CSTS=3D0x1 failures and AMD-Vi: Event logged [IO_PAGE_FAULT domain=3D0x=
0001
> > ...] waking from s0 (s2idle) sleep. Are there any other quirks or what
> > that I should try
>=20
> I've seen the IO_PAGE_FAULT error reported before, but all I've heard is
> that it means the device attempts to access a memory address that it is
> not allowed to. I don't know why that would happen, though. I've never
> first hand experience with this condition, I'm just as confused.

Thanks for your help! I found this to be IOMMU related and I have to set=20
AMD_IOMMU=3Doff to have it working. This is not nvme driver related. Sorry =
for=20
making this patch.



