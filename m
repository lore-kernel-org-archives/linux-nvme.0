Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36908C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 10:21:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9115E64DCC
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 10:21:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9115E64DCC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=gQ/O5nEsM943n6GGPmAwMQcmYXtt6bGIHMQuu9Uk9Xc=; b=qd+Hv2CkhxTBAhjm0qtlXgv1d
	5Xrn8siWPLTrb1GLhDUvJ52kT7nJ9X4yNQ4D0+iqKOphyTycYWbOpNkbc7Umr/reNC9f+Zx4vwJPY
	qvSppmvN7GrTMg5VlX9/oeCBW+KLA0/9XxFAWZkVQyZar6OU7wsRIG969X87ouObzG9+TXOvx6ja9
	ZndZfTTZhNAzBZ+/FFnKkkOtuc2DhLVS44Nr7yojS1WWIeoo+ZmvRq/nPMetj04LQle4Pr0waZh3p
	gD4ttkVaZPcpy5mRnUo/bvP+UECkG0xpXUIGW53XLSVYn9STC97hltoKVAsHt7xcjeXMlU3g6+Xh5
	V9O/pP24g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l54Q0-0001Fj-9R; Thu, 28 Jan 2021 10:20:52 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l54Px-0001FG-Sb
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 10:20:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611829250; x=1643365250;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=f7EzVXCXt7JdAps5QjROjUi1NgsresqlKg2iUJrDLWe01DZ9ytHCdStU
 ZVJLFwTO9cZXpklukDYPQ5ZaKn9IXE5voaRdJSxE+60u+Wipc4NcNO/tt
 75j56SR+I0Q+DQdPdvi+fJlngX7skLTSNBY82RyY2gcGPwOUQ7KVAhuUT
 90fmhOGUpbmkZEA7lFIz8qP5yIx7zY7RjmVHUeCYlkb26iH4eOrWpnQdz
 Ai+xcbEEjNzpCewllQ7zAmpS5mzhkSfpUoredwTA6NktFSVYSodTRhp2p
 47sCoEfai7FqPkWKFCDQCmdTmGPpFnG7Hp5GUCwA6JQWoG0prdvQf4psg A==;
IronPort-SDR: 0/Ownn11iOOOln2D/6ejdOVPdV6LyV3RJXRYLiqJlRFP8tLouyPrFG6+Z5LonaXMMzjmShUl9a
 8Qc2cS+ZJt5Var99ZhPlPLbVYiigqo+M1C1oeEW1lcs75Ja9TcJ/UztKMLO9nSm5EsDFBRFdjN
 /LzGvb6YtWnxC6ay3pGFswHEe4vrTQWRvSJUKtRKju/4t6KaRgyT4jMLxXqtlOq3jOjtF8jkTg
 KTCnP3nHKuJsI1p5JJzZIIOhb9PNGPtUjz7kQ5e5qTlPsOGSnH3QLym+dCDhl6/jS6L+81pzD+
 mtg=
X-IronPort-AV: E=Sophos;i="5.79,382,1602518400"; d="scan'208";a="159709060"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 18:20:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hT5CbbPMUE5606Yzz4uOIXDDj7ExXrpS2/q1Ka09hx0/x4fAc00R9Bwp/waWIjTfK04va6GZcZtTiyZunYa1+nbYI4kTExnS1EDajyFX/JhK/CmWxpeXsvUC1EZDDvI7q4lD/WzPKCA02MTZBYv8+ekyoWaCoQ7Yb1Je6RYCmxv6/4EpZtUjuJyqa7EserEAN8dG1SC8Svw+mryUKPuUp712RLvGL9YDy03QKiWjO33Y/vfyBDW1JwFn3eO2iD0HVNc7Y+bLBd7qlFIr19dMYuzrArRNm2Znp9qTgvo/9ASDQl0VIedQ3oYOwgzg8Qh/CLBcFMhfWI1hQMpgpmJmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=G7tRttjr5z7ugsb6qUFmPqlmEYJXQaGLy5ywMNyC0McCbC8aCuqSjsjXoCF0T63XGQSgH3ZSHTGlVJZkw3sMTCn1pHTXgSEeaW3gxjKs7ynSGkqWVwD98Yd4PYnajzG3sa5hgBedhmNmchXSTAAclImaOHFdT+ZPyE9+DaFpdoqPN/m7Yz2zdO9onvE04G1wVD/lcuE60IMnWExbkeJ4+muNG/hSaSFUB8f5BqROtacqj/S+dmj7tnJcyjTN6bZpyVnKeHOWtrER/83eqpa024fnwkYgYn3VW7C/r9lcxAP2XZK9bS9TNRcaBwTJjijzgs5T8AseoF15zCumZikk5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=u19aUvqlweRrQpNLsZkhitiGc4lf57EUuB9j/EA+6aBfjXkkAAweZXcMZloQ3F1iPiLMYot13okDPOv5mj9phPkhwetXacJBNm0OaPJhXZczQOvCSLl9vgGVzKpbkF6GnCCbaEpVesbxBebbwIgYfehOp5WWgj2g1aYq0fJqW8k=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4464.namprd04.prod.outlook.com
 (2603:10b6:805:b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.17; Thu, 28 Jan
 2021 10:20:46 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%6]) with mapi id 15.20.3784.017; Thu, 28 Jan 2021
 10:20:46 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v4 1/8] block: document zone_append_max_bytes attribute
Thread-Topic: [PATCH v4 1/8] block: document zone_append_max_bytes attribute
Thread-Index: AQHW9TEkMgeHpmzBJUK18PNs2a0qPQ==
Date: Thu, 28 Jan 2021 10:20:46 +0000
Message-ID: <SN4PR0401MB3598E30093CC3EF92E0397839BBA9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
 <20210128044733.503606-2-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.238]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd4af1dc-74d5-4b90-9d6c-08d8c376604d
