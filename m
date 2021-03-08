Return-Path: <SRS0=2ZV3=IG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6853AC433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:21:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CA9E6516B
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Mar 2021 07:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CA9E6516B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=1R+ZnNlQ/GPDSnohjdS8el2NnFKlttccpawccx50YwQ=; b=AVfGMjBv2WOBfhKeG0BxU7iEE
	pP4ArSzPGlS8hSte99ynYKkakn0r5KALducMZXA/1K8j20/ekG4Q8E71rRHZ0GXXPI7DSbgSe7igJ
	ZEwcOr4wL2821eiTBGICQJGBqBS2QrFm3WFs/xf4XJ07X9PlCETQCQBFxBpLApdx5KhisIRPtI1wx
	cEBV/ah3UcBR/K4v3Iy0QZhlTCN/YMgEL6SfNja8pOVQPPxIdA6DCFsjfs5Y99NiDsPpuqS8pJ1n+
	YB3wJvs6RrtlwqMhH6jNJRsTj6hE6yKwIzMv6ay/ToNOuEhefnVIy6EjZY8EuUxNfo6FrfyaG6Cp8
	H4yWX2YNg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJACi-00Fhey-Bd; Mon, 08 Mar 2021 07:21:24 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJA6i-00Ffy3-GZ
 for linux-nvme@lists.infradead.org; Mon, 08 Mar 2021 07:15:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615187712; x=1646723712;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=EHm6d3pCT5slmtFdKzRPCTo6RGQbYkuEtYgQQ5Sib/4=;
 b=GxvpnFkppeHwYJOAy5Z5jDnutyenX4VWFGeQlCaY51rmlr8DSnj5zqTZ
 LeDEyEELWVccRHT3U2r7/TYMMnTlnjEF3ugNb012ctjnhKQYqLCdK9FzO
 QcZS2umJWRj7CsW9D9nslFr7ZIvf3VhIVwhQdzwNCYjyvQ7zcN3Nd5OOI
 uWf6uKGkIXcD+TZxCKBwt8CoQuy0K3WoGvr9aQwCD5UYVeeZzVPjiDORo
 ndggJnq6ZVXEby8mvFST/8uNskyG1f0nsaKG1QUF2WtjmnfRnwzCj15IQ
 tVMZ3DsNh5snNfNthIWTH9S04NS7V798vyBkSLgiOXv9T4oiKrtqTZLmU Q==;
IronPort-SDR: qDP0LOqxUb8akuPsUMGMP3w0EVA+l9E05V9g9yfgdSlUuQ9FzWCz/Vi0N9ORpMZVzSrp73tMdR
 nDUAV+h8BoBXu4cphsuolywLLCtf/ThxHKBW4fUaVkzaq95/sP4u0vM0mbFJkYq334czHeuU/2
 BOaitzy/ryG2KtqazsdaTFV8mu1CA5gvlGaCCxPoU4itJ4RQTUyED4h2ADSuZP623UV3Eu22UL
 4AIBfeMpeSn5UOshUvxGNQzi3AFVzEKiuZ5Ws0dPPFx6Kl91rC39zDVIkxI/fDiQqrsDE1oM3m
 9hc=
