Return-Path: <SRS0=15CP=IN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A557C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 04:15:14 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8007464E64
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Mar 2021 04:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8007464E64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ZW9zT51OKl2DfJRxkqhhpB7Oh5pR8iSez3gkroWNUgA=; b=nt54KO+8Al20BssaGkM4kD+og
	aL8pZLBn8TlqF6W5xBwhF8zouGWV7Oo8YUE6h5XB50hcE4SIMGRLiyL6zPTzQSSdC+a9n2JYM/V9u
	hi5kBT4L5l0obgduvOEdB2HBhascuqP71u5N1tcYNeISyo6VXP366KbG5Rs/GBdYN2nIl75ZRIhLg
	ERhx1UwGuNQnbpjTLxacdneItzlEh35GJkUzqI4JMY1euM9nNJ5GkDYH7Imcek6FPeTqrY0Zf5zV4
	ZGiJhEW8JYB1XEyksVvXoPEBnSnN6aZAUkNrx3w1o25sYMN6qgFwtMxVu7BgVLKCu4K5MPDtVRMBz
	YGC8xjSXg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lLecs-00Er1d-8w; Mon, 15 Mar 2021 04:14:49 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lLeYN-00Eqsl-02
 for linux-nvme@lists.infradead.org; Mon, 15 Mar 2021 04:10:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615781404; x=1647317404;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=wEp2y1ScKs9JCFSG8VPuhJpZfMqhdAZnvmzN997uojQ=;
 b=h9A44kpvhWQRJ5BxtpdNT0Zi8/OTUlootIELAZRQZ40GAycjevRCbAAD
 G7RS0VK7S8Vn82p2pVX+B9q8/dmNxSukrhydV6nLvg0kInmFwLTcmb3Nl
 8TaYg3OwZuuw5XiikkQapG7LXUCgxEYYAr/IKVa4hoOGO4rslcFpmYbLf
 8B7+amnAqEaBdS83VPAlU/njcQU5a4t3eAJv0r8PylRlSsmY0UswDNmLj
 DTZUi3fMl13+RpIHE8Dx51uCqH6C4/vETV7IKMpchltvlTwQkCIUFG8D5
 FR5RW1yVTVoEMnuUWTo/F6yzwirTPeHFfU9FIYQ9WIunUTaNU1ZhUqaQS g==;
IronPort-SDR: I73TZ3XwtMlUncnEGhibGKyDGsoR0gimVJ0YgoRbJCMb8hNO0QAT0S3I7gY3297zkbBDcrB4hX
 /bU6Tybj1UPIukDHjppqLzl/SU0J7SIo6/ri+7LUjKdUfEVjUqzmMOQxqINrzFRySN9Ec7aH9H
 trgzO3tcs9BDmbV7CTLSA4NQeYh0jn0+foLMqzuJsbWt2OmJaeO9NY2yOHTTEzQ7lx9hfiyxZT
 URkuUTffnbfxIdaaboscCk3Lk/fScQ2jbqFsVWbAkEK290BI4IS1843vxn7WWykrDE0bhFEWLr
 edQ=
