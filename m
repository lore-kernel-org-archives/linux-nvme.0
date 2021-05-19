Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C1EC433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 21:13:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA9B61006
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 21:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA9B61006
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=3WxcKR8O0kiyupyd2l3K2sipfBKQDh2kr2HoOrgc9XI=; b=rQU34ZBVphIfy4hcvM2HoZ9nT
	yEysRCNqkX/OTyAvN6BIziGs9+y7QSlgKwPNRoEGtf8h7rU504Y5zvEineE1//P3lqc7iLc/qt4jD
	v3nZN0toKFtpylI/znoN0us/EvmPGs0c6xsM+iopcmYOsgDpPEqB8ZK0qANw92kxCOimFUNcfcMQ2
	9IxyiS5vklleNatxlljaztlLb2+D54JwIpFlvTUAMOdI1KXKR370YpbgPdwHRSAy8TZezAwGP3lvv
	E5YYZNFR/rXFffDde6+DwpeYp3GpOT1p6uzit7ev1fcmR33hxB690KDQ+6hv600fyUG/EPuF4yB24
	yhci0PnIg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljTUq-0057rf-AW; Wed, 19 May 2021 21:12:52 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljTUm-0057rB-A8
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 21:12:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=T+Vo3Qd44arVltFIxI3I6JI8+6Ijd30vMknG4+s1kQc=; b=nF8CgW69MpKgYfRXGnvEaeDYDH
 ogqblzp8tencjpx/CxOMaiX8rJeqqavDXDWz6G3LOdUr2/V/6e0bsUmaPzH/nLL7ISa3I78xLooQI
 Nz6Qgm5r9ZQJimRLPRn2c3vRZSvQ9dG/02V+zBDv35BzSy2GU9DhMmG6Mzqg+FZWxyCfoV8CZVN4a
 53Ti5r11jLkseqkaqCeixB6u5YhgWGvzsgaSWZMFhpJxjRV0Amrx76eb39rCntZkLVgeH1ZjXNARR
 ru7GcF01lx6BPkxyKKJYKGYg7IfXbbk4ITVAgQyW91BWin9bFOIkFCwAAWT4k4/BTvA3xIRfcVHbY
 byM5l//w==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljTUj-00FnEZ-TB
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 21:12:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621458765; x=1652994765;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=T+Vo3Qd44arVltFIxI3I6JI8+6Ijd30vMknG4+s1kQc=;
 b=oDSFPkxjy0MVUYK5GrryuEHSTw4tZCl5ugFhutjmSZDH7ptUi/y/ssrO
 wWFGScjrFKCYi/PIkgNU5HFgoUCKPwrYJKtUSuVUj9LvQElKmU1gTtm0n
 CCH7qGZB53PbG9ohIUlnMmU8Fc7P5WFQ4hUEh1lLhY0fzQoBHBQbNCa79
 LWWRLTMMkAJxG3w1u2EkmnZ6tuxWOEmBkew8GRIFoRnGcMYqxeMGz8Z0/
 hpH2eazgeUVlvoxt7GxZ8afqs/6W2gDtXk1hp9clxhfLNkraX+QLSiYAK
 PBspj50Y8zE6/74v7smlFPte8utuT6ZRCjBhOaY2c9KFRPRcE2zboTOlo A==;
