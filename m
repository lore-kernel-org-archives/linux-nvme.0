Return-Path: <SRS0=yJEp=HU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E41BC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 01:41:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21DE464E42
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Feb 2021 01:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DE464E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=fITIorrf00yo80QhaJTKTJkuEdfquRgY94NTpk9MGis=; b=OwnqhCwI3cBbadZ6vfLs8XjOM
	YT2GUB6t4bzU3+IwnVoANj6MwBQ8VrL5D3oQcoufXTYqHitKTEZW01JZ2iLErXchfzeubKtQ07gzt
	plhGscxILrzp1AUY8GWq06wQt9sofzBj3jIc8XfqSAOVkIFY0WTRe86LNM3eCvnzJA+aDkUddtVr4
	d6SbWZ4+r/XMrs3O451Mgc18F3Uqp3UGucVchFIpWiMD8EhB1oGFrgwHt6gsscTryMdrQoZDJdpPH
	4M/X7r/rJULHmy59ElmNZ6Nbu1RiQJUskr928X4raJ9tGCQrNN82yf/JH3g/KiGxhSmpSfaf6bk+M
	i4gzkhqZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lCYK7-0006dc-0d; Thu, 18 Feb 2021 01:41:43 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lCYJx-0006Y8-4b
 for linux-nvme@lists.infradead.org; Thu, 18 Feb 2021 01:41:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613612493; x=1645148493;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=p8Qn/g6UhaURCN4NbgB/KIH14yCj6/6tsItZ0KLv32Y=;
 b=dzZprDCezSbHEMNQ859g30XSXJ7Q8Z7VXqK+FNbk0bXhue+3+QMsbDBw
 im8P7u2ujagG3YjAXm1wArVGbDBP8MpfUL4S29ETQi6MeB7ofL0UdnSVE
 oSC3acN8UvQPFJjvGHLX0mciPhAztL0oI1p3xwutBdIQj27pCKSw1H9xN
 oy5bwf69eBsq3cuM1o0yA6ac4sBqEGYhgA8DrafYSWCrUo8YN+hF5rg0v
 VvUg8jdZxsqG9nvpxjI7eYJQGqqm0qmW3BLBgv25pDCNkoAqC0rrdmMzh
 45m9l6InnL1V5b+9twSo1mNnQpxb+HlPppBa8ie3N41hx0gS1/aTcUtap A==;
IronPort-SDR: C9P14XeJpE/BU6Wv59oeYKzX3Pr8r97evUXEhRV1bUpqLeU4sZ1WbkGR9+IrsiRo4XkrEaqSrW
 eTmKKTcyxrBaTy8da/s0NpnxX5r2UFqdYtC3xfpQoqQP6tiTu9YqJOWYYC9GJDl7AoHwJ0yK3o
 mqUirt87s7cqNcFVc0kzzvuhTcOb1F5+bMGpLA7BIoE9sb2M+wGEL8Z7M7Wzj25kKIBEJz9six
 kKZ+vGKN0BFN49BLPx21AS6I/DikamvdQ5B/vKATodtlgn1skLUD0m1bfWIXhAjj7oqUuMaLd2
 qW8=
