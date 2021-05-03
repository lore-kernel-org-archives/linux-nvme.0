Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D85C433ED
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 23:20:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E75C611EE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 23:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E75C611EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ob3l9kH+xeLb65DX+ftB8ozQPdcX34f71PEVLVGLThk=; b=HvqYC9FL2fxNlGtQ1Y8W8Y6mX
	qfbq4lFLUFAfM5orYZR+FlBhwwvC8s6tYmq7PN/GtmQC4fjsz2pEj8kQwV5+dFUPKWqL2rDmAaQdY
	IfnXYu6iFUOYC7nc544fk64fEvuNmz/uyi3bTChc54f4yHGo6K3GChi+nsOti1mCTdcsL51bV30H4
	rTAJSbfwqWNyC/bKZSc2EUgBL9FFOJtiA4DXOZ7hUHHYhdEaQmudENdVEhiZ6PRJhddUPLSH0GG7A
	pufYeqc81PtRbHEhEmaR+mrMCwsWaCBFefecPMhu+y9o8+/X8rURBVYLTeBxBKo0uTVT+FHZwZjFy
	tydG9o38Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldhrR-00F15T-Ao; Mon, 03 May 2021 23:20:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldhrO-00F15G-Rc
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 23:20:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-ID:Content-Description:In-Reply-To;
 bh=wKPp/8QK/Mn3CH4CKzUH5BxGAPMadBEcwpcyTfcRi+Q=; b=Pn/ozfXj1v6N/u6PCsNW0qon1t
 yQyu77zl+BjX8W/MPhGpVhWfTl/1pcmu2c6cjYt9iEVti8aJPgISNwzCmOevyDAArlryK9/LaDxkV
 2NrhDgm15e1k6I/FSr7ssEFvPOWvmAlyhBCMh9tvnjLww6BXsXkAbW/5/rc2wF8Fi3+e0FBg9WDZo
 LmGH7cuAzmXyYJqKjLJSI3Zf3GBhj582e0glIUryid2u/HJ+Wy1U4q/h7AIsnLgpIaRtNHyiwCKMb
 Epn7UoBN0igq7aHuO6in0tvBFSLaIKAKgqTBs5WiFnrpSfkYdsOaxj4qTxOZB9LSJeVvYDZ5fJZsf
 1NSJDecA==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldhrM-003Xwk-Dv
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 23:20:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1620084015; x=1651620015;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=wKPp/8QK/Mn3CH4CKzUH5BxGAPMadBEcwpcyTfcRi+Q=;
 b=QmyFhCt7T/Rq2rRZEH4Yj5WK3PbHyrHXZuTRKOg2c/tNtFVGE6Oq/cLz
 sEe5QbR/U6MdP5kXbxkatoy9ItYiiqF8aEnP9c0CthcX4FoKB3a30+i0w
 DIgkb9XCQs0pbEvoSzyn/xmWKf/6PDaH04kur2oc4R+aAR9UZK0xlJQ8d
 zFwdsvXWqKwALX1hpXjvhzaoIiyD0qvxl3sSkSpKc5OHcs90BvmdDQ1wY
 hNpwnfEoW3GfSBzm96buys8cNPozFTgDlKPhzWsd/nVzi136xpJb4ER55
 bFSHcRrtNVOi8JZJKL0RVlgsaIYSHWarsh5n6FkObfq6kok0jlQcXtaJc w==;
IronPort-SDR: HeB2USA+oCik0aWqMENLkiq0v8ehLl1psWCnr8YDmujA+lDWGPsoHuMmb/E3uQN2BWeZ1koyvk
 NaL6hUrRCv16bMFE7Em0KQsY0LTpDX2p0miJxBmFWjC12+jxi1ROHT1rVYoFdvifplDi9caSV0
 gOZMLk/DanyJKrevW5LklGVpBUugiFMMMHF3HuunSokV/CA67b9fzoR0gqY9EFSEu8/YcBgG7D
 sie/10x01rsGvfbKlZY8Thc4S2B3t9v1IXOF3oSMqJaL2YUdCVL+IAVbDJ/8XJdOYleL9gfdDs
 0r8=
