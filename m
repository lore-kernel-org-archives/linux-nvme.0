Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0BFBC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 03:41:09 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 809C76506A
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 03:41:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809C76506A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=y2eZlfsC7PNk2u1CBQau/U/zT/Hz336yDHtxJLXk5sU=; b=qgSOlcfC7rbQ6KqmSBaCYo0c0
	7z0q2HPXEYKfi9VHRupPnyV5zjaMpr/GGQ9Ppm2+zHccEnFgj4FrHJQwCTFlnEz+UiredcxGschH5
	gbM0/PCzFgqw5U8SrjbLFWPZBN0jBF2J57S3gw5+5aoNm5kktPiCj3JBLe4v/y5KnaGPQesCd9OJ3
	GpkGiD2XRNBw2f1UFaeBbQdOHSZmZo4hrUO4sDhvBZqEXHAPwNH2rqZDZpUQOSfmE+caaLHBkiioE
	IeB6vtoaaOVD0GQOy+YgD8jGom59slkd7tCNfxszE74MvgIVlUtxvEyLRK0/lj24pgLjXDZb8u/Az
	kVllvrQxA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM0Zb-00HL7A-VC; Tue, 16 Mar 2021 03:40:48 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM0ZX-00HL6P-18
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 03:40:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615866066; x=1647402066;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=dXjzgFeGqd1PA36HGwGtOe1N+9kPqWGGSoCjO8uaqtE=;
 b=XO0wILP3/eFR7SStRKfPOY3yhj56dbQN8beQNWSf31SjAXJJnurEMhp8
 65NclTRQEMwlOHhuYE5UJ0atEI4aloEmkgFtjS9tyR2fDG1xHHrR3fkSV
 eu26z9owaNKnmc0rUAy4FknXWNj2IvzjqRgXd6IXBjGcAx/MyI7/4fjok
 l+IrHLRZj+H4I45tkEdZeYBtx88NtciD3EYy+M66oPF+gAAAehg8PwwIy
 E0rfyZRYI8DjhDNLYRAj7kMMZ40X+C+enCGgqdR7OdsM9In00UZTWdwWK
 fJQj9hxuAGrO1sXfIqYGoAmX6fcved/1nI9a9qRuBWU3Lu/AxAkaU7LsZ w==;
IronPort-SDR: fHkSrF9Si7QwL/6CHA+HgEDvoTA8Ws/RFegCGqrjUAP8/UXBYKLja6pRB04RLNxQTZv8VcuL5O
 kweJbcvpfV8SKY6yJG1np7c903WnoAZnxGYyrzpn+10RBtFSznLPTM5JOxqERuUC5as8n2vxxJ
 K4eSMUFZkgckxUOwhti8drnLp509SUYB+i/POXDfnZrsASVGvqe5pJgB0zli+kRkdm7nFJOY41
 KHgPF2qTeAchs3mX0MmH/QXDfmrF0IvL+p+9Dq/KiwBwqkQbx/YrenjlAETDMyZ2Yd/VtW/pGm
 ObM=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; d="scan'208";a="266606795"
Received: from mail-bl2nam02lp2055.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.55])
 by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 11:41:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFX+VOsH6cK1fM6RGtMyUkZKims74zS4VT88VThpEfIz8q/NcEAc+BmcmVOHiM4DXeUsAwaVwep88IN5z5TW6DYHAF6bUl/PP21pPBwAo7P08ipOcPEKOPtcYbJMG+YmBtOfLWNmmDaJKRZ2AzGzkqHugfYudp+loR0y903m+nOAr9Tlz4jN1/ob99/mtTDfOuy33fydzKyqFYL3YCfM6/SVII2bBGSOZVfD3jVuVBK52UkBSSZv0AR+ia6juLbLd3tfhQtggORWieJgs4TvML6pp6Sys6qg6JMmzqNfcQJo9/0Fufal4IkZgEkkay6DSSa/0UXtXiuAnVklm13M7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJOciaOpV+7lMF591LBfUxx/K8jChO1/3Qg6fM2tKNk=;
 b=HIRVvKjT9U62LztiZoHInPXuUIrw6HIMdiv8T5X0EJ4OBxc2GbJJ+yil4JPGclO/CwGDT+60D9O2TwP1VufRbF7f+rxJvc87EUtY8lun+lz8mthUpNbVLy6n3cc9yk55MxpBtuxZ0kXK1jSQvHmSR0AFWsvSdiEkd1kXTCYskXvDHiQi4yJuaj1NhliXMprduEOnavVs33Q+3iiFPwyOsPua2n02GpZTWPlCLJhFePKU1wrR10m2GYkPiouGLzgC3KYPwidk5kVTlHk7DvpDovJimWEQ7RW9fVYT0RBkADtmvwpcjwOHGd5YR9DAdkU0hkE+UTcKLqEZ79Fwv3rq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJOciaOpV+7lMF591LBfUxx/K8jChO1/3Qg6fM2tKNk=;
 b=kGp9d13uuCG/18mroMqYag+JoY/xQA5WYLW9Cr1gCooiArVisH/V45M687P49GRCO6iwzm+6aeCLxAIOsroDYIJLaZ/56MG/uWswegfmnuU15DIK7Yk2ThqqtIeIefLf3gC27XskfGp/AH98ZlhalcEsuxZcAyDstUaA83V7A+A=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6024.namprd04.prod.outlook.com (2603:10b6:a03:e8::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 03:40:37 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Tue, 16 Mar 2021
 03:40:37 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "mgurtovoy@nvidia.com" <mgurtovoy@nvidia.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "ngottlieb@nvidia.com"
 <ngottlieb@nvidia.com>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/1] nvmet: do not allow model_number exceed 40 bytes
