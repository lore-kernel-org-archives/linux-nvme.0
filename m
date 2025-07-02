Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE18AC77B7C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 18:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JjjYFjqBaUvCVAewHgQAsYtgAlSAvrQZT+fOk3f05SQ=; b=PT3Qiz1Dm+tBgmuFQDGZ1vTYMo
	etOX7hkoBCUZflMG/Wlb8fyeoFgBFNrTPsh6IsHV3J9Wc3zW4vnU6p+qU2rM8eiPHoale6dPYNk7d
	Wty6HuXPCY2Z54Xm7v+3Af8NmLMP4D8sQJ3JIw8o9uSHBQ9rLbtNs2zL/62fINNdAdeC8LeBQkPiB
	aUqJa/bxTvPW9qiNC4SEpzayD4g/9xfsNNi82Njzzu9hwqI/UI32SDVwFtoYF5aGg0/c8Ki7g3w2z
	jdwxMx365Vejvn2wTMV1KRJBOfkUqUYO17LlLc9qzFhOpLplFZghshdp/LpswkBSuzHT9C4LGdjXU
	AxrYXTZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX25l-00000009FgC-1OF6;
	Wed, 02 Jul 2025 18:21:57 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX25D-00000009Fbw-1HdZ
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 18:21:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751480483; x=1783016483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JjjYFjqBaUvCVAewHgQAsYtgAlSAvrQZT+fOk3f05SQ=;
  b=WqL0rVz/Al/rZflhLeK8NwRtP8Kp5BET/nrLhLXulLLRfqKhJrgWfggC
   1SVja5UrmcUcN8/zs5B/nEpse+Cy+YPx1nnn+6IQsclrSaUn1RxNG5v+T
   ZNzfoL7L9JPyKRRsi8k2gyVqtJClqcP/Fs2q+eEip+O1CNx8S0Dhd0XXt
   N9lF5lLTSg2yz+Tl0QlUw9LVxlhZAZtT1ZkLqLJKE4O7hcK2oqExGviff
   knq23xdN9/f+NQVWxzU8U9UjvBaoS6E4vFd7JFMNnKrEAqE/UqoEnLaCb
   wtkB0u6wqiaeKU6FznEkpq6cgBa8S+bFoL6EYuNvMcInjayh9HyCM4778
   g==;
X-CSE-ConnectionGUID: Uo23O51xTV+u3ZKPFbdllA==
X-CSE-MsgGUID: lGpvAs1/Qte/4E8D+Qo+iA==
X-IronPort-AV: E=Sophos;i="6.16,282,1744041600"; 
   d="scan'208";a="91728569"
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([40.107.93.77])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jul 2025 02:21:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kc2eXywK9V3ve6NMGEBj1vAARdQNZjNYmm+0ch/gKpSdZcXNufqzvP8jJpa2sD7sN/raEQ3VFu8Spfm7pKlZz43lspIoCJs++dajG4IPzm9qOivM8oNnrqP8Phl3uCFW9av+WCxP2d7//fRss7hohdirAr7MbEiZxngIJq0dA25+QjcfzsNfh23BCKpOOZX8Xp7jgfnyaMyzLcX9DxajJyyvzxix02fPXyOgE3uVdde/AgUVdVWbMb7J/3Nk38bcOqebRbu02n4cl6nxC3u4DEhYVV1ryk09i/z9VDVnB3V0U5CWxpbpvtDpt39HLSvDldEMpgNSQ4mI8Er5UodGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JjjYFjqBaUvCVAewHgQAsYtgAlSAvrQZT+fOk3f05SQ=;
 b=wjOMXwHfsTbPQTOFjKOw8QgU7+dX0G6kgVUrHIlhjuf9jLCjeQXeYgGKebHwjrVR5zrFmwvq1W+26XayjT1e52ipG7KksJeSSiNW1xCJfCpDVhNCs8W5l977Oe7u/2nT5cvA7CGLySJPibCRPGnNimOsuxnL+1T8Jq+tJEA1kmechyXgfZBB3gOPceCBfo7CLet+38S5TawttCBL4USs5VpDtfRr0Bln7YpqGK/c2wIbOyoI1cPT0XkW71itO6xgxfY30kxW0gRcxUbbgk2wbW/D1W9IFyoHyW+lWSRpFwPe5gY+mAp6jtUy5zBu76xw3KvcyYmlQU7KrNe8OHXAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjjYFjqBaUvCVAewHgQAsYtgAlSAvrQZT+fOk3f05SQ=;
 b=o4UVZjNmNaxzXJ4zudxbWtxIRTGANzOe6wyso11jFQ3c2mK9Y/JqnDcckp/Z4TMwEg/KkhBWzbTIYACYgfp+QKXVOb/ZGJvXa05K0OHIlLz6XD4Xrqjib8hQd8SjL3MDacxg48LtXIuSgLZeo7sqjkCFdEr6pd+VxjZJXMZX+3U=
