Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B72EC56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 00:50:57 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CEE4207BC
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 00:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WaeLnGHC";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ssl5w0Fz";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ddw5EDPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CEE4207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=R5Gy+bZch0rWcvHyfO28H4xaA6z9zApCcn6wFOdiodo=; b=WaeLnGHCxDvDZmSvuqkSJBkRa
	YhQt7053wTtVw9O9RgVNFsKgHHICSnUsJF6hb2cMcw1fPOw3/ReejPZEf3oMM1BcC/PAbygPMNoJA
	SOQk8lnHFsw+4FEY/q3tleHLx/4Iu3B0KLGJBhrD+V+vASpSVgNmZPVavziiaaYJguV62+4o6cPUT
	SRkHIaAz5Kw6Y+LkSXfGIg3chNoPtoX9CjxuRHANCZ1JB232uM5Ci6xItsd2LCo2OME5y6PKKv+JJ
	Jxqln5TFmEMKpRKFIKy73UG9J8DhJmV9azBt0+oJ5rRbHO1tqiZA34ez5V/hhQU6QHPDUN639j6Cs
	78XWcfMZg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki5Un-0006KD-Fx; Thu, 26 Nov 2020 00:50:49 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki5Uk-0006JT-U3
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 00:50:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1606351846; x=1637887846;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=QQtqW4lWpN8h/53vf6vK4R6+/62Y1NZdEe3CD45wfqQ=;
 b=Ssl5w0FzAu5e0i9Aa396kquniFYoxFJ3pGXMXDli0KQlDA68eS7Ad7Sb
 B1PFfU5T79HX4f/8G9U3/52eLK6oYBmiop+X7YM2I0W1lH9vUOlCr6XeQ
 xP0yVOl+cYG5svUM0Y1MJaQElA5pW5DvKJGx396wZXc7GwAkf5D+UaV26
 qsf+dwzETLTxnyVk+6f+GowWWCW+75gv0DGG8cBz4RZHT7kWl1S+pKMv3
 Z3ulkobtL8ryfxCwQ5+042UT/OBnOLobgIaL1M/JCY14R42CpOAgg5bfF
 TR/4izRc4zX8UWJidx/BbPwjj0+ykyBIY72+DFsRUWbr0xQ5Hc3ZRHd2L w==;
IronPort-SDR: PooScEfJeGfeRlwq155nBJjBzmaarYvxjMvBNZyz0AzWEfR/fh7r2+UjCYh6rVBm5aG4EUPCcx
 HcIixF8a9wZ4tSTzn/oseIoJ8lWZsjmEczReMAi3dj9ZBZTzJ3Er+ev8frUFryWXaFyL2sBecK
 RiUoai7g79zpIbGiBv6ODjWCvFwoKF9GNnV9XZyKdHLkp/QmmH6ixR3jeTQS4UMQ7GyylITrkz
 dKDQDvq3iwgA/V6GFWoqKiY5APWzP9NjR8AIPPhx7FYrl8aoPudUy8qG6kvaIHXHnEs4DYYJNh
 A7M=
X-IronPort-AV: E=Sophos;i="5.78,370,1599494400"; d="scan'208";a="263584822"
Received: from mail-bl2nam02lp2059.outbound.protection.outlook.com (HELO
 NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.59])
 by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 08:50:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vp5U4wpTDG7lXARIOacOQHqlff2F+OaCDVMY5hZVTs47Gt5/ZirP64rhSbQQ8RwjPGn73Vg7lX1L4J6RUcPy2PpwUMJhKkLqXjZY0/3giQNxuMrH67KN5hbonBbqhW4YIU0XheubPM1XUzSRGojvX1sN1XXzVkV1z2RXmHdToJwOigkYeeYfLk/aF7MuJstTSj+GGUK0ClEsN729aARnT2l8KhMOUrPv3jgoeGGh4/mulCt6xRsTzKXM+lyg+5Q1CgV+cDjdDay4ZBPJ09SBDV2/OQQ5VJLDY7XLALJnhsD2dLDIg2vQiQgC2u99AylIEiHh/jp0QW9e3UWOkkCsCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQtqW4lWpN8h/53vf6vK4R6+/62Y1NZdEe3CD45wfqQ=;
 b=IVu1NtDCU/331zXnz1ATgm63WvAmB6Lo2e7QcJWAcvpwPRQmBcggVRa+++be/AotjhhU6c7q7TyHRVDNQJpb7fA5Gzqn/5FcfLbtaBU65u95aWW/S8h2S9tVUJ9fpjwecTtrpRSuf4vWvzY+N3yCZQEcsGxmmcYJJQcCnbV5LbQo8tkC9rCCADRvG6fCVmxcHnBn4FP0k+Ac/RX59VlxDX+aKAFrs6dNBdycDdSTBsEGmbSRhsDXs3IVbz8tVjvO4hi3Tn6ooxjkojo5mEt3jvUhasdDqXsWv/AhEuP0edCwvoE3dg3H9LKOr2HmPQ127YwMDWp0gsyH1w2InhGqyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQtqW4lWpN8h/53vf6vK4R6+/62Y1NZdEe3CD45wfqQ=;
 b=ddw5EDPZ4QiJ9TOyvJY2f5y8Lnp+t0iyYDrKVE98WyMjHM5/kqdFickox3sQBewLFEFA0mVUQ6iNBI23pAhdKC1ianGSQFrVTFSEmtTUzybci0VAy81vMSkVSpAFROVu8oYLdlnuqlpynXKh3PDWOS7ZAQay0R+QdaqVS8/YizM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6101.namprd04.prod.outlook.com (2603:10b6:a03:f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Thu, 26 Nov
 2020 00:50:41 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3589.032; Thu, 26 Nov 2020
 00:50:40 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] nvmet: make sure discovery change log event is
 protected
