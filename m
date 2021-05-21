Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CA1C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 05:01:12 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0A661074
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 05:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0A661074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ufPc3DxLP64hPwLs/iYncu0QAQK9H8YIck5BkuDr4C0=; b=qH4LwKq7O0FVP6shU43cwRFXZi
	MmWig/eXPwxwKjUmuBQGM2mc9o1xH/aqj9tlPUTHGDYdH3R9lfsFGg8qvsm5cJ7mgNEgMbMoNqwzY
	Lq2peB0foZNJuEyYey4J3R/HE8/qPYcM9lIl7P1EEMV6W2r7YfCwc14kZZE5vPZeB3ZQ5UJpwcktl
	wHdRbWc4d3To1Im2zvrAU7G5gKeW7724ZYjWwj6AlexX/RiNOkvsFDcUzm2+pfQg3qLyaClDsT9JD
	gXTK3ueAF6lUnBUbOmHQ60BJYoyHrkxtjA9cGYqwq5QoIAonAFwMgzOyVbqZa5X6yV+6H7N2to7mR
	EOY155oQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ljxHB-003p0K-Bz; Fri, 21 May 2021 05:00:45 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ljxH6-003p04-Nu
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 05:00:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
 To:From:Sender:Reply-To:Content-Description:In-Reply-To:References;
 bh=QaH92Sl201bZXT24dVyXMNyFYjnoqR4pOqs31qj6SRE=; b=dVGOldZmC2tdMIjLEssLaMqnLP
 1QoUmumRnN9Y32DaDYHSPtjtBV7ymvRwyMdHJdQEhTdYiOa59qowwkbErLq7ZE/tjHGJpfAg/9iE2
 86AnM6RBkGEUPDLhM/1k91Kew2EsU1z1hlb6ALSUPhdTs7DCvqRJuHs5B/JPIjS7MpUBiFRGd9FZZ
 EzhTNijoH5RQssGB2z35oJ6c9ngPMJeoXOmV1Ka6Hn+Ddcu6tHKz3cqtZCHCvLW5JPR4DhhR77RoK
 lZuTdPlINWNYXS7jTid81afw5tlBvVLJVi729wxpOVto1/0GqaC6bVe5f4yJJVSf66jfzC1G6eVSG
 vn3xMkHQ==;
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljxH3-00Goq8-Ci
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 05:00:38 +0000
IronPort-SDR: cXYoixoY9rzGBhIla4LcTy8WoROvLm8fvE1WmYnBZ4hKbP8pzLiM9SRJElz3dRHUJ4xb4+ZWbq
 PDKYcuDBR5cw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="222513662"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="222513662"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2021 22:00:33 -0700
IronPort-SDR: DgtSuAZdFJ6aRxoFYMPgVGSvPadLs51GygIBa5QtP20YdjNaIQ/Vu7jW/JIJkkkOFFgXF2TXVU
 VPOgGkmmnS+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="475531542"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga002.fm.intel.com with ESMTP; 20 May 2021 22:00:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Thu, 20 May 2021 22:00:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Thu, 20 May 2021 22:00:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Thu, 20 May 2021 22:00:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coNATxs55I/utkWj4kqdV1tNKd0qS7EXcMg2vkUt88kEGeEe6ZCh5VxzEwtxurgjecHlbIJ5DPyOODbUmQj1kl5XrMRyWqWIbStAif2YpFqIL64TUPyc5yS58XN2eX/WEkyEQ2A3cnPn6cXXT90UB0LnXs6rvhnXqY3ILUdIzqEFydV1c0cVXKiwMEHNYjzBnFEVe6FyqSVpEaiz9pzvUVg48ecchFV2fOv+sYafvswKktcWfT9yiFfCWyp8yHsSRE+FDHrz1psmc5yb1lfgSJvyb4a+vm/Ey3+FUQZh9iOV3/AIM/t1pu17dCR1Z12+qxDJ9ZFpqOR117l1eE1cGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaH92Sl201bZXT24dVyXMNyFYjnoqR4pOqs31qj6SRE=;
 b=FldyViUkO3jLql7PfZh6cmh92khPvAmcf+eotFuogDgE1gDS1CM8PyWORslmwfQ0V/ejxA7X9HexcVjv0pPCl7P6Brx4cCiKCEpmUwpfji7U2ggRVw871YorxQPF93ze63ins+zL68k65nroZCpMJLDTZYWZ9dMv0p5fo9nxQ0JefaZUOHZMTyyPdyXsiG4HqL4a/rCF6TRYQDwFmf/fRUsUAvCXyaRNNFGS/BQoZwsN+PPUI1kzgP/El+lcLQ4oMg4ZhCGBzrZ1zZH5MvIYEQpkexQCcXlI+l4RgWaWyxPxVytv5jTnriFJ5JpXmmS5f9Yt0n4af/AVPllLQsNBuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaH92Sl201bZXT24dVyXMNyFYjnoqR4pOqs31qj6SRE=;
 b=nN7Ssk0JFPa9JxWfOKXgOBOEhKsz1M+x3DVlocfKvabfeewpcxyz7laVel5nhXmRRdCSR77oj05mjbcvcaqHPVoQSXIM6W3QONZngxOQdq76/quAgRhf4N7ngpDDUirTXJLK50eTYO8vGEK0orDw14rinOK9Ycf590Q0Cg56BOA=
