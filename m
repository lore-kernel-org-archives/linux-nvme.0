Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1313EC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 05:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yuUPPKZc9c18t44v2OCxk+uPFVqWGo+VTYyLg/99hH4=; b=OfWhiEnFYoS0wFndIK4RYnrbd0
	1zkh0AHUYGfRLwYeq63N5T+PSdvgjmrdth8+owukjLuuS+dE+c+F4jroXOBRxoxBbTLlE0vMmpD7c
	3k3yelNEXr4xkGlsUrZxuh1MeN6sH9Z+j7iQ7OJ/TsTqU8dGNSFUXT/PG08eoa9rIjPXZF9h1MWQb
	/HKb7R0MxCw8BsM3Y+5pWvtJg7r8ZL68KJ6eKJGgkRSj8U7dVCJWoTZTFPWf7vGTDZOqjnPhkYZBY
	v9ongg9DtwRQox0xfpoioIGcoG8PnGIt7HC2bMQMZbm3ueXr4zqnC5LdmxVvwfX3xdymOgxoMiMk6
	D2rXkSpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0ylp-0073bS-JS; Tue, 14 Jun 2022 05:07:17 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0yll-0073b1-9F
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 05:07:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655183231; x=1686719231;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PJnOv96z8ATDin/Z17IvgPo0WQ8qtgKg8o6mjOCt8mI=;
  b=VyOYgWaMhuC4SQqFTS56fgC3QGxk87Q+86t3GKka7FG2iMvxb/F/XM4S
   jd/l9/xwjT2OyoZv0UrNQ7mseMfWEOsnQ08XJALNR/FmxSNDZ4/FZuSZI
   ULtFreHLnM3SEEBEAc5gDVklQud4TjrLsrETGlzHMknytKpQk7VzEr9LX
   NM2KUcO/spgLLhCrXnZyKBG3jGPfIuEfzyiO4IFpwCop9vayg2DzukrMq
   CVC0hXJYre+zcG65lYC7tlITLGrbgzjcMgcoeyWYmcIR/Tbf8QRtU/vpW
   FSQ8wiXp3neqWy0c0jEVJ0Pf/m7IWyLjwIIsdxZbxipQC9BYpQhtsmgBA
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647273600"; 
   d="scan'208";a="207919569"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jun 2022 13:07:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVezfeGmasUGwUlCF3nfqDz9I86PTDsb3PjG4dOjq0wRdNTlMDIOzMvzcKNkim3WU8TQtt96cfxc7S5rtAmC9UHa98JycHlPO45qU5wQUH4LQhviW7ibFaxrKTTKKtZmalpuJor+G79Yjg040Eu/rUclku442fyBb6yUPUyt1MBmSanOX6ODi/6hEwzFTssjnuuw4+EED215HlUvqCMKICUBSD/4fnBV/x2/HyXvFlxiWLoUHZBN2nGZBn/qqqnxXW9fgD7pjUa5RL/8QnUhZtAG785S2FPS+e3j/HjNjVaLQY4GmAeb+1GCmnweANwt289+hMZqJCyO7utj9NWnlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yuUPPKZc9c18t44v2OCxk+uPFVqWGo+VTYyLg/99hH4=;
 b=lNi0II/Tkvhuq3KC8WkUM4hDizV3iD+uqiJR2U//rhqeDuYYweONsu5WIXUcjoSSO+z2VbcazMxfkb9drQI23Te/OYP0/blgjcBx3G4CTlb9/UpqPlpvsFIJ5YY3rC4bbQ/DhUBPWbDVlhpe7Q7d65k7OWuvVyfUdW2M/tTwiBf9AJiG0d/pOvhmjqIXP7HgeSxt/YSaYAqBm0YzUJSoLFC5AAuetiY8jaG+FPgfqA1u8Bhdbqp6WVdSjUADCZK0WtSUxnqGoXYqe5WdX+aF1cWuhYfocM6ExBVMACUVsKvSju11Wyk90cn0GCJfghkJUarLUIhwY6VoMqtEqhw7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yuUPPKZc9c18t44v2OCxk+uPFVqWGo+VTYyLg/99hH4=;
 b=RLkSoRQXG0dMjuqVt7qVsPXgHg7DEEqKirgFVZj5aWKkpJhMuUYiY/zKM4P6A7pZQmoKZtVsbSXUTpHobVALEh+RDmB+aTh4CGaV+jtt5vlGibvRM7wm/KHNW2bHh1b4n2XmnV4HPhPgo+eru2GWsK018nrlnqYj2EKKlHOd6QU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB5681.namprd04.prod.outlook.com (2603:10b6:408:77::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12; Tue, 14 Jun 2022 05:07:10 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5332.020; Tue, 14 Jun 2022
 05:07:10 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv5 blktests 00/10] Testsuite for nvme in-band
 authentication
