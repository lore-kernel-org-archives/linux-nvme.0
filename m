Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B3CC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:32:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7543206DA
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 23:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l7uaIO3k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pz306Ox4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hUPUT4Ju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7543206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=Y2pV8lptns/7GCHOY4YQQGILUhBXHvskYKinERJI17E=; b=l7uaIO3kXj9X1qYuOgz5N2apI
	aHBsmiHqlTIYgJtFMawL3G1kTpydJksH7BiU8NbjHuBKijPhBxRXPUqPagYHGQOffxQT3z6rFQs52
	Yd5GeVF85BqSonJurzkKRr4GcXgS02pQc3s2H0097PFnmwS/YdzsHJlNEAlLpjFhy9JlHN/ImN+Ph
	RFN1wR5PgHj+HZkAyv37xbV1kfJs34+O8ooLrzvJXVKMT6/qX10yrWTLk2HQMcUv0Tq5nauqAcQCx
	SoAeB6SYExPvLL/9D+6stV7e0ioxKEtPbCTzBdP+nz/XXjGDg6GpV5PDvfUiidGVdZrrzWgGl0+TR
	P7KKHFvWw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5HH5-0004my-2F; Mon, 10 Aug 2020 23:32:15 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5HH1-0004mY-AU
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 23:32:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1597102331; x=1628638331;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=Wt7KzDW6Nb4LpjUMp9QfxXfxYqmFOj/ZT7lLDbdl0po=;
 b=pz306Ox4u84l73xpiwzODCZ3vjK0EO6R8/dj+7qBSXC5Dy1WAf+irbMh
 WqJ/J59zbnatnL+dAvgjuM32lBEJ4iEOwuXhui/UVkOwdI8priyrUULwb
 IIbwdt1Bjic5cwegj0y692rUS9dr/vmBUfmP7DQ7QaqIwSf6rW9rIW2Wn
 toBldo//KiQjwc9q+L1aHmQlMmvdHGgKSEzjO+KbnY/GYOdIPui6jdAQZ
 eYa75ExJEpoWcuwteSODi1umnpDs2DaUNWDdTRPIt0au+/KJk5Zkp2Sw6
 +tv3BxDQryxbR+SX7Nsj3CUZFSXMH7Owm5ynw++bcBOQX5te5nxrshHvY A==;
IronPort-SDR: rkt7PDkusNko0VpNdwK1ZO8qpaTm5C/O94j2cbjoJvvrYO+osIWKge3mnWFaPyg/XkvnUJLtaz
 lrxQUmqvsxkrg/OZPDHV0pfzeCnu/TKXaufipV8O+nmOVf7wfUoV58RTLIjWmo4CdPOm7UbLWS
 rrlAb18Q2S/R4OYEnvpQHaCC2XfRVAgZxokY1qC/qTWgo7gMW6RDjTM4omF9/dsvmcLntrzMuq
 m7S4JXf+FOW5VwPToIBOgQsR8GuEXpbxg5nokfSVutHeVHLDUyxd1JLJIC8ACyWW9Ka2WRb/BZ
 ltI=
