Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB90C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 25 May 2022 16:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a3ft370BvP9SDoMpnqAOBphdDbAmQ7UfqZ/xIafPAhY=; b=TdedZ9mCdt1gYYwPI1KxanWDyF
	DfWN7RF2Xq1c94ysWa8Ffzeq0NEP1XqF6JREJa1PCfm7HNOsESfO16+cdORR05xNQA3WFBl8X3sw1
	KZBRmYj7U9Zkhdd7Nen92CcByqy4QvAyoGXdhttfzTPnrfhcSzthSd0ni+WxHUysgEmQ/8ZvIO1FJ
	MtH9BmPkLClnuuHTR+C+7LtKNZzf9MC/ucV2maXx66fcW99dcM/aqtLkYml1rGR4te0iTrYO8dMm3
	wJcyYzlxu1WlErAaAl22tuPfXL3ORs/VGkuXkhqka3PpW6cPsT7dSGCQsgMd+jC9jNd+7Mk5taexK
	hb7xkxuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nttjF-00Bo3U-3d; Wed, 25 May 2022 16:19:21 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nttjB-00Bo2j-Hu
	for linux-nvme@lists.infradead.org; Wed, 25 May 2022 16:19:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653495557; x=1685031557;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=a3ft370BvP9SDoMpnqAOBphdDbAmQ7UfqZ/xIafPAhY=;
  b=c4BoInz6sXhA954t1uorvSr4OSKerhFglKY4DqUMELIHqgzGMt1ApknQ
   KzdnpIBG6P6K19HmfqB363Jcsry/Uc3v3/n6OakjEMf5Oaf0uuAe/g7yb
   QHYf8eRXyMFM4z7Mo3N/cpj7hGUEj3T3b/LxS9JO1o3Am7HtqyWTGKxnR
   Kii2p2O5bjXZWamnwhibMBJrViYPVGGLCoHp1BpHfbOqt4RPrET1h/co0
   SjffMZxlzQY3xy9MNUhLViGmp5nq0ZBfvw8Mldf0udLAFYzohEqqzoAon
   bXMeRiIoBO4/uiYcKBnClTMpkRVehoKAbWzzm7uYrpBCuOj4Jlenapssc
   A==;
X-IronPort-AV: E=Sophos;i="5.91,250,1647273600"; 
   d="scan'208";a="200199260"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2022 00:19:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PT8dMDwYilxKgj3gw2+dMSpycJa3D+z0PyXt408g9BctDymJ6LcQ/EdyXFumD3ASRL0yOf67kKFmmzQWX2MN86Pobt/+iSqKxky5e0VCTkTOVXN+9iRrSo0hHM1Y7h6O0gYq0bH2c2o93j/rbFAbmMB2tZm2R02srjtic4txpYAxCWGSpmEtOb1Y9/IM47EcGgg/QUa8vAv3FRWoeGx7ExuoBNblUE5NSPLH4fj7WAO+BI3NBvcYAYAF29Q66/qto4LXGMpAt22siQvU+Df09ZefYQXEaFy4vt1yunIt9q/jzkEHVxe/dD6ooxoyg9oTvRrcS8zHGNZjuA0oe2rJcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3ft370BvP9SDoMpnqAOBphdDbAmQ7UfqZ/xIafPAhY=;
 b=XWQsSSGXualnGleWqRF8RSChav46SjSQ/uImGxpebwzJpFpmZhX+NNgZu03NT3Rzjjpx3pkaDtZZPpLUL5uX/F8bslths6RyYMfddB0z93q4oHoozmp3Tj2m/5Ek13Esi5Dyj5lrEh1LWT0kSS2x9fHp4+Avn9F/Fht4ZQmZrXhTstitHIcz4zm8UryDviMvCn14/wj23pRJvE7yTLMVnnnUeWBxpfaXJb2tiPAxqF+cRVgV+4Ci4LqDTjSfBi1TTI2+xpm7IyXkkzRy1zvCsxn0dcX/Qd1l2Kj4w++QBJzEYKx357txbFbHAqfSJIkzp9lRjawvu/JOCACrF2ImAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3ft370BvP9SDoMpnqAOBphdDbAmQ7UfqZ/xIafPAhY=;
 b=iXIZuaS6ge93TQ7hvVUSJuAiK2u9CXcWiug3h7X68Zt/oVxhGHh2uY48+6NHtStIuqTD5g8Yzi+h184M6yEWnK+9YkMGiH4ecZ8uev2rKe5WMy8L4sGc0qzQu1/TRp9yqaoxhD+sdXHq45rrnyDigBx0XMHzBbdVBRi1ghNApg4=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by BL0PR04MB4675.namprd04.prod.outlook.com (2603:10b6:208:47::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Wed, 25 May
 2022 16:19:05 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::19e0:250c:79ef:1617]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::19e0:250c:79ef:1617%3]) with mapi id 15.20.5293.013; Wed, 25 May 2022
 16:19:05 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Keith Busch <kbusch@kernel.org>