Thread-Topic: [PATCHv5 blktests 00/10] Testsuite for nvme in-band
 authentication
Thread-Index: AQHYfL3ytkNE+npGcUWSZnnM4N8BBa1OX7cA
Date: Tue, 14 Jun 2022 05:07:10 +0000
Message-ID: <20220614050710.dsj4b5x64fi2i3h7@shindev>
References: <20220610113324.10294-1-hare@suse.de>
In-Reply-To: <20220610113324.10294-1-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 128eb34c-6ed7-4778-5086-08da4dc3bcb6
x-ms-traffictypediagnostic: BN8PR04MB5681:EE_
x-microsoft-antispam-prvs:  <BN8PR04MB56811A6D0213979A62644078EDAA9@BN8PR04MB5681.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  R2yngakIuJBTqbYu/fp3FVQTsblYe7rpV5Ix8iarJ80EAHsCx5RzaMbpWzozqb3JVgrlnISBdnito+C0hcliW7dF9P7dpwhYxLO8EHM1Iifg/MVURNe0bBRaINN3M9WWMOSxfphncRMPJXBrCNxhxddnKNut3i2ArMJOATJlStzbjcXop6Btj28Nj7zVcgKn8Vb0gLXne+k0G0N/ARebzS1RZuAa/6fFWFS9CvywoOX5LtLObtoevKTPw3bxqsCtTlaqZ431aC/1ELZyGiLKdkzcf4+jT4svcQxxIwMa4Nz3zfLsVdYWEtqdzMoF6Her0Pd9lULBMEtgqjZ/Y9am2/4mrNkD5yIAqdMHl0/uQOn6sQtTonNAzMXD94nOKG7j9fgBHXJ8yBvZJsDDl1Ap2SPhRgeVBjafcTmAJfZzaoFqOlwp0RUodl9Z6dsp9CrwvHh09Aa9xMJTvSnQeIbWRXh2Q8Bzt7MRIwbj5tAWrjN5VS0upzSawjAqlM3VebuZCSZBMkdpP+Fr6RubA4iSA46M9QCz/4M29zxVT68k8aZj2iA0zzvlch/a5TCYR1qstku0YumIuL03zkapCnhPMCQaOIrqAJVgxK2lIMHXw77jorOr9EH1hJqtMJ0IFMtb2zFL/4DczrzaniLKI5IEDrJ0MHoEdj0p5EGVCzqHh82f0qT85VfApsXwINu+EhGcYFalOXCwHcsua2zKKfl+xg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(66446008)(64756008)(66946007)(66556008)(66476007)(86362001)(4744005)(44832011)(9686003)(6512007)(6486002)(6506007)(5660300002)(1076003)(186003)(83380400001)(26005)(6916009)(38070700005)(38100700002)(54906003)(316002)(71200400001)(2906002)(76116006)(508600001)(91956017)(8676002)(4326008)(122000001)(33716001)(82960400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?6VR36bLVhj/TRHFQ7oC5SOgLgS/BqN0oXYQxY4+NYkbl67t6xWmhdfVL9f4e?=
 =?us-ascii?Q?npvHWkayb+4ofJpgYYxDP0V6OyBkgCXZMwmoNIjjYWbUricYrntHLY2ignHT?=
 =?us-ascii?Q?YnX7+UezFvlSfk2Izb9xsNMCbHCHGgxGbddjejJ1Ob/IMCQGW5QPq58YZN5D?=
 =?us-ascii?Q?uCk6qbGeitpaoJSoPBfE0vsSeoWTDUWjhE0kiLAm3Rohkjs2hmnHKCQUfAqp?=
 =?us-ascii?Q?NTGK1faRvdD1VMAVx141lmT4V+gVLEbOLkoHVhxL3EXBNwrg+9E1RszARZ2B?=
 =?us-ascii?Q?OgrZrE/TYHer/294hbelB+W1tTRoibeEd/NtPS+a3EkNNGhtXez2mo+sDwHk?=
 =?us-ascii?Q?MF8ewYgaQ8AghBhklf1TWSu9yIYxNdbQFSE5Bs4wKVV3PUtopC8wORT+wjLf?=
 =?us-ascii?Q?JwNOrDAhm2P0o9prWR30byvGQlwhqKZki8XiGhMTrb+wXwUaHfaawDANqxCu?=
 =?us-ascii?Q?l/o2ShnH7tkvib4jcvZV4FHHganJeVNms0MXflWy8ODzLUGelfHOP7/dOzXL?=
 =?us-ascii?Q?eR20VEuO2xgs+gH6qrebVpePdyQMsPu1ucQqnh6nk/rqG8mVT6gx/3nU3sDC?=
 =?us-ascii?Q?nLVfNStaN+ArhlQA+z/j5CDxtuQQ8cv6jdmMCLry+XbrD9QOKppD+5zOXghp?=
 =?us-ascii?Q?NXxKwnAli2TY5Ye5rIPHGKOuHpQSy6c5jzzJTKt0bhChAewHn5pbwz3s+QjW?=
 =?us-ascii?Q?MoMlVQY/7B8uxzpQ0UBIWtLsxpp8Kph114xT7hvyJc5u/2tyxWFx4LEe29TT?=
 =?us-ascii?Q?o2C1J1b6X4Ym1FWs+o3BGIN+CBf73RgSLxHdtOvDpDXckNCBiDGqH46fQ3Xz?=
 =?us-ascii?Q?47w7wPet1l1BT141AdD/XgQWMMEQz23tiD5vWNlZZTLTzW0D/fiPClAeTBPu?=
 =?us-ascii?Q?jSX3zpAFrvtF+X4y9+imkBgZ+oqnGv6NZk8w4TPPBcbDAznYr7DmvFQn9pPX?=
 =?us-ascii?Q?SO+eM948+P3XWINv+yhfSMg4yPGIJYd8PUirGzUnbfumz3EjtWAL6/ZVaYpk?=
 =?us-ascii?Q?AzsV+3WvXFbe0TwMDyXergz4MXWFdFX7jqi4Jqdt+eI5CILDf/BxPym2VySh?=
 =?us-ascii?Q?20zhHR4HeotAOEf8XZli7SlQLxqvOL5e3Z19L94We9QQMAAxSLdsxe9j54FX?=
 =?us-ascii?Q?675vYLOdgWrOEYi335+HEtCGpnBLx0QmVnh9pJFGeGOKffQH51TALvWe/2bp?=
 =?us-ascii?Q?hxOMBbWJUg4S4Kdi4O1qxtoJcHNMA1dCkad8gAbZgQn0+UOor+laBjc0tVG5?=
 =?us-ascii?Q?SNLJCmcjaSFr+f3tpD57IoB0B7cHyp56z3NgBjKlcPMq+Zrf1+gEoFzZw1xX?=
 =?us-ascii?Q?0gQMZusIl86i9oa9Vum6BkKaJ83h68VcuuoLi0JBxdW/1MSnKAlM9iCD7qWG?=
 =?us-ascii?Q?Q9YI1/AwWbsulkukfC7gqtoM188LRn2bS6p8G1sV1YHodQhO5jqMJPprkeYN?=
 =?us-ascii?Q?nIN+rT42+tsddEZo79v2AiwJ+TLu5JFl2uuQV7SdqJHj2MC4MHnC4FyEo/Fj?=
 =?us-ascii?Q?yThX+pI/8aEDQPwYZaiNWonUE05Q+kA3DPK/hKQsWjjCJYFnC/kfLR3GQa3u?=
 =?us-ascii?Q?tSbCijKdT2DKGyvfoylUXV+3RSEMxHvQt1XNBOskPHG4xZ0SUlsb1it8hNZL?=
 =?us-ascii?Q?ELO+J9YERxaE6ICaRcBKBTMgqDdQBsM5ZlFY7TFdchxlNbm0b5kkt/+04KB6?=
 =?us-ascii?Q?pX35M6c6vAGhTQiADOCuRjGu1stXuwKMUGtEJv+thXrcSnTzrehI8Tbwa+Pr?=
 =?us-ascii?Q?pM4rWeQUtldF/KVpDtRVq0bGVeSEfmyEKY3o0HfJ0yJ1wVbwHI86?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <04F0D4874388D649AD915B599D8679B7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 128eb34c-6ed7-4778-5086-08da4dc3bcb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 05:07:10.5747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wBZBLUFYhD2g5JQLseITVsip98LRHCF78AZE1vdeppbAe4s7t/GSxBmdob7BZ41AzG3ZhZe4EN2K4vyak19mDkC3qpH1zzpcQEgzgoGX4Eg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5681
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_220713_430281_AAFAA09F 
X-CRM114-Status: GOOD (  10.53  )
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

Hi Hannes, thanks for sharing the series. Here are general minor comments o=
n it.

- Newly added test case scripts have file mode 644. I recommend 755 to indi=
cate
  that they are executable and to keep consistency with other test cases.
- Could you please run "make check" and address shellcheck warnings? Shellc=
heck
  is good to reduce human-error, and I wish to keep zero warning.
- In the series, I observe bash condition expressions with single brackets =
[]
  and double brackets [[ ]] are mixed. Originally double brackets were
  recommended for blktests scripts then I rather prefer double brackets. Ha=
ving
  said that many single brackets are already used in blktests, so single br=
acket
  is still ok.

--=20
Shin'ichiro Kawasaki=

