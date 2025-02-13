Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D38C021A7
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 07:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=juBvlqdFaQypaTi1zQURANeCTt7fEaVjxyE7ucJcQeA=; b=jx2MvhIXV+ZcpXwWT6B6QLgK/e
	cezsB6wtTuW0dPbtUL2sKHWecl/mSzOTewtWqloD13NC9jyqqMtGV7uxoR9UdHISK/cM8AI9nImZr
	ltSlPYJL8FP1LoLWcDJQo3ixCdzyyFUdg61g4s0aZJcIDOrS8w4yqViRC9PtLBKd2yyaCjUux+IFm
	Y6lm318LfIk1sXP9CJyxtTCyxerDAF65h1iQhG0wwTZedJbg5Bxd0gypUYJeUKfbsB777zftVW6Gy
	gIgvd43D2XzZn3SbwCaUC2tQSvsFOSoZ7RdSyIjrFIb200AM0f+ernXb65+veCUIWbvlZ0p9Fnsc8
	Aw97zcXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiTT4-0000000A3oX-0RLZ;
	Thu, 13 Feb 2025 07:17:02 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiTSe-0000000A3jh-1ynr
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 07:16:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1739430996; x=1770966996;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WxmyKPAUAn1aoHp423XXXBFHkPE1TlrklH5kWjef2TA=;
  b=qf87PcnemcCoP/naFF8yLITj6AyTLLm1t1prCauB5w+ZFLST9nwRYke/
   s18m3QO0H4YQbFqSgsMun/2t95s+yvM1OUYLmIF246zF64Rv5p0ieJfoI
   e3R8i73RjjRHZSJn8OhafDHEGKh/yVUf+W0wiQk978E6I9+5+YCLonsYt
   pDRBDh0TQ8XpMMptn96JuY1P7o6JeLPSf20/b+nm6Z/yLN0pGLLrsOSvA
   OtRsRCrG4MVYzTdHYjCwvQOeRFKS4zjU6D6whgcOtPvrQ3zqSVbUphyjd
   PBJ7EwzLMzHFPtM7Lb8I5ShJ2UNhRPaFmQl9+e/5zlAAFLn3gcGvHfSWv
   w==;
X-CSE-ConnectionGUID: I2l9h1vbTpmLk6u8qtHfhA==
X-CSE-MsgGUID: HEW1yrXWSlSmYOEEAjVOXA==
X-IronPort-AV: E=Sophos;i="6.13,282,1732550400"; 
   d="scan'208";a="39352860"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 13 Feb 2025 15:16:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fen2hg49WL1QuWb4tkqLYmvmp/ZTq6hptLFqJfZCCUo8b2qF6nuARe7quvLMbIco0hE3sX2Qcf06WrKvQSNp3oHeC5frGveHf6dXDHXTh66KYkJWRNjh2ebxG8lrkm993i/S2usr2B2Pd259jsdVaAnA0KAk3a8OGZgl9aY94pyft6ooa9fUkej2VzfZREsdBl+m8K5YP3ywPLklPhYwqj0nvtfvaoA18XzAKZ/NztE219W4u16d7dbwvCJycd6op86GpnCH+R2AcPgtPEZmls3pP+n+J7bZ4LeT2Oam0s5Dki+mFC5G2CQe5VdsaeTz+GMHU9cgoBRO1m1qT03Hpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juBvlqdFaQypaTi1zQURANeCTt7fEaVjxyE7ucJcQeA=;
 b=e9YA2Y51yPaFtQCrZFSXkaPMKm53eSXvxvQk1KEgkY2epD3BESh9fbeMt0eTlY6AaAlp/ZBAuLibZBZZOzw77sDAufUjrNt6xy9YBzCwf8lWLwpwAmDkPr+wE1VC6Oh/CZxvrTtaHhTUhjxcUPG0bZ6nll2WvBzoEfacsZ5gT5bSjbKlIX2cKYdMNj5L9vm2idyFyB9U58MTF7Wi5aVvx7tWjdmqCzikAvz4Kp0akv8O8PL9FipF3t+qAd6x+S5eY9ZSd4yhJQRwNbRm+Nna+mQpBuBD/PbORUXXrfpMtVAoNj6vwIoVBITtHPg6r7O4Ri5PPei84nQ7uWV0FtjLAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juBvlqdFaQypaTi1zQURANeCTt7fEaVjxyE7ucJcQeA=;
 b=BcOQ1Y49pDdb0ePXYd2syy70hL21sY89HnARpx2qUInurg+QE4HMK5mSHpYEAkrQykSx7uZ88cVm06rwBEP1ugLEXK4hrWM9kXkacLmsMgofsNg99hhUBM5LWfzHJe0091rhnTTF1qKLdBVg0wFJ0kWsnmWPmAeIWiZkI01DtOw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BL3PR04MB8201.namprd04.prod.outlook.com (2603:10b6:208:348::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Thu, 13 Feb
 2025 07:16:32 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 07:16:31 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <wagi@kernel.org>
CC: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	hch <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke
	<hare@suse.de>, Paul Ely <paul.ely@broadcom.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] nvme-fc: do not ignore connectivity loss during
 connecting