Received: from MN2PR04MB6862.namprd04.prod.outlook.com (2603:10b6:208:1ed::18)
 by PH0PR04MB8452.namprd04.prod.outlook.com (2603:10b6:510:294::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Wed, 2 Jul
 2025 18:21:19 +0000
Received: from MN2PR04MB6862.namprd04.prod.outlook.com
 ([fe80::67d7:8033:78e7:9eb8]) by MN2PR04MB6862.namprd04.prod.outlook.com
 ([fe80::67d7:8033:78e7:9eb8%4]) with mapi id 15.20.8880.023; Wed, 2 Jul 2025
 18:21:19 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, hch <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "cassel@kernel.org" <cassel@kernel.org>
Subject: Re: [PATCH v2 2/3] nvme: prevent admin controller from smart log
 fetch (LID 2)
Thread-Topic: [PATCH v2 2/3] nvme: prevent admin controller from smart log
 fetch (LID 2)
Thread-Index: AQHb6uxwekBsdO86LEKXtCaOeLhxjbQeGA0AgAELCsg=
Date: Wed, 2 Jul 2025 18:21:19 +0000
Message-ID: <MN2PR04MB68627C5DD4EEB073CC4E3EC7BC40A@MN2PR04MB6862.namprd04.prod.outlook.com>
References: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
 <20250702005830.889217-3-kamaljit.singh1@wdc.com>
 <36499d5b-4203-432a-a822-95b6d20d458f@kernel.org>
In-Reply-To: <36499d5b-4203-432a-a822-95b6d20d458f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6862:EE_|PH0PR04MB8452:EE_
x-ms-office365-filtering-correlation-id: bf39d407-0f9a-4e50-b772-08ddb9953de8
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|19092799006|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?1kpxJDMVBz/jrNoAX1uoNoxzeENx4W2KF3Ks+le11CvAM3MDMVm5lgcr0E?=
 =?iso-8859-1?Q?kwweIKJdm9psx8nursYlwguS/jO38xhTg7yEoG12QLOYrXOG1G1gjWlxN3?=
 =?iso-8859-1?Q?2PeoHrmqQoWHc5DVHZtkWxcq0aWWF4xgo1c6SRF1beg+yveQEye7WIfste?=
 =?iso-8859-1?Q?5U0XFSVCc9FxJBnNVWMCiGkGI8IppOhxBFUgsFU8lxAIQOXbU1lBUDSVvB?=
 =?iso-8859-1?Q?HS4NizyXlnrP0PSpuNt/PvQ+jyAol+ZJuOPypJ9gWI9XMOO8ZvmTftilU/?=
 =?iso-8859-1?Q?NJR3o+eZ3d/GU2HVju2dx1nqFxE346HHNx+TG05rvdbJcusr7G+/UC7ves?=
 =?iso-8859-1?Q?W3FhFF2gPzSXRAAyqwguhNGqBYPvHWWZdfVp9yAyqYsSG2R7jW6GSYoPOZ?=
 =?iso-8859-1?Q?7aHJMCO2oBW9MJ2N/nOULbDw5FA3heeLtatNa70ErEZUv8F7tjw3lOIlRP?=
 =?iso-8859-1?Q?5xVQ1sX745jIyfSAj9oqVCHZ1FNbjAT7M44WY/crEhqZQh3/oStyF4LG++?=
 =?iso-8859-1?Q?TAGwlqz08afLwDprNO566MoOx2XApDwvVr9hEqxOESh4DSiAkCEM5Bqw6z?=
 =?iso-8859-1?Q?bJO2kixrAxhyvmG6BmGe7uneCPNgmBCJGe57vJwGbtyIZPlIFLKYFSpGAc?=
 =?iso-8859-1?Q?XqNeIb5Ua1dh6bhLQB4NWDKbCgYqkHrEUv779yeQGudGUhbaBMyuTQaqG1?=
 =?iso-8859-1?Q?Gx4Fr0re8huS7QMyN5Ut18v+4h3VRcjF01N/WR/558DXjBp29UHXRzkwU/?=
 =?iso-8859-1?Q?HvXPIlrgp0g17lOMhzIPKLspZniHfLPqRYYT/1lrPPZhjkal2aCVpX0MU3?=
 =?iso-8859-1?Q?k72f1CavjBrzNSPHltF9Qh2z02jx8J8a1lz3Und9dhd4WNr/yD3gpCy9PN?=
 =?iso-8859-1?Q?WW6bAPq3WClxRaU7r6p8u4pb0ItTJ54P8AQv5wly/MWzvydpq++prWPK+o?=
 =?iso-8859-1?Q?xBjZ/605g5ypA3LrvOXAmmAgnrMLVPcwizm15jRrtJpxdmdgfIo5wSY4Uc?=
 =?iso-8859-1?Q?OAgHumF5Foz6GHIgJP9Gyfa+PL9drcJma8Fm20qXIqz+BI7MnzA0l2or31?=
 =?iso-8859-1?Q?dJ0FL0FdynZ5K1eDmNzBLURDXa6gfU09w+pZDsAovdXHHC++x+YxgmxLI1?=
 =?iso-8859-1?Q?jedJqXW9m+2P0lNDGcnJ2hdkedN2H4kTGCypLfkF678wnlM5jU2i9UkBgC?=
 =?iso-8859-1?Q?7oT/3yTKfmeGGEiEM9Lag+qiDHq/XWghsJRrqgqGgqU76L6qzlGwV+GL3z?=
 =?iso-8859-1?Q?PQUvonJRMEYl9bQf3evU5NbSSdjzZl1Q/QNeTYBVvKcKoeZs+u28yhJ/Ne?=
 =?iso-8859-1?Q?c5OgKuCWcbNLOK0LmOTWPBsJYaXPn+NI/wTDRsCV5qPgB7s/b3OwKlwAs7?=
 =?iso-8859-1?Q?/oKkA+xaMz/PfmIBz8xrrdrEkW5GJt+0QxY0arVBV1lKqV2cOpClAthgYa?=
 =?iso-8859-1?Q?fjTSUXoVdBJZr9EcIQYWUa3RSffy2bdF+E7z5+r3h6z+LvBhOFlzjkMGFr?=
 =?iso-8859-1?Q?IpDmLlFGwCwwQvEOWOOSq1wBIT2YrAw6ykHBJs7WEG5Q=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6862.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dTnQjAP9FjDaTAMnr7bjmv99wHDGtN67LYwhZUloCB/WMtQ79LbZCGLZlV?=
 =?iso-8859-1?Q?J1eUkERAIqBXVpfJheuxozfAxDbLSfdVBCHnk6ptz0ADa1B8czoYQ4DDOZ?=
 =?iso-8859-1?Q?0b/LLU/cvnDkF9oAodFB0Tkws65Es0q8YlBbdZB2KOQUAzDgohqsrTmjsq?=
 =?iso-8859-1?Q?L/qT/J9qNXxulYs9qpgUXAXGqEzNC3gQQldP4QU4RLym65dr+CBg0DJWZW?=
 =?iso-8859-1?Q?GgkFFj5daA5DMQYmWnPzttiuoJ9Hh8kBMzMWjEoortJPIb0e/ZrstR0LAg?=
 =?iso-8859-1?Q?KfEitEPdGqnr4NrNNU2eeDH+nGyl4vsX2djcfVgRn2HmNkw1Di/pvEuhTJ?=
 =?iso-8859-1?Q?FEEjjx2RXOBoh6OgdGN1gWyDOUcHUlZQisx1B65hPbJGr9GDUP/Ve7F7da?=
 =?iso-8859-1?Q?ObxbOvm2tddwQIZBUxsaQJUNuHzZRa+4GvmBKUKhkMBVW5bXBNW3hpqf2S?=
 =?iso-8859-1?Q?4uFTwpVWwA1Fg+U+bNsNTlRqdMFAWjbZj0SeQJQYXN613470/5jePHIYfg?=
 =?iso-8859-1?Q?mvABsqSCQZTPpqJ6tKk1hf5mej5A71EaLf1/MwqMiF1x9m+WPJJ1+4RwST?=
 =?iso-8859-1?Q?uKafNoNLiQa2BfZyyGLcfE+P3wSu11kYQTDUsBIgluHd2nykO1T0jXYwRA?=
 =?iso-8859-1?Q?7VaeghZNX5rnLocBVA/fSAfy5XwNWuGhIY500xDow+wK6lCocuqLcjrdBp?=
 =?iso-8859-1?Q?Z8WAkdiTH6lCZCBKXG4iavwE3yxFdVDkk3l2byXKhrpkxpKj0zXUHeTFcF?=
 =?iso-8859-1?Q?wwA3yiQV976Z739oWVEFlsn4c/Ck0ho9lzLEPodtL1sm5J7uG/BoNXHMS+?=
 =?iso-8859-1?Q?JSYhVkI5Urv5NmXuIH+yXELb/D3t7TkHys1gMphvmvHxyA9tm4gv52luVl?=
 =?iso-8859-1?Q?6DCgOYCFBBIRzB0fGhUPnsh1F5kWPYPsMxhZ+HPThYvP0ztvPzhddn7ETm?=
 =?iso-8859-1?Q?2BNQNkqbEpirM2YRUGLXmOwX+vMosqFICLeIQCqgU8bcWHEnw0pOF281ZL?=
 =?iso-8859-1?Q?A+Ssx+0yC8HMcUHVfCigGjqN9/uy6SUcaUqkubwg6zsPGlFPN9qtZQnyA+?=
 =?iso-8859-1?Q?aclwfvdpiAxunrLdBugAHVAWxfAARrkAARjKfFSb9xQxvQTYhsPVQPmESZ?=
 =?iso-8859-1?Q?qhtuYVTjj/0OFGsvsv45kaebNJsoIomjuC3yfunhT+jZv3DNO1FGlQ5KDc?=
 =?iso-8859-1?Q?Z3T6JzymrP3mKHPtOquv/oCWPC6uwjilFdh4y+GrCydfRk5izvJYsT1c8k?=
 =?iso-8859-1?Q?O79+9dpWsGyhJV3OSzriWbXhgMr5fbKgDQMYmUsTmtA4N315cxXFcqUKuY?=
 =?iso-8859-1?Q?gG4B6T7LO8peLpIFfc1PXiciHK7jsYcPsYoCqiFUNWtxtI7UJdfNIBtt1/?=
 =?iso-8859-1?Q?Zvl4x3w3KGFLk9hRn2b6vjLBpcmu2Iv6y45uY1Q+AvSrcZZ+t6c34T/3fL?=
 =?iso-8859-1?Q?8eMGt4CxeEKnbth9nleTYy/l9zETVZoRVtrG+Q95zcyCTGV9zuio7263Cq?=
 =?iso-8859-1?Q?AuL+m9Eppv5NzKyi7yA7RJ9oWbTt4cJx0+P5qbfPHmdDoEwGUCGylqMRnH?=
 =?iso-8859-1?Q?n6Jw9GM4Omh5L+zlHvQoiYaogFpRYG2hR3LadLvkQcEBqJcHZhINAqeXdi?=
 =?iso-8859-1?Q?0tMnRU7oqfnOdrlj5Up3UPW3DHfhSUVkDD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oiCuYua6qT1m3Y3FvJP7GPmRl/YhVQL2lCcGuQiAr65EW0rdZAAu5hSnHI0vxLVoe3i2IC54/x4DfN2jkjOqKSX9t9S3J60yIeyzj6j8g44BjXVNzrPanJB14xTJ0StDpWoRckc+iWxEtbK5I2V9IZAbecHzwJEJTg+TkMBY0mX0zCk2yMYrIe5qItcAxnVsuLd479uUsUVzJ5b8hg5X/ZpDLIsw+OQPO22ik8EeIIIQSBjJKf7xr6ZWep86WIsiW5oALQHZyheCi0Hk028w8Zjint+N9P8IZhBZzDmrtvDxdHl2zI5FUsCPIeBoOIHBJ0uE0bbNbJQCdhi51ojd1AbzFEoPcMqpLtY4FbwJy+VHnzEED8ST57qci0ZxA60cI/F8GdNLt0lsWeVciaASLTVZBfZpOSHXJBmKULKpfLJS+wEr+AfEbAeWIGUE9qj7/U8evFz+jM5SummSFaqp2Xne8mRgdFDRC5zPT5hq4QzuCyBwbJ75ZoPozYqzJsnoiNGaXLFDS3uPH86Nd06JyT4vwv4zm9i10KZ7Ypt/TOQeCgitFMGW8/1mGgM1BK8kSYZ97CEX8KcxENF8ukfxC9BVeGe6CBhiWiHr6Hf7owaYATO4wUa2jumtbqpaXunl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6862.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf39d407-0f9a-4e50-b772-08ddb9953de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2025 18:21:19.5929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73TK0psGateggSJJ3DQV10i7zU6iVpIcLwZMhdrvsui8G/nTAErk8E+gYzEwfINQAwI/CdgWSl/6MgCnLgssjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8452
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_112123_412254_30BBEF48 
X-CRM114-Status: GOOD (  18.06  )
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

Hi Damien,=0A=
=0A=
On 7/1/25 19:14, Damien Le Moal wrote:=0A=
>> Similar to a discovery ctrl, prevent an admin-ctrl from getting a smart=
=0A=
>> log. LID 2 is optional for admin controllers to support.=0A=
=0A=
>If it is optional, when the admin controller support it, why prevent it ?=
=0A=
>This is what your code does... Or is it that at this stage of the=0A=
>initialization, you do not know yet if the admin controller supports LTD 2=
 ?=0A=
Yes, the latter. If the admin controller does not support LID=3D2 then GLP=
=0A=
will fail. My suggestion is to revisit this later and add smarts based on=
=0A=
LID=3D0 (supported log pages) response from the controller.=0A=
=0A=
>=0A=
> In the future when support for the newly added LID=3D0 (supported log=0A=
> pages) is added, GLP accesses can be made smarter by basing such calls=0A=
> on response from LID=3D0 reads.=0A=
>=0A=
> Reference: NVMe Base rev 2.2, sec 3.1.3.5, fig 31.=0A=
>=0A=
> Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>=0A=
> ---=0A=
>=A0 drivers/nvme/host/core.c | 2 +-=0A=
>=A0 1 file changed, 1 insertion(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c=0A=
> index a1155fb8d5be..c310634e75f3 100644=0A=
> --- a/drivers/nvme/host/core.c=0A=
> +++ b/drivers/nvme/host/core.c=0A=
> @@ -3705,7 +3705,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, b=
ool was_suspended)=0A=
>=0A=
>=A0=A0=A0=A0=A0=A0 nvme_configure_opal(ctrl, was_suspended);=0A=
>=0A=
> -=A0=A0=A0=A0 if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {=0A=
> +=A0=A0=A0=A0 if (!ctrl->identified && !nvme_discovery_ctrl(ctrl) && !nvm=
e_admin_ctrl(ctrl)) {=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * Do not return errors unles=
s we are in a controller reset,=0A=
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * the controller works perfe=
ctly fine without hwmon.=0A=
=0A=
=0A=
Thanks,=0A=
Kamaljit =