IronPort-SDR: vaeCX1nKugpi+9fJdb79l+EjFr/2AhwU46Bsx+wQkj6hgWgTAQ96+Tspd1Aoefo/mkqQxMhdgd
 gTS5ZIRwFJDfnuNxCtMDqkTUIQ9PFtCkzdip/KSEj0CZL7+VWoTO2t51OZjODtSqVin63yHrcL
 7aAjXhNXm3khKOasR8rr7e1Z7IOHth6W5ivRcOqdlRxvYfX/0wwYwxzUYTc6TqvkAn/gaj32nG
 FEA0HK+rcSJCetf4FbQLXwpFVbpBx3qglAUxRO4qfBsD6RtgjyeUzjGHtUdCtdm6ajABuapcd9
 bz8=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; d="scan'208";a="279997698"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
 by ob1.hgst.iphmx.com with ESMTP; 20 May 2021 05:12:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwnx8AmAE++388oxYQXBJLnvP1y8ECTO1jo6o1O+yevkYZEh58AAgpDJx4VDCKqEmJpZBbXbk4wATTLjxjJ2hf3P4Rsd3nIcFPgHB4LyVqE/zXBnSpruf4kfZNcXoC/q5Hr6B2qoRLZTJJhKW+ftDv+Hm5jL2Nq9K1uHttR4MMJym7QXxhFxT4SAiZFLrE/81h+u7OeXG7Su7aKc4NodLEoa5pe6skJRZVfHFW1GvUldwQag0WrEy0NHqe6HGqYxuaP2VAz36WNcdxjN8nLiJXs1YecBIvgy+1osxGk7cQSODsAKToqRKwNZTG5faA9iIvc1cGpAsg9L3JZ5vLeg0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+Vo3Qd44arVltFIxI3I6JI8+6Ijd30vMknG4+s1kQc=;
 b=mAHKo5sIImypwucHWZThex9y3Le1KKE7BaCQ3zTyhVerh/xDY4M70UTfY6g8km2zKB8T1vIEQC2J61Vd3gw+0qu0hjQSAaV00ZQ0SgwLZ3nD216bLC0xa/Vb1vWSJaJr5/ViWms1+IuZLEKyS2JyfW0Y+Wj8zEgKNON2qoAHEt6LMeWj8V8RGN8hhxYem82shPWme8n55oF9k/CqpQDV1LoACs/s4N8KeznBjDgb+aQYcXlgMnk3TPpsF2DXtmxeZlIDhbFcNmFw4wvIihhhWf2dqC5Ttw+IwR55G93p+UdK8V845uGqm8U6OdLHfNVcb1Ji8SkFt7pD0DSZzMRagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+Vo3Qd44arVltFIxI3I6JI8+6Ijd30vMknG4+s1kQc=;
 b=HXe2yYYx5tvTPY7dyNFxcGnHSbGZlYGpwSjB3eAIClcn6zIHiJQ0bMaN5IQ1hUmPHjrrnfEjj74Iuhct+XHmBXqQNJh2NyD+aLIys0BS6c9/ij1KB8r/5KgsoHRu3pxUwZvjuJGZbGMBWV59xbYv1NtORz7Od40LsZPsnumC+Js=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4871.namprd04.prod.outlook.com (2603:10b6:a03:4e::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 21:12:42 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 21:12:42 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>
CC: Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v2 2/4] nvme-pci: limit maximum queue depth to 4095
Thread-Topic: [PATCH v2 2/4] nvme-pci: limit maximum queue depth to 4095
Thread-Index: AQHXTNewXoasPiIJ50ajCpYmCnQXIw==
Date: Wed, 19 May 2021 21:12:42 +0000
Message-ID: <BYAPR04MB4965F6F866F4864BE3CD95F2862B9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210519174340.1144806-1-sagi@grimberg.me>
 <20210519174340.1144806-3-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31cfe9da-df5f-4687-b7e5-08d91b0ad76d
