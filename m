Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CB2C83F27
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 21:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hc/ZWzYPSjr8kzipctJ2KQTPbYaLu4McG+DXrIXv/Yo=; b=UXNkxCxTf6bhq37aNt+KsfieW/
	p4K22NiW7bq5CqQUC9tUqJzj4BMWCJ/2QlrSktccympqEQ6OYzdLL+7HrehScH3JkSv3CzuEe3MTF
	Gi3Zyda1ZuE7PZ2lbdwn/NSqnzCD29RTOZrIMZBgW+/Am227bY7IWrix5eGALsFwiuCV/OkWAAoPg
	DjC0TzgBWDcBTdI/c6ulVKo30r4HuDYYSN+tnur6PeQ/HzoPI+M2z8jFRBjG74d6ptKLzIg17j7GI
	poXhmrico1QctfVfFgQKC8G79pQ8gHfW/Yq6kTJYjAWN/bXvrfCL0h3z8xxkdV/RYZIRA50zaSMKA
	QN5KYXKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueKAB-00000003U69-07rZ;
	Tue, 22 Jul 2025 21:04:39 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueK3V-00000003TLJ-22TV
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 20:57:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753217865; x=1784753865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hc/ZWzYPSjr8kzipctJ2KQTPbYaLu4McG+DXrIXv/Yo=;
  b=Lz5+e4nP/BoTkoXd1paUUviR+s5zVqwlmihWiyRr37QQBLanY+n+9Gj3
   O/GG+qV15mWSUdwzxclv5RLdCE75RQAHctMG6GMrHDg63P7DlaNGKlbIV
   2MTpSdTBHzEqbpa7j1U1euQ1jC9FrWFtEwteOP9Gzn0mMUzG+c4cYcsBB
   8YAEzTBUQ5wZZUTbok6+cNlCifdzz5K+X8Ma2gWhMm4GYx/5NOsKdUWbb
   +lRnEl4eGfKRkhCcFaTV6BU+kAwyMj/ydbfoDmgFtfT/EU0sqnaX9AhTg
   iDYFuURBCtZBh/2mWVVZiu/QV7PuRzfxA/Xg91kQAw39JSMPeHoyWP8S7
   Q==;
X-CSE-ConnectionGUID: YjnEiGm5Rw+cA2IXnfTA/g==
X-CSE-MsgGUID: UF/n6e6vR6OgugknbZSQEw==
X-IronPort-AV: E=Sophos;i="6.16,332,1744041600"; 
   d="scan'208";a="99415620"
Received: from mail-mw2nam12on2062.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.62])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jul 2025 04:57:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dio/zIqHoHxKyP6azREAP5MDnTgz08gs5m76z1jWQGHcbTUuuZ3KNkaZO5QvZwnfSszXyFK52wyWOgt7vwtq0hiOHqfhgp5/RF1jB8dYuwX6uzq5zHiRT2+hRAYZ3J3LgCuXZLHW84D1UVFIY3+HpcmRo11D/p8aOG1JO+B4fekzlw/Q03cKKIgRP6T77fFaCTEwghHiqgTvrSTTVpvg1222W149SmCU/Mpo91T1lkI5n8zMWGQS2B8nnf0LUu0Tka4k0BMbEd2qXj6jUG17ct8qPhHlCuIVQWlfOvKRUop+ytj070242VIziTJcf9j7tv2k9LABhR6yVo6SpHCKPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hc/ZWzYPSjr8kzipctJ2KQTPbYaLu4McG+DXrIXv/Yo=;
 b=uJzClBdIFCu7X/CBZDSVcCtenp44sSCmMlLLAPKK/rZ+rXIci5tYF8gdogyyf58E3X4dn9x3TLUqBveUvxja0cdMeHhmgfaBqcK3cm26QPcoVrbbrGkWjssLvZCy2jFS0e1ba8eb4aco0oki1KooGUQey3Q5S16ETXSRWOan3tSvT4W48L9+hd1KBgkWzai3l9iN6u0Z30E27HiYmDzB7DMotvfqVPIRgE3pWEDcFmwMnf33EQ4ri6WAC6Zi7AoFTMUFSoXfI61tTpme5hu6JvtG4vl80CA8i0fSQwLVWQ2pzTAS5B59MgffErg2MMJ0iXhS1WvBWLsihHB172Bl7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hc/ZWzYPSjr8kzipctJ2KQTPbYaLu4McG+DXrIXv/Yo=;
 b=IfYe0vMf6gKOOQ0PlWy2MgL036OM+kz8azayUgUypnUVsVBP2cHXhC8hpPpCh4iXK0tjOC7YllVP3tMrjFVyQhEQ4SJcsGrMhtF0S2i4dC9a0hVt7yjHkw/igQjesTEFFMNNygphKlIQFMZstk6xdP1bxVrBuQTZAyohW9s9PRc=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by CO6PR04MB7571.namprd04.prod.outlook.com (2603:10b6:303:ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 20:57:41 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::a414:8a6d:1caa:13d5]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::a414:8a6d:1caa:13d5%4]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 20:57:41 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Hannes Reinecke <hare@suse.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, hch <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "cassel@kernel.org" <cassel@kernel.org>, "dlemoal@kernel.org"
	<dlemoal@kernel.org>
