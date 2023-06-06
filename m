Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533F3C7EE24
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Jun 2023 05:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PAi4fESPN4N6GOZtKjIsl8yjO/xolnDodZ51x9ONmqk=; b=qRwRCJCDWDgNlMIX07jx1JqMDT
	OxsB8wx7Fy2jKM6e6yc/SKOST0PKNWEaInMm7U4nuKUajtH8OVM5dvnzH5lSQ2w9dOW+G6+NIKZDA
	B0tHDFxALdCPOEzRPseJp4gf4jfG11a1fdS3B6mz8BI4Rxg/brySlvUB/+8T+zH8H0UIjtqGD3a/y
	N5qbcFJSKDSRq4rAq3u3FE7zlqN5OVNbzmm5WjUxNvKbTUq61Tmu7FCZinGDrVeQmtGoTmmoEfioq
	KFuPQ/2lC0JN5mhUz1BuVO+BE3X2PkBT9bPvxOs90fW6CZWdGx4SihkOrEYqm4C5UM+Gea5SgkBJi
	+T+b82dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6P1X-000EDa-1m;
	Tue, 06 Jun 2023 05:14:27 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6P1U-000ECS-2r
	for linux-nvme@lists.infradead.org;
	Tue, 06 Jun 2023 05:14:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1686028464; x=1717564464;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lh2TPOKRq0dYmX1EOb0Zio6f8RO/fU1e/E9ilKHreY8=;
  b=OWeeLFkfDAZinuoMXbkpfJQSb/BxBQR3GhdWgSerJtrePmPaCJHUeY6O
   xXmHR1MzkQwksjZROoGFgZb3mXxR3eWCdiqbd0WBWjxP7DnOPtus31iMV
   WLXeUCeDG1rbDIhAV2155ELYXpizGw1bpua0vRRCfM6Q9EtdYqvMyn8DY
   a9JD1ZXmDyrMR0/2MjOvQ+4Zqo/el5AAvlSw2uC61QrlbEanhD+/Cq99M
   sBDdNoHlfmCvG9Xw5Pr7Yq5Gd9GSWtilbGyzXwTza6FC3rdcrsyLcHTwh
   uq0URwX4SCvD63Lby1m+jUwmJ8ZKJAlQzgCQhe8xUOLcKl4qLJDjSykZs
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,219,1681142400"; 
   d="scan'208";a="232621914"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2023 13:14:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWoLrBBGUog0rVK1fEi19jJZ47Xp5/+8NXutKxm8r2NyfM3Y9FmUkXyUNbnqYv0Mz8OrL9trGdhLIOi8HUr2+YfDxzh3BCSFK9F9x2fkTAUkqxowQ4zKC5OXVXZqiNURZOXM47STME2qgpQ50VfIR+oCwCCcbYLR7NdPAbQdRGQC5XIXxFpcSgTcjQohudTgVaaVt2v0FH9WbjXjvdPJMIqnI8/ycg3uJdCxZJOidHmRI+AxSd8+8ARsBG9/hjbk62pNJrKB9eb8RUA/zeaHTiCZz7qSE0Gf7sTDPqTYrsBPN7cIU0P9Px1J8MJefkIkbCnUhfGue6OkuCjLK4YH0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAi4fESPN4N6GOZtKjIsl8yjO/xolnDodZ51x9ONmqk=;
 b=g2DWZBSJRCjFhzL7Wb/YHWfPhT8yPOxK7tFPjNAS+Sw5LG/wB9ttYHHlVKQ43vdP/Iab+o9+QzAnHAYbPET0hLFGGXzEu2TSNO5XOzn693Jw0yoYUi6Cj5ddwdHGb1Z3N6mNON6hwP4cRFTbVhbkWAkLvQQIz4s9noJTkA7x15nNl7ud7EOb1cc8ByghE1Vzx7xfcYWhBPzZrn734n01aiNjB0Nsb7AUUDfmQIAjupmuw6OS0CMZtPyfyJfVWb/3MoQw/c8pd+97ObI3KuKcf8NLkwLz46j1FysU7Y9d68Ye/hENSq5lsH7pFJdXxdeslhhHZRRt11yHJ/J3/V7vtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PAi4fESPN4N6GOZtKjIsl8yjO/xolnDodZ51x9ONmqk=;
 b=hXbe1KNg4NM412ffkVFmx+TtQU9qyU9QaEAADy9RMKZUJUrfy/yCxJ8gPaV5AZI6XeqICb64Nch1aAIkfTkgAymuHcBpaIvXQQ/tTKA7gyWtbpK2lFkiKjWehuXfMp9st1wdAgpAHT9l6yOQZY+zJBU+3locVBGGMSpBHleQeNk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8195.namprd04.prod.outlook.com (2603:10b6:610:fc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33; Tue, 6 Jun 2023 05:14:17 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%3]) with mapi id 15.20.6455.028; Tue, 6 Jun 2023
 05:14:17 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Thread-Topic: [PATCH blktests] nvme/{016,017}: use _check_genctr instead of
 _filter_discovery
