Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA743C636D7
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Feb 2023 20:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KmguNuPy1E4uQP0wEiqWR4Jlvkj90b8bF2anJtPKlME=; b=S6fmpypcmL0ZkLpWjPY9o4CQIu
	d/l8Fkcy1vw9+vyoE4ye7cozItS7Lr1xW61lT5l/B8aE3n/t4B7AgeYNDe3ff1L1ZfGE6nA0YvX5v
	q0M1RIniozAJkfXrMPAdprXAY6xBcd7xdU9ut7B/qedmbJ4SX4UxCig0QbAwx1em+dTY6jPQ6Rrk2
	g89PLaDqDRAlQdp1jTIBfxwCNJGJr8zMsV6mcfqUo+ZViVrAvq7JwC9rdo2aUzHFqP/rRNb6Zyg/x
	7I9u/ZG7Z32xrBWaeaO4DNn6ruhfDOHKKFL+Wz96QaKwkoZuLgrWFlLkmGdFFOuMzL9yjfPhgjR9V
	k6LXzqPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUZV7-009jYQ-NX; Tue, 21 Feb 2023 20:44:37 +0000
Received: from mail-am6eur05on20720.outbound.protection.outlook.com ([2a01:111:f400:7e1b::720] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pUZV4-009jWY-JY
	for linux-nvme@lists.infradead.org; Tue, 21 Feb 2023 20:44:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EYVd9qQo0KN7UIBhH7vNnWsnZbLkswFm04/o5bDIfDxkvHGO0KF4bEfFr50wTVWnpvHe3Ozex/yfGNzMJKD4gVQuSLd7hcfUnGE0FyAHIGal9lQvy3pzsRumJlLELp9RjAyid9FRarxCOjdtxl3unHaMeUQZmNBgJV1KR6P7TUTq/zTrIuTyfZJpUHM8TzL+Au3pHs/RpXh4KqWGiaWDan0Tpxs3pOMEro2kTUiaRco6PiDekClPFCB3CUipocpYNsuXk05C5LKNTB+3+rXd1SC4OKyBtL9JUZsoibgTWPuphSxxh1PYi8hNNL8MkBoJR3i+6Fa4xwx8755JTs/ScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KmguNuPy1E4uQP0wEiqWR4Jlvkj90b8bF2anJtPKlME=;
 b=h1lebsLkmYHaZIZnkGC2MUgG5KO9FCy7vaTgA3U1CT+uvomLgOVq0VujvWAKXzNKMkE5nCR2Pzb7dsO/B85RPirZw4Bn7gLxfx3FqT2RPEjgASvu9eqOJgUvlqsJcqzCyQtdXebNZJqcMyqK/JyPqhDX5kJ1dLfRD4hLJfgcZi19z+04d9CFu/j6MoVkE/Rlybq9sEIA8vI70dvtw9dwuSqYDbAyJBYDMdk/TMjZ41wl2Hgdi1WHI6wZ9sGTrAwQv444sXhJs7fSeyGOfQ8elVlihugmdjR6rLc6rpfVUII1SdJKMBuNKqi+QtUJ3LLlhIQ4iLjB6FxDVI3G7wcnOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=edgeless.systems; dmarc=pass action=none
 header.from=edgeless.systems; dkim=pass header.d=edgeless.systems; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgelesscompute.onmicrosoft.com;
 s=selector1-edgelesscompute-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KmguNuPy1E4uQP0wEiqWR4Jlvkj90b8bF2anJtPKlME=;
 b=hWNfHjruEZIkZM7VXF9ye94H816xe9mb6/e5/efw+g0sqO+jV/CY6zuo/9+tCPs2IIHl+tscoYMYINVvHJHssPUws/W+IvFfO0Db1PEDjwazcRQjuIGo1iD0dimRLf995zSSCrU4QIWOoqEmeLWXUs9XYYL3HB8U4u+XIaglikg=
Received: from DB6PR02MB3128.eurprd02.prod.outlook.com (2603:10a6:6:1a::19) by
 PA4PR02MB7054.eurprd02.prod.outlook.com (2603:10a6:102:105::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.18; Tue, 21 Feb
 2023 20:44:30 +0000
Received: from DB6PR02MB3128.eurprd02.prod.outlook.com
 ([fe80::4b7b:21bd:6058:8763]) by DB6PR02MB3128.eurprd02.prod.outlook.com
 ([fe80::4b7b:21bd:6058:8763%6]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 20:44:30 +0000
From: Nils Hanke <nh@edgeless.systems>
To: Christoph Hellwig <hch@infradead.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"nils.hanke@outlook.com" <nils.hanke@outlook.com>
Subject: Re: nvme_scan_ns does not remove stale namespaces anymore since
 kernel 6.0
Thread-Topic: nvme_scan_ns does not remove stale namespaces anymore since
 kernel 6.0
Thread-Index: AQHZRgBgvrCjXMW6CE+iIeVwiHOmEq7ZriCAgAAwaYA=
Date: Tue, 21 Feb 2023 20:44:30 +0000
Message-ID: <CCD9A3C1-AF4E-413F-82B9-BEDB6CD3E7BF@edgeless.systems>
References: <CE04FCB1-DE80-404A-823E-5B164EDC2A50@edgeless.systems>
 <Y/UEh+lh5RT+1uAP@infradead.org>
In-Reply-To: <Y/UEh+lh5RT+1uAP@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=edgeless.systems;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB6PR02MB3128:EE_|PA4PR02MB7054:EE_
x-ms-office365-filtering-correlation-id: caabb6cd-60e1-4ea7-04d6-08db144c6e60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  bmQ05lu082M6FaHMcD0HIidzImMnF5Vr03aITr7f+BLhJYq7exLBwTB++19gpy9iVb6IL7Ccm9vEGrGKnlYnI7DNjOmM61m1FudlsPvmvlYfTKZOEzXaYz7CDMaXZeMCQjTNinWtyPn2YdEy4qIZ6VqB4bJ5xtLr2HlNbV25+7wlTWmCZElTaGZWSjabqvZInMPmVX/Jc7mNt+8NyS2dY7/ydhAq0Iy36LEEoNH3/5TxLwVHUpinsz6kV+1+mApwYDKS9w2IG/DiuUngNjbL7ru6W/ySehkIMQlJ6JmdLF4HZv/IbYb0iOFdc1Ncs1abR2n6dE3ZXnb/snA1we6VHJInc1LtK3r/BkY98cqLvKr3Mxv3AyOrW0BcfpdV0nRwUyyro9Hyjfj37NrTxTa5o1yf3ZWWycUSklDLl1d63V3/JcUY88dO/JF9ZBdPQKlrZc2j3xa6W+yetmaF9CbEvrFoPAMCnSRqGJTJV6MRjamqoIXNW1brvZ3/onCjNr/18mmCwDOoJnB3YLE0GFODwQ6Wg76opDWH14VGqT/YAKSFPaST7+b5/vk76NVgK3nfIomdhul8+BZd2ogzA8jTjM3K5gKOObLoqAG4Gqm01yisK9qkFIqZFE6NHi+uwa+5f4UAEzM65dYqhqLjbgJ2oMxZInKmbbYnpBC/Q2GU78WR8rYAHlJ2rlmshTVqxBjTJWhRW75f+tMepo8In2S2eMVqMTHqC2Gv4jiFP/9DjwHqUlzmzi9wg4vrvza5mUOE
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR02MB3128.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39830400003)(136003)(346002)(396003)(366004)(376002)(451199018)(478600001)(71200400001)(38100700002)(86362001)(122000001)(2906002)(33656002)(558084003)(38070700005)(316002)(54906003)(41300700001)(5660300002)(8936002)(76116006)(66946007)(66556008)(66476007)(64756008)(8676002)(66446008)(6916009)(4326008)(91956017)(26005)(186003)(6486002)(6512007)(6506007)(2616005)(46492015)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?DpDmPwIBbVHtNwtfkYpnLRNyeewhkURlCb2bCGPqo9dgrXur6gopIojcVYda?=
 =?us-ascii?Q?jFyGhDOPS6HYEM1lVKcxJBlWhMI2uwqQnHG5ZyoEcDGPDxfDud8hPNyTmMj+?=
 =?us-ascii?Q?R09/6pseH3AXOfLvFIkIBZ1pq2zQhjCSz8Aq0+zbP/csRaDjuwwq2IVTujtW?=
 =?us-ascii?Q?ofhx91kLX3q7+mNz9VJn+JhopNRnpGGwET/AhZTtJ65v7/eQzEqLhwnt2P5v?=
 =?us-ascii?Q?6QNknRCCvCqNMAuqCc3KlTsq5/tHi1Ox7X43/4UMGvUExs3vj+8+xosuf8nu?=
 =?us-ascii?Q?41DrEn8i+ObCQZqYl1mp5OYztFePjYEMJ4sPXffGpTWnrXZJ3XcsBNLrpHft?=
 =?us-ascii?Q?kKhU7Z92LNvPTZTzSrIh4NvhcXgoYv1S3Udc1UerZCud00EGI86UzQpf1wFJ?=
 =?us-ascii?Q?tj5/vyeU8VLC3mT/DHoCzoefgPPYXKyDpI+XGkRydEkFxjBkQnwToIF8TR88?=
 =?us-ascii?Q?tCzx1Ji8nW8x3O9lcu3VpwqoHyVeoky6a7WWhTh6TjhPF9BuxQJU+Y74/8Zi?=
 =?us-ascii?Q?fPF0M4J6V9UjfH3Q5gZ1e1rd5Mb/2BV+fEm0P8TIX6hbUf7QuizmF/ysi3qT?=
 =?us-ascii?Q?OPWmqnPRqF4AfY8qYLzuq/VbFM0aTO8PSiaJyfv1T9Z6M8Hvxk+3oB5ORTqC?=
 =?us-ascii?Q?o/ISYNEKnhNLZAbZ0b6nPiNVHCv8exu5zszc60c6ocf2WSbvOHqmhtZ4bQ0P?=
 =?us-ascii?Q?p7zuRuNecPN5l9XzNPewx/AoyVEFyjYwln+ky9gGwSga0YbVpkOloY/0Q7Tu?=
 =?us-ascii?Q?SBUBMkq4xuVkgruoOhBy8FugGkpyOmVicrTLrwWNFdLEM+OjKGh5EA0t6zPu?=
 =?us-ascii?Q?0t2NNEKNG7KgJNQ/uV0llq7qbG5SjH/yOSj84QJXtlS4CKubAqHwXChiwzl4?=
 =?us-ascii?Q?ZelS1NdZ46YtRHgm2d0briurJCgGXD5W9nwBKOwz+Pfd6nUDkPCTfxOdFOJF?=
 =?us-ascii?Q?xbZEKTfmjED9eqPe9Jxjssl2gaepaYWAf5k9gE4PJ5KHwfrukMlm3mlfT17K?=
 =?us-ascii?Q?URzJu/utOMu6J8JX1SVDFDOC0STNMTSs7fsK+2WhUNTPuie4S/ZVl7p9+eXY?=
 =?us-ascii?Q?azeSr9SLcQzBTuz9FTr/qelhY5nyNym7Yegp5KjQ1JrR78h+zSAMpEmbpZFN?=
 =?us-ascii?Q?nsqpqyDCTkkmmLUue3Sl6lZvi86xlEzDgPdSmX9d4A8SY7n7E+fSzhO+IdDD?=
 =?us-ascii?Q?WCZLdRAX/O0+gsBOiY2pvc5xk80E2RSYvDh3VKIsCAyRzT9tlzGdFBwR66Cc?=
 =?us-ascii?Q?MZbZuZrnpt+bzVGPVjPK8RfVwkA6Wg57aQzMem4XpqbVW/dsrALEXJv1Az3Q?=
 =?us-ascii?Q?WEanprpDA7q/Tof+rjxzcG3q9E2rf+LVaZEJGTnLED0QyH0OvssLT10SqnX1?=
 =?us-ascii?Q?EsQBCq3WnFnodhCdChNSee3ezsBP4VwlqE9AoLZ5qrKBGDOM8YBdHQytRXus?=
 =?us-ascii?Q?Ydxr8fN+fp3EFwUGG5VNFFndxSZ/+Kp4uHlMTCd6ObrF4nsH6zQVuf8uamzZ?=
 =?us-ascii?Q?j498uW//EcNeCCjRHA6Bg58X57opqPFKb7i2H/AV52E0Qd0R5YUFK99tsWfY?=
 =?us-ascii?Q?+Z4jSmkBT75324wUZ80MtT18T/Ar26G7U5dbPPJZ?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <08257758BAA4B941B6F6E14A3CFD7C2F@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: edgeless.systems
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR02MB3128.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caabb6cd-60e1-4ea7-04d6-08db144c6e60
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 20:44:30.4757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: adb650a8-5da3-4b15-b4b0-3daf65ff7626
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GWyLwiWXUz+Olbx2YxABg70Mt/wUWxomLS4rkcuXgkSn5x9cBw1/7+seCA6K4xYLfMsJ11kc3NOxDCaO07i/lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB7054
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230221_124434_869456_2F24C1D1 
X-CRM114-Status: UNSURE (   6.61  )
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

Hi Christoph,

Thanks for the patch.=20
Detaching disks now works as expected - the namespace is cleaned up correct=
ly.

Best,
Nils=

