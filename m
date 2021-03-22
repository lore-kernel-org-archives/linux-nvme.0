Return-Path: <SRS0=yO6k=IU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C83CC433C1
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 19:40:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A012A61934
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 19:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A012A61934
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=cjKX0VKNatq801LhXW0bSjf7Rozu1OfLZhiw1oWxBXU=; b=GiwTRQGX3bg3rraU5mHMVyyR+
	YVB76izLt5KHUkUHwqrjG256EYnUWqB/EuD3jcHXAYh9b7f3QcNZsCnJoAo/IQ5Wei14DQYMr/biu
	1lWjxojACv4zi3ymXFjM9oma81zezajk0A686SH6Y88QIUj+VenB5Dd4lhbiW24JT6L9Eg0x0N+M1
	6bcTwM4MbLauaCMawuVCI1nngLHZCauzPBd72ne2ZQNrzNQTboe7As+zeIWQhxs0uek3F7b5kckux
	ZMWgJGQ5r3J9+3RE1jQ+PdtoANLSOVwrmyIs3KNBQbGFAOr3wqMiMjy5E5DMvB54JZxNtJBaF5PGJ
	iFM71/+mg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOQPW-00CReD-FH; Mon, 22 Mar 2021 19:40:22 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOQPR-00CRdT-Dp
 for linux-nvme@lists.infradead.org; Mon, 22 Mar 2021 19:40:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1616442017; x=1647978017;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=xUphTMUZUCaMCQima6TJAtpXAR4iHZ0lEL2iohmApYo=;
 b=SLk8REZNtUas5+ZfEmgFT98VaA5jV0bkroNcj15ybmnPfyV7AY5aQfE3
 F5WDxw5QcrlWCjaEMZW4z+UCwMjbyDa4kTQ/ViIehNW7MigsJ+xe8xAy7
 IqFHGy5Qr4T2tussdMa1LzErklKtdVesGiY+e0UjYGq6k/8ArL+hdba1t
 8ctvPTw3/GL85fyTvM0EjaL+MRcmQ4Aj/aOtOD7NNPHHM0ujCdgnOkkad
 BY10PUC75o8xQ9MCA6U5RFMflZ6ahPxAKGzylc1Nhf0VZxz1weg4EnNxl
 Uh2lO7FL1FZZZ+jybLmsWk+uYv03m4/TGjuoKa2trrzFyFHJLWF4WXWt6 g==;
IronPort-SDR: OmNCA9mt0OADbm+/p8TT280a7yfG3JNOjoOb+BpQufi68HcT7dgc/aiBZchMV6SdG+F/pjpgT1
 fmNTPgJHUhgXcx1KekAeFL6sqsO74OHA6yTJaHwlR1mKtUzaGEiLarU1PrjBbCf1xCMubmT5P3
 tHA59Sr4hdMpKtqEGA48iPIZGrUO85idjtwQhwTCLWPcXTsbDEgBDq/cx8D7lJysGL4TGZcfu0
 RlS3ZcmQwdJj00hC34+CjoyvrNOjqUhu537VzxzwUcZ2VutkQnSKf15FxXxzjulc//NGdFXkVd
 Bbg=