X-IronPort-AV: E=Sophos;i="5.81,249,1610380800"; d="scan'208";a="266510689"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO
 NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
 by ob1.hgst.iphmx.com with ESMTP; 15 Mar 2021 12:10:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ihmm9sUIGqL1hukEJ7s3jsJO54S3kJUAootOE4t5K+jjE788Wgjc/9QzApi1UKja8knZbxGyLNY3YwcjF2pEuPrxdC8VygBRzOKAi9R3zlRywfCcG7oLIYOHwyKoWCu1hMGWkxSnF9e9fNTQvFnvnACRjne0rQNPw6+crYJs+BWO/mrYyadCyUVPRNCWkD3l81s4bTz874AAptNIGXmCg1hAFs6l5TQNje6PGOo1syvrQ/N9L+MkRGO4b31Ykzt+laLk3tZl/CHRRMFvUAveUOO1oKgWgDuoItDqp07hhWG61SS6ZrdYMC5ppsHwFsXgcg/Xx0Xf2ONochTEIdnYyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieqPshS8jlUH7YZqR8nYlPyKrUYD0Dl+QcEDj2dR6vs=;
 b=WDNSdtkxTv+Hjxgwsh+QspiOuggOExxxcEe+c+HBflVCxzd/lvI+zHzApY7oaVb9TDqF26rJuhsT0kLMHXezNPCJBnpJCH2uynhbKY9Dtvya7hoVVlpU6Q6LCykQFQsOUJJUcgX5Cfyd7f+k6vazOX2w/3XeEsNkSewpZgYDVV86pkj5z9qlXOwTM95PHubAESCN3hSrx/MNp5t6VP1aKQYBKNfX1gmfFEvwc7eMycLRWtGmAc3NZXzDUOUQnnnpcewvj4d7MLg7UAzTpc19JXddVRU9g4cQ+5MuAdkrjWqnOMbwbGAZ42ZxtoSX2VSkNnNhJ16w0IFUyDi8L2Vhhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieqPshS8jlUH7YZqR8nYlPyKrUYD0Dl+QcEDj2dR6vs=;
 b=KZZrQQis3dcKkzu8MloLgXKKSTX3aK2aCwgMDs5nMAM7BsmljoKsbdgh4M3gJxvkFo9xH2mP0231gFkzSRgr7EgZtjYZCuwQNvG+jdbPLDHk+jxtT4XXESG2XRjSF8bj/ko/xwG/IRzCR95BCMqCe1ijYf1/CFJwAE10ftQJtiI=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6413.namprd04.prod.outlook.com (2603:10b6:208:1a5::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Mon, 15 Mar
 2021 04:09:54 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 04:09:54 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, "hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>
Subject: Re: [PATCH V12 2/3] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V12 2/3] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXFkZtVLB3m5Kiw0yrvZIx/W7awA==
Date: Mon, 15 Mar 2021 04:09:54 +0000
Message-ID: <BL0PR04MB65148249836C08C94D2A4A15E76C9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210311071530.18680-1-chaitanya.kulkarni@wdc.com>
 <20210311071530.18680-3-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514B749F68EB412FEC032DDE76F9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BYAPR04MB49657E04A5017F5C31D4EFE1866F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BL0PR04MB6514F4EC40A62AB4763560E8E76F9@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BYAPR04MB496561F5A30C4200976B718E866C9@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8e67b03-09ba-4211-9c9b-08d8e7683018