Received: from BYAPR11MB3448.namprd11.prod.outlook.com (2603:10b6:a03:76::21)
 by BYAPR11MB2534.namprd11.prod.outlook.com (2603:10b6:a02:c2::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Fri, 21 May
 2021 05:00:29 +0000
Received: from BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc]) by BYAPR11MB3448.namprd11.prod.outlook.com
 ([fe80::713c:a1f6:aae4:19fc%5]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 05:00:29 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "Williams, Dan J" <dan.j.williams@intel.com>,
 "Schofield, Alison" <alison.schofield@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Weiny, Ira"
 <ira.weiny@intel.com>, "Widawsky, Ben" <ben.widawsky@intel.com>
Subject: [BISECTED] nvme probe failure with v5.13-rc1
Thread-Topic: [BISECTED] nvme probe failure with v5.13-rc1
Thread-Index: AQHXTf44RymihtVr+UGY7aRawigtfA==
Date: Fri, 21 May 2021 05:00:29 +0000
Message-ID: <40071b11108987556d0473f9d968fe7dcd3f304a.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.1 (3.40.1-1.fc34) 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.139.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6f54fdc-56ea-444a-ad6c-08d91c155b13
x-ms-traffictypediagnostic: BYAPR11MB2534:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB2534C1BD0C8FD7C3699880A9C7299@BYAPR11MB2534.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xm8zi8vkJyswfonMfD1dq0ItmODskJxK1VRVzJI/SR+afFjDVTPquXLT0CpxR7516RIoMQW3qC+1V+B6k/KLiyYQU4tf3NraUxQzLARN9x1GkLR+YDhjGwgxXP5XVwx1Dsyqw2ut9io+9Hfu0OhdlsrIOj0KcQPbI4TvW7Sb91m1diThNVBn9/sqPyBYi9tpRYMJScgEXGal0h4G49qMk8LS1U1yP8pTLOhiqb6GCK1NjHX6jQzbY+X/7JjDB1MshRmf5f/Ak6jZTfVsD8JrFwho2sm+hC+YhzR7xLBZG5hgJUGNRZ8W8mY5ljEZiWldr4fRSGkB99O/UbaOKCIzT7VQ4g17wpbO16nQot2Aqw9cfGg91hzlc23XGcCsGroimCIMyWT5wBDUB8Q5NxuQ23CTtVdMxWVCCJ1CG26TFzhMxm/aWkCVTzocpwibCvL07kieJATywlwvLUmcqdLiul1ol5Ro0hgHW2IorES7+3MDUeahALWbCkv8x4qJiojUfDo0mUwn8662jCjVbyn3J0LcWEzDauWbC0RSZoUIesvv4QZQvF2wBrIg3fbqYIfFUPRECFcofsCuL6CApUeHQGBkZaeBpNR/AJ5NgLqsWJU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB3448.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(396003)(366004)(376002)(136003)(346002)(6512007)(8936002)(66556008)(8676002)(26005)(6486002)(83380400001)(66946007)(36756003)(2906002)(66476007)(76116006)(64756008)(478600001)(4326008)(54906003)(71200400001)(5660300002)(316002)(2616005)(186003)(38100700002)(4744005)(86362001)(66446008)(110136005)(6506007)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?V0R6VTZWdk9uSXlVZDVkdkxvTERrU3UrR0pKbVJMTTFmM1cxb3Q3ZE16YjBD?=
 =?utf-8?B?NFZBMG9kV0w2VzU1NEdkeWdaK0swZTlVWnJoQzdraFV4L1JDRnNvZ3graEZR?=
 =?utf-8?B?bzdtMkJzT2NUaVhUcFpsajRXQUFFWWdEVnhKaFNOWlZtYmN2cnZPSFJoVWlE?=
 =?utf-8?B?SGxpdW5WWlVrQkR3L3EyaFVoWnoyVlVYN2MrNHdZL253T1h6UCtPYXk1RE9y?=
 =?utf-8?B?YWJRUERDcXZpeVFvcnlzWm9iaFpoMC8wRVJETUFuVjlsc0FGalFCUDY5MWJN?=
 =?utf-8?B?Mi9lbHFPS3pheHBZZ1ZSb25sbXZDNE5Mbm5pZ3JTSjJZQXMrZXVDTHBTcWRs?=
 =?utf-8?B?ZklPWlF5Rlo3d3RtS3I5TEEzYW1RVDhmdHg3ZFVlcDRJNmxBRW4xdGxDTlJQ?=
 =?utf-8?B?R3loY0J4VmxoeENNUWppd3g5L3BUU3JoMjNpMkNKYVNIQmxPdXVSeU1TV24x?=
 =?utf-8?B?Nkl3NytkRjJoTFF5OWczaWd6OW5WZU50citOemtHeXl5blRpY1d4UVMzRVJT?=
 =?utf-8?B?ZkY5R3VrR0pZaW9EazVUWlBpMTB2SXRZNXArOFk4eUdGcVErQ2lwSnlLVENa?=
 =?utf-8?B?MDB4K1ZJNEYrZlB0ZTVrdXE2Z21BVysxMzREVWtFMmpJZjdjMDI2ZVBWaVpy?=
 =?utf-8?B?QWNaZ21SUFFFREllVG9UT0xpcGhyaEtUZHp6eDg3MERjY1kxRDVPQXM2SlZs?=
 =?utf-8?B?akNHMUF5U29VV3o5TDFOVGNLaWV0alp6SFFYUHlqd1hFeGUra1d1ckNBMGx2?=
 =?utf-8?B?MzlzSWNvNEZBNG80NU1LRWRuQ2tHZllwZlZVcWtLN1ZRYVpNcTNJT0liSjIy?=
 =?utf-8?B?NmpYMEJncHdrMmpWK1FRV2gyb0ZzNDd4em1Xbm56YVF0amxWQ3k5OGFzdXRK?=
 =?utf-8?B?czJmREMvMUFmdisyalpjVThrZzhMcjNnUUdVelVJdmc2cThsOWczQ1l6WUdK?=
 =?utf-8?B?UVY0bGFYL3B0SHAwWGZSS0lXK2dlVEtFeHY4OGhPa29GM21rbEM0M1NVSTlw?=
 =?utf-8?B?RGxwdHRGZkVaeXRZTnJHeW4zM2YzaEVxTkxPdzh4Z3Y3Y08zdndnaW1JblRB?=
 =?utf-8?B?YmRJTG1KejhYVUJrTEM5YnBheHVSZ05hVnRLQlArQnBLYnNRdnJTYVk5c3BX?=
 =?utf-8?B?bUxaRm9Qd3RHYlVJYUZMbDgyOTNvY1RwK2JtaWpjaEZMUElQQXZ3ZkdnM0sz?=
 =?utf-8?B?ZzZWeWRCUmFhc2ZvU0FjSnFtbHlGbFpNYXZ0T25PaHJKLzVNM1hleThYdXZM?=
 =?utf-8?B?VDE2UytOMEhpYXZaSk9FWUkvclZTUnZYc3psL1YvVUN4YkZjcUMrbks0SzlL?=
 =?utf-8?B?ZG84VUlvT1JndFNRc2pKMFFyRVpOeGorK05SVE4wT1dSdE9sbWtOQXBSSjF2?=
 =?utf-8?B?YlA0YlJRV3AxWWtKamRJSjNjVS9NempuZ2thSXhUUHV2YnVUZTF4bEZjYnlC?=
 =?utf-8?B?Y1BYRCtVWW9rbkEwWFByS3NueEV0cklCT3lOMDFPcnB1VUkzY3VkU0RPcThD?=
 =?utf-8?B?RVRrc1FIcmIyaW1xYkQreXJNWGt6Qkt4cjYwVmhKaytTREVTRGhZbEpPRUZo?=
 =?utf-8?B?bVdBWjVmRFhjVDZvT01rVVhVdjBORWR4RDVpWFlFb1pPaTh2bDREYVRGS3A2?=
 =?utf-8?B?MUpIMUozS3VJOUhKWXlvVjBTZGpMU2VMT0Zma1RQbDZuNkdUSkpzaFRON2Nz?=
 =?utf-8?B?ekpGY1RjREU0N3RITnVYNUZyYjJlUFpGaGxMc3FoMENKVlRkOTN4cVlDT3py?=
 =?utf-8?B?NWZyVFArU1RHNEp5d3QyVlhCKzY4ZnpmSW1LNm95azRvUjBNaUpTRngwUXp5?=
 =?utf-8?B?VENEbEE1UHZUeDQvbkF1QT09?=
Content-ID: <90B9244D948950418CBEE0B19E8CC3ED@namprd11.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3448.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6f54fdc-56ea-444a-ad6c-08d91c155b13
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 05:00:29.6083 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KhcMkW6AKQUzLbyDidzk153w2tGT2BFerjQIx/1l9SZa5EOltnYuYrIvgL6W9JB4gynZZj1bkIN5FabszjdNtLdIYJl0NkEwcUkyctDlMlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2534
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210520_220037_470338_B4976803 
X-CRM114-Status: GOOD (  12.34  )
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

Hi,

I ran into this failure to probe an nvme device in an emulator
(simics). It looks like there is a ~60 second wait followed by a
timeout and a failure to boot (the root device is an nvme disk) with
these messages in the log:

   [   67.174010] nvme nvme0: I/O 5 QID 0 timeout, disable controller
   [   67.175793] nvme nvme0: Removing after probe failure status: -4

I bisected this to:
   5befc7c26e5a ("nvme: implement non-mdts command limits") 

It's not immediately obvious to me what's causing the problem.
Reverting the above commit fixes it. It is easily reproducible - I'd be
happy to provide more info about the emulated device or test out
patches or theories.

It is of course possible that the emulated device is behaving in some
non spec-compliant way, in which case I'd appreciate any help figuring
out what that is.

Thanks,
-Vishal
_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
