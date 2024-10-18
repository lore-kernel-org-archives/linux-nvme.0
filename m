Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD790D3C549
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 04:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=21Yu3iA+WG44WbRD6sZ7iifZC5IzA42qrtmbzaWpC3E=; b=rr4hK7YLJtH183WkOWno2SBSIM
	RTdnlkojijzfwR232lBaud3TGmt8DKnZi25wCi/yeVkjjVXcnX4l/gmD+vPLGZYkUuadS1VVK6SZN
	Y1iuDGbgx86RiMcJjndBT7DpN0BYns+Y8JSad/zB2IBT5Nd/yEYSxS9P9WTzrxSJLh1ymf88ksGbw
	cQljdJYRVuEhjDzYepweJrsU9RDc48qV+LP3hhjxA5ALN5qO2hTv70patB6FI/aiOdAlH3Cw2MGZs
	jl9Ky/0ms6GNQOTaaO3AHMmBFo2rOhKUEqTpidoslspWmD0hjDknDZ+tCxDJ602pLdZcFHmHojT/c
	mQCpmWDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1eSj-0000000Grir-0NtL;
	Fri, 18 Oct 2024 04:19:41 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1eSe-0000000Gri5-3rHb
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 04:19:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729225176; x=1760761176;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=21Yu3iA+WG44WbRD6sZ7iifZC5IzA42qrtmbzaWpC3E=;
  b=c9fp+T6mrDXTK6OMDGJHVqT8HR9OU94T8IdDqARna6Fh6pytCbdi6ffw
   3V5LjRUYjhUN2Ec7AgvNw7kjWmHttJeuG3XfWeF2EdQBjDpQGjSdcqIze
   9SWpt1vfvQtIJWVasi2hnF2TPl5/qc2M9VRW6nBdiCzZlGD+s0EQ82+jF
   cW6LoX12dLbDhanXKRLCdh0HjslXY2rUYosofBQtdYx02Fikyd2sNMbhk
   /qFe2rfGh9qh4tr3qCpcA313mBz3L0w/qv9kbhXwR6q8L1BubU35bo542
   zriFpiJxXTL/AOYBmi63aPsMGOMAtTe1R5mbcDzWsgh0UVdFStMPaqSTt
   w==;
X-CSE-ConnectionGUID: Ow3wkxbeROChYb/y9enyeQ==
X-CSE-MsgGUID: Cm/l+1++RcmDsjDAWEVTiw==
X-IronPort-AV: E=Sophos;i="6.11,212,1725292800"; 
   d="scan'208";a="30198000"
Received: from mail-northcentralusazlp17013058.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.58])
  by ob1.hgst.iphmx.com with ESMTP; 18 Oct 2024 12:19:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g9pFKHSatiGVSZp7ZGt8XNBb9uN69pzJPv7rRtTuYdMptnIS3gCGuM2BLHXsv5gfSztXPbd6af2z/VD0LjgJ4VYxiRZoKJjtWC6P7AiFq6bAPK0luKIlvfLQ18CCX1h9irpPHWCbjwH8gyOunOIS4sJJXZZEZQXB4Waowj28utAyR9uOkprPAomJUv0LD11ATKZ4DmNOEkHLDN7JKjClJNXNEkbSjDs/8/RsATVl6INoD0yl3+Cc9I3ufozxNdzPt1hCu7WaQ2B6D0z7zKEQ2HD31M9lK4Pczxdt6gZFBP7Y7ZC3VcFNDa27dnW71WKRvHAWg2Hp5L2FzpxicRanOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=21Yu3iA+WG44WbRD6sZ7iifZC5IzA42qrtmbzaWpC3E=;
 b=neDlaEfvS6I14CIbupRrQyIQNsgeyXN6vFbCwSVZIBb8CBpdgJ707BZdfcdY+mkpq777tcCoUCv+ncFTE5XjryuyehO3MFgbNdx+GhfRXLKMOjxumU9QKVkt1YdeijttXiXDvGgW9OQyS8nVmCcT5ZyEPHdu005Q50isd9yEavFIKO0PhQklem3VF9ykRZQz9pDonlZMODsCvnXQ0w/DPTGyzIEya4L6niZLsElESEDZ47r0j7O2rowJzjafFMNLnQ68SWAClENM4VPpuir1c3Ddbn+x0HTLa4rqMasvbsEuOHVXBPsLYJq17P2uuX4HOc5cYSRKSdxWlY4JKdKiyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21Yu3iA+WG44WbRD6sZ7iifZC5IzA42qrtmbzaWpC3E=;
 b=daH528hzcPAqgPPDioB0QDHNtNNcPt5a6lYpbLWs2d2XdomcdxexcxknrK5o0jlcUawgSrE+KjOzYAgtRaAAkP37pEK36kpWKwxOUSm9QZ5HwoyCFLkfQ7HPkswQsNciaBPVqH5n7PqwI6ZKMyrxY82lhL3C9HJYbyAROOmNx3E=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7989.namprd04.prod.outlook.com (2603:10b6:8:f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.24; Fri, 18 Oct 2024 04:19:32 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 04:19:32 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@meta.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, hch <hch@lst.de>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCH] nvme-loop: set blocking flag