Subject: Re: [PATCH v3 2/2] nvme: prevent admin controller from smart log
 fetch (LID 2)
Thread-Topic: [PATCH v3 2/2] nvme: prevent admin controller from smart log
 fetch (LID 2)
Thread-Index: AQHb93jrVbHycOlJBEC+T8ZuwVvzK7Q9v68AgACj9m4=
Date: Tue, 22 Jul 2025 20:57:40 +0000
Message-ID: <BY5PR04MB68493E6146C3C1A9ADB6525FBC5CA@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
 <20250718001415.3774178-3-kamaljit.singh1@wdc.com>
 <fac23c24-100b-4bc2-ae74-045fb71990b0@suse.de>
In-Reply-To: <fac23c24-100b-4bc2-ae74-045fb71990b0@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|CO6PR04MB7571:EE_
x-ms-office365-filtering-correlation-id: 6f030d0b-3d15-44a6-ac2f-08ddc96265e6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?TDYkK0IqVd6aU3p/+4+oz9Rnbyv/xTN/J/KNapKc5YoXKE6tV74wRC0QM+?=
 =?iso-8859-1?Q?ftOLypCkEzphi7Wfb9Pw2vUggmn6iIUg8YSg0zwwUKupB1ydzz7O+aUjWM?=
 =?iso-8859-1?Q?fT+KNDnuo63z1g+M64E1ZpDXkIvJRTHjxIFDwxoAjspHsbi2xomXsn3Gyu?=
 =?iso-8859-1?Q?G9KdSPI7lgYesfMAdOSE4cDyAgcu9W1bcamTpKcgHT2F31xbJuIvYWlAqh?=
 =?iso-8859-1?Q?uVYIx+prjHXyRH0Uj7f0B2sl91EvtSQOKFhkvRxmqdsWouVFndia5SI089?=
 =?iso-8859-1?Q?CWkDwjfiNcjO/oe6sgMY1I0LCzNkMvnVK0eE7xR/m+UJy8vvnKgNfo9xGn?=
 =?iso-8859-1?Q?qggoJfB1mRkWFpt2j9Ms99Q++pgu9pAhbUQKhM7fAIBxF3+4bxgUgb6LpC?=
 =?iso-8859-1?Q?IXHH8N7FpCz/pTOwt3erMIPIqhsieY+2Ibhj6nq9o6aGwgurbRgZ6ZFpPw?=
 =?iso-8859-1?Q?yDkdsQw0HitVx7xzqMRvJg3X2/Y/D/RHr1tGxDSihV0ADrxSngREJvAjow?=
 =?iso-8859-1?Q?3x66FlvmnaxXvreK8dZs/LFI1VHXmv2BA3OyjN8x+Pih6zKl++KeRu0v7o?=
 =?iso-8859-1?Q?BHq2NUfrIPeFxIs41HnnnHoq6mhB836Zg5yw38ubJetfKlKNRfDEXxIskm?=
 =?iso-8859-1?Q?x06YzqmYlkQ+w0Tyov+ntsnyBTTpXUplBCYKWmS47nExDQt7qgZLVRqRE/?=
 =?iso-8859-1?Q?X874Nesg2pYhWH9Olc9u+ocdTAiP2AapWiyPU4LqPya/oeRZulGLZXlCOr?=
 =?iso-8859-1?Q?zX0hUU9K6rI+9qG3ttUDcG1dz5JH5AXwX7EnNF5Pv2XUBhnwA+/F0U/PeW?=
 =?iso-8859-1?Q?eS547ulzMnbzqPNI3dHolVQGzfYEI0Sx7OvJsJOSlBhSMuGY0tQRNxeeep?=
 =?iso-8859-1?Q?TxUGzBpjcyDZfm1qboLA79CylWL1bbUIRSf+LV84qYvok+zt5YFVCLvI2I?=
 =?iso-8859-1?Q?dTV96XBfoF2y1Kc/OocoVRDod91ZLiUS1expO00MTsPWNwVx+5wxoP6erB?=
 =?iso-8859-1?Q?y/qbBG95ivsJ2Cf00vCeUqzMOjQQRP7kl6+4c4RO9B7g37IJUqU6jwaw4J?=
 =?iso-8859-1?Q?iQCj7VM90wpIdJDZYWwEk5TPJWdA+xFsinfdZOaNG9Qv/GG30WqZk4eUQS?=
 =?iso-8859-1?Q?1+sroahvvWorLITa/ulxcVpzAp2tvMAGKeXnIdqUjXmQpOUnf1Cibr6ejT?=
 =?iso-8859-1?Q?vdZd1ac4aWG/LMgd+WJaCmuhdhG6tUfVtXLF6XFMxgOZg3W/h6D01Qu0EM?=
 =?iso-8859-1?Q?yVvJSiUdxM7VRj4/rAJwNgyngr6TZ122R3ocqwh203d0DUFlaP2ywQJq7E?=
 =?iso-8859-1?Q?+IjORmbX6KMgUlfCa09rNPKeTzLngsB72WYr5R6ga68F5Lo12yIALi5NbL?=
 =?iso-8859-1?Q?FP7LZKo+Fuzh+GPcow6qCrPk5rBbQYYsJIpVksr1Maw6r3CBXVXVA+rz4E?=
 =?iso-8859-1?Q?41XG1HIBYZRInxKpWVT7xcLTh2D1Wb2OAt7HR00+KrovU0KiCO1rSVo8Ph?=
 =?iso-8859-1?Q?X6ZGPXrvb74n0jlBCkV+Eivl3pG9YiiM0G7or+o2cBXw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4TU+qMALMbCM5+rYXdgxgU1vh6gwMr2hfcmZLj/Nnhf4ufH8yYik4ad82h?=
 =?iso-8859-1?Q?WkOkkVCvyewlxYBbbP7iJwwg6r5+1Tv1pCc6GqNduVaFw9ewZXIw0FjKmI?=
 =?iso-8859-1?Q?FxPaXHSzMaWAVG2Z+trg9gfyluPj13myeI48WZ+w8/lEOSkJEKLyce5H9z?=
 =?iso-8859-1?Q?+Lo0xztdVhb+/XV7V3v1S2rGSDgc0oHr54iKaMIakJl7WdBGqZ9VlQXn66?=
 =?iso-8859-1?Q?2aUTkJ0/r+n8auwbww7Pxs0dSu8xGX4aCY0Itj4Xe0MONSUagdVKu6jhT3?=
 =?iso-8859-1?Q?hPbtP13ojPiWZr3PCGJNkCqgJYkPId/Nr6Q4NelRs74eZaZbrgtL3hW8lZ?=
 =?iso-8859-1?Q?4mMKoXODVFCftdBahIu7+N+FcW0S02R1+vx+6FdecXvGgRi029uqy0DClc?=
 =?iso-8859-1?Q?tJQl+jXfpFW04acT1KFHY2b87BHSVvEYftkgK1X/9HYsgdgKluhcEbVDgU?=
 =?iso-8859-1?Q?0sllzdcRktPKH+Ke/pHtaC3cACRJwtTtnN7gdheTk3hQpiQoBXOkbm7Ltd?=
 =?iso-8859-1?Q?R4+sr3kkztlvOgBL3lnUImWN4V+NyultAdzLOFUHV5Kxv8zClXeciI/iz1?=
 =?iso-8859-1?Q?NRPgV9MHR3qkUOtH70oaOCjb0xEW59QFPJpVRX8Gd8vtPbZdf/qbhdEO16?=
 =?iso-8859-1?Q?DkZz75EmYKjPGfzowoqPncCahW+yMuV4SJZyNYIS3XbxHB3Zsl5kBK8DyO?=
 =?iso-8859-1?Q?BbOdePqnFCBvhc6A0SQvt01DDgfeyP1mSBy1PF+D36f2NJIM0oQ8WXi0vK?=
 =?iso-8859-1?Q?BZH0+iNmUYJffEdszzaJgOBv4dZu/8xDvj7/zqkKAjGA9a1TPXRBPuoEjx?=
 =?iso-8859-1?Q?xra0BvvqFt/io9dmIeGiDcKGETW+j0hhJMHU83z9y0kWviyTPz+gw98ZZg?=
 =?iso-8859-1?Q?H6LhniJMUgLAUVJ9Z5HltjH99jseSNaVD1FaH29SQL+9/kCQ8abtI+AyaN?=
 =?iso-8859-1?Q?I+iDCVdVfFUn2u9HtRcAiVA+rM2LHI9z4wOSOC+F1JiifcX8gAksvE0MgL?=
 =?iso-8859-1?Q?Lzw+xl5BpTU/0uw0HDhE3O+ATxPQ2LO5/rq4Oi+0PCh43yf1T4nsc0+xEN?=
 =?iso-8859-1?Q?CGirqnqRJb0JNofiFiy0kT7bNr2KL5XwAoT5x30rn1ha78SeM3eGtbH/z0?=
 =?iso-8859-1?Q?G57MLwc7kAwyl4oSdMslrloujqtGS6QeGSVPoPSke4AjpfUQ/hoiSuQ2L3?=
 =?iso-8859-1?Q?vCbyPbjWuWZTiiLQP8sEAiyKnDKYmtE/7VjjdM65IXjDJwxNhmFYtWpSFd?=
 =?iso-8859-1?Q?PI4UM5y97BQKJwOZ4z5NGPWVjwY4mkkDbcRE30CL83RMyUVuwfOhuhCegz?=
 =?iso-8859-1?Q?Ha9P0VtKzQX7AMGmB8VJAiGPMY0PhJTyLG0UVZPWbm3Pr/tY+GZgyFofBY?=
 =?iso-8859-1?Q?Gikwgsprtkq7vlja1tqiqYt7hAMfwnAia7VqBl7NgkvzIWoZknGB1eaeEY?=
 =?iso-8859-1?Q?DuMkIEC+6/kV4aS3TO0SroSUwcLdh/FabcbTMdmqSjrenmsKrLdvJKZlJ6?=
 =?iso-8859-1?Q?5dXfIqDk/BOyFRC5EaAlhXWJmJDlS9chlsS2pgZTEez7hUsRVPZw5IkGSa?=
 =?iso-8859-1?Q?v1rfD1w5Sf5b0aP0PUun0tUSL2dpw31yw5heR3l1mePtvsrKbfFY5J+vWU?=
 =?iso-8859-1?Q?mWukVyGNqIyoKhx4MW8pwATCu+0cdEsFMT?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SbqoCSbH13GjXjkGk1yYSfDMpOzxlT7mlRP6TWXBW5t0VcIXh1IikiGvp9QmcDkk722KmGW1Ja5Un/3Ei/nkHLO/CIOaSAhqe5KobM2WIwyhW/722XLWCL3SjjXuQ4gwrGx501tKwOJl39o6E2nsDladEITyor4w5oAovN+7+Ij8U1EanJNfpeCGljzz3KyHp/EYfYGQ2ZKNhZs54oDIOUQwwxtGjqSJ+7qudj7NpD36jHZJP3s6qr/YjPiKTdopEZfjynpeE1h6jR95Wz1SAb+3gVuUBYXeIE3P7SOknA1BMynvU+WtpTFGGYY7xX+1V8/WOtM79+4HJmCT8ZdQAomvkBxlPh9PkItdx9EvP8RSKHrxSPmiOf7b6+dFvQZeFeNKaHDxBYItt6/eco8nMzH+eBI/UcRwGVzr2xX2jVodMmDfPvXx3UbuNUTX0p5t0MbgpMxqQoWT9tAybWt+w9YVcUrfEjRLyV7L8wpaamDLeQisxz5tBxe1whTtPXo8MyVOl+GkXmn8VyqgjfaEGx5pDq1jWWrKPneOqakpfvE6O7qclJJgxnjL6w9s3gHX8rF4Jlsb3X6F79NyevrEbNmE5NdhyT8VRwj3H9uG5KzHBdDotzO4qF+IFzvIljQt
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f030d0b-3d15-44a6-ac2f-08ddc96265e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 20:57:40.9768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 357CD0O1Z54dTDjwrxEk/EFkPbPGuBOsUABeU/IyNVh019BM+8qTJCvkuLneBiQCkbuZyC1IsOVg86ZZEQ+cUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7571
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250722_135745_624457_35C7D589 
X-CRM114-Status: GOOD (  18.07  )
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

