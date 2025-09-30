Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F295CAC5B9
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 03:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DUlpLSO1yEcSP6sd6HChMRPdrRDSgk7oxBAjPqUDCEI=; b=NMvBJBta5rdN8d5bA5xvH6bMSo
	iPDIebSzn57Qi1iAc80lzcdUxtyeT/B48vvTUOhpBwIUPZfP8Y9ga1/ByJcnQUlZshI9CuIkM1d6d
	LUimwsrCSjb5rAq3i+lQD/4E48Gpvc3OXQUa19dl+dJ6f3K5NWVoHvFRm0lNQ2Q4ZTMKYfeoCPlBW
	ghpMkCFiXlvCNsqmyQqjIVlLsqrexQcHREvl3Ne6r+9CsYNYcBJbhR/OrazBUV1OUITQJN/NMPNhE
	H55KoQiN0CBUWzvRqX6zMw24M1O6lGJXC6aV0UwbOY//kLyCg+Q67H/ux75pk0ImApOpAtr2ifU1K
	LO/tV0gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3RCY-000000042K0-2zCi;
	Tue, 30 Sep 2025 03:38:54 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3RCW-000000042JW-05P5
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 03:38:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759203532; x=1790739532;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DUlpLSO1yEcSP6sd6HChMRPdrRDSgk7oxBAjPqUDCEI=;
  b=o2TvFunVnp/RVLla/kHuVp9xkl6t+XR0A8lOmmSn2JCDPfsZBI9UzoKP
   XLjGbjF6XAGhCyRKCHxQOFzPDOdQ/elQYklxPSH7zstmJS/x3k09uEB3Z
   ynA+F/oI+qbomFexUpFhxw4SLRJqJ0uUmpEGedbKdGqc5bETX6sm4GCpi
   pe9miClU5b75dbphAvn6c/3dEv160XSjqwNuK1IAEEk7S2zTbnwexMY/H
   aHzFUv+3Nl9QUa8IZ0e36Nw+y1WmQ28vEzkKL+ZadSaCdQr6t93ANU7iY
   oZMFgx2tKqnjdS4KpaIj0Dz5wMZwJTtDG31TFXUE6wAs1yBMBRl60vbQ/
   Q==;
X-CSE-ConnectionGUID: 7BF25mPiRUmu4d3HXBXUEg==
X-CSE-MsgGUID: 9GcBdVbvRLKks+kCnwHMoQ==
X-IronPort-AV: E=Sophos;i="6.18,303,1751212800"; 
   d="scan'208";a="129048841"
