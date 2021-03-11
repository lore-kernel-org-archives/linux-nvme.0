Return-Path: <SRS0=tknV=IJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A8BC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:42:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5DF64FC4
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Mar 2021 05:42:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5DF64FC4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=FphxoHQ2Udo8ulm6wtv7qhilViuFC6YlnFKEcecCfaY=; b=hQ4nqcuJ7W53Am5dCeiIwAOOT
	WCsvDUVf89UKeJaqVzmFtrOddYSHnshwLTfx5J4SbtzJ4ZGRdYYBclS0pAoiEZp82NZDKgD38uyqQ
	EiqIruhqwaGTrZ4fDOcJYFr7q4EHnszQI1iTT/ivggoM2kL7gFqYqXk4d5ViOkcjcY/XosGt8eb7o
	y4lv/NsCN1qnxdablUMfnDrCosxevzWp5MqevWwuzhEmzyffLnHOuehHdcJFg60uWzYGTldyxBmM0
	o8B10N9bRiJtUGcSr68cCdSUM2XD+v3BFtGwAZm6dc6eA8JYuW6P2HoWvIDdlmKzmFh2lXEp6VxZa
	WfqqnXyeQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lKE4z-008PlD-8o; Thu, 11 Mar 2021 05:41:49 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lKE4u-008Pk7-AN
 for linux-nvme@lists.infradead.org; Thu, 11 Mar 2021 05:41:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615441305; x=1646977305;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=gDoKgjTcVkA1yG5B0R5gtwp5+tYfMcQ6QraXyzf50TA=;
 b=BuGHC6cZ/mhrXYK4o1HjuzkTnSjmfcD9vKxzl4MjEwURi3dzOdp9kyFM
 P3IBgSu1W1yqF74w8hXpK2rPZqBTTmsP6I6z9C7rwBZ0AGwowr34siv5l
 xhUy1mm9/cFUJY5lZNTkR0cKgc27VCeHycRDWVMRwgxdoRb8v1qrjOfO0
 2EBZn4n1/U8HBgf5fuzTGH71yv7BrRaMPMMNn4FTKL/A6X04Po7tS96CK
 6IzoupYkBbBwXfmefReslgxhSNDWSQlSn+0VQcCQcZwrlKFFVRwH+2QCa
 Ux9e8A8bgVbQ86v5Z6Fc8drDvLX6+zmrF9KBIq6hlSM/oxlDUU5aQnvWH A==;
IronPort-SDR: HKBZ/rhNxcRQnf1IVk+WG4OxgjJZnHI15F8YFuTFBbHJottX3ODy3JjWj3sEVqpryilCJlRLH6
 SDZekhkHp0dQS5XaGy/tyUC2508WMsn+H3l0r1UgHxC4h+cQvxW34v2ko51yimkFxlsY/OqxQt
 nxcBO0qL6Y+Q8KJip/L08mV/oexfAXfc2NYByN5MKISdX4GlVM5s9TM0s1xd+abjjn4a40jJa6
 qwRI6MaegFOO9oNGjdo1le+4zuASzbYRZuk3vMQeyXJmskDWXP67lX+BESHE+VkgA6goRU3Bdl
 VWo=