CC: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: add support for TP4084 - Time-to-Ready Enhancements
Thread-Topic: [PATCH] nvme: add support for TP4084 - Time-to-Ready
 Enhancements
Thread-Index: AQHYbD/9MNxk2Gqn+EqHlnIVT743ya0nzvAAgAf+3IA=
Date: Wed, 25 May 2022 16:19:04 +0000
Message-ID: <Yo5W96ivET39WVXf@x1-carbon>
References: <20220518064040.3223894-1-hch@lst.de>
 <YoUEf5nsyhVzeDH/@kbusch-mbp.dhcp.thefacebook.com>
 <20220518150044.GA1359@lst.de> <YoeA1Lh9oxwyao2S@x1-carbon>
 <Yoeh8KyvZbOPOrqy@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Yoeh8KyvZbOPOrqy@kbusch-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 193aa5e4-b56a-4231-c866-08da3e6a49ba
x-ms-traffictypediagnostic: BL0PR04MB4675:EE_
x-microsoft-antispam-prvs:  <BL0PR04MB4675946867801D8573E3B5B4F2D69@BL0PR04MB4675.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  iDoc6i//GKVEcfveLj0oovDsFUBvFJqOsKXnE4gErlUaAO4RfmPwXjv6z8HcUWGOJNEFezoAJ1LJa32eKacFoNPTH8wsNbgtMVSaWvqljtyBf13gwQlbaekG/nhdaWxCaKePOT/q2G03Zsg7iG6+uk5j1KQKaAk2boZShBC3fvknFbC0oQgy3q11UfR+PonmOpNGXRvaUoULNRVZT7yWMzSNRmrLIzO+wdhgYUH2N28eQA04b/VbyoKrFryT4gLvcw5wNNxCHBGiZyFGEfmOLgHLb1xaUfjWhCBMlwttaKsiaYnl8Hg8j50wLWcNtn8SocNEe2WCOE5YTNTLCQHwQLpMjBVB0jp3XvPgBTeYiM3VMrKri9k/PLkoMdXAfKc9PpaLcJT/FtbBizINW9Om0zk828CV0k2zsy/fdBiJuVE4OgAm6EYjjuAuxCgV4xiAbDe2TwibQP1PgbwkoA8r7/8bFcfBmWuc2nntZODzFH2UxJeKzWGxGbQyJxMsS/I6xu3/yCxo89od6aPhXK4y8Nt8wc0OSBXKIrsmuqv1KZnA2EyAzMXvFz2BExJgIDU1WlEq9TuGubwOpQiCBPY9H4iRmuFl+fyRUNgoSSvwDC+MV6MmV26t4o2NqdHqt7VtyF5DzjiUoyPfvnf6skbcWWd3tE3esZdFqO+2+RcREFd4oV932qsZvp7LLtkfQL0V/qRotZfYyMvkHeZweG05NQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(2906002)(4326008)(8676002)(38100700002)(66946007)(38070700005)(5660300002)(86362001)(122000001)(316002)(26005)(82960400001)(64756008)(33716001)(66556008)(66476007)(66446008)(6916009)(9686003)(91956017)(76116006)(54906003)(508600001)(6486002)(186003)(6506007)(8936002)(71200400001)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?YjBFMGNMV1k2UDJCcXd4Q1haMjBicTY5WDdmTDlOY1pCZXpEbnFaUUZVL1Br?=
 =?utf-8?B?K0o1WWxOZ2RvYVBRTHNaRzdFc0l1bHFKYWs2QkMyVHNBOGhqUy95cVNwN20v?=
 =?utf-8?B?U3ZFdXRwQmN2VCttanhpc0N0cFBSVU5mRlUxU0hieTZFV3JyMnp6eEp2ZmNT?=
 =?utf-8?B?WEp6ZG1ZZldTNjhHeEJ4cWNxNU9sQkhtdWxia3daREx4N3g3MlNncUM5Y2RI?=
 =?utf-8?B?NFNaMFN6SHNsQTdmaEgrbTNDcFRZRWNQMFhwWGJVd3R1UmhLT0pNc1NzS2ZU?=
 =?utf-8?B?c3pPWk15bThTb0V5WTJzb0VRUHUyQXk1Tm9SZnk5eHFSZFdURm43VnZwQzRT?=
 =?utf-8?B?akVZS0RmYVIzcnYvWXVta2g4ZDZMNFNGd3JnQzNzZXNTWHQ5QVMxd3ZOSU95?=
 =?utf-8?B?QlZ4Q244VnVFUnNUTWNoM1REOUp2R3h1b1hXeDBTWXBrNzNJMFRzWjBJWllR?=
 =?utf-8?B?VW9rdDNhZWNmb29XRXFiOE8rWGlZQllUVHd4N2lVb2l2NjNTRG9QZVBtYmtV?=
 =?utf-8?B?WGViSjQzdmJPdTJTVXJQVU1HQVlLUlZhdUxoc2MyRGtHc0Z2dHhtVnFYOWJi?=
 =?utf-8?B?THg1SVNseEpIOVdSdXF5NmZIeHlFamJCNU1Ncm5ManpmSjBiYUhhdStFanli?=
 =?utf-8?B?MUlhQndKTy9wVnlQZmhSZnJOTm5hNXB4eVFMVFpHb1oyUmE5eFRVdmZJQy9y?=
 =?utf-8?B?c0IyVG9VQytmUnIyam82ZlhvbGRFc0ZsLzdmeEMvamdkbXlqOGtNNVRkalc0?=
 =?utf-8?B?R0hOR3dyUHZ6TFBhdGJINjNHek92UG9rUUR0c2lPOFgvOU0rczN3Rk1WMTRJ?=
 =?utf-8?B?NDkxMTRadk5vOWFnYy9nU2ZrSnVKalZtNVpjLzFMbzk2TXZWNi85enFyQ2ts?=
 =?utf-8?B?dDUzdUVvWHZaNnMrMitxOG5pTmh5bk1HY1ZldjJYZnZOSE1xUDlCM0hDOExO?=
 =?utf-8?B?V1FtL3R4cDN5TEdaUmRGOU9ZeEs2ZWw3YjZ1cEMwd3BZVDBlMndteGc3cVpZ?=
 =?utf-8?B?c2NDUUJ6VXIvdGFTeTQ1V21TMXRsdkwxbkg3ZGRxNDNab1dsdk9ibXdpdFF3?=
 =?utf-8?B?bmNvU2UvVGFPblpZemd6Z1pTdFk4a0JTUUEwVUZYSjhOZmVOL1R0a3lkSjB3?=
 =?utf-8?B?SmFpVFU2c05jUjhGdkxienA4M200Q2VsYTR2UjdQbUhDMDFjblZEMzBxR3Ni?=
 =?utf-8?B?V1NLc3ZpYW9qMWNIUlhzWkJOMy9JcDZkZ1E3MjJ1N2x5eEVKWlJ2VHFQdTk0?=
 =?utf-8?B?QU51NXgvci9adjhtYjBlY2J6NnNqeU9kMFJFaTNpSldOY2kzNDlwcHVsc1Fu?=
 =?utf-8?B?a3JjZDV5eW1iK21QSjFxMnJDZ3U4ODRscjRSeldBYkhLWUxsdCtYOFZ2ZUNn?=
 =?utf-8?B?SnMvcGZSSkVPUFJPZkJ1VmxIUlVkb2NCUmxkTHZxNTl3L2NUSU5tOHJNcGg2?=
 =?utf-8?B?b1hZR3VEZHExT05VdS8wMUxhWFdSZHR2U3VEdGtuemErT0EwcXh2QVFZQmYz?=
 =?utf-8?B?eFJBZHV1aTJqNGVQS3dpYmI0QVZYTnRzQ0FmV2FpenVLNXB3a1JzVEV4OTdT?=
 =?utf-8?B?VE52MGhVVzl0SDhxQjhjY3BHYTZBUHB4UHNCK0dWM0ZPZWFUU0ZpZjNhb0U4?=
 =?utf-8?B?Q2M2YWExN2UybkRyemxBMWFKY01EdWlCNDhvU2QrWG9tRUwvWTZsZHdVRlB1?=
 =?utf-8?B?VEViQ3h3TTNHRFFyVndPbTB5NndxVXFlby80VGFaNU81QTc5UXZsMXdKaDVK?=
 =?utf-8?B?K3M2cCtsZzZXdmk4bkdBT0Y3anVqMmx4ck12OWE3V1VtVVA2bmQvcmhIcVhJ?=
 =?utf-8?B?TTl3eUF2UnprUXcwbXgxTTN1aStJb2tYR0ZBWGlubUQrdjV3RnMwTDZVblZn?=
 =?utf-8?B?ZG52c1FHblB4UjZSRlFPcUZ6bWtLcVNERWJ6T1BCcEx3emRHVFl0SmdaM2dx?=
 =?utf-8?B?NS9PeGl4ejExUG13TlBoaDUweU9Va1ZDdXA1Q3VPYXl0aFZUaGgzOXBPR0NW?=
 =?utf-8?B?T1VvMnU5QXJ0L3R5OFNJejdyR3cyVXNjblZkVVJqMDFMMVhrd280bGdzRDFW?=
 =?utf-8?B?WnhXL3RITW5mSmFRWDZDcnFPV3NrRFhNWFhqVEV0aW1sejZtT2U5UWdwM0Nq?=
 =?utf-8?B?UjBlSTU0elpJMmZRSXNJMWdhM2crbXI0UXdhbm1ZUTlFOHN3MnhEazgwQkhM?=
 =?utf-8?B?MVkydmJQUmNHZHJiUzRPMldMZjRPNDRGQW01QjF6Nmd4aENDMlJPWlFtQzRM?=
 =?utf-8?B?bGZldFNJdFRubDZ0NjNtUE1RdHlCanJIZjFGSW9YdHJ6a25wYlY4ajNLT2ZB?=
 =?utf-8?B?MUlTWTdybmU4akNIRitpRTJLbWxJckNpU2EzRFVrMU1CUDQrWUpUNmhtNUlO?=
 =?utf-8?Q?ke0icDiYYRoEjySY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CB0170B391F4D44A6C5C3579F9684BC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 193aa5e4-b56a-4231-c866-08da3e6a49ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2022 16:19:05.0154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Po2p0U1VhWIvH41JAXJwb5OveE2oGZiGrEUC3tO0kvqJa6gmAx8nT0pV23LHuCd2EGouAwNLHhKKGcWCWxUCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4675
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220525_091917_913169_291E1C1D 
X-CRM114-Status: GOOD (  24.65  )
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

