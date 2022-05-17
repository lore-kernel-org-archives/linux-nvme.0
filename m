Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDB7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 22:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+SQc0rQRpnwiLrsstU8aT1dfMKd//Bv4iM6Ma5ZM/tU=; b=mQKKw6fC6WMYm6DIlGzIGTAmSo
	OW+HdgHxXl+Wji5xDB1KdC69BgbtKR1HwsL47pxwSVp9Vzz5v1ToER7C8hw+LVIAF4Lg/dhvNYm7Z
	Muhcnomnb5f8SErmhP6I5w/haCp8gdkwB4OYjO/fPdi5axZ1x/EIK5SjHsO5t5mWmAiyHeqlXqiMG
	nVOrTKVKc5ac2msQZBQ5+u7CsbXjyXDk9zy5Is4v1hJdEpG3muTmDcDwp2q5hX87maqKFLjuBnF9J
	z+XazdqkJ/OHCHYSMGSyaFQ9ngaMem7STNZ0g25GsFQCv/VJ0v6dw1vTi+2GXsbmCqps6QEX+lFYF
	yeopUMpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nr5tD-00G9G3-O8; Tue, 17 May 2022 22:42:03 +0000
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::601]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nr5tA-00G9FX-1c
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 22:42:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8Xo4czuHvfaDTrAE4DB3j4kaTv793TeTDcLWZOArn2toh0CJZ0Xpc60pEpnbIjXDpN7UrzfZvGIeX+j8qnVcJGtMptq/LhZx1cyhiXS07kSObR0EX61jSXxGaW3aAmKVI/Hubv0r9tVmepH/F8gbsmZSBQed5mmsQV/TvCthk8oMiv2vhgsu2JVdjrKmc/CEq9yKP7L3Z9XfH2HmYRFIaTxihDFjFq7o+2Kv3zohBawopePz9OPjtqBbYzFuNTZLSD8+NUMvLZ4Jm57i9arcVknxBJ6rWqMtk86Oqqwpl4mT4JPtXJ6JAHnmEzs6R0FDR37PqOcWqmXJBDgsePz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+SQc0rQRpnwiLrsstU8aT1dfMKd//Bv4iM6Ma5ZM/tU=;
 b=AZyXBPYShuCeRfa6BglVWYD55yV0mEYC5i6F97Cd3T2ptiPvhm//RfdkXVEYeDpI+QIMHDxm/C+0F+CqZVwKcjFYs6gjt+WHeP/xhvyzm3MusY7W1HBSUYJwjhR6GkuIXdrve//ZKYSx7ufZ6BQnLgEwel3QOvlE5innJTmCUsJKSTRb0yTvWuXrKAenmlzUCxb40kZ89X8WuQsG1gdKfRAgXY1T57tVvf+CQrgvTkbqOQh9tBjkWhKvzTwXD0eztjog1GtulUGxyixS3uxFd0qBaN4dxKjlxhXII/0g58eDONDwfC05mPEMuzo+uGAYsBpPOGmFKB0xhvzhQxmv/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+SQc0rQRpnwiLrsstU8aT1dfMKd//Bv4iM6Ma5ZM/tU=;
 b=XR9USUAceIxj+tex5t9Upr1Iu6m9J7Supcphqb8pMHyTPKB6RbPzvwenSKHQuNALt/S1uQ1YbRcRokQPKE2wjqcr53FmJ0reHQOm1jvKWNqHjg/9H3tNJR7+BgYKOHrneOFlcGYAfRJEL44l0/inpHnzzCy8NW92/3T15UL969xdk05ZDAI+D7VsiTtTc/6PaY259FGJ+68ESUYiqwaWfX24mUMTozquXxqDvKibAqlscMkpSG8v22YOxURdjdbJzZcNmgX/9dYlbsaBR8B7ByffgPM7SG7zO/ucAZ9lflSPmMXMiTeaeNCnnmoSRJv8RGVban6rCXtHawHhJoAMzw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 22:41:55 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4925:327b:5c15:b393%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 22:41:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, "james.smart@broadcom.com"
 <james.smart@broadcom.com>
Subject: Re: [PATCH] nvme: set non-mdts limits at I/O queue creation
Thread-Topic: [PATCH] nvme: set non-mdts limits at I/O queue creation
Thread-Index: AQHYabJt97Qh9I0ok0uE3+uQMdd9La0i1UWAgADV8wA=
Date: Tue, 17 May 2022 22:41:54 +0000
Message-ID: <955bc8aa-dc88-68a9-c656-51e52fe589f6@nvidia.com>
References: <20220517055312.50331-1-kch@nvidia.com>
 <dd46fded-d213-6956-8f0a-69a70e0107d5@grimberg.me>