Thread-Index: AQHZk1w9J1fvV9jcWESv88AeU5E84q9z3PqAgAkERoCAAEOxAIAAH8+A
Date: Tue, 6 Jun 2023 05:14:16 +0000
Message-ID: <2hx4a7yzh2edtegsrgt5pfjqfr6b3ysq4dxws5cchkmubnn7za@f5qg2sncndrv>
References: <1685495221-4598-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <6fbgjc5ykve3jyko4vlzudrnwueou4ehgn6n2dtihjko3qv7ww@sqlyuxx4ijt5>
 <446c46d8-fbc7-ecd2-8efa-1c9497e16851@grimberg.me>
 <eadb2514-f06d-7cb2-2cdb-04a6226edac8@nvidia.com>
In-Reply-To: <eadb2514-f06d-7cb2-2cdb-04a6226edac8@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB8195:EE_
x-ms-office365-filtering-correlation-id: 8e3630f6-b6e0-4f6a-a42f-08db664ce04f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cWyIdQObt/KOWNPa8Lc0yCmf7dcylNFc67FIDXQp13O2Tm4aBDNS+8+0xxlBDdoriZdXopCOgRkS3ibmOdvqlWrd4AgY6ozbz6ovwhhgrIi41OTUoC1moa8WmDyLHzWTQXZNU+NA6vyXHLPe8TEG6NTtOK82b7Blv+ImOhJoF9MnjnzRlzSFd8+4E3xUv6Al1ldrQRIhaGbIICyt/FZxVI9fJQW1KOuJujquJcMCivnfQz+qyCJTZTQeSlxzfVWNd0MwoZWqqKkZfa+hy5TAsIB3IuE2VscmfUzLOU4ZJUfOeRed0TRPuVJ+qm3BjvqMTpp2wb9/ST8JatckM5YfssL1GnGFbmn0OgPkLdoQUTACg8D/nN24R0eG1W2eYo9bTdwXR+T1uY4vm1cPR1oqkSR0TeIcp3Z9SgJVHFmUXjp8ONVWPRQOZw4Isybszc/q2CjSUPKJfkFZfRuQqoe3tsdlMzyQuaFmi0F65n6MntdDmOE23FgnXFUSPu3VrA4MSX6D4lEvgHXcX9RD+4/oYUz/xr+wRyCJt5aZ+7ARS9Y/MY3DvvxVO6q0zEyPbcMcZ7Sk98ie+KgHIDgvoky5lqOf7cFO6KJ1ZWj4lCIq/kwn38TPAxeeUR5AcoIGT9gn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(122000001)(83380400001)(54906003)(4326008)(82960400001)(91956017)(66476007)(6916009)(66946007)(66556008)(38100700002)(66446008)(64756008)(76116006)(6486002)(478600001)(71200400001)(2906002)(186003)(33716001)(316002)(8936002)(8676002)(41300700001)(5660300002)(38070700005)(86362001)(44832011)(53546011)(6512007)(9686003)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?twdsKu8uyb6+lc2Swh+kSOEkZ31+XQxNY831BfkL2FUbEwJrg3wG54PLvRwT?=
 =?us-ascii?Q?YaMYMxx60jPFR1lAYVvwUp8Nf2rG/CNR7OAo4FBxbPbl4pazqoBCVIgWWmGO?=
 =?us-ascii?Q?1zCtduHJr9osJ1A58NpHlMLA1dPQlhzlb+L6eGhnQmuISrKSgWTKYdYXUp4D?=
 =?us-ascii?Q?vbhEKtiwr/7Mu38kBrihAvgge0lDrLXTbMjZ46Ym0e1f1D1Roddx/YPgc2H1?=
 =?us-ascii?Q?2MWm0Qqt9o8/HWJZLFZ/hMC58Go5ZuRK8mBB/PPepy1SCsNt0W7BrzbKgJyj?=
 =?us-ascii?Q?YATz4Dk9V/AiuqnW0PlwVq1YOUGggLQWNkfz7vHxrLSD3G6jmknZwQmxdtoq?=
 =?us-ascii?Q?tgztLEY5IbCTzyXmWI3zZkXnKj8syrfOmu4J/BU9bUMStIaHHBSBrP7qrWAo?=
 =?us-ascii?Q?t3hFZQI4Y9Tzcie97hdguhTFQbBtNDeTS8jFW8rddNQjIkA/T4OdYLeYW3vm?=
 =?us-ascii?Q?evUhGThrQGsS+dbHXfzDZfnHzjakqlXFq0V9M0z6bAvTqXJno3DLL8+h2aFQ?=
 =?us-ascii?Q?lCNh4YZ8Yri8ebkh2rlcvc9bdkeItX6DTpeLGac6JXola7uTOnffpB/FdD3M?=
 =?us-ascii?Q?1OJmaxMWukmvX3umquqAhdmGsDTWyT52PMK8H62Q7WxfRZeAjGOly2LqeIXA?=
 =?us-ascii?Q?ie/V6KivT5+t4rGx1TRgAXxTPYFyCUKTFKI9ndpAMHksx+n/OAvMnmYZdawY?=
 =?us-ascii?Q?GhVBxZ9hscDdirP0ggd7qOZ6O6PCxWm+sskcDNkEDxH0UGziAmKk72Wdjo6C?=
 =?us-ascii?Q?OypmI9TW/9Lf079bOWlHGixdwuyG7C04XwF9lp+qRHQV9+DIuxycMmnUP9KR?=
 =?us-ascii?Q?OXjMr87N49zlXMEv5hiatoyKrn/XIEnElGb2+5rXJQ9ClYhk4O0mQuKKXPIK?=
 =?us-ascii?Q?spGxRSK3NoPmoC5h8/rr41a3E1pDm7R2MBsB30rmDyfbsVte2xBZiTUlj2kl?=
 =?us-ascii?Q?5JIsLhcme23pDmpnDYRhMg18jffJXeT2esc4VIdMLfMi1Sa/m16rh1Bt1Gd/?=
 =?us-ascii?Q?uBnqAEivN4+3dCMCBoMilOKRdvA8x2OjBWlxQh0Hu4g5qwwm2PoU9NwiLGJ4?=
 =?us-ascii?Q?8gZWQl0XBJD6a90JI0nAZ2BVHUsxRM5PmsuKYLG8sQqxyGLVx/BaJyckUHqh?=
 =?us-ascii?Q?wRcIFmldpi3zvamAxxGYC8cuQWBWHbHDRfINhN691PlipBkhwMn0MA3eVRUT?=
 =?us-ascii?Q?kazceeU3uCft/wg5PFGzf3uJ5FvAXLchoyoajJwN0tuKrnfAeDrooS8Rs09m?=
 =?us-ascii?Q?qJWURqFiW5dAHjunu8eAT6CtVJ5jS0TNIkn8tvqgEgLv0E226omhVwKJCs0s?=
 =?us-ascii?Q?LBNeK9B8LjUzMUuAmI8iSOKSUMOyo07gY2NiqyNXXU9P0X6e8JC2JFJnf/JW?=
 =?us-ascii?Q?gRfxEa7xE7kv+GofaI0xdMP5T7/VbDbRhAp+tz7aKPDL1W1MAshaWzTCTXNW?=
 =?us-ascii?Q?jgJvFbffGHrC8HXMIIfoCTY7nl75ESiggXuOGjC9r0d2D+ATAT8j/MWd/5YB?=
 =?us-ascii?Q?D17XyclWMlGwMRnXudI1dNcfOBASMrG6IhWP6VTUyAWntZcaafRa6hMBvbsU?=
 =?us-ascii?Q?DiXrbZtnBPHZbMo6Tj6M6jfOn31wllAHSvfDpmfjv62YS7RcYL+ycnzHvl02?=
 =?us-ascii?Q?O735QSgyeSS6dcuQAm558y4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <76386EEAE416DD4C8D5E339EAA55736A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xANFCBPtwR3qdADFwzSUAbdbazNysBMG/pKDpZVeDErR88+RhW8MywA1MZB5Ok0y7X09NKj7/4GYaV6T0uQqxqg4ofCf9PcQd3kYtF05EdyGJfYXRoUNvfDwPlYlYGIFe7r/uhFeMVqMZ+qIPKmuzygz1lL0R96Iwqu2uH8SRDa+he8AIUPR0CuzxF2lxCduAS2NxwX3j46PHPc8gFL2g6VtbIsUnbBI41QimuQUERgYXzWJg0F/wnIlbCRVlBFu7YClG2FaOCQ11E6yGK7xkBxAbmhxdF8q30c+BC8x03UEgsC5Scj5j2Ky+D2QlhW1PrrzRYn0CiPmXJn4/3J6o2bd1XdrCFKhK8bTUyQmpb1nKgm8/q2u8hI56vGTUjX26UezVKq5X/gadEoFnwwoeE1xx9PbpXEdMZKT/8lq1EGCTqdU1Slyi2lds7U70lU3uKmx6G+xwhxwcGXccXNAxBhH79ObFNh1QRKTiwj9yzzPtv4LjLWfBSFQaW0Sdh00/TzIt5t7aZdAYgwaDoV6hCSY4ST4atPJMHrDjVfqnV0VtpRHpDeGb5NCgJmRsL3fD3tQDQJ0y7MJCUEaHd0esWBKj+jOKxnVleNpjf0mYBXQs3c5G8XZwOlSEvFJWYw/wmf+60/SZROoNskmA9k8fQFUjG8NCUqsF98J+yZhAww+hz8dd+iocmdKbMqTmB2ifAct7gaqY8l59NX9ImisDzpxOgyAZHSlrR6lddHhAznEZbVYN4I70B9rwH6KLj4ikkvcmFOMOF0gx7He/Evqph1vGICSjFoddQhX7wWQo0uNWhU99v+yIcmlKygAuqO6y8kE35wqsCyijQhimy/Ldl5lmmr7nXCaN9QfC3r+tLSpyxzU2SkX+RbQl9RA2W66o0mR/rrceb5sLE2ch2Px884yG+cCkkRP5XAE+kMTLUo=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3630f6-b6e0-4f6a-a42f-08db664ce04f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 05:14:16.9919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DQ7lMxStF5YZgOcwD43hynZgjm4Dw5gidvB/PeVNItmomTOSz2YRS4cguYsy0NoGOLfim/e54nR+cYqfR8XRGihE5ICwXZOL5p3IX5sG63w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8195
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_221425_011469_FF30C8CC 
X-CRM114-Status: GOOD (  23.29  )
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

