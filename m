Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DF7DC636CC
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Feb 2023 06:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HLUG7AhZBg6pwlaSmH9R+2Q+Cs19P/V/5U0YB2fUIkI=; b=ZRu0TpfNoob8xkyiaxGtwJeiDK
	IqT8HR7GYvvlaFq8GBB9IiQrO7PAwLvXpx+AIC+VB1BdJY/+JwWAz25QnC0t6TRuuPlk+7BstVhqz
	M5dUPP/ega1uFuzuVCcJ7xOLwD3G9f+wkmJdrf2ONWoNQWfD8QXMjs1mYFn1eNZxjDQ810aYJ2PYZ
	S+y17IFxqnPpp0GHgzOb/ybkZtCYaoBKLk9IRYU5C310SjuZII3DpNT/Y+Ku7iOqKWFTGhOaTriA2
	YgTSFMEyMhVjW/RXjSvdWm7ENVV2wSL3LvZ8kluWMWBHGKQsvhGQa8Oxci/5+9lKG/O3zmJBdb59z
	7QTX0ckA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRSWj-00DMwS-Ri; Mon, 13 Feb 2023 06:41:25 +0000
Received: from mail-eastus2azlp170110002.outbound.protection.outlook.com ([2a01:111:f403:c110::2] helo=BN6PR00CU002-vft-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pRSWg-00DMvZ-CA
	for linux-nvme@lists.infradead.org; Mon, 13 Feb 2023 06:41:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2pKNPdcSdW21lxGw7rfsHhQqlEKQ2EgXpLMja/DCM48oNM1iJz9VMtm5crwYiL2sQAphhUsK+sttjVrY/l0o2L0rgOtCaKRDcobU8kLNmQkVKnFjRXChVI1XmB80sfNviA9V3TOxXi2WOX02XOjQZJP5AUsGTJriX7oX5+/QJ05JxR0XWrPJCsuUUz8IBVL7NqVqGM3WgWgt+I5d1P0pmOnevNwBU57SL7Us+vFGjid0gsCYcVD8PMJ4JjkfTgC6lEb2tRZe4dqt5EAtiLdj2vMykYX/MmtgViT5jhxpeo2Ew3h4K44s+aG/NxS0MPUxf14mrPf4oTXGBXwIGbcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLUG7AhZBg6pwlaSmH9R+2Q+Cs19P/V/5U0YB2fUIkI=;
 b=Bky9O6OlJTJjKUjSfxvNBusnbp9LA/uRboZH7nJ6EH6VUPPVjgAvpnq2ddDIT7jOvGnMu+TuLEMMszToSF0bGBbT+n8YPQN+eNSrUOeolQzKQEcp+hhjzuRj75C035VPlH29s6cRA8u0yfCcdlz4CAHeyPvW/pqL9rKhd0o39/QxZBVI3qBxaUNhFP/ARYpwEa49E6N8NHp2HEnOaNqathhYlln4pWLaN1gaDa4iqVNx0LDU124gDCw1+HhwAAQvN3f0dyWQtbffrnkEZwuMB5d08n0UUoyWNVyNQhfRnxPQxTJ3VmJGRLmQyAk8nhQF4o+vwxbVtM31std4a1TLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLUG7AhZBg6pwlaSmH9R+2Q+Cs19P/V/5U0YB2fUIkI=;
 b=FZDW5ammsyPkRow/5+iLZH3vl3tf3XFgVYA4jSGwctT+F3n4kPU7SH2L0+lCUDUET8UBVD2w0g/keQb/DJZLx/f21ODeiMSEumwCbtdOq5v1T6gTdzGGWtSqfbe1FGwc5QkQpugHjv+rt5Fn93zGKgmlSLPtxH/wnco63LVgVWY=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH8PR21MB3835.namprd21.prod.outlook.com (2603:10b6:510:216::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.6; Mon, 13 Feb
 2023 06:41:12 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf%8]) with mapi id 15.20.6111.007; Mon, 13 Feb 2023
 06:41:12 +0000
From: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	"asahi@lists.linux.dev" <asahi@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: RE: max_hw_sectors error caused by recent NVMe driver commit
Thread-Topic: max_hw_sectors error caused by recent NVMe driver commit
Thread-Index: Adk91saIeniTqD2RReK/0l1vmobdkgBmZimAAAFBSJA=
Date: Mon, 13 Feb 2023 06:41:12 +0000
Message-ID:  <BYAPR21MB1688F70E49AAD658D86C439DD7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
References:  <BYAPR21MB1688B4BBFCCCD01C016A62D4D7DF9@BYAPR21MB1688.namprd21.prod.outlook.com>
 <20230213055945.GA13648@lst.de>
