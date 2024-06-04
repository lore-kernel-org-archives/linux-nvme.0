Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93809C25B75
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 00:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fpn78OaLmrig6Esq6R24y+sM2iYGNmSqUpgtIhoWr+k=; b=d9tk3u7op2UIQmmC5JLnYMTcj6
	AriPOWNRcPBacIXxNWou6qt8MkxMdm9jinFl0aFTxib59S8U0nuEGGKFcbimxqZDg7PEsmwTpG0MT
	ClU+5C0yfcLspe1OQHsdtK+K9Avj1/FgyubH/T1B8za2LOWvtAb18uityBxN3sPIjue2y71Rzq1lo
	RWrPSoKanVU6PudFFBH7hk2cVUIbi52YB+ME1nsBjH+Q38Ns7ir0BFfUfbAYLagcnrcUIM3FDhUt/
	8d7WftKqjYUxjQi85V3alaba/QzIzIKdJxEN8Z6PClwMmIVM+LS7/RwaDnTPz3enyl0SuVEP07qoH
	Lv8V5fig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEHhU-00000000ggu-2Vl9;
	Tue, 04 Jun 2024 00:06:52 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEHhQ-00000000gfn-30uk
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 00:06:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1717459608; x=1748995608;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fpn78OaLmrig6Esq6R24y+sM2iYGNmSqUpgtIhoWr+k=;
  b=NxM/gtWY2KpDw6AuwGisrRc7/VcgBwUG+T8gbSWK00btZI4QZVUuC8oh
   MaiLdOfXpMVGqtBl57nzU0KVfkUgMNxW3huY8qpcJOzDNdxjiX6gBzmIo
   7QFGaTuv09C2VQmctSWphnpZoKUdgUhcYDT2Ue0czPJS1BUl7cIRDWomf
   x5F3u6CDMPzuqTokcffmAM92rLW5OQ6pU409J6edwnVwPLJ337jJ97Zms
   gtX+uvZkyhLmwq/JtaslzlBKDvj2k13+x8TTAYImxpUMr8f60udeRfh0a
   wuLXVfkaikRJGXQELyGLW+GCiA5ckwZCsS5VSBsD7+gT7sEvTZLYIuSl5
   g==;
X-CSE-ConnectionGUID: eVxgFN2fTnS62hHRfT0BKQ==
X-CSE-MsgGUID: qVj42s1qRQCsBK8vgThDYQ==
X-IronPort-AV: E=Sophos;i="6.08,212,1712592000"; 
   d="scan'208";a="18309250"
Received: from mail-mw2nam10lp2042.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.42])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2024 08:06:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8bnvopPYzJRITCDMrBUx5GRXq5mZAiFtAlx8hqHT4x7YHXsWarCVaLLY794St5f1yoVTc5F/QbqMILgJJww0/vXGl9NHNT9XGFt7E3Wru+URasLnZTNn6PsvlNbrcwFlUsWO4i/atCpq7KhUCZig05BZqkqco8lzU48Bh56hlgo52WM+HJuC5HHeDO4osuVKEi+INswQbr6wzdhAnd36gBwtJZz48ugW98x1keSvx/tsu8sVCBUpvYcCIZG9UMR7fh0EBz+Ss5Kv0OAMYK0zgM/Mu0oOsIhl+n2eW/lU4pMujp1sYv7dGs6SYEdlSQrD11OHsCJsix/iVqHMnTiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpn78OaLmrig6Esq6R24y+sM2iYGNmSqUpgtIhoWr+k=;
 b=XMF90B15clpth+d4Qhj347P9YFMrNTzPTH/VsgTUYEA/92i3ZGJ2sksmUGWBbgCSj1Wn3UACiVh4cs1Z7gyyeKPrp0WHogcDzx6pA44raacj4MBEojtDgmnCWJ9APgqeaGTj0u2gKuZyR8l8WMufd1XMbzdiC5oCQZZHHa7kovde5XLb3Dx5i7AzaBTV3jtC3+84rttQTini7i3jqqBK8uFS/K2aypEOt9r9nsHu4/pfjWeNxLE0s6j2V6hziEiCBprxJrce9N1/VQ17bwzkNg7Fn1arahKLzy0QgZhjtdLvFP/hWeiVEJ/tsKjn1gbvh80r5Bd3v7qviaL/fAfBUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fpn78OaLmrig6Esq6R24y+sM2iYGNmSqUpgtIhoWr+k=;
 b=JQ9RcjTANYXB5roxnNNn9R8WbBaNCeCIMosh3QDYt1xRfBaVsxdWhiKThkREzv5ZH9ACTIyr4GNyO25UuCj4Jp1TebH0XZTp4/zU2R8WfR6P5v4gOD4JvU87o/put37K53/cVpAqcCntU6+UbzAZ85M5GuwXme5jXYzMygiJCg8=