X-IronPort-AV: E=Sophos;i="5.81,231,1610380800"; d="scan'208";a="161590197"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
 by ob1.hgst.iphmx.com with ESMTP; 08 Mar 2021 15:15:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OXING0uA0JPIB08is8VmAIh2gmLTNGMtdr5BBiNUZOGMUNQMIV4ajybpjpw3XxmImpK1BshNia72l5f51Rzt9zcJTlrQWLjQRCT64VSADVv1tmTK4stueyt8Y0H6sFCC6ogxVtHXkP0noBLokCKWemAE+cQLYESZpNblKdAw0ur0G/0rDEuzf7gVaEQgkUPpoJuA9c0TNscHqZmiADFxDxA/dESajyvi86sBXP2jTOC/kLuGw6aB6sontPXODjpQcy4osfToKGvYOXMvZ/qDU8nZmGSBnyhhdFhncli3R3Ou8ecPUKX3deKDiNKhF1M7WHgQ5dUKR1h+n54qnvzY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKqk0uE3Lys8340fTpSbOK5hK6GB01RS+X74Z+Sn6IM=;
 b=oQ3Ym3OH/Ax6/L/uVTwC7W6VGBJyHgKgSTyj/1xQpdeVLcemyIXh7hZ7TmkkkU8JDt3MNjSqZ+nHgcaY+QGJszW0qYyTV6R3yTkZI4yZpqG7S7N09GVC3GATUbgANgSQzOuYfZ0+VeiO5suMPhG+eBVVQC4DchtOWOsARCeZRhah4HJwVTsQb3mlKMsiFLYj3JQIfSgCF6C/855582khPer3iy1qbyKJ4Hw9bzrm3+4ennHd3cgWvsiDjVEMz7/2YLrsHvoG1oTBXgevWDVl5QoMr4G3U70IWMkNLHEHBxxD0yla86RufIIadU9y1PiIy7QOKVYAU9ZiwYClnudJhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKqk0uE3Lys8340fTpSbOK5hK6GB01RS+X74Z+Sn6IM=;
 b=kRPx5sOo5SC03+cZZfkuZaUwc537Y9QSrt/ryb+vzlP1Mr6cnUug5yGT82xLp0LXhvRYJYCQmXIB/PGuvkwtKelsdlK74cvD+jv+feaffXXTyH/OLvbpi6qi5GL3aOZ29b00WiL47/+XSnWvCPexwA2Zmms9/cLzBcT0I+V9l78=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4103.namprd04.prod.outlook.com (2603:10b6:a02:ad::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Mon, 8 Mar
 2021 07:15:04 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 07:15:04 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "mwilck@suse.com" <mwilck@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Enzo
 Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 06/10] nvme-cli: add generic logging functionality
Thread-Topic: [PATCH 06/10] nvme-cli: add generic logging functionality
Thread-Index: AQHXEiDO+0ZhO54F3Ua6PauGKnAgfA==
Date: Mon, 8 Mar 2021 07:15:04 +0000
Message-ID: <BYAPR04MB49656474CB914992CCC1A3D986939@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210306003624.21102-1-mwilck@suse.com>
 <20210306003624.21102-7-mwilck@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4a6474d0-1b39-4ef7-a11a-08d8e201e58c
