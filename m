Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7BDC369A2
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 00:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3/aMIV+UpA3UXU7SDbHaSB8DKck/oqp2GU6qkGIxDwU=; b=gkGYJWaZ/keRVcPLn3LP1QVeno
	em31OSvBEPlOLejTgmLUiKARs/iCHRvinetFTS3KpX082hc/jtD5UTOETaIQdw5D9ucoRxY7u33bK
	4VU1h0cqS0SXRPbIHEBJqg1ApM8x8tdcfIVJM9ZbQaO4R8FaJx2RYAI/J70tv1r3byoxoxzt8WFgm
	WzUnJGUhLpTOzRw73PYvka3s2FWoFy5ZJdWO+kjMbBcG//N+LGcRW5WbYTGYR9K6Jus1x/PcPf1Dl
	MUUHJ2qenMKYFEu/QJNsxtLiHMNQ67Uom9ujATfSutG8xwzW4GR2UfZTETHmss1JbT/LASnA5WcG4
	nZpSxB4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2gDa-00000008rkJ-0EWp;
	Thu, 10 Apr 2025 00:56:34 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2gDX-00000008rjR-2kM2
	for linux-nvme@lists.infradead.org;
	Thu, 10 Apr 2025 00:56:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744246591; x=1775782591;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3/aMIV+UpA3UXU7SDbHaSB8DKck/oqp2GU6qkGIxDwU=;
  b=lkgyCFETyq5tIT/TaeRGkP2Yhw2YTOCrvevjQ+elBWfUqZdVR9LyHPQI
   NefcYQjSbfFWK+OjO/gC1HV3zllzw9xFBLMuZL5PEnsCI+dy6lj+i6z+I
   LQHEyNGaozMRHv5BQrH5disurWFzBTNwqT+TNa70Of1s6Nrq7wcIOBvKA
   RTvgPzz28vX+C0QziYlGjmHD3rJVFjKZ35deEw5yTDC+mS/eBHkKFD5kc
   4cCAqnvxBLDjEzJR91YEvsxfCNJ6B40uVfcMnGlStHNq7jC+f3LTQpCNo
   sgbgvXQj3AipO0K5cy4FXGB+jgRU81nPsB8KhjdilbG9DwWoGhgFoNa5z
   g==;
X-CSE-ConnectionGUID: 23zxEwwJSSCVZ70xtufkyQ==
X-CSE-MsgGUID: NGZ9PuUMTC+LQWoM+PBhuw==
X-IronPort-AV: E=Sophos;i="6.15,201,1739808000"; 
   d="scan'208";a="81344524"
Received: from mail-westusazlp17012038.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([40.93.1.38])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2025 08:56:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wM9np19JykQdtCa+GLG03Pz5EoI3q1FZ+mAOR2QuU48gclMiHegZAanm+ElbVSK93Of3dN1WdFYC89g+qPDjCBTdcewbVjryWn2+1Zx+K32jwMhjR0xQkIwNtuE0YITbHhFIvHosUmRGt2I7jzFFwubW7gFzBfrNqKMUwfrcWmUSqObIgphLPWVHSZDhILWW5Mu/+VIJBzVEh8q6OWIFoumQy4VvjVbrSjl46u4DNvNHbIDa7wz3N6jJH28OStYInFcuE+aNW+XKJYZNpWnnE+Ar9DweR2+gB3paF/my6Krd0ol3D/EPFOCs+4YjtUSC9EzG+pU0WskgBHtwNzHbPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/aMIV+UpA3UXU7SDbHaSB8DKck/oqp2GU6qkGIxDwU=;
 b=bD20FHjbPeeLBFwxuGEXYyVqfTMMluhn0JQophQhc6WvdAPnXfLwz06PDfW3oPJ/9Z/irhdnSv4BHJ6W0MyAgSKr0TK7ZWnYrndJgUGdtTYGPS555cJ5EJDip3cgseh0w1zu4S+Gvw9gIn3jz1vO6v84KmkgCrtf1Wo2p+rkxr4URM9WzPygEATBaMoTWTrnDxFYAv3vvinoZOimbICkGVuk/LQrdoXIYKWGWzpCv5FH85/CSBDmfQqqBNdag4r0G21x1sH6Iq84wHbHM1Qs0DpLpkE0vEzFTD94mKJB32dFwx3mpIZrttEAgOlDoKB0YwK8R4VQ7Xb8nD/95sGLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/aMIV+UpA3UXU7SDbHaSB8DKck/oqp2GU6qkGIxDwU=;
 b=YlKgnp6ZOKwIHuRLfhWuwWxUKcD6w0vMYx0SK0XlTEAWADfwOhBPiu+BwuCDDo3efj2uRbtH5TqmA3Inhl3zVjtIY9OnLdlFoQqz0oMUXGwNOG6KDf6nTZddKwQ8NVMrIDdbF8nPfQ+cO5SeJXlAmMiZ5MuLEwk2xesRC+qo8uM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7221.namprd04.prod.outlook.com (2603:10b6:510:17::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.23; Thu, 10 Apr 2025 00:56:27 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%7]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 00:56:26 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Steven Seungcheol Lee <sc108.lee@samsung.com>, Daniel Wagner
	<wagi@kernel.org>, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH blktests] nvme/025: use character device for nvme
 effects-log command