Received: from mail-centralusazon11011008.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.8])
  by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2025 11:38:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5kVwHDdDDDx9WFz3KG2FMsONwITnsZN4amYEdHCsX1FkdFASS7BfMGxc8R3GrSOmPCkJiI9Bs5vi5nx00z4SlKbQjqFfo+bFiLRxIgfI5sOjlXRBg76WqiOeL7yeGU4uxEKYovpZeOfR6e3qT/RzCEjBvFtD/3zlCSXWDVSasmZsTVm0LOE91UMLI3Ol9NNNRxXQKGG586FJmYlmUJCKvYeFDYAI4S43uQ86U1vNkpWLrfujzD9NljbyP+cQ6lHQPO6tTIxb8Wu6wSJTOG4MrfxzEf6cddgHR5NMVWOLhs+ITFSHsafWDT4TcsS93YWOR8d9tbwhBZg8iw0H5HB+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUlpLSO1yEcSP6sd6HChMRPdrRDSgk7oxBAjPqUDCEI=;
 b=NRgvdwOkE+BqSdteGACzA1WNjtyBOFTSjaUnCYHN56xILByCoWlBsS8ZJqMcgEiFyMWKJaBLxuh3InMv8+S6p78HsJHHh/AZ2h+gRDZavYJBPrslUZEeO7bgxYMGOXvdK8vrTSeosJQC+zIsmUBQIUAZy3dn2Dehy79x+AyoN8rb14afFByLRp8h7TNnYRT27lcZkxyrez4sZG1o3fKPHnk17jlUlJwm4jjDYypF+36eNhDcx6VkGcXuvDaDeMoY5i8SuhAhSfsRQXAnI0OoeHDr81flwrJi1RxAVRjMP0TY4JYwldVLd2lolKefiO24x4pIUJPYqF1k11GNJrOG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUlpLSO1yEcSP6sd6HChMRPdrRDSgk7oxBAjPqUDCEI=;
 b=Vpqg2S6CxyOtjKlBGZ74JNyp2tHWxsF5M9Wj30wQx+xGYcmqIsTlNKpmZ21z3FWvgYXMD4iNVHOKinhM8UYU6tL9AyjFQ3jfHOBSgPx3kNfrs81TQbfk8u8L6/SymFx+CV2ulr/fREsV2LOmiATc55bDQAcQDA2uRlRMtb35nW0=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA3PR04MB8748.namprd04.prod.outlook.com (2603:10b6:806:2f4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Tue, 30 Sep
 2025 03:38:44 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 03:38:44 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
CC: "dwagner@suse.de" <dwagner@suse.de>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>, "kch@nvidia.com" <kch@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"israelr@nvidia.com" <israelr@nvidia.com>, hch <hch@lst.de>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>
Subject: Re: [PATCH 2/4] nvme: add support for mlx5 RDMA devices
Thread-Topic: [PATCH 2/4] nvme: add support for mlx5 RDMA devices
Thread-Index: AQHcMG5DO6NHbo6kaEmZo+pusAYgKrSrFpOA
Date: Tue, 30 Sep 2025 03:38:44 +0000
Message-ID: <5mfjs3mjm23adjqfetr27eo5b2wpo6rfskjixd2zpoztl2jjnm@hhbi64b3nf5b>
References: <20250928115125.38383-1-mgurtovoy@nvidia.com>
 <20250928115125.38383-3-mgurtovoy@nvidia.com>
In-Reply-To: <20250928115125.38383-3-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA3PR04MB8748:EE_
x-ms-office365-filtering-correlation-id: 2439d880-2b60-4dcc-d724-08ddffd2db54
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?IGABzbsYqBtn8PMnjKZTbYmI3YcyoR+GD2e6kr9hQScZrOPJAY9W43sil1yw?=
 =?us-ascii?Q?qGdMR8G8df/6atElpUDykO7Ygxa5noxdX+UdDBr+kQkxIG+GLJ0Pvg6PzU1B?=
 =?us-ascii?Q?WASrIWjk4IdQQJclq3QQEdLBl4jHfVToPH2jmTcVTVp9+sATfhkJgx+fCzeo?=
 =?us-ascii?Q?9sbwOxxZy6IJXqvP86wd8xAuTvJZUgREewpUIt5+9rnfsDQO0kBxoiqvO9Hn?=
 =?us-ascii?Q?anEpBf2/t/Xv5yN03IVf2vG23LswK1tn+NZsSJeWH9C9m/8tjKb32LCLXuYA?=
 =?us-ascii?Q?NdSQkFYMM3E6JvNELdDQsIKa3A4Uikx8aGNnclnKMg8nyEvhxXi5l6f/NoZW?=
 =?us-ascii?Q?1NMIq1QjaDNBeUtLkukHw4s+C4zLX3Qhe5ueGmLdyirQn7Vp3aWtqyS5Ix/M?=
 =?us-ascii?Q?565pmMemlchn2Ylb7U1gTlta3XagfmX15cqyeRPPxCsWyva62Jlpbu6l+6Hp?=
 =?us-ascii?Q?lBjZhIMCP5M3M4hmnnEypBpBVnNdZop04k63s/nmzdy0RS6VSzRusdCwa9I9?=
 =?us-ascii?Q?r5CZRnnzOlYfvTIVNz40ZOMUejVfUyW19VX0kff4nOJQbBhR9UA76l4OLJcg?=
 =?us-ascii?Q?J8l4YKQyAvASqGbBRp5VS8MPECP3Kj0bEnsyc5i0q6gTflUmyZLCWYdc7Sef?=
 =?us-ascii?Q?cvkn4jEvO/6/5cZnsqEVo5nsoaEBKP4R+nRYpJOFkD/8AjFRjERiQl6wsR0O?=
 =?us-ascii?Q?jCq65veHdcTpUMoPbhSfMlLitDnQCnolx8Hzu1JSWA5V02/daU4YcQxAHysq?=
 =?us-ascii?Q?qm1535QK++BqJ2pxcxtlKbPOyeVjH1WZPnrTrw5PwI5T8qLSLMEAT6YG1vV3?=
 =?us-ascii?Q?n0sJtp3tLrRx439ODeoNjfsmEA4gnFIB8B8dZ3yDUQfdheDosY9cOeN07Gr9?=
 =?us-ascii?Q?E+3po1lFCDEzCJnqYpgwJat/vUJ0EyZCQhZ3AzC881RgAXrP0dmFgHs1t84K?=
 =?us-ascii?Q?5mNj6E5NVBSpC3C6Ml2gRdIJdZ7ebIO7cbG7rxNOdWMHk1Tr3oj2yYYH/mib?=
 =?us-ascii?Q?zfHz7JCfnVpsw5ao3gHd6Aw5ak+51cMVjvNjUXFzrfsFAMkNu5Ig/eRvbqqN?=
 =?us-ascii?Q?geBM2dqwD7SqXlUzur+9TLfBaWW1+T9A3dHOcEsweXuFxJT+uiLqknHTYbYh?=
 =?us-ascii?Q?kTOEvbl3EKTPZx30EY/WVrewtjXW0tekPdaK9AXEe3BbrnKOHgkNCBmp5LWE?=
 =?us-ascii?Q?AE2yq90EJ1OanXMmufp03m4TtOeWWSwUHhxZlNMYZjo9L4AoeW+Xy8lx3WYN?=
 =?us-ascii?Q?snMDP2L1mOdQnnqmglq8iFDz37j5OFKZdu0u3vcIAzgim8btJ9HxmkhP42fU?=
 =?us-ascii?Q?UyR7f6Phn6CY30CE7Jm0B+crfMYEry181C/mqJ4uYUnPZRbIW6e5dbbDIS0Q?=
 =?us-ascii?Q?ppn4aQA77OCDtYvqcIILveawnkMEKIbzy2eCWCkIjFxbZotZerigTxG/gek+?=
 =?us-ascii?Q?4CLpr8arhyMVqXjjNSc/sXJZBMNQptkCxKYYjmyjcsJvqwlGV2FW8yVkzhWs?=
 =?us-ascii?Q?Odg1s47+/ZF8lYtOlhaBr8ED3BuT75XdmSZe?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8aW2KghvdxUvnk1jOYsUZHYxWq/6N1vNF2VW+kNVYUNsVLHYtdR6UjrDjfGr?=
 =?us-ascii?Q?kQKA8jHedHf2rApfLdxxAwZiyT8OsAu/gYTtOtTkXkwlz8BxlSuHr3sFANMW?=
 =?us-ascii?Q?S705QTbXDs2HM+9G6QJQk5mvvkBM2Xsi24jP+8Z08h1Oc3IY9l03PGracQSP?=
 =?us-ascii?Q?ZoGiM7jU7eDQqT3It0yG2CWzVr0b+S+TTQeM7pO2kWmzqL7fq0opVO0wp+d1?=
 =?us-ascii?Q?tnQ2TIRdoN3Wguk+MLnHE4x/iBdQRXDi8aEuaVWQEFmKBMADERwYONKp9F4g?=
 =?us-ascii?Q?lB68buFnzxKpUW9HZXPNmpLtVvbNONfCED48K0eaULRLHQd5Db2Mdc5mWofv?=
 =?us-ascii?Q?wRmxNyMfvziFi6jPdX3foZuztyhfPXxtUhWcY3g1+XUYzN1jXdd6KqHzBTgT?=
 =?us-ascii?Q?PzPHMhSRc+jOtKzSOBrZ1ckbV7pLCSozhOjYpt/MdAOI/Agm5mQc+Lu9TSqk?=
 =?us-ascii?Q?WgwMGw78PCXS0k9/YS0DRGPbThne34fKkWt4qP7JV5MBIbt94kXrR291xaJM?=
 =?us-ascii?Q?Gt1yJCQ1SyEHvNnIz43/n7QyTq7xLYh76QHcoSTS5Zw2JyvrpypRfWGEsgcX?=
 =?us-ascii?Q?C5WR9r4FNPiTgBUs9PbxEs98v4vtR9A4mF3Doe83qvD4ryEoKpcHIJbZ7i4D?=
 =?us-ascii?Q?hhEKmaUl8um/EwkkDGvCfW77kUsJeMJZhUeXuINkbPQtYkVtSwKkvo2tffiD?=
 =?us-ascii?Q?1o7mkRa5MRljT+SfoLVpsMKkiSapVueZ0GfIPdrDkvFnndOE7uRX4P6og/S4?=
 =?us-ascii?Q?z4bPXdyiGHatJfjLdomFY6FigkOmA00QV3pBPiXyTxro6FGcWWBTP/BxQ9XO?=
 =?us-ascii?Q?K4dYdG+H0YxuCJf35XarCwaaRUxXBMm1mPTPMvTRhQBfbuPDgXY49BWHJutj?=
 =?us-ascii?Q?CkmFo5NBjEmSK84POfDSmutDajku7Sw3mtnJLBZ7u+qlFS1W+On7Twn4R6PU?=
 =?us-ascii?Q?OhrzdHV1kCLyNe+SS/GzpVfnXkBA+7Q6hTVIewjZSfA12oD+fJBWBq2TgQJH?=
 =?us-ascii?Q?reP7o3i/KQ4LyUU8Z/3r9ivaYimyywnB8ekoExIvS3UgPRdo1zvgbaY0qJ4m?=
 =?us-ascii?Q?AAshnwoT/zxpLId69TCE1KAtTIJxQvTf54WkRPMrxFFXuqZsl+4kl07jZiSP?=
 =?us-ascii?Q?lFSKeP54s6Xw4rq/WjBz9Csyn2gCZcZHgjdOvdDoHRyYWWyxqaU3kMh7yqTq?=
 =?us-ascii?Q?cZgTatw1ymiFPPQBV1Y+qGA02AyaTHexrTvgq1nBnMdxsu8ems0fDhg7mpQ9?=
 =?us-ascii?Q?iQYhRx1tRhPty+xxGPcTgcvVUkj4NRZ5IZM18WxZMeEjz7SMwwn8WtZ/0SzX?=
 =?us-ascii?Q?4Ga4WZnPq5TbYqtedCB70ojGivxEf48tlQRalMSzeRCsSwVOwFYgIGfX4dnz?=
 =?us-ascii?Q?U+ituy3OSHUGXKGQV2hYWTphlrmH/RNOkY1pbeOIn12YwZmUYaOUEEeE2kXQ?=
 =?us-ascii?Q?CngSEOKO9G/5h9Uxm3KFB4L/hSmNRkua6Hxo15BlR0JAK5EN6lCJa1M8ejji?=
 =?us-ascii?Q?3V67rqguW53syw8w0HjJbLaf4aPvh3sfFSS16UerctgAnKqussTn3ta8dYqe?=
 =?us-ascii?Q?ZEa/XvxnGphH2wXeyyFEg3i84LMVnbnMJ5L+rjW26clE65pa43os+4LIzQP7?=
 =?us-ascii?Q?N7trJtBCIqF6dxb6nOlUN6w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9F7E04CE4BE3F9419B280218831EF8AC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xK4M+KMNrZATPzAKgTIrFwyf8lN/aNy7WU/FPNhpgEsIsWmBuSP/viquD42oXRl3t7E/U8vuyNgrK+dfn33BgvA7eKUetM2OmYWQtp/xRZ0GRzxHxEAJMBfwYIVF9SLBUjckxc+IddcdQaX8PyAv9dsIO1m9+1gMFdMZ7gJMfRYYFDLC3y8R3cavDMLNXptO4MwRgFrSryB5MnaRcgIgrAxB3AII2nIrco/fot1mVK26ngozuL9Xyy0z8t2956I3LQRnw5hyovyBS8GINfd49Z5pfjogLibxESkRmW+QFDcUKHvm1kl2h+PBpxAA48q/32hn9qhfjYAc7EEHZKcpnUh8AsjAehoHye9/olPKVsGZ3Hj6+n/7LECde7J7+BYi74pbNzbv02RUIFXKBLB481NBetgEm0QWqTl2rSOg9XaXQv7RXjWGQYV/EfVSIitC+vAQE7pnJZgoWppFDO79USJ7/oUdLNwEiHg3IKdMtF0nI1lvhGVVNbNpvF7rBtwbBBP52jJHUX5Qp5nGNeiokqEnZh8xvzPbX1bEEzSrDcy3EOJJ0YvmY1kZ1RTLT8zUOdHvpsRq9tNtprkFDY+ym00DNmnh1Ac8bh+hbFQjHcVVcBHbvBV2NkoRab/CGMXc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2439d880-2b60-4dcc-d724-08ddffd2db54
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 03:38:44.4371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRD2tGegX0HEGOWxkI6xdTVgvn2d33I8ieBHSW3nRbMB7edY/MWSEw9ILXmMc9fi3YEDa81QiRNHGFSSf/S3QiHFuAcAm37llyWp0XU5hL8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8748
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_203852_210484_47ADA21C 
X-CRM114-Status: GOOD (  15.44  )
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

On Sep 28, 2025 / 14:51, Max Gurtovoy wrote:
> Until now, the tests for RDMA transport were only supported on top of
> software RDMA devices (rxe/siw). This commit adds support for running
> tests on top of mlx5 hardware RDMA devices, allowing for more
> comprehensive testing of NVMe-oF RDMA functionality.
>=20
> Prerequisites:
> - RDMA network interfaces must be configured prior to running tests
> - User should set USE_MLX5=3D1 environment variable to use mlx5 devices

Hello Max, it's great that now we can run blktests with mlx5 hardware :)

As to this patch, have you considered to use NVME_TARGET_CONTROL?

As the commit 5b6d89ced118 ("nvme/rc: introduce remote target support")
explains, NVME_TARGET_CONTROL was introduced to skip the generic target
setup/cleanup code to run the tests with a real target.

This patch introduced branches with the USE_MLX5 variable. If we take this
approach, we will need to add more branches when we support other hardware =
in
future. If it is possible, I guess NVME_TARGET_CONTROL will be cleaner.

As to the script to be set as NVME_TARGET_CONTROL, we can find an example:
contrib/nvme_target_control.py. But it might be too complicated for your us=
e
case. I'm guessing the script for your use case will be as simple as this p=
atch,
and it might be worth adding to contrib/.=

