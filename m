Return-Path: <SRS0=c0j7=HK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194FAC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 03:51:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 795E964E5A
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Feb 2021 03:51:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 795E964E5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=uEkzJVIpstLPNKsf0KJZDaeJN1Nn61LqP5Zk9AzzxAg=; b=cBCAOe6pRZ73qlJagyRfCby+6
	l0eE0H1ENkni1pArvgd2mX4xHAUEiAvlXius8B/m4FeWTzhrT0FTjeVEgLACdkVm7lB2EuxBbQFMy
	4WkeugcW9RJr+ku6/VQnUBZiFk9jEAP42gfplyj0CP6baSSDxRzmFXGbczG4dWL42SQ6PCaRmcz0R
	H7jxiOhldOfD8n3h9CAOYGGaxA0EdbFeLhj0MGXHXMXEujQ6w3Kic8qezXgn6K5pMfTRwgy6DM1jU
	vgSYi8mX4F6Kl5SShnAFoz+fwk0/h3cGqmcW10vKVxki6ikVmVu1SdlvgIJ+KvPYQ3XN3AEh4mpTj
	la5LSkozg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8xaF-0005b0-Up; Mon, 08 Feb 2021 03:51:32 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8xaA-0005aX-V8
 for linux-nvme@lists.infradead.org; Mon, 08 Feb 2021 03:51:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612757461; x=1644293461;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=3ldGCkpv/EojZl+Z9asPlebPmsho1y5l1Wbt0VmvpUY=;
 b=RcK7gUXCUIXPcn3r3gW2LqluluujGSFc1Kak4uMTZZ+7eJ4cTMvE7U82
 bNmo4OSupxGSa2ZHv5kohbt5rHgQJWZgWXsmqJMIpD0FIvbwg4UnJ53Ku
 Cqph+3T4fEszIVOYjSpM8uAWo0TOdOu/YUOe621uxI4sNvixC86Zr+fjh
 OpjRsNDCg23DEPU0wb5iFVGhR6vC+2BH9V/oSnOpBD6Xa6KIXrVWzUfIq
 oNtVeee7vGr1B5MzyVvHqLvmx7eafUn8XBDcOUPwT0NXNQoKSaevIliz4
 EFghjzVi1oDQ19duw1/dNA/76RC7mMkTlQZ2r1Q0F+/Tgl6NsvmrfLCgn w==;
IronPort-SDR: kt66HD2x9qIeDaOwlQDf5izab6pfUoXdJw6PzRwJkyOq9mANTIm2uQBZdqjbYmP1oP2Xh/RIbn
 ahXQkYqMgGf5/WuDiwX3iIvGPIx0WrMc9L9CoVB8oExDvSFizlmlszs7OBd7e4XLHdFJoxBeCc
 b5LjkacNOnqg0G2NgS2v7gP3o5i9+Pa5jMdG4t8tsDccmKEr+uhpRG/2WFqtK8aev+HzZDAKZ4
 IJo0N8rK5uEa/q13S+VBBKZvpAAOzCJqhwEnDg6vtHmcG65b3oVT0xQgDkSDiCTBzOhgX+PJQQ
 OqM=
X-IronPort-AV: E=Sophos;i="5.81,161,1610380800"; d="scan'208";a="263517500"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
 by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 12:10:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpJw02rFYjb/xpTZOCfzcv72GxjJtY1qWO1llbmtJFbYlvlaziVc7KCgszUjd/6qfhnMa/ZPG8/SBDB75aF55yPX1ocJrN2blys5HGs4b2aSoUCUIq65Km2wNILPELYpYRVCW8ZEdveih3WYT489rShkeKdXHCkhRgLDulQp6cbnRnWjgnVFz/2fMJq5sbOHIaCd8+tik9hV3U57IcT3ECRIBqaGRH0SwiIGZ1OytgIf/r/39ki0K4c+ibbYp9URnpl0SEGxWQ6D2g0Rgk8/18rk3W8loRzKs/9lsj2abpCbODk+14NUqjJFH3EA+ezQGumo1Urc/OZwMapEn8RJ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsgRRmVcinDVLZqZJgpnqclTphb6XbVDc9fai27pcwY=;
 b=I20BuKG1j0dVBjTl89POp8GfENU0rifPqfDS49L9zSDOkQTzzFSoHHL7IqsNvm6vW8TuItaZWhKuUi3005/sNO1XF6Orom2faWPyH4nxSwkNVEf+udbn/Knj53XADx4cRLta7uPlu1dv/3hk44xtwq7MziCVddPhlXln+E/dZuVo5OQIEv9afmskKMa0PuGQLwCHYAlnMoe6vuyAsOXGC8mqjm9zQMhhVSkHYNixb+TYzDeqZ9fQ+ihg5dfme+6x1yZIXnx5o6/GB8gxB79JNt8xWuGBh7WRxbvGXlGwRoTj3FH99LtQ7o1N0qSGLE0ES+DlZQvpavg9AQbR1E6g2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsgRRmVcinDVLZqZJgpnqclTphb6XbVDc9fai27pcwY=;
 b=avB1oqk61aMA/+s8EnD5XkhWarWlTtp5f+Sf+RSbFmBbTBxSHCATTcZzu2Wp8/E+e02HY/eUvt5LEFerZ8oLRLvcXv+0ew5ezpfKkRkD0wHNL5QSeIuFUv/l5DPf2G37yf12q2Qonmu2FZCmYoOtCRukrlbZobOdyWtPX5f+pKo=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB6482.namprd04.prod.outlook.com (2603:10b6:208:1cf::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Mon, 8 Feb
 2021 03:51:19 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3825.030; Mon, 8 Feb 2021
 03:51:18 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-multipath: set nr_zones for zoned namespaces
Thread-Topic: [PATCH] nvme-multipath: set nr_zones for zoned namespaces
Thread-Index: AQHW+/gdUltcG0/QqECHms/I6ixNvw==
Date: Mon, 8 Feb 2021 03:51:18 +0000
Message-ID: <BL0PR04MB651449A902E7FAD397E2169EE78F9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210205195002.2657209-1-kbusch@kernel.org>
 <BL0PR04MB65147CDC426FC6345B2048D7E7B09@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210208032851.GA14062@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:9d22:7ad2:9f1a:e44a]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 292b64c5-7fec-4755-ccec-08d8cbe4cadb
