Return-Path: <SRS0=hrUZ=HW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6A6C433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 05:00:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D10564E15
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 05:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D10564E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=JyHJn2UDNhyBjhtvouxYN0//4nXSAlxHtEFnblrHMUQ=; b=0IC3N/m2Zk3lK82vQ3d7cPvCX
	B9FeqbZPKmDfS8wnZ2AdPQp7cTxxethDacQDTL7PeJwZYI7QM+D71Ama8qX2RyrMbb8ceXGpzDM9l
	kJMGKNzOis/bgTmhLyqMLK6m2L7OTkcnBa3k3Dcc1R94xONgmdfqwgVH4pNQRCgIxV9jkD0klI5bP
	P91/es8l/6KoJ+y6zy/Boa2iqPWuH5JC5Sc3+vbLBRZ6M9pEtJ95qteN3jqcndHf5A5bUzDZZJdK7
	pzSZdaQOCe57dyjSUrkHV+eyky4l9QKhqr4JQRTGWL3Z4+0caxZ8sC9Dl1kubQifLUtiE07CS60kv
	F1QpBK8Qw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDKMQ-0000MQ-VG; Sat, 20 Feb 2021 04:59:19 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDKML-0000Lg-8s
 for linux-nvme@lists.infradead.org; Sat, 20 Feb 2021 04:59:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613797153; x=1645333153;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=AsOXh9VcdJqytY3nu0opwXKfAdknCy9wxxLsTIVM8I4=;
 b=M6Z8ItiaditC7K5cGh1a760dUdc0c7OnpVz3UjBRH5fmhKtWRcA4CRvg
 trDv1hSAWzaqewmsU7aL64FFoxBCxQjXWFoDGKRgyS1k3BPIeMzeVr55t
 3yeg9EKmoDoD/b+y3foYcqjre54eouXjy6N8nDv2d26hDdo4Ik9sW5y9I
 u9TDwuA2YuqrIzDtldDcPhKQCy2ASmCqdAJQXciBXaID69Y4W5OLpVsw2
 4HTRc+Cu+lRIQScwRrupS4Yrk6gtTJUG0Hy4UCMvrjMMwapyyJpY1FvIZ
 CYMPV/7N1PetI4/HDmnMVpkSuvdDOK9/5uzv8sIRnAgqscKq4R1+LLe2A Q==;
IronPort-SDR: +ZI/tnOzTXSFCLXHOrRkszhBjnLedQ9YD1Xh6WroEjhpUqpIfdyTTjvfzd/WcQ3OeK+nRxwK6J
 U5R8K9s6OTpBDBV4nMaJMxNmVQE+D8FmdL425RwdkvNZ9RYfp4EspIFHI3zYA+YefwIlrvTlbD
 Zq460g+dWfpnnOxa3kAf2IYqdvMKiPlLcFf3ufB9qwDeS2NljhPcU0k1f3Pw34onYG6XFHg2Z8
 cR8fqCwwbWtfZZ5wlgNO750Ys3Y/dgOHHAn/ZS+KUmHN3h0oO/7xmiNlWS4qk6SFRP8YKqjWxo
 sq8=
X-IronPort-AV: E=Sophos;i="5.81,192,1610380800"; d="scan'208";a="160387174"
Received: from mail-bn8nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.177])
 by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2021 12:59:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=giktCt46pnV4XlX0FhuKu26jYScjk9Su4SQsfT9i7tSBMERU3t3Kglv3Mtu7miZdmhdn73AhABRzZoClXhpQVcBEy2t359iGR0H6aZsxPn5p1U+D8Lh2iKeWUHdLz3hdW/qICyAzxCSfvuNj9NwU2rTJ6vIvRhF2vXfRdG+Rb5qmu7ipGk9okUR3dNZ5ZDRNAA6SYH8U5oMkt9Fvg4YbU4mjNPfbIFtf3bQCLU+fpwSgDzLvHg1TMrJw+BB9OoA+k2qXLlOhaDanlqFKj6O0EEldwt/coCvGyEmjGqCQyb9IA7bq4Brv72tfr1Jg7Hu7i7fdgNw+tEat8qEj5JRhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K23pIem2bWd0e+PJFN/EThlyAwcD/2HLJal4ZzUEeLY=;
 b=SxSOaaZ9iOh+LpbADbOtRIczGS5RaBBjmRjGBQfr6EjTeCt64IK4Rlm4H5VHgSJa7dbU1Iy+ezVCXbYanQyPxMlErdAjdwrrrawL3YwqE86D9UDpJYSTbc9/zoI0zsKldTFCiNe83ieXa1VtXvylwOUiO/DyNBVDSH7vnnn1nr3+DxBpyini+0sy/xBDcSl84RTNWQlbCY9C3pGeGIdlCVqqlCgdlGwSqj16fcpKZnjYObGUiXscuDT4/UG0n2GGNzlorE1ks+ojy5BkrqH79JNwdcrfvSAi61XSKna0qe6ZNHkqH1MJzVC2fE1SVWrkOX4+HZA90WLWrURgFkaHjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K23pIem2bWd0e+PJFN/EThlyAwcD/2HLJal4ZzUEeLY=;
 b=dr/b/D3Ewq4c+J0YHoT1LB9qgW4f4XBpHjCeqcFS3MJ7ajd0MGygko5Ju3Pkq4btcbd1uV7kPTyraTMv/bEc+Uy3exJ1awaMwXCsPQhr2uduu7Tk+N65GeAVXZ6Ol8989ANv6w9yDdbvYxh5xwiHCBKIxUHpQ61YsKjYuNHdkBc=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6596.namprd04.prod.outlook.com (2603:10b6:208:1cf::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Sat, 20 Feb
 2021 04:59:05 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3846.042; Sat, 20 Feb 2021
 04:59:05 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: SelvaKumar S <selvakuma.s1@samsung.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH v5 2/4] block: add simple copy support
