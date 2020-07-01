Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B41FC433DF
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:43:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34E820853
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 18:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kGRi47jl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aiVjzSkN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FCznrz1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F34E820853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=nZ8LxjEk4z6QWB8W2QGmKgWjmSdeNiupEuHUjGT9E3w=; b=kGRi47jl3yTWFC01+m4W7oTOY
	k5QgEPEfkoRoVKlcZmFq5lCK/oVaeardv51W4VL9gnT4xsilcr7VQvy/TqMV+bipsGV69alp2JukM
	JoN8eV17MmOGzwddBotrljJiUVNF1WQVGFy4Iyl5pR4qxrX5iIoY6wcAnAmgZWRFDd0Y3GREiazJX
	KDntKM7Szfa3/PMDp5eMuucbda5TXvcq5x3NLwJAg4NmxlNUCGoNHqqtqwOrb9SiNltSUtnt78/NV
	Etoh16USYiKDhAXTieUynldjn9huYaT5G3mgzKcvpCiri65blCAZq/nCuMtd50a+9n3thlPy2cXQp
	yxHpHgxRQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqhhr-0000d8-My; Wed, 01 Jul 2020 18:43:39 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqhhp-0000cW-13
 for linux-nvme@lists.infradead.org; Wed, 01 Jul 2020 18:43:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1593629016; x=1625165016;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=PxieS5cB/rG1XhyIVF7PjaN8LKdksA822nA/PD7q/X8=;
 b=aiVjzSkNrRy89LN7HyQv/Ms+EoX3GI+cN1q3ftMiAGxWjZHOvIAurrjh
 uvmJ4Kpp4s/c5A0cN/sORkmcDBp4+o9Mz9g6G6SeAho5QtX05+BDwt6Hr
 krzJjwIH6/oTNllJWQO5RAwIJEPnjtwlBQ3IX0Rbh0mTDoyuZaGxV8Cuw
 zEN/H7POIRTKbijBYzU2a+vdIfCM/mEci00gJzNPNq3jf76kv0u1k0NkL
 f0yz0iMf+nweSjdI2uEeBZSq9yLx1WNcjcOueZ6TQxKwSKCkUc+Tn8oWY
 kagCCxtJRE55PlpswIAnNmx6B032lRZIroyMcYrdZY7KIib0VPnoYunWR A==;
IronPort-SDR: /i0A1DBbmn+xA8jxmWyANzZoqFf/8ECF2SkleXlxIT3rPc4BOONEo8Cv3xivM4Qm7M/XkgDoN2
 MF1yVJ9J4BQP85fdZefik1oc8ZNeC5sySSUY2TL5kRS1AvpFwPNXGwm0dszMAiEXWkWdExxUgq
 wc//1tBk3ktbNNZNIpyclS9G7N2kob59+1NLQq0q6B0ppM/O/XA6fIyGqoBkm/PuFbOVwNd6tT
 yTmYZQZ2xmMdIyoxkRicezyVDWZ9h9tuPlohQEjD92F4pIq2H/g+2U909u4Hn2QDCDPNYMiZ7W
 X58=
X-IronPort-AV: E=Sophos;i="5.75,301,1589212800"; d="scan'208";a="141405683"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 02:43:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AIaIKrm7/jGu/BY4/U+ltgyNa+tfCIM85vzbLiypaOFcgfDCjLuIXH1s4rxz/tkiQ+MT8YoZpnUJV7Vrrqdcuy1+bhRU/vMa8KQ9crvKw4TFhtdVpIcvZVt/X47fXljfuOd5IHb3CrfpSYsGiNLTlwlF9bv7WuiaRXrL7eQTc/cuHumDtYZwOLT1ubq4ZHxnkySGffeUmVU7mDKvpmRR2IeVpnwTkyYMI0GxU0jGrKz+F22CT0duRRcyu5tyRuauWepAPGPC/p0w0xWgrfhhIBW0gPUOE+PMXo9JOvL+r4ucv8AQS/dW3cEKxBVW7bvE22j0mlW2CfAz67U/zYuHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4b/fTAFxLSu5QvGEOklyZT7pYcrFdIzEd3MPb5/ATE=;
 b=UH+76gKhdZgDXXU8ew9M3lAuRWm9UhCODlfHkyy4DoqMqXDGwFKlOJU0TLNjUWqN6gwdhe2Lh8LyxCBNw1bOoMAW/W5YDTcSGYfiLwXsl7jBWRLtg3h7g5fh1L3O3CCRAqbR8/lsQ+8BcNpQW/DR5LOCgUPatn9bVhZ5Ax2PiFm9opJC8Kn+UxHA660KFwWOADQYag5LKMwGJiI9zSc1AqK1EZwapi9+WjlfM5zBy0b2dz1SzUbfDHqf3A84dd1+ktORqBjGnWaY1AHC9h3HycnYJDZnA2JeOyiISkNeCFQBGyRv6Tl8VPW/M7W7sYYDaNu4hwrVcxqBMLe2eI9ZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S4b/fTAFxLSu5QvGEOklyZT7pYcrFdIzEd3MPb5/ATE=;
 b=FCznrz1GzYOIeSXr15CiJm326t5vOLKFjE6dFxWEE+tDwXl+KU9rqNpeHzmxLPm8oMWeOM5NgITLV5wvaOexTp2skJFjPXCHT6WA6Ght/+EkUCDBBSB7GodmssqjklgSrMGGoxJAxp2LXZIHYgvsAKDwruOHiyaJY1pOOe2cxmA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5032.namprd04.prod.outlook.com (2603:10b6:a03:44::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 1 Jul
 2020 18:43:34 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 18:43:34 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V2 0/2] nvme: replace linked list with xarray for ns
 tracking