Thread-Topic: [PATCH] nvme-loop: set blocking flag
Thread-Index: AQHbILj4WY5++aniNkmiSCycU7ANMbKL6GmA
Date: Fri, 18 Oct 2024 04:19:31 +0000
Message-ID: <p3xi2sn2vwgw3drnietym7tmyfb2dat7atploqwc36spl5kng4@u2awrtzvrud4>
References: <20241017172052.2603389-1-kbusch@meta.com>
In-Reply-To: <20241017172052.2603389-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DM8PR04MB7989:EE_
x-ms-office365-filtering-correlation-id: 44596718-9cc2-4070-8a48-08dcef2c10d2
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?bIUxbZywNxNbi+ebrudhAHeMe+gLNHGEQbsFSP2bqqGReNCya3Z5ahBPoIH+?=
 =?us-ascii?Q?TVOj/OFNEtzCdAOlS7bWhTNJD5RtO20iVD5z2isKR2g0nRdrM8zJCqAvDSwi?=
 =?us-ascii?Q?Z+37cQTDwEACxrN9kh0FZ/EKSt2FkIY4SuH65rAr37H9cGYgcdnXNnzNK17P?=
 =?us-ascii?Q?mJyJJoD1KnRBbVWFEuKk6wa3CAA/5Gzqxt19JtQ/GExjLrhtfJlj/+rGD6xL?=
 =?us-ascii?Q?onZPsYUbathz3ve6z66MMaB68Yw2l4LU5ftbR7QuUDJ20MlpQ7M+1s8/RHZI?=
 =?us-ascii?Q?8fAyH18bAPnRSKUoK9OZK7uAMW80QtSXuu3TTwbJH4wkGfAeCj9cVcxIYilh?=
 =?us-ascii?Q?WgSiItfxNSpEVchWsn9OIsd0UfilSw8G47g/Ke1mU0eNEAV/n51KZ3Bf7HtH?=
 =?us-ascii?Q?HNCdvA+HsiKyl41BeaQgPjd8wwtWc03j830jWNZgbUWOk69nv9zbOPQbv58c?=
 =?us-ascii?Q?cdjmOj2f3voXOsKZyEc21XMS0LBSezuTT2UOxYq5yk7mvkohM1mGvEpuXz2z?=
 =?us-ascii?Q?htD/TfwTZ45BQjNkfVXkyAk9iqeNGjHQThF/KxW+mJfZ9cwiDMfqZCDc1xn0?=
 =?us-ascii?Q?tVV/ou9XCWN/Qc2Oy/+I8IAFut6b3PumWkuzHLlc+DW+vF8b3wiHj7oph4nN?=
 =?us-ascii?Q?2G7KgjtEkzny9zMdzA4JKQpVQavy7xKUPuQabO5tHayTlAHZwP6DjsOtZJ6+?=
 =?us-ascii?Q?Kv2aFBJN04UwsW9ghRX+eh58Fj2jX2XhktGohjdLNX37yQf0fCA0xzvykfMR?=
 =?us-ascii?Q?n6PLuQSvWlP3BafArlwFwBm3HmLIPUulOZI1FNjz9zEduijTwnVTQh9mmfQz?=
 =?us-ascii?Q?q/PWnbSlyUlX6fvsHbHLT6Bb+9z4YELMc57WZ8CKg1YjQlzAi3UMGxzE46ev?=
 =?us-ascii?Q?QQvdk/JnopN5ZVgfNBkvNv0DkgD7rEMHH0c7xlkSnRmzF1A19I7DjWOTGLs1?=
 =?us-ascii?Q?r2kH9SUzWIE3K5bSjgltDeHL1LTcEP9i+NuJGySmjZNqGLbYDxuIKRH38oZ8?=
 =?us-ascii?Q?ad3NR5iCQzR6TQyqtjJ/gLfnOEEulNKR6DWb4WXDotZioETqNCBtyQEXQciW?=
 =?us-ascii?Q?oqPpHRfX9Q+hL5lhuEY/22/78U2qBhdcO6bHLBxXbnzaqT/9ipd7SElpv2uh?=
 =?us-ascii?Q?XMnR0oKJF98ti1WRpdqsiX3z+rhxEoywjzGmq1y8tcUi2CiMioKkZS9GHCUW?=
 =?us-ascii?Q?UygvdxT/UzBeSsJUsJ3ZP6kdc89R+/T1Nxg48hgEyE+HEeWoGpxYBh2upYcv?=
 =?us-ascii?Q?HbIbd8ebJVBiEr9eIlZxu67CKI3f0cBA6lTukyyVGV1TNzlbV5pI2hmozeRQ?=
 =?us-ascii?Q?DwW+72FrQ3AD4YPmDltkxF/CUGvb2gBXw6U6aIE+PVncQejE85hwML1W9oTg?=
 =?us-ascii?Q?OWPuoLw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O/risP9zCdBR131t+fERLtSF9PkOTzWFZSPiz9UBGqLnRJXX5JstuiO1E/sI?=
 =?us-ascii?Q?GgTBT9GscnvrJ1I5hz6MMpWWmffKh46YPvIJwcYV0Wi43DFEizK6IcDkPiRF?=
 =?us-ascii?Q?2P54cB4paEVDyIsYwxcfR8eX43gS7P4qqZoJCs1GW+QK64IYht55XwbFTI19?=
 =?us-ascii?Q?qvvmHYpWz+32uqHp6jGqNl8XRw93oniBU2QbMF1DxVtcH+nHJshD/ihLMjdO?=
 =?us-ascii?Q?9L05wHcwGA8/Vv1bDW15dxQZ9JVk77fKwNXTIjzqQ1D+/HU0n1r30j21EWpu?=
 =?us-ascii?Q?xDt+A1qTghV1CDKgMne1UOVoHVF7en1ILlU2DD0Ib7OfevGpInZDDPI7zcRi?=
 =?us-ascii?Q?rwGwvT9UlUm99BK+2bwx95C2C//d4TkxBum7dVXUURB2YIskR9nc/LfGhPg+?=
 =?us-ascii?Q?rEPyiAwdAfd6azvyJBjZZvvyW4/T8hCeyxVeX7MzGh1vtCgqgFVtB3ZhgCrZ?=
 =?us-ascii?Q?GdVlmLruaNhp7h+01/EfeQCyfH5c5NMEXnxBugfjfF8D8QcGsbUzX0vFrSW2?=
 =?us-ascii?Q?NzCGBm/xyemj0tRgPfAycyOHjGNcAc/x3A6VJfPehitymlm2e+YUQbZdYGjE?=
 =?us-ascii?Q?+ixJ1Wr4kd4rCIO5fS5Ujll+oXp3tNpr6YBS/rMIiW5N2VemcQKf/jltVr83?=
 =?us-ascii?Q?oOjKP0gbCZTrreZbkVrlsfNibdxWmFzgi18d7RjZXPZCovoPF18nabqIlOoR?=
 =?us-ascii?Q?1Q63daNPsent1ANUhxi2F5bIx//dFHZxnTiMiUXKnZZIBiVg5QWzapTnSh4m?=
 =?us-ascii?Q?I6NuqavuiNbAd6mI3Zxux74k+aw/OKyT86lWP5QSVKpJN1agi1dUdbIQ154B?=
 =?us-ascii?Q?raPl0gvQ0xg8qumwn5eKsWBh6Pl7L2re74GkB07HKiEjoMkP2BsS+ltprYSH?=
 =?us-ascii?Q?lREiFxDrmQif6IF6yu0lVUI4Bby96A8kCgyYcgEXGw4IpOshZ97VP9WO0rCs?=
 =?us-ascii?Q?CcFNQYno+hhOYYK61O8/Ds7F+0Ot5BOGd20CZklbtmGouQbv6SgW0jTGwt4F?=
 =?us-ascii?Q?5fGleAzHXIGuATZTPaKUCbNM8+XvclxpS2LqdF9vuKmrQUSbgyGYBSCsRG2t?=
 =?us-ascii?Q?/3IV9uHj1FAeohRm7Pu8Ou1n2u3vtfZMHbudF4MFXcxO8YQhz5HHmOQTyiK1?=
 =?us-ascii?Q?YW4tpI/NzbdJC+joF8gSXGh7TvOQdg2qws/u7Grog4Vhtr5yJ78UB36SsBu1?=
 =?us-ascii?Q?EXMZC7/kxIKexCX4HLQ3kKlV5P7SkV8RP1IEBRnSZqfhhez2hySfFbTo3IZN?=
 =?us-ascii?Q?0z1Ulv8K5jIT3Y2aDnsLAtIQgUblwjPH/7Kn8kEeWN66agZq3pCok0cncVGr?=
 =?us-ascii?Q?GxTxpRRRvHaAOrid9XYk+u3PddZkJfmb9gGoeY4JZLf4FScAQIrSZ/qdbauR?=
 =?us-ascii?Q?fZjMMUqf5vxG9nzHYqx0p20hcHoko5iS/naCOdC5RmWWPxyI65EMyTj+uMMU?=
 =?us-ascii?Q?On/nGQR8kruN6uHS0Mje7ioTva5z4tz9rUfnQMrURu3s0OnznKvjv4Aidzjj?=
 =?us-ascii?Q?cUnSZZzsjGyzubQa+W6M27lEtWkpBo9Sx3yf74bM8xtwG9lB8ph7H16Jzmou?=
 =?us-ascii?Q?7UWfmfF3YoxTfzqLewtWTIBbufi7lQL+Vwju6jxSU5lV7ffU9gDaQ8j45cKH?=
 =?us-ascii?Q?jv1P4ZYff1qQeGZ3fZ2QrQo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5CB415E7A3522843AE981F4ACD419FF6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0M1PSLdS4lBNDOJp10DZqd3TPmgi8IsBHuY7ctq7APtTCvRSl7Q2H1w9mTwXGO3tPvjrhCG1hXskbnshKu0CYxsz6HQI2szUTnaDFQ/fIbjb5nfLAB6W30WKA0TUfjpetJGXOjH5dVk5mhyjLDSAhi2vHp2/vr2aUIxBKDRRYvTnDSAb4VCvnpYvJAeZLe7X5jlfvgo/rqEjLsQ8YfWUI4jR2XbvsvzrJc7etkuq0dQcyPlTAOv05C9odcnz+dG3kjs/TVWPjfBiifs5raUeq6l+PdML2l/sYK022xgNNS/VUD3sYkwfvAw97312+KdNwENFc8Kg7BPWPcWXcTq6uo5dfsrzMCYH1qKolCR6OU+raZ9ucSviMyVwnLC8L9/o2D/uDww1fqbWLeIRhB5RgKuo7kkAfGwlJnEvthnY8xpVIae0vVRMT81dkmw0U4c0Fot5Con6d3PE35197xi4TBDMpPpvHH1WZWI0zivl6vOJbIQjvo3EMgb0V/yZF4isSDEG5FFDPwNlrnbBFEUuSEau6B97E3ZkNKop6Qi8A0wT5R7ZUSoe3R2+4sD34SCiFPQzK42zh4w5C7lKGkN+KmZWpRgRIscqpMhIkXV2V1XjtgpVgWo+Wuom5F5Fb9iM
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44596718-9cc2-4070-8a48-08dcef2c10d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2024 04:19:31.9291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2WzjJOraZrwx/bOrXsLQx7TpCDlVZlqVF3R9RMcacX9jwKUXSvwBjr/+rITLldU0PitIJEi1kxGB5+oAvXdGZPL9Zj08ctmfJzDH0esTYfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7989
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_211937_013163_3DAB3A21 
X-CRM114-Status: GOOD (  11.20  )
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

On Oct 17, 2024 / 10:20, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>=20
> Commit 505363957fad ("nvmet: fix nvme status code when namespace is
> disabled") introduced a mutex lock in the io path for target. The loop
> target connects this to the blk-mq submission side, so it requires the
> blocking flag set so that queue_rq doesn't happen inside an rcu context.
>=20
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

Thank you Keith for this quick action. I confirmed the patch avoids the BUG=
.
I also ran whole blktests and observed no regression. In case this patch ge=
ts
applied as it is,

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=