In-Reply-To: <20230213055945.GA13648@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels:  MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=082babc4-ac9e-42b4-a365-58fc71d47688;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-13T06:35:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH8PR21MB3835:EE_
x-ms-office365-filtering-correlation-id: cdcc0202-c8a0-48f0-ab5d-08db0d8d4c3b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  kAD6wVo2FoNsk922Z4iy5+mjWBR5NjspAOOdNrDI100L69CDk6f84K7Lp3CqfWtOvkwxryyVoOKm2uycrSDHiIyMWi2DJCXUNe2iPJQR9S2rd3c8dotuevBylEW0Y7LR+u3Ve2GToMvS50BJc8JFN1ziOIA4vsT294+sHlH2M1sRwwW7V9x/iOHCiGebmLpVrXdvjWh16/SsBawEWIHSJ/DcEUlaW3c0Q2rbArqfJCvemzcButn4D4OJyuMvklDGjUYywWqm+hg3bBDji+ksOD/SVzV+1qUuAF6Syv0X2sYlZJCBG/aSQ4HtwJpkWBtbCQQCDNBEZVONZlH5CuGRRj847hFfWsUxUJQTu2qLIlchzZgYDaDfiuHWYgwVGJOtBwQQ1P8iLoeAtPC0zGqzc3BS1Vq+evRzZfE2DCaqKkMk8XWxkumc5mohGQTYmB4tgbcJ6q9hATube8M0ERC6k1lLAwYRmRLAdVnVJW0xR3maoj4/W1LjYPFZ5+EAtrnCk5S1ri4KL5dZOEl9tuKu8gv1ysqtiYsBxKNwtpZqH00ySMa8jeoegAciYhLtEik2DB1zyPHqqe0ZJkGR0/AuYweMvfOtIAQ0RBcpC/MOImP9xEvLwHAHe7PXazy1/qreU3FYg4BNklDLgzLkCj47k87CCdAdPp1dI5Rlasm2pM95wUq90nM+Gw49FEECZqu4bktYKYjEZurFlADYiA0LmxGl29HErFMQ0vgsvZoc7IZ9DF44NZwUB/Ed6/ZZg+jT
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199018)(38070700005)(6506007)(55016003)(9686003)(186003)(86362001)(4326008)(6916009)(66946007)(64756008)(66446008)(66556008)(66476007)(8676002)(8936002)(33656002)(5660300002)(41300700001)(76116006)(52536014)(71200400001)(7696005)(54906003)(10290500003)(2906002)(82950400001)(82960400001)(8990500004)(478600001)(38100700002)(122000001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?us-ascii?Q?KSudzmJlTWgKZcOXLyxWpSYKN9xEF7owzgHIpcq8jepFdozy6IXh2bqW1vDj?=
 =?us-ascii?Q?iIhdh36mKF7kjbLd3yUvK8TvrH01AVr5UEUqo6P1LiERAuNHc//EYDlI09zh?=
 =?us-ascii?Q?8epzf4vl2ApnFiE6COu5dg5mMMriH85hGFuWIdw5bAzKHE7mySlnbuG6o8+O?=
 =?us-ascii?Q?CG32RGDq1+bfyEzEirzDZGmUGIN1UtvNzSObKFY87C/jSyryvezTE32g3uIy?=
 =?us-ascii?Q?2BogY02KZVSwPpNCIfrsLZQpQpbAHte4sS+YhfmA8KHixQz/YiHpokK297f+?=
 =?us-ascii?Q?3lsAMPULrZxArrh/vbBYjRcgyhYIQrH2wEjcLeIkbPJI5Ap2r0Ig1kT9qXOI?=
 =?us-ascii?Q?fCq2BowdZATLYumPpepYQqHrhb/hHbX1CDyrF4CYoAA6SNcxqViliWuM2UPw?=
 =?us-ascii?Q?j4eplxlVJ4LhiTC2VdBbt5cvlJT9q9j+iJvYnZRQLB6dDcOkJ3qp3tPKTNZz?=
 =?us-ascii?Q?XJhMxC+7wh6AHI0vLAB23xarHxRql3IQLExj58F2z26+FjD7yJvn6f7nNUTA?=
 =?us-ascii?Q?PemVeH0MYLRjrW5wlHX1U0oc6NiEJeB6dbvJQRA0+fyutDlh3soCgMjqfAJq?=
 =?us-ascii?Q?12yCCIsB4t/j4JKChVAPNFN4BGUs/MpQ7/kvSsT06AI0MHsehbJ/LS6yI1za?=
 =?us-ascii?Q?uCsHYHJqgHV1ANFNEVSWTp1Ff3KQmfwxKjBLU6MBVz8Masj3yyTalrO77pNe?=
 =?us-ascii?Q?bHcKDOZ5wSfJ/2lwVPmnAsYAD+0nPBpDUD49d+rsGXd11Rdg9R33CoGZmTio?=
 =?us-ascii?Q?yjWsEG21wmsYowXGO82HDxVECoEtRlePmOV+Ph/4mvEMjf+gjXU5jGuqyNza?=
 =?us-ascii?Q?uR0TTYYzynLbRx5374TMvGjqx30XgeOQCj7EvPktu4fbiUmGolqtDNGyfjC5?=
 =?us-ascii?Q?wzVxHJgK60aTDDrEtyuZYckhGeXrW7Pz+VhyI2VmcgUCSKMg1dh5qDo1juW8?=
 =?us-ascii?Q?oEOIy9bSk8bBS3GN5Lgg44ssJSM88H6rsKKkY/9k/wYWRiGtLoygDcS80I7/?=
 =?us-ascii?Q?JF8yVyP4O6y5geUhcczGEmNhgBJc1ApfjkiGqNpo5gU3viC1KpKEYvBk3Ift?=
 =?us-ascii?Q?YXn4axJz167oYanMCN/As0zi4lMlpRDTw4uC3uDxz7gb2v5vyWw27hYIriIM?=
 =?us-ascii?Q?Wi7DnSFi+PdAyqNYNGp1MBO8pNdgsvPdU1w2PG7fbC4ZeWM8b1RoUluClvI0?=
 =?us-ascii?Q?odZhkMzI0m2zIpWJfIx3L2k9eeyYOG39IXasWWr3jXpwYjILP5H5TIjJUk7c?=
 =?us-ascii?Q?aAsvGygwmeaJXiwgBKbvE0Lob/CGkyLwJK9dWRwtg7Y1md1Ld8ctuTJL3tJi?=
 =?us-ascii?Q?+hGuBZQ4reWrUDN4z2szz7BU1m5gBWoXZC0mK4uF/56GGYyCpiq21cA2Cgh1?=
 =?us-ascii?Q?+NNycXAivBWdct8jSJl3tFWbV2k/MR080OiitnDdbPO2VEtnaSYcv+6WkW8J?=
 =?us-ascii?Q?CyCmeu8dSHgWFlpwZEso6ODleh0MBKmTOJJmT2f2omA/UPgScvWpu275wOyO?=
 =?us-ascii?Q?4G05pRDoqyjj5zpu57M7Zwxr3J5E5kxkGhpy35MCYU3RKzmvhmPA6tq3dZE4?=
 =?us-ascii?Q?Q61diHUnEkZB+Oh5rQuC/St/u6Q0vEUPKJYxFkzS6+pVWob6vJDxGdoglZN3?=
 =?us-ascii?Q?7O08vqrZm0SCPBysfleOc9AJdP0BT/+JlR1qmYb5vgUtHbG1W+HU9x73GyW5?=
 =?us-ascii?Q?o0PIUA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdcc0202-c8a0-48f0-ab5d-08db0d8d4c3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2023 06:41:12.2960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +W/0mvESyEnZOT0/+0H4xIvNt1tL5VkGXMLam5WraHNRidJ8LHocSdcVY0E9Aszq/+xbTe4f0MZvNebPMqRHEKah7Qa2zhrS27sHxtJR+BU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR21MB3835
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230212_224122_630360_192F8CAC 
X-CRM114-Status: GOOD (  16.10  )
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

From: Christoph Hellwig <hch@lst.de> Sent: Sunday, February 12, 2023 10:00 =
PM
>=20
> Hi Michael,
>=20
> does this fix the problem for you?

Yes, basic smoke test works.  The underlying NVMe device
capabilities now show through instead of being replaced by
swiotlb values.  I did not do extensive functional testing.

See one code comment below.

Michael

>=20
> commit 0467e96bafd2e84b67ba5c122bbbbac5e3f267e9
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Mon Feb 13 06:58:33 2023 +0100
>=20
>     nvme dma_mask
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c734934c407ccf..cb068f92bd597e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2509,18 +2509,12 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  {
>  	int result =3D -ENOMEM;
>  	struct pci_dev *pdev =3D to_pci_dev(dev->dev);
> -	int dma_address_bits =3D 64;
>=20
>  	if (pci_enable_device_mem(pdev))
>  		return result;
>=20
>  	pci_set_master(pdev);
>=20
> -	if (dev->ctrl.quirks & NVME_QUIRK_DMA_ADDRESS_BITS_48)
> -		dma_address_bits =3D 48;
> -	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(dma_address_bits))=
)
> -		goto disable;
> -
>  	if (readl(dev->bar + NVME_REG_CSTS) =3D=3D -1) {
>  		result =3D -ENODEV;
>  		goto disable;
> @@ -2998,7 +2992,11 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct
> pci_dev *pdev,
>  			     quirks);
>  	if (ret)
>  		goto out_put_device;
> -
> +
> +	if (dev->ctrl.quirks & NVME_QUIRK_DMA_ADDRESS_BITS_48)
> +		dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(48));
> +	else
> +		dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64));

Any reason to use dev->dev instead of &pdev->dev?  They should be
the same, but with everything else in this function using &pdev->dev,
the lack of consistency suggests there might be a reason.

>  	dma_set_min_align_mask(&pdev->dev, NVME_CTRL_PAGE_SIZE - 1);
>  	dma_set_max_seg_size(&pdev->dev, 0xffffffff);
>=20