x-ms-traffictypediagnostic: BYAPR04MB4871:
x-microsoft-antispam-prvs: <BYAPR04MB48717BF3F6A145E8EFBFA3C4862B9@BYAPR04MB4871.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4kAdoTaGiS4XkIAcucz70lH5lasHtW+hYQkoqZnzR9b5bTqcBFbZ9jBj6PGwB7cWCRvx4BsQ9HRW4lZR5KCZK75O5VV5ZjHp6DAZqr5TEaVLpst2EKtYe9z17dTfLiPAUVrVLhj5hGCb0MuHL9Ci8fU/NWdPyUpT+uDQPaekZpQY2xpvv604JN9N/I5MMrhICmI9xIul689EiivDegsEcMHU03soDcWXQhFDO5itYC4EbRCV3DXClIbXJwVNiOI3iLoSzvkvj93KZ1QxwVoQ4XZm/M4jx6kqhpJBgroUiArSEsuFpUP1UXPpi+K83y7T41sBul5CGD0IAX/zGm67PQ3LXTsiKJperIy1yIshHk2SeuPNEMa/wYK+xp6+W+PT06UL1FVSCDoFhoCfuD9tGXvi5wq5VoGLrOQYHEVWndWv7V4I5C+fYOIK8d5P8LReL4OSs1T0SgahqJ29Nda1faLUN3AtfkLvsfk647qPx4332+WZK7XmVjGSoNZc6KtVrGPLXa5hTXUXY7NnVcJDyNKd9d+0FQzaoSw2vsg52nROCpuhPY8vUQNFHdCX3ppwA+KGseYpVqDaAtcWwWHT0vd1KiTI6V31/8q7jWfURQI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(83380400001)(6506007)(71200400001)(7696005)(4326008)(8936002)(66946007)(26005)(122000001)(53546011)(33656002)(66556008)(66446008)(76116006)(478600001)(66476007)(55016002)(64756008)(186003)(9686003)(316002)(86362001)(5660300002)(110136005)(52536014)(38100700002)(8676002)(2906002)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xCbUv14Nc03OF5qz05T4h6jHCQMgmZpnCcdOyEuihxr5gCGwZ8+13IiYnpQH?=
 =?us-ascii?Q?icYU8+7HrLroLHZqVPwgvcWZVxqaqVfUXa6Nj4+EjDg/J1522iq40hqicFOh?=
 =?us-ascii?Q?xR9lFt7JUy9n/5k9M1WBk7hv3kvdeHM0BcsxxeVpCWU+2G2pYGEt6u2/BW+l?=
 =?us-ascii?Q?W/YUZ0DS6wao6VC5Fu8mI/ckzFoaimsQV6P2IuQDCI9lcXKlbktqauJ1Gf6w?=
 =?us-ascii?Q?0bXdn2U58Kaeq1fvCgz7OGLH32/cAM8ylNe/ifmwuTZ/GlCJnfmbiXj0oWl5?=
 =?us-ascii?Q?0oTE+mrTTkjVlbgoVdDaYM8NRiMBk6l+epNmAh8oDm3QfMdlWYqaAGxSI6H+?=
 =?us-ascii?Q?nQ2m4wqoFyEZzoBlQWn2dNLoAt8bXjppVbbprcYk0dxJolkDEOziVAek9OEK?=
 =?us-ascii?Q?GrDX4cO3gM/1SMYUuGi5scoy/yZkH/dWp9TfVY2EpSEoCfkqzpBJ4XyExvnI?=
 =?us-ascii?Q?gu1oGUiM3c0SEgrujylUnzvKBLeAr0n7rUUH3ZNrDekJeoBLDua4CSDV50kT?=
 =?us-ascii?Q?siLOEAGC4kqf+j7Dyalttt5es494O6CwTXOBwloliyebQC9RWLbKJ2sxwhVf?=
 =?us-ascii?Q?Cf3cExL8hgkJYYDyrFoUfaQ4LKayj6E+lel8hkv9JSOq2vth7EdIStKtvXZ6?=
 =?us-ascii?Q?5HCCLjJg3i+mVuO0tOBENeew9jg1JhJxkG5USvc6DyCdh4iHScuYaOtC+d7O?=
 =?us-ascii?Q?MqH258ICKZHZ50T540Ugl3lAHa5IG95J8KkLIk/XOVcqDR5LDt9rvYDJJmyO?=
 =?us-ascii?Q?nXuGJC/xlRAn8P/sm3AKouJgGPCK6agr6OIhKAAq/Q0meEfilvTNDRfXrUqQ?=
 =?us-ascii?Q?+ImGnntRpNeAtR6tX6mP6evIFBou4StpgwaYsKmfGvI8TbO9Df+NHa/qOIix?=
 =?us-ascii?Q?Foe77yuY8ynTWO5OENxtchy6EfFzjpE/ysrD/nPrqp5dtL1jmywj4BPHBizj?=
 =?us-ascii?Q?3YsoSPNcr6gueIFylAXNXoLDWhpPoNkcSZJv/UJOwLnA1n2nh2e4cBw/aghE?=
 =?us-ascii?Q?o9ZGEUfdEIYbVPcthPG2E1S/A46Wb3OqEldgmfmCZS3CiNoJQrHDqDEFvTCi?=
 =?us-ascii?Q?qnwOVyFg4OGXxQ8zC1AkRzvswjEmwG/QI3yNIiAQZDAudwvG+SMQexZSVAnH?=
 =?us-ascii?Q?QFQm8mEuDLKKsnC6NOxgRN57NNc3+UabqakLlEdaiRnL5W/45jp079Lqn/f8?=
 =?us-ascii?Q?a3XpNiSCSolEVTdAgCipwu68pS8Dhj69MGOjqAhhZvfesqU0NrH2KqeAcDZ7?=
 =?us-ascii?Q?bkecZLsyKAbKUq2bRlWNmhFJfpMbZrr7IV3vXIDQNCXpO7O1/6li9qgrtsbs?=
 =?us-ascii?Q?cQeget/p+Kbhd2U5FjUV8c5e?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cfe9da-df5f-4687-b7e5-08d91b0ad76d
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 21:12:42.6181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixjaaQlKY0g0PWIFHLtwg+0FgHgWYHj/rdvwyV8XiW839oOt2XyRm6YNv6j7CI77IzvwJbXnkuxBkH0EUshwj1ljvP1cm7tqIWArnJhBktI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4871
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210519_141245_974579_EC15F447 
X-CRM114-Status: GOOD (  12.19  )
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

On 5/19/21 10:52, Sagi Grimberg wrote:
> We are going to use the upper 4-bits of the command_id for a generation
> counter, so enforce the new queue depth upper limit. As we enforce
> both min and max queue depth, use param_set_uint_minmax istead of
> open coding it.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>


Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