Thread-Topic: [PATCH blktests] nvme/025: use character device for nvme
 effects-log command
Thread-Index: AQHbo6IbwRpgfY5iH0erYpFFQEq3hrOcH4CA
Date: Thu, 10 Apr 2025 00:56:26 +0000
Message-ID: <rcepk447ivj33nz5jc6qovmcrx7hef4a2h5b5izbceme52a63v@rr6o4n3j6cvz>
References: <20250402073727.395179-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250402073727.395179-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7221:EE_
x-ms-office365-filtering-correlation-id: ddc4b267-c60b-4f22-68da-08dd77ca85cc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RRdVUHhZrv1pxisEAtLrfuj9/GZHZ+SGs/BRqDURnVuh/ig2VHoM3W8YK6eK?=
 =?us-ascii?Q?mNzNu6LsYYHua6umqVJHx2YXrY7MpLwBvnPLLzAC+7sxbpC+ATITi+97o0Wa?=
 =?us-ascii?Q?ptYxq4cqPTPljFXjugjHcwCajdJis5OK8LhaQYi4yl3d3GkAeexsxSbPtK2O?=
 =?us-ascii?Q?LVRHYTQ2jdtrNvrDNALJTxF00uKAJKwr69ST/Z6sK/F70WIRI0ZbRfGBGSP2?=
 =?us-ascii?Q?Mtm918I0/s+MFvYbBTr9DM35chojMJiyL87gP9eoPyIc/v+IN56rSTfR3WjJ?=
 =?us-ascii?Q?PpP3yXhuVAcdwFS8NfilqvpL9TerxNm7Au4zwv80d1ku+/CV8EVqAhk3n2qZ?=
 =?us-ascii?Q?vBM4MY1J4iUkE68siEoKteK+CAM7CEJZ1GG/KlLxMx2rwxecRceX5sBqE5t2?=
 =?us-ascii?Q?8707fXpl3mcsLBXaZJ6ldfv9akZmS2hCw28bhInYVwcgEWa70Lipf58ifTPC?=
 =?us-ascii?Q?1wc2qkVUOLr8fFFRtWQAg0xTAx/ujZhhjSOgADSqMtDY4GTvMRvpJeTzhmOt?=
 =?us-ascii?Q?ShZjtpUG4/JlmTbHc8EQvOs5Ko0KD1inRnYF59tEX+F7hLsc3QZ41+fAPVck?=
 =?us-ascii?Q?9eLCvQgqqdf1fpeJMjFQc79TEFav60TqunHQd9lUDAoEvHKmKCxWLO5n3nG3?=
 =?us-ascii?Q?kFwE1lA+h+lIfnal804ogVobXu4/Ov/EcGDZvCj1v1ZuOPJmRpvQiQguYvtR?=
 =?us-ascii?Q?GEFXmnl84OhiqiwuyxUcPux5XqePPoIEeNMapLmTNQ09z0gKv7sRRrPjSMum?=
 =?us-ascii?Q?2WQSIizm2LL8LdO7XZNfD8OoLgLHPCNv7/7iCHb6cXOGvuzasAyNUG4QhgLm?=
 =?us-ascii?Q?2Mb7Bhue6WQG8HaO7w2MxpTNOxq2leTXL8I0PyhAUVTB9TG9ZrfYrfaeMEZn?=
 =?us-ascii?Q?tV5rMv2E5ztFp8OixKBEzMdU9cW4WWwhr0ux3mUgrxR177sHre3ZXKsTOenz?=
 =?us-ascii?Q?h2tEsPnEGQnR8VantlKWGZI+BmZ8GMP5/KDsgqHCK+ZKVSrXw3QuAbhIKrha?=
 =?us-ascii?Q?g4BD/3t8KjntrNsnv2hN+2+dfe+VVdYSyDMoO+uWSK6+/M29xMlDtTkHJu5f?=
 =?us-ascii?Q?ovhDIDOtETICCZqzxNrTXYUbVquE6XDji7pTDYQ3IQSxaM4XW1FIcIEyAWkN?=
 =?us-ascii?Q?GpvOSxohRRpBfwqvwE1MFhNo+EJyJHp1rkUL2fm1r5dr3QeaRDSVtTCHCI4C?=
 =?us-ascii?Q?SfmHJqM586rRAWO1nr+8L0hyH7DGa2WWz2LMv9q8yLN4O45nbkicBzDcuplD?=
 =?us-ascii?Q?ifP6OPG1d5GPoKSw9S6ikwhK2AzcUcVOD52z9I3x+52yvmujnNLm1maBm+4I?=
 =?us-ascii?Q?DsncnGkjngC5xT9E82R4dLFE3g+iIgqgzIyttZ3F+5mlOe6JSWuKEHogDHaQ?=
 =?us-ascii?Q?pBQTKOFFDd5zcDydvEIsodgRg44HCQPRlrPMRoRfNQUPRSspd+rcRVk00Ath?=
 =?us-ascii?Q?Yu75zg1/8PERF8vG58WymYGOiIzEf2E/xHhRWjxrHBExFahI9L61pmT5v0GD?=
 =?us-ascii?Q?6V2gM4LCiw6UGLc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Q9RVSwL8BqUq1LZRRQ33mHJk4GOaY4Hvy9zFKLFPiMrGi2UWKuCiD5gE0TYP?=
 =?us-ascii?Q?OpHG4xk9R5NClG346QfTCRtfNZyhgGNv7lIV0ZDggUW2HALjdgkHQASBy4da?=
 =?us-ascii?Q?eZXl1YTkZMqAsuOf14+ERadqbgCKLpS1q/1gQ1kFIS9i8H0YZ0bO9mtMTadZ?=
 =?us-ascii?Q?mSkhngy/NhdGG6AHA3Cl8Wglg/ri9mA8VdjImjR66tHmClQDqYeF90r+83ns?=
 =?us-ascii?Q?Yg/qcdnALNoFwCug5kC+/MGgSyMhdIQSuwnj15NbgbE+iXeyDZjLZAty0hDR?=
 =?us-ascii?Q?92rMw7NzW5TzYxt1L9KZE5QFvnZdeVl41NkgB2vAfBnt7S0ht+cECnxIXMfY?=
 =?us-ascii?Q?noruIj+56gutqgZ7QX/AIXpWnBDvJUu5PUU+ByGnOqJxN1looGhl2rj4lvHC?=
 =?us-ascii?Q?RMFHYkSBAC9JVYfMf0k47nieB8OuyyrfY/2sCETOvD/CWSzBEwoaPjUELq1w?=
 =?us-ascii?Q?MlwTAkkySJuRniWlWqCcxIFow8/0qH22I2E4KOqifqsTzJzbH2CBniNqRnzs?=
 =?us-ascii?Q?Hj7y0V1jQx9Uc/q0BgHJS3mH48D1Z3jpiJeICxPkYcnpViXaETC1+z1bIUrF?=
 =?us-ascii?Q?+LsgsPPVBRAJmvOH1COTulN6nB1QGoBmDQeyoYF4Ujh9DiqZd3A/4zwOH/Vw?=
 =?us-ascii?Q?5sNg3T7ofMQFftWHRmKJYk/3ggXAgbPYrPHJ4TFWyg16uYctfBs2tm6NPjzj?=
 =?us-ascii?Q?dnwul6c2bJwGPMq1z0ZWf+DZUYUGtHUHCdf2J2qg7q9+1lPx2dlZnNdqYeE/?=
 =?us-ascii?Q?k7ne+UBMlIt+DDr0EXIxaMaNCALYqxvvAyqbg8fx0PkdrGu1S5S6bMylngwT?=
 =?us-ascii?Q?+a6F6+r8xc3ssQmLOxqVP5ggIbKpuTXL4U1RLMAPTSWpEVFvEp28YCz0y0a9?=
 =?us-ascii?Q?sTV73SsTlD9dhl83PaFp4b6USsAZmGutlMiYtx09Fg4iyrii+q8oIwNFynrl?=
 =?us-ascii?Q?tT6r1uoFG4rC/hPqPN0YDnU5z9qezbv6c/1uq12dP7sUMMiKMbnqdgm4RmEs?=
 =?us-ascii?Q?J1QMXU2GfJkYirWLCFj7c2yOG91zzI+nrNdQKDGaTS5sH9p0Iy2ghuoRldfE?=
 =?us-ascii?Q?d4O6xqr0RToYklIZTzUxHG+53fuXy0fv1a3acZPAAokgKoB1ivXF3/VW5eDK?=
 =?us-ascii?Q?5Ek1LHLyge3lhZs5vAv0VNynRyu8hlkYqlXGZFHtO4xl6V623W24QCo1MgaO?=
 =?us-ascii?Q?pwqXm+9s6EW4wE5j0AKEIZHeulMrTgD9uR0vjzf6aikeaOvMpJiNaWP/rcB+?=
 =?us-ascii?Q?ExDkK/UtnagKrvNYhlCCR0J5jhL+ZanqVX5Zbc0g2VXej8EtvRTCVVc7FS45?=
 =?us-ascii?Q?T4kup+uL8+FGhnEMI33ep1Y3lYCunrn1YAnFVXuq9S7Tblejx3L6Vlz7MLlZ?=
 =?us-ascii?Q?OH+4G9mDOukTkRXxRWrjFlv2ak6c5RUhVFtDABD6O7cOFu0ZjQSDq5QbVYJ+?=
 =?us-ascii?Q?DMqYuyYFE9CciqweAH5ELtRRzKLCpsT5eyZ3Lwe6XccrrJMxx8tUj6YAXyC6?=
 =?us-ascii?Q?t6XPx00E/YG6m84O9O1e9n6rwT2pHT4WB31FAEFhGoXw2oY5yEg2QwrQAZPG?=
 =?us-ascii?Q?QmLnuUOnl6P7b8O/bwfmjc8EEulv6n0Du9vv+8XEK6HK/HYR/8z+CvCxCK98?=
 =?us-ascii?Q?DukFxuSyOhUGV8MgcTqpggg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <10FAD17FD66A6F4380E75DDE6FD3DA71@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: T7sAEm0W8BK7BU+jy+GjcFaCqCfYBnOmmK/sSsQm1oaEfGz0icxXl9F1WF0Nq5lmw4Ea3EiGMBw6hfzCkJu1M+u79kSlLWc+0kDx0QHLqzz4OKlZYtcU7+R+DnKyxyF8tTwDQpzkcUFdv+8Vs4nXrs5HONAOw2ue3pXeDETEuh/3hbUXnrr/EFfyrunV1yT+a9zoTkpyz4erQP818YCLr2LIPLGm2JHkVi2LhJ7DLfdqhM6F6lHyoR/bpOz09qJLZ9QrUhTluuCKufmzisb5NsZMQRgHXJ9bJSLP84V74Kt/YFqRbd8Og0TUtyjGLiTwXWF/MXXL23R0eN1Rx78IwAVKcaz54vftdYBMZbC/+dnOehZfNXbnPqR6/xwb7bIqkp7LT8GrqrdTDWEwqOjlYmRbNerDHXdrk66EzXnm/SAlkxZb4JbMARGSIBjxInqMS32OCxKPaPUtqNU0jdGRrWUxuXneskPbXME2FRWCEipOfIRzywiowOinetlSU1ZltnuNRTg/ElR/r7KAvK/VPkFXzLyrtjgLBMpQqJ1UV6VoFo0lY4ykEc9dhehWX+Evj0KUBVRdkxr+Jm4QS9oYD3W5verdWxsEkz5SvCcHqtVJp7PTJbVP0DFnVLg0xWCU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc4b267-c60b-4f22-68da-08dd77ca85cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 00:56:26.7848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VI+IFg/ojnFyyTzDgXTfjUYCYCqXbd51EfcuTs8fuGK6PGVIAgnwSR6LAE3q7OTKpLtDiZ3RYCMIVKMXXoTneIB9aalUX0xty1rumTXGwVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7221
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250409_175631_931878_689B913A 
X-CRM114-Status: GOOD (  11.64  )
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

On Apr 02, 2025 / 16:37, Shin'ichiro Kawasaki wrote:
> The recent nvme-cli commit aec85d96e07f ("nvme: add error message for
> mmap_registers") in the version v2.12 dropped the feature for "nvme
> effects-log" command to fallback target devices from namespace block
> devices to admin character devices. This made the test case nvme/025
> fail with the message "Block device isn't allowed without csi". To avoid
> the failure, use admin character devices instead of namespace block
> devices.
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thanks for the reviews. I applied this patch.=

