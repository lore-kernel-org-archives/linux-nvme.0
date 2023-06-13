Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED54C7EE29
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Jun 2023 11:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XFZi8uGaluOh+24LP8UtDUqjz9tliiCMH9ENAncqaeI=; b=3vTTMgjPQDQ3whfebRf9QN6Zyo
	VepMweZrMSLUzLjs2bivgE4BZOeDM3VRWD/vudAURzIr1O3DrcvAfF4WYSjnSq4NA/5BHvWgaxf9G
	nhiZ5uv/bQPiloeKAYecXn11U4mVegvgQMLv39+qinCR4LSggEexIv6GzTTd51Vg7yr8bvzBFohOQ
	a2QOSKjlO4zoEmcd71qA0sIkjhEXocCpCFjHgW8v0QFwb9Ull4GCyjaKtITyjPWj5Z7FeJZOBCm2+
	hTvJMMGXkM0SAWYx+dsB4sQ6lUJIA5Dw2BqSc7MwDohur6AVYdyXkJFnxz3dOpUiCcElHtBC8t+TH
	WjGwOWmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q92Jb-007vv6-1Z;
	Tue, 13 Jun 2023 11:35:59 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q92JY-007vuL-1r
	for linux-nvme@lists.infradead.org;
	Tue, 13 Jun 2023 11:35:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686656156; x=1718192156;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=XFZi8uGaluOh+24LP8UtDUqjz9tliiCMH9ENAncqaeI=;
  b=ov9/wfHmgWOU3M+vneK9w9ueLUydqyYzZjJVsXYnxdvHBxKSqLM7aAuI
   expvkLJUS1B2CjZm/w7bNpzahi6ec0bIiaQiluSwyhVApFHqXBOjkaidL
   O5oXVAq/4eBX6Epe+eV8K7nLVD3iBVxIyenAvFRaG6pEd5rjfUgh2DD6T
   yui5jsoiO4vNwDBBX5mtVjU1DoCO1KH0VbST10s0LytTkn7I7ac9NCM1c
   A+k3oHlIMiawSno7mQ7v8DyyveP9aZbEWHTy2fKf0z9Fy2iUO+i/RMY6Q
   eKEoVz3FvHK+kV+DKRM1wYGeJhpnMR9LAoo6AF+EVoIPdfN5WScG2WOAd
   w==;
X-IronPort-AV: E=Sophos;i="6.00,239,1681142400"; 
   d="scan'208";a="340212834"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2023 19:35:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9VT12T/XY/vduPxDu0hfTYtG13/FRmcep8k3Nyf9UZpcS5OzHF0MGe2Tri/DVstaqndMjVCgP6w+6TcThwblo8uOjSB6zAI0N036ywbzHAb0imog6MHFvjeP8Ih16b5SfVefi4c66cUEVbbrpyDlE+YtUmwqGrMu9emt9Fp5jxn/t193juCiCiPSyvl3oF0KtPGdmvbfZ64esytDr5mDybyaqUj25Szt5gALOaDJU+rxQqF/CerIhZGlfvXlF//Gv9JXDCjmwuNS47iGWgYakF1rpuXV+qduw/i/xbcgypL/uCV/NiXGSW1p3JF+bUYu7KJVUfblxCctQgtVZdT5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFZi8uGaluOh+24LP8UtDUqjz9tliiCMH9ENAncqaeI=;
 b=E8j+ENu9odSb+DNzjGt0QJquk2cvlTD7y3Vl8OnTPnLgry4hFiaJc4uxIDYklnAMz28FyzGkvJuiWq4XhWAYTiQ+2wWNz+mQXsx0WyUagF/JMxsO9dav3hQj0+sXUqO7jCTasgNZ5SrqXTP8NVoxCaivQ1VuSiumix2mafq0arUZqI9TnB256sYcMtTgw2kBqGtEQoCfloODJGD1aRIHiFB0dWIvtGK+NHpvphdJcEG/oJcMht1au8Mns3NJMPENL4G+nobdwYv8yQQLmLYwt+jn6OVIBVXQS0xUwxxPbwiG1z7KSRLh0RvxP9HKIR6onvcM1eW9gAwKAbLds5X2wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XFZi8uGaluOh+24LP8UtDUqjz9tliiCMH9ENAncqaeI=;
 b=udTHACm9vb/Uw8OicmSYssbQsIVP9ihd4FhRXUr6oSaDwEWberIFkzTct1AfXkwHAYNG5RHBry3k2qfwzGlC0i4sikV/nOOJ6CkF67JPifqtfK5aVPbYVRhLTXqUiHk8eP2LRxLDv0h2Ppl4bOkhr/MgNlaLy+Ce96Cqmgslod8=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7200.namprd04.prod.outlook.com (2603:10b6:a03:29d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 11:35:45 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%6]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 11:35:45 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests 0/3] improve block/011
