Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9999FC4707A
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 16:51:24 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0E9961090
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 16:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0E9961090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JjPBgO0a2KOOWhWD3UcK7sInaD3wjumEqf+32MzVU0I=; b=eMtDcfEuyb4qXRnLtF0ANoWhtk
	DJ3KvTxTapX09ceEYmdCwg2EL8S/LIRySWSU185XjOyVA5O8WvVf0nok8oaveEsyDZNyeuZ3eFqqB
	jo6m8r6tPYNxBxCQawsUdza5nr9W+u9kr53RtG0w26SbRip4uzZOZjWwZSxULFWbQjA0DymZY0QKQ
	OhZjsaTf30V32v7i3zcJj0O91wgld3arbaJynXxTbDlOA46WC5rxg4JMk48Hi1tc5eLhjOQV+4yaD
	5X2+2wIz3WAMQT8xVRiUpdqYAegshMR0CsQYxZYygdtuZVQgxZ83ThmUDuid2Gj3rIQ/vaqHa6vop
	idG7uRPA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lk8Mc-000Lfd-8G; Fri, 21 May 2021 16:51:06 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lk8MU-000Lf0-JF
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 16:50:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
 Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-Description;
 bh=/MrWl71YiLtuMgElvSka9WZSYGImx+wTTDdoNpmGfno=; b=27nMAUT3TngEn2pa3WEvE14vpe
 RqLxhA66aJrj9qMnHKRsKgGUOFevd2bYdmabw31wEYPlsL2IKQfxNP3e6iD0i9PGzzEvn1fd8N6Cj
 tnaIzzI7YyIeGLqveJpyu43fCwV8ygXFDDfKrpaSEAT3m9SZCs/kTWe1RMotdsuvjExJa1tmlSMhV
 hsdbnL5/w1dBKmVpAh1zsqvePwB04LKLEjo176FsmvZUk9aHts+1DjQYpDPSYHrAWV6uy8PvNO80+
 8C7x09m0Z8Mc/G4LGj/73JP0ecxBWInJOGYdcGp29bGzfVB41OXI33W9CV8ExuvQ9rtBm2m6Mr1R0
 2JlqaXqw==;
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lk8MR-00HHyA-Sw
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 16:50:57 +0000
IronPort-SDR: a1vH3o6ZC8NnvFihB82jTDn0FJiF7GSq9/i0h/g3rzDP9OBCVAB8hA6/6s8gwX01MD9otF9Kb9
 EGe6joChQruw==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="201560275"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; d="scan'208";a="201560275"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2021 09:50:24 -0700
IronPort-SDR: wZCqZGCoJAfVumVN16x8HnjuVgsEyNwC5RrJq9NkBspkyHMsaVCtHoI9BTKITFBrfM81NGOaw+
 Bc9Wadp460ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; d="scan'208";a="544148649"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga001.fm.intel.com with ESMTP; 21 May 2021 09:50:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 21 May 2021 09:50:24 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 21 May 2021 09:50:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 21 May 2021 09:50:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Fri, 21 May 2021 09:50:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HK/dtWtztztG6fBYQQWTqqtsJizpg1/BwqD7VI7X3I2haPOlf9rT6/jjZgZbQFbjbW+dowVbQ3MusWpzgK9DFN/0oqHeSirDGb6Vvd9C+GxevSsatlbeUFNf81awHAm7r+Qxj06KDGf7pTgZ7V+aT26igqmrydxaE1jw6MU0ZW2ao7RUrEXvo7tzQE19Xh/3m50Rvr3nX8T01TfsFqpwAkrSJ8GCkjQ70HTFEc0ybCcAuKk8kOc1Y6KSBqDRJqZEqvDMG9/mKnp/TCvLEe7v2sAtuMb57ul8UQ+IRWELp6QvCID3+Yml589N+ktnq99ZvZ/gNrqEaIka30SyJnpy9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MrWl71YiLtuMgElvSka9WZSYGImx+wTTDdoNpmGfno=;
 b=cckjJmufcYlpUw8TUx7gNHHL6lq5mQAu2Qj5XcJNmR3nlOEy2cwtFZ4Aocg2ztPyjUfDigCdcq/yH2orPN+tRM6FSWMlSfjUOLke7tYj2Tn8Lu5bRlquVKSwZy5xbZuClOq+G9wq9xGhQCrhfpz5qL9OH7R177v77LaUzNKdlb3Kzg1Ts3/6D6bLJUm1ahehQwUcbYNsqvkvDBRwe5D4y33Bk+bLFKn/zQV2+yXRSMIoEHjR8SAwLiicPQOuVrMeIHNmY1wgfNpXv9ZWYo0fosJ9cGLIfxtVJqtaxWul0yn8FDLIqvsvy3BJQLracD6a8e0u78Sa+vhKR/Hq9xVcTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MrWl71YiLtuMgElvSka9WZSYGImx+wTTDdoNpmGfno=;
 b=bjb7mnqZqB+LYkG3M60HBv06kFW3xGL8wT50aV6GAog98CGTrG8Gy6tNy1o03kUGuxu64CJFhZBkznK69pKF2ZiEldKlRu8la6BZdytoQkG6sM+kVkGuHQIUGQUttWgKZQ2HdTbDl+FUcbhtMsDsxQETYooqa4ztkEQfyu1JtCs=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 16:50:15 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc%5]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 16:50:15 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "Williams, Dan J" <dan.j.williams@intel.com>,
 "Schofield, Alison" <alison.schofield@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Weiny,
 Ira" <ira.weiny@intel.com>, "Widawsky, Ben" <ben.widawsky@intel.com>