x-ms-traffictypediagnostic: BYAPR04MB4103:
x-microsoft-antispam-prvs: <BYAPR04MB41031C0DA5022C35E6CAD57686939@BYAPR04MB4103.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ehyk2gDw9D+hapnW15jwXCQtY47i7ae6Nfos8AVWtAdoCfDOl1ghY0ZkLDgywx9/7gjSw/upLoHoF7BkjeT0BIE9RL1hbexofWQ0Hi5TiI0h0VhBYjYXX/MkUPXcQTC7MpWy5Miv4GqaUbXkkaLF9imtz1rDclPpvhrVeqyctJSHgKchjVyWfbRuhGIIfof/HhCdDoFVIichs8BwoM5aB0KuHXBoSiAijQIym05cEz7orR09mO1t9fDBYjjhzO6Wen3hT0jFLhUl+NtnAR/+nbqEJzwKBK22r32E0B35wOSvarX+ziRoYYBudmNXngai1LtNc00osnCDmegSilfMnEcOeUbsQCrgK4sdK0Nd2cv0LB8upCBzetoccCvxCjUfN2VyCt0xO0AAJZP1USr+WFICNaTVVF3bft2V653qm9wSca/SHG7sH9UV700zeVs6uNxyOB9yeIHm91hIuR3OQvXYVTlhdR6TReu8kzOavORhOhye2LXoNMFKIpYubsvfS27nQfbn7woAp7/yjgAIcEoXGy9FHnDnYBkUE+xkIN0Zr67MaCgQdUWi1I7KTK5q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(55016002)(4326008)(110136005)(54906003)(5660300002)(316002)(66446008)(8936002)(64756008)(66476007)(8676002)(66946007)(9686003)(2906002)(66556008)(7696005)(52536014)(33656002)(26005)(186003)(53546011)(91956017)(6506007)(558084003)(71200400001)(76116006)(86362001)(478600001)(41533002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6CtoYnaKsziiQCY3D7FAXsCo1qupi1jjrphvgn3kj+ExMmtPZC97qzA5Hj++?=
 =?us-ascii?Q?Jbrt64bxKLNOmhU1ixunRdSCY4kR223gF0Pmxu/3WItpi3vVpDheuqXYlSp3?=
 =?us-ascii?Q?STJftewhWeuhr3ZU1+uJcdbrPN7b5oPhcKOE66EEMG5IIA5VMQ3BwQUAGWYa?=
 =?us-ascii?Q?LfbFg2ynuj8OcKKbx7JNy00vs7QcOKoD9zbTHM81EIxIiKskwfb6GXF6SL5d?=
 =?us-ascii?Q?wGrtr68YOek7smAEkv07mPb1dl6gk3ehoKVEtWpxWlEQS+DiZu8AThaHQDkM?=
 =?us-ascii?Q?5ypbMxQFXN28Rq+edHwwE4HBGwXWap3chOBlpsDA5R+mHQJgH11mmdpT5z4d?=
 =?us-ascii?Q?YD/UCiM9UUBnxjHUD0EBQsnGB79U8y1qfSiHMMV6sqrWIvNR5D+ddOGhaqCf?=
 =?us-ascii?Q?wFYzIqmPGxssf3mCaXqR4raCxsgIC70kKFde2RPuBfNg04VUqE04zeKTrqJo?=
 =?us-ascii?Q?Ux5rEwWfUBVQe5Ygo5fCtNA3oWBX56ftZlUDdL+y+wuw6wOJxqUT/GjXVDKK?=
 =?us-ascii?Q?fkIYgQCxXPA8hrXth8ckMW3E7dLxpBqN5wgMqn5rBt7Jaqruz6N69M8t1esD?=
 =?us-ascii?Q?m4StonSms76S9N8hZ3K7zUEy/2vb2kOJirTexq9WcKqmXHxOtUzsfjG4usw+?=
 =?us-ascii?Q?dXcPweGaDfCxrV7GWhYZUq6iDU9w+gh4/OsATXv/Lm1WSduS1NKfuObafNTs?=
 =?us-ascii?Q?6NsjXMJ+F6Y5ntXwR7D5hfG0THOJxIVaudKHXCf/NcqCb0GRqqDE/u9o9MoQ?=
 =?us-ascii?Q?CL3zYuZuCMTMMvaFF0G3U6sldpWUWRS/5FweMQiJ6W5BiPB7eECzz4Vq5s7p?=
 =?us-ascii?Q?ZiL0kSyDdUD0970+7ifMB9qsn74OrHr8GCZzlWqKVlhF38d2Uf5khKhph+Nd?=
 =?us-ascii?Q?XG7vgXPinsAD8ZRTxUahcWBv6IB1VU5PL7nNYelLC5u/CReIrYjpWEYRjx7R?=
 =?us-ascii?Q?x0MNaX/21hrsomTSYEbdDE+JlQIWJi4s9BrOB2MvKeRG4/tcz62DT1dE0RuX?=
 =?us-ascii?Q?05S26WFyUmJQaBTy2Rj3SXIf1U/UGj43cCVxKKNoelFRiYDfX62IN5Cp/Y19?=
 =?us-ascii?Q?nnCq1L5lskJEY6KtPZaI/XLPw3N701zMzk8nrmHsLTyUy0BXMKYAvD3PhaVc?=
 =?us-ascii?Q?rwNVF6lb8o3Ggywr5zcL/MtWSr+NfzVofPFrJozhhkTykvko6qJpL79APGKT?=
 =?us-ascii?Q?CO5Hu+OlBfbeDu8Hio992ju0n81WCHB/Y+xtni/oDWvudPxtcUVTzTUY+391?=
 =?us-ascii?Q?pFOeJqRG+AZTJ/b82lT2taw37AHKxno7wNheoZgizJqH2Fg8wQui1dCvCo+7?=
 =?us-ascii?Q?9lOp6Fo1n6O/34ZL3yDjamm2?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6474d0-1b39-4ef7-a11a-08d8e201e58c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 07:15:04.6348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfBmVgzFzoWkh8pSTS4Tpo9C7LqLhYYiaBeF2ryHzT3UusZISQn7BMIUBTnHIbEuGocSX+XRY5Ql6pgo7l2w9W9XUgVd+483gVbBDU8BvdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4103
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210308_071514_793013_635782BD 
X-CRM114-Status: UNSURE (   7.81  )
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

On 3/5/21 16:36, mwilck@suse.com wrote:
>  
> -UTIL_OBJS := util/argconfig.o util/suffix.o util/json.o util/parser.o util/cleanup.o
> +UTIL_OBJS := util/argconfig.o util/suffix.o util/json.o util/parser.o util/cleanup.o util/log.o
Line is too long, can you split ?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
