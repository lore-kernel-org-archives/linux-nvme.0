Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626CEC433ED
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 17:36:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 806A4613C9
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 17:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 806A4613C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=pVa8tUjtL4s2iumScTqkWTssRfa163YUTRDCxyAu8Ic=; b=ppAGMGCEkwoYP8vPNKExf44uB
	4ot154v9VQtonHjEE+qLNB3HD8ChCqTg0iQea1mUE4lp5Yo/MsWNEriq0kvSWKdCwCfaQj6HotfZ2
	7DiA4bDuBtqfNy+zsPB1JDHeywoGpU0RlYibsKkp4VQCxORS9CHO8uq7mXQzoyDeL8CbBqXLiSL5S
	R4UPjILBiD5RptTnVY+PTZCpUzQAPPmcD3RUq7RfmS0F0Bn1bwiDGC+I+6MTf+NQ/tYqh5bEmiJWY
	VZKGlyKXlLzS1JypZxtxBRBYwEY1EBiCxf/JG+i4ScDAA8k82x3y4tseGlda5N2lEWWx0wy7XwCqh
	aN68MxudA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYuI3-00ClNO-7V; Tue, 20 Apr 2021 17:35:59 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYuI0-00ClN0-Pp
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 17:35:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=CZQrKYBF1hrkHHRV8innsLQvvg/Ar+jpZVXjewuaIdg=; b=HCN1iDkvgl4DHcyl6BYySHpwxN
 TxZ9BqiVHlztXw8uT4I9/VAAsGCQiIEq1oR9lo/o1idXyePCJMB3jnghNsJnf8TmLOXt6exbXm1hr
 kog7btKTVt3AZ4Izx38TfNUZHpYX6Ty3MKGtcXWrgkBwzetdU8fwcDhND6IDIfl9f5P2L/CSA0ywG
 q8L0OYU2pBcg4fYPRlVgM29kwiu10CVoFsxq63NYQ6l47bKMkeESm35IAxaYuGvB9BfqL+4nOPm+d
 oUD4keu7z4yAAphN7B3+jHHCUxpjaFH2SYEdTYnmBTbE6luFDZhIJL6k6I8myz9HVWdqOb5mByqKh
 TJZNgn0w==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYuHx-00CJuX-PZ
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 17:35:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618940154; x=1650476154;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=6B6oVONdP4eYRQc/WIhKZn0p82YLXqm3B4CjCHc6mcw=;
 b=DOrCA+IIlsigq/A/ZWSmy7ZgzrkuUHnMHiUbjnD7FNm2c0wlZiiLzEgX
 qtLqvkbx2vpRPrTZXbYeWcIcI3tb5JHXyc/iebP0fmxxeUTmJhXc9HVY8
 aLOpQUt6+a6b9frdsVfhCZr3LAZ8+8QSFcfuUBuN7AtFy8bXW5A5BicbO
 g2kNw7g0HLppXXBm7tgpmIUnS5OZhz9J5/11NdDqynt2/miK7xKa13ws7
 Lx88bXAP+GlNLODRo3r7JRP/5Tiz0FH2yNfgGaWfhs4cCe3wTCSaxZNu+
 8H/fLotLHqEiZ0UFZP/igUEK5wjlw3wzwzr0kS1CBmo7Mbfr2Y4KIBiiF g==;
IronPort-SDR: TOZlFjRsdUz1eBGZ/ADLR+2PCqVz3rfgCzS2AqdJqix4n8DF9EZldX2O1A8iB5xFwPi6dWSaCG
 iIg86HafRGdvh8xC0ytiCUbi8az31UwKPFQUlH+wL15Zstx28FTRyU0N1VNj5Ua6NH8Mlv9d7+
 i0i2C4U8VHUIyoqA4+4Vm/ZjvJm7zx/e+GJ3hAbMv4yv1heetWqaQHWesPSlfZl6duqYM3YcOm
 H23bzCs+r6DcklfBqIeTbYXLDv/qyithhqn1R6YLIq1JANqfD8fyjDN/k3UgsoYBPWcGsVUATD
 yLQ=
