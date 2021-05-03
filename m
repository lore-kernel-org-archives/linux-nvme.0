Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6F1C43460
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 23:19:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B065861208
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 23:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B065861208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=PsWYIaDyEYP2TqV54lDu1a5k8MOp6Fhl3D+QcVXIT54=; b=hKvj01opiFLWGqHZYS5WoXQTP
	Q9LFNdnZZs/qaXjJi4JW/yeu0EcwuvUPynketcbrT820YYJ+AF3CRYnOS2wiRh5E5I9Jm7VJ00wwp
	6XMZ9i8DZty3EMtiqvlDFB8frt4J0QZhaftCrhjRYdVvxFimWFXOStGV4UJNRfJoeqzeGkviYuPIM
	Y53cwy6yO6NiJhyYUxCV5QB6njoErdPo7qnNOeguot+R1JPADr4FX2Yt2HqSmo6dVYA2SnAnlepy0
	Pb5HlIHwduRtV9lsUehfILIEJH30/p3BpGg9HnHr+wyukUks1qyomQSbGcvQhRg+LfPupmFgRG3g/
	D7+NAEMgg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldhpx-00F0zj-MS; Mon, 03 May 2021 23:18:49 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldhpv-00F0zI-6A
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 23:18:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:To:
 From:Sender:Reply-To:Cc:Content-ID:Content-Description:In-Reply-To;
 bh=us5veKs35j8rhlk/gF2BVAI/Uf6iawy0itnA6qxVm4w=; b=1YSJn4x2InSto8lKoaYgPEpO8/
 qiuKN8BMrhq60iOBRlhlJjkxypMvAVXexlfY1y2JezpkXGMBvNPxiraJCo+vYxl+QcdG0ocIYFci4
 uWQyt/dFYJaDQlU54tGxqzPtqovgn4XEGt1p/FXXw09AiDFvFYyfpy5yKFY+ycgtA3PpWSoRbdqf4
 33pkD11xps0GAg7+qnOGhuHT+BB7aJlaYkw9rQ1feBnzSKz0QVKn6xdU2JfMVgKyrqPYjOoA8/ABG
 afHGL6Jjb86XOMcoucxRTNSGY+aOFTwF96FzoowUcgDwk/rGW1ak4r+wD5GVKrGHe5cWYHFvahf2a
 H6Cak9QQ==;
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldhpo-003XrF-4n
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 23:18:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620083920; x=1651619920;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=z/dxzh4QufMAgyOfh0N4ekXJO1ZMMlALJn9CcUlvNzM=;
 b=BsQ1mfHiYfWMJ8IC4DYZyIiSs8aHgaMYz3inkoEJdQb8sagzVDkxeh/h
 Q6rGFRxR0SRuDs/EXViCR2fTk23oP/dg+pXXI+Y/jmGwdZPAdsLaFispY
 mriWX3WpMbgP6vQ8A/VSNecUrBJvNfFBYRt6+CJI1d3N40v3MCgeP4vy3
 Zacxq/a0SJFZQAinCuFJHd0V3iwPIVuO1YhimRx9Ugb/9TmbskI6a1E0P
 Tjdhpy2TvYNfEH/YZXBpEI9KKvmf3pxt4uBTPq7XueDsoxW4+sg9k2R9+
 FtDJ24J3qazDcO83JxkNDcYdt0UwPmDM+IfYZpG1uMEyI0Yltfmf0MNN+ g==;
IronPort-SDR: e2aWOZhNBcuOBDHASiAPpTphROzCapTcnMmH6uCkfewB1VFcQFVTbKHox1gD450AMxitz+NOIz
 qLnFS53wNvGTFVRThXOzoX5lhoZjiIzkUkqoDGVlBaHSRh10Pjz8N1M4O8AjpjETA1kgrcIU2v
 vEAbVEvcmX2ee12r8WihJLup5USthOqfpJPmXW37UXHyaVqmJ2xDAFOzZ8SNGKBjL2kvq58TZM
 qVA0woaXDyoXB0JJ6GmtBe/Dr3gSlJIgVnSwOfOJrs2pkUym215OwRt1F/UuyPEDzxrKTu37Vr
 nA4=