X-IronPort-AV: E=Sophos;i="5.81,239,1610380800"; d="scan'208";a="163043949"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
 by ob1.hgst.iphmx.com with ESMTP; 11 Mar 2021 13:41:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oq9BdD8i0KNWtaHi2zdUglFlF/LiYj/zieQPsctJsQiYU9dlJUI87xFDsTcNcmq1ed+OA6Ut8LjN1odWa6ch+sZal4ZX/EQ0WevA4lF6g/xPsKhwAuHJ0mReecph1f0qSly8sjIFsS9f6TH0wKm8LNBnLc6ohN/SU47ES3/LTapKYrrELpi/BBbakGDmfOk8CXTX4Vad2sLoZrSinLRksNA8gI1j/EpnUWYIiShnsYVjg5gv5At3wY1ExRZmvhkp2xdM+dbTO+JWen5XlRSYmGFj83hEwbEnC28ldWkrnR9RxAGckgCiopLI6S4FZKCWQHjx7KpqcN+Dptn6iDD0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAmCrCIEX4rTIp78U52/L3v8za/t1UB0jU9FIV0mQJY=;
 b=WhxLFjGKfxcBgtPWJ9lvNzFxUrx+09lUKmH7sDwnozfytq6VLsvRWij4BN0IdcSTCNY04J63rPrDWJVewW4wnM0SB0XlaF/EmIVfiQsAdkuYdWMknAICVl1pjhCoq4682YPj7vUwJr92k3CZ0w/Hp1C5aQ066Kmrgqva6Jp2ja9XMlJUD3NRoFBAwaeK2amX9hQhutyFcu3dIPamrsmVkXq2huhAoC0pEosXqVpQmmw+hJlIsE56glwbgn2hZ3svxINR69DZdlOmCzPqsS38kbz9ZEXE6a7qNsrtHVf94xdjnl/B8MbbIcksf/Pw6g0U5S20i0H9CXBFgLyrZqw/qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAmCrCIEX4rTIp78U52/L3v8za/t1UB0jU9FIV0mQJY=;
 b=qZ/eWePqwpzjUU6t9TzeIywhhCuIQ+qqFFXY27tCa6qAIuwdIiGkP5p6ewc9Iw3ZdMOQu0miaNFGdYHGQ9yWLV4/z8TF6MX62fr8il4ngKnFtUNiR8P/ZAYqer6mHHpSTLdx7TFC5NRxrXfnW7UdfYwh0ZvE9ALtceothIwznus=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB3960.namprd04.prod.outlook.com (2603:10b6:a02:ac::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 11 Mar
 2021 05:41:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Thu, 11 Mar 2021
 05:41:40 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V11 2/4] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V11 2/4] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHXFjCN9/5a75AcckumC9lPapW+AA==
Date: Thu, 11 Mar 2021 05:41:38 +0000
Message-ID: <BYAPR04MB4965036A68AB5A07EF004F1A86909@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210311043908.26146-1-chaitanya.kulkarni@wdc.com>
 <20210311043908.26146-3-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514B376CCD4EE404050E1D1E7909@BL0PR04MB6514.namprd04.prod.outlook.com>
 <BYAPR04MB49656EEBF4AA66D1B4F4596686909@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BL0PR04MB65140897830F157825CE72CCE7909@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc5025ea-a436-4662-cad3-08d8e450588d