x-ms-traffictypediagnostic: BL0PR04MB6482:
x-microsoft-antispam-prvs: <BL0PR04MB648259726701DFBD9B215C5EE78F9@BL0PR04MB6482.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lpnKBPKv58yKJqJIcvHTHOFL2vqq7lfch2wkXu+OeDmqVrERCKTzc4z/x5Ze+kVa1vyaB94a9tjbu4b10KtBvgjTFZnakrWWdvo6Kel9aBN+sppUKir1KWrIkpid4YT44l132xFUVsPwPlzqWUDbul26BSUKeSM9ss3sD18cs020WrRFQE+dqUxmi+eQ4aISXzZHO1rRxZd25aevoj1PBEBkrrKzRdZCOVsl1Mvb2vVlOZ8H+Ov32NrcVPhjlCPVuOyDSUDQT6+b6ElFkWVx5B3IQ75DBavYuG8m6lhP1eYPDrioqjtl04Rym/CdlDHKohwI2zNIkwg9blAtLoC0IkAU8Q6h6nhe3VTv3w2FgWiGaobuo0INe828GGIC7Zkbzak3EwB+tMwPqqLkT7xpfcbtRIOaH3DGjdtv25Ptqco5DIwEN0yBDl7l5Q4Iw3y129ivjnFgXielSKU8B+6QUsCd5ggI+ImWgOhyYBM/hN134K/H3gJgupaAGcXu/GaLeIbv5k5sJG+jw1L1/njFDA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(86362001)(71200400001)(54906003)(6916009)(66476007)(9686003)(53546011)(6506007)(83380400001)(66446008)(316002)(186003)(64756008)(66556008)(2906002)(478600001)(33656002)(8676002)(4326008)(5660300002)(76116006)(52536014)(91956017)(7696005)(8936002)(66946007)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?idtyNif9zR+XRT4taLRBtgnCykt5bKn1nI3MjXcVxQhE+5Qh1QGIviH29DEQ?=
 =?us-ascii?Q?DxtEas4ogVsmlOjz3cg1gCPey0h3YC+qEbM5sI5tLjx5WVwnzBZdLeCqM2gW?=
 =?us-ascii?Q?HJ0ZWKsiOcbhCLuohaowUAGcyNzX80B+/RsNG1JTqXaHav/xGH39EaWRYj7J?=
 =?us-ascii?Q?4j2QRUzA55geNVjat5Or4GaYpD96q3uBukMRTrcHlmurMxD758cqsllIhMWo?=
 =?us-ascii?Q?EeIyqFEXxtiiAeN7CaJbebVDWTLYMROpKDLSY0vj+KnXpRDLnYqgNH68GIbi?=
 =?us-ascii?Q?5iBWnoyQ+I6o/ixPGFMvV5slfVKycoWRWtpHT1gcdNGVcNhb29OvzTgDR05w?=
 =?us-ascii?Q?KLvq8Ikxzf187r94vD8WvMhG1ZAGIBSUj09zzmP60C3HXseV90JI5qmDNae8?=
 =?us-ascii?Q?qQq1caMTgTQ7IfWuXBjiutZESSVQhuiHFvWGc7ylaLPJHi7uJbdoDmDPPbeO?=
 =?us-ascii?Q?Zb8aAJ/DA771uXQzZNvwA/pcoGAFluCWSYCEY5gQruA1I013TQ2tNSskB6cw?=
 =?us-ascii?Q?IrI/oq1rqwA2cJZ5UBFTWlkh/oWBMYrwRbigEdXZT8ylbbUeugEox/QvZmta?=
 =?us-ascii?Q?5sDPMFDiLyDa7SOIRHVBf4kkQ47Q7duM6Gf/auqG9vRvf89RZrSUt4EIHTx4?=
 =?us-ascii?Q?uICGbC0vUPTo61gavoDXqpbQFTF9UkkuwRBdPxTN9Fg9ySTfdXRax/Rh5LIR?=
 =?us-ascii?Q?luTdAF/QCp3c00rDfkAZ4dxfVQ4EISYM5YpI8J9asNHamlXRz4XIVn9fyjJs?=
 =?us-ascii?Q?2/wyltdDTWDilntdSvCqMJ39NDEmwjRv6T/DYA10ghRxpLk7/lvv6sdXpIf4?=
 =?us-ascii?Q?NUsytBPvE3ZN3AoVo9Y7P0xnrmZdCclwsnx84Q07z3VjsyAMihS8kAiyPoz2?=
 =?us-ascii?Q?NNAdlEwOgk3aW2FkE0+30HheSPcvSBeEEU0nl7Vmv5LMkaNpLI+Vcg7AxaVo?=
 =?us-ascii?Q?SlsjqHBNIoPIPTot3KQ028KTXA9zmJgJyTgBDIjavwRZijclxgKQpeJJKHfZ?=
 =?us-ascii?Q?nHuxl2icoM0xjPYd6nd9MvRYd8K2QjScR3SXdz8vRx1YwSOQF4s2hqJFtMWl?=
 =?us-ascii?Q?Bnz39UwElH33pRPuRBTdjTXgOuAYwsrnuWlcDxVg9nMbEsgwEYAvVq+p510Y?=
 =?us-ascii?Q?jdJo+THNXjdZ1rl01Z8oss5p7YE3qku6StkgrtkUrbapUn2V36cterMb2dvX?=
 =?us-ascii?Q?i61ItcuY45u8HaSUZch58dN1HjXYzYEJjZHS6ZWvn1KNyOnQdEF48a7qdv2Z?=
 =?us-ascii?Q?NwjnqdTNarJguGlMq1cBOyltmdjsr+H4us3Aj4876aUzx2uZX7KrJ+aAB7s+?=
 =?us-ascii?Q?i9cqoP1f++hE4CNL+6D6hoc6BjgzdmaJxj71mcu9ZLO9ZP65fU88LwkLYdS9?=
 =?us-ascii?Q?SVKGp6YcHtgyx0pvCYhyRP851heLYC/k9BwrSvJbuRqG1fl4/g=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292b64c5-7fec-4755-ccec-08d8cbe4cadb
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 03:51:18.8065 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qxlvbHl4UuVMbu49Z5jDz8OJpxsOJtucGCPBYCQu3S4zBMGrxRY52UJegzlbalzZraPDk8xdFNq/kpuiWmfV3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB6482
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210207_225127_323224_8E9D3567 
X-CRM114-Status: GOOD (  14.23  )
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
Cc: Minwoo Im <minwoo.im.dev@gmail.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2021/02/08 12:28, Keith Busch wrote:
> On Sun, Feb 07, 2021 at 11:06:36PM +0000, Damien Le Moal wrote:
>> On 2021/02/06 4:50, Keith Busch wrote:
>>> The bio based drivers only require the request_queue's nr_zones is set,
>>> so set this field in the head if the namespace path is zoned.
>>>
>>> Reported-by: Minwoo Im <minwoo.im.dev@gmail.com>
>>> Cc: Damien Le Moal <damien.lemoal@wdc.com>
>>> Signed-off-by: Keith Busch <kbusch@kernel.org>
>>
>> Shouldn't this have a Fixes tag ?
> 
> Probably yes, since this omission does go back to the initial inclusion:
> 
> Fixes: 240e6ee272c07 ("nvme: support for zoned namespaces")
>  
>>> ---
>>>  drivers/nvme/host/multipath.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
>>> index 1427c9555cef..a1d476e1ac02 100644
>>> --- a/drivers/nvme/host/multipath.c
>>> +++ b/drivers/nvme/host/multipath.c
>>> @@ -677,6 +677,10 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
>>>  	if (blk_queue_stable_writes(ns->queue) && ns->head->disk)
>>>  		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES,
>>>  				   ns->head->disk->queue);
>>> +#ifdef CONFIG_BLK_DEV_ZONED
>>> +	if (blk_queue_is_zoned(ns->queue) && ns->head->disk)
>>> +		ns->head->disk->queue->nr_zones = ns->queue->nr_zones;
>>> +#endif
>>
>> Is the zone model set already ? I have not checked...
> 
> That's a good question, and we should be safe with the zone namespace's
> zone settings set at this point: nvme_mpath_add_disk() is invoked after
> nvme_update_ns_info().

Hmmm... I see the zone model being set for ns->queue, but nothing for
ns->head->disk->queue... Shoudln't nvme_mpath_add_disk() also set the zoned
model for ns->head->disk->queue ?


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
