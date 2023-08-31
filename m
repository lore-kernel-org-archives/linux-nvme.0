Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30FF8C6FA8F
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Aug 2023 02:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+qz/7PgwRlKMaQbF7kbHFRCBY58wzEEzlmhzSyn9xoM=; b=svMMMGhp7Gpj3Stlrvx7C4P7pD
	8OBFkajuXw3CZKJ73wZxU//OGQ44PyA+u95L3IrOgqvMhMKboFnM6hj2pnMAf9eS2WcFAaeyPPc1j
	nZ7m64Y/D068611+d47jz2amyZUpoZykER5C8icuDCsK3dbqqsRreBvQrPPGAHswy9TgKUKFwu9iO
	3xzA2Xa4ajRtFyVh/X5kM3ap3P22gfvhu8yTgpnLBsdgzzUFUTnDguV4abSBSOUmLwvrfZVixSTTC
	WeWGtuCZSBBKALxVDGjXbR/dLh2XC4fKEIjw6xrRH9YTQFVoKvg1vykdY7Rfx9F2rmKnAhIuyy8gS
	9pqjN+1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qbXNL-00EUmu-1U;
	Thu, 31 Aug 2023 02:25:39 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qbXNI-00EUlo-1W
	for linux-nvme@lists.infradead.org;
	Thu, 31 Aug 2023 02:25:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1693448736; x=1724984736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+qz/7PgwRlKMaQbF7kbHFRCBY58wzEEzlmhzSyn9xoM=;
  b=nsGBc2oCSMP+5OVA+4kzdNL5mq8PXgJjt83YYEjISIrCVHYRJ47BxIgz
   UlF6ucEWDclC5TMJjtFitBpvdCfQkoCdEHU2SDBE6kjpi59BYwb9nTRJF
   uqP9X4/BZOZ3yiyaMnOnt4hJ3PbB7CmUjwmspoVfZxQLzTcp717fv9QI9
   gA0OTN0hY0cFBNx28h9y2JfiSOliNFeYoCSALDIzIb5NN0IhdNkLIiBcg
   M3XFV+F4R7Sz7pE+VXx0TNMISc7sadXAAhetbBNpYPBsJtarGjRqyufs6
   EfsnauAwzOv24m8SEJZEP2yaS3BSthuyMUgszAfQRx223c8DhNlvBpzGo
   g==;