X-IronPort-AV: E=Sophos;i="5.82,237,1613404800"; d="scan'208";a="166121124"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
 by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2021 01:35:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKM4BEiFGqBP/HbbaBVNtFeuUAAIwqKPkqs19X/hEjQs7+kEYXCuSaTYXYG1Gxz/RIgE5XRwl/4PK3XXI/up4EDOMFVSJ+1az4UOpQfVrYYUsjZvl6/x2/zH1IElrYc/q8+k6J0BepKNiGj+Xbr2bBf8ZrNBHMi5BKwL0NCR6QU1pK4g4vNTnWK2tccJFOPjncKBQKMsdzp3G3PRYA/ObtaQM33UjOIVdjg8fXH2aAGZMhsIr1vn1QVZOJcSwFf93WzDQJxT8nRhThkg1lZGwqe9PjSuZpXFWxAv1Cb1uyLVqhekKQ8j0eVLzRTlAxpOEloBw3p0/BcWuQOiFBkX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZQrKYBF1hrkHHRV8innsLQvvg/Ar+jpZVXjewuaIdg=;
 b=cdbwREGacXFfyl+oW1C5IGudHh9KaRGxA9psTSW48lp6hKxy5HaG36KNRZiKScHk9xNuL1H5jc0nKEmvlvSCPfvFHlbQEm5NrM8fnGT9lOx26SXSNzJJac/0Gae+aSJ5dHfl/dIfi7yWUh7ctBLyfIcSebTMvour1hv5MB8DPME58Lwl8Baw2K28mFU3ENdq36qHYiDLNmHJLxb5Q3FIwVz/Wdm1CbD6+8XMsyZ1cJpgx+f0FbuDJEve1NAFuwV3IXlpR2RwrUN/KPuRwZrnmYbe+yplXf/4/5V1exsSNTyRYwKds1C3z9E1pA+VFGM8jQr6ilbIQTJ82rBEsYkNMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZQrKYBF1hrkHHRV8innsLQvvg/Ar+jpZVXjewuaIdg=;
 b=SNLidZyGq8DS8b5RAwdv6iOChotAWF8b/ehwiMV1VuGod/s9PvFoP4r/Sx1hQPXimUr2I0Yie9nPRM1c8RHHBOavJFtIzfjttJTl/+rCXOky+ow3tI2lUjThaafzlt1MafMrLHAsRb1jDHpzTCkGd91NFsn81u2+QIfKmBRV2oA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5592.namprd04.prod.outlook.com (2603:10b6:a03:10a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18; Tue, 20 Apr
 2021 17:35:48 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 17:35:48 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
CC: "oren@nvidia.com" <oren@nvidia.com>, "ngottlieb@nvidia.com"
 <ngottlieb@nvidia.com>
Subject: Re: [PATCH 1/4] nvmet: change sn size and check validity
Thread-Topic: [PATCH 1/4] nvmet: change sn size and check validity
Thread-Index: AQHXNcTWJAYbPxX+WkGAFV7uzYisZQ==
Date: Tue, 20 Apr 2021 17:35:48 +0000
Message-ID: <BYAPR04MB4965297F005A2E8EC059606D86489@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210420090903.595664-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca45861b-3bac-41e9-eb5c-08d90422bc60
x-ms-traffictypediagnostic: BYAPR04MB5592:
x-microsoft-antispam-prvs: <BYAPR04MB559238C6A9C4202B2EEC8CE786489@BYAPR04MB5592.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KxnubCloIOyZuSL0GU/wx/i1LlC4BmoKjvSAcHAk0fjxUUYOhxHX2qzWFmKa5FMeZK6UwVz95nNmhAtrrd4vhgfl+V8U5ui0pdcv7t7RQtsPTWMYRek6r3GquPXznHl17EWLsF++oy6dRPvIZiM7wEylyXnIC3jPYlb/E/8olqBu6RrAqABS8g+FVsDPuaGWAnLBznMMSa/lxLZRvcIdFD7IEC2gk35FyrjBALBj15snaWdM33LwEhhkbaYEALrFaiiV9QSlw7+7Y6x1ke+HkX1xIFeK/WPzrzjfD49ML56sCGUBG6a/4VXOAYY439UeaubNwG9wTJKF3cN8CDTfRJL5OWKhGM/HO1zENx9WrxIHIDdJ1UqNA5DyPMu53xaQO8Xu5mr3iq8Hs97jYstY/3Id9NQQAS21suin9EjesLgYFSAGPjHwp4osEnNm4zttb3tVg8k6Dl5ZFprm8XzY76sxudeSlIakbHrDkZUB4cRGc13Jey0NqEx++q5XXO6IN0iIHdB4kT0B8NWR2zk4wWjAS9C3HoeM2j+ZeRFqD3ptoizFqPrndCsZ/InAn+jqViCkvZgGxzpxVDwrQU+hddaSG1Un3lG8Fe5aqYlpF9s=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39850400004)(53546011)(33656002)(6506007)(86362001)(2906002)(66446008)(66556008)(83380400001)(71200400001)(64756008)(5660300002)(66946007)(478600001)(122000001)(8936002)(52536014)(186003)(54906003)(316002)(55016002)(9686003)(38100700002)(66476007)(4326008)(8676002)(26005)(76116006)(7696005)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?YP8e7GRoU814b04W+hyxjYdYAuTy1eSGqw5kbPXx+u4VcVj/y0+du1rND3LX?=
 =?us-ascii?Q?/NWxqpS3YpfFNIl9XECogKDLXL4+tk0SffAfkv1PILqfBRONEV72J75h2fiJ?=
 =?us-ascii?Q?+xN6yC3L0nmwpovk0YBz2+HO1nuNZY3uv7h+NIZRF4gyqPzRTqgeRGlnKIeD?=
 =?us-ascii?Q?alZCEBJ5yHbPg//v7WKvYFrtn3H5fWgC2gxEZHtA86tzRXk77eLYvwq/UZxq?=
 =?us-ascii?Q?AUDVyxFFuJsqqnUkunO3ZihBgG47j47FQxJw3AcDozlWjbfxw8BHfF/MlIZc?=
 =?us-ascii?Q?8q7Lrr6mleDDD+cU8MOiszADu7EgFMbX2B208zAbyfYt1EDSbLqZzisMbBZb?=
 =?us-ascii?Q?HFKcm4CwfpBuI0qraRtsrewdRnXBYZ4YC7H31+2pU6f7VosBGvZE5f59rfal?=
 =?us-ascii?Q?h0EjpyCSA+SNZzSyuMdnhr+o3VOpQAY7/4FSu2PF+OVrtbpKqcyB3kY6QCDj?=
 =?us-ascii?Q?tHeCEC41e+FN5ClbMznxA6FE4qbkHSohtzWwgbk3IdMKa+IXKUTSkrfDCmHL?=
 =?us-ascii?Q?o2cC9jhKMq3f6ohUOWOK+VfUN85RIoG1qIZBC/WsmFwcCawvAgJQv1ZGgVBU?=
 =?us-ascii?Q?mPP9yuOSOKq3KNo7xCI/sJ3v3MqwaYbEu5GlWhf9vTh9122pRxRwG40gjNQn?=
 =?us-ascii?Q?nqGOrrFA1brnbHxbYweCeXrIKSnmnD1yB9C1Olx2W6e+y55YPo+6PKRdIfHV?=
 =?us-ascii?Q?jpkl3tvshA/CQNZLWVm9JsVqpY3iXd7DoMge6lfSmBMOno4Q9974Zk9PMuMe?=
 =?us-ascii?Q?pZW9LwuDZT6Tej4zTchxMxtU34Ovm76nGOPmDTWwT/0/O0R/WyBhwfA8Itam?=
 =?us-ascii?Q?qroDmIXuNNW6H253N73h8K8pm72IzLNegp535yrosTrtfqcnvs6GkFxgEk/x?=
 =?us-ascii?Q?PApU8GXdMQ4ofQHmCWQqHB4xqSy8C2zSEd6bYaACMDR9wt7WLrpj6ZGmjXY1?=
 =?us-ascii?Q?CECTuJFdMo9wITCTqFgTiNNSSHSmR+NQ1U+bL6y7UhUXSDb4i+hpqgdL/RVm?=
 =?us-ascii?Q?OKmxuvIz6d8WeL/l/7Qw8/SHP4upTpPL7PSwh46eVO1/qziMkO5t37oHqW0W?=
 =?us-ascii?Q?EV2kYep2VHzikcUPqiPgClGJ1xUaZ3HUpb6lYaGqLq864m0SluX3Xt8H17F9?=
 =?us-ascii?Q?8L1seOZz709+ureaR+CckS4YCpWihJHDnVSjAMhgLFi8FDufy8U48fr4NdSj?=
 =?us-ascii?Q?ucVHn7ZRBNz9bszX0s2xmHcSqY7LOl3rfUhd+iiwk/MBvcLcIQ16c7DxCD6h?=
 =?us-ascii?Q?Yqxv15fKMBFNGIimkLq295hBoIEycHXrW9XJRdzY3UN8OkIp4hngcoWxdsCh?=
 =?us-ascii?Q?UkHFvzJc9Na2ExG8M9JKN9PI?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca45861b-3bac-41e9-eb5c-08d90422bc60
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 17:35:48.4363 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3p5fJICkNLZD0tPs/dI1U0hVYPh6dMWk4XVx54EDhNitkCOT08CGD4u+Ot8bxvU28IVDhIRzqcXc1yGwjDoQEzphgZMwLOyl77vlC0p0BVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5592
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_103554_042085_62DC3E4A 
X-CRM114-Status: GOOD (  23.07  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/20/21 02:09, Max Gurtovoy wrote:
> From: Noam Gottlieb <ngottlieb@nvidia.com>
>
> According to the NVM specification, the serial_number should be 20 bytes
> (bytes 23:04 of the Identify Controller data structure), and should
> contain only ASCII characters.
>
> In accordance, the serial_number size is changed to 20 bytes and before
> any attempt to store a new value in serial_number we check that the
> input is valid - i.e. contains only ASCII characters, is not empty and
> does not exceed 20 bytes.
>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
> ---
>  drivers/nvme/target/admin-cmd.c |  4 +---
>  drivers/nvme/target/configfs.c  | 36 ++++++++++++++++++++++++---------
>  drivers/nvme/target/core.c      |  4 +++-
>  drivers/nvme/target/discovery.c |  4 +---
>  drivers/nvme/target/nvmet.h     |  3 ++-
>  5 files changed, 33 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index d2a26ff3f7b3..91eb7562a88a 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -357,9 +357,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
>  	id->vid = 0;
>  	id->ssvid = 0;
>  
> -	memset(id->sn, ' ', sizeof(id->sn));
> -	bin2hex(id->sn, &ctrl->subsys->serial,
> -		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
> +	memcpy(id->sn, ctrl->subsys->serial, NVMET_SN_MAX_SIZE);
>  	memcpy_and_pad(id->mn, sizeof(id->mn), subsys->model_number,
>  		       strlen(subsys->model_number), ' ');
>  	memcpy_and_pad(id->fr, sizeof(id->fr),
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 65a0cf99f557..576540fdba73 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -1030,24 +1030,46 @@ static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
>  }
>  CONFIGFS_ATTR(nvmet_subsys_, attr_version);
>  
> +/* See Section 1.5 of NVMe 1.4 */
> +static bool nvmet_is_ascii(const char c)
> +{
> +	return c >= 0x20 && c <= 0x7e;
> +}
> +
>  static ssize_t nvmet_subsys_attr_serial_show(struct config_item *item,
>  					     char *page)
>  {
>  	struct nvmet_subsys *subsys = to_subsys(item);
>  
> -	return snprintf(page, PAGE_SIZE, "%llx\n", subsys->serial);
> +	return snprintf(page, PAGE_SIZE, "%s\n", subsys->serial);
>  }
>  
>  static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
>  					      const char *page, size_t count)
>  {
> -	u64 serial;
> +	struct nvmet_subsys *subsys;
> +	int pos, len;
> +
> +	subsys = to_subsys(item);
> +	len = strcspn(page, "\n");
>  

nit:- we can avoid two extra initialization lines with :-
 
        struct nvmet_subsys *subsys = to_subsys(item);
        size_t pos, len = strcspn(page, "\n");   

> -	if (sscanf(page, "%llx\n", &serial) != 1)
> +	if (len == 0 || len > NVMET_SN_MAX_SIZE) {

nit:- 's/len == 0/!len/' is pretty common in the code.

> +		pr_err("Serial Number can not be empty or exceed %d Bytes\n",
> +		       NVMET_SN_MAX_SIZE);
>  		return -EINVAL;
> +	}
> +
> +	for (pos = 0; pos < len; pos++) {
> +		if (!nvmet_is_ascii(page[pos])) {
> +			pr_err("Serial Number must contain only ASCII strings\n");
> +			return -EINVAL;
> +		}
> +	}
>  
>  	down_write(&nvmet_config_sem);
> -	to_subsys(item)->serial = serial;
> +	mutex_lock(&subsys->lock);
> +	memcpy_and_pad(subsys->serial, NVMET_SN_MAX_SIZE, page, len, ' ');
> +	mutex_unlock(&subsys->lock);
>  	up_write(&nvmet_config_sem);
>  
>  	return count;
> @@ -1128,12 +1150,6 @@ static ssize_t nvmet_subsys_attr_model_show(struct config_item *item,
>  	return ret;
>  }
>  
> -/* See Section 1.5 of NVMe 1.4 */
> -static bool nvmet_is_ascii(const char c)
> -{
> -	return c >= 0x20 && c <= 0x7e;
> -}
> -
>  static ssize_t nvmet_subsys_attr_model_store_locked(struct nvmet_subsys *subsys,
>  		const char *page, size_t count)
>  {
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index adbede9ab7f3..3efd48b0a34e 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1482,6 +1482,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>  		enum nvme_subsys_type type)
>  {
>  	struct nvmet_subsys *subsys;
> +	char serial[NVMET_SN_MAX_SIZE / 2];

This needs a comment why NVMET_SN_MAX_SIZE / 2.

>  
>  	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
>  	if (!subsys)
> @@ -1489,7 +1490,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>  
>  	subsys->ver = NVMET_DEFAULT_VS;
>  	/* generate a random serial number as our controllers are ephemeral: */
> -	get_random_bytes(&subsys->serial, sizeof(subsys->serial));
> +	get_random_bytes(&serial, sizeof(serial));
> +	bin2hex(subsys->serial, &serial, sizeof(serial));
>  
>  	switch (type) {
>  	case NVME_NQN_NVME:
> diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
> index 4845d12e374a..f39946615fd6 100644
> --- a/drivers/nvme/target/discovery.c
> +++ b/drivers/nvme/target/discovery.c
> @@ -262,9 +262,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
>  		goto out;
>  	}
>  
> -	memset(id->sn, ' ', sizeof(id->sn));
> -	bin2hex(id->sn, &ctrl->subsys->serial,
> -		min(sizeof(ctrl->subsys->serial), sizeof(id->sn) / 2));
> +	memcpy(id->sn, ctrl->subsys->serial, NVMET_SN_MAX_SIZE);
>  	memset(id->fr, ' ', sizeof(id->fr));
>  	memcpy_and_pad(id->mn, sizeof(id->mn), model, sizeof(model) - 1, ' ');
>  	memcpy_and_pad(id->fr, sizeof(id->fr),
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 5566ed403576..53999bd259ed 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -28,6 +28,7 @@
>  #define NVMET_NO_ERROR_LOC		((u16)-1)
>  #define NVMET_DEFAULT_CTRL_MODEL	"Linux"
>  #define NVMET_MN_MAX_SIZE		40
> +#define NVMET_SN_MAX_SIZE		20
>  
>  /*
>   * Supported optional AENs:
> @@ -229,7 +230,7 @@ struct nvmet_subsys {
>  	u16			max_qid;
>  
>  	u64			ver;
> -	u64			serial;
> +	char			serial[NVMET_SN_MAX_SIZE];
>  	char			*subsysnqn;
>  	bool			pi_support;
>  


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
