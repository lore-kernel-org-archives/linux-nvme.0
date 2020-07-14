Return-Path: <SRS0=z7iv=AZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52020C433E6
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 00:02:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21D1321883
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jul 2020 00:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dGRd92Ul";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N4b+CB0a";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dkwyC1Sn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21D1321883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=QbRGm3NF0NgvLgrjkX1MQJZz1RostX6axAqEjfy104E=; b=dGRd92Ulj2+s1+uK1JsZw5be+
	nHYiD7RwgcokcBvGPuAF/+umiX062o+21/uJPt3enPTdiaj/oquWKWV31ymbreRdAWlCZqd9rPNSG
	JKjje/3Ep8UXjORMyO+KQS4l5x8rHiZy2Tpybe23IdzmG7WYh7Zr6bUfTlHa8grUEvwScJiUJMp8/
	krVNXtXEH4Rdw04wAcVCRjCo38D9jcqisvd0KmwTg4G9LyfwudRgsUH4IalNqhc7/4iUUsDfdCBju
	zu9Ed+QH3SCby4UH4t8iXHGnHMaPYDIsSswbZmmVQ63RjmVCCg/CU17UvtbmXTq38zIm/YyxMySkV
	Eo30G0zUw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jv8Ok-00015q-69; Tue, 14 Jul 2020 00:02:14 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jv8Oh-00014k-Ee
 for linux-nvme@lists.infradead.org; Tue, 14 Jul 2020 00:02:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594684957; x=1626220957;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=8bcY88D6MWgWL9M62ORk2Cu5MokTzrzOJ++Dbld9pnI=;
 b=N4b+CB0atIHw40hsSjZN41FT02FCqs3v/r0juRXnplG7B36YnlXTE2JN
 UNKriTbQwKdYAJ1vK+o9mdA5frHccXY5JgizuCyS08kQGew/dJzwbO0A6
 Eh1YdkN/xxsUngfOOTmjhNlwmT/VfiiL+q3ax1c761f8tb41ACg63vrzh
 IHXEBXF2+sbI3iPC97QNFQ8Oy62Dr68krEW0Y2v7wR83pwq0hprGVReft
 wN96HTn6bdGKLiYzr8y2CTJxh9VRhtIuOdXke58YYvAFOQUUDwjiJeWbj
 1WzkyHqrrKgbl2M2euux7FiiECRUve75E9ybJTTc3+bWSBhrRxqwHI8YR g==;
IronPort-SDR: AH9mYX+pRS5Sldwy5oY7H84vJHXVF2s0AeynDzvDrWYoA8FtTV8Z8n3GRiJma0RVVkqkUQsUcA
 Zvx4/hn51YZ4VUMIMarzk0NZS7KEUKFhpo3u9YlHRw0/zpkw0i6sN2XJEkiwk0r1XUrd/ztbHm
 cPLusdW0em4Y3JLSOFDSRU1g0W5VsSsvQWiZW3GcdvZPQoypujjaqgDia3KQw9dmRCpCq1QdT7
 lQ3bDHfEsaLoDrsId02uvcIK/ioT5vnkqsm0mNHdWrwneMBEV0dGacIFOWIIvvJc2hA2QsKDEr
 MOY=
X-IronPort-AV: E=Sophos;i="5.75,349,1589212800"; d="scan'208";a="245390535"
Received: from mail-sn1nam04lp2056.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.56])
 by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 08:02:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJpvdOHCqXZCK7tBfAO/FKIEmmv/i0dox+ye5YTZ+lyQazZ4ADAnj5JW8KGn+De21rIyQHfKClC/7AT1VIgfJ764TI8tbTHqFqVKOPirOapUHHpHeVRw7BM44tPCZfLNTgbL3WQWOJvP/qtt4+MmnJsCJItLLBx798hnCsJMz8fW/GAhHQjxwqnF9uisCEmrMY+WXOAtTUEZqzfbNhZgabpLQOWSOpO1F2ARt/oYUjivCP5+MALPRg0qwVTODC6NyGcCnkJO9UQYp6FuF8iXEG4oR7T5xlxGvoFryZbpjo8IN2vPFHcuR8bHYLZMNe/61SgAk/fEOu2eSs9aFKuOtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxJgbnVl3l/WVJa38mJdc6pzGxvUtMIkZ0cYJOZihzI=;
 b=aUyRVR6rGA1m1fgl4bvWIqKA2WRKUJpDkJvLYL1FJf/qQIsY/6JyrsQGUNvrqwJCeqHNRbIJd8k1aOFYnXlpadNaH08lmUmYowzZ0h60ReZD+7uupYwx9qk/13JcUZBdbER/4GxZxJUoOR/Jm+rIERdPUH6yrPAwCG+wb4eF7BwfVbCDUDn7aIUr0zuey2QYxgfxwbvgiFKtAcVNnEPJspiY4yAqpZYuFgiLpxX9ST7hfSAoG6kfQnihgUtZuWLM2TgRcNJIcSRZzfDfZCzs4vPgRH/be1aNDw323VtSNdewFdHetwvpL8Fnau01R1xNZFyQatcN2pqa1YkaS/kV0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxJgbnVl3l/WVJa38mJdc6pzGxvUtMIkZ0cYJOZihzI=;
 b=dkwyC1SnQyWgmfT/BY+b6h+G4tYQIZtbhfwUCSOBzz0j9+7u/488D+JRVVxR/ovSLvZLAHpE2IenQh+MRFlklRvd4PN7JFqKjo8YRTj1+txclBsS83p3m0ia7D8JeepFpHSd4p0/7RfPWSCEZrdoURJm8h180ouJEZSmVJ6IYBo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6549.namprd04.prod.outlook.com (2603:10b6:a03:1d2::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Tue, 14 Jul
 2020 00:02:07 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 00:02:07 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 1/2] nvme-core: replace ctrl page size with a macro