x-ms-traffictypediagnostic: SN6PR04MB4464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB44646F3246845C6A0D1BB1009BBA9@SN6PR04MB4464.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bDW6g8cMkdEv/Po3RuZv5maIY11NsYjbOXpqbLAazk0ZpZbiqOhtx/OHN9c0FeYoe/tGIVYNC9sjeAvoh5wEOnDxgxZLhAP4XzuMj+UZlgusgHv2Fw9jw7xuHPUYgIghtuuUSiH3wxBZd54xrfQhQZpLjAj37O13H6wqTOJadPlNu9aTxzao6oQ7k29NSFQw+ADoHvBlAoKu1+2fIAqRokawdZBWFPQ5Vm4u5EsDF7Hc/stAUld1omCYb8k1v8eSFerYnBLhs6EW9oNuKrtVYb25GdK2s7qzAmvVkEXEow5S+MxPFNfuoTH6BrEou96dkdpwdrnivc4B6ntAAY97P9x/3ICF+YWRsbkot9IG2xpfkesdyLgK/wuwETv7cYNhGNLRxR1nqC7z/Ua0zplOB804zoYFW5RHdEY+GPRES2UnezXKAJC90AwqSlxOnydZU+EWbwfNokMxQ9tXcbMiOM+L6Zbh5QTymDB1FrN6px5OQFwALU4tXNrYI17xX2OjfK1ayVwOSmj/MK5R55zb0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0401MB3598.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(110136005)(76116006)(64756008)(71200400001)(8936002)(66446008)(66946007)(6506007)(5660300002)(7696005)(8676002)(86362001)(91956017)(66476007)(478600001)(66556008)(26005)(52536014)(54906003)(9686003)(316002)(2906002)(33656002)(4326008)(558084003)(19618925003)(4270600006)(186003)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CgyucL/mouhnFC7ycJ+6gkxehUZRI+vIKjgRDU4BUjY3JbYTVw3KZAvokeut?=
 =?us-ascii?Q?ve6hrpnfTSne76ZOQhqZqHFZeNhzs3w9sdPc27gcof025q5REEoTcdJd6EB6?=
 =?us-ascii?Q?t8rG2DxgBqvQRvToDb5rXGmGN6BAuPqWGUarG6L2foji9rjehsiYagpuQ0GL?=
 =?us-ascii?Q?S2JQoOEkzpKHMnfBevEyqpqz1x5xeaa4NyhMouqguyimojg2IM2UDuj6Go4+?=
 =?us-ascii?Q?kih7cPg21dUPUiJyriLhhj06VMj0Fxd9Xnu66dRi5Mp1AIjeRuGMz292Orh+?=
 =?us-ascii?Q?hOE5/weD5m9CGgpM/xGRQZukdcv5i8P9yhj8ynBoWwWfBA+6cqVB9m+v8O84?=
 =?us-ascii?Q?oY+go8IZFwNkvTuPI34uyzt3T4kGMMrWLwUhEg1qNQRWZlTI2LVEbWaMWV09?=
 =?us-ascii?Q?Jh2osTk9JsbaRjHtMeQ7dL+gkuQiX9FiI5mdJGdV/yRkbxqqsaeTxnRNrbgN?=
 =?us-ascii?Q?kwA7bj7QazAXdMycJh2OCR45Yyjb6daCPQN+4DD9LH5tomihh4SEQBa+GNhr?=
 =?us-ascii?Q?0fIcUxubWxmDjtclM8QnGlaLLr70GdsnWWCStacs/rX75t2mOXyZ75QxSJS+?=
 =?us-ascii?Q?w0RueJi/GjM1/6PW4PLANwLa06BnzUx8y65DdGLq8Ax+iUVIWGfDw/iPbVmp?=
 =?us-ascii?Q?BxoNR+TRNwOTaVU5rj0pTyG7F0K2lBjmbLasDOdya5va8AVmTmrbU+hd5s/C?=
 =?us-ascii?Q?JlQTUi3Ov9t/Qj5VWissrJtqPyjkdQs8w6SDagUETV88RohS5/F93XqKy/Ey?=
 =?us-ascii?Q?/k8X6NSJwGaREpuGpQViyf6n+bavmQWE3mCVKZX9/kuhY8XZkTOWbAUQ3vHF?=
 =?us-ascii?Q?Rzc+mDxj4Uz1eRhm3dEZKi99lrVZzMnZml2O9U7ZsrFJAWwlPf6Z2eY+9QcO?=
 =?us-ascii?Q?JOT0W7vNlThCiQjpWJVY6DqBpqf/mzibitaAx5uwNRjRhEyiXTOkTDB6BqND?=
 =?us-ascii?Q?ksB1CEocqXwXdxwauEQv6rjs5PLQbxxTlr/PB+O41py3c6j17mhifwLUBC6G?=
 =?us-ascii?Q?KnslUwJt6sksdC1vMAxYenTDm8VSfntl0zbcFED8uIgvyB48XtOR7vvVkyUi?=
 =?us-ascii?Q?ARfBACQdx2cyy7CfDfZghqHiXcCfzQ=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4af1dc-74d5-4b90-9d6c-08d8c376604d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 10:20:46.1032 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3EFqX9X9KE8k2ZjCaB2H0Kpxkn/eF7wyYksZjO3D14dOluEYh7Q1m3cAV5lJSWhS2wZQu0tb4XCiBvm5xLm7hqn1orNiTxAiOoITHuSFtEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4464
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_052050_116089_140ED743 
X-CRM114-Status: GOOD (  11.65  )
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
Cc: Keith Busch <Keith.Busch@wdc.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good,
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
