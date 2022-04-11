Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25B7DC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 03:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eqdqnuqqnPhEhQdTnKzdKTJKm5NpGWdcfvHerJWF5wc=; b=h4tUqDyXiYHuKD0s+9pZyAWz3f
	r44YpMIt2eaItajLaIZmHqh0wwiHug/fGpHdzQuPaNt/6uyJqZKCQTvpUvI6LgMWF/so/ZYNAJB1P
	gJAyzHDQLjzJnWY6Uf9pujvPPQat4KL5Xrx5vrTgRlZpe5k6sNbxGiYMzhOQ0O1TXznA3lfONdbIu
	ks4d3osQJgZmRtVtKVuZktMiV313ZCjTiH84E58hXOreEvBHAsF/TyCkMjwtQeAoyZjbwyuKs/AH0
	aqiGagZp+gMeBBe7KBs+haz/3HwRCBv54PN6uDWMjyoq7gaB94JGvrY4ZTvr8sFmvW1viLq8JqvUO
	dYXPAOCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndkkR-006TbQ-KC; Mon, 11 Apr 2022 03:29:51 +0000
Received: from mail-dm6nam11on20623.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::623]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndkkO-006TaI-Uj
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 03:29:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7rfbKBxM9GbrbK3hFra/U2gRqGv8vYw/A+eYBS50vGfzOnlXBxSgCxHHZdxC7GAhROfL/S3fEKtXZ3t1YHuRVnHYbF4Xl6pEKeDHHq3DNhD0c8zbGGiNvG0v/ww46KP2c7wkPK4ZkhGLe4X82Q44AttFQgDGQT5oatPQ8Y45IFz+V60niT5RcHimHv5v7a8n3KH6LkYOvEHGTXMcAiwFOoy1QS/kPWUVId9qt407UOwvOp/HPq5n8YkRyFqi+hb+vDpzlZpb26Y46xTc4swmVXmPg/FXfQYqnrcajHISMGVEpQwO0iu3OPZpPZjbaKGC/Xjb7vvOKDx/lRZtAE6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eqdqnuqqnPhEhQdTnKzdKTJKm5NpGWdcfvHerJWF5wc=;
 b=ebj4XjNkqcFmFpMgbsKbCtIy3hRubQwrQ+popc7BGjAPHLTDUVUNEqJ3jREhEW81h4TzGoRZ8Nk7FLRhmNYI+LTy4U4sITK+gpXdRX7xPylp3xwS6zO1surz1lq5nublRfVv4Mu34MBCFfp2l7LFntrP4S2hN8ZnyJL0151pGQkEwBK4RU/HXrwxMUFPNTnh5FejDq9rQqvLAlk3tXYa63D4v//ZIVwW0jzbQMtbvcrMtRmK6aULS+myS8LcYx2+p7C8q0vlFcbR7m1EuvkD0qyH0TmGk8qOpy8w1HQ/7YDa6q8g7MU9EY8LYeSq30T8cw0otxmFq98QNPDzWjsGHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eqdqnuqqnPhEhQdTnKzdKTJKm5NpGWdcfvHerJWF5wc=;
 b=TXiI0b90LKPqOJpyepdX9M7PY+RU/H2tRkpahdKD/XAY1VA80i+kav0Q1VamJRgWkv7uIdLhKy7z+0nfAZH9crxRilXi4HO8GocrMY3+1JC13vRjbkCU5sWuO7sXjOeRkFkX51hN5acJZu2sdwec0QzpBjIopWc8MClN6TFs69Ku+rd9ZOuLtOXPbk+PUGYvry4HJ86TjMhOkRHSofVGJ8iAkbRK7IPSUOxitzDvlHL9mGcN7bXfJscDjdTlVij4lvWfvvpFoczw+pwIvMVtIDvP9ED7G6yCAoe6mjZvKMmReoQHz6qSn6G/kRjHjtqvBdAArtP1upulk4rkBjrMVA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB2337.namprd12.prod.outlook.com (2603:10b6:207:45::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 03:14:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 03:14:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 0/3] nvme: fix internal passthru error messages