Subject: Re: [BISECTED] nvme probe failure with v5.13-rc1
Thread-Topic: [BISECTED] nvme probe failure with v5.13-rc1
Thread-Index: AQHXTf44RymihtVr+UGY7aRawigtfKruBySAgAAfnQA=
Date: Fri, 21 May 2021 16:50:15 +0000
Message-ID: <e8ad9de961f3bfcb748733b59c189aa577ffa1fd.camel@intel.com>
References: <40071b11108987556d0473f9d968fe7dcd3f304a.camel@intel.com>
 <20210521145705.GA29013@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20210521145705.GA29013@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.1 (3.40.1-1.fc34) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d2c4a89-9b1e-454b-4288-08d91c78825b
x-ms-traffictypediagnostic: SJ0PR11MB4896:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB4896A52D5C5DE358159FDAFFC7299@SJ0PR11MB4896.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QFXK5keNHV10ikoysq6FabQlBml1uYEx6gIUIsSzYQjESAnjplB4TV15Bk86oslgXNFBBacwGghxq+bafvmzAKll5D/EQn0QPTjD/H3mH12Tn5c/awExHcB6w9bu4I1OBakAUwEGgjvIfIarY5wyQAUiGHkBrl0UR1kJYuchU7NzfVcvuSo2clvTagwKHtiIyFkOBJ1ALlC5pXKCKkpcEflyi8QoMtx9xxQXNEhMpp/Boz7m0SRg41zO7ChwB/3XbkI78YcjK801mx4kyMQB3dfnnQ+dwFXbsBXISU9o2C1VBweiwwBN3zodBBNFgpO/jkJ/DR/dI4BBq8jyHmUdD8KR8NYruVss1wSSHRWGeReykDrxdayq2fePPVEPq1n5sUFuYpLNkwF8ygOOWWIN4RT+qtkWx196uIdSwiM/jgswmzj7zmcH+CzIsIj9SGptwmchOf4O/tMbW4P5B0zSiGmNehbOLi/6CwLjcDj86tB9i8KN7rA1nDhEHj3AWO6QMc8AJiPBwRgC9aRL0sNXMX9kQC1vXWXOx3h3ef7MdyyHaIQSze8UBRv+4/1H7VGk+Jt/Io1/ngWNQ3sNx1PmJ4ABGilEe7xRNPrjkjIeof4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB3448.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(39860400002)(396003)(376002)(136003)(366004)(316002)(4326008)(6916009)(38100700002)(2906002)(86362001)(71200400001)(2616005)(6486002)(66556008)(6506007)(26005)(64756008)(66476007)(66446008)(6512007)(5660300002)(8676002)(66946007)(478600001)(36756003)(91956017)(8936002)(83380400001)(76116006)(54906003)(122000001)(186003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?YlRaY1VhSmttbjJyakRjRXRnYjRrNVBrN0MrMS9kT1A0S3NWelVndHNxK0Vz?=
 =?utf-8?B?aWxWZGw5WS91V2VmU3QrRTQ0OWpLTldzV3I1V3p6UDYzdnRWbVF4RCtiUmJL?=
 =?utf-8?B?OTNtaHdKMjdRQlArOVB1eVJTN3lpa1pnRFpjc0xzd01FSjFTTTBjNmNWbElO?=
 =?utf-8?B?ckxBTExRK24zcERzS1dJTEJtK0RMSitIWExiT1VnZjJMZjl4eEFrRjVybS8w?=
 =?utf-8?B?SHBtNWFvRnU2cENHekdUZTJCb1hXbllFcU1ob0ZRSS9zUUxnMndZUzhFNE9s?=
 =?utf-8?B?T0hoUFo1VTZaTUlrN1lycW9ZK2U2ZFFkZnUrNk52ZU5BOGdqamNNaUcvUDFk?=
 =?utf-8?B?RnBoeGl0VmtkM2l2VzJqWExoOFVTQTVYbXVzOXlUdGQzbUFaM1RYKzZkL2dt?=
 =?utf-8?B?ZXZyUVcrb01adGNhMlIwUEJDdzVucGNyQ0hmSlQ2elpCbkFQd3c4aXJ1Q1cv?=
 =?utf-8?B?OG96NG0vUTRzd3RSOE1NYnhtN3lzVVc1RC9UdXZLclI5QXh4V2doSG1wSjJY?=
 =?utf-8?B?amlBTE5NYWFJcm1CeWdCVW5DU2wrbFRaL2hVajFDbENIK1Bka2VjMzRmcWs3?=
 =?utf-8?B?NnB6bytWWGYvR3llTnRNRzVaU2dvYmV3SGNDcjJlMTRmRGZQWUxmYUlGYjMy?=
 =?utf-8?B?RUpYYlk4b001QkxRaE1pY1BFUDFPazVGNEFiYUprbEhNaFV1ZVFNN3hwVUdm?=
 =?utf-8?B?RnR3QW1YRUN2M0ZwdU5LQmlGU1M4VG1YUXN3MVYyaTFIYnptUTVpUHZGK0hO?=
 =?utf-8?B?QythNzFvQVpxVnM5dlVmcHkvbGpqZDZiWHhxT1ZhUmpuZUpYZm5pb25hWlF0?=
 =?utf-8?B?aUM4Y2V5alF2eWlRS2hoV3BkUk9ZYkdsUjYzUUhveGdjdUJ3dFAwMFJVQytG?=
 =?utf-8?B?NW9MNDk2U3ZOZGxMSWNmdy85UVdQMlpuUENNZHpWV0J6MHBoc2h2eUhVVEFI?=
 =?utf-8?B?ZEk3TmlhdWsrb09xYjNGeXIyeldFVEhqOVJxVW16Um1YeStJZ1RBbStIU2N1?=
 =?utf-8?B?R1VRT05DSklvTEgveEdzQkV3YVZlSlg0UWxxS3o2WjduUTM0SUxJSmFHU1lK?=
 =?utf-8?B?am9FRklyN1E0VWp3aWowbmpZYWNMOHk3VEdHb2FJUVFuRUh6c2JMM0hFRjE3?=
 =?utf-8?B?SWFIS3FuQzVGTCtmZERENUZ2YU9BeWhhUDVFK2ZzNUh5eW16TS9xdm5DVGdq?=
 =?utf-8?B?NTZ4cnk2N0hNY25XampzSnFKV20xcGEzUUs2SzM3SUFzWEFqVUtieElmK2k0?=
 =?utf-8?B?K0Ruby9WaG5zNkR3NDA3RVk3V2lsVU1UeW1qcTRlZzIzUWNESktHWkxXelZO?=
 =?utf-8?B?MENPOVBQa2NpbEhXejBkNyt3dmp5bkdCR1BFTlJiNHVnZWdxNC9LSjNwSmF4?=
 =?utf-8?B?dGlFRUx1dTE4aVdMMHR6a2RRZGRXNnRiR2FDRkk2N0FSRk1qaTVlQ3M2QzFh?=
 =?utf-8?B?VWJzd3lWKzJqSFBkRENEMDI5endkRTFXTVhzWXlObHhSV2R2aUN3cUQrUDRX?=
 =?utf-8?B?L2I4TllnZStyY3VrM2hjc0pOb3ZnenpXVFNHMGI0b2h1YmhWbUFvdEpPSHN6?=
 =?utf-8?B?SHo5cEIwUUV5UEM1Vk5OcTRPVDRkRjRNY3RKUmZKRTlMeUliK21lZkV1SnlU?=
 =?utf-8?B?ajBzNlRycDFLVjBLM2VrNEdsTXRpL1pMRXZwdVE0ZENZZEk2NUpnOTM0SkMw?=
 =?utf-8?B?bW90eDZ1N2VIUEFJOTVaTG9tQjUvL2RDbWx5c0Nkd3dvU1gweDEzbTNvbjhM?=
 =?utf-8?B?N1hUNWlYNEVIVk9maDQ4ZUJxSmFxQ01vd2RjTHBPWWZGaHo4RU9mVFI3cERV?=
 =?utf-8?B?RmluNys4eUdJNTl5NDQxUT09?=
Content-ID: <E958432B6E3298479C30455B2738F858@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2c4a89-9b1e-454b-4288-08d91c78825b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 16:50:15.6129 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LDl84dvL9RH+mAsa3sEJ4xkTKV+F7gGm/1Tw3dXRlGCPnoyY0a9uUfWUpOd4TcSPajpu8bwQXZJEIvfuVJkfz4l5BddpZlhVL0Js7wmQ+EY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4896
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_095056_062384_1D0A52F3 
X-CRM114-Status: GOOD (  42.03  )
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

On Fri, 2021-05-21 at 23:57 +0900, Keith Busch wrote:
> On Fri, May 21, 2021 at 05:00:29AM +0000, Verma, Vishal L wrote:
> > Hi,
> > 
> > I ran into this failure to probe an nvme device in an emulator
> > (simics). It looks like there is a ~60 second wait followed by a
> > timeout and a failure to boot (the root device is an nvme disk) with
> > these messages in the log:
> > 
> >    [   67.174010] nvme nvme0: I/O 5 QID 0 timeout, disable controller
> >    [   67.175793] nvme nvme0: Removing after probe failure status: -4
> > 
> > I bisected this to:
> >    5befc7c26e5a ("nvme: implement non-mdts command limits") 
> > 
> > It's not immediately obvious to me what's causing the problem.
> > Reverting the above commit fixes it. It is easily reproducible - I'd be
> > happy to provide more info about the emulated device or test out
> > patches or theories.
> > 
> > It is of course possible that the emulated device is behaving in some
> > non spec-compliant way, in which case I'd appreciate any help figuring
> > out what that is.
> 
> Hi Vishal,
> 
> The patch you bisected to sends only a single Identify command, so it
> sounds like that must be the command that times out. The controller is
> not required to support this specific identify (CNS 0x6), but it is
> required to produce a response. If the identify is unsupported, the
> controller should respond with an appropriate error (Invalid Field In
> Command), but it looks like the controller didn't respond at all.
> 
> So based on your observation, it sounds like the simics implementation
> has an identify bug. The spec doesn't provide a way for the driver to
> know ahead of time whether or not this identification is supported, so
> the driver just has to try it and react to the status code. If the
> implmenetation can't be fixed, then we'll need to quirk your device.
> 
> If you want to confirm for certain that the new identify is the source
> of your timeout, you could try the following patch and the timeout
> should go away:
> 
> ---
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1a73eed61eee..b16d31d82606 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2711,7 +2711,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
>  	else
>  		ctrl->max_zeroes_sectors = 0;
> 
> -	if (nvme_ctrl_limited_cns(ctrl))
> +	if (true || nvme_ctrl_limited_cns(ctrl))
>  		return 0;
> 
>  	id = kzalloc(sizeof(*id), GFP_KERNEL);
> --

Hi Keith,

Thanks for looking into it - yes with that the problem goes away.
Let me chat with the simics folks and see if I can get them to fix it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