Received: from BYAPR04MB4151.namprd04.prod.outlook.com (2603:10b6:a02:ef::28)
 by LV3PR04MB9217.namprd04.prod.outlook.com (2603:10b6:408:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 4 Jun
 2024 00:06:38 +0000
Received: from BYAPR04MB4151.namprd04.prod.outlook.com
 ([fe80::202c:5b59:1db1:25f1]) by BYAPR04MB4151.namprd04.prod.outlook.com
 ([fe80::202c:5b59:1db1:25f1%4]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 00:06:38 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: WQ_UNBOUND workqueue warnings from multiple drivers
Thread-Topic: WQ_UNBOUND workqueue warnings from multiple drivers
Thread-Index: AQHaeXhd/UIUk2VZGEG0Qh+3CF4eQLFAWi8AgAIfawCAEyxD94AHteGAgDDsFIqAAHuuAIAe4uIAgAOMTQCABfkD+w==
Date: Tue, 4 Jun 2024 00:06:38 +0000
Message-ID: <BYAPR04MB4151D34E40AC4A4E8033CB4CBCFF2@BYAPR04MB4151.namprd04.prod.outlook.com>
References: <BYAPR04MB41513F04DB2ECDC3601CC36ABC2D2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <c4057654-97bd-4721-9bed-9dd5ef8b3f8d@grimberg.me>
 <6d3af8dd-30c3-48d4-9083-7f00ea21ff8c@nvidia.com>
 <BYAPR04MB415196EC84756BA1876463DABC3E2@BYAPR04MB4151.namprd04.prod.outlook.com>
 <f5d57e3b-8168-41af-8e36-c7a21ef3a475@grimberg.me>
 <BYAPR04MB415180536421C9B8326D6A30BCE52@BYAPR04MB4151.namprd04.prod.outlook.com>
 <dfb9074c-d019-4a19-83eb-00d93da8dada@grimberg.me>
 <BYAPR04MB41514F3EA640750D6C68AF56BCF12@BYAPR04MB4151.namprd04.prod.outlook.com>
 <7c1792f6-dacf-494c-a6a3-04b48596f903@grimberg.me>
In-Reply-To: <7c1792f6-dacf-494c-a6a3-04b48596f903@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB4151:EE_|LV3PR04MB9217:EE_
x-ms-office365-filtering-correlation-id: f67d4b2d-1c77-483e-8c1b-08dc842a3491
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?Vi9kg8iBql1pvLsmO6Zw3bts7o4UHxH7V9vghAUjbSjc2v5VIfiYKNhFAF?=
 =?iso-8859-1?Q?4qUvWY7IPW4aP6dR3mbO40xlB+m96vxzQXlHeasEDnzXeEjmQqPhYFw+bz?=
 =?iso-8859-1?Q?bNgI5kW96AeatPkoLYkYZUclcc1p+9S5MKb3yGwd2aMTbIi4LtLRZICRLp?=
 =?iso-8859-1?Q?dmrUHehmxP+zn7+i2H7wMB3oWiLpUkuH8QjuMwe/sdXXWLuUKlvIcwvzdm?=
 =?iso-8859-1?Q?ZBJLskVJwtN0JLipWjwtGpgnoayV4YVqbmFddGN8six8qMnA+GGrv55jLX?=
 =?iso-8859-1?Q?V8PGNaPoa91UJu+wirgQUqTH3vwN0CBDiNFskNAzWxhcFR+pkhkuCIHfF3?=
 =?iso-8859-1?Q?CIUNP2kmbAX+6+G0/7Qqob3p4A3eSTbWrcUqRV5bu1lV7TWrXN/CN2ZIHj?=
 =?iso-8859-1?Q?Yt7aW2hqDrKcj9PPt6vp4SIlyg/hAZ+n8SoLejBkj0BgvSiR/RP8vShHDA?=
 =?iso-8859-1?Q?tpN7AYEDB4fyiWbYeF3pX7k44f4y/jnGqW+wP968TcPXy3BSKat7YnMMSn?=
 =?iso-8859-1?Q?smBljvT61g0zLzLoGhZvXdZVbjE4Rfuvnmg/W7N/z8Jge92swTA2xMkyCy?=
 =?iso-8859-1?Q?WjTumZDWhhcO9ZaW51VyMhKeXFT1NhjcbjJ8kfvsP0+O8+j0ML2b0IDpNM?=
 =?iso-8859-1?Q?NuhxZTdeqDvG1ax1Clx0yzANwdPugolxcRNRCo1QPo9j5CS39WhkK9AwyZ?=
 =?iso-8859-1?Q?Ni0z5mOkJeRXYYeRQCEYzDlVZkT7Y68UmJe2LTlG0j7UnUkfv+cL393BxR?=
 =?iso-8859-1?Q?R/TjMDSiHGFBKlhecpz8k3SYgJs5UfJB7iprN+d8m6QbNP8tcOXanjXMZ0?=
 =?iso-8859-1?Q?xP5k4j5VXCIU7lzNRwtrDxZhUBF6eYpNBZ9dLA7jQCocdri7jADPR/M2u5?=
 =?iso-8859-1?Q?Ls/qdLNcBltqbr5WUeXyxzODTxcn6xFUQU6CXSJxXUphawlxEjcx1vWFQP?=
 =?iso-8859-1?Q?mErCmL/heGdVtg6BKGYyPRDFoeE72eq9WyqZK9kjjq1j5er6nYUA+t3+zp?=
 =?iso-8859-1?Q?pdCPxgk2wv4A+mbFZMJo+jfYIaI5V/lMb8+E38Pwa2Cw0riEIsQQheanfa?=
 =?iso-8859-1?Q?bAEDGXZm3ijnCnc3At5ZhEQbr5KKu6v2URl03AvMbl+xYZl3E3UPNAzC/t?=
 =?iso-8859-1?Q?ga8e/pVbW75WRD1GLOjE+RGyhQHeX65550FlVCQv1iFtUbWjKrJNIvqQUM?=
 =?iso-8859-1?Q?qQ0rPmRHbV4G4pTwu3j0Ret+kV57WtFY+W0jf4d1OGd5T9yrVM8J4qt+hG?=
 =?iso-8859-1?Q?lr3bsft32FC6xDsTlS1ypByT4Y1Qs4dAWjWSvicWT9pYN7flKM4F9sMY20?=
 =?iso-8859-1?Q?AgiYHJiCQPGJUiwXv3RStVfTbkZTs9auNsdrcyljib6aNgQdRj4v2HtHd3?=
 =?iso-8859-1?Q?TWQAeABsh/i9Zvtvsx2xjIBUhfABE7ow=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4151.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6ID2PLcv4yO7XPY/TfjOGXckZ5oTV9mC6KwrYKChwkN65NX6/ix6WwbxEx?=
 =?iso-8859-1?Q?C3WwFq77lnhEbvJqOCSWhiGSGrnk3jVsA3H61gAWv9Xlh5xOpWmcgaUMAb?=
 =?iso-8859-1?Q?nFBt55EOQTbxobnjE1UUqXKgzjWHjZlYIFM7tPstIU/pk4CKwC8a/hOwkN?=
 =?iso-8859-1?Q?PsadFabB48kajqPls7TdUtB3/8wYTxMW2/scVPzjK3TETXYwljGr65dIGu?=
 =?iso-8859-1?Q?WnNzGyl7fpaeCbHB622xLa94T+sqho/i2JdLk5MkNTABxEvWykYv/tvYNM?=
 =?iso-8859-1?Q?cc0KzVX7lfUJC+xtpQx6xVWYm26Mtf0zox7RoIXzLlNZortvjmQ7K3uALS?=
 =?iso-8859-1?Q?jN8RdqGRET9Z+Mwx0FFTSTzZZJs6Pf/EjF+orpY37C2m12MjwyeHiCTjHz?=
 =?iso-8859-1?Q?soWOpVgxusAjOjk/E4dJ++gZvul4Qt2qrwPtu74BMMC8QY4/Ot8ZJqsSV2?=
 =?iso-8859-1?Q?xqndXPwmiaBb2yEKM8k9bneiSnt2o3Do6UnSHNWtvqp1rJuPIxSFM6YCx/?=
 =?iso-8859-1?Q?zckLyuWGbP7fY3n9NYujpByHdV5Yte+/4JUFclcSiluEZBGJ0q3g+n1KSH?=
 =?iso-8859-1?Q?FIQe0za1P/ZH7PUris6yRqZ0Q8JXKbTNa1pHC8En4OuTLcAtY8WOgrQt+R?=
 =?iso-8859-1?Q?75jnd/iVdP0sjFoT5o9TCGayfhV17WIsDlKiJuvBkIpEquAGmfvDqjLMSX?=
 =?iso-8859-1?Q?9hStMZYfabeh98qEzrEvF/0G1WogIbA63jWzf7bYOlK9vmfPq96XvgKnWo?=
 =?iso-8859-1?Q?jNfJmapwrNGK2goGnSV0R7iUBHmhJRmXL1P64CeS6fakax8PlTt6PN1FXc?=
 =?iso-8859-1?Q?312u8Uf1RrDmc6IjI7gHh4glDvKil9juAj52G/PIuraxs0IbZd8MqKHrm0?=
 =?iso-8859-1?Q?5T5zZYI8YlDwGoe7nu/tEoT+Qr+T9eH/9u+LS/GtpwpUFMEGl/OleuctT4?=
 =?iso-8859-1?Q?OsgRmhvlve+FOKsDYtQKBce2Vj2aY7XJleiSWJRw34cdqO0Kjx58Mu86qk?=
 =?iso-8859-1?Q?CMf4tvk1cwGyWqE2jU9VRiKC5xRgY00TVUk5F84JQvpVl2K9PeEO/C0itM?=
 =?iso-8859-1?Q?gCqa+o6Md+4mA9XfkNFIEAJutC2tLmjKBGjhTldSRhvTZfdPl85XjG8nrM?=
 =?iso-8859-1?Q?f8jdoGnG3ibPWnWck/jVIgH08EJ0VxL/B2dsB0xdg9bBbmAfjEAcbdsWEb?=
 =?iso-8859-1?Q?dX6cEdq3MwsgEzliIqsyr9a8ZCXTElV+TGjg4uqPZwLo0Fgkp13DlLmhkF?=
 =?iso-8859-1?Q?nvRluFWJ3ULqPicDBTM7dTZKpeNLgu1oEO6OO9ef1RshSoI0yVPqfCQuuF?=
 =?iso-8859-1?Q?SWtO4SP7zLGkEqlDZueWAQDHeWAo0o9O3pEUisEv4ql55MVQsPPfw3d/TR?=
 =?iso-8859-1?Q?UJ7+q/JKp1YvUFd1Q+PdGn3b0R+CbiA1v+d2PIAJf8b+aCQqjoh4kIq3Ho?=
 =?iso-8859-1?Q?+upwvNIg6BW7RfrT/V6zFI2Mlt9fgSfrX0vXXE4ngnWjVRWNaKmKX7KeKT?=
 =?iso-8859-1?Q?0RWCx2rIvyep8Hqyp5jUe9Xq6Y7zXnd/6SWkcdIDmnnVRYYBDKjHeXdi3Z?=
 =?iso-8859-1?Q?VLMZ3roMWhSeOWxC97kpZkIiE9fy8+yY9UsenYxGe32SP9hR7+hqTJk9Eg?=
 =?iso-8859-1?Q?XBcmKwoxYk5aF730DqUhAqva4Z4d92NFJE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aIS6016aazQx1utkDFxcCDB5GHDKRJpxaOII2ROkT9ulFr4dMRb61GYV3PJKR2nDFYvzD9qJXM+vMap+C6STV0klpxe9szWr+s6g6TI0npKwCCLXOBmjfLRXBM70+hoN+L5MFviNfa7UyoyEG+yechuPPdGAv7qlZCFympD7T492I9MZRwUeChBicdxZry6dKC8PcUAKPtuYcw1aArr+Hu7hHCecaTwZhgF+fPIDHEhTwiWcSnpQfrKEUNWyANVg9whQb5z5UdzAo0KGKO0dSo7RxZhsqo/JS7LOvd/djJ7aBlr86Ubg38m08MJN2lkgbd9CKuEgirhW+DYCWBwhu0Cyr8PgTDO/SzDRHv6myAv3lZwxANjCXnawdsVYpRyl24ZQur7lsjw/9U4Y5OKfhVMuFtGRg11xfR6Pez9omzd1fPPAPEfcWK9nFsKeNvASRd1J97EE+htn7bgeWvw0xsOQjX8AdK3O6AAdJ/uAuo3R/+nSW1zRYGO7To+zr6FKNBoA+wnVM3u9bggBga2k4n6KWZBKF/5wZu/uFgTo4LHvSiP6AiLete0hdAQaRAGhdV3vJK2Kya4J+XhMRY++LJ2Dzg+fF7V088qitXIVX+PY3Mqi6oDSsY0SFhQbvz4N
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4151.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f67d4b2d-1c77-483e-8c1b-08dc842a3491
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2024 00:06:38.5085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u0mT0dJv4n538nLmiMWmENvhypNa0yGEmTiqobtH9+QmgbPeEbLKFU2wrZTJwZY6Tf58Q6DfrnVmWtKQUjpNhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9217
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_170648_801169_BE67431E 
X-CRM114-Status: UNSURE (   8.54  )
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

>>> I see, what is the mdts?=0A=
>> MDTS=3D3, i.e.=A032K=0A=
>>=0A=
>>> and what are the r2t lengths the controller is sending to the host?=0A=
>> r2t lengths are 24 bytes or 28 bytes.=0A=
>>=0A=
=0A=
>Umm, so your controller requests 24 or 28 bytes from the host at a time??=
=0A=
>That's unlikely. by "r2t lengths" I meant r2t_length field in the r2t,=0A=
>which tells=0A=
>the host how much to send in a h2cdata...=0A=
You couldn't read my mind ;) ? JK=0A=
The controller used requested data length =3D 0x2000 (8192) bytes=0A=
Sorry for any confusion.=