Thread-Topic: [PATCH 0/3] nvme: fix internal passthru error messages
Thread-Index: AQHYTVIErUO/Fh4VmkiPMdJ6tQ4U/azqCdQA
Date: Mon, 11 Apr 2022 03:14:20 +0000
Message-ID: <100b676f-8da0-bc2a-ce74-2d30490dacb2@nvidia.com>
References: <20220411031235.5085-1-kch@nvidia.com>
In-Reply-To: <20220411031235.5085-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ced8d787-78ba-49ce-6bc4-08da1b695f4a
x-ms-traffictypediagnostic: BL0PR12MB2337:EE_
x-microsoft-antispam-prvs: <BL0PR12MB2337F4B30A64A0BE89ED16FFA3EA9@BL0PR12MB2337.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1C6KREv7JHAbvx+E9IohZBQd9rXl7XlERhmfakdI5oveLTSJQ40KqJIDe1JYdmJsnLzWwgOnsons88/dmbBqLJfIVLXpZKA5m7dhccbKyBH4sCvSMvGBV526bK3FdOfalfxvOKDhhxGigocCcUl6meRvhUUpyWi6WyJxLGABAd6XHWlMM8Z2a6lRcwO2Puh98C6vQmDP4qHhQDO2GKe1BrcGzSDLf7gy5Q1VwpKhvSLpVImij4kwcdpK8zE2La49yJMjaaj7R3lpJmWZu0mrIOiOckQf2QmnlhVLyY5pn0SoFJQ2AeVYNsXZAQFAkmOdo2cQciVWA+ZhHluJOhUDXiHCJ+E0SSG6NYIcVy1eqzNlI/zpm5pVxxAknaNwaa1tiiif+AkcpE6zkZYKIk65OQxdFisjg8FAy5Kecm9UsCRYx038ZTlWloILCgcF1JM0NQTCMKNsZN7oSS+2QxWLODW09b1nV9P1ybjC5RE8h1WD/ESH7L2KvTcUrH+JjHvkXZzXOFYxXBwNoe2auNtULqqzAB6AT5FTg6+eeJchJFPrWNL5rxH3C6BoR/THIXi0bW3RfsgT0Fkv7WSjlvRCnMgkjmLIYR8wqxhHAy2J3Iqmy/Bg/k2TXgHGrwVNJKaeYJYOjY0aAvk6pGEvhAv813Z9NSqSy8vkVzKWSDYQs/wO6eL/QO9fPWaqVEXeFjx9Bm/6VIU8iTXX3uiFRIqrEr5utOaWrP6eXlNt8bCF5g66Qn5JHzLs9aV0uvAAw82wrkgr/Ez9u8tPthj6U8mrmg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(4326008)(64756008)(66946007)(86362001)(110136005)(66476007)(31696002)(66556008)(66446008)(54906003)(8676002)(91956017)(316002)(76116006)(122000001)(6512007)(53546011)(6506007)(71200400001)(508600001)(8936002)(6486002)(38070700005)(38100700002)(83380400001)(15650500001)(2906002)(36756003)(31686004)(4744005)(26005)(5660300002)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWNpb1lseUhvU2xqaFp5UTBWME9rRTRlVzdQMnY5VThRc25wWHVBY1JmRE9m?=
 =?utf-8?B?K2pNTGh5enBtbXZYOGY5QXZERmxxS1l2aURTOGowNlQyT2pyYm9Nd0VoUktI?=
 =?utf-8?B?a2dBMUVKQ1VoMGFzdzdkVHZIeUFlcS9hdjFKWmZ0aTh5NnlQS2FaL2Z6U1do?=
 =?utf-8?B?ZFA5dktKeFR3K2ZoZnBubVJCbVl2ZWRzbElONDVnU01tWXpBM0xTaWRjVGhS?=
 =?utf-8?B?VDFMYzdQVllkQ1FVUVk2Vm1KNGhQdkhQTXE5MHdnMWxBZ094YTJaRkpYVkxy?=
 =?utf-8?B?c09oUEtpaURXZy9XTm51TStKM1luMFJTMWswK0dwdU9Fc0FwZUtIYjY4bTBn?=
 =?utf-8?B?cEhSN2xUeHQxVmI1ZldVNm9vY24rR0xLNXhId0lrTGlDbTNUcjd4OWxKYUNW?=
 =?utf-8?B?Um0wa3h1U2lvejc3YVV1S1BJbEZGZ1MxSzlaNEtFN1huekFieGp1NnkvbWtT?=
 =?utf-8?B?RWZ0T01XaWVkVGVPdlp4RkJEY2k3NTd1Q1lRWnBmUjVSNUtGYmRtNEhOdVdD?=
 =?utf-8?B?UDdpVUNPU1VtK1loamcxRXBmc0hUc3NIVjI3OGEzRjJWbExJMFpMRW1wMUZz?=
 =?utf-8?B?a2F2U1BwZ3A1N1lJNFlISEFPSk1PQUpyc0FGNjNQUms0d09GQ2I3dXBjeDRm?=
 =?utf-8?B?VXI0Sm15ajVHSW1oTU9iTHptSExvc1RVMWNFa1k0Nzd2WVlHVUNZdkRhd2o3?=
 =?utf-8?B?b3RxaUsyZzVGeVNvMm1qemZPNjNURVpmYlJkWEgzT04yWXB2Ylc5Slp5djFO?=
 =?utf-8?B?cG5meWR6K3duY1dNTU95WkxYY0VTQmRYYzBxekdHZXNjTXV0UFhqZXI2YXVF?=
 =?utf-8?B?ZXRyWHJBTCtaNy93bEcrSVJ0RDdXakFKakc3TklZczlGWmlubFZtbjJsWEl2?=
 =?utf-8?B?YWtCVnFUcmdhVUNzT0xnZ09jZlFrUCtmaUxmS2pBaUpUeGtCWk9JRFd4bnFn?=
 =?utf-8?B?azF6aFhjQTdJVWx6bGFpN3EzMktJQlFRTUgrN2FRaEFDTnVUYzVnd2phaWdI?=
 =?utf-8?B?cElyYjNPTUNYSVNuNEZnNmkydnNlTlpodStMYWRJOE5SWXppNUNubm1Ib1Bh?=
 =?utf-8?B?RmJvcndpNDJ6NTBKZjJuNUJ6Qm00aFVQTmdXQmU5bGw2dWxoS2lwcUR4SHFT?=
 =?utf-8?B?cVUzNGVxR1E0UHF6VSt2RHFWYk82czVFemM0T0h6dG9VUlpqT2l3SG5XVlFv?=
 =?utf-8?B?UDQ5UldrTDRSc3R0YnlweUpsZEQ2MHU4WitiUEc2b3BPbmxycEFaQjlNVEhN?=
 =?utf-8?B?U0EvaUtEYlhtNCt3SjM3QlJmWjZWa25QRzhMaGFja3hZK1V0Ty9nU01qWS9j?=
 =?utf-8?B?UDFMNUhwb1h0S0w5UE8wQTZldDNYOG1sTDE3WStia3pOS1pGS2h0d0UvNVRn?=
 =?utf-8?B?S2dYOU1JSTZIWHoxK3ZGZGVZbWxKN2Z2L3NrRVdJSnp5OGdPMjdmNXJFSk9N?=
 =?utf-8?B?cFJGN01GRUZ5b0R1TGg3dDZoM29qVXIxcjlIYlRuL2Y2N25jdmVYMUEzSFpl?=
 =?utf-8?B?cG1EZXRkNzBnM0xsMExBTW5PYmpkVmJFTDRCcnRKYjhXMjdCTDQzOXpXTHp3?=
 =?utf-8?B?ODExcWg3VGNIRkd1VEFEelI4WTFWWDNjd0pUVFZGK2Q4cmxhY0pKUUFhWDZ4?=
 =?utf-8?B?V0l3cDR3RzRvSjFtY3pHdzRteFpWSWlHVkROT0dIYTZPaXdIRlFWSlAxUUtm?=
 =?utf-8?B?c09rU29MWlVreXRtTU9ObkNyZUhHL3ZVMWxQT0dmS1ZKWGxNK2ZUK2pyS1Vo?=
 =?utf-8?B?citFcTd2TjRMclMwUVppbXd4d1IvQkl4MkRrOUZNV01BeVNRVVJHQXE5MG1I?=
 =?utf-8?B?NWR1TzZtb0F5dzk4WC9TelZvMCt5RnlvVzFFM2hTajlWZFBRYktEYVF5SklH?=
 =?utf-8?B?ajNuZUZIRVlPckJVVXFDME1ReG5TQWZUY3pBdDg3TE5CdGRRVy92eGV5RDUx?=
 =?utf-8?B?M0U2bnE4cTlUQi80YUlybnVuRjQ5dkMvclowTWVNU3E2dlcyOGFhcjhNRGV2?=
 =?utf-8?B?dUtFUU1xb1ZSQlpkQWVaUzRvMU9JRXNEQUxHQzRhd3RvNWFUbFZTa0I0L1dS?=
 =?utf-8?B?b0Q2ZkhoYU0yRjdiV0RuVnMwMElEMmJEaGFyU2grT2dsQkMzaXVOenFUUld2?=
 =?utf-8?B?bDRtS3VzRHBGQk9sSlNqK2Y5T1RtS09kc012eDNHRGdWb1graDBNaXZTKzgx?=
 =?utf-8?B?Q2pOOTFlV1IzVVU2M3hFVjdBbUJubXE0d3hrYXpXRUFWN2RQU1VJdWg0eisz?=
 =?utf-8?B?allWUDNaa3F1SmFQWHVEQzVlQ3Rud1JTRWs1SXdvTGFQRWZNdjltMENNanIw?=
 =?utf-8?B?T0crYjJ6V2c2d3VuQTB2MDgvaGZpS3RIR1V2N3dQV2wzbUVHbmFVZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <930285703D858D4198B2764F6194481C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced8d787-78ba-49ce-6bc4-08da1b695f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 03:14:20.9794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Y0XKtbSwXDr2zbBp+xeTgdZs18OX9MpbhjDp5LQ6D8YjDlLYu2P+q9ECqwj3ZhtRFTtFNr29klrTgdpVPUbQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2337
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220410_202949_029473_4C60B26A 
X-CRM114-Status: GOOD (  10.81  )
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