Thread-Topic: [RFC PATCH v5 2/4] block: add simple copy support
Thread-Index: AQHXByxWhY0q9dGq/EW9B8B+rRJ+Hw==
Date: Sat, 20 Feb 2021 04:59:05 +0000
Message-ID: <BL0PR04MB6514EA91680D33A5890ECE16E7839@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <CGME20210219124603epcas5p33add0f2c1781b2a4d71bf30c9e1ac647@epcas5p3.samsung.com>
 <20210219124517.79359-3-selvakuma.s1@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: samsung.com; dkim=none (message not signed)
 header.d=none;samsung.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:8564:8d20:cd78:c10b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5babe2b-4586-438c-e8bf-08d8d55c3f90
x-ms-traffictypediagnostic: BL0PR04MB6596:
x-microsoft-antispam-prvs: <BL0PR04MB659656E0EF6A1CDE80666073E7839@BL0PR04MB6596.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:212;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xJGWCLj4DiBFG5CDe5afglJGPqVYJXQjAupO4WfrrrGnz2pSywIfv9mTUfj72QExxlITqjWEVc0hcXgBblc3+WEFIdYjmOq7j99Mg+D/c6EHhMmbguCQnANazKDM+qddpHztk6/gIgsBJl7c9Nuf7LXnSvGbyou2BMISTQ5Ocl1LwVIqJiEi74p7YgUUGCuApHNtmIT9WF+1IDrjTHJxFfxavw2CU9zW3VZ+sn4emYR2VgUGTNkdvXvolVctJynez9PGXweyVMJ7SzIxpatv4eol4AlArpMlQLU/Z+qijCHnMRxqdOi2jFLZsMGNur+FJwjAS3tsY4NlrCOOPtTiJ0hVB0mCKoBDiTffV91vakzLzFk001yOUNrGABUi42m66UjBup6GUSkOEUUwq9+HIa8zZhdbDbhbIhaBvz0kEXOE3FrRUZpkVwv+SRZC5hOuqDW5jjO1bhjJ84s3m9RfTMdYKVBRY6zn0iCrfim9ysztDJfg3BWRPExd3PFDaYUYZd2QgLgKXq2CMBNaTZZYsg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(66556008)(52536014)(4326008)(478600001)(55016002)(66446008)(186003)(8676002)(64756008)(66476007)(86362001)(33656002)(5660300002)(66946007)(76116006)(54906003)(30864003)(7416002)(71200400001)(7696005)(6506007)(8936002)(110136005)(66574015)(9686003)(316002)(53546011)(83380400001)(91956017)(2906002)(579004)(559001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?t3MoaFVTto4ASbrrzVA5RNp8PswKiwY7TlkBpTLxLYXQDOLnK75M+YR8nY?=
 =?iso-8859-1?Q?SzmFh8AibEW+Sfyq0VM49DTM469OGqpLuwrGRWeFsRZEt0/kwG50mvmn4t?=
 =?iso-8859-1?Q?Mni6s+4RHkZvbBy/QnfOT8n35sMCzivmegno27EUGLuKzkZjcAyMZlTY3o?=
 =?iso-8859-1?Q?BE9ieTxqtM9QTraZ4o0UzEomFsEJ0mBG1hgcoyD+p4mHTlFc9zEM8xxL1w?=
 =?iso-8859-1?Q?/SDv5xdL4+TUeXdf5PUySi3licFImUbqQk+hl22gWXpQIkAhVYaxksA4+C?=
 =?iso-8859-1?Q?aBx0objpgqEgjCSZ0/NjVizeS376QNpaBUSZG4pfE4TMw8KktXG3bcJwp7?=
 =?iso-8859-1?Q?rVyLCyVUv3w7wGO3aAU8jxeAc17a5h1XUIOmNwkIaLu38FC5B7sl9p1D/Z?=
 =?iso-8859-1?Q?COqUWzUEH6h+HZ01oUmVFO92Z1v/l5tef9HmbkrdhxQc2AI8p2i1/VQa9G?=
 =?iso-8859-1?Q?1J/BevCvksxnq8EIwb8nnULJ7ouwe8EN9OtysFRzurjEW0HEX3u+oTxYsO?=
 =?iso-8859-1?Q?XVf8reU5EYyoKXJUIDUfZILoDlemBplZldcFu85DS7xOcjMiZehs8WmdIX?=
 =?iso-8859-1?Q?q3JL5rsKB1vX/hi+8Uxqu4/SEAIdjupI6g3un6RAF9Mr2zDF0nQ/H8yNxx?=
 =?iso-8859-1?Q?VsfqH96+xP36qKbHIqb1hCaNRw4P8Lgnc/N7AFk1pBMaKEpNGIYXmIAgxK?=
 =?iso-8859-1?Q?fW5gcFxHFTTzYCoZfV7Rf+2I6J1yE1R6jgZ+gfQYnzERwSQHOJWIAR4Z65?=
 =?iso-8859-1?Q?Rpt3wBAHxXAThdoa7NCIYQIyu047gyVOsd+eeSw9j4xKoGsWiQ5uRAG5vZ?=
 =?iso-8859-1?Q?dKIrbQQk2bYVPpPw0yklXtnCgUDeZRS9kh7GTK6fiDiii5Nj4fg99Rq+c6?=
 =?iso-8859-1?Q?n/IR3wKh9kfGyMjcEoWVC9q8ZIoyw95AxAzbkIJdj90xs/PqIBh7fNdQEp?=
 =?iso-8859-1?Q?/Zn0k931pc1ekv0i9fYPqteEHa38DOCq34wW6rO8QW2eJ2BDQf30Jrq8HS?=
 =?iso-8859-1?Q?Qyp59SWtXuwYn2FWvkkNvjcMlvZWCMWUHJBXQmTri741/JwxJb2WRZwM7p?=
 =?iso-8859-1?Q?gn0yt2xq7FUwUloMzqnPi+3MVPjT0Z2STfkwzVdv2w2ecWM88O3CFqRaU+?=
 =?iso-8859-1?Q?slIbTW9mVTnxVQsPqVfpZJOr3eF4IC6sCBKEfiTUuJV7RVZ4UM8d+XyUpb?=
 =?iso-8859-1?Q?PlP6DrLUC+u5W3tobVUjNPsk0NYKSXmkxXVkJg0Oqbgb8f5pSXyuuZyylf?=
 =?iso-8859-1?Q?ou1LEzqYqodiu8VIoRwt6urAJfzSgbxUC1VkfnGctU3c9gJZ8jIcXesiXY?=
 =?iso-8859-1?Q?jbGLnV2hsAmihysCopE4OkJi+5qMbDyFYfEV9OJYhb9Or5jQZDN+wK9tTv?=
 =?iso-8859-1?Q?idkJpGN/nDxi7SuDiRBHlc8zr62LXMeW0L+7aat1LbImkcBG75eIdBj1CS?=
 =?iso-8859-1?Q?AxaFoXdLVoGiSD6G/Pfk2GhhK1Ft/opuajLgUA=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5babe2b-4586-438c-e8bf-08d8d55c3f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2021 04:59:05.2038 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XMIKy0SE062u2yGnIACGuF7f1lb89/pAGx49OIE2J5dWf8Ydv8X6L4nnNB7GGPsUEYC1CiPhQeGiRr4Zz9uMCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6596
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210219_235913_763393_BB11360C 
X-CRM114-Status: GOOD (  26.87  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "kch@kernel.org" <kch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "snitzer@redhat.com" <snitzer@redhat.com>,
 "selvajove@gmail.com" <selvajove@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "joshiiitr@gmail.com" <joshiiitr@gmail.com>, "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/02/20 11:01, SelvaKumar S wrote:
> Add new BLKCOPY ioctl that offloads copying of one or more sources
> ranges to a destination in the device. Accepts a 'copy_range' structure
> that contains destination (in sectors), no of sources and pointer to the
> array of source ranges. Each source range is represented by 'range_entry'
> that contains start and length of source ranges (in sectors).
> =

> Introduce REQ_OP_COPY, a no-merge copy offload operation. Create
> bio with control information as payload and submit to the device.
> REQ_OP_COPY(19) is a write op and takes zone_write_lock when submitted
> to zoned device.
> =

> If the device doesn't support copy or copy offload is disabled, then
> copy operation is emulated by default. However, the copy-emulation is an
> opt-in feature. Caller can choose not to use the copy-emulation by
> specifying a flag 'BLKDEV_COPY_NOEMULATION'.
> =

> Copy-emulation is implemented by allocating memory of total copy size.
> The source ranges are read into memory by chaining bio for each source
> ranges and submitting them async and the last bio waits for completion.
> After data is read, it is written to the destination.
> =

> bio_map_kern() is used to allocate bio and add pages of copy buffer to
> bio. As bio->bi_private and bio->bi_end_io are needed for chaining the
> bio and gets over-written, invalidate_kernel_vmap_range() for read is
> called in the caller.
> =

> Introduce queue limits for simple copy and other helper functions.
> Add device limits as sysfs entries.
> 	- copy_offload
> 	- max_copy_sectors
> 	- max_copy_ranges_sectors
> 	- max_copy_nr_ranges
> =

> copy_offload(=3D 0) is disabled by default. This needs to be enabled if
> copy-offload needs to be used.
> max_copy_sectors =3D 0 indicates the device doesn't support native copy.
> =

> Native copy offload is not supported for stacked devices and is done via
> copy emulation.
> =

> Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Javier Gonz=E1lez <javier.gonz@samsung.com>
> Signed-off-by: Chaitanya Kulkarni <kch@kernel.org>
> ---
>  block/blk-core.c          | 102 ++++++++++++++++--
>  block/blk-lib.c           | 222 ++++++++++++++++++++++++++++++++++++++
>  block/blk-merge.c         |   2 +
>  block/blk-settings.c      |  10 ++
>  block/blk-sysfs.c         |  47 ++++++++
>  block/blk-zoned.c         |   1 +
>  block/bounce.c            |   1 +
>  block/ioctl.c             |  33 ++++++
>  include/linux/bio.h       |   1 +
>  include/linux/blk_types.h |  14 +++
>  include/linux/blkdev.h    |  15 +++
>  include/uapi/linux/fs.h   |  13 +++
>  12 files changed, 453 insertions(+), 8 deletions(-)
> =

> diff --git a/block/blk-core.c b/block/blk-core.c
> index 7663a9b94b80..23e646e5ae43 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -720,6 +720,17 @@ static noinline int should_fail_bio(struct bio *bio)
>  }
>  ALLOW_ERROR_INJECTION(should_fail_bio, ERRNO);
>  =

> +static inline int bio_check_copy_eod(struct bio *bio, sector_t start,
> +		sector_t nr_sectors, sector_t max_sect)
> +{
> +	if (nr_sectors && max_sect &&
> +	    (nr_sectors > max_sect || start > max_sect - nr_sectors)) {
> +		handle_bad_sector(bio, max_sect);
> +		return -EIO;
> +	}
> +	return 0;
> +}
> +
>  /*
>   * Check whether this bio extends beyond the end of the device or partit=
ion.
>   * This may well happen - the kernel calls bread() without checking the =
size of
> @@ -738,6 +749,75 @@ static inline int bio_check_eod(struct bio *bio, sec=
tor_t maxsector)
>  	return 0;
>  }
>  =

> +/*
> + * Check for copy limits and remap source ranges if needed.
> + */
> +static int blk_check_copy(struct bio *bio)
> +{
> +	struct blk_copy_payload *payload =3D bio_data(bio);
> +	struct request_queue *q =3D bio->bi_disk->queue;
> +	sector_t max_sect, start_sect, copy_size =3D 0;
> +	sector_t src_max_sect, src_start_sect;
> +	struct block_device *bd_part;
> +	int i, ret =3D -EIO;
> +
> +	rcu_read_lock();
> +
> +	bd_part =3D __disk_get_part(bio->bi_disk, bio->bi_partno);
> +	if (unlikely(!bd_part)) {
> +		rcu_read_unlock();
> +		goto out;
> +	}
> +
> +	max_sect =3D  bdev_nr_sectors(bd_part);
> +	start_sect =3D bd_part->bd_start_sect;
> +
> +	src_max_sect =3D bdev_nr_sectors(payload->src_bdev);
> +	src_start_sect =3D payload->src_bdev->bd_start_sect;
> +
> +	if (unlikely(should_fail_request(bd_part, bio->bi_iter.bi_size)))
> +		goto out;
> +
> +	if (unlikely(bio_check_ro(bio, bd_part)))
> +		goto out;

There is no rcu_unlock() in that out label. Did you test ?

> +
> +	rcu_read_unlock();
> +
> +	/* cannot handle copy crossing nr_ranges limit */
> +	if (payload->copy_nr_ranges > q->limits.max_copy_nr_ranges)
> +		goto out;
> +
> +	for (i =3D 0; i < payload->copy_nr_ranges; i++) {
> +		ret =3D bio_check_copy_eod(bio, payload->range[i].src,
> +				payload->range[i].len, src_max_sect);
> +		if (unlikely(ret))
> +			goto out;
> +
> +		/* single source range length limit */
> +		if (payload->range[i].len > q->limits.max_copy_range_sectors)
> +			goto out;

ret is not set. You will return success with this.

> +
> +		payload->range[i].src +=3D src_start_sect;
> +		copy_size +=3D payload->range[i].len;
> +	}
> +
> +	/* check if copy length crosses eod */
> +	ret =3D bio_check_copy_eod(bio, bio->bi_iter.bi_sector,
> +				copy_size, max_sect);
> +	if (unlikely(ret))
> +		goto out;
> +
> +	/* cannot handle copy more than copy limits */
> +	if (copy_size > q->limits.max_copy_sectors)
> +		goto out;

Again ret is not set... No error return ?

> +
> +	bio->bi_iter.bi_sector +=3D start_sect;
> +	bio->bi_partno =3D 0;
> +	ret =3D 0;
> +out:
> +	return ret;
> +}
> +
>  /*
>   * Remap block n of partition p to block n+start(p) of the disk.
>   */
> @@ -827,14 +907,16 @@ static noinline_for_stack bool submit_bio_checks(st=
ruct bio *bio)
>  	if (should_fail_bio(bio))
>  		goto end_io;
>  =

> -	if (bio->bi_partno) {
> -		if (unlikely(blk_partition_remap(bio)))
> -			goto end_io;
> -	} else {
> -		if (unlikely(bio_check_ro(bio, bio->bi_disk->part0)))
> -			goto end_io;
> -		if (unlikely(bio_check_eod(bio, get_capacity(bio->bi_disk))))
> -			goto end_io;
> +	if (likely(!op_is_copy(bio->bi_opf))) {
> +		if (bio->bi_partno) {
> +			if (unlikely(blk_partition_remap(bio)))
> +				goto end_io;
> +		} else {
> +			if (unlikely(bio_check_ro(bio, bio->bi_disk->part0)))
> +				goto end_io;
> +			if (unlikely(bio_check_eod(bio, get_capacity(bio->bi_disk))))
> +				goto end_io;
> +		}
>  	}
>  =

>  	/*
> @@ -858,6 +940,10 @@ static noinline_for_stack bool submit_bio_checks(str=
uct bio *bio)
>  		if (!blk_queue_discard(q))
>  			goto not_supported;
>  		break;
> +	case REQ_OP_COPY:
> +		if (unlikely(blk_check_copy(bio)))
> +			goto end_io;
> +		break;
>  	case REQ_OP_SECURE_ERASE:
>  		if (!blk_queue_secure_erase(q))
>  			goto not_supported;
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 752f9c722062..97ba58d8d9a1 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -150,6 +150,228 @@ int blkdev_issue_discard(struct block_device *bdev,=
 sector_t sector,
>  }
>  EXPORT_SYMBOL(blkdev_issue_discard);
>  =

> +int blk_copy_offload(struct block_device *dest_bdev, struct blk_copy_pay=
load *payload,
> +		sector_t dest, gfp_t gfp_mask)

Simple copy is only over the same device, right ? So the name "dest_bdev" i=
s a
little strange.

> +{
> +	struct request_queue *q =3D bdev_get_queue(dest_bdev);
> +	struct bio *bio;
> +	int ret, payload_size;
> +
> +	payload_size =3D struct_size(payload, range, payload->copy_nr_ranges);
> +	bio =3D bio_map_kern(q, payload, payload_size, gfp_mask);
> +	if (IS_ERR(bio)) {
> +		ret =3D PTR_ERR(bio);
> +		goto err;

This will do a bio_put() on a non existent bio...

> +	}
> +
> +	bio->bi_iter.bi_sector =3D dest;
> +	bio->bi_opf =3D REQ_OP_COPY | REQ_NOMERGE;
> +	bio_set_dev(bio, dest_bdev);
> +
> +	ret =3D submit_bio_wait(bio);
> +err:
> +	bio_put(bio);
> +	return ret;
> +}
> +
> +int blk_read_to_buf(struct block_device *src_bdev, struct blk_copy_paylo=
ad *payload,
> +		gfp_t gfp_mask, sector_t copy_size, void **buf_p)
> +{
> +	struct request_queue *q =3D bdev_get_queue(src_bdev);
> +	struct bio *bio, *parent =3D NULL;
> +	void *buf =3D NULL;
> +	int copy_len =3D copy_size << SECTOR_SHIFT;
> +	int i, nr_srcs, ret, cur_size, t_len =3D 0;
> +	bool is_vmalloc;
> +
> +	nr_srcs =3D payload->copy_nr_ranges;
> +
> +	buf =3D kvmalloc(copy_len, gfp_mask);
> +	if (!buf)
> +		return -ENOMEM;
> +	is_vmalloc =3D is_vmalloc_addr(buf);
> +
> +	for (i =3D 0; i < nr_srcs; i++) {
> +		cur_size =3D payload->range[i].len << SECTOR_SHIFT;
> +
> +		bio =3D bio_map_kern(q, buf + t_len, cur_size, gfp_mask);
> +		if (IS_ERR(bio)) {
> +			ret =3D PTR_ERR(bio);
> +			goto out;
> +		}
> +
> +		bio->bi_iter.bi_sector =3D payload->range[i].src;
> +		bio->bi_opf =3D REQ_OP_READ;
> +		bio_set_dev(bio, src_bdev);
> +		bio->bi_end_io =3D NULL;
> +		bio->bi_private =3D NULL;
> +
> +		if (parent) {
> +			bio_chain(parent, bio);
> +			submit_bio(parent);
> +		}
> +
> +		parent =3D bio;
> +		t_len +=3D cur_size;
> +	}
> +
> +	ret =3D submit_bio_wait(bio);
> +	bio_put(bio);
> +	if (is_vmalloc)
> +		invalidate_kernel_vmap_range(buf, copy_len);

But blk_write_from_buf() will use the buffer right after this.. Is this rea=
lly OK ?

> +	if (ret)
> +		goto out;
> +
> +	*buf_p =3D buf;
> +	return 0;
> +out:
> +	kvfree(buf);
> +	return ret;
> +}
> +
> +int blk_write_from_buf(struct block_device *dest_bdev, void *buf, sector=
_t dest,
> +		sector_t copy_size, gfp_t gfp_mask)
> +{
> +	struct request_queue *q =3D bdev_get_queue(dest_bdev);
> +	struct bio *bio;
> +	int ret, copy_len =3D copy_size << SECTOR_SHIFT;
> +
> +	bio =3D bio_map_kern(q, buf, copy_len, gfp_mask);
> +	if (IS_ERR(bio)) {
> +		ret =3D PTR_ERR(bio);
> +		goto out;
> +	}
> +	bio_set_dev(bio, dest_bdev);
> +	bio->bi_opf =3D REQ_OP_WRITE;
> +	bio->bi_iter.bi_sector =3D dest;
> +
> +	bio->bi_end_io =3D NULL;
> +	ret =3D submit_bio_wait(bio);
> +	bio_put(bio);
> +out:
> +	return ret;
> +}
> +
> +int blk_prepare_payload(struct block_device *src_bdev, int nr_srcs, stru=
ct range_entry *rlist,
> +		gfp_t gfp_mask, struct blk_copy_payload **payload_p, sector_t *copy_si=
ze)
> +{
> +
> +	struct request_queue *q =3D bdev_get_queue(src_bdev);
> +	struct blk_copy_payload *payload;
> +	sector_t bs_mask, total_len =3D 0;
> +	int i, ret, payload_size;
> +
> +	if (!q)
> +		return -ENXIO;
> +
> +	if (!nr_srcs)
> +		return -EINVAL;
> +
> +	if (bdev_read_only(src_bdev))
> +		return -EPERM;
> +
> +	bs_mask =3D (bdev_logical_block_size(src_bdev) >> 9) - 1;
> +
> +	payload_size =3D struct_size(payload, range, nr_srcs);
> +	payload =3D kmalloc(payload_size, gfp_mask);
> +	if (!payload)
> +		return -ENOMEM;
> +
> +	for (i =3D 0; i < nr_srcs; i++) {
> +		if (rlist[i].src & bs_mask || rlist[i].len & bs_mask) {
> +			ret =3D -EINVAL;
> +			goto err;
> +		}
> +
> +		payload->range[i].src =3D rlist[i].src;
> +		payload->range[i].len =3D rlist[i].len;
> +
> +		total_len +=3D rlist[i].len;
> +	}
> +
> +	payload->copy_nr_ranges =3D i;
> +	payload->src_bdev =3D src_bdev;
> +	*copy_size =3D total_len;
> +
> +	*payload_p =3D payload;
> +	return 0;
> +err:
> +	kfree(payload);
> +	return ret;
> +}
> +
> +int blk_copy_emulate(struct block_device *src_bdev, struct blk_copy_payl=
oad *payload,
> +			struct block_device *dest_bdev, sector_t dest,
> +			sector_t copy_size, gfp_t gfp_mask)
> +{
> +	void *buf =3D NULL;
> +	int ret;
> +
> +	ret =3D blk_read_to_buf(src_bdev, payload, gfp_mask, copy_size, &buf);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D blk_write_from_buf(dest_bdev, buf, dest, copy_size, gfp_mask);
> +	if (buf)
> +		kvfree(buf);
> +out:
> +	return ret;
> +}

I already commented that this should better use the dm-kcopyd design, which
would be far more efficient than this. This will be slow...

Your function blkdev_issue_copy() below should deal only with issuing simple
copy (amd later scsi xcopy) for devices that support it. Bring the dm-kcopyd
interface in the block layer as a generic interface for hadling emulation.
Otherwise you are repeating what dm does, but not as efficiently.

> +
> +/**
> + * blkdev_issue_copy - queue a copy
> + * @src_bdev:	source block device
> + * @nr_srcs:	number of source ranges to copy
> + * @rlist:	array of source ranges in sector
> + * @dest_bdev:	destination block device
> + * @dest:	destination in sector
> + * @gfp_mask:   memory allocation flags (for bio_alloc)
> + * @flags:	BLKDEV_COPY_* flags to control behaviour
> + *
> + * Description:
> + *	Copy array of source ranges from source block device to
> + *	destination block devcie. All source must belong to same bdev and
> + *	length of a source range cannot be zero.
> + */
> +
> +int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
> +		struct range_entry *src_rlist, struct block_device *dest_bdev,
> +		sector_t dest, gfp_t gfp_mask, int flags)
> +{
> +	struct request_queue *q =3D bdev_get_queue(src_bdev);
> +	struct request_queue *dest_q =3D bdev_get_queue(dest_bdev);
> +	struct blk_copy_payload *payload;
> +	sector_t bs_mask, copy_size;
> +	int ret;
> +
> +	ret =3D blk_prepare_payload(src_bdev, nr_srcs, src_rlist, gfp_mask,
> +			&payload, &copy_size);
> +	if (ret)
> +		return ret;
> +
> +	bs_mask =3D (bdev_logical_block_size(dest_bdev) >> 9) - 1;
> +	if (dest & bs_mask) {
> +		return -EINVAL;
> +		goto out;
> +	}
> +
> +	if (q =3D=3D dest_q && q->limits.copy_offload) {
> +		ret =3D blk_copy_offload(src_bdev, payload, dest, gfp_mask);
> +		if (ret)
> +			goto out;
> +	} else if (flags & BLKDEV_COPY_NOEMULATION) {

Why ? whoever calls blkdev_issue_copy() wants a copy to be done. Why would =
that
user say "Fail on me if the device does not support copy" ??? This is a wei=
rd
interface in my opinion.

> +		ret =3D -EIO;
> +		goto out;
> +	} else

Missing braces. By you do not need all these else after the gotos anyway.

> +		ret =3D blk_copy_emulate(src_bdev, payload, dest_bdev, dest,
> +				copy_size, gfp_mask);
> +
> +out:
> +	kvfree(payload);
> +	return ret;
> +}
> +EXPORT_SYMBOL(blkdev_issue_copy);
> +
>  /**
>   * __blkdev_issue_write_same - generate number of bios with same page
>   * @bdev:	target blockdev
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 808768f6b174..4e04f24e13c1 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -309,6 +309,8 @@ void __blk_queue_split(struct bio **bio, unsigned int=
 *nr_segs)
>  	struct bio *split =3D NULL;
>  =

>  	switch (bio_op(*bio)) {
> +	case REQ_OP_COPY:
> +			break;

Why would this even be called ? Copy BIOs cannot be split, right ?

>  	case REQ_OP_DISCARD:
>  	case REQ_OP_SECURE_ERASE:
>  		split =3D blk_bio_discard_split(q, *bio, &q->bio_split, nr_segs);
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 43990b1d148b..93c15ba45a69 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -60,6 +60,10 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->io_opt =3D 0;
>  	lim->misaligned =3D 0;
>  	lim->zoned =3D BLK_ZONED_NONE;
> +	lim->copy_offload =3D 0;
> +	lim->max_copy_sectors =3D 0;
> +	lim->max_copy_nr_ranges =3D 0;
> +	lim->max_copy_range_sectors =3D 0;
>  }
>  EXPORT_SYMBOL(blk_set_default_limits);
>  =

> @@ -565,6 +569,12 @@ int blk_stack_limits(struct queue_limits *t, struct =
queue_limits *b,
>  	if (b->chunk_sectors)
>  		t->chunk_sectors =3D gcd(t->chunk_sectors, b->chunk_sectors);
>  =

> +	/* simple copy not supported in stacked devices */
> +	t->copy_offload =3D 0;
> +	t->max_copy_sectors =3D 0;
> +	t->max_copy_range_sectors =3D 0;
> +	t->max_copy_nr_ranges =3D 0;

You do not need this. Limits not explicitely initialized are 0 already.
But I do not see why you can't support copy on stacked devices. That should=
 be
feasible taking the min() for each of the above limit.

> +
>  	/* Physical block size a multiple of the logical block size? */
>  	if (t->physical_block_size & (t->logical_block_size - 1)) {
>  		t->physical_block_size =3D t->logical_block_size;
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index b513f1683af0..625a72541263 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -166,6 +166,44 @@ static ssize_t queue_discard_granularity_show(struct=
 request_queue *q, char *pag
>  	return queue_var_show(q->limits.discard_granularity, page);
>  }
>  =

> +static ssize_t queue_copy_offload_show(struct request_queue *q, char *pa=
ge)
> +{
> +	return queue_var_show(q->limits.copy_offload, page);
> +}
> +
> +static ssize_t queue_copy_offload_store(struct request_queue *q,
> +				       const char *page, size_t count)
> +{
> +	unsigned long copy_offload;
> +	ssize_t ret =3D queue_var_store(&copy_offload, page, count);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (copy_offload && q->limits.max_copy_sectors =3D=3D 0)
> +		return -EINVAL;
> +
> +	q->limits.copy_offload =3D copy_offload;
> +	return ret;
> +}

This is weird. If you want to allow a user to disable copy offload, then use
max_copy_sectors. This one should be read-only and only indicate if the dev=
ice
supports it or not. I also would actually change this one into
max_copy_hw_sectors, immutable, indicating the max copy sectors that the de=
vice
supports, and 0 for no support. That would allow an easy implementation of
max_copy_sectors being red/write for controlling enable/disable.

> +
> +static ssize_t queue_max_copy_sectors_show(struct request_queue *q, char=
 *page)
> +{
> +	return queue_var_show(q->limits.max_copy_sectors, page);
> +}
> +
> +static ssize_t queue_max_copy_range_sectors_show(struct request_queue *q,
> +		char *page)
> +{
> +	return queue_var_show(q->limits.max_copy_range_sectors, page);
> +}
> +
> +static ssize_t queue_max_copy_nr_ranges_show(struct request_queue *q,
> +		char *page)
> +{
> +	return queue_var_show(q->limits.max_copy_nr_ranges, page);
> +}
> +
>  static ssize_t queue_discard_max_hw_show(struct request_queue *q, char *=
page)
>  {
>  =

> @@ -591,6 +629,11 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
>  QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
>  QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
>  =

> +QUEUE_RW_ENTRY(queue_copy_offload, "copy_offload");
> +QUEUE_RO_ENTRY(queue_max_copy_sectors, "max_copy_sectors");
> +QUEUE_RO_ENTRY(queue_max_copy_range_sectors, "max_copy_range_sectors");
> +QUEUE_RO_ENTRY(queue_max_copy_nr_ranges, "max_copy_nr_ranges");
> +
>  QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
>  QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
>  QUEUE_RW_ENTRY(queue_poll, "io_poll");
> @@ -636,6 +679,10 @@ static struct attribute *queue_attrs[] =3D {
>  	&queue_discard_max_entry.attr,
>  	&queue_discard_max_hw_entry.attr,
>  	&queue_discard_zeroes_data_entry.attr,
> +	&queue_copy_offload_entry.attr,
> +	&queue_max_copy_sectors_entry.attr,
> +	&queue_max_copy_range_sectors_entry.attr,
> +	&queue_max_copy_nr_ranges_entry.attr,
>  	&queue_write_same_max_entry.attr,
>  	&queue_write_zeroes_max_entry.attr,
>  	&queue_zone_append_max_entry.attr,
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 7a68b6e4300c..02069178d51e 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -75,6 +75,7 @@ bool blk_req_needs_zone_write_lock(struct request *rq)
>  	case REQ_OP_WRITE_ZEROES:
>  	case REQ_OP_WRITE_SAME:
>  	case REQ_OP_WRITE:
> +	case REQ_OP_COPY:
>  		return blk_rq_zone_is_seq(rq);
>  	default:
>  		return false;
> diff --git a/block/bounce.c b/block/bounce.c
> index d3f51acd6e3b..5e052afe8691 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -254,6 +254,7 @@ static struct bio *bounce_clone_bio(struct bio *bio_s=
rc, gfp_t gfp_mask,
>  	bio->bi_iter.bi_size	=3D bio_src->bi_iter.bi_size;
>  =

>  	switch (bio_op(bio)) {
> +	case REQ_OP_COPY:
>  	case REQ_OP_DISCARD:
>  	case REQ_OP_SECURE_ERASE:
>  	case REQ_OP_WRITE_ZEROES:
> diff --git a/block/ioctl.c b/block/ioctl.c
> index d61d652078f4..0e52181657a4 100644
> --- a/block/ioctl.c
> +++ b/block/ioctl.c
> @@ -133,6 +133,37 @@ static int blk_ioctl_discard(struct block_device *bd=
ev, fmode_t mode,
>  				    GFP_KERNEL, flags);
>  }
>  =

> +static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
> +		unsigned long arg, unsigned long flags)
> +{
> +	struct copy_range crange;
> +	struct range_entry *rlist;
> +	int ret;
> +
> +	if (!(mode & FMODE_WRITE))
> +		return -EBADF;
> +
> +	if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
> +		return -EFAULT;
> +
> +	rlist =3D kmalloc_array(crange.nr_range, sizeof(*rlist),
> +			GFP_KERNEL);
> +	if (!rlist)
> +		return -ENOMEM;
> +
> +	if (copy_from_user(rlist, (void __user *)crange.range_list,
> +				sizeof(*rlist) * crange.nr_range)) {
> +		ret =3D -EFAULT;
> +		goto out;
> +	}
> +
> +	ret =3D blkdev_issue_copy(bdev, crange.nr_range, rlist, bdev, crange.de=
st,
> +			GFP_KERNEL, flags);
> +out:
> +	kfree(rlist);
> +	return ret;
> +}
> +
>  static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
>  		unsigned long arg)
>  {
> @@ -458,6 +489,8 @@ static int blkdev_common_ioctl(struct block_device *b=
dev, fmode_t mode,
>  	case BLKSECDISCARD:
>  		return blk_ioctl_discard(bdev, mode, arg,
>  				BLKDEV_DISCARD_SECURE);
> +	case BLKCOPY:
> +		return blk_ioctl_copy(bdev, mode, arg, 0);
>  	case BLKZEROOUT:
>  		return blk_ioctl_zeroout(bdev, mode, arg);
>  	case BLKREPORTZONE:
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 1edda614f7ce..164313bdfb35 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -71,6 +71,7 @@ static inline bool bio_has_data(struct bio *bio)
>  static inline bool bio_no_advance_iter(const struct bio *bio)
>  {
>  	return bio_op(bio) =3D=3D REQ_OP_DISCARD ||
> +	       bio_op(bio) =3D=3D REQ_OP_COPY ||
>  	       bio_op(bio) =3D=3D REQ_OP_SECURE_ERASE ||
>  	       bio_op(bio) =3D=3D REQ_OP_WRITE_SAME ||
>  	       bio_op(bio) =3D=3D REQ_OP_WRITE_ZEROES;
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
> index 866f74261b3b..5a35c02ac0a8 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -380,6 +380,8 @@ enum req_opf {
>  	REQ_OP_ZONE_RESET	=3D 15,
>  	/* reset all the zone present on the device */
>  	REQ_OP_ZONE_RESET_ALL	=3D 17,
> +	/* copy ranges within device */
> +	REQ_OP_COPY		=3D 19,
>  =

>  	/* SCSI passthrough using struct scsi_request */
>  	REQ_OP_SCSI_IN		=3D 32,
> @@ -506,6 +508,11 @@ static inline bool op_is_discard(unsigned int op)
>  	return (op & REQ_OP_MASK) =3D=3D REQ_OP_DISCARD;
>  }
>  =

> +static inline bool op_is_copy(unsigned int op)
> +{
> +	return (op & REQ_OP_MASK) =3D=3D REQ_OP_COPY;
> +}
> +
>  /*
>   * Check if a bio or request operation is a zone management operation, w=
ith
>   * the exception of REQ_OP_ZONE_RESET_ALL which is treated as a special =
case
> @@ -565,4 +572,11 @@ struct blk_rq_stat {
>  	u64 batch;
>  };
>  =

> +struct blk_copy_payload {
> +	sector_t	dest;
> +	int		copy_nr_ranges;
> +	struct block_device *src_bdev;
> +	struct	range_entry	range[];
> +};
> +
>  #endif /* __LINUX_BLK_TYPES_H */
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 699ace6b25ff..2bb4513d4bb8 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -337,10 +337,14 @@ struct queue_limits {
>  	unsigned int		max_zone_append_sectors;
>  	unsigned int		discard_granularity;
>  	unsigned int		discard_alignment;
> +	unsigned int		copy_offload;
> +	unsigned int		max_copy_sectors;
>  =

>  	unsigned short		max_segments;
>  	unsigned short		max_integrity_segments;
>  	unsigned short		max_discard_segments;
> +	unsigned short		max_copy_range_sectors;
> +	unsigned short		max_copy_nr_ranges;
>  =

>  	unsigned char		misaligned;
>  	unsigned char		discard_misaligned;
> @@ -621,6 +625,7 @@ struct request_queue {
>  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
>  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active =
*/
>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
> +#define QUEUE_FLAG_SIMPLE_COPY	30	/* supports simple copy */
>  =

>  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
>  				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> @@ -643,6 +648,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, s=
truct request_queue *q);
>  #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_fl=
ags)
>  #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->qu=
eue_flags)
>  #define blk_queue_discard(q)	test_bit(QUEUE_FLAG_DISCARD, &(q)->queue_fl=
ags)
> +#define blk_queue_copy(q)	test_bit(QUEUE_FLAG_SIMPLE_COPY, &(q)->queue_f=
lags)
>  #define blk_queue_zone_resetall(q)	\
>  	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
>  #define blk_queue_secure_erase(q) \
> @@ -1069,6 +1075,9 @@ static inline unsigned int blk_queue_get_max_sector=
s(struct request_queue *q,
>  		return min(q->limits.max_discard_sectors,
>  			   UINT_MAX >> SECTOR_SHIFT);
>  =

> +	if (unlikely(op =3D=3D REQ_OP_COPY))
> +		return q->limits.max_copy_sectors;
> +

I would agreee with this if a copy BIO was always a single range, but that =
is
not the case. So I am not sure this makes sense at all.

>  	if (unlikely(op =3D=3D REQ_OP_WRITE_SAME))
>  		return q->limits.max_write_same_sectors;
>  =

> @@ -1343,6 +1352,12 @@ extern int __blkdev_issue_discard(struct block_dev=
ice *bdev, sector_t sector,
>  		sector_t nr_sects, gfp_t gfp_mask, int flags,
>  		struct bio **biop);
>  =

> +#define BLKDEV_COPY_NOEMULATION	(1 << 0)	/* do not emulate if copy offlo=
ad not supported */
> +
> +extern int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
> +		struct range_entry *src_rlist, struct block_device *dest_bdev,
> +		sector_t dest, gfp_t gfp_mask, int flags);

No need for extern.

> +
>  #define BLKDEV_ZERO_NOUNMAP	(1 << 0)  /* do not free blocks */
>  #define BLKDEV_ZERO_NOFALLBACK	(1 << 1)  /* don't write explicit zeroes =
*/
>  =

> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index f44eb0a04afd..5cadb176317a 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -64,6 +64,18 @@ struct fstrim_range {
>  	__u64 minlen;
>  };
>  =

> +struct range_entry {
> +	__u64 src;
> +	__u64 len;
> +};
> +
> +struct copy_range {
> +	__u64 dest;
> +	__u64 nr_range;
> +	__u64 range_list;
> +	__u64 rsvd;
> +};
> +
>  /* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definit=
ions */
>  #define FILE_DEDUPE_RANGE_SAME		0
>  #define FILE_DEDUPE_RANGE_DIFFERS	1
> @@ -184,6 +196,7 @@ struct fsxattr {
>  #define BLKSECDISCARD _IO(0x12,125)
>  #define BLKROTATIONAL _IO(0x12,126)
>  #define BLKZEROOUT _IO(0x12,127)
> +#define BLKCOPY _IOWR(0x12, 128, struct copy_range)
>  /*
>   * A jump here: 130-131 are reserved for zoned block devices
>   * (see uapi/linux/blkzoned.h)
> =


Please test your code more thoroughly. It is full of problems that you shou=
ld
have detected with better testing including RO devices, partitions and error
path coverage.

-- =

Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
