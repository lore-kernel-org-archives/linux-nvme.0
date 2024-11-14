Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34765D65C7F
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 11:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iL3kAUuZ6rjhquaD/L1M7WjTHz9qgDV+Cm9X01csHuE=; b=ehm6RfOX6xQqPvH2rTpc8wiO89
	gARULxZ8iDDjd5N67LGR5AgV60iXLT3mEKEOlDd7neIHUAzKYq8EiDHOg1nwMeSE2Hc2Vf1RIPGTk
	ZEU+6cLidl90nNer36YJbnHStY1AX85tezkUHJBNuE72SkKcG+JQnGysLUHXN1UwcAAAtFOv6US+R
	Vn8zdHpkeZv77uPFW6E5JhcmtrGtbE84cwqehoLKSA86jt375j9OsLPU2V3npRZF4e0/pnI3+AzA7
	St63SrIDJXDIXmQ3gDVbjxygEvvEN552SaaEmCpmeXAtilioaoBofJ6BNT7YtofwW8BxCXRUrmT27
	JygBz3YQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYMM-00000009mzq-1Yd8;
	Thu, 14 Nov 2024 11:50:02 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBXeY-00000009eeV-1sDH
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 11:04:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1731582286; x=1763118286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rf1pOgtcwlcKg6/UZHe6yIslerLl4B12Fkvyq+bekpU=;
  b=hOaKp82XH4Y0NUif0oiSuj+4nu6+Saex2kTS+tGvJ9+gRjTZ0i5NUKTU
   cRaAQ1uhzuOZFcAbo3ZwAx0gNa8KYqFVhkEjjyyIUWQlRWv287lotwf8p
   90+KkjqOIQiH1ApNlt4ZmMcbe8fdbZP+Jeyumwhx1Do+RchRiBHeXB3/r
   wWWf6svuCYf6rsAgQpX9P2bsyefkEueBzpDCORb1aDKs1b5BGrqUMJVRJ
   aReW0VKewHXhqqBvCzS1tPXmScSQlytBDBh6JuggpU/XmbVbjre1bFZKK
   1HuJpqQJ+FHNrk6nS9jHzu5vAmrHoJzdk6ep35U+6oOqwI6z5jL9WtI7b
   w==;
X-CSE-ConnectionGUID: KemS2v87S2a8YINcsditbA==
X-CSE-MsgGUID: RhfKHxQpQz6L2A4QBVqdbw==
X-IronPort-AV: E=Sophos;i="6.12,153,1728921600"; 
   d="scan'208";a="30847043"
Received: from mail-mw2nam10lp2046.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.46])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2024 19:04:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HD6/QpZc58GidWJR12ZXfHM0MbKI+XBaXlQeki00d7OCX1dsY7NhOSLPSOJCGskgjZK+FqwTDa4yn8HATs9+KrGSgzhb9T5kXLXA4Qc4pgLV6Sebq8bdotGrdHQMzE+4MX10uG/3Zf8D2AEcybF7VBP/hg9Xchb+93kd/jSbGIjbrE/02vgenzJ7JYk6RHkC5vfgPor/Ko/iyhH97qVCEcPPxzltA1xt5ajxHHY4DJJSQLkO8CSQTpUUbpwIKTjVgY4fe8hMWr02QoLy2+q8yfqy0eMboUlOleDFhKdKS74AUim7R0TTEmMiutizXc5Js6fPefL6MfWqbsVz5QA3qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iL3kAUuZ6rjhquaD/L1M7WjTHz9qgDV+Cm9X01csHuE=;
 b=W2kCQtsptLx97ecR7AWDcsBXxE1VQz0ahgAVXQdeey+aY4hmfTA8znHvCcAECXwNG8hgxiApyO2xE0bwzkA4D/EiYgDVq10drnX59Md1qkIrPSdGj/vt8aIxjxxy8dzjcWZH+RwgQG7ZdBObptAvIq4MuR1oHT0i8ghvx7NOh3axd0bK/rxTe8nXzYxCEywnMd8l9uAq3QpAL1muGNkM/O6nqgJyf3iZj07piSx0DXKSkdoDjn2rfQDOC5l4NXWi2U/THy64V93dtVWMryJCS9qu7lrhYpRtPKNmDupotRueZGUJYg6IY3OzWJoxHQvtsCBVT6xjnpOdyv+2chALPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iL3kAUuZ6rjhquaD/L1M7WjTHz9qgDV+Cm9X01csHuE=;
 b=G/HWnp4v4J2kabMbRiOU4B7gsTlkCgdvkLHOameUpnKaDDSw7VJCznPq8+tjDuz+CaQu9KUsILsjw6nITW+IEYFq9l98+2Sdi7jbFZ1G/5LqDDWjB+HRtJ2pVaRspoy5/VeNdrL7pjJstzGkiRfopNMw1tPdTQAhAy6XNhJ5yWI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH7PR04MB8612.namprd04.prod.outlook.com (2603:10b6:510:245::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.17; Thu, 14 Nov 2024 11:04:42 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 11:04:42 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 3/8] nvme/016: do not create namespace when
 setting up the target
