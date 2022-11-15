Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC52FC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 02:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=p/CmrD8W9mRCL2ew71gJI2eHPCTScHEoGtSayXHczk8=; b=zeBRmUPJdnVT1ieGaVsChsEEn5
	hHgYvdzeO8mmpejyuVnEG4K+cjOb6nsfwknBEkJuvEi1WlwcjRFa6b4Wcdw7IyCvSUmJEjM2rOzoT
	1NP/MzDJE83+vuaQ5RzTYTS4tnfveNOJqqZ/NeM6t7+IPkZ4uW0xg24ft4d+sPbdXb5UQSTpkmPND
	jXm3v1NlHYamC+eS2PJAQlEyILRgI21U1XjV1MHyESuQI2/Qpk43d482u1uO3y8bwPofSdTqvYX+l
	PrjN6Y6pbj6Te2YHm0pCaLy3G+pBYoAumjK6JKhMJ4DGE07fJ0Ni3CGBXv4o88Brv59mMIRvQrWFw
	t3LX4L9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouliD-006qBT-Rr; Tue, 15 Nov 2022 02:30:09 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouliB-006qAt-90
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 02:30:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1668479408; x=1700015408;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=3asaWzA/awmOgHN8MXKLMPl7rEUtbhptrI5EF3zU0wM=;
  b=MDLz1ATcPRbm1a5tkwltCYtxwao1PMEgRje2p3UuT/VEKtqUhDLREzpX
   BLzbh9PEIu3nbIaSowuc8N1J/9ws1aa16EkhbohPcJmMewlNJNked4tnn
   Mq2TbRpcYVLlVP/JTEZ07nFWq1JHgeD/edcVZ7Y3BnHCkZN99QWchr0X2
   YzYi8/0HLt4rfgaOa+6yGYfhPJwuPwu7ZAvfhhnCpR448kQPzMYHrE+tN
   5H6mRlNaSNzBQCFbWwVZrPgV2hXtJhZ8GqbjQmRfdSOJp8PXLJIwLnugC
   CBtkz8UzL/k0a/RygNvm+7B4HvJwbhP8MwsxrJp+74TMmBijdWfgsN05+
   g==;
X-IronPort-AV: E=Sophos;i="5.96,164,1665417600"; 
   d="scan'208";a="328374780"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 15 Nov 2022 10:30:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPT9PqehlqfI0tnh9DOEOCZbCp1iv74GW5gVaoomLBeyYn1wrOa6WG0t9iXc8W6k3+rUsEPyisqHzCNZJNXKvv0e602ITWUfuLztVdza628AkSnnaEeRuWynXW83y+9tCYPHjygVD4dpFrOUQyKh3nDjdO1AwDPrKHnyK57uHmcGsc1/37xSDX44vjUvevvrmTtE2hKvqZdEkF/GziUW/yyF2lDkb1XSpRncJhQl25Xgf2khRGEjdRW45lUhruB5MS+MU0WFi7HyuBIMXXM9v98b7IL2IdUedGZ81K7QqnHgi99TEKOdLm0ff7qf2b6aoKN6zz0V5iAuDrRw713BIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/CmrD8W9mRCL2ew71gJI2eHPCTScHEoGtSayXHczk8=;
 b=jNLVMjfWOXx/4/jOC6JA5F2k0xUM/+wdRnCs0wja+mpzoEDcdhQbOdkhzVL3qezUuj2n2ID3cfv22JhndU7hd1SzkfJvqEq9fblHmlfRcZyLohy3SmJqWpuZyp5vcs39WRGuIWYJHcXgCYM+8DzZinPw3/f2HvljCDJ7JUcuLoq51YPWU8xTWxbSUJiYgU+BkIey4HWfHFseB6T832Zpl43s3YhEy1v8FJ0+QrNeiDn+c19rF2kq+bh9KuuJDNsO5j3hA7LwqO7Xg0LfAPfoatnn5SfLOJCFchFRZiweJduBQ3fclvC4M40PoAfSaKJnZe+TeqWR7WiItikc5PGJ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/CmrD8W9mRCL2ew71gJI2eHPCTScHEoGtSayXHczk8=;
 b=PAdka/5ijE+WliRPcduaB/OlxTWsKj9e+pRDhIZkISGjq+3sAr3yD2VPTPHEEPeRR81WMOe4sk6kr/zj4CH/bcLaeNvg4O4yN1GgWNuFRNyLEcUzFGsMzRHFd6LyQ00vr+latPakN6bjnOMOVhYEep2ZypH8f5ja/1geyH42C/I=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7151.namprd04.prod.outlook.com (2603:10b6:a03:292::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.17; Tue, 15 Nov 2022 02:29:59 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::d4b9:86e9:4fc8:d6e0%6]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 02:29:59 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "alan.adamson@oracle.com" <alan.adamson@oracle.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>
