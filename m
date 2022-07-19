Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6CBC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Jul 2022 05:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gV46wbOOLcvjq9XQN+DBELx1tFfU6gmiuqvitdExaNs=; b=IO/OQw9GeRusJ35umpjMVHQTDr
	gAlx+eZUA6D+YibkN0Tqez3RtSKZXp/oUwICkP3BwKVzzxACqsCBZIFygxb48jGue0fQRqP8+kXh3
	HWOhhN7Jlu5TlR3CPh2LuUtX066AYD6bvUEb9t+rOJCcEYo9Dx20S7Zu6S+iAyBSDQYJDxSpEL1Z7
	5bVk0KAFc1XGSqn+k3d7JU4lm2WL5MtnTOCRh0Rv2qpjeyuByeQQkfSFFcpuPpa9K9fOW63UziJUM
	mPo3moz6ZVku0XcSL6vPwScN7n8IwzVZq+duKFXaD0iKGAuR/VE06bmn2qCXwwL2lOZKABfoxRz/c
	z14lieJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDfTu-005DVZ-I3; Tue, 19 Jul 2022 05:09:14 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDfTr-005DTQ-IP
	for linux-nvme@lists.infradead.org; Tue, 19 Jul 2022 05:09:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658207351; x=1689743351;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gV46wbOOLcvjq9XQN+DBELx1tFfU6gmiuqvitdExaNs=;
  b=TjwKmN5/bh2UZYzDNDk8DcDuQpY7EVmYBQrCb2OTcy5dIQuYBWB2QlDF
   nBP9gWDt1FOntPl+/OCp9u0qDLPwdO6LvdfV8lXT5QwiHgceq2CzJ6G+d
   E4UMdKQUnAlhMY4EJdEa+GNio1N+df6mZmQOx7Lc+V9SJRlErR0F7QcQM
   7JLijYTEn9DjwgOoF/iUG4zNS9X3+R8NMB3YGoKcRHJvGkWOxszhIXxpG
   5W5BdoZ8CObgW+TYTfhmcgWKElsugRlyldhaVrJeEJLbCHXl9ZjqaEb9w
   5GsTH+3SpSBJ2u3JKEiwr5o+damB1rLmuKdhZKJ6P/UMFejk8Z2LT/uxm
   g==;