In-Reply-To: <dd46fded-d213-6956-8f0a-69a70e0107d5@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1978194-94cf-4bd5-30a4-08da3856717e
x-ms-traffictypediagnostic: IA1PR12MB6332:EE_
x-microsoft-antispam-prvs: <IA1PR12MB6332E94C2CC6F3AE8F1079C1A3CE9@IA1PR12MB6332.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ERuTo1p6DiiTbXtRcJggAcwCSi1KT4HwDB85z43Y2bIy+TKU6k5QraJ2SmnWkES1amU180bJJyoBAf2uKb1ICXS9dMua6LDVvE47R3hTVf1DKigiaANc9qfSqU0GTpVUNW4aD+Cl1mlg87TXKP3jewzbNhSKikk6eqm109gRJOLsEJRVKrlh2MJzB7pv/Lbt/llX6qkDfG6qUhJFzokVn4G+Hw0veWxxa0Smv7+TPqZob6mpaF2tjn25S6/Bea/0cRIMlZmUGyOjavs2hIklwpbcIgcWWr7PtUwlr85vF3BaAe/vbgiPT/u3uME34G4CIPcR478BzwZLmT+jH8OGwBn8yk1i9ze3qUyOeo7TjjQlS5LHyzx1FWR8Kf87xcW7ex3I1yggOcyKSRgwae4Eeyw2ul2cMQWdi99Vpt3oVdnUKstf3e3NeDo6qpzWrVY1jczwrD/Qh0cjajvs78SNW1Mk1dgqvyKfUpoO/v8FohhXoWLOsyP8fjatnfxwzCrSCkgKpw8naHJVGcGmbLnmkDln4qPtdCMLgZc1E6QNrLDAPqFhHXGC38Eyjj9jDz61TmdMBd3woFTs4HuLfG2SoE9kfDfsx87XoRSOyP0XM5v+LqOzGj7A67EODkCnT8rdqzHHX9MP1eE5x1hXFL/mE5RZpyAQSfzYtmCk2qC7b+bynyDpDu9I+C7Tes0I4l265r5K8J/2ZubfIHNXDupjQAV8rHoIm68VobOQliXP10o4ODVuswrUx4G7M6C/T/h7NFXqzVQQrncIVMjqA8LFTQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(316002)(53546011)(6916009)(66446008)(122000001)(66476007)(64756008)(38100700002)(66946007)(66556008)(76116006)(2906002)(2616005)(91956017)(8676002)(4326008)(38070700005)(31696002)(6512007)(186003)(71200400001)(508600001)(6486002)(31686004)(5660300002)(86362001)(83380400001)(54906003)(8936002)(36756003)(6506007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SW84dlA4UEtBUk85RVhHcWZNODhvOVc2NHVrTnlYaFFKd0ZmTGRETUs3ZkxZ?=
 =?utf-8?B?T0p1L3BMVzdRcC9UMmpBWWlBUmYwcktjU2FFOUlPMnIyVUFEQVowTkR5bXlV?=
 =?utf-8?B?V015TG5hVXNza05rVGltNUthWGxJYWUvbHNaUFRUalNiM0RnMFlsRFB4czB5?=
 =?utf-8?B?MHZEejAwM3hLZmVSNW1CYjJQVktiRS9PR05meHJZeko5Wld3WG1PMUIwRkhB?=
 =?utf-8?B?Ty9FRE1uVGdHR2p2UDJhK2kra1BIVSsvdFIrNTd5Vk5WUUlmU216OUNnclRD?=
 =?utf-8?B?UDluYmc3aWtaUnZ1OGNiVGIyQmJJSUJPUSsxQUlGblJXeVEwbUtZdXZyU1E4?=
 =?utf-8?B?ZVV4eXVFb3lNc3FPeUxQQ3NOdmRROTR2VmtqQnhqYXFUMGUrckR3MnpBbVA5?=
 =?utf-8?B?YWl4YkNPSUJVeWowVkxIdDVMY3pMV3dSMEpUVTk0NHR4aWlaUS85aTJzbGY3?=
 =?utf-8?B?dTFIMUw0c0FGcTluVFh5M0lqZW5Yd282aVVITElQWGVJWjR5aGVaTzI0Wm5D?=
 =?utf-8?B?OHYxdU4xaWwxcVJjMU53anBSQXB6bmJnVGFMTG42WCtuUS9hbWorVVBqdzRQ?=
 =?utf-8?B?ZnE4MFFVWHhMRjdEVjNnREtNbTYzN08vNEVTSGJXUGxYRnUvekhjV3JZNTRo?=
 =?utf-8?B?anVYYVVwdUdQWUoxbkJDdTR0bk9qenUyYmE3a0FYb050djRNUDVZbS9ESjdK?=
 =?utf-8?B?VkFDRGVzU0hkRTFKRlRSZVVrVTh0VTFIZHM2cGt3VmxaT0RnMnQvam9XcFZP?=
 =?utf-8?B?c2t6cUFYc0dvTkhYSDI5M2JPUlZDTzd0TGNiLy9UU25SaTNvUVphZGhicE5D?=
 =?utf-8?B?VFpnTVdheHpIQm1EYmQzZTBKenNncHFtK3BUQW5tSHFoazBMcjhTV2FoeUtz?=
 =?utf-8?B?U3lIOW16cTVKaTBZQmpXWGg3dUJRNjBlcUk4Vnh3WDh2UzMxUnZHKzlhNU14?=
 =?utf-8?B?Y0R2WjJsZ0UreWNUcTNoS2lZb0FmN0h0aW5lVW9TdkxTWmR3MEZKQXhTM2Ur?=
 =?utf-8?B?M3dhWDR5R3ozSWJmQ1JqelBNVUZkUTh5MUc2dVMzZVZLcHp5V3pwSFExWDI4?=
 =?utf-8?B?VXF2L3lHdWdDKzQyMExCRnRsVU1XWkpBQ3NlYVFWR0VXWTlxa3VkMXZQd3VI?=
 =?utf-8?B?NnFhU2Z5cWk3TWVwZE9uOUlqSGVNT0lZR0l0dm5WU2ZJbTNxQWo4V2RGZTBI?=
 =?utf-8?B?ODVZQWtkZkwxaUdaU1BRbTJ6MHBsdlpXWCtpYWd0MFIxYTl1azIyT2RFemY0?=
 =?utf-8?B?R0NFK2RGWW9OQlJDdXBDejZLbnAwT0hJd01QcGRuTWpwV1F6M1pYaDNnMU1r?=
 =?utf-8?B?Y21rTHY5aENQdG9xekxmUm8yZFM0QzBSM0FuMEhDZmUyMjFTb1NoR2s1K2VE?=
 =?utf-8?B?a3FEM3BYemdzOUFMR3EyTkh2bXFGL0ttOC9pQkRrakRBeVZ4SUx4R0lBdTUw?=
 =?utf-8?B?d0JCL2pUdWpDRVlHUUFMVXEwNE9CeE9DQTZBQnlQSk9OaTlqQnRWc3IwOXVi?=
 =?utf-8?B?QkN0Q3dkeGY1KzN1N3JmMnZwZUdMRVNvenpDQnplQkswS09JWlBiK0xnN2FI?=
 =?utf-8?B?cGRxK2dSQ2lnakptWjBnZVpxdHQzNERyQTU5SFBaTE5pQ2NYZ2ZlMktpa1Rr?=
 =?utf-8?B?R1pkVlZRelVjeHNzSlVOOVpaSUdZSms2OVRWdmRIZmw4am9qQzdrSUEvNi9H?=
 =?utf-8?B?TFBLU01SK1VKOUtZSjRtTDhLamRFNXBleGlGTXdCeWpNRzd0eTJjT3FKVHJV?=
 =?utf-8?B?ZVNON1Izb2I5eEtPblhTc0YwaGdrVngrRXZIb3VWSzhWSmFWTkgxbnNTNHRa?=
 =?utf-8?B?MFBIMER2SEFUMm1GT29OQ0JQeVZMT002ODNUVkZxcmdaMHkzTWlaZ1pCYWdZ?=
 =?utf-8?B?Q1NqeHU0dk1hWVM1Uk5LajJKUitnQU9HMWJ0ZklObVhLcTdjSTlWS3AxTHhU?=
 =?utf-8?B?TE44dSs4cStzeXMxYi83TGg4cjVhdDdiTTNqU0g5RXdXQmQ3cmVCVkxxcWhz?=
 =?utf-8?B?akdrb3Y3VDVjcGVCdDFkMVRKVGNoMFgvNHZkMHBTVGUrN2FJT3Vmek9ET1Mr?=
 =?utf-8?B?ZkZ6d1JSMGVWZ3Zkd0YyaTBERCtJMHZ2aHVBVnAwcmdUVjNFa0lqNjU5UzJ5?=
 =?utf-8?B?dGxXcnhhbTFWMkxwQzBGZllsVFpiUXFaZlF5OU5rOVNWN0l4WEluVjZjOVNh?=
 =?utf-8?B?NUxsaGpGR05lWDNYTHEyYTJzT1hWMUtNeFpPMVBpL2ZRQmxjNFAwUHBTMndJ?=
 =?utf-8?B?ZXcrM01QNnlUd1B4a2I5VHFFQWdlaGY2NlFHK2h1ak5qU3VMUEYwbEg4VGs5?=
 =?utf-8?B?TkwyK1hRdHk5c3FvOHplVDFyT2NMYzdRMlNwWXppMnVhU1FCam1LeHpBRGZj?=
 =?utf-8?Q?aTfn+qf3FFXVjhrsqM6AqahnT7LTWvDu+m/PQXaVDFfqq?=
x-ms-exchange-antispam-messagedata-1: 5jfaIfjr9h667w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <255CF5999C199E47835788B2FAEA66CB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1978194-94cf-4bd5-30a4-08da3856717e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 22:41:54.8316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jdjD04fg1hgMUB9ks7h4FSVWwUPs/E3URHEGL2Wew57+vPdOI8CBViZ1WJdzsHbyfkR/kLV0u/nLf0SY33EJpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220517_154200_325690_5E494FBC 
X-CRM114-Status: GOOD (  14.11  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNS8xNy8yMiAwMjo1NiwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gDQo+IA0KPiBPbiA1LzE3
LzIyIDA4OjUzLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBJbiBjdXJyZW50IGltcGxl
bWVudGF0aW9uIHdlIHNldCB0aGUgbm9uLW1kdHMgbGltaXRzIGJ5IGNhbGxpbmcNCj4+IG52bWVf
aW5pdF9ub25fbWR0c19saW1pdHMoKSBmcm9tIG52bWVfaW5pdF9jdHJsX2ZpbmlzaCgpLg0KPj4g
VGhpcyBhbHNvIHRyaWVzIHRvIHNldCB0aGUgbGltaXRzIGZvciB0aGUgZGlzY292ZXJ5IGNvbnRy
b2xsZXIgd2hpY2gNCj4+IGhhcyBubyBJL08gcXVldWVzIHJlc3VsdGluZyBpbiB0aGUgd2Fybmlu
ZyBtZXNzYWdlIHJlcG9ydGVkIGJ5IHRoZQ0KPj4gbnZtZV9sb2dfZXJyb3IoKSB3aGVuIHJ1bm5p
bmcgYmxrdGVzdCBudm1lLzAwMjogLQ0KPj4NCj4+IFsgMjAwNS4xNTU5NDZdIHJ1biBibGt0ZXN0
cyBudm1lLzAwMiBhdCAyMDIyLTA0LTA5IDE2OjU3OjQ3DQo+PiBbIDIwMDUuMTkyMjIzXSBsb29w
OiBtb2R1bGUgbG9hZGVkDQo+PiBbIDIwMDUuMTk2NDI5XSBudm1ldDogYWRkaW5nIG5zaWQgMSB0
byBzdWJzeXN0ZW0gYmxrdGVzdHMtc3Vic3lzdGVtLTANCj4+IFsgMjAwNS4yMDAzMzRdIG52bWV0
OiBhZGRpbmcgbnNpZCAxIHRvIHN1YnN5c3RlbSBibGt0ZXN0cy1zdWJzeXN0ZW0tMQ0KPj4NCj4+
IDwtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS1TTklQLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLT4NCj4+DQo+PiBbIDIwMDguOTU4MTA4XSBudm1ldDogYWRkaW5nIG5zaWQg
MSB0byBzdWJzeXN0ZW0gYmxrdGVzdHMtc3Vic3lzdGVtLTk5Nw0KPj4gWyAyMDA4Ljk2MjA4Ml0g
bnZtZXQ6IGFkZGluZyBuc2lkIDEgdG8gc3Vic3lzdGVtIGJsa3Rlc3RzLXN1YnN5c3RlbS05OTgN
Cj4+IFsgMjAwOC45NjYxMDJdIG52bWV0OiBhZGRpbmcgbnNpZCAxIHRvIHN1YnN5c3RlbSBibGt0
ZXN0cy1zdWJzeXN0ZW0tOTk5DQo+PiBbIDIwMDguOTczMTMyXSBudm1ldDogY3JlYXRpbmcgZGlz
Y292ZXJ5IGNvbnRyb2xsZXIgMSBmb3Igc3Vic3lzdGVtIA0KPj4gbnFuLjIwMTQtMDgub3JnLm52
bWV4cHJlc3MuZGlzY292ZXJ5IGZvciBOUU4gdGVzdGhvc3RucW4uDQo+PiAqWyAyMDA4Ljk3MzE5
Nl0gbnZtZTE6IElkZW50aWZ5KDB4NiksIEludmFsaWQgRmllbGQgaW4gQ29tbWFuZCAoc2N0IA0K
Pj4gMHgwIC8gc2MgMHgyKSBNT1JFIEROUioNCj4+IFsgMjAwOC45NzQ1OTVdIG52bWUgbnZtZTE6
IG5ldyBjdHJsOiANCj4+ICJucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzcy5kaXNjb3ZlcnkiDQo+
PiBbIDIwMDkuMTAzMjQ4XSBudm1lIG52bWUxOiBSZW1vdmluZyBjdHJsOiBOUU4gDQo+PiAibnFu
LjIwMTQtMDgub3JnLm52bWV4cHJlc3MuZGlzY292ZXJ5Ig0KPj4NCj4+IEV4cG9ydCB0aGUgbnZt
ZV9pbml0X25vbl9tZHRzX2xpbWl0cygpIGFuZCBtb3ZlIHRoZSBzYW1lIGNhbGwgZnJvbQ0KPj4g
bnZtZV9jdHJsX2ZpbmlzaCgpIHRvIGVhY2ggdHJhbnNwb3J0IHJpZ2h0IGJlZm9yZSBlYWNoIHRy
YW5zcG9ydCBjYWxscw0KPj4gdGhlIG52bWVfc2Nhbl93b3JrKCkgZnJvbSBudm1lX3N0YXJ0X2N0
cmwoKSBwYXRoLCB0aGVuIHByb2NlZWRzIHRvIHRoZQ0KPj4gbnMgYWxsb2NhdGlvbiB3aGVyZSB0
aGVzZSBsaW1pdHMgbWF4X2Rpc2NhcmRfe3NlZ21lbnRzfHNlY3RvcnN9IGFuZA0KPj4gbWF4X3dy
aXRlX3plcm9lc19zZWN0b3JzIGFyZSBhY3R1YWxseSB1c2VkIGluIGZvbGxsd2luZyBwYXRoIDot
DQo+IA0KPiBXaHkgbm90IGp1c3QgY2hlY2sgdGhlIGN0cmwtPnF1ZXVlX2NvdW50IGFuZCBjYWxs
IGl0IGFjY29yZGluZ2x5Pw0KDQpudm1lX2luaXRfY3RybF9maW5pc2goKSBpcyBjYWxsZWQgYmVm
b3JlIHRoZSBJL08gcXVldWVzIGFyZSBhbGxvY2F0ZWQNCnNvIHF1ZXVlX2NvdW50IHZhbHVlIHdp
bGwgYmUgYWx3YXlzIGVxdWFsIHRvIDEgd2hlbiBjaGVja2VkIGluIHRoZQ0KbnZtZV9pbml0X2N0
cmxfZmluaXNoKCkgYmVmb3JlIGNhbGxpbmcgdGhlDQpudm1lX2luaXRfbm9uX21kdHNfbGltaXRz
KCkgZm9yIFBDSWUgOi0NCg0KbnZtZV9yZXNldF93b3JrKCkNCi4uLg0KICBudm1lX2luaXRfY3Ry
bF9maW5pc2goKQ0KICAgbnZtZV9pbml0X25vbl9tZHRzX2xpbWl0cygpIDwtLS0gY3RybC0+cXVl
dWVfY291bnQgPSAxDQogIG52bWVfZGV2X2FkZCgpDQogIG52bWVfc2V0dXBfaW9fcXVldWVzKCkN
CiAgIG52bWVfY3JlYXRlX2lvX3F1ZXVlcygpDQogICAgbnZtZV9hbGxvY19xdWV1ZSgpDQogICAg
IGRldi0+Y3RybC5xdWV1ZV9jb3VudCsrIDwtLS0NCi4uLg0KDQpBbHNvLCB0aGlzIHBhdGNoIGdy
b3VwcyByZWFkaW5nIGN0cmwgbm9uLW1kdHMgbGltaXRzIHJpZ2h0IGJlZm9yZSBJL08NCnF1ZXVl
IGFsbG9jYXRpb24gZm9yIGVhY2ggdHJhbnNwb3J0LCBzaW5jZSB0aGVzZSBsaW1pdHMgYXJlIG9u
bHkNCnVzZWQgZm9yIEkvTyBxdWV1ZSBhbGxvY2F0aW9uLg0KDQotY2sNCg0KDQo=