X-IronPort-AV: E=Sophos;i="6.02,215,1688400000"; 
   d="scan'208";a="242517766"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2023 10:25:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WmN7U+uV2IzoBMsGLyUpf8DCReVv8rOXQFTflbGtvA7H0093ukYndQl/Z3UFqXqDJ4tsYm0BCU+UvrdoXdJBXf4VDFrO41qxuzdH4KR1CT+GhBdA9HyIJOyQbgzxW1XlqOXDu2ISdjFKR5IdWvYA7x8Y+B+TCfazm9ktVYccYQPn/BMDBkgHDN9x7hBchi9G7YXvYRgYldrqsRz4E+2YcyBtrSOMJzx3U1sHU0tc2+CBB6Mi5E8iTsw5jj4oGvvNtK7IQqIEYHm3Rl/RY45LSlvINFU+rkAWlfinvlAPfgrcFxm1YAZS/0msGzzvZvUvnq0FzFyNT0Voc7XzcNxGhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qz/7PgwRlKMaQbF7kbHFRCBY58wzEEzlmhzSyn9xoM=;
 b=maG7fS+V2TO3utbfp1xJVUHjSJz4ZYhutaRnz6IJGOXO1Eu6RiW4KuSL12l2/8o1isfSlAMDBRy2glA05t+sSIVJePwppOx+so5Sj/2zGMJ2RgLhy9JFnt2U2JA0phv1AeoWP3arTO4/NsXSvHrFclZM2OftBbhMFBV4S+cuRgLjom7PzKZlzrzG9IKEEf3zI/Pdh2tMGRpdmGyZRyP5JqQ6nEPuGAL2dB75IaLl7gtE/VUzXHF+IpnlzPrB0seN3JmHIaFntaSF5sn8xmKkjW3UXtdtyMrXQceMwqY2U/gRF+4HyinX0LAjcOyyWYZCfMlB2X0teY/LwLQhPzL98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qz/7PgwRlKMaQbF7kbHFRCBY58wzEEzlmhzSyn9xoM=;
 b=fS1/iyedQDnlInX6Jes/CB9kPeiRBYU6wFPdQ584TOkDQKv7ZmYTg5K5683mYA/JfAueFLzXc7Y/V+U4vJjXtlntJk7tx6+ICSPwBzFT01/9apZKgyQPM5zFR0zT4zpvf0EM6XXTmTV9ESzihqMAI59/w81oS5ai9E2blNbJLwg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB6354.namprd04.prod.outlook.com (2603:10b6:408:df::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20; Thu, 31 Aug 2023 02:25:23 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6768.009; Thu, 31 Aug 2023
 02:25:23 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Chaitanya
 Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>, Sagi Grimberg
	<sagi@grimberg.me>, Jason Gunthorpe <jgg@ziepe.ca>, Bart Van Assche
	<bvanassche@acm.org>
Subject: Re: [PATCH blktests v4 0/3] Introduce nvmet target setup/cleanup
 helpers
Thread-Topic: [PATCH blktests v4 0/3] Introduce nvmet target setup/cleanup
 helpers
Thread-Index: AQHZ2yMwDFr6yChQoUCALIhpFapgV7ADroIA
Date: Thu, 31 Aug 2023 02:25:23 +0000
Message-ID: <yhnyazgqmgbzsa5irt4cu3735qxuvbl5czicsaxl7zm6ckjkzf@2cs7fpg2qvpb>
References: <20230830092019.9846-1-dwagner@suse.de>
In-Reply-To: <20230830092019.9846-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN8PR04MB6354:EE_
x-ms-office365-filtering-correlation-id: 6bd47250-b047-427c-96ce-08dba9c98794
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Xi+Q1XxZiUXOx5luWS/Lgdznq7kSvHmnf/baKvoXsX+ao4aqxrzxBLQ0hSpe+M9w9BReTWG87R4GL/S8s2pe68LjgH2QDF7SHr77HagQWrDs8NsvZtOizu3MMu2hkZ0KoRW9U37kertqUoH43ehvhqbOj4ZYiy9TvtqDgS7yZWj8sHNIzYDt2j/b8WzR3ongpW9M6ZydJVfSocFuL7vSndN/x862RY6HiSFUCx2Gqi9WXy3ch0PEyQPXe3IMKd10BytHlBOGVMiNo+5TrVkVWKrGGwnUBrN+KinA77uB29Qs3QFgRueQuTai0AkpfSXwEMjAhbs6hcowVhI6FmpfZ1gBydX037SLImUkNtqvL7d8M35lUchojlb/TXXctPcjVPpYtyW2LS3fnn9tnZa34EOKeYtHMu6U48HjTwKZnTcEhV4uJ1gq1gDOD9H9rtblEumwVF9MzIMr7gQu0y4fxop2wGAOgb4nxKG5yp1SiUgvIv4tpO5aT+jqzdYjm5PT/bi1VUSz7PWMEsyejE+8YBgT6AvZp5sHyovLLw/dRgBM+ZxKw727qptZUQIqinTA1B7Xx5QpCw5491qzf//i4iRaDyphiWUODzfifPmpl8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(346002)(366004)(376002)(396003)(186009)(451199024)(1800799009)(26005)(9686003)(6512007)(6506007)(5660300002)(6486002)(44832011)(71200400001)(38100700002)(38070700005)(8936002)(478600001)(33716001)(4326008)(8676002)(82960400001)(122000001)(86362001)(966005)(83380400001)(91956017)(76116006)(66446008)(66946007)(54906003)(6916009)(66476007)(64756008)(2906002)(316002)(66556008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H+k5i/bNetT+dB8EAknhpM37pKMKO/QZ87WYzpmaem2qT9/3D51IleGSsFGc?=
 =?us-ascii?Q?DNKXi7y1g283A2kwozXLQJ5SmQTUQHDpYkbwVmqM1X2odTK2zyQBHH1ggo4p?=
 =?us-ascii?Q?SEqmcZBO806HlXWv+7M+AM6LB2+hDQjE+JNEn6gSBR9/D6E1eUHZ9hLfbBMS?=
 =?us-ascii?Q?2YdyDjnisJyHA1NRe99X67UpwJC3areX+Ejn7Bs/RxQEgwZg0uJ+UtJZqjvn?=
 =?us-ascii?Q?xJp6ljBiipzenxbIoGnq/MG0BL91iGsZ9HMtbCvzx6AKyKKn9rjtYbFI+EPS?=
 =?us-ascii?Q?6pYrtoHWnNMzEs9bwRxmh6T+5B3ppCiiaib70PkR/8fXWDI41T5v4IRfZ3Rl?=
 =?us-ascii?Q?gyuLSYMkr/vrWGmSK5DHcyYdRog3ipVvaByLH9lD5qQ+zhwvVj4AIakjib9u?=
 =?us-ascii?Q?UytiyP6J9K8u/fkAnVrBkDLo3AcuBrTTRuHdItixqDThVCL9UDz7wA/Od0/J?=
 =?us-ascii?Q?uypFJiOxsqulGYoYEl4rrutq2E6tLvUT7txG610FeEir68IrvRZ6z62l8yEV?=
 =?us-ascii?Q?fBBkQknloXp6WGHc10bWrQHlAGg894cT8f6zEmK+CFIoHsEO/+FmYJhE9kCJ?=
 =?us-ascii?Q?fykHP0L/+gBmSYdwnUVeAr383zrCjzeLJo35rePAqOeUmTKKoGeXAryumewo?=
 =?us-ascii?Q?YD4LALAUIk4VvkipdvH6JfX/zwTQhm2kQU6yxAJ8/CqTdEMYrMU8e9Si7GtO?=
 =?us-ascii?Q?dFbxDEeyzhDVBWHa5fpcj5xdsVvwGlaD0VytX0qygl8FmZ/hcQdwQ6yVafWS?=
 =?us-ascii?Q?OrN3fI8BL3snAZWLX0+SErQYjO3Ep0o77wls3NdkA8D45xxK7vAtb5SZ9m0n?=
 =?us-ascii?Q?MaLSF+tpPymnvAzE7kaeIQbP+5/O5+pPPFzbLKTcKjSVdvvb4oy4EGO4dIol?=
 =?us-ascii?Q?HLQG/frS2+N4wCCUxTV7J8Gaipi/WfjGuXN9X8tmvLcL7wP4yawyQ8dlSLJD?=
 =?us-ascii?Q?cqyET9F6hfIcKNbEnD9uaqM3ytjhWssy/ewJHnqds5RAcpoJHsRYkCTweYI8?=
 =?us-ascii?Q?Ly7WGVlUWy0x1R+QvRwGyGZ5Bf3ki5UDrLPCP7hoeVXrvDzWBvsDX01LqCfc?=
 =?us-ascii?Q?abWAHLeqaWoBgSsDOGuRuXGZR0HFPLD01Wh75Xxz4HEhy+fbLPMG3KHFLuXz?=
 =?us-ascii?Q?DYvs1YjigvMcwQv3svBTGA+/VJ+vScEIg3tiwJecZTQrA0RQd4Oq0BoVFfp5?=
 =?us-ascii?Q?IuyCjOPTnjhs89hPZpxuAxEo98RveD1vaLnROqTaUHnOCMdRk+G3zzFZmXzj?=
 =?us-ascii?Q?YQymov6bkfd4cD76S5JAfkDOZijqn5FG451K359dXNg8f8rnT80snmlmE0+1?=
 =?us-ascii?Q?fMouAP+G2166chn0YJ1Xhu1N76NVAsTlMyYz4OCtWCwljtNqoEnAHtB2mkqO?=
 =?us-ascii?Q?Py+b2n5Qb4VSrToTTAt1qdxdftHkDBUYNYbPDlq/ETGsOYBZR5stenSqRKEb?=
 =?us-ascii?Q?fl6e5waiHDk9chcymBBOPcxncQHWa8y2X+RjvD02xANGMZYZR/sqUXsqV2p7?=
 =?us-ascii?Q?j7HEZVz72CDYarnOxubB1YrTveVRIJ2B4hhsVGRl3/IFskgCu9Z6QRkmN/d2?=
 =?us-ascii?Q?KZHEhwsnFeBg6N8dkreI7VqtrrxUCvMSRAOoF6RiZ3+RkkXDFPtiaTjAOF+P?=
 =?us-ascii?Q?jhYd5Omu7tiFyLkh+L7UUgk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A6E0549F521DCA4097B490D0D9B6AECB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?HkcSdmY9vasZvbQE1ZVoHKY5CkOQ/aWc0BZoI+4o6GUepAQgx9NeK8ZYAC9y?=
 =?us-ascii?Q?SeygrMzo4zmlXwSXVtc8YL0t4H8wXOYGZ83dAwQ+8IOWpq6bI+M6j8WN1z0o?=
 =?us-ascii?Q?cchSS20mS5gYn0aXYJbqNSCM5rWKls7XwGYHuF5gCEGKFrg1P+oIl/0FzwMc?=
 =?us-ascii?Q?+3PG5VGwMutFgMb9rJzlS9gXhnv7HLR3DJZ2d1IJQ73utqoVWxKBqW77zIrf?=
 =?us-ascii?Q?50g/OSDvdgVa6jyaARjaFHgpTCz9/Vnqb9U7WNZ8R3chvwdubKZuf6yCC3Jc?=
 =?us-ascii?Q?iSFRWkHefaRIGTTCC3EnO/DEdamOhlxe+5elbksszBaCo5cjmX37+r1P9ZVu?=
 =?us-ascii?Q?QHxMI6sauiHQJJpqWo7kRb0Nq8s1rHNxZsICJP0d80hvehhwzAGJDgW/4YGv?=
 =?us-ascii?Q?9RadIC6oeYXKK6L6t+viACxJdwUb35881l4KmLQFs057NSU+MhwUpNMf6RtD?=
 =?us-ascii?Q?bm93KtivL4XkOoQ39dGXistLO4gUqe2QKJzNXWRkCwOXCZwVwJWFp9THk/FN?=
 =?us-ascii?Q?c1d8oIYoryMcSIOV7HsGgx/xFGGjxhkZplKetuSv+SwSz33nJCZVzenudhvK?=
 =?us-ascii?Q?vu2afpzw+oSv1Ta36ZKrQ1/KbDT5+6MFrGMkx4KIWRn/BbPkx0VrARhA7ovs?=
 =?us-ascii?Q?olG8ysZUqR+mn3lRsx5SpTL+hgoyDWXooDS11Q+6sPKtHobBIDQHIiBPIe/5?=
 =?us-ascii?Q?uZDstLPQ0UdHbOP4w/TIpn4CZOLhthQZatJte1yMasuAftoRgcdtkudGovNN?=
 =?us-ascii?Q?wamp/5QTjfneB2E2h/tbQ7jSaX7N6esrmSZSGovl4jlYbMzHUmnE5xd7pNQe?=
 =?us-ascii?Q?Oa48sZKMREPJJswb5IFcrC10kdyHXIo3J8H4z+Q0D364aQr6CBuBXlzZx6EC?=
 =?us-ascii?Q?pOjS2EdqAQ9TK994jzS9lGaJO6vjRmF84yt7ladl6cVri39d0J/JHptrInP9?=
 =?us-ascii?Q?nJZJs+vI/irSwIaB1rqD1g=3D=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd47250-b047-427c-96ce-08dba9c98794
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2023 02:25:23.0686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBhtO/6Ua0inZQkMdXqEg+E/WEBtSGbLq4BD7lypZLj3l7sf3gqkVf+gdqPfmEsz/bJgiXYmHMaOpukIE6sltf5Hd4Rx4EDg9ERDs7FE3nY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6354
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230830_192536_524896_148279CF 
X-CRM114-Status: GOOD (  20.92  )
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

On Aug 30, 2023 / 11:20, Daniel Wagner wrote:
> Updated the series according the last round of feedback and retested it. =
In
> order to pass the 'make check' check this version depends on the upcoming=
 revert
> of 26664dff17b6 ("Do not suppress any shellcheck warnings") as discussed =
in the
> v3 thread.
>=20
> original cover letter:
>=20
> Introduce helpers to setup nvmet targets. This is spin off from the refac=
toring
> patches and the allowed_host patches [1].
>=20
> Sagi suggested to record all resources allocated by nvmet_target_setup an=
d then
> later clean them up in nvmet_target_cleanup. I opted to figure out in
> nvmet_target_cleanup what was allocated via the newly introdcuded _get_nv=
met_ports
> helper. The reason being, Hannes told me offline that he would like to ad=
d ANA
> tests which will add some more ports to the subsystem. I hope with this
> the code is more future proof.
>=20
> BTW, while looking at this I saw that the passthru code is using the awkw=
ard
> return value port when calling nvmet_passthru_target_setup. It seems some
> more refactoring is in order...
>=20
> [1] https://lore.kernel.org/linux-nvme/5h333eqhtw252sjw6axjewlb5bbb5ze7aw=
ekczxe3kie2lnhw6@manyer42khct/

I've applied the series with the fix noted for the 3rd patch. I also revert=
ed
the commit 26664dff17b6 together. Thanks again for this clean up :)=