X-IronPort-AV: E=Sophos;i="5.92,283,1650902400"; 
   d="scan'208";a="206943606"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jul 2022 12:36:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGC+kkcY05gBKDGaZWQ1oAm6Qjrk7g+BDmgE8aDhYbBvOYh0M/aqXL3bPUyVYwu7UcQ7ZageLs9cQ5GIqwHBGNrwspWWqOySdJufaYnjU8kbj/NRuDFQKGmqh6ZuiJtC4O4odRkkqKBxPwnDBEue0rx7T+h76zRAgcQ2ukZsNweNJGsu7i9TYx199A0Hi/+WCm2oF3iw/vK1N8LWYSBNW6EbZ8nPzLqR77TRAKAJgdEyj8FrnQmP+wZQWfptVghNs7/ZHjzkelnWBVhRSmYNVoI7d5oOxiape5+mTbqFi2s/UEnU8yn4d9U5ruqta4kU9weWPXOm3OqTknGp0nRmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV46wbOOLcvjq9XQN+DBELx1tFfU6gmiuqvitdExaNs=;
 b=TCPhAT07n4CeVFpWXWNUjZOmVljqJAZzW13862NR0HycFKjtoofd4C2Y9Zx8g7pYL4KYEDKBHoW7KTQG4Db6oC9SnTqwUbDzoh9EurTlHcTbTwOvazlKuVFBlzWcovow9mQz9B9gvLw7TAIII09Di+VGLPoWp2qa356kimeWWyf2H+4x7DuvpgkJc19DyCh+e/fL/2ilE+pTkszcABMPG4Zq3WcslxLNtvhBCAqZeR4RJ8oeag3dSpHcs50WgiqI7bdLR5nkvJvyrfaUpvbGeuYpNbtMpzJFm6AezegGy9wUTfyKlWJWdUmNQfka61KVOeoXg/Zw8DZpdViCGmbJEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV46wbOOLcvjq9XQN+DBELx1tFfU6gmiuqvitdExaNs=;
 b=PNX1KHjLDxowHG7G0fRke947d1SGiosqYx3qFIRl2j/xTwBIQwkTqy5utyhWmMK3igpO3H+a4ezN5HDLPdnj+ststRZbcFk/h3r1YwFwDwQ85bQKZYfi+oyxg4+RolqQ06nmGifcm2HFpmidhm8tPCgjogSwl2eyroCeW5XKFCI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN6PR04MB0514.namprd04.prod.outlook.com (2603:10b6:404:97::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.14; Tue, 19 Jul 2022 04:36:35 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5438.023; Tue, 19 Jul 2022
 04:36:35 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Hannes Reinecke <hare@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: NVMe In-Band Authentication blktests status
Thread-Topic: NVMe In-Band Authentication blktests status
Thread-Index: AQHYmv7CoKmZfXV9NEWBBHTpa/U3ua2FHEIA
Date: Tue, 19 Jul 2022 04:36:35 +0000
Message-ID: <20220719043634.txdofxzymvv5ayvm@shindev>
References: <e647c133-f54d-b731-3fc8-1f0b523aff42@nvidia.com>
In-Reply-To: <e647c133-f54d-b731-3fc8-1f0b523aff42@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6696dba7-e402-4634-aaa4-08da69404345
x-ms-traffictypediagnostic: BN6PR04MB0514:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  YOmCrZQjHUxS6sTIB/WKUDOEZPT8auxrF+SyknHD6uJ4CVEJuLkQ9eslF77SoF4XzOekCGAhn5TII27JnYhq260hhFrOZfDC11fZY3ciMwnVwupz2/rCboqHiNyGHyRqrk1MqP7TnXdmufXa07vCw3NxPf+yigF3hg9EJLjsVhFFYCkuFGFWRxAx0rO4D4HW6j6D1pqjRoQ1uFTwS0oy+Jwe3CXE9TIzJAG8AtUTjU3wgAAkmaLUj0jQg5ZFqLHdjJb//6tuqTtMbe+KZrlLJirCWOuVpyXYhtAaMYaJlOsYJIueNyaGahbP7MT68z7QhnS6OZMgOkhDKcdyMcgjCxfTl782BvkePjXg8Z3eBeL0a/+h3wp9OxySIp6CcInqIlaAcUSRWv06M8pUXRHTb3kAXkt6aQq7sA/LxpbcEtLZCAgyJQT0stDDWz1NaBzijawNjfuOaIfo+UJObN8bhS5ooWKVByYuxkjhNGrctBj/yD+YjyQBcZ7lHse0AnWA3DjNH30vd2kIhMN2fiD081jW3GrfWWhSkuz9q61CBat7jznS90pcrSMVYS7/tH9SozQCbU9v0P5OVshwTrOaojR2VhxU614UCU4iGtAL1wAQC++ROJFqh/rfxi7bRwq7xscM+Jz/dFxLAFS6XIS2dPzD/hX/4v/Gp68aHhBio7VyNHZNvVmuCXs9rZ5+6pVGfTKUJ3gIijfrRRmy3x9MLqb7hEz/X0BdfdFnnaP7rHR8xMFSg8hslDr34Xw5dS7+pZi4KXuIdT/x0gXrd8tbI2v5iJtmKv4bY2pHyja0BzgaMP3UfzKErgUqORxV1B8PjbMFN+J5sXB3Wib6nIkoyg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(136003)(366004)(39860400002)(346002)(376002)(83380400001)(4744005)(9686003)(6512007)(26005)(2906002)(41300700001)(86362001)(1076003)(6506007)(186003)(5660300002)(6486002)(966005)(66476007)(44832011)(8936002)(478600001)(6916009)(54906003)(33716001)(316002)(122000001)(38100700002)(76116006)(64756008)(4326008)(71200400001)(91956017)(66556008)(8676002)(66946007)(82960400001)(66446008)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?FjQQmz4K9Fn+rlx0kV76FDn7H9xOF3XXTi22VrEt97+SpY4P46H7OkNvMmC5?=
 =?us-ascii?Q?sdQSq+LODOXWgrNFg2Wvr7J5TgE37IoA4Pt6xSyiL/8789dV4Xi96aCJ+ADN?=
 =?us-ascii?Q?gDCttbqEo56sV/MfDPEF1gsd4yuNSjLs873nmJ5WzZ6Vs5wI1OOAE8YDrcfP?=
 =?us-ascii?Q?0RNxFXNN6YQByLDfByNVY5i1E4ujj32ET/QsSPfaKxCjhkat92dp0e8VK1v2?=
 =?us-ascii?Q?ZEvO4HtE3JtlqKArMXBAkUUyHLf/QmS/7Vz5chm41Sa7FRL2rERhjzQvVnuE?=
 =?us-ascii?Q?qPPj2+YPg93oYOQwZi/wZQjRLWXEmMfRIhUolIDlCtzZWpuGXY7zMlZIPoaR?=
 =?us-ascii?Q?9B29RUEXc7CUZrCkfEgmTMCT9qc9OC3m0eHDlOmAnk6GFk+uXjrIf0v2RGtd?=
 =?us-ascii?Q?mGmUVJCeh96RnyKJuTmxjfhGSeRGqApGwSxsSbfUmLBwAvvTYunstlftsucg?=
 =?us-ascii?Q?xwswIunWOslVJZzC9ssYCRjsLpFgAQgjX/+6ThCIrXqqXnBKYA0cuPm9QHwR?=
 =?us-ascii?Q?zaJqV73MNnSneqOY5yMY32EGZxUjLVQKpXfWjGQwAAQcDQJ515gn/vFP/dZj?=
 =?us-ascii?Q?5w2JqfhPpmPKDVGkPoM+ibQNNhWB8GAadF3/XFbMZtWm5YW8LG/F4NFdo4GH?=
 =?us-ascii?Q?pAxiq/Vo69AonMawo/5g6JmQ7EaZadR1A2lUuE1jlJqsqrsIRqaoxqKVUFh+?=
 =?us-ascii?Q?GfXgSUWPIJVShmW0lN0y4PBugMaYIZAtZaAikXfuaUu/XkSNkzlrZhNS20SR?=
 =?us-ascii?Q?gA5J1AG0YJ83D1EGhMHdQ1aQwO5cIx1Znqz7j3uLelYuw+aGHvA1gSDWAiNx?=
 =?us-ascii?Q?0eQRpyfguq59q6haorhS+pHyqKryGSpLeVTUwGxn87vWUSKKehUycxwtmRdj?=
 =?us-ascii?Q?UFASSLkRNUz7qGNplD4Jac/b5RqaC+qTC4r2+Gi5FKAnhqLN6GrGmew1Zmjz?=
 =?us-ascii?Q?GSl4W6qUjtnsuybTffVo3fXf7zHw2D+2nMgocgCkdYjrzO4Tnrgspiv98toz?=
 =?us-ascii?Q?xWHMeDZ+UH8B4FtPA63bLHe+99dcPQ5F5iXQ2PWQBZ1+uDYBCE5msCBfIURH?=
 =?us-ascii?Q?jPkTo2nIwA6gAIEF+7cLIg3nUNhS5w3fOB4TmqrEMB0OGUZQ5jfcM2UcjnCv?=
 =?us-ascii?Q?1s7vIAB3hVMrYCAw5BqW4tVqZe7kJoP3Qv5UUE1I5QfDog71lJOKXMdJf0Af?=
 =?us-ascii?Q?VObZ6cl0BOW+4bUU4uKxuP32qTt7xa3rM4Ziaor48E4WRCa8ZuOTiVpfgkeW?=
 =?us-ascii?Q?Ttb0ZkCnE5LqZ10lowkR36sxUyWhjVSkijZHkVFlIgYQ72/GpomI+hVaHQuw?=
 =?us-ascii?Q?+2JiuZUWqYtF8ff68ugGZUTjxKREy0sqaJyfBfiSkxLM/W7C1N4uhnFbos3l?=
 =?us-ascii?Q?Hr81jhL3syGlRN7UJa62kERPAaaAgZJaD+C5Ab9uvjhsUbFzgsFxx4NVX+9T?=
 =?us-ascii?Q?JinRXDw2mBJ9CReBunqL0ICjPxx1KuDma4LoRAKrwpp+y1d/uWdCxSJ5K9Pz?=
 =?us-ascii?Q?zfsqWpnTUzFMZ4x5Cm2z9WeDCGEPqPdhcGBpAwlOeK3+kISBgsuHs7XQXr8u?=
 =?us-ascii?Q?QNczs4SP0v5XvIysCg1MHyuWNAv+Spi+cXBVYEfdYCIDIMZcwps5GT2lEHzZ?=
 =?us-ascii?Q?wfxSiCwenVOeVozX6XOmsqk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A8A757BB5F35EC40AC327BFD3D7FA17B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6696dba7-e402-4634-aaa4-08da69404345
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 04:36:35.3496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p0y13PS0ZNm6K4KMU+KHCgYj/Ev+7SwmsscVa++3CbyFJOyKJA/OyRvGD1HNry8og5QNyPmFNaEFI6buiZDHy+wkRxOMjDmG9dX5eiIXo6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0514
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_220911_764335_13BC3800 
X-CRM114-Status: GOOD (  15.45  )
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

On Jul 18, 2022 / 23:33, Chaitanya Kulkarni wrote:
> Hi Hannes,
>=20
> I just cloned the latest blktests and seems like we don't have in-band=20
> auth testcases in the repo (correct me if I'm wrong). Any plans for that=
=20
> to get in the repo ? as many are asking about the tests as code is=20
> upstream now so we can run on different transports.

Hannes created a github pull request called "Testsuite for nvme in-band
authentication" [1]. It is on my to do list to review it. Will do with prio=
rity.

[1] https://github.com/osandov/blktests/pull/97

--=20
Shin'ichiro Kawasaki=