Thread-Topic: [PATCH 1/1] nvmet: make sure discovery change log event is
 protected
Thread-Index: AQHWwyZgV3T35Isd4UyDx9goCn6Bsw==
Date: Thu, 26 Nov 2020 00:50:40 +0000
Message-ID: <BYAPR04MB49659DD9BDE12B278D1F827C86F90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201125122736.4423-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea748015-2940-409d-2254-08d891a54c4e
x-ms-traffictypediagnostic: BYAPR04MB6101:
x-microsoft-antispam-prvs: <BYAPR04MB6101E029CC93E6987F3AAF9E86F90@BYAPR04MB6101.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:392;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2ES85vtdewUP0RyTgZtnrPXFgGNd9HJRhCw3dWz86R3J4WSaiIbvkaZjzGPGePT0ja4ZBkKGcnKyc2QXBEGfF4aXlKhHpTj/H0DU4uxJjFQpjgVYQSro5rV+ViQCeeNwv51jso8GCfuXhiI5W139wdvPy41+5C4fq0BWck87IFoZeA7oi3fiXf+N1z05hdwRUqPRzo3qewR9tg7nhtI0D0T2JAWtZoFpafHMPz2Q3JlhKMl6BB8PzDO29eygZ4AJHkQNyewHYdG4W8tyndNzryU1MJx1I4cRGg/4bQugNM60+OCpCS9/LJjgoi+kSL3PHX17R0uqNZCTucZYv1gZqg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39860400002)(8936002)(54906003)(110136005)(9686003)(478600001)(186003)(2906002)(316002)(4326008)(53546011)(26005)(6506007)(7696005)(66556008)(5660300002)(33656002)(66446008)(558084003)(64756008)(55016002)(52536014)(66946007)(8676002)(76116006)(86362001)(71200400001)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: xVO0Qcb2mQGLCyO78Efuwx5JWUcc+Rxcx3CeaH0JgevR7yfBmYFpE+yAxt+M0If57MN9989vKv74DI8/rgJQbIGkOcTcHAg1Gc7K5ApWfZTV5Q4Tie4+/noAH0r25hmSquVMCg+gBzsiWs+aH3I+64h4eiJe9zEFErFjHqNNu6HRUnSQiO4WAVjXvIaq3OSXDABThTho+MYDBAqVsAD5cuntCqOnnhGCV/hep064eiGhQHRYCAxxtV80WWn8Hetz8bWZrvFZlVE+esRGTf69MPjD1B0V+gDGOLTPDl8lAsbbQBqpStpLR7+5rZTIBovjpJoaz4Lc6qUsG1V3rhKhAp5Xc/64ccAN92I2ZxrUh+I4T1V20u9jeIYIhfsjXMmUSOyCG6SKDAXHA8e4IK8oYOcV2O/qgkxQfwPV02zj6TFGNYvu+QVHbB/9VFubrSqoeJFQsj4eLIFUCk05VGFZxLjM3QSvrTTYuEpboplguApKKbCuVVv04NE3X5+BlJpWfgpc7niuW7Lgfhb+if82BnFnyngM/tOBQ4HyC+T9rE8OKJg8TYxk61Nt0eMrelNzdnMovlGXZNIcb5CQ9hQZKkzypF2EymjXecw1l+UphPrGPnhXZg63vzFYigUVtYTArP5nkvLaTKyIAsu2eUNaXCSG9pO8SPhqBW5FUbcuWJDgCFwjfAYrW5Am8GUxMn6jprZtT6rjnFvsIeMPIyBx3QOeVceY9Y2HLUYBwtJ6droww0eu5FA5YuoFPhUlcKhPTbGF0JfyI7yt3HMIqzyPl+kSLTlxrv3ckAv6z1JVzd2/nS5GhU0UIT00xEK+wVUpSs+iKdfRyQKDo4gv1iYGDzpwtdRj+7E0ZnE8TbJsBxi3uFUvGVWyR2u43j5IxTT3fd7cpZlE8TfDorq7IwSVXg==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea748015-2940-409d-2254-08d891a54c4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 00:50:40.7796 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LeRQZavUWmS2hRXIPZmmacQdv1RmCxbgDCzgQ0jEksnBp04OUe0ZxnlH7ewJhJm5tn9A5mj6bydrT//ZVho15d8C0GbL+OeSlG6J9ct8B+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_195047_283557_8F9F9E73 
X-CRM114-Status: GOOD (  10.97  )
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
Cc: Israel Rukshin <israelr@nvidia.com>, "oren@nvidia.com" <oren@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 11/25/20 04:27, Max Gurtovoy wrote:
> Generation counter is protected by nvmet_config_sem. Make sure the
> callers that call functions that might change it, are calling it
> properly.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