Subject: blktests nvme/039 failure with kernel v6.1-rc5
Thread-Topic: blktests nvme/039 failure with kernel v6.1-rc5
Thread-Index: AQHY+Joo+0qmAtlReEOjnYEBNEp0Tg==
Date: Tue, 15 Nov 2022 02:29:59 +0000
Message-ID: <20221115022958.ycu7i46vler2n6xc@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7151:EE_
x-ms-office365-filtering-correlation-id: 2a6ffacb-dae7-4742-34bf-08dac6b14b10
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  FVSGWZVJV6tqP9bClcrtnLm0QloBIiygUCdrvUpL1AW05Ot+ZGzvVB9vv+8XxZEUdVGUl1vzu8gmITii49UAmbySGGnOeQ2S6NpDMmjNqlvdJ66xN0Nyf/3uQNk4RI/lmaei3eJFyWtvmuZmDfbI6lIFkuYjWB0h6XiARx+SrTvwGpccekpl8YoUq0gAZD4+b6a+grhk/uP+BXZbKyuSdrfIk8UPeYoVp0ktZuvD7MAbD+vZHNGJ9lfhWAwEc1bwuVpFOgxq6PKjWBazamZed6Ctld4eEpkPX85ThmrjJuG78COC8kAB3Iql2GFFfoqZepb3oIQWDSfc+t/oAQO2w0+CZRFRYYp1QNOg/5OWYCxetOnIYbf+dHLAkUap8MBFfRacFnuyj3Ay4HGvG7YH8R7sa435+EGjq50DuJle16MgI1bt9OkWBWcOzra0kABsLCnlMkx4ZicRUtWqQBgLpml7uWz+3aHi4tuxVWOangk+BGctVUy+/GDotb2bF/5k4k9Kc/Pc/LjLjMuB/RKSYm/1DL7CJrclO2rumOsDL2epeycxiLCXubF74R1wtQAfb0Qa8V1544HsFkv93i2how+QK4BFfeCiq2p2JEGZUxnu5ARRcFl7nME/7YC3DduOvnTSPp8nAT0I6e3nmXNFltGaHueAKodd4Dm229vjLKN0TYZSRdrZFFf60zNcgjvMmjNjVcntaEHK4Ae82WP/YK7wVx7fDBqyfRKCmh/Vs0wDW4i9oilMgsqTBRU4MN6R/WrdLbp6M5wppESnHrMn0A==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199015)(478600001)(71200400001)(6916009)(54906003)(33716001)(38070700005)(6506007)(6486002)(86362001)(316002)(82960400001)(9686003)(6512007)(26005)(44832011)(91956017)(66946007)(8936002)(76116006)(38100700002)(41300700001)(66556008)(8676002)(66476007)(64756008)(4326008)(122000001)(5660300002)(1076003)(66446008)(186003)(4001150100001)(83380400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?YIwq7S9BZtboZAFjQUW7Ir3ltFCt3YgtCYUjYjQPrYRyg5J5hEBy5mtiSwvi?=
 =?us-ascii?Q?RsnWmf9GlTWgLNdM5181CdpfYTwq5f6u8p0Hc3JSqjhceYzzmWXKT3cA4Wfx?=
 =?us-ascii?Q?x5/z39Xqt10znaqR1+H8g3x9jDNbHQU4nL/GkbvuzV1Q2bALhlTl7Z6FAsT7?=
 =?us-ascii?Q?XEbLpnQIB9pRit7cTKGnRrefYbaOTiIYM1tSeLIHk1k27V6Z1qnHu711IunE?=
 =?us-ascii?Q?QrzMMJJ1eqokPP09baRpxZrmIaSsAjGxPKc0AbMisR2jvaBqB7W4yh6yycwK?=
 =?us-ascii?Q?kKxOI9y6tdU4xLT8DVuRebJ4sYyAD/NSzDQp0kQpQWBELC9TvG36N00tbNHq?=
 =?us-ascii?Q?PpkPavSMcjMkucPOJ0bt6z/9FYxA+rkj26oMqHH0CCuz/2JUw+wcok3OHAHp?=
 =?us-ascii?Q?47n02CYWCnLV92GKhMx/8ZLVODRo/GMHkXtN0KuLKQe2eLlrmGzJ09C51fV9?=
 =?us-ascii?Q?Tqf3/G46bdUWbrOI7QcO25DvRDvprLTmnhWSWBq67dtkCPbBIhwm9J8v9xMR?=
 =?us-ascii?Q?DiLll23dDEzHv9ehnyvji8W01NAmf7CBk/XnXkrtXPHhKb7nwKR4HX2nypYO?=
 =?us-ascii?Q?+9zZmkuOAr12QBgT2bdMNpnpMFUeKrg1xFKYufM1+3cG30ZJddEYR9Lb3Sd9?=
 =?us-ascii?Q?Q4iyupKgxit42cHNms2JaI4zMrLkQujM1dL46c0uR/ajCFfKpLfe5yvFeZ1U?=
 =?us-ascii?Q?Mx/4W0tByeg5g6bsmjHlfXLFpk5Qo8FzcUEevdcU2Sh7gwf3aNd60x6fywl4?=
 =?us-ascii?Q?7XZbVyo84ba3ymQf+6i9TBAXT/BNQ+q9GoGpAb5cxkPpQKjVJEt5SAXvP6fm?=
 =?us-ascii?Q?owB8moc663E1A7yrRfrl1n0WvzIZypjPRTsDHmIQlAV6PFOC7hMv9n56680Y?=
 =?us-ascii?Q?QyyQbf75Gg8/vDCEypjNwa4NheKad7teqsJJ6xKHMSrLhUICAHUwFfcldu5m?=
 =?us-ascii?Q?9sbkWw3jj5iXmhLfBNUNY3lQjJtBhvUms5kSwxB6GegTiYOIzS9xCpngtR4/?=
 =?us-ascii?Q?VAvhu3SAHWYsYWoI+halV7a3bw/wVcU/Q6PGHCvB+qJkvq+kxNiHCr7X3SVj?=
 =?us-ascii?Q?J7lW3YlooJLKIS5SNevEG9YKACjtKn3brwCf3Y3H1Ndemv+1/mz5VXV83yQU?=
 =?us-ascii?Q?f+NCHqgiYgxzoV2Jz6JKaF8wgQs3+Gg07IFERSafjLPhER9NW7tz9jgRLfyt?=
 =?us-ascii?Q?cBNwlEobJfKFLYtXIhEGNBaxSl+LK/InQn10byg0zm5PpLASQPBPEK7QWJaI?=
 =?us-ascii?Q?VVmadVnNcW4Gz9jLCRkGQqL02bqapIuJ0Cm+r5yaz0sSyoi2ExM+i8ehkFBZ?=
 =?us-ascii?Q?8LEXmcSlSx0HPVDR5opv25qMxDN8WqFUES3mHYka/+VjB/GiJnA9JbrDzKqK?=
 =?us-ascii?Q?2m3rF6WQPmcPoN42AwXiGmg4GJheCYbiDdLgSFIRjYEA9GW9UK7S2t4kyX0Z?=
 =?us-ascii?Q?1UFOuB/UYlAVOsdRy8QvLSrAiCJ7geERnREb+TwbXZvQ5V+bRPZZwWj6Pj7f?=
 =?us-ascii?Q?OWInSZc5/nANqJs1DftUYnvz33XyHzKx+pAm6/BrlraCNEJeknVIacQhFBaf?=
 =?us-ascii?Q?YQoSCmILaElO99tAjEDreJUi5nz0PUpg1Uo2Pw6ZwrU6MLajx9iXclhOh488?=
 =?us-ascii?Q?r14jBIckBmBYYLjCn/m+zyY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62907CEF04285D4E8D47C929412F48D2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 	SjOzAG4WIfApYu4/IVdb/eTIrFxw0MNCMRvWamqo1yA4diugf3yHoolMMJP842pY258mqtN+pTynC8kDND6iMr9vPRpBjpl8o4BS9wC1mJ+xninI5fWI2bOiuYaEncsIAObLO+m4JOmlYlY+Q3qS576IzKbOfu/3j1X+Wv+XcGbbEafjCEfpygqWOY7DSIavUYTODaapWaHK03fZgHUP20GwkuEQ9kztUpBQOTMCEj8UG6Ea5UNRSe+6FIbYmi9NJWXf8g0VvSBT6ZrXbhE5q5NsP+lA0rwCCSM9bVGh00rLc2xXP2zKeTL1myd1nlhJ95WFjbMWfGkC/ovdJvLCfGsb+WvB26BuSN55kRToMDuruMZ4lqJsr1DfG9b8uEeTnWBwls+jbKJIjzY0xx4pkzkXpZP1wIEthD+c8++e0GaB8MURX2r8Wewk3ZNapOmJ3S65gw2V580aTAtAEfw+i4GjqGaVxQGoeZs3UmHQZzzmzm+d9luhBsYErrmntJbxU8Uiy0EJ6I5/3H0oVjRSto+4IMBjJ+Q9+h7lABaduFyvVFW//OJOWc55HRhc6TxhnwVuPGxbz/kkUolITJ30gTPH8+AGKHRSvfZnjB9wNZknLJk+aPwjAiiA9qs4nhEfaB3AVGJF5j4Y0Ogaf1zaHWcXSloIn+fd0BhykFvw51crBEtlToyo6gTyKSW3WnZX9AGYSATkqpmmf2zyZiTQ6zTg0dhpq39mJFqmWxHRBvTr0aiNi84/mUi8Hok7K8KvWth1O9vq4TITrQ7HNrINQp5UTjweVTtOHUt2f5x+/fOOuBbVjfSJ88oJ3G97qm/Z1Fo/xr/I8y3K1del6aodKZsjHeL77o7xHdDzIPaN2uo=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6ffacb-dae7-4742-34bf-08dac6b14b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 02:29:59.6742
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: egIFPjugRGHNtBaCoBu4n4/u6oX74qnl4bkBxV+Vq0sIRjj6BLDBgov6bdKdlGBsRqaOpsug/cRotHRS4IdN6IClmLmo5ZGtpesBXdIAo9o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_183007_570175_FD4DEB70 
X-CRM114-Status: UNSURE (   9.21  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I found that the test case nvme/039 fails with the kernel v6.1-rc5. The tes=
t
case tests "nvme error logging by injecting errors". The failure message wa=
s as
follows:


nvme/039 =3D> nvme5n1 (test error logging)                     [failed]
    runtime    ...  0.402s
    --- tests/nvme/039.out      2022-11-14 16:40:48.598495709 +0900
    +++ /home/shin/kts/kernel-test-suite/sets/blktests/log/runlog/nvme5n1/n=
vme/039.out.bad      2022-11-14 17:14:05.387628216 +0900
    @@ -2,6 +2,4 @@
      Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x8=
1) DNR
      Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR
      Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR
    - Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR
    - Unknown(0x96), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR
     Test complete


I checked changes in rc5 and found that the commit d7ac8dca938c ("nvme: qui=
et
user passthrough command errors") triggers the failure. By reverting the co=
mmit,
the failure disappeared. I guess the test case needs modification to match =
with
the trigger commit.

Alan, Keith, could you take a look in this?

--=20
Shin'ichiro Kawasaki=