On Jun 06, 2023 / 03:20, Chaitanya Kulkarni wrote:
> On 6/5/2023 4:18 PM, Sagi Grimberg wrote:
> >=20
> >> On May 31, 2023 / 09:07, Yang Xu wrote:
> >>> Since commit 328943e3 ("Update tests for discovery log page changes")=
,
> >>> blktests also include the discovery subsystem itself. But it
> >>> will lead these cases fails on older nvme-cli system.
> >>
> >> Thanks for this report. What is the nvme-cli version with the issue?
> >>
> >>>
> >>> To avoid this, like nvme/002, use _check_genctr to check instead of
> >>> comparing many discovery Log Entry output.
> >>>
> >>> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> >>
> >> The change looks fine to me, but I'd wait for comments by nvme=20
> >> developers.
> >=20
> > I'm ok with this change, but IIRC Chaitanya wanted that we keep checkin=
g
> > the full log-page output...
>=20
> the original testcase was designed to validate the log page internals
> and  that correctness cannot be established without looking into the log
> page.
>=20
> but given that how much churn this is generating eveytime something=20
> changes in nvme-cli or in kernel implementation I'm really wondering is
> that worth everyone's time ?
>=20
> Sagi/Shinichiro any thoughts ?

I don't have future view about the stability of the log page. I would like =
to
hear call by Sagi and/or nvme developers about it. If we expect more log pa=
ge
changes, Yang's change in blktests sounds reasonable.

If we expect no more log page changes in the future, we can think of anothe=
r
solution: skip the test cases on older kernel (or nvme-cli). I think the
blktests commit 328943e3 ("Update tests for discovery log page changes")
corresponds to the kernel commit e5ea42faa773 ("nvme: display correct subsy=
stem
NQN"), applied in the kernel version 5.16. So "_have_kver 5 16" for the tes=
t
cases will avoid the failure Yang observes.

Yang, may I confirm the kernel version you use? If you use RHEL 8 based OS,=
 I
think it is v4.18.