X-IronPort-AV: E=Sophos;i="5.82,271,1613404800"; d="scan'208";a="167024992"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
 by ob1.hgst.iphmx.com with ESMTP; 04 May 2021 07:20:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUjQaJqb4x+CWLrh8esdAV3/latNIyzUQsatWHRZfiflrHCmKZBGI08OeiUP8Bjo4M+0SFbOwRw8bV+cipgk+4BQfcylhWWP4crFwE/Rti7NCGkBzZsHquJUrwuQwJLXybOsjeqk8OwGhIYO6Kj8j3TUGnJcXR8WNv53/hMmPtxFFWg2VjuSago5jPBt14e8R7JJPgvjTBNeq0M44beCZ1kOsIjgNc0BxsIMjbfjhKEQYlAN4DVue2ee7KvR6d71aCE1Aj3IPANpgtTZhDwUWzRV4/p9NUcJKfMU3GCnQA0k3OyLwdv6svJHRpf4ATnzNEYnKB1rNwzgD7vcwWtufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKPp/8QK/Mn3CH4CKzUH5BxGAPMadBEcwpcyTfcRi+Q=;
 b=WVYPtMjrKLZovaUfWvbVamfJlHjUhAoax/ziQN6sr5LOOfEL3JvnG8gGdzGjjn9C4ziu68jtsCk247m1Y5w04N2cT/lWCnZXkozut606cGAak5VMTfYb5nbp/KwM0QwtucZEVHoy8ujQ9kDPtgY3yklNjXGIBsiq5HYZ3qtAzsCq88SgVxgsKtMH+F3waz43O5Qy33Kwim0zn+qpFBhZmRhXv9N3kd/GiEFtakV3mw8/eUmSpgYGH9R1kZUAGuc6M19djji6+qiuXHS2lIe3lbiZWe2hGAl9FYfgLcnx0s1QcbUGWmQpNGTlYvKHYa0KNi6E0SXd7Tvz6JXu8olWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKPp/8QK/Mn3CH4CKzUH5BxGAPMadBEcwpcyTfcRi+Q=;
 b=w5Dt8esM7qaocNRhsTI5eW4gUzEKKaJi0idBdBAfyyIGkiwtkuaDmYs0qD+1hLR+S/iOvOTDLCPo6hsUTYcdSWcajS7bp3Kg+ANoYhjU7cxkQTzf4fq7Rqgu5jCgTFSyak2XkFp/PBFUTWSwhn/WuqVd8/ttOnxa1TPWI/fXM2E=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6247.namprd04.prod.outlook.com (2603:10b6:a03:ea::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Mon, 3 May
 2021 23:20:12 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4065.037; Mon, 3 May 2021
 23:20:12 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: "Rao, Vinay" <Vinay.Rao@dell.com>, Christoph Hellwig <hch@lst.de>, Keith
 Busch <kbusch@kernel.org>
CC: "Belanger, Martin" <Martin.Belanger@dell.com>, "Hayes, Stuart"
 <Stuart.Hayes@dell.com>, "Tarikere, Madhu" <Madhu.Tarikere@dell.com>, Martin
 Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "axboe@fb.com" <axboe@fb.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Topic: [PATCH 1/1] nvme-fabrics: Generate uevent on namespace AENs
Thread-Index: AQHXPG0XeEN+DoD31UWTKCt6MGrgfw==
Date: Mon, 3 May 2021 23:20:12 +0000
Message-ID: <BYAPR04MB4965AEAA777D3ED65CB8C675865B9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <BL0PR13MB429142FD8B9FCC57C2FE451D9C409@BL0PR13MB4291.namprd13.prod.outlook.com>
 <20210429063056.GA2482@lst.de>
 <SJ0PR19MB454499BF2899EF772B1EA11CF25F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <BYAPR04MB4965BD2AE65469C96CBF1354865F9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <BYAPR19MB29351987D7ABBA3F28791D978F5E9@BYAPR19MB2935.namprd19.prod.outlook.com>
 <20210430162104.GA907317@dhcp-10-100-145-180.wdc.com>
 <20210503065235.GB32627@lst.de>
 <BN8PR19MB29290320440FE9740E699BAC8F5B9@BN8PR19MB2929.namprd19.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dell.com; dkim=none (message not signed)
 header.d=none;dell.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82a0e560-7b4b-44df-3f87-08d90e8a009f
x-ms-traffictypediagnostic: BYAPR04MB6247:
x-microsoft-antispam-prvs: <BYAPR04MB62479052962F16A46AAAFE17865B9@BYAPR04MB6247.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DLtS/Ko5z58oZZkw5z8Zi2ogf5VUP9V7AZ8XsbAsIaTSGUXVgPTgo3/4yJdEgDc+bXDjOTpHZPZgmJZqjYxZMIPsVG7e0Tfe5k6xxJNUFoM6jNuI168JC3IZJhR7RhWQfeYWv56uEGaALYdMRuU9bZ33+VlFctTGMj4nCOPhHwJdISsFrjpVaDLJzSW9loXXt7fLbc/Wly/05b0z7ngDhWZlXYOq9YRgU0ElxynaoXQvEnVbgTyV9mXjr7QO0HoFl/RhjLkHg+wCq22uQ8K8bgLDGiNEEpNnoOUXr8pdSRssFXlKgXPpPzUBmCUYXSWOzzGG4xhBCYiTQnTEhbEJRehN6di/GSVZJEwIuNICL5OPb05qOdhnfZlNA7JQSZzOx00x0QSH+7sA2B8w94qxx7tdpamPxF7YL5yL4IPpssXwjkD9Y2oP8U51Wf+0LIElyzVEBwXRmvh5Q3Sla9LkqgPECb2zwMxry0LsxkZ5gLgXgLyytQpzeUBu927JyJqml4whHEXOc11ZrVz38Gnmu7dIlT4cqkyGaaQVBggnaBfS1Yuq8fW3L27QHxxASK7q/axvxnpi7Hr6dQq1jnsQDUtusz+JGMdiwEh7g6FbTh4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(71200400001)(8936002)(66556008)(478600001)(110136005)(316002)(53546011)(6506007)(66446008)(5660300002)(66946007)(4326008)(8676002)(64756008)(66476007)(76116006)(4744005)(26005)(86362001)(54906003)(38100700002)(122000001)(186003)(52536014)(7416002)(55016002)(33656002)(2906002)(9686003)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SocyfJxM64IdRkPNiCBk2oCnVncuIs0BQPw1sxOFEQ5bte7F7u/2ylQFt6if?=
 =?us-ascii?Q?vMOct33fQMbYPAyKwQNVh//94XdfuUw+zcAiVrwgJh6Gsc7pgHV8UmlzWeKP?=
 =?us-ascii?Q?eIkB1ysNFixAedVj9eaz/UwDn3Prsl7RsuNGxEO2vp/7Qs/H4CHnoMkcnFZL?=
 =?us-ascii?Q?votfkVnsm5heTna5FUNKZperdhYNZTmvrPFBvEfh4AfQm3GFORZfJZgADjc/?=
 =?us-ascii?Q?eYYryAHgqZdLDAh2Tev/lqnyrpULJ0VeSYz7xLpTNdleWXLnHFfDo3PhfSrP?=
 =?us-ascii?Q?OkfQC945KJzs+cBIOjfSlt5kgGAT/CY/RrLtbwZV5LEksN9eYYxXLademfOP?=
 =?us-ascii?Q?rusa/PylvG6l//pN7NkaGj+ZY1lJDOteJTF2YVfztGmoFV2+5Q5GWdmdwa20?=
 =?us-ascii?Q?SKfMDCWwTr9HZGEu9FThVlKkUPXybnSbkQYOP9KCwdJepMvkIvq9RRi4YU9v?=
 =?us-ascii?Q?vP1r2fhgGoaFidTmW/pCb5o2CqSZVVZFPvsTOvyWuiBIRqccX+o9AYlG4hxB?=
 =?us-ascii?Q?O8t4iowwqTTOB0Y2m70S1oBUm5MWYl5RH8SGCBzRe/hbGwQy/sCm0TfarUth?=
 =?us-ascii?Q?pZ4ZeSUMoT10kasaJ8XCS2MKATAKVQC1TkRxRM/vunj+jDiYMNLgXG8RVqOa?=
 =?us-ascii?Q?azm2ZPWFEoR31kfBFreDYd3Fu+x9g0P6YVVYqIOSXDmTq/bZ588gkVv8LqU0?=
 =?us-ascii?Q?f03CyhKn/rwSUnTU7vmsN/CDyvf4wT0qhAQEJcp/tq6b5NmHUEJNCA1HJNDS?=
 =?us-ascii?Q?cuBxWIQIKyP7F8Q9jvatNCP6vfabn6ZGyVMPzTLidO/KLjyVMhegKnnf/AUi?=
 =?us-ascii?Q?a9RupFIMIe7g4H4ZRd6fY7abxPBYn+OxPnUhcU1Ox7V6VktWqSDj8gQTZxk7?=
 =?us-ascii?Q?wf4LNe4KL600oDDAjrtGSGF0Qt0/fHs2F7w32fCP2cTIUzf+I5lFhIhyim9s?=
 =?us-ascii?Q?bBSnsw3v51Znp+3OTeUjA5HaIfOerQbEYGQfviWlSHUtS29RNOZxfi/cSFkU?=
 =?us-ascii?Q?7sj9Yb29gdV4kLCaFBBb8vEY+wcAZ69IWeAdqCzOIOxF7kBKePJ7g3+5H+Mt?=
 =?us-ascii?Q?draxz+th2T1itIpKieA3mwiJCOn4HO3qS9JAypDBWbqs300Hcekw2TDHRXHl?=
 =?us-ascii?Q?V7lj+ILScQpDrBp6qUnKO9liUf7rqXCRkBRpgi7jt60KpHU197m5Lh6cvQlh?=
 =?us-ascii?Q?5ggSc5YYfSKTHiXHytTW9PfekTfMqqDZURHO72KRxs0svQqbgmChDS4VCvTz?=
 =?us-ascii?Q?wiyTpPHaS4qhc0n+OTOmoleYsZeXTH0rItQjgtYCjUZZVlNrJluoi1rHh++u?=
 =?us-ascii?Q?piqIA6EeB1vGsCxA4LOj+Brv?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a0e560-7b4b-44df-3f87-08d90e8a009f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2021 23:20:12.7238 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FqzxK370sbEv9TcIB+9HgRzJib6acUXDZ1O7M31PGB5Gj5j0PynNRN9UkB29TRX1xfpZDx0kmb7JGWMQ3RQkOX3MYwAw3ltus1ei46Tidyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6247
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_162016_502732_20073980 
X-CRM114-Status: GOOD (  12.63  )
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

On 5/3/21 00:21, Rao, Vinay wrote:
> Forcing RAE bit on all the log pages that kernel cares about is one of the option.
>
> Can we also think also think about an another mechanism where the kernel would generate uevent after kernel does a get log page. This would make kernel always to get the get log data first from the controller. 

Based on the comment I've got, please don't top post, most people don't like
it.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
