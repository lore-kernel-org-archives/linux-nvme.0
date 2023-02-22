Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50521C6379F
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Feb 2023 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ypgXpsCk+1vV5miVOoqVumWN1r1BAIlma6rj4MkX6CE=; b=XmnFym3eaGdS9JyTwpI9YxGh7/
	L0zZAqpdb5sFjdPXXZYP2l/Phv7uiomsmPLyyhLuuDNI8TxLMLAA3caH9lp6pxkECRijjkoEGGjHW
	R5nS9gWkOUit+UTX7Gk9AbmD9E7eWq4k6f/aZgs1fT/B/iTH80K0dhIYr4wJFsa6L/H663lmRRxaj
	O0/DMSBKeRbN3yvlq/mYUX0OfLnmcVF93EILExJ06n6KDVmdr4o9w/ngFX6Nrm0MExr5YN0nhHxP1
	GHCLKi42LlOvfk2LPazC2sgSG7TvqoFnLxnG0TW53zIF7wUI4kA/ZZJuWm2/egXFmdCFZacGxfHP/
	oRDbLHeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUmd4-00C3DH-40; Wed, 22 Feb 2023 10:45:42 +0000
Received: from mail-db8eur05on20720.outbound.protection.outlook.com ([2a01:111:f400:7e1a::720] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUmcz-00C3Ah-JU
	for linux-nvme@lists.infradead.org; Wed, 22 Feb 2023 10:45:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GarYPx7EDQeJLXLe8GVF2opYHMIjc69KXGC/XpQ3LqLC8Kd3zsGejyW8aS27V2/vy1ytP7x+3rS1CK69q6zFJaB1X0Ou9wbvT9mdjnGBqOZg6ftTaGp6fvqklV7PRO6J9jqglei23LsRP6S0cFNgauppPI6tIVlD23oo6ELS32OzGPTDhhR48PrwJuM8oyG6luX6L3Mktd9QPA6xLp3oq2oBAd9ZhCM++bcskDo7nY8jFENsBb13rAaBWEpPT1nyjO9kNfKyGRg4kWQBNEzDfCTqLLLMgHE4NQLRMKA6C6gtkWODx/imD0ctSR0aF0buFu3N9H7JXaJ0pgX7RKSwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypgXpsCk+1vV5miVOoqVumWN1r1BAIlma6rj4MkX6CE=;
 b=jsI7HpVymnwBv57oFFN4sKSx0JUTJ+Sza3Z0K+MnYiP+pHdP0WObo0hb8KQ8f0hfTwEvUj00fx3GV/ezkhl/kVPl8GYTM+BeQeYmqzj7tL3DRuEcsNVCTeEBr+2Z98kf0PlBvm+uyeufV7aMgPjc/JPPveFYY2di4Wjc8I98hprDlZUSRcJ7+Xfvpco2GyaO948xQXs2llgXex057t/PCFFrUZRrTdn8J4qGAbQuYmFwkRbUoauv7o58dIkvB0tYWmKwie9wu24Cj2XRke+lP0RyRRygDfQUmulMgxolXTDbdvrY4kYpqpBLy7FU7cCMoygLldrqPTgo4e83nzCJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=edgeless.systems; dmarc=pass action=none
 header.from=edgeless.systems; dkim=pass header.d=edgeless.systems; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgelesscompute.onmicrosoft.com;
 s=selector1-edgelesscompute-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypgXpsCk+1vV5miVOoqVumWN1r1BAIlma6rj4MkX6CE=;
 b=BQ+SEtrUuuOalybWDdxPceWqu0Vm4q6C5trHOJhiT5/ibOUa+42XngkWC7/CtWag+DmIzuE+F83hWLZB+luR2RdK6f1GQmbtS7tov4ZUrjQY6R1wojbmMuUFTieuBAnyFsdV7TdVIOZJcLbbLt8gk0w/e4Y+e1GCaGWKkJXgPmE=
Received: from DB6PR02MB3128.eurprd02.prod.outlook.com (2603:10a6:6:1a::19) by
 AM9PR02MB7057.eurprd02.prod.outlook.com (2603:10a6:20b:270::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 10:45:33 +0000
Received: from DB6PR02MB3128.eurprd02.prod.outlook.com
 ([fe80::4b7b:21bd:6058:8763]) by DB6PR02MB3128.eurprd02.prod.outlook.com
 ([fe80::4b7b:21bd:6058:8763%6]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 10:45:33 +0000
From: Nils Hanke <nh@edgeless.systems>
To: Christoph Hellwig <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "nils.hanke@outlook.com"
	<nils.hanke@outlook.com>
Subject: Re: [PATCH] nvme: bring back auto-removal of deleted namespaces
 during sequential scan
Thread-Topic: [PATCH] nvme: bring back auto-removal of deleted namespaces
 during sequential scan
Thread-Index: AQHZRkMYu0WQZfCzfkyHvlhtPcNtC67ayQGA
Date: Wed, 22 Feb 2023 10:45:33 +0000
Message-ID: <342BB919-6896-448A-A110-B0D248188EFB@edgeless.systems>
References: <20230221222307.557935-1-hch@lst.de>
In-Reply-To: <20230221222307.557935-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=edgeless.systems;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR02MB3128:EE_|AM9PR02MB7057:EE_
x-ms-office365-filtering-correlation-id: 7df588da-0f95-4d4d-3ce7-08db14c1eccc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  FNLWv+YDFNfpGNU3bpEBJhpABDi48voKFFNzkyN91MiWWWAiMrvGf57VGrEEP3k+a3HugSqMuPaQxsQxlakQ7cFqaNH9j5bu1IDOSOcB7HG1Og/K/Vv840hgkNA4VrCiZmjJ9wQ23Hhs1uyN8WJp0UAo9lWiKQ9tb/kuAkX5VVQcyO72l+Mz++RJ7D9caqRwXrzp+oevOdhMN2EJTH6MOR0xLTZmHFrOp/3Gl3XU1qMDgjlP0cmlplX5BzqD0bXjRy06h2vm4blnbmQtT51bBze5KR4N0+1HSDkkR+ioV3mMZT1+nWFUsLlLRh85q6fEFC5araPrXmD0fwHnrxSE6KWAfZ/mao3cvxQYaXKmyN/u7um9kH3wvDJwbpKJyEaHIzpipKQsDRBi02ptyIc1YCJOwrwcjnH3djj9eP/p92j7j2+au94gLOG93hvetO8BsOfZsW+yJfyKrwIuguEJDCy5ebHDEZy0nPyTdOLZPIkAAFqWybblWePPtm3gcpWLwlFR5gSwddSdaU4a+R3DzkdSTv3JoDW0Dx1roN2sE6oGOZUZw+4ofFuihzMsAus9wcZ7vEIgO69FhSIiBREDpGotMfA36JgUzzlrnDaETjelhIzdNdutUXAi9jsnzTCtLaeaSBpAt7VcZ8abEBzsoi+uKkv/yUFhffeFyBLG+sj3OoTHbugoRV3fM7CE89UwC9snAugRhc9Re9ac3Ac4xCAPlJ85iwkvr2Vqay+ta9bINk7NIC3EHS7Vqq61myiz
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR02MB3128.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(39830400003)(366004)(136003)(451199018)(478600001)(71200400001)(122000001)(38100700002)(86362001)(4744005)(2906002)(33656002)(38070700005)(316002)(54906003)(41300700001)(8936002)(83380400001)(5660300002)(8676002)(66476007)(66446008)(66556008)(76116006)(66946007)(6916009)(4326008)(64756008)(91956017)(186003)(6486002)(26005)(6512007)(2616005)(6506007)(46492015)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?a4q1GEuSC52yzZE7QheAuxLSvY0NGo24NPNo6L017BWVY5dg5abc84fy0onR?=
 =?us-ascii?Q?IkvCzixbjXp2xyL6RZqIYZrH3PbVazD0bKDiE6C7Cg8Vh0X+r/rANMia3dPb?=
 =?us-ascii?Q?hiWToJcnCuSNehPiGGGNDvbaPicxKN7OWrszwXKUUoTTEo/QkwuLub5344nt?=
 =?us-ascii?Q?GDgxzYt5cSCSeUZmfsXOFpcQNEZapX6w532dDAhImozdiRXOrJRp6BKBZ4Qs?=
 =?us-ascii?Q?4C0esc8LB0KS2pfXrL0eEk4I/4tRoUtOw1mRs1GnNYRbptW8PEuf/ssk3/Hx?=
 =?us-ascii?Q?ZjJPUzoBEg5lx6B1AJnjAUup+KODQDsTKUs1gkPTzGxV2yJeg81GQIKl2im3?=
 =?us-ascii?Q?+SpIHiZbTDGXtbUUA1/Cou54aP+BN8hJmqQlX6CNkeJfYBNaMfxZ2m+NA+xO?=
 =?us-ascii?Q?4Qcg/SxEMn/x8MZyhgRSyadjtXNDT44itBAyRmtJKNPnACHfk5k8fi1oVeAm?=
 =?us-ascii?Q?N94cb8yIlvKQOIXfAd/kYzOKjmI/VRbNTT1h0rA/xa6bfH6HjWx4K41i4v7T?=
 =?us-ascii?Q?rYD2uCKR8Naq+vcJj1JTf+PVSyKcsMNZpyXiZAS69r2s2CXr5+2+rdFoyMFZ?=
 =?us-ascii?Q?1Gu1LaaN7yxL7neBHVVc3E/pI/vGDktSRxAJrf67e9zSsnPPoacc+R+DLQRI?=
 =?us-ascii?Q?jsYO22Sqb/SDGi+z97bWamwtITpGRycTeZtNpinTWa5ghOn5WFwbKAwIFpKK?=
 =?us-ascii?Q?xy1c8JWUW/IQt1dy7V4Ls38IyGMu+gumX2g5FQcbLfHRxZdf0uqEwXbLmmrJ?=
 =?us-ascii?Q?q/hbc7E9IgyvpMU0/4BwPNAgFlhXAG2b8oO4qztB5zY1hYBYX/0i8xBk6yPj?=
 =?us-ascii?Q?4D+QvsM8WivhQ5o3TyHGx4xKRG+Jrag7/XTHW7yQ1xwJR86yiJMUML2BvFeg?=
 =?us-ascii?Q?GMkMqv647PiA7lwgR5XNbxLfwnlRuQirlEjUeOeJ1nJoxSyiYAhFRiaNC5cC?=
 =?us-ascii?Q?QqS6jHFvys3/AKxoUY8FclJmsx974uJROy5A9aNnMmvaXNZe7fv75Z1AcBan?=
 =?us-ascii?Q?1Lohvgf/12RMPSpbn42rOoySXl3zTEO00l+rgGMLDDzo7Ehtj2snpwGnLXsS?=
 =?us-ascii?Q?6UUKHQk29PeRLHUCbs7UT5uXPvny40nT1q5O99Ez4qODJitR1KMhN0/Mz7ax?=
 =?us-ascii?Q?Ww9lO0P2x2VSVN5FjmdDOVO+GyBjsn+p0uK1jBGH46IuxvVsjV/rsm18CGzM?=
 =?us-ascii?Q?E6LJAdxY8u7ucMwZwjGWws1PTdmolcBiRxFtdRU0QE5Nj7NPwLkSqGBHKjdC?=
 =?us-ascii?Q?iNg//9UuOWD1j5iI2m8WFZFMFl4vEUagAe5oaFHBw5bhlfwp6AOl5KXhAXHH?=
 =?us-ascii?Q?9eEqz1/migRMN/dYcxU4eUtpp0DJBcC5MYrd5Jk1g0lrNSTFczja0oln6HT/?=
 =?us-ascii?Q?y//c4CFyCJfOVTO0e0mT3AeVOIweKo8AwsHPJ4py86Qy7fxliFELcqjSCLr4?=
 =?us-ascii?Q?fXXXOHuBA+6vWq9hSXLcb039NsQO4T8Q0YnbiqISANugEruvAIzw8fVu0pII?=
 =?us-ascii?Q?rcF/011U06IhMjJFqxKWC9gWVLnU7jsXUp8GyYqtgRReaWX0ekygKmbEOGHc?=
 =?us-ascii?Q?4dJ42iDiXllzMevNGPz+8rP5JpWEQtuRWoVG9WSBII8f9WifENcXxS6fkDtc?=
 =?us-ascii?Q?ng=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7E267F5D64A6DE498C04C7418A0A8990@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: edgeless.systems
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR02MB3128.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df588da-0f95-4d4d-3ce7-08db14c1eccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 10:45:33.6952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: adb650a8-5da3-4b15-b4b0-3daf65ff7626
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGIhSLu9Hr0Kc4+QndS18UqpZU6uDlV9OqS442uZ1g+znAJlPvcu/KzcEiE/1CXWb5TLJAincG2yvJVEv5yQmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230222_024537_941050_DAEF0704 
X-CRM114-Status: UNSURE (   8.97  )
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


> On 21. Feb 2023, at 23:23, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Nils, this is a slightly different variant from the one you tested
> earlier, can you retest it?


Retested it, also seems to work fine on GCP.
Namespaces are cleaned up correctly.
Attaching multiple disks and detaching them again in random order also work=
s as expected.
Thanks!

Tested-by: Nils Hanke <nh@edgeless.systems <mailto:nh@edgeless.systems>>=