Thread-Topic: [PATCH v4 3/3] nvme-fc: do not ignore connectivity loss during
 connecting
Thread-Index: AQHbfec0nbYVZITau0iKmO3vJ10nUA==
Date: Thu, 13 Feb 2025 07:16:31 +0000
Message-ID: <denqwui6sl5erqmz2gvrwueyxakl5txzbbiu3fgebryzrfxunm@iwxuthct377m>
References: <20250109-nvme-fc-handle-com-lost-v4-0-fe5cae17b492@kernel.org>
 <20250109-nvme-fc-handle-com-lost-v4-3-fe5cae17b492@kernel.org>
In-Reply-To: <20250109-nvme-fc-handle-com-lost-v4-3-fe5cae17b492@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BL3PR04MB8201:EE_
x-ms-office365-filtering-correlation-id: f84425f9-6c98-473f-4b67-08dd4bfe578f
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?G29PpJSSSnFw+iiqo+jBjfb1lheaB3+sXK5+jNcmxR+azpdJfRyyuF8t+yQw?=
 =?us-ascii?Q?3YqhHlPOoe6L+9tUT0BZL6zQs7Ce54RkKXM8vrfP+ogrikXqt8uvbPOV4aMm?=
 =?us-ascii?Q?t+c2V4Jwi7wAn5hcxJmbnLsrVa1MNlR7JpQ17BAj5cy0ySjXl9PEqfvK7zWA?=
 =?us-ascii?Q?1PiINpmqlPJwglC8VIvwkiKbVXIXD4IGNrRbPwFya1CkO2bc4TGTMellRBiM?=
 =?us-ascii?Q?cG4J0DTWEfplJbIwDZ1ZN0GHredfJoTY89t/B0GsuSIKKlJbeLz2Qe2GuEwt?=
 =?us-ascii?Q?SFn71uA4FLan1CSf356IQsodvTtHl0RBbTIZme7lAVg/hywrIChr1zr/5bvy?=
 =?us-ascii?Q?QNi6wqo6MUyrJJHPcIgJfSA/kraSPDZ6ZSBVhMOFWpSVGI6j8iHYGTOKbvem?=
 =?us-ascii?Q?igfQcMFUs7UK7l3AxaDX9KavQ4wANGndXOXES48B7tCQXZx0p9sR5JLADXfC?=
 =?us-ascii?Q?Stk6YHsFkYDuZrOV2WZePIi0aPUbkCYt9G11C2vyJV9eBqsDq8zo1aZpGKk2?=
 =?us-ascii?Q?SEiHykvyeC9D+WM7Y606PwCgysRVRdxywhGXaj0LVNnqKcPjXtOvKi8mCqTV?=
 =?us-ascii?Q?vBIEZCYk6QZyovEGydW+BxiW2OqfDXrVLSviZScULP/wGEM3cenKDQku0I/v?=
 =?us-ascii?Q?Cx2YjSCyZtEmDoLCt6ayRvGN8ywYzWRPiQ/wis3Al51TJN3EWL2s+OjVayVZ?=
 =?us-ascii?Q?gr+xSBW6SBePri08iIKwHqRqeqqu8Q10YKtkHkzAaAwuX9F2MmU0wtFTodbB?=
 =?us-ascii?Q?VIHA9bRbfnPiQFDAWqnRY67LLVAAYF774d3jNCkykcbZMk8dlBFo1TWdKcco?=
 =?us-ascii?Q?S8WP39gcqnapU1vQI31pIiPOlC1EJqy3xk9aAWt0ExfR0BmzbUQYoLYQ+oTH?=
 =?us-ascii?Q?E6BryHpiJ80apiVpozhUvBYTdqi8s73hFlt5UxS0bwxjEcoDmHmm5JrAnNYp?=
 =?us-ascii?Q?uF7SMzLu/RrPvE3jDyK7pdtJydE6KKl4T0af2yStvW1c3ZCWLXWrdPupRzdx?=
 =?us-ascii?Q?iS7c2MSVKCVRgHaCqoAQvxt+ZhB8YY4vDkJeGfj9Odx1bLyZ1UZKOWoETU7a?=
 =?us-ascii?Q?/fwFDOKcTVf1YTNUP2jA0x24pv1Mmt/TgJoqETg6Vsg1okYTGc5PAe0GApRa?=
 =?us-ascii?Q?/BHULodHWZ/C8H//5GPUoW0jaze2UHjaImDAiq1YowchsJe64YDYqoqwI+hg?=
 =?us-ascii?Q?Z+ryEwbojDDxqRUdprioBbjhBfa1gViaVrDP9JZK6JWWt9zQwl/bOhdFx/6B?=
 =?us-ascii?Q?wegSbeJ4JnXWAzoPP3aTZoLnBQsQsWsAKds3rgXdKXUFPLVEc/uowN1kyJ25?=
 =?us-ascii?Q?HPtt7C2sTtOZU2oWAAaFG+1QySiy+pvpQ2+if3vWiid3zX1tKDR0Kz+0JfmX?=
 =?us-ascii?Q?THgazYkQlCBEhUCiTcrppCZs9nvNhWBuiSjT6uRxytW6aGes6SSCzbYXEltB?=
 =?us-ascii?Q?6GCg0xmV6rgc4pHRbTKYOpdMzq5JrBRY?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cJh+nzm+D/IK6PGPEZ45ckRjJwgVPJE8gxQXerwnrifVA4K3Cj0ZAviM7RHl?=
 =?us-ascii?Q?3XyYSRawu/cB3TfiVlIdiNQh/8wYXddhAJCm1QK19lxhh4NEavVjfQjEJ/eV?=
 =?us-ascii?Q?GszJ3q8UEwzNHokGc2YPALJPFhFZvH8wFu7GiLh25xWP0gOYOdNSXFFP+fmg?=
 =?us-ascii?Q?LnHnRJR3Za4Zy9j7QlyzKMyNCYyQN+jsHyVxwEmF8SaXEbZBDDgXnED1cyzZ?=
 =?us-ascii?Q?bAPfQPAID8eii6Bim2hxF4EyHuwiGhyWRtTkqW+IC506YsgHWBoAAUwF35xQ?=
 =?us-ascii?Q?SV1Q8qxv36lxGrxjewdbnJvBjtj8+MGYQnVQ2ePHCy/GgDz1zmEZ13sOs9Q6?=
 =?us-ascii?Q?WX67mahPpxWuS3CiQFhtAZ89udoFwsQ1m0+ldlt0RBeHCR27cAzhfFa2t10C?=
 =?us-ascii?Q?9hQD48Jy1rtJKZD8paZjVj7+5PZftbi3EMGnbw7h6OnETaJTYJSbsdJrLApw?=
 =?us-ascii?Q?35ne6mPfozH8jnT8sHjcaPIqIuiCHiUb0MhSVwJBcdKIbM5Nl9CgFWdMFK3W?=
 =?us-ascii?Q?reG+YktGfUMYYR+xm56WfQIJN22X482fszyoTEbmQocVF2JobNK3UzDMcmOw?=
 =?us-ascii?Q?ZThVkxam+TdAijcZZ8rqCeTEkLL1mvNm81xm5yXedhno5tm157Rgqp+Iiny+?=
 =?us-ascii?Q?7zMAyaGw0ZrmGLuXm54uXZ5Vg+K//34el22ry4mmbvxwHs2COSUsm/hQkAXk?=
 =?us-ascii?Q?Jx2woXWa79QH12gJJlC3iZD22adduMWJmMMtOyhevbjuruNNWXBeaRWCg2BR?=
 =?us-ascii?Q?K78hUmUY9ajIbSYJkdtReiDMRviDRiUzi2hn1NJfz5EgC/C4bdnCJyKPB8OB?=
 =?us-ascii?Q?CBaaB0FqCyiWuk4FS4M9/X/1xy0wqpRkUvCZ70O054ptthSnlja93BqfUzMJ?=
 =?us-ascii?Q?h2lIzrvdVS89ydjiPvz+gf8QmSYUNaK5/SqApWgAqmhlYAAsV2KMxjYBig73?=
 =?us-ascii?Q?uKVDWqjof7mDwnfMLxnubnPdBZ27h44GSLwjIDD66K3n12f7NzYZ4XLAfxkI?=
 =?us-ascii?Q?cL4SCmmwhZ9ykI6rOPOhN/0Z+mYSU70gV5Hm8TapK6ESFhSe1doBYuEWeaSg?=
 =?us-ascii?Q?vdaZWV7VYmnHpbjz98nOaDD9i9wH7soCmW9zaZR7PyNteZ5GBmxfKyrt97ga?=
 =?us-ascii?Q?mBGLAsnMG/ZlSMO7HCUfQLEbZJOcDbALI9sxKuQJP1ZRUoFealL9V3dqMZjR?=
 =?us-ascii?Q?m7o353NKvNZC1/ybZA8SzneiJOipEikWPU9cvKoGMyYMGtfOXv3ZpDvFZUN1?=
 =?us-ascii?Q?Lu3F9AifGmP+TlZo0AiJCqRDGi9MrUTKXVQrkGZooPJaz9wLcZpmRn1mBdO1?=
 =?us-ascii?Q?bxSN0HZYCBY1umOkN5y/CKumJ17vnokAruI6oylvojghAQIBwRr5l6ifsfGd?=
 =?us-ascii?Q?erH/xf1pmt6MlwXA+s4ny6/KrsPgZGZrBFNuZpX2JyrlD44eQQoBzxYxw4C9?=
 =?us-ascii?Q?pX9JhYi6go7sZHWIsvI+jnTcFwfG2E18raYrLgf5QD4Pi0VL/a1wsEFMZ4IM?=
 =?us-ascii?Q?YsmGc2XO1Ff4+HaiT93PKKIBPhDSa1tez8VODaZq2bdtXW+J8ft8obuTvN2J?=
 =?us-ascii?Q?/90DnOMvIhcFg/z3+kTtNqxFSu/l58ohDWIqRXRIvtTlSMW6OUzba2pE/Yb/?=
 =?us-ascii?Q?a8NQMXLjl8+RUlx352VEcTw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F0F47916F0E6140B906D4262242DCD0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dQJ9+HQLMNyp5SYINB9wjy8kEHtUeW6QmjMrUtsJWYCzs+5r+UwvwUlwQNDuOtUr+A+2OULoP/jBQHDh/O1VnER1rJ8sJP/73Q8iTaQTdGDX/yaTUjUjBmfqFuGBN1/9mI5KcCeOeVCRVGH3COx4kqImfqXNl67JVm0AS5wpeMHtAr+OwwuSC2m6uuiRJ+wunOXpjdtaKD+2U6KsVVscUccOiTnUI4IHvRBLInhUvk9WGy+knwgCveQ2YurVTVykK8xjk6d2+ASQn8z91aFArGVm91BYDvQnUSKlj8cKUfEBq3VNwxGm/epAPfxek0Co4y0Hvo6iakNfrO8RrBNGFRPgVczi0Gy1auUyqDTCfit6JfG311VYqjPzb4oYsNu5cO8PivPVC+r//PMMMDHi2uw+xklvjZXfJh1LJn54bLqE2IPfhrXVw/TU5e6KWStPjUAr17xhVCF2osVh6kdEGM/iErmmwS7dOjiuSomsxwqgSbMCHkj3HrKJb10RWma5eGK8QS40uI9WS/O2gwccWWMmUub0D+zUqMDaQvQLc0i0l5rYgXntuR4b1ISoinBwt0EZyIKgvK3P2WVpGpJGsTq63EzX/P0ttZ+MyCQO9G3jEDwzQeJdgWvm4i+6PQVI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84425f9-6c98-473f-4b67-08dd4bfe578f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 07:16:31.8907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p6SWBAuXkADvf/pvM0/z+QOyg2xniPiygOYTipEmvVo4bQ13u651kZs+T8/HdgJ8/rLxCQZzm7KdyyAuxEx0gTEkmoBs9CRPJk3MjZKRioA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8201
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_231636_569242_ABC6239E 
X-CRM114-Status: GOOD (  19.46  )
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