T24gNC8xMC8yMiAyMDoxMiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBIaSwNCj4gDQo+
IFNpbmNlIGFkZGl0aW9uIG9mIHRoZSBudm1lX2xvZ19lcnJvcigpLCB3ZSBhcmUgZ2V0dGluZyBy
ZXBvcnRzIG9mDQo+IHRoZSBlcnJvciBtZXNzYWdlcyBhcmUgcHJpbnRlZCBmcm9tIGludGVybmFs
IHBhc3N0aHJ1IGNvbW1hbmRzLg0KPiBUaGlzIGFsc28gdW5jb3ZlcmVkIHRhcmdldCBleGVjdXRl
IGlkZW50aWZ5IGNvZGUgcGF0aCB3aGVyZSB3ZSBkb24ndA0KPiBoYW5kbGUgdGhlIGNhc2UgZm9y
IE5WTUVfQ1NJX05WTSBhbmQgaW4gdGhlIGhvc3Qgd2hlcmUgd2UgaXNzdWUNCj4gbm9uLW1kdHMg
bGltaXQgZm9yIHRoZSBkaXNjb3ZlcnkgY29udG9sbGVyLg0KDQpQbGVhc2UgaWdub3JlIHRoaXMg
Li4NCg0KLWNrDQoNCg0KDQo=