x-ms-traffictypediagnostic: MN2PR04MB6413:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB641307B99F7C5CEE4B45F853E76C9@MN2PR04MB6413.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k3TjdVPkbK0ex0MH8ht9/rzpJeT7AwCcf2urUleGJkMp7cSFyAUGg+V4m+ftS8hDbvqaLlxw/Jsd7DMc/AwAByU13Gg1S6nZFKWllPWNgARmLyvJl8DevORxYUI565VhpnKbvpL+fH1zB4wckIIdunJMFmGFV5jh1hB39IgUiaaZdvkZepPd3g8GLAbENVKEKqpYPnYjbPm5/WA4DFzWOIFbryJ469vsjOe0ZnPFqHHgxwOybitSa/JeAtxAewjnegrJbYJM6vjstePM+apoh3hn+5fL0raEYbQYJgFbe6A0vQu2a6ZqLbHwf7wI0KZlXCsUFLeJyfyMgQo8o/ulBh2RALFaI7FYLg6U4GwgpOHUyJp20YISrMQ8aPDXApvtP4A4mYChNII/mIxBjWVmqB39CbuiL3ea3x2fZT5n1lfRG9TYxvQ/XSpgDi1/DHbPi5dtXmvam2AVqIGr3RB4fQBxG6oC7Cfod6Ud208b0DSmp7TfO7EeZRJ9tzYW3Ooic/t0PNN0tNdmb0TgvSNk9qYgAiqFZBqi7JAWVsXSK0KvqUwk5xUdeGN/3tqDqkH8
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR04MB6514.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(136003)(346002)(396003)(39840400004)(186003)(91956017)(52536014)(66476007)(478600001)(64756008)(53546011)(66556008)(7696005)(66446008)(6506007)(26005)(33656002)(8936002)(110136005)(8676002)(2906002)(4326008)(54906003)(83380400001)(71200400001)(5660300002)(66946007)(9686003)(86362001)(76116006)(316002)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UlYFOZBYUpzIEuWW4gv7v34fRbo7Qg6pHn6aSQ8L5VMfR2v9mI7mosilIPCV?=
 =?us-ascii?Q?tYeP/v2qXP+ctrz+QPIUH3Y/PfYSiP/vL9Il/Zz8nto9z2X07P/xxLznTDFZ?=
 =?us-ascii?Q?1TbDQXG0htENjy/Nhdg9sFP2VVB1mFUG+Dbz1LD9IzwAbW7jkgNFwrwKRw6Q?=
 =?us-ascii?Q?7967QBdp1F1A1If85HkN0fCSOrDQm4lHUGDtFu26IGpA+t1fB54DXciIY3EX?=
 =?us-ascii?Q?aTzvNCMeXVTUYagpdEVMuXR3LP/Q0RWDLBMy98NC6nXizR75K59DMg34M6kS?=
 =?us-ascii?Q?xKPFORpVDxbPeIe/iAAokP3842J0rSoXqSCJa6hkO84OTvuYYHlAUeS6rE4D?=
 =?us-ascii?Q?ThsUREgcDJpEBVvvlKo1IiEs6M1WCWmVAIxUwYDvT8bEBdfGlj3yFqXEvfe9?=
 =?us-ascii?Q?D2EvmIhfUAc/0ioL7av+EERjYbKjlUtAuymt8PUFTtmf1yVpMUr9kpcE42FF?=
 =?us-ascii?Q?ngxcHlglOhHx3EZk+JvBwsIAOHLevp6kVfwJcS9tzhYxNUXcdBGdjWGAy/hN?=
 =?us-ascii?Q?ju4XjSIl+iM4n+1mL3driPpcfowAM+f15N2OYWh/nEvjFMv1WZ+YREheBTWR?=
 =?us-ascii?Q?Ux+US/HRfL/w+IvJnl+dGZ/ddEziDVeyCMB7k/yXJ1dCKSm7ZxMZlziGleHQ?=
 =?us-ascii?Q?lo94eR9m5uu/ftSCHTyt9SD7TcYB3YaJ/E6/G9wWkslKVX390wIupCDtd/+2?=
 =?us-ascii?Q?TS9CtQ2XjDuXVjGddc6Klw2yRyjDyHjYPBageh97aVnolmIOQwiGK8122Fai?=
 =?us-ascii?Q?H2PhVMoxZtbSTaZpV0lralDPugxnbtaHq/GI6azja0zI31fcFHkXH+80j9tK?=
 =?us-ascii?Q?ofPmUjQBTSlojN4KZKhntRDUFAWyeqsD2uegDLQPR0fxN5uTNiG0AX3uWjl/?=
 =?us-ascii?Q?GwHjEiRyLnscbhIyvHLofgT67N0tYVK7OM3HTh0esVekUFPU6zgqAFnxtKbS?=
 =?us-ascii?Q?4gjFFMa2PyiaEtyTCd2PK49xEja4xuDvvipW3cKXiIagLbMobOv2X+6JSEGb?=
 =?us-ascii?Q?Y4w9kPf7fPCee6G9tf7jxwFnGwxF8cRZFyflTWnbSXGihy7MWQLeQtIp8sV7?=
 =?us-ascii?Q?TAUhOVj9+DBiLj2FW55A1HdOz2jEccN8mypxA6Xt5dnS09vkzEV6GOK4Csgu?=
 =?us-ascii?Q?5FEisjCTgUaYLH4+t3CxQkEtX0XKvec2kbJlZqTEGP/JT2pLRrxgNmTUMm/a?=
 =?us-ascii?Q?7LM9VJdL2UfzayA1tqC7+CaxqUzLORCZcxtoH1GNPeCrQ990CTxZE96a80zd?=
 =?us-ascii?Q?4sFqPsVTRS8V5Gnc6aV33yBnFNXz3vyzOjPSBNQm8SUtVHHA/QntPfnM+S3T?=
 =?us-ascii?Q?WMIPnM8uqdHyZ3aQ8zQ2iHkW2c9Un1MH2DYHeCwvzRgYJg=3D=3D?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e67b03-09ba-4211-9c9b-08d8e7683018
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 04:09:54.1364 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVIKQUAmeSSzqUW3pTfFoGuo7IBVoB/lCyyF5LVaRxt11v30dWC0obmf1f+Vyh92/IZbrFhyZqYtcjtFEUjFHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6413
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210315_041051_760212_D1D471B2 
X-CRM114-Status: GOOD (  29.02  )
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