X-IronPort-AV: E=Sophos;i="5.81,185,1610380800"; d="scan'208";a="161391306"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
 by ob1.hgst.iphmx.com with ESMTP; 18 Feb 2021 09:41:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfgcyHCVRSfJd1rI28hNMTKBx8FEX/D6wDAUev4ckTLNichhitqLimxjNuS3nZF642oLB7RIHMI/lvRyRH1jq/1OJ19eUWqqcbnM9Chpk+sRiEBaiVUVEQoI4zo4AxYjgtOZf/24SrN+XNbtMgCgfscMAROl2oAuvPKkTnS8scxasfuX9mGvZmd4upyWmnCbwf24f9O54X4BYsuBwOzBE4zW6C/dQ9DfThT8CDFpspjozB0pFsWWxsbQCQ0ndQB8UI+GeaCWyYFI+jx6pJaV9Csk150VSPwfiOmAvh70UkF7BBIQL03W//kSaCSSkbT4hJZI1T9erc63B+GWdaM8GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8Qn/g6UhaURCN4NbgB/KIH14yCj6/6tsItZ0KLv32Y=;
 b=QASjsPRCGJse0LplFQySWgv3k9y+Q8GA5Px8YpoB3GQpNfQcywON1+9qrsrnfjEJpFW8POOhLBXCNDLQrjkaHHypPyUHGuMSHtC+MieR+ZEtmki7GQM7Kv51YoFEc/Iiv1BuH93qaEGsh1ksMFTgdEZs/jhnXKASr8mG5SZE4QjuOLJgmUv+ArOTDs540Q7q1y0Vax1uNy/x1R4Cw5maQR3vafw57gmTAlqKNim7zYqf/3cu8zVPjLeKl3g5uUWqk1faW/Q7xvfDp820NQ70Ml93HWAoWl+xn8/uT4kwMji6Xa6m4BPGCMxxf1FD2wCk/FPyfHbqxpB/9jQRHK0UNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8Qn/g6UhaURCN4NbgB/KIH14yCj6/6tsItZ0KLv32Y=;
 b=vTmMbEd+30FSvgwb6/Haqg+WqX/B8wDvm+7vLaK8nkn8f8J1/KbsZB4NgxX+Kud5JCUFfiGt1Chc8jVKNy/hGU4gpcG9uYpb9voLeMN1rczpZXva9OECbjkwMg0spV85TqKF3mTGBsQLA8GR9MnylQQgqfawuM7tqBXzqz58M5o=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7501.namprd04.prod.outlook.com (2603:10b6:a03:321::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 18 Feb
 2021 01:41:27 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 01:41:27 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: use lighter smp barriers in nvme_irq
Thread-Topic: [PATCH] nvme: use lighter smp barriers in nvme_irq
Thread-Index: AQHXAu696T9/DajUoEiPLgnbqLXgjw==
Date: Thu, 18 Feb 2021 01:41:27 +0000
Message-ID: <BYAPR04MB496552C50E0B69EDEC5880B686859@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <1c90fd6a-d991-b347-479c-2c8ae5a4c51f@gmail.com>
 <BYAPR04MB4965D222B05866D93852835F86879@BYAPR04MB4965.namprd04.prod.outlook.com>
 <be263cdf-19a2-05d6-1023-7d935d526663@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9d9648af-d006-4b0f-4960-08d8d3ae4f1a
x-ms-traffictypediagnostic: SJ0PR04MB7501:
x-microsoft-antispam-prvs: <SJ0PR04MB7501A7DA7FA66061DBC79D1886859@SJ0PR04MB7501.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N27B6UevRWRwJpStGSStWFhFimMyx+Fzg2Eb9KIa6+Pa5F2WuQh6atbtl6j+iOIbjUI+rMsEWLk+J573STyueAMaPwHFoYHH/pUFq3srD3m3y+3V5Cz4U/4BQg5piIoAw4y0P+Wtf8cId+dYSltI5iMe7m+rSnTzQRG7wlGB5Fn0zxiSNgIVV8Y8cAugg10wsp9+mZnPYrjm3Y2Q6yGSOXEjmq/NwgsJlWvm01iL6Sx18x5j8Vf0n3AuomMQd+uj+nFmN0sqm2nJwroztC5DETACTKamN9Z90yie9o6x7o3KLWLscRP9VtYDAUPOdG48BV+q7+P5ALJdOvo13D2fRT6JVPTUGEDDqUVA3eNc7gF38GMdSx/Rc5eRuKoA9+zm9GDQW4kz5dfrypHxZ8BYWMEiGjxHcZtXPO8kULVpW2POA2uyqecT5IxYLXzMJoVFl1jtE62owFBD9FOKsciw2HQ75NreY2WnDz5/99IO6aWVpQLsvqyFjeCj5Z7qj8YYeofkFAAxSz9VTjNkvQUqAQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(316002)(5660300002)(8936002)(4326008)(83380400001)(9686003)(86362001)(8676002)(7696005)(52536014)(33656002)(55016002)(91956017)(478600001)(6506007)(66946007)(186003)(26005)(71200400001)(53546011)(66446008)(66556008)(66476007)(110136005)(76116006)(2906002)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?sv2niqjcooaqnTl6kK0l0AOuD7aN2ahEwGVUwJ62x5gRjdkwF/TS2vUjF+8h?=
 =?us-ascii?Q?djBujlcUD6wNs8SQxWd1x7XpV9s3rvwDAgDcJp5moxk1PdrsIfcawAvHrNtW?=
 =?us-ascii?Q?zqsqDjpbXCosAk6hHOHb5ceWtiWcwqVOWGERQ6a4V36yEjEzX0dnOiO4av5A?=
 =?us-ascii?Q?W21/J9yYFcsQ8zBA+SVp950ZcxEc6jwbpzFCP2pp3RWxcIrojN4KWsUt0pm4?=
 =?us-ascii?Q?ZKDW6AIzHkVbt1T1n34OoZeLMpXG4bO/zar00auzHFEZHyQZnbFHy7wSAugn?=
 =?us-ascii?Q?HMSmovSyfZ/zg0Orx44DUpEK4P5TZY6nxa81OGlFTP7gA8RdGEoL9o65Cm+D?=
 =?us-ascii?Q?GoVIuVMnXZEBdF561UZ8gKwJtW3EJKmQVGFgvN8g6bv5jHeJ2VbMg7jeUz7+?=
 =?us-ascii?Q?75e0E1TcCcx5o9NIk9kUa0B3V7rQxNgrbgQ4uXmt9TzJyv4ENH2aWCzkx6i/?=
 =?us-ascii?Q?MmfPjTeRzVeCPn4dsPsdyOEGse4Mm+/BINGOhmdjCk2pgqK/H0NeWWZNTwxu?=
 =?us-ascii?Q?e1Hj1MQ1WC9X5eErCA24QDnU58jjvg8+KCoVE8+z8K/TLkbQ3QiuG+TSPVWJ?=
 =?us-ascii?Q?OOiZ8KuXbuwdX7nZswaHK2vkbH81NYe+LvSGPizjehLkmhedjp3u2yd8LCr4?=
 =?us-ascii?Q?c6W5Och5C6kI3UUgqwvZ4m9azOwTFV9RMkNQGwYJTpVMRDwehehmVN8icd6X?=
 =?us-ascii?Q?8XOYqifcHJb6k3odc240iL4P4oFGmyOJGIJNZQI/hgB3KiseOdtDaeCFDFhF?=
 =?us-ascii?Q?dPMTe6rebJNX74uNssf74+IkfziJyPuOp4vMRXAi5gUkA4nmIU8gJxhWRVq5?=
 =?us-ascii?Q?GZarkTO/94NkgmfxeT2Jan+sTbWFKhayVAbMoAWxaMqmU1eWzCoeEC9vje8J?=
 =?us-ascii?Q?g2+EP8IfWWLK7Gq7SPc/gV5r1e21udwQpPCewQbshoUSklqnXGnqvZ7dFFN7?=
 =?us-ascii?Q?j6YMo53Sm0GDDEpQDsrqgnZaVGNgbpFKPLZ38FA8E1GhsddUtScf16jzRGJl?=
 =?us-ascii?Q?iomSzI2M77yC/uRDMAxVcT8qy5MtXSQ5A5+wqoEtLlPlc+xNlYDgw2gh7wqS?=
 =?us-ascii?Q?lJQFcjRI0YOcQX+0GIbhLEQg8Dz5NUQnJYWFyXyG1kYhFL7nUyMpSM3bF25A?=
 =?us-ascii?Q?t1rQLF40t1IH5H+WEFHT9KpAt6V1fSV3lIJkjuDGRybAOP1T28g95nsJFza/?=
 =?us-ascii?Q?Ey1HhQS5VJyKXMLoHqkBov/4nL9oX9HEtHKcGKxsvFRZm8D00rdGwPqa+v6r?=
 =?us-ascii?Q?S9aat3CNCYV++UAYPN1lT94JPF7qVHadBh8d4cpxqWEdjz5qxI2Fd8Qp/lj/?=
 =?us-ascii?Q?Me0UTeye/SjKaOD02+BH0Utv?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9648af-d006-4b0f-4960-08d8d3ae4f1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 01:41:27.7288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7hgLhV6EufbpNSc2QNE21oQG5JgfXVJb7JvcIVsDgQGIaHj8MxCNzmAEwrwUDJzCVlBmPujIzciGBQuVNQmEN5rEfX64tDoXyv5IrbRBBx0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7501
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210217_204133_462939_841B9B54 
X-CRM114-Status: GOOD (  17.49  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2/16/21 23:26, Heiner Kallweit wrote:
> On 17.02.2021 00:59, Chaitanya Kulkarni wrote:
>> On 2/14/21 08:30, Heiner Kallweit wrote:
>>> Based on the description we should be fine using the less heavy-weight
>>> smp barriers here. On x86 this would be compiler barriers only.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Can you share performance numbers ?
>>
> I stumbled across this code piece by chance and don't have hw to test it.
> Having said that the change is based on code inspection only.
> Unfortunately the barrier comment is very generic and doesn't mention
> a problematic scenario. Also the commit message of 3a7afd8ee42a doesn't
> mention a potential race. Most likely the barrier can be removed
> completely. Helpful would be if someone could explain the potential race
> in detail, means which reordering / variable accesses could be racy.
> Then we would have a basis to talk about READ_ONCE/WRITE_ONCE vs.
> smp barrier vs. dma barrier vs. full barrier.
>

For these question you need to add commit Author to original email, as
far as
I know any performance improvement needs to be backed by data, unless there
is an exception, in this case I'm not if it is.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