Thread-Topic: [PATCH blktests 3/8] nvme/016: do not create namespace when
 setting up the target
Thread-Index: AQHbMQYlzkRt0qRYHUKRPggMis7nC7Kx6ciAgAS+LYA=
Date: Thu, 14 Nov 2024 11:04:42 +0000
Message-ID: <xn7lzzin4xzspxoc3po3pgjapevehmfhts7efjch24pudzepjw@jabgurc5xxx4>
References: <20241107111354.80606-1-shinichiro.kawasaki@wdc.com>
 <20241107111354.80606-4-shinichiro.kawasaki@wdc.com>
 <585ab80b-7a7b-4493-94fe-9b9cfdae75cf@flourine.local>
In-Reply-To: <585ab80b-7a7b-4493-94fe-9b9cfdae75cf@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH7PR04MB8612:EE_
x-ms-office365-filtering-correlation-id: b5cef3b0-555b-4c23-b486-08dd049c2413
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?VdBClEv3bXj3eztPLXbR79SFeBWbjxkI2lFkiJiVRsRjKNhn1t2oKImvYsY8?=
 =?us-ascii?Q?vt2YawxsrGgTTgX3CZIn4Mb2UfXY0iag9IQ/HEgcH+CFaIwt5bg61GeNnYmF?=
 =?us-ascii?Q?3uDDl0aGL9zSRNqROQuaW1eDl8E+AFvHbq1dG4k6c+TpWJ1NCjo8pyR67SeA?=
 =?us-ascii?Q?N724L1x55hOrcCueu4kIfvVGicW/vYlH09pNKI8YPdv2BmHKOe+xlrqzkaNW?=
 =?us-ascii?Q?RhfpfA9K/1LwBtdGwVFDJpGj3kF/i10td1DkmrD7GRE0bkpIr6e6vfE5oesw?=
 =?us-ascii?Q?rsXf8fBwNq86oSpaL68KWQpAqnYvZrLo/RqTij2DNgwoMb4TPQ40Af1YKytg?=
 =?us-ascii?Q?A1jOfIf0p+rScOabZKwxHD0pQckIu+4zfsmqYgoskd6yTVsUSB0RTW4hF5+H?=
 =?us-ascii?Q?47IWYzwWE04TMou0dFGrAFiRFeLbIdjdiIeCAt9T08I/hepP3hAvTGrW+9b7?=
 =?us-ascii?Q?7u1DNkqjIW7/T9RTV4E0L9FDaeZL8CuW/58UVOC3pP7e02/c1XRT511nVUnl?=
 =?us-ascii?Q?P5fm+ydeApacrNzWbqIaaVP/rLFjOixURKEzKg/L87avIrsNZOZhjIJqvNGC?=
 =?us-ascii?Q?8j97Fd+YDkKecFQhi2MnRaBfU4/F96GFO8nM7Hn7sDqkp8/GxEG+Hf0TwXCm?=
 =?us-ascii?Q?S93jwOY+omLwYeNdXr2pv4edP+qy63/9PutBDd6XbPeTxoZARml458Z49VLY?=
 =?us-ascii?Q?VLalmTzzDngMNt+usjoY3SeeHh6//ckfShM+3xqTO3dJ4TWk5bUnEP0Z83nf?=
 =?us-ascii?Q?wYPovWwLy2d0VAiGdPtWl5QBJqbWFE5FmmBy5qiJKyi04rK+JNaCWb9UM0L8?=
 =?us-ascii?Q?LULj5KJdwz1yWQkwHDsSzLvpUW8P9TUgNo/R/Cpoqecoyq+cGRfOpDJgdPNR?=
 =?us-ascii?Q?pSKhSrFiDQrHDcl1zaf5X13zp7Mzf5SRAxGgYEI+bweSB3AgrhHwBsohXvbO?=
 =?us-ascii?Q?yuMgsY7W8zWzvOhc0muR0/QnjD18c72WWALwjjbZ/Hui0YYMnvdNgGHOq0Jr?=
 =?us-ascii?Q?cMyyWA+AzRUhy2thfIwhChRfWRa8kBSVY/QcRW1z4gHFjOcOdxA6+Cb1No6i?=
 =?us-ascii?Q?tlDSPHnB+TgmBtufMaBiRTdP2C1QhMMNGd2+KBL26nxrLDXeiN9pp5FbAG5/?=
 =?us-ascii?Q?OOASLiOJ/b2Tu3OmYTfR0A2hPg/2ZfAqHgCIqgErIKq6eY+GUXcjKmw7W/3I?=
 =?us-ascii?Q?NcbyRY1Z1ac1vanEBUvFeqrAYyLoNZc8AJzd8kjcSBWzWU3qUXhLEaXEiUce?=
 =?us-ascii?Q?8tSr36pOCK6k6m/Ner2VP2V4XzTqVTmHcJQewAL6TrdJ3oMJ0t2Xge+Iauj0?=
 =?us-ascii?Q?h9d3s6qT4sM+tDUz9YtcBL8DzKWU8EWpHORRCsCR1Ve12OXKwAfjYxPdPVQG?=
 =?us-ascii?Q?3SEL1+tMhtL1L2bZp6XzuOPuacvd?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LfMGEntp255kW64Fp8VvAH5aT+Xcluf5CaiJX6+f/ej/xJSmcq3XwWQPS+Nw?=
 =?us-ascii?Q?djpCTlbTp3mpt3w2v0XBldNmF4/4c1hO0lJH/+hH0FE57ngoA76cEsJyQIdP?=
 =?us-ascii?Q?k5QHEBbsTVatIVTa26HAgngksRVpXJGl1bsN9W38F7HRuv+ggRFJDfXVQNlE?=
 =?us-ascii?Q?+bzVTgEUtvf4g1WO7+x5XXnOxQvexSaTsH/idK1ShEcAzOcgUk+sfP6fAJDa?=
 =?us-ascii?Q?Rbi1oYl9T/SYl4zw+BGCXf2jYq5CHjctYDWVpF8cn9WBEEaq9ybO3Oa4Ssb1?=
 =?us-ascii?Q?duvAU1jGNH4SDXig/jU7u0E24C1cf50hZXL/2iMbGVivGHj4e688NXTXDOsN?=
 =?us-ascii?Q?izXKGK7e0ZjU2Xv09d9In2Pu1b66okzY8rr0JJqApyr3HPPo92FrnqwX3cY0?=
 =?us-ascii?Q?HmjmdKm2yE16Jf+gAzMaHxp4CM5gIz0kMd88fua/wSyTcthGjpFQTdeWbH2b?=
 =?us-ascii?Q?MKCrjO5cjul353sk2Mh5qmyedzs16davfXyjxJ2yO8Q4yj3nLdb0U0SiaSCH?=
 =?us-ascii?Q?Bc1UoNKM6dduSqTERE0Kc604Zwi91EMwzbqFccJTodLVcVE00nVCkGMyBGTi?=
 =?us-ascii?Q?VHbhCBJA3BenTCgie3j6+xpQoKb0QBBl4u6tbr+sBQVxhfkbcrvEmP6czYV2?=
 =?us-ascii?Q?eOVef7kgehf/i8kg3RoLV58NgSXWjlPFy8mrTgUnNfF6K6suyLzDwZY0LORg?=
 =?us-ascii?Q?th6vP32WC1iLKt9xInTMRFOp6FcRgHh2E+dJnt7GG6+50QrMIf3ybg3xE9mU?=
 =?us-ascii?Q?28jmWPVTkTaIWbisBxz/nU4NoGV0shkC9TkAo+e8bd1+GSq059MEEl3X5yIZ?=
 =?us-ascii?Q?k6kNcZiZ6aam2VrpSeZYrW5JULM34el6C/W9W26KWfavokcyeDZA3n5NoA9e?=
 =?us-ascii?Q?Fjkrz2eAMycUvJE7BByyl4cG20zYKGNgISbARzoQsCIEiDyRh4vUxkWbwHpT?=
 =?us-ascii?Q?Ps5aANlXE5/+aKb7UPQ+oHupr/zBzIMjwW0zOcBaFLRWInoj2YHn7IyjVvD6?=
 =?us-ascii?Q?LQMhvhm8icw+wkEU7QYOea6gAQGLN/1n6nMsegQZvOxUUVwUiMGTDiUqb2dR?=
 =?us-ascii?Q?kF+b+I/yU+2ozbHIKu1RUWKPjccy8l4LLP9KTtSktOSHG0LruQ2cb32YSyHE?=
 =?us-ascii?Q?tZgSS5oILLNT2P16Xta0BX1apzWWE1Bjy0Votk5uryRYmiL2F7SJGesE181r?=
 =?us-ascii?Q?kWp3Zj9Q3OHC3yzoWt0E+Rd4OLcrQc0H4eQi01hOqKw3lU6wvguuAV19U2+I?=
 =?us-ascii?Q?crT87D1GRTYfjc0LxHh4rqm4uDuHE2GsOuF7hxznH48WnChMjBI51rFllAqM?=
 =?us-ascii?Q?xtTSDDiYI9P0gMWthTcNOq83jz53D8EWTO2lJfRyubKKYohKR91RadrwIpqH?=
 =?us-ascii?Q?3pzxKVWm5a0tVdIrr7JDh/Q40HEDSoyMGFVUADKK9rjk4LfFiZoOuBNYWeT0?=
 =?us-ascii?Q?Jnf61ecSXmeX0oImtRnxFF1bIrhrsURNpjXLGmkn2MOxYehRFWLmtFaBt1RC?=
 =?us-ascii?Q?Eel8eKzYN0a3bArSf7Is7dzcFCpesngTBCYGPZJq2TDEkf1id481taA4XnxF?=
 =?us-ascii?Q?Y4KH8Mwe5WIx64tDEydttDk9hlNU9t5qjIxFVQe/Izl4yhA3r9/X17iVv9tl?=
 =?us-ascii?Q?zEDSFvf7mgn5Rbuf5OJRvMQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <445D22A05A39CF46848E06CF918B6639@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qZu2Ptc1YTfiN3lvX0tbQIkbCsRD22KaJMkebjL12BrT0UvDAGBXqW9iLEtKIhKlau1wNwBaKAHN2jZ9ROgamcUMpjMFg3HHoyaigzKKTetmponjUYdWMH8dXY4F+qYL5jgzCQbmeZ7zCvqiRc3kfd2uLCG3iY7baASOWSzr7MsH5X/Cyme2iWgSjXi52wrOLlf1LMuFrPObeeYSpM80cFLULSZb3RFc8ctavXjXAysdIrfSwlJIamZtrCmggdIKXtPpEFRX6Ez50zJ7CYgNMY3GVZD0DegIKKH0boEme1orGUlO0XHEez49KvORzzr1nwqtJ4ifnMOh+R55s8d9sv7DPHvvty57SUYB28VlLdA7Qsgy4iLe+eZwqMez4hqXB0C+MjOBRlCyn2Xs8jT0+lvUW6Z7tptxwoPKI40dhl/O92lj4DffQG21yKdeTkkvChvO4qXO949DArvPT0GkNTWBm7bnYowK3rAYCdpF7nepl9UvGsV4jPLqPXLwTKjZ+NV5GHRH4529R0PhSSBTkeTZORunUsJ7am/K7xegPDRqECXknvkDu9zdYlBln9XMjvdYrBHGGtArRPaF48M+M2+hAqs0zymRxdSZG5nK62n6xejMdBczbYqok5nIfEad
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cef3b0-555b-4c23-b486-08dd049c2413
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2024 11:04:42.2745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +aKAv/clQzE1TbZSKOnaJbV0sFDpWPiyKCGIWADUQMdyj8fTQPM259urZK9D530ywVPBI2SS2mCZWMCq8ZARx6zBpT7vM4cHVX+92a3UhN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8612
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_030446_627945_756504DA 
X-CRM114-Status: GOOD (  13.06  )
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

On Nov 11, 2024 / 11:38, Daniel Wagner wrote:
> On Thu, Nov 07, 2024 at 08:13:49PM +0900, Shin'ichiro Kawasaki wrote:
> > -	_create_nvmet_subsystem --blkdev "${loop_dev}"
> > +	_create_nvmet_subsystem
>=20
> After reading patch #5, should this be
>=20
>   _create_nvmet_subsystem --blkdev none

I agree that this change is not straight forwared. Please refer the commit
fe6cd136 ("nvme, md/001: support only long options for
_create_nvmet_subsystem()"). It was the last commit of the first series [1]=
.
(I should have included the patch in this second series...)

[1] https://lore.kernel.org/linux-nvme/20241030065149.2297405-14-shinichiro=
.kawasaki@wdc.com/

It added one if block below in the middle of _create_nvmet_subsystem.

       if [[ -z "${blkdev}" ]]; then
               return 0
       fi

Then, when --blkdev option is not specified, _create_nvmet_subsystem does n=
ot
create namespaces. So just removing the --blkdev option does the change
required. Same for the next patch and nvme/017.=