X-IronPort-AV: E=Sophos;i="5.75,458,1589212800"; d="scan'208";a="254005863"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO
 NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
 by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2020 07:32:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LS4dDzg3/bd98yxn/d7ATuwds6K7eW3gFLE/wsJ/cW2b167gpwzB4PT+b0tVNsW5uSPNmWbs2UFT9jhfGu2zOmLsHgCC3iPfFFhwY6FHibNiSzK+AagXFgCQNqiZN3dTLKIcIsjElU8cHPE+NQtgjP5Xva+QbB6FL9iyzF5OTj6FFXSpfgQ43m0O9J6x3k/E+x3riwRoeqywvEWE2y/HbIzWu7Ioi+n1p1LuAA9PYop/Z4VrOUyr5UH91UBRX+61ZExNoev1/A9C+6+egl4qTzDKkua4B4wARzXNUnRVO8ZDpGOZz9rMgPKUvGsup0RohxCdv9pWmPKxrq0Ha/d+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wt7KzDW6Nb4LpjUMp9QfxXfxYqmFOj/ZT7lLDbdl0po=;
 b=aLAEast8OvmDVge65bqlQGGpsvdAh/crYTOmZutfbwPyNWi/c/6Ltln5Yed1Joln1x7uSYYAN/8JAyotFTgC1kEz4fFAjM1Djl9Q9BiBkQFj8jnV5mKjFWVhvU20a/BZCxSe1qc6uHz0aqwZQngXRhit6ZPmk4yXnudQoyV0+SQvOY8ziCU9ZIgpSCz3bgNxbkjgeVqsxSk5j6/IcbWTpZQkB2/3egE66op2asoOIdgup4cwzm8/9kIPVXQqwb5NCnPehLPARfq0NDVZ7Q6J9qPkr0/78/gRRfGSLh/N04IQhP8CkgkDzWrHgwjFDi9c5AzF+rSzly21pbs2dfYMMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wt7KzDW6Nb4LpjUMp9QfxXfxYqmFOj/ZT7lLDbdl0po=;
 b=hUPUT4JuOWCsGPdwujeceHFH9FIqgQT6xZBCJp+fXPpaUXToj3abMucNngNmvjZA2XO09v2yYhmDVTIgdIwmzRkEnRE9a2TpVxRhOZIkQXxX66qlsekI1qeFESEHqflJyyyyx77wQZwFgyanMKNjDCxvSEvz2A9JmiC3V641fio=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4870.namprd04.prod.outlook.com (2603:10b6:a03:4a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Mon, 10 Aug
 2020 23:32:08 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 23:32:08 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
Thread-Topic: [PATCH 08/14] nvmet: use nvme write cmd group setting op_flag
Thread-Index: AQHWb0fs0yKpxgu3gEaaZuX9mEBqyg==
Date: Mon, 10 Aug 2020 23:32:08 +0000
Message-ID: <BYAPR04MB4965263F4DCCF20A8B12851486440@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200810185456.7713-1-chaitanya.kulkarni@wdc.com>
 <20200810185456.7713-9-chaitanya.kulkarni@wdc.com>
 <ec013b0e-e9ac-f6b1-3285-d281a81f74a0@deltatee.com>
 <BYAPR04MB496527B7BFE2E1049B6E6FF386440@BYAPR04MB4965.namprd04.prod.outlook.com>
 <ab9d6ee3-a7ae-1ad8-1a81-4fe5bc6feab0@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 011ca09d-6d54-4446-b03a-08d83d85998f
x-ms-traffictypediagnostic: BYAPR04MB4870:
x-microsoft-antispam-prvs: <BYAPR04MB48705868DF64E116E3B5A68586440@BYAPR04MB4870.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DnKj1JSaHL2kZck0ioQ6WKyEAOzpWUW7TMc8g75AdehuoMODiVNCCHdAGzCoUXC0nojOPf1i/GkRJV4+4Mn58rBYMTnJljK5qXjMLMy2D71cjAV/lfqIyB3x5rEOt9F5iUqUCqTLa+Qenk7kHN5TwbH3sst0Z+F9bCkHN9/UxkrwLnahCVIHOu2juXlLTvs8BCSZOexRchmdO5EVZL+gpSp1SO80hu2xH+yuaG8y78KkBNY3Z/i+SAT0nkNZ0LD2BMhV3piKJaBKPPvwBYuxEAZPcgD12cuzv1pMrSoL06VX1nr1e8zwl1VxEhhMVjyEJANoxU6P59O058RqKo1apw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(5660300002)(478600001)(55016002)(66946007)(9686003)(2906002)(76116006)(71200400001)(8936002)(66446008)(83380400001)(66556008)(64756008)(86362001)(66476007)(54906003)(110136005)(316002)(52536014)(7696005)(53546011)(186003)(4326008)(6506007)(26005)(33656002)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: KEHa1vIYqoO8sk8aroIeluxa8W2AOK4Bea+pQ/NP/Fx2n5/pUuPbNBLrkTW1eULABGGrUbOjSVY5Xmpo41IWtwgB1VpOPXWfIKm2UwAYhD5Y41PcD5MbDmwpHkbI7S28a0tMKgFqA1jrevJF82DtQ4QKdUPm41Vwl6XxDJ9p+7u4cQsyf/5p/PcPpJHapm8KHDSF775z3yxSj/8azpji3XfPCVHB6ZYdGsRFa17BArJeRQYkPJVIDBwfrtAnrLwlOte9mKxhwlUHO0oST88xKGLyJ/lBHToqCDrx0Pb12bKNKT8noPMrKimlRHj6FFWk4zRiPeOX9RQ52NPy6MIpGKxPqkss0EMUH0EkNFGJVp6jL4jkSvz5FAHAZQ5OVzfSbCdo2NDmxSFhnyS7KQcLIUcDqNVDqltsJ1AJ+GLM+BrJZkgc5c7uFszQwLYXqskXILtRBHcWh9sGOhP4jTk8cNotuaY+4iEoXN/kiCoMSqkmgtCGqxZA7nNiGW7XOekHbXbuHU7/dnUsi9z90DVl4VqqeT9uTCiyJFgvbF4O2bS9vbbtwDC0W42c5Xf3WmGxDhyJmnenjS4bMw4XXb6kqfNgNJPw9mwVUJ5KpA4Pni3u0ZRNqe3zbz1YgK48/I++jE1HDdau9cIxzZpx9/4pwQ==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011ca09d-6d54-4446-b03a-08d83d85998f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 23:32:08.8331 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x223W6mkXiGpqwU5hcrJTtpa98hNLZnxlxZaUVt+rbfcGjsK+kM0Sd2zJH5bEyk6PT9R50nLOqwxSaiAcV9WuXWDBmm3eAR6w/xPTi2YA2A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4870
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_193211_791638_8E8D4F89 
X-CRM114-Status: GOOD (  15.94  )
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
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/10/20 16:23, Logan Gunthorpe wrote:
>> rejected ?
> In some cases we were worried about side effects with other hosts
> accessing the namespace, in others they require using the ctrl_id which
> isn't really mapped in a sane way.
> 

Thanks for the explanation. The first case is completely admin's 
responsibility how they want to use it and share it best we can provide
a documentation.

The second case we need to fix it, coz that defeats the whole purpose
of having passthru driver without ns-mgmt and critical commands which I
know are very important in the data centers.

>> What is the use of passthru if host cannot create namespaces format ns
>> and sanitize the important data ?
> Plenty, they can format the ns on the native host and still use them on
> other targets.
> 
>> Irrespective of that it better have it documented there is no harm.
> We shouldn't have code that doesn't actually do anything. It's confusing
> and bad practice.
> 

You are right.

These commands are important for data centers and should be supported.
Regarding this patch I'll remove these commands and I'll send a patch
when these admin commands are supported.

> Logan
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