Thread-Topic: [PATCH 1/1] nvmet: do not allow model_number exceed 40 bytes
Thread-Index: AQHXGateohYAPQtrLEmKz9nIE6WnAQ==
Date: Tue, 16 Mar 2021 03:40:37 +0000
Message-ID: <BYAPR04MB496523CA274146559560AFF1866B9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210315145611.155972-1-ngottlieb@nvidia.com>
 <BYAPR04MB49657B5E84CDE72510A5AB77866C9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <4a4a2b20-af9c-0474-a5b6-734158dafcb7@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e584ad14-6d0a-4fb7-99d5-08d8e82d437b
x-ms-traffictypediagnostic: BYAPR04MB6024:
x-microsoft-antispam-prvs: <BYAPR04MB60241881E98B8A7A7F7955C1866B9@BYAPR04MB6024.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PR52VhYLucpYHE2P+CO3WVrE1Rvpp0k+vaBb2HIYs5AaXd6DoLhAlWOa2EzETH0cAc9kqzHB4v3au/3B6cHCzwyqXuLsyXdpzJ7WiQSOIKfEgzFKbC61VVbhT02ejcRrB1t2e10fWpckQDMf4irX0+ENXjN4gAYtcCOdeV5IJmL3JCo5f6mCgE9+Gq/6wyWOeHkAbIJqiGXvwtEFRrLz1HmV3ehYRN6XuZToDbJN0IvpNX1dvEQ0ZXGq9D8Ic+KjMUWbuZN0fqtaLV0Du60U1rcNrIaF3ASk0zRKAJceUoYjmyaX5bpxDwbb/Fbh5KqM6J9DxBBzoZE1jgWpHpmWP5N/o6Gi7RnjYe1v+7GfGaxZFI/MpmlyPIoTqcpRW4myjI90rspMyL2xRhRhouXsH41RXHvPeiyNoOvB8Z3E5nL6ZXGL/LxRBAUEjhYNS7lcyNHiY5PAunVD1BOJAH3haWBiGptZUkFZtjHbM3JbS+/IqoHlAVljKCnZNBErvB4vWQu+ZaVEqh8VMr9i+jBrpkSvgBOCU+ajd40ftgKskfpsNk/g7AwWF/gpQON9z85a
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(9686003)(91956017)(2906002)(76116006)(66946007)(54906003)(52536014)(64756008)(186003)(66556008)(66476007)(7696005)(86362001)(8676002)(83380400001)(55016002)(53546011)(6916009)(4326008)(6506007)(8936002)(66446008)(478600001)(5660300002)(316002)(71200400001)(33656002)(26005)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RIb4AXABe9Iabhny+/BQ05OJMWohD4Bmm/i+vlZ+LVIA0zP3KUWBGp0GayX7?=
 =?us-ascii?Q?eUawQBo0EXlyEuwCUvnvb2tS4wbkVLsO80hO7NeDG+tmqPvsm/5N9L8iMYj/?=
 =?us-ascii?Q?VsoqCObxgeRByNkwyxShaljbeOGQf2H1W40mlKiRJNJ0c6PJwnE4YQg1q1vB?=
 =?us-ascii?Q?AOEmBMqsEli0ywBFaL6emkzr7LLWwSEpLtVTRPIrKgOKAo1WRw3GEJMGhptl?=
 =?us-ascii?Q?cjOzl1AMIvOoqjnTO3qX+zppUF3+A/fyrMW4lKfvIO0kaUoSt5q/Ox0THGnn?=
 =?us-ascii?Q?uZhhwKPhXEh/TnwXmJL7nQn+ggzlZtABJ9cDQZ6eOZQp5gAD5Nu6d7za7i90?=
 =?us-ascii?Q?YqrepVxdCNjYC0p5B2PaVqMapeEZOlkwAC3KH/y7pfTwiZBvNjlagigWrvxE?=
 =?us-ascii?Q?0n4urh+IKB9bIOOtqZ/4djWmjGk512Jzp1JUV08+oyOuxRE+/ScAbz9TQni7?=
 =?us-ascii?Q?NLPC9TaN/mruYgKDvHZpbaUrsx/SCpA4P5Go1HYDj4hbDEMdZ++1SbmM3oQC?=
 =?us-ascii?Q?dHQzOEi5/uMIBDOuW0zoYAn+JZZxzIFaLD9uuBYjDvpB3jDK7/bEPvlaT3x/?=
 =?us-ascii?Q?gtH3Of7t3yygv6rVWmrN5E9ECV70uejQ1FrpQgmxBhBOHcZPPyxrUaUznyw8?=
 =?us-ascii?Q?MNl8EgpLTRUUa5AfztsXu6EyY6SQzHtkYF/Fsx41zoH9eApXMkpTitoWG2O9?=
 =?us-ascii?Q?2THNa7EJkpAziZdFDx4m+D0RwLUqwt5PpBCNA5Bih9NDLMf0JTGFPdvjtZew?=
 =?us-ascii?Q?mSlKkD8yqao6mQfTBCH3WmDhyqzK65omos6iIAisJ9ZgzoyaogCJdhUYEjGg?=
 =?us-ascii?Q?6BT5tmULFJpyZ3KUP4DcwiEQfxopFDKAg2IXSAqhrdLWVlwF6yt07rtTNEqZ?=
 =?us-ascii?Q?TSFBIXdScsu/tGhGIbjrsHvXoz+4G+dECErSsReYZvR63QUh6d0QiDFdr91c?=
 =?us-ascii?Q?ttJpgnTXYlSDu1lKHuWeG7Cfd2uYBFwPAz8GcmbCQbW2MnPvbbk+iy/j7+J6?=
 =?us-ascii?Q?knTjjPrHnfd0q0M5LWg06fW2YxveBx+m2XTg5/kC8IfS9R6nEJSJxlhPwKAv?=
 =?us-ascii?Q?3VdT0HjSAOUoySn4ko01ZbsTPuXbTicUUoWe/uqf6Alfv6PqTTunKOFC7zn6?=
 =?us-ascii?Q?6NjzDLlWRNLq7pxjTNywu3LYyXUv8qKKEbzf1C0YjmuhC/R8T6EaQ5sPageG?=
 =?us-ascii?Q?+NrcaMdJh7OV0f589w7H2130BdXHpbz9wl3IeOFZl/iGinSwaW6Oa57JqS7p?=
 =?us-ascii?Q?D6OUApcloJ41dfys2iIiIalmcQi9pp7iDH+mPuGOMSS2nr2mih6khW7Y0nwo?=
 =?us-ascii?Q?KAhXYb7mETdeudm8gPSzH1Pz?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e584ad14-6d0a-4fb7-99d5-08d8e82d437b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2021 03:40:37.4290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mWdWQfy34bVAN7v+IOpHNAv6RGApaI/0upICsQ0PEMFswd66NF7Zl8n6ZosdgU7VZB5lcmZOQNFe8t//beKcqjxuaYq0VmU710qYsrQavFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6024
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_034043_514803_8CE7F04B 
X-CRM114-Status: GOOD (  13.08  )
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

Max,

On 3/15/21 14:50, Sagi Grimberg wrote:
>>> According to the NVM specifications, the model number size should be
>>> 40 bytes (bytes 63:24 of the Identify Controller data structure).
>>> Therefore, any attempt to store a value into model_number which
>>> exceeds 40 bytes should return an error.
>>>
>>> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>> Signed-off-by: Noam Gottlieb <ngottlieb@nvidia.com>
>> The patch looks good to me, but is this patch not intended for 5.13 ?
>>
>> Since for 5.13 we have nvmet_subsys_attr_model_store_locked(), this
>> patch uses nvmet_subsys_attr_model_store().
>>
>> Is this a fix for 5.12-rc  ?
> I think this patch can wait for 5.13 for sure, maybe needs a Fixes
> tag to help it get back to stable...
>

That's what I thought, can you please respin unless there is a reason for
this to be in 5.12 ?





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