T24gRnJpLCBNYXkgMjAsIDIwMjIgYXQgMDg6MTM6MDRBTSAtMDYwMCwgS2VpdGggQnVzY2ggd3Jv
dGU6DQo+IE9uIEZyaSwgTWF5IDIwLCAyMDIyIGF0IDExOjUxOjQ5QU0gKzAwMDAsIE5pa2xhcyBD
YXNzZWwgd3JvdGU6DQo+ID4gRnJvbSB0aGUgQ0MuQ1JJTUUgZGVzY3JpcHRpb246DQo+ID4gQ2hh
bmdpbmcgdGhlIHZhbHVlIG9mIHRoaXMgZmllbGQgbWF5IGNhdXNlIGEgY2hhbmdlIGluIHRoZSB0
aW1lIHJlcG9ydGVkIGluIHRoZQ0KPiA+IENBUC5UTyBmaWVsZC4gUmVmZXIgdG8gdGhlIGRlZmlu
aXRpb24gb2YgQ0FQLlRPIGZvciBtb3JlIGRldGFpbHMuDQo+ID4gDQo+ID4gVGhlIGRlZmluaXRp
b24gZm9yIENBUC5UTzoNCj4gPiBJZiB0aGUgQ29udHJvbGxlciBSZWFkeSBJbmRlcGVuZGVudCBv
ZiBNZWRpYSBFbmFibGUgKENDLkNSSU1FKSBiaXQgaXMgc2V0IHRvIOKAmDHigJkNCj4gPiBhbmQg
dGhlIHdvcnN0LWNhc2UgdGltZSBmb3IgQ1NUUy5SRFkgdG8gY2hhbmdlIHN0YXRlIGlzIGR1ZSB0
byBlbmFibGluZyB0aGUNCj4gPiBjb250cm9sbGVyIGFmdGVyIENDLkVOIHRyYW5zaXRpb25zIGZy
b20g4oCYMOKAmSB0byDigJgx4oCZLCB0aGVuIHRoaXMgZmllbGQgc2hhbGwgYmUgc2V0DQo+ID4g
dG86DQo+ID4gYSkgdGhlIHZhbHVlIGluIENvbnRyb2xsZXIgUmVhZHkgSW5kZXBlbmRlbnQgb2Yg
TWVkaWEgVGltZW91dCAoQ1JUTy5DUklNVCk7IG9yDQo+ID4gYikgRkZoIGlmIENSVE8uQ1JJTVQg
aXMgZ3JlYXRlciB0aGFuIEZGaC4NCj4gPiANCj4gPiBUaGlzIHBocmFzaW5nIGlzIHF1aXRlIGNv
bmZ1c2luZyBJTU8uDQo+IA0KPiBZZXMsIHRoYXQgaXMgcmF0aGVyIGNvbmZ1c2luZy4gSSBzZWUg
eW91IHN0YXJ0ZWQgYSB0aHJlYWQgb24gdGhlIG52bWUgd29ya2dyb3VwDQo+IHJlZmxlY3Rvci4g
SSBob3BlIHRoZXkgY2FuIGNsZWFyIHRoaXMgdXAuDQoNClRoZSBjdXJyZW50IHBhdGNoIHRoYXQg
aXMgaW4gSmVucydzIHRyZWUgaXMgYmUgZmluZSwgc2luY2Ugd2UgY2FjaGUNCnRoZSBDQVAgcmVn
aXN0ZXIgYXQgc3RhcnQtdXAgKGFmdGVyIGEgcmVzZXQpLCBhbmQgbmV2ZXIgcmUtcmVhZCBpdC4N
Cg0KSG93ZXZlciwgd2hpbGUgcmVhZGluZyB0aHJvdWdoIHRoZSBzcGVjLCBpbiBOVk1lIDIuMGIs
DQozLjUuMyBDb250cm9sbGVyIFJlYWR5IE1vZGVzIER1cmluZyBJbml0aWFsaXphdGlvbg0KaXQg
c2F5czoNCg0KWy4uLl0gSW4gdGhpcyBzaXR1YXRpb24sIHRoZSBob3N0IHNob3VsZCBzZXQgdGhl
IGNvbnRyb2xsZXIgcmVhZHkgbW9kZSBieQ0Kd3JpdGluZyB0byB0aGUgQ0MuQ1JJTUUgYml0IGJl
Zm9yZSB0aGUgY29udHJvbGxlciBpcyBlbmFibGVkIFsuLi5dLg0KDQoNCg0KUmlnaHQgbm93IHdl
IGRvIG5vdCB3cml0ZSBDQy5DUklNRSBiaXQgX2JlZm9yZV8gdGhlIGNvbnRyb2xsZXIgaXMgZW5h
YmxlZC4NCldlIHNldCBDQy5DUklNRSBhbmQgQ0MuRU5BQkxFIGF0IHRoZSBzYW1lIHRpbWUsIHdo
aWNoIHN0cmljdGx5IHNwZWFraW5nDQppcyBub3QgYWNjb3JkaW5nIHRvIHNwZWMuDQoNClNob3Vs
ZCB3ZSBwZXJoYXBzIGNvbnNpZGVyIHNwbGl0dGluZyB0aGUgd3JpdGUgdXAgaW50byB0d28sDQp0
aGUgZmlyc3Qgd3JpdGUgc2V0cyBldmVyeXRoaW5nIGV4Y2VwdCB0aGUgZW5hYmxlIGJpdCwNCmFu
ZCB0aGUgc2Vjb25kIHdyaXRlIHNldHMgZXZlcnl0aGluZyArIHRoZSBlbmFibGUgYml0Pw0KDQoN
CktpbmQgcmVnYXJkcywNCk5pa2xhcw==