X-IronPort-AV: E=Sophos;i="5.82,271,1613404800"; d="scan'208";a="167573996"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO
 NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
 by ob1.hgst.iphmx.com with ESMTP; 04 May 2021 07:18:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drvw8NiIP7rVqbJqXqzsjcNEmA031ulmeUXpHwJz/eR6/1HZFNPvny5YBf0CrGzwnau3BDy+izTL+Kji+25PyzhNk1AMZyo1w3NFTBN1rbIPze71VcndcJ989nC/Twzu+lOe/VEHXnVMYN7HTeLENdZUcdf3XuWcKnKz6O1xzBZxIqr8PvZjztRrHGh2oTNxLVjDyjrZDpO2AXm0Bo0zj7M2aJwddeOp3eV4LK0SAooZHQe1AIukjY0KZRiZGfTk9VmEAzPRFJa1wM+K6WSWEN8Sx94mEhT4Mmfs+tny6Te8qt7779U6/R7Ztp6BpMF9x2YZy726RqRW+6tFT6vMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us5veKs35j8rhlk/gF2BVAI/Uf6iawy0itnA6qxVm4w=;
 b=ZldHwGtGflm7djwboedqGLbwlN25aPjWI+Tfw45eOQ5E71dsMaC/aOljZfrjMgj0NCjoH1jvM61GWYGJHYz+wPDcc4geCvBV/hSjSmbJxiGbUZW3G08QFiAzSLnQNHIRtO4V7agfml79APGjuyoqio7Qk79yS+g4HsQV74M5j/MGG8bHp42r21GuIcTBTFinG/m1O223FMwl735Rzy4aUlDhg/G2RVfYR3b7atEu4kObvWGWgFutolye2GzAKhbv9EKges1Xz9W72OVKhPRmEuzt8ADCJqR9g8ISMxilnVp9cTwafNUlqgHUl46U7SrKpjnaVwrzeynRlEQX1GMWyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us5veKs35j8rhlk/gF2BVAI/Uf6iawy0itnA6qxVm4w=;
 b=qfQxQ9Lp2CfdyZdSUHGIzArnT19Cc1C8XsDvi5i4oxKCO2fknZAwk7ZoEAhbPsyDNG9S4GA3+NAKk1kMtdrk1r+F4DUQT0t9DrFvMesp+I8VB6d1+GESQsRI1Px+DF4Hu5xNpN+pc9fifn0Kj248Vri6CWZR7tEwEsbBb0dI5Jc=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5829.namprd04.prod.outlook.com (2603:10b6:a03:10c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.43; Mon, 3 May
 2021 23:18:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4065.037; Mon, 3 May 2021
 23:18:31 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "ran.anner@dell.com" <Ran.Anner@dell.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: allow setting ctrl to ready without iosqes/iocqes
 set
Thread-Topic: [PATCH] nvmet: allow setting ctrl to ready without iosqes/iocqes
 set
Thread-Index: AQHXQGokYoUYNABlD0G/UJmB1XIb+w==
Date: Mon, 3 May 2021 23:18:31 +0000
Message-ID: <BYAPR04MB4965F72A2E7618FA8FDC6519865B9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210502153106.18970-1-ran.anner@dell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dell.com; dkim=none (message not signed)
 header.d=none;dell.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2732873e-96a5-4fe9-670b-08d90e89c477
x-ms-traffictypediagnostic: BYAPR04MB5829:
x-microsoft-antispam-prvs: <BYAPR04MB58293187230EA8B5C3AE6574865B9@BYAPR04MB5829.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TPhjZtcPnJKu4KDGtxjmtcNSivNZG1ofYfIvNUzY9YoTE2+T3G+u+KO7YQxbI5vb7b0NYl5zXsIyMyS8EeNTnmbje0sl9tHVZ33qdgfXQJrtav1R9GYG8Dg4eAn6yE8/YNyUURhXTM7MGhl/5ulDC//bBVHwhKjWP91kyW16JgrPDXl0Dh4JAp3tL40C5E5puh5hLQFDYn2y79s+Bp77euMzDxQjtVnPYGBSF3uq3MUIqeX+gKGvwhV1puy9mRFt+b4EOhRTOtHp2d+XxkAbpKGuRdT64V9lGHmua36iaeek/xxtfF6KIgiHSaH9fPIANl+Cqx9FD6dxdHz8c+ubC/KsVHsSc/j2/axq/TYdlfDJ//qignAppivG2vi4iR/1jsO/xVdyMw9UmYD/yzQPIw5Wq+q5tv3Oh/aNMAu7dWBqihKHU3u0szkwIUd3A1qpnviOM5a/Tlix9MNHvylBkn9lFeCY0ln3jtbgDFyAvNa+CBujMscOOuE3XVV5opd3ShzvoPgehxanwuPgSm7mwu4krKvMr813If6si/rmRiZlYQT8fvY/uR5MDBnOaZoxHtGAKN17SIKnBQgpD/01qD0UHUYZH8ckZqO+5aXyCAY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(55016002)(66476007)(64756008)(66446008)(66556008)(5660300002)(8676002)(26005)(66946007)(9686003)(38100700002)(478600001)(76116006)(2906002)(52536014)(122000001)(186003)(110136005)(316002)(8936002)(53546011)(6506007)(7696005)(71200400001)(33656002)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?A94OHlHrQxcVnuGk5WczJxQGBZdjzrdu0C9plSnbdTl1Q9iR2WVYOuZRNs8f?=
 =?us-ascii?Q?9zHGmlaeAcKXqAgLqXAT/3VKRxj4iD13SMvOJ8Ayh3Hm8Q5vMqeYBldx0kO9?=
 =?us-ascii?Q?yKh3qRmyH0Dp03iwA6Tn62cymjOpvSGKz4TrEGR2sFNra8My2FdY8elWydvu?=
 =?us-ascii?Q?S02djpcUHc7lLDTgOkwow7+FRryf5vB9C0no9WTKwP3VRy31B/lvE3lxwxPR?=
 =?us-ascii?Q?/StvcH7obeOkYLqcsjkNAcfeFFCOZxeUwfFIrLTf1Tf31HvNgAxIB+iFnJN5?=
 =?us-ascii?Q?rdc4Vst9AlbnPIvUJg4sKMmUk4QHN7KOa2akzdE7o1Ga72dNvZkBw4T7XgOZ?=
 =?us-ascii?Q?MOJIw85ZmHTxH4HOF034AoAyo2a0QUzKinvUmxNQ0KhbRVr+xEIUgfZaAnmz?=
 =?us-ascii?Q?kra+3upBo7hXdUxFgcEZK3PnEL096klm5KhKr74ax1804k5aarExeAjyUexD?=
 =?us-ascii?Q?U7HDYoGgHCdlPJL4vI+YlwsW78HXy3IU+eTKg/7yU/LxXjhc6wAhklL3J128?=
 =?us-ascii?Q?XVK4lG72gCfAvjgDE+G1gyWvoR+GQcL1eEFfZP5dhCUxemfc3ycYhdlAEzTU?=
 =?us-ascii?Q?pzRKJZUIYmibdh5THmJqeKXSHhz54ARy44v3CSXNShsL6y9hs12mXD4UVF88?=
 =?us-ascii?Q?P8qb5fNRD74DN7OJlhHTSqpRcNDxpY7ItsGUp3LHh/awwv1qP8zwpwvCBYuU?=
 =?us-ascii?Q?LnGc7LrE6ef/vSco0rHVlR6S+BYyuG5pmjH5mNlp6qk708EADr52VL0WPiaF?=
 =?us-ascii?Q?+OqCoeDIrheBtfB7zWMTAuaIGnaY4Td56DUZ9Rw6X0tYHIvUH9pw41L12/xS?=
 =?us-ascii?Q?rodnMRqUuQ4hhf11b8n2UUUx6NtlANrmp96SsCQi3HSQ4ZExu/6L0aIk8Gl7?=
 =?us-ascii?Q?jVdYue9d7efS9/xIf6NUv0lP21vuMe7eK5ZPiLDKGYNM8rYJOXz5rIvtMBQm?=
 =?us-ascii?Q?cAaG/y1dh/sDXUNj8d1u0T3m2RNW1g+nhTVtgJk9sm+3mKfXpjp8RGAgAtfj?=
 =?us-ascii?Q?V1m4cAVMH2rSq+l3gVxiD4ceYp44bBbTP4El2bSgp4Yxsj4L3Jd1qUW9KYHK?=
 =?us-ascii?Q?1yqk49RgNhOAv8ypv+bb8tAKpJwib45ghK0nI+xPGLoMwxK2uFpCI/lTi9VW?=
 =?us-ascii?Q?GCPKuu1QZuYlxJhf/yUS6F+FgrwFXMFVyU9gU+UZcVEVM72579Oul8oxVJq4?=
 =?us-ascii?Q?nRejJhvDNAbcy+RqfvFAB8QSFp34lIPoZVeLBH8mog02C5rrJ5lO9cwDJ4bA?=
 =?us-ascii?Q?oZbBLTfIeJyiHQ54k67RLDG9qbRL9z5reGSxutWwPSojsTDdxL6G4eUmBgTk?=
 =?us-ascii?Q?6YCC1u2m5yDmeAXxayMTiuVT?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2732873e-96a5-4fe9-670b-08d90e89c477
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 23:18:31.8154 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+dgRMVSntXlqgRRQVb3aBly3JDunoII4k3Cwu0czvKB9/ID/pjqoWmA2ANX6RRduH/Tf6JlUvd7LZGTZ8iHN4RJrII1vOjwjKdMQ+peVS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5829
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_161840_356050_2003CA6A 
X-CRM114-Status: GOOD (  13.05  )
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

On 5/3/21 15:17, ran.anner@dell.com wrote:
>  
> +static inline bool nvmet_cc_en(u32 cc)
> +{
> +	return (cc >> NVME_CC_EN_SHIFT) & 0x1;
> +}
> +
> +static inline u8 nvmet_cc_css(u32 cc)
> +{
> +	return (cc >> NVME_CC_CSS_SHIFT) & 0x7;
> +}
> +
> +static inline u8 nvmet_cc_mps(u32 cc)
> +{
> +	return (cc >> NVME_CC_MPS_SHIFT) & 0xf;
> +}
> +
> +static inline u8 nvmet_cc_ams(u32 cc)
> +{
> +	return (cc >> NVME_CC_AMS_SHIFT) & 0x7;
> +}
> +
> +static inline u8 nvmet_cc_shn(u32 cc)
> +{
> +	return (cc >> NVME_CC_SHN_SHIFT) & 0x3;
> +}
> +
> +static inline u8 nvmet_cc_iosqes(u32 cc)
> +{
> +	return (cc >> NVME_CC_IOSQES_SHIFT) & 0xf;
> +}
> +
> +static inline u8 nvmet_cc_iocqes(u32 cc)
> +{
> +	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
> +}

Why are we bloating header file ?

If I remember the code correctly some of these functions are
only used in the target/core.c so there is no point in moving
those unless we have callers in the second file.

CC all the maintainers for NVMeOF target to get the better
response.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