Thread-Topic: [PATCH V2 1/2] nvme-core: replace ctrl page size with a macro
Thread-Index: AQHWVkpUVzGd6sb7QUGtvMo4HjxQUA==
Date: Tue, 14 Jul 2020 00:02:07 +0000
Message-ID: <BYAPR04MB49658A5EAA53980A2A26C8FF86610@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200709234025.10673-1-chaitanya.kulkarni@wdc.com>
 <20200709234025.10673-2-chaitanya.kulkarni@wdc.com>
 <20200713074210.GB14676@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: abf06c95-acad-49e0-afef-08d827892641
x-ms-traffictypediagnostic: BY5PR04MB6549:
x-microsoft-antispam-prvs: <BY5PR04MB6549B829F33320F73BF6A80F86610@BY5PR04MB6549.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FEQhwCgxoFQor8EWamajz27O78u4vEtTAKkv9/X+YRRTO0IfEa7PHQNiGyUHCmn0CA2sBd1v9MDgAVNyUR3EcT46rou+ZeXVdeGI9TZRbbBaJPPFD2sA/NsinrowjghT+Ly+GozMR8jGKdhvZUp+X0E3duD/h/dc4ZXCQkyYOSmOs9HkX6Co6LZ2p8LyGx4YOtRy/4EtklumI9MBPBINsSoHuVfeO3ikxpLFIF6t+W983rvwY8AdSid3d7jang5sur5anpumPVIqTcHibNF3xdLeesSqrCxrjbgfL+TNK905kD2iq5rfluAZEsgy8YQ1ztWSDp2UrF54sFCEBhvgjA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(66476007)(8936002)(478600001)(9686003)(4326008)(55016002)(86362001)(8676002)(54906003)(66446008)(26005)(6506007)(83380400001)(66946007)(2906002)(33656002)(52536014)(53546011)(5660300002)(7696005)(316002)(186003)(71200400001)(76116006)(66556008)(64756008)(6916009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: avTiAB4VNdxm1qw59ggBIz385JQA/A5pDIUY39yGgMnsmy80D4xxM7C75fIJrCH3Cp7HwBaCE2y0NEAOMG4yHZ/qdyXFQt6I9P1+ommXnVn50WHOW0Qr9i1YvHqDYviOwpcU8EIfmDWl7h3lUkPE0kQZG6/N/8WYnfooq0CFv4+8xRNTMoQ8zbYlSyRwXM7iJyxW0n8CFUpyyydvnR17GVULlrEwY49GrNQi2mdVR+c73RoWlRqJqpucJjRol6v3FQHdcAViLC5Ub754DkCxne26T+4yA1nxQevjpWUj9J9BRDNbS6ZJCYzmzr4zDswDcozGvx3gvOgbkxBZuThc4OUojsK61qUaENRyHyq0mPP6ODK9UgEeQDpp85xI1hg4cu1r8MgrE875AGNN4sJxhCu6DqExa3HRXtmSfMPURRYqJ8yQxc/ZqL9/YdjDdtPezAATuE6q05UYqYlXP+HN4RaWFUHXMDYhn7kvaYJcfQs=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abf06c95-acad-49e0-afef-08d827892641
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 00:02:07.6898 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YHhA7ihf1XJfGt4OIS4k4izZj5ii6jcK5kpeXkQJXLRw1JeY6NMIIdlSfQqO4GhM13UD7wE22s8xwzCZPyGsZYpE+2WNYwpaP41FImr1a9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6549
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200713_200211_651801_FF641445 
X-CRM114-Status: GOOD (  16.21  )
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 7/13/20 00:42, Christoph Hellwig wrote:
> On Thu, Jul 09, 2020 at 04:40:24PM -0700, Chaitanya Kulkarni wrote:
>> +/*
>> + * Default to a 4K page size, with the intention to update this
>> + * path in the future to accommodate architectures with differing
>> + * kernel and IO page sizes.
>> + */
>> +#define NVME_CTRL_PAGE_SHIFT	12
>> +#define NVME_CTRL_PAGE_SIZE	4096
> NVME_CTRL_PAGE_SIZE can be defined as
> 
> (1 << NVME_CTRL_PAGE_SHIFT) instead of duplicating the value.
This adds a calculation every time we use the macro and makes us rely on 
compiler to substitute the value, I guess we are okay with this, will 
send V3.
> 
>> index 45e94f016ec2..68f7c090cf51 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -348,8 +348,8 @@ static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
>>    */
>>   static int nvme_npages(unsigned size, struct nvme_dev *dev)
>>   {
>> -	unsigned nprps = DIV_ROUND_UP(size + dev->ctrl.page_size,
>> -				      dev->ctrl.page_size);
>> +	unsigned nprps = DIV_ROUND_UP(size + NVME_CTRL_PAGE_SIZE,
>> +						NVME_CTRL_PAGE_SIZE);
>>   	return DIV_ROUND_UP(8 * nprps, PAGE_SIZE - 8);
> This looks like the existing code here is wrong, as DIV_ROUND_UP already
> adds the page size itself.  But that is better left for another patch..
> 

This nprp calculation should be  ?

DIV_ROUND_UP(size, dev->ctrl.page_size);

Should I add a 3rd patch to get it done since we are touching this code 
in this series ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