Thread-Topic: [PATCH V2 0/2] nvme: replace linked list with xarray for ns
 tracking
Thread-Index: AQHWT07f2kc1pYF3pEmTYkfgZJ9VFQ==
Date: Wed, 1 Jul 2020 18:43:34 +0000
Message-ID: <BYAPR04MB496573EACC167BE681D09460866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200701022517.6738-1-chaitanya.kulkarni@wdc.com>
 <20200701053609.GA28056@lst.de>
 <20200701132137.GA1988944@dhcp-10-100-145-180.wdl.wdc.com>
 <d6d2853f-3600-514b-148c-3943338827d0@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a7ac978d-50f7-45ed-76bd-08d81deea905
x-ms-traffictypediagnostic: BYAPR04MB5032:
x-microsoft-antispam-prvs: <BYAPR04MB50325DA4D0F143CC12970F52866C0@BYAPR04MB5032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jq1K+ScAXQaj+AH4vq9sSdvF+BpcBjFF+lpT6za6MgRr0hBnL6x5E8YYrwrAfJDZd52Moex4vUkGPpQY5yQW6SBxiGIACEdKXGI9X93x5+Vu9bZ6GRc5L92wnS7nHniIIoDaIz10lYh51zUtWZVd0FYuKvxzjWxIdw5zIf0AcVLBomoJ1nK3bSFYX5UpHJW0MmMHX5AKi7Dr40X5WiSQ2ir77DgiiwfPnNJKtm+PLwrXoiy9mNy0x3bZBjVsozQU6MedjfTRGr2GfAUqIirn2v1Soefv5MbQevu9bVLBo1CHFIahLArU+l2frNEFJHI+
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(4744005)(110136005)(8936002)(33656002)(26005)(86362001)(8676002)(71200400001)(7696005)(6506007)(53546011)(76116006)(4326008)(66946007)(66476007)(64756008)(498600001)(66556008)(66446008)(9686003)(55016002)(186003)(52536014)(5660300002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 9inFjdMwOm5IG7PbPjvjwZmQLWqQw6iQqs6s1MRrau+p5saiIagO9h7CCmR06ZjY74i0HGF1F3wvbTXrOrFW/nJC3iDimcvG2MPDs52FyuJTGWiaPTtihzwbqCQSEs1ClBRw3VUKO4/KuF2boNzRLYDxIonCTuaHStZ/Pom4uFqXTiB5rltwRwb4/z5A+t+ukPkOZEg3Lf1a7qPex7LzciO8cWHp6W945aZ9dIpv9gFb9IEVNBR8yzUHwZ5aABp510OpPYbc6vjbFoKKd/KZ9tlQqZNN/8pP3ILKk1mpSkceqPLzcC9e/ll79AYk2MzHPlcluAe40ns84kOdx2d/fntM2ceWMBpfCjRdzyQjiPCO06PZ/n+ZRGXkXQC4WYGXnh7GSeD3s9pEG9LCopD05DDCkRvAGLi47/bryhWmZC17To/ZlpYlGszM196J1McP06Urbv8LA0kaQvueQ+srBTjUGwrdFnTUVo1lHGk9aCBjjonYgnxWzyCa8+E/lfpq
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ac978d-50f7-45ed-76bd-08d81deea905
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 18:43:34.7015 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yw59A7J2Z7IQ1PYSqi0qmaZ/SpjhAPY2B4wTCNOEL4/rTPZwguGrkIvyaAad3Q2nPEjCvkQJTeuFkZyFvtvX1VEJetY7hcY4x0k7uEVeQxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5032
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200701_144337_222212_534B41B8 
X-CRM114-Status: GOOD (  11.27  )
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

On 7/1/20 9:50 AM, Sagi Grimberg wrote:
>>>> Hi,
>>>>
>>>> This is a small patch-series which replaces ctrl->namespaces with
>>>> xarray for host-core and target-core. We can see following
>>>> performance improvement when running fio with 32 parallel jobs where
>>>> first 16 namespaces and last 16 namespaces are used for I/O. See [1] for
>>>> detailed performance numbers.
>>> Why would that make any difference given that we don't look up namespaces
>>> in the I/O path?
>> Not in host side. Target does a lookup on each IO through:
>>
>>     nvmet_req_init()
>>       nvmet_parse_io_cmrd()
>>         nvmet_find_namespaces()
>>
>> And this detail should be mentioned in the test setup for the cover
>> letter, or in patch 2.
> Maybe ns scanning performance will improve:)
> 

No it is not about scan only, (although it should as there is no sorting 
involve) this is for the passthru series which uses nvme_find_get_ns() 
in the fast path.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