On Jan 09, 2025 / 14:30, Daniel Wagner wrote:
> When a connectivity loss occurs while nvme_fc_create_assocation is
> being executed, it's possible that the ctrl ends up stuck in the LIVE
> state:
>
[...]
>=20
> There is already the ASSOC_FAILED flag to track connectivity loss event
> but this bit is set too late in the recovery code path. Move this into
> the connectivity loss event handler and synchronize it with the state
> change. This ensures that the ASSOC_FAILED flag is seen by
> nvme_fc_create_io_queues and it does not enter the LIVE state after a
> connectivity loss event. If the connectivity loss event happens after we
> entered the LIVE state the normal error recovery path is executed.

I found many test cases in blktests nvme group fail with v6.14-rc2 kernel w=
ith
fc transport. I bisected and found this patch, as the commit ee59e3820ca9, =
is
the trigger. When I revert the commit from v6.14-rc2, the failure disappear=
s.

Here I share the kernel message log observed at the test case nvme/003. The
kernel reported "BUG: sleeping function called from invalid context".


Feb 12 12:03:08 testnode1 unknown: run blktests nvme/003 at 2025-02-12 12:0=
3:08
Feb 12 12:03:08 testnode1 kernel: loop0: detected capacity change from 0 to=
 2097152
Feb 12 12:03:08 testnode1 kernel: nvmet: adding nsid 1 to subsystem blktest=
s-subsystem-1
Feb 12 12:03:08 testnode1 kernel: nvme nvme1: NVME-FC{0}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2=
014-08.org.nvmexpress.discovery"
Feb 12 12:03:08 testnode1 kernel: (NULL device *): {0:0} Association create=
d
Feb 12 12:03:08 testnode1 kernel: nvmet: Created discovery controller 1 for=
 subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvm=