Thread-Topic: [PATCH blktests 0/3] improve block/011
Thread-Index: AQHZj47Bw2i4uO1+JUKjXyuKdgFjUq+Ity+A
Date: Tue, 13 Jun 2023 11:35:45 +0000
Message-ID: <yje2wbbavmx7yeoh3tfduz3fsuck4pz5tljtalst26iwpvi25g@7gjs3zfua7ol>
References: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230526045843.168739-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB7200:EE_
x-ms-office365-filtering-correlation-id: 46721733-79ba-4c1f-ec14-08db6c0253d3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e1xdfaFtJD7JKZ8P+l9lsjnCy000YjG6mtYlAPjkJjJqmqRBeRKXphxGyj8npHOaspURYnpcfKcyopase4xFACaBUB9CXWGM6Na8IAk0rY303YaOJK9oKvsrWsCU/ipt8AStFIpHCpHj9p6VTN1FBV3ZsMUf+GeNFKEwOhp+QQqI3QK3bUqSmCyp3ztiRc1sshkGISMY0tvgvMHT7tg+L1YmO0uOdJFX10sb4HrORhC1Hwgr+pbUdM6Xdg+3ps7uYglNnSEyeSu3Tgl5zIR3nQV7P7/Sh0t8jiJjfxm989BSvDRqgYVWW4x9dtdBW76RLFRkcF+gRBdywUSqP7JQvn3hsjyLnZpZMUJgf8nfSIGDvvpObgGRpNuAYk7WoLO1RSTaTCQe+zJREB8O0ov3wDWt1h4M+46PL+1xkGd63XDBDlf9e/zyNFunLNVBx0ku3kZAswcpY33n1QvPDLYjnfah68uXMR0sB5xp+PS3K1ejxpdQvv44jBBTc5X5yisnsEUZvXN4pYnht8yPcIuHysaLKU3jl/m/mMaWYzKQqQsR3O5pSeShl+ItFor9v4FOxHt5tRZf57sQYi26Jsd4SY6k9PKt8xmgzaM6DcFzCrc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(64756008)(33716001)(83380400001)(122000001)(91956017)(66946007)(76116006)(6512007)(26005)(71200400001)(6486002)(966005)(9686003)(6506007)(478600001)(4744005)(110136005)(186003)(2906002)(8936002)(8676002)(66556008)(86362001)(5660300002)(44832011)(82960400001)(41300700001)(38100700002)(38070700005)(316002)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K6WdV2H2AlnQBwxvF8gGYk9jPS8WAtBvLkGOBi5lClarqsUuncHor+wNRSfh?=
 =?us-ascii?Q?O2qyF/olaxmer9ZKQVwIXbw0Bj3kaT14kypYlrGP4e4J4TK0ipAdDATL85F5?=
 =?us-ascii?Q?0aYkbhThx3y3u/UxKEgpM7JSWsNmXUEQ9SGhlxX7fhq3Ty96vLMYE0ug5v4D?=
 =?us-ascii?Q?Imu32lfGi3kW7mD9obqeKfbVL1llKn6RXYEwMADjqtoXZmWcI0tbnQTiZkzl?=
 =?us-ascii?Q?+kW7N8NYPinKjMayZaZCu9K+OQgBUqmIYf5XrRnqYVdEN/TUuKgkK97rJSgO?=
 =?us-ascii?Q?5Jnaw93VW9UU5sq/3eXPql3//GhjQ5QS9tVqCuayV9FMX+C4WMxA9FAkjX/v?=
 =?us-ascii?Q?ID8uuOmcL9n2VBI2S0mXp82PkTr3x6eFY/lrlhHCQiHa1JcaaPlKgUUpEutl?=
 =?us-ascii?Q?kU7/z9tD6j5nlzAwI5FkhjuDVKg5d2P9b9x2ZAkZRjoCwtDskWUt13gTwCjF?=
 =?us-ascii?Q?2UpMPx93PfidQ1cTERt9moaFYIN7ixPL674BK40GlxZ6IwFMWT8hELtLUuv5?=
 =?us-ascii?Q?t+UWmw6V8SC4eIsh312l0SOT/nTlBFfsyvbROV1H16WUgFBIWqjygeR57boy?=
 =?us-ascii?Q?UAtzN3HLeG6z8sv3+UrIEXVRaIg81VyCO8B4qVr7bfczbkZNRSKvRwaTSNR5?=
 =?us-ascii?Q?dmQ6W3RxAlguwEMjpRI8zcAKEXNmErdxiidJc9ybqxy581sEKp8/TYafS0iy?=
 =?us-ascii?Q?SChjDDzjLYkrQJO5aH51jL7tWcqrLE6l9PGoyGm+Su0HVNvkz2K9YaqepQAS?=
 =?us-ascii?Q?Z96vJi8YwsUTzXwFvtp0PLNRCRhIwikYuNuVnlGy3uzpBxq+hrtMQtB5qyDM?=
 =?us-ascii?Q?U+uqiE7IhRzIyRP1Cy7olrB/vxCymRbWajUY15UwSrqOexnsyr1Vo00lpo++?=
 =?us-ascii?Q?QL0Uj1Ogapoizx1Bnqo9wMEFe3nJ4KF1z8wkCllwkMXtXhYfZEjVP3AaAXOF?=
 =?us-ascii?Q?wfbLPhQi+i9UH1p+YkyXL7ZQ0tS/kGdhShUf/dxKEcAiyZ7O11hBnmk1TIOu?=
 =?us-ascii?Q?PbANLghyL/3zSpMpS9261nY2p+TwDmZ8nIOZ3XdAV9F8HxVNNDIj+1XOepuT?=
 =?us-ascii?Q?JTuHtHcuHTF4zXPqThRyBsxk9RTLbV8nYYqblaV33NlzOjh+g8HlDeVSrS0M?=
 =?us-ascii?Q?caI5XhHQC2xuFVPLMI38X6imm+0Yb/TXECY0+o9PfFQl5rpTlRjv5AyC4Spe?=
 =?us-ascii?Q?Dh5gfqyfslEWHcxhF4l+GIzlgYB5qaSVzCqGcHoIzUlj6YYMSMCiyL5KnAb/?=
 =?us-ascii?Q?IkaWmtB4+SfvzJvD1LkSY1e20EaRs1KUiO5OLjXgvzbT1Si9j0bK2qL64Y4R?=
 =?us-ascii?Q?Ab4BJDOZdEdAhJgSred64IzhRt2MYvweh2F9RYCIJAZH8BMc/2W/dQpt0GTw?=
 =?us-ascii?Q?MOA8S/lHbx1d97EJcgO0Yrk+C2Iv+rsNK2SDxB8A2iRmoFKoLlgJvSZVg+D9?=
 =?us-ascii?Q?aK/U9wb0bCmdC/wqUbvcL7xDuAr3nm4SMCSg1ziV6TH9kLltEVmwtWapi2Pm?=
 =?us-ascii?Q?4zGBA851LPCrYBnnBgapCRqx4zP0zymYZwg1nLVW9LJMd1WnPLb5Kn9BBsKo?=
 =?us-ascii?Q?aS3L3Wi1ABIW/9euyStRi2SOJ6ENWZ+rCucaHNdL3qS0FYKzUgMnPshhYJ8G?=
 =?us-ascii?Q?I0ZjTNgGyRTF/vouRxNKyLI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9E21DDBE0F4C94439074248D03397F32@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 60btleEg5hEILQp1988kDy4Wsjsk0dZ4wX/jl6bsO2aGlUBtqR/73264ZdYt0tjPmssTtOqDzlS7jpnn6CY1SAI1YsAF+S9zKQbAwLPR+1r7KXzO3iJM2A5WuSFx9AOpc8gbUNHhdoYXHsw2LqQkhHREaSGp4RVJAOWrm/Nx4BgzfPMak6dvQsj2GiH1uRNybuCFBeqBL1j9xG8TnQFH2Z/9SBH9hX4R5oGK7Brt5fWBzNdtCo6ox9hN4IslY76KSoEDP7e0IF2voZTQoJ2SBt6711I6D9D43TDLYBPIRReO8z9tOQehht6ImCdjdtoepmCFVKavzTzuvTNNjUknSNGaCeLBqzOtXV3HXe2McV0pWRaUFtEa5jzAY/GTLLpV/uPBc46nXsY0Luz+Q/m52emtvSrMcTOAg8BJ/Q3vIIfI3puY6tnVMVL1eYzT3Ce4BzZIhX/2IwoCteD1EeiypcN/YgKqKCriu5I1/6uSbanp8Cj9TJjsq9cLWvc1HbUZTVHbx+co0IDpNtZen+wGZJT+8E+Dr5kzmQcNPsfBGqUVmnj2GOb1U74LhsBVsdOgO9RtHwcaLFzvCkzAIxLAcLqA79Hk2R5fHDLXRVZa/GduCZ5JEds1sOqpC5sCYIfvKad1bygUm66kOkEEeMNAOHSoJCE75fX8u425Ngg2e/Qd796BzodNB63GBSblfFiwv/hfiIl9VQvUr0AqaeiS5a5ZDosLhj6FoLxKrE87cslFVIjeTSsdFxuJnCmDzVmtp9rA0EDJcmFgt5A0smke8R+gAHEDePQCJUc9ekFsr54gd6QAvzTueUX4sJUUsyZoC4ZJBwRlRt1wKxuQPWTjUg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46721733-79ba-4c1f-ec14-08db6c0253d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 11:35:45.5003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HeNVpiAFpSYt1ZkqKlmRFzv57xvdxu0nQ5QfDXF02E+74QEDtOFwAdPQYjePuyWp0VuBJCyX8KY7RoaH8FolRvVLjMirsCTZAqMM8nzuQKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7200
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230613_043556_682941_E3454A2B 
X-CRM114-Status: GOOD (  10.06  )
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

On May 26, 2023 / 13:58, Shin'ichiro Kawasaki wrote:
> As of today, three failure symptoms are observed with block/011 [1]. This=
 series
> addresses two of them. The first two patches address the disappearing sys=
tem
> disk (Symptom C in [1]). The third patch addresses the zero capacity NVME
> devices. (Symptom B in [1]).
>=20
> [1] https://lore.kernel.org/linux-block/rsmmxrchy6voi5qhl4irss5sprna3f5ow=
kqtvybxglcv2pnylm@xmrnpfu3tfpe/

FYI, I've applied the patches.=