x-ms-traffictypediagnostic: BYAPR04MB3960:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB39606426010D15074B5C594C86909@BYAPR04MB3960.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Cnssv80wwcPvSujKRkntl3ZiVNjotkINkgDCtaLrqhiIodoj86yWiF1LLS+/9axdfN4B+GvArMCTaX0mbZ+ZauZGjfVulBWJRgrC2XLqKAqharSd+Kwk82WjxxZhGudfz2+egR9WS+eXWGGz5rHZxcjkPEP6ei5B7NqaSRKWBldfkeCt8QZJeQLroAK2YGbKie8BLVSM0MqsZGdpqcd4q44kt6Z7vbpOzqfdq/ZAZ2xswzDxxFG/HsjDb8GqaoAjoDY2LN8XcfxFG52FQXiu+HQ58cpkML62a/eGFfuNRPCGsrQN9RY8Y/mo7dvS228aHbEjvK1bNxemmphpzAaAVT/cE7UqG1ow4YduYuDWPSv/+4khzsTMZA22EK8ro93MiyD0UP27vpVYBx+GEPvA0ZrNeHyytFkofxn+7HTYSkmAhVPumweZ1vBy5OksLTgtqgTeTkRmZtV+h6kiJTP77aJIL6Vles7ZvaI8GmHNlAlp62qN+c89U3KRvB58o1rp+PGYMvT0NK3091kBuj7ug==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(64756008)(53546011)(478600001)(110136005)(4744005)(52536014)(4326008)(316002)(7696005)(8936002)(55016002)(86362001)(186003)(9686003)(26005)(2906002)(71200400001)(66556008)(66946007)(6506007)(91956017)(33656002)(8676002)(5660300002)(66446008)(66476007)(76116006)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?V4h05HQ8CTR2JpTaqayCyhl6vpNrLFegIxLq+t91dT0aPx7Rxp6Q4UQA21hU?=
 =?us-ascii?Q?6xGiD9PieP1aIg9rl0Ck++1nNrZH86GWw9zVsYbKlg2ZqU+2GuHTSX3fEahq?=
 =?us-ascii?Q?2z2vjf1N29UVjDTJcmSPw8jVnFAcFEZS+YOussbeR0raqO/rq9+EwgfHGGWm?=
 =?us-ascii?Q?pUJHNXG6MLq5Go/NHtBzx5X2iZXIjVuPLn4Xj4/WnCItkWVF3fG6rQUCm1qC?=
 =?us-ascii?Q?VSD+rSMpYrexsrFFNfiYTUkwfFm4rYcyHWEh6c0lp5e6d/1d9rdKUdBwQqq2?=
 =?us-ascii?Q?7B7MfEnIeUqhKqhyvxAxDpCv/BKBoeZ/VeqMGY5jAo40XxX6/2VcJsIjeJ1Y?=
 =?us-ascii?Q?QAc3qVPU7T6a4OYeRBExa84IVKK2enpn8kJ0qhxY0anwtn3mwAIQKCuqLg0i?=
 =?us-ascii?Q?wzlkPtrnvmkH7ke4n7Ku8bxl8CgUZe/UtXDU7VCb4lHXdk5eftjSegC+eVPc?=
 =?us-ascii?Q?UdDyQUTUttxfb81n9fGxfV9o13BM4QTRxvhFoA2pUbxzOUSv06S43pxdTWJS?=
 =?us-ascii?Q?cJT2AyYc88FBpul5WNkpPB6MQolm4DQwkgq7AIVQWx13IAQHeN0hiUhBonKE?=
 =?us-ascii?Q?cfOprmXexZMs5FUvI/OHhacaZ8qQbEcifJCYN7Bm7feo6ZSBwCaKrvOi1bxl?=
 =?us-ascii?Q?s22T4GyiWwzXa3bUNQvh6blrjN7TP6XuSgSjcvN0ZCN9piY0l6Fc1AKT8DO7?=
 =?us-ascii?Q?k3HI9JMB57RLbvQxgjA3n0pvOhWDAGTeDFx2R28ACQJrqA8FehFLmCdShZsd?=
 =?us-ascii?Q?Cns0R+7XCA4Spn5Q+VE8gXkU6Dg9lmYr41fqphxsr7WtvUX4yuZw/Bp5udDO?=
 =?us-ascii?Q?uz9L9GxcQvvBrY6U0HTsGAMVlT5dADHkmMutp4GYCZq0f1vUkRoMfbRCA+yS?=
 =?us-ascii?Q?b/+1VZR1zO+qiAreJN/pzRMjZEWkS97kMfWD9kUO30lWJj1XEFrkOGTuUutd?=
 =?us-ascii?Q?CGAGgVo/q67mSyAW+cHG6kJ+DmbdPvsyhrQU8JoRA9MjBi4DjThtqjLJbCT8?=
 =?us-ascii?Q?ogdLO7dc54IMjEBLhDwVPR+9EEeT5PKZPy4DWZrkr2vBeUvqiA8wcbrAMiGL?=
 =?us-ascii?Q?F0EfGJEn7NVEDHk1jfqHSAwLE1TFplDSYdW23XG+AO9GzxD7ERacnA+KVtUk?=
 =?us-ascii?Q?1Ked/s1wSR7PrsLACMkM7vQLiiZtMvKulnc+04zgiJDZWprO0/mq1AChZ0W9?=
 =?us-ascii?Q?hRGRz10xx3ahhfXdi8IpMYWUQKC6daxAHJqsav1TivBnTDg8VcWKCDJrWkWQ?=
 =?us-ascii?Q?A7z9JF+OoFlRooxelVbsnejOPwVjxS8X/kuD2XZDEy6+oo1HwzgSiD6CfnvE?=
 =?us-ascii?Q?cX1is52XKTZ5NAiMwgUdxgiN?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5025ea-a436-4662-cad3-08d8e450588d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 05:41:38.3373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cxHLoK2YnAWg04CFJdmo/Sx+0FgyrwrjocOOP0b+PFGmCYLyPPOKTn+YjfmbFEqpRnOrjKqvHDqVsbg51VF6DNKRXq/K0HQWlNSVuBsG18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3960
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210311_054144_680104_9EC8819D 
X-CRM114-Status: GOOD (  12.79  )
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

On 3/10/21 21:39, Damien Le Moal wrote:
>>>> +	nr_zones = (bufsize - sizeof(struct nvme_zone_report)) /
>>>> +			sizeof(struct nvme_zone_descriptor);
>>> What if nr_zones is 0 ? This should be failed.
>> blkdev_report_zones() already handles that check. I thinkthe error condition
>> below blkdev_report_zones() should include<= 0 case instead of just <.
> Reporting 0 zones with a valid buffer size (nr_zones > 0) is a valid reply, not
> an error. This can happen depending on reporting options. Even though
> blkdev_report_zones() does not allow reporting options, it would be strange to
> fail empty reports.
>

I see, will add the check before calling the blkdev_report_zones() for
nr_zones == 0.

Thanks for the clarification.




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