On 2021/03/15 12:54, Chaitanya Kulkarni wrote:
> Christoph/Damien,
> 
> On 3/11/21 23:26, Damien Le Moal wrote:
>>>>> +void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req)
>>>>> +{
>>>>> +	sector_t sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>>>>> +	u32 bufsize = (le32_to_cpu(req->cmd->zmr.numd) + 1) << 2;
>>>>> +	struct nvmet_report_zone_data data = { .ns = req->ns };
>>>>> +	unsigned int nr_zones;
>>>>> +	int reported_zones;
>>>>> +	u16 status;
>>>>> +
>>>>> +	status = nvmet_bdev_zns_checks(req);
>>>>> +	if (status)
>>>>> +		goto out;
>>>>> +
>>>>> +	data.rz = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO);
>>>>> +	if (!data.rz) {
>>>>> +		status = NVME_SC_INTERNAL;
>>>>> +		goto out;
>>>>> +	}
>>>>> +
>>>>> +	nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
>>>>> +			sizeof(struct nvme_zone_descriptor);
>>>>> +	if (!nr_zones) {
>>>>> +		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
>>>>> +		goto out_free_report_zones;
>>>>> +	}
>>>>> +
>>>>> +	reported_zones = blkdev_report_zones(req->ns->bdev, sect, nr_zones,
>>>>> +					     nvmet_bdev_report_zone_cb, &data);
>>>>> +	if (reported_zones < 0) {
>>>>> +		status = NVME_SC_INTERNAL;
>>>>> +		goto out_free_report_zones;
>>>>> +	}
>>>> There is a problem here: the code as is ignores the request reporting option
>>>> field which can lead to an invalid zone report being returned. I think you need
>>>> to modify nvmet_bdev_report_zone_cb() to look at the reporting option field
>>>> passed by the initiator and filter the zone report since blkdev_report_zones()
>>>> does not handle that argument.
>>> The reporting options are set by the host statistically in
>>> nvme_ns_report_zones()
>>> arefrom:-  nvme_ns_report_zones()
>>>          c.zmr.zra = NVME_ZRA_ZONE_REPORT;
>>>          c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
>>>          c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
>>>
>>> All the above values are validated in the nvmet_bdev_zns_checks() helper
>>> called from nvmet_bdev_execute_zone_mgmt_recv() before we allocate the
>>> report zone buffer.
>>>
>>> 1. c.zmr.zra indicates the action which Reports zone descriptor entries
>>>    through the Report Zones data structure.
>>>
>>>    We validate this value is been set to NVME_ZRA_ZONE_REPORT in the
>>>    nvmet_bdev_zns_chceks(). We are calling report zone after checking
>>>    zone receive action it NVME_ZRA_ZONE_REPORT so not filtering is needed
>>>    in the nvmet_bdev_report_zone_cb().
>>>
>>> 2. c.zmr.zrasf indicates the action specific field which is set to
>>>    NVME_ZRASF_ZONE_REPORT_ALL.
>>>
>>>    We validate this value is been set to NVME_ZRASF_ZONE_REPORT_ALL in the
>>>    nvmet_bdev_zns_chceks(). Since host wants all the zones we don't need to
>>>    filter any zone states in the nvmet_bdev_report_zone_cb().
>>>
>>> 3. c.zmr.pr is set to NVME_REPORT_ZONE_PARTIAL which value = 1 i.e value in
>>>    the Report Zone data structure Number of Zones field indicates the
>>> number of
>>>    fully transferred zone descriptors in the data buffer, which we set from
>>>    return value of the blkdev_report_zones() :-
>>>   
>>>
>>>    reported_zones = blkdev_report_zones(req->ns->bdev, sect, nr_zones,
>>> 					     nvmet_bdev_report_zone_cb, &data);
>>> <snip>   data.rz->nr_zones = cpu_to_le64(reported_zones);
>>>
>>>    So no filtering is needed in nvmet_bdev_report_zone_cb() for c.zmr.pr.
>>>
>>> Can you please explain what filtering is missing in the current code ?
>>>
>>> Maybe I'm looking into an old spec.
>> report zones command has the reporting options (ro) field (bits 15:08 of dword
>> 13) where the user can specify the following values:
>>
>> Value Description
>> 0h List all zones.
>> 1h List the zones in the ZSE:Empty state.
>> 2h List the zones in the ZSIO:Implicitly Opened state.
>> 3h List the zones in the ZSEO:Explicitly Opened state.
>> 4h List the zones in the ZSC:Closed state.
>> 5h List the zones in the ZSF:Full state.
>> 6h List the zones in the ZSRO:Read Only state.
>> 7h List the zones in the ZSO:Offline state.
>>
>> to filter the zone report based on zone condition. blkdev_report_zones() will
>> always to a "list all zones", that is, ro == 0h.
>>
>> But on the initiator side, if the client issue a report zones command through an
>> ioctl (passthrough/direct access not suing the block layer BLKREPORTZONES
>> ioctl), it may specify a different value for the ro field. Processing that
>> command using blkdev_report_zones() like you are doing here without any
>> additional filtering will give an incorrect report. Filtering based on the user
>> specified ro field needs to be added in nvmet_bdev_report_zone_cb().
>>
>> The current code here is fine of the initiator/client side uses the block layer
>> and execute all report zones through blkdev_report_zones(). But things will
>> break if the client starts doing passthrough commands using nvme ioctl. No ?
>>
> 
> Regarding the passthru commands support following are the non technical
> issues
> I ran into, it will be great to get some feedback before we proceed :-
> 
> 1. We don't support any passthru commands for the generic NVMeOF target
> backends
>    (file/bdev) for that we have a dedicated passthru target. ZBD backend
> is a
>    generic one, so do we really want to add support for user's NVMe
> passthru
>    commands ?

If it is not supported then fine, no filtering is needed. But you should add a
check on the report zones command received by the target to make sure that the
reporting option field is "report all", and fail the command if any other
reporting option is set since it cannot be honored.

> 
> 2. In past we've decided that for NVMeOF target non I/O commands should
> be handled
>    in the userspace applications to keep the target light.
> 
> I couldn't come up with justification :(.
> 
> There are other features that we may have to implement apart from filtering
> if we want to support NVMe passthru commands e.g. Set Zone Descriptor
> Extension,
> Changed Zone List, AEN Zone Descriptor Changed Notices (Log Identifier
> BFh) etc.
> (these are just placeholder examples, please do not take it literally).
> 


-- 
Damien Le Moal
Western Digital Research

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