Hi Hannes,=0A=
=0A=
From: Hannes Reinecke <hare@suse.de>=0A=
Date: Tuesday, July 22, 2025 at 00:07=0A=
>> Similar to=A0a discovery ctrl, prevent an admin-ctrl from getting a smar=
t=0A=
>> log. LID 2 is optional for admin controllers to support.=0A=
>>=0A=
>> In the future when support for LID=3D0 (supported log pages) is added,=
=0A=
>> GLP accesses can be made smarter by basing such calls on response=0A=
>> from LID=3D0 reads.=0A=
>>=0A=
>> Reference: NVMe Base rev 2.2, sec 3.1.3.5, fig 31.=0A=
>> Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>=0A=
>> ---=0A=
>>=A0=A0 drivers/nvme/host/core.c | 2 +-=0A=
>>=A0=A0 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>>=0A=
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
>> index 105127638c31..6e5c9871b76d 100644=0A=
>> --- a/drivers/nvme/host/core.c=0A=
>> +++ b/drivers/nvme/host/core.c=0A=
>> @@ -3705,7 +3705,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, =
bool was_suspended)=0A=
>>=0A=
>>=A0=A0=A0=A0=A0=A0 nvme_configure_opal(ctrl, was_suspended);=0A=
>>=0A=
>> -=A0=A0=A0=A0 if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {=0A=
>> +=A0=A0=A0=A0 if (!ctrl->identified && !nvme_discovery_ctrl(ctrl) && !nv=
me_admin_ctrl(ctrl)) {=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Do not return errors unle=
ss we are in a controller reset,=0A=
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * the controller works perf=
ectly fine without hwmon.=0A=
>=0A=
>And to go with my suggestion for the previous patch, maybe it's=0A=
>an idea to have a helper 'nvme_io_queues_supported()' which could be=0A=
>used here (and in the previous patch)?=0A=
=0A=
That's kinda where I was going with nvme_override_prohibited_io_queues().=
=0A=
But now that its flattened into direct code, that function doesn't exist=0A=
in v4 of this patch-set anymore.=0A=
=0A=
In general, I do like the idea of a helper like nvme_io_queues_supported()=
=0A=
which can be applied to any controller type. But I'm not sure how it could=
=0A=
be used in this case, i.e. for a GLP LID=3D2 holdback.=0A=
=0A=
We will also need to apply it at the right point so a user requested=0A=
parameter is also taken into account.=0A=
=0A=
Regards,=0A=
Kamaljit=