X-IronPort-AV: E=Sophos;i="5.81,269,1610380800"; d="scan'208";a="162685766"
Received: from mail-bl2nam02lp2058.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.58])
 by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2021 03:40:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh7GJjKDqK0KWgVHcLEqNlzFIk67aJ/bH18tNLetHSCQVIUO2kSZyGUY1C3anLhU+9Vcxt9DiycLUYiEKThUOZ0gR2W1QccKr99BSt80rVyJVLZ6AvWeU0+FfYcIyeGG7YZoNmm7kIMVVaADnYBLM+jSWI/em90+5Y705WqW96voRJTZT7W0Iflgf+RcDmn5aYn9tm4VILU5fZrM4yGX/97YCOsMZkDNWw5DPMHrqYj31s8BgmIpfEEcZWfOQhsB+wxdpsMk6O6Z2pmnIY/hvGXkQiitwpm6TdJgol01cNtRtwVf5RRgoTdfBh0yISsPZ68m7OrnafYdTTXcbnDYUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUphTMUZUCaMCQima6TJAtpXAR4iHZ0lEL2iohmApYo=;
 b=dGnQ+OX9OKh97+s7/kMEFieMCvRA/9188aQvognqHRq/1bSLTpe02OzpZ6iXVaxQvPZHXZmZ+y/z0D3a0GgPYyyHQnw7LCSR3S9uJVhfq5wPwyLvLjdy3dWELTzyFRLTd+rxF+SFBo6f4vc9r2nQXi461gRom/MKn1uXEyUIEVWREGdeZkLCN60ATqhTcR8cl8QOPlPsUNbAPKmRv9+QAkv7OThDNPfXu5llYoHIbbiRhUzrAZjqvx0iFC05WnFqlCv0HMvkROALy4MSFw7Q54aIdKxGcy5pKmdhkuPkcGTvUSqgf2x8RJRRoi2FYzOMq1PUp/QxtMnifJNNmqhX/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUphTMUZUCaMCQima6TJAtpXAR4iHZ0lEL2iohmApYo=;
 b=t7R7ElPI5qWiSxG57hKsi5uP5vduVfzvEPtgfG5o0aVCh9s1rosdDKZ2gxELiiNAj2vXjJh6TOR3DXMBBpIRowR5TLk5lZih+04jsMaoepbobUtLuAr+lAHE8KvE1z2e+gPj673CmT5XLgYKLO270M0AYi615av9mg0QdFyOqoI=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4869.namprd04.prod.outlook.com (2603:10b6:a03:41::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 22 Mar
 2021 19:40:11 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3955.027; Mon, 22 Mar 2021
 19:40:11 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: James Smart <jsmart2021@gmail.com>, "amit.engel@dell.com"
 <amit.engel@dell.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "james.smart@broadcom.com"
 <james.smart@broadcom.com>
Subject: Re: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Topic: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
Thread-Index: AQHXH06tqYHC8w0QLUOi6S5SvvpPqg==
Date: Mon, 22 Mar 2021 19:40:11 +0000
Message-ID: <BYAPR04MB496554229749E7A8D45EE8A286659@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210322185945.10364-1-amit.engel@dell.com>
 <BYAPR04MB496537278CC338FBE8066FFA86659@BYAPR04MB4965.namprd04.prod.outlook.com>
 <c553296f-cd43-56b6-1088-5b4eee5a8736@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79363c83-cd7a-43ce-dd57-08d8ed6a4eac
x-ms-traffictypediagnostic: BYAPR04MB4869:
x-microsoft-antispam-prvs: <BYAPR04MB486914E1C664245F9823732A86659@BYAPR04MB4869.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oFcGpUFD+53tXac8NvrJmmYlmKZge9YM6pE+dxh9vys+uv+Be1bPTYOQ64RNY2v5ZMy2xQoGO3a9YfqnCzb5MY1fn6UcmAUdbw7ySAOY0zVRsAeLV8JdckWckCTwlN8PsAmuUZKJ7b2mAfihxOHAsED8BCue8pYF4u9oP53rVNqXb7PT9fvXEeBhpk5iL3Zdr6af5ANDS0wDPq+WoBG7y4OMABlCc22rq8mXWvgfvajVC32kO6xQdkXCwzbxhvlafjri7+hQwu7Lr9KbrCzuUApJpkorWJyxyjv8m3wTTWPIWc+SsjwQKYwEu50qu2GOZCkQ+mt/E02Mxeza8r3QzYLq4fAQNdg8upQGPm9cB3Xm9/0XGU7EVNoQeNdZbv2pCr2LJKjEhxJZbHwmv83sGugh9fuDEXZcHQsxDzGkftzRfQTzoRgF8Y5I1U1RikA7alQlhXVqdpLgBMHDM+I7xyMk2Fe54QPj/+tOCicz4+MUsoS+KZEVYnm1WOHzEFal+sbgVlen422vofYuRMrTuTVC2dp/+JHFP6YHElAagMH/GDMhA+sDf7t5jawzKOILxKju5aw8cSWzd3Wxf+MYsKFCr20LgrDaZwXqSl1gT3N835FDRvk5xl21Z5Vtm5fMAwvuJ5I61F6AfMcK7qJGYJcCpxzh0zIAgO6BTxlPSvs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(8676002)(71200400001)(8936002)(186003)(110136005)(86362001)(478600001)(33656002)(55016002)(26005)(66946007)(66446008)(52536014)(558084003)(2906002)(66476007)(66556008)(316002)(64756008)(76116006)(5660300002)(91956017)(53546011)(7696005)(9686003)(38100700001)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kTJIUlW4vooOJ2vmZOuLgPeaUvXSfJl5UpMc8Fy3wo1A/AYK2a6Xpwb0kp0Q?=
 =?us-ascii?Q?SfnuPpKfwqgA+4iYX+g52Abo/z5lGkniOXx3yflQQMU7i/C02K1FfTE3nDo0?=
 =?us-ascii?Q?qJPcYHt8lUSQjbz9EYz5kFbTZ7DGDCUCLeQATsPV7dk1326IcjQAN9pmtUYm?=
 =?us-ascii?Q?mcGbor8IXVy9B0PRgH4AAo4GRJwHTXgkTtbv6Njk97vYOM9xHZG3C0r9nm2d?=
 =?us-ascii?Q?Vs6VUOuNqQjis2KnMMgAYAnyi4Y6oGf42HVZC5xfSgQmTrDRG+oofdNtEMWU?=
 =?us-ascii?Q?EK2bZYAqQGR44kQyoXUJyUOPR7BmDPBv3lbz0TLWkII1SvTODpmHAXfHdBzD?=
 =?us-ascii?Q?sV+kIPD/3n9aY/vqjqfQJu0kQzn11qgSB7hQvfqnEhb/x0vUMKKv2/Xh1V/0?=
 =?us-ascii?Q?LmtKkzyeXJFoo83/k2V4eYy5ZS80IN4bXOcRXLOve3/+QUI+Rg4/SDgThxlC?=
 =?us-ascii?Q?qDB7IbPCZdbsY6O/l2vJ4qdOUTyT1neHmqfcR/mIs0lSj9xFDjlVmkpFlY5W?=
 =?us-ascii?Q?us5D0BLHv4RcZTSjBCbY/6rbqjLLMT9Ybzb9ew6PIaH6dcHY3Iu1Jk4VnEzQ?=
 =?us-ascii?Q?EdPm69WKjCtv/krv8EJKoGahvX3krm3NPt4SfZK6hi73IMEYX/Qh9qzM3y50?=
 =?us-ascii?Q?Aoj/4tEWFiFSaYZhoJy0MEG1ZME53mxGRRvgTEuWCmO0i/xAd/BHz3ZVamig?=
 =?us-ascii?Q?LX5ptiJB6EnH7Ndmu7RzeLpnO7TD4p3JrwBbbr9xiHoplNF+ull3/YFOZw5K?=
 =?us-ascii?Q?WODy886nhVWztbjEc5yQYDYkb3XgcWxckbZAZJhXRqvwgIpK1AZNDW6Rxcs4?=
 =?us-ascii?Q?xJs8u7Evatl46zGri4K1ly/Yt4JDrZSO0pKJChQuzZxXpR0zg41cshJvQHAq?=
 =?us-ascii?Q?zEiGn5EKXQIIxtnFfuMZ7s47v15xKN80esq29j6+UU3A+GYCB96HwMmvRRff?=
 =?us-ascii?Q?3kEsD8DJ7YqKQmJnDzh6qlt1o5K+rtn+DKivjgVqtPudW9SBNnzYxT79iblQ?=
 =?us-ascii?Q?iZYH0zXILra3iM0JBpjkc+0xTFlEmS1QZLHUMbpZXicIGZr980SEGiMO1tV+?=
 =?us-ascii?Q?XbQWyHzBTOOk0kH5UGFeF65IyyXgdFk93JXBjB9UyRq3+B9Aec8HbmlpiaPd?=
 =?us-ascii?Q?U4+1wpdbVMEuv5KzNQM13MxPzgX6BW1EIrMOyk/U3/oFIGWd5gjfuCdnUvL0?=
 =?us-ascii?Q?BCWhUUxrP0n9fyorISsx8xMKcJQXMwFytJlxbTdNoiwbNOnlfVK2G/g4d+Rp?=
 =?us-ascii?Q?lX20lqGmTqJMi7UseLQePmd9urAXb9jY6bvqq8COHlkVJz41J5MEwO1inu6T?=
 =?us-ascii?Q?65mCwNRgoXwr6PvZAlgF/qWk?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79363c83-cd7a-43ce-dd57-08d8ed6a4eac
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2021 19:40:11.4343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VBHOldRMteqdxxKRUDRPDYvfxe3O1z9hDUOml4n05TfjK0x5aee15f3YA8WzypczWsY++A2rzmJA3pvKHJG3JoVinXIi4LGIxNmj3PLqrJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4869
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210322_194018_333779_59ED4CCB 
X-CRM114-Status: UNSURE (   8.14  )
X-CRM114-Notice: Please train this message.
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

On 3/22/21 12:37, James Smart wrote:
>> Same comment about return () here.
>>
>>
> nothing wrong here....
>
> -- james
>
>

Wrong comment plesae ignore.




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