express:uuid:0f01fb42-9f7f-4856-b0b3-51e60b8de349.
Feb 12 12:03:08 testnode1 kernel: BUG: sleeping function called from invali=
d context at kernel/workqueue.c:4355
Feb 12 12:03:08 testnode1 kernel: in_atomic(): 1, irqs_disabled(): 1, non_b=
lock: 0, pid: 68705, name: kworker/u16:14
Feb 12 12:03:08 testnode1 kernel: preempt_count: 1, expected: 0
Feb 12 12:03:08 testnode1 kernel: RCU nest depth: 0, expected: 0
Feb 12 12:03:08 testnode1 kernel: 3 locks held by kworker/u16:14/68705:
Feb 12 12:03:08 testnode1 kernel:  #0: ffff88813a90b148 ((wq_completion)nvm=
e-wq){+.+.}-{0:0}, at: process_one_work+0xf20/0x1460
Feb 12 12:03:08 testnode1 kernel:  #1: ffff88813b397d38 ((work_completion)(=
&(&ctrl->connect_work)->work)){+.+.}-{0:0}, at: process_one_work+0x7de/0x14=
60
Feb 12 12:03:08 testnode1 kernel:  #2: ffff8881ab5bc018 (&ctrl->lock#2){...=
.}-{3:3}, at: nvme_fc_connect_ctrl_work.cold+0x2200/0x2c9d [nvme_fc]
Feb 12 12:03:08 testnode1 kernel: irq event stamp: 140088
Feb 12 12:03:08 testnode1 kernel: hardirqs last  enabled at (140087): [<fff=
fffff90e222ec>] _raw_spin_unlock_irqrestore+0x4c/0x60
Feb 12 12:03:08 testnode1 kernel: hardirqs last disabled at (140088): [<fff=
fffff90e21fef>] _raw_spin_lock_irqsave+0x5f/0x70
Feb 12 12:03:08 testnode1 kernel: softirqs last  enabled at (139874): [<fff=
fffff8e5158b9>] __irq_exit_rcu+0x109/0x210
Feb 12 12:03:08 testnode1 kernel: softirqs last disabled at (139867): [<fff=
fffff8e5158b9>] __irq_exit_rcu+0x109/0x210
Feb 12 12:03:08 testnode1 kernel: Preemption disabled at:
Feb 12 12:03:08 testnode1 kernel: [<0000000000000000>] 0x0
Feb 12 12:03:08 testnode1 kernel: CPU: 0 UID: 0 PID: 68705 Comm: kworker/u1=
6:14 Not tainted 6.14.0-rc2 #256
Feb 12 12:03:08 testnode1 kernel: Hardware name: QEMU Standard PC (i440FX +=
 PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
Feb 12 12:03:08 testnode1 kernel: Workqueue: nvme-wq nvme_fc_connect_ctrl_w=
ork [nvme_fc]
Feb 12 12:03:08 testnode1 kernel: Call Trace:
Feb 12 12:03:08 testnode1 kernel:  <TASK>
Feb 12 12:03:08 testnode1 kernel:  dump_stack_lvl+0x6a/0x90
Feb 12 12:03:08 testnode1 kernel:  __might_resched.cold+0x1f7/0x23d
Feb 12 12:03:08 testnode1 kernel:  ? __pfx___might_resched+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  cancel_delayed_work_sync+0x67/0xb0
Feb 12 12:03:08 testnode1 kernel:  nvme_change_ctrl_state+0x104/0x2f0 [nvme=
_core]
Feb 12 12:03:08 testnode1 kernel:  nvme_fc_connect_ctrl_work.cold+0x2252/0x=
2c9d [nvme_fc]
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_nvme_fc_connect_ctrl_work+0x10/0=
x10 [nvme_fc]
Feb 12 12:03:08 testnode1 kernel:  process_one_work+0x85a/0x1460
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_lock_acquire+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_process_one_work+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  ? assign_work+0x16c/0x240
Feb 12 12:03:08 testnode1 kernel:  ? lock_is_held_type+0xd5/0x130
Feb 12 12:03:08 testnode1 kernel:  worker_thread+0x5e2/0xfc0
Feb 12 12:03:08 testnode1 kernel:  ? __kthread_parkme+0xb1/0x1d0
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_worker_thread+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_worker_thread+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  kthread+0x39d/0x750
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  ret_from_fork+0x30/0x70
Feb 12 12:03:08 testnode1 kernel:  ? __pfx_kthread+0x10/0x10
Feb 12 12:03:08 testnode1 kernel:  ret_from_fork_asm+0x1a/0x30
Feb 12 12:03:08 testnode1 kernel:  </TASK>
Feb 12 12:03:08 testnode1 kernel: nvme nvme1: NVME-FC{0}: controller connec=
t complete
Feb 12 12:03:08 testnode1 kernel: nvme nvme1: NVME-FC{0}: new ctrl: NQN "nq=
n.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uu=
id:0f01fb42-9f7f-4856-b0b3-51e60b8de349
Feb 12 12:03:08 testnode1 kernel: nvme nvme2: NVME-FC{1}: create associatio=
n : host wwpn 0x20001100aa000001  rport wwpn 0x20001100ab000001: NQN "nqn.2=
014-08.org.nvmexpress.discovery"
Feb 12 12:03:08 testnode1 kernel: (NULL device *): {0:1} Association create=
d
Feb 12 12:03:08 testnode1 kernel: nvmet: Created discovery controller 2 for=
 subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvm=
express:uuid:f35c1212-8678-4a7f-99e5-05e61788783b.
Feb 12 12:03:08 testnode1 kernel: nvme nvme2: NVME-FC{1}: controller connec=
t complete
Feb 12 12:03:08 testnode1 kernel: nvme nvme2: NVME-FC{1}: new ctrl: NQN "nq=
n.2014-08.org.nvmexpress.discovery", hostnqn: nqn.2014-08.org.nvmexpress:uu=
id:f35c1212-8678-4a7f-99e5-05e61788783b
Feb 12 12:03:08 testnode1 kernel: nvme nvme2: Removing ctrl: NQN "nqn.2014-=
08.org.nvmexpress.discovery"
Feb 12 12:03:08 testnode1 kernel: (NULL device *): {0:1} Association delete=
d
Feb 12 12:03:08 testnode1 kernel: (NULL device *): {0:1} Association freed
Feb 12 12:03:08 testnode1 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Feb 12 12:03:18 testnode1 kernel: nvme nvme1: Removing ctrl: NQN "nqn.2014-=
08.org.nvmexpress.discovery"
Feb 12 12:03:18 testnode1 kernel: (NULL device *): {0:0} Association delete=
d
Feb 12 12:03:18 testnode1 kernel: (NULL device *): {0:0} Association freed
Feb 12 12:03:18 testnode1 kernel: (NULL device *): Disconnect LS failed: No=
 Association
Feb 12 12:03:18 testnode1 kernel: nvme_fc: nvme_fc_create_ctrl: nn-0x100011=
00ab000001:pn-0x20001100ab000001 - nn-0x10001100aa000001:pn-0x20001100aa000=
001 combination not found

