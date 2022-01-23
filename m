Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E49FC433EF
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Jan 2022 23:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PD/npWym33diuvCoDT/xpA50KA51aFlRCXfe82Ovk0Q=; b=1c5EiRhApTCCNrkeC7Pu4AevA1
	rAv2JEzAG+VU8oM7+dVYjBaFe+Cv1Wk0AFnSnK5TNeid17UrtgnsfnpfaZMHpeJNjXwL0MInWje/Z
	zKk/pML5rN8PPI2xEsus0nLwcIylzU3y6dprPVYweAFlCEcazwIdnNec8bupMupkn7LbZPd/+PNIm
	a8R79aKw/1Sln4S4D3RwGbL+/Q8OMCqWsNYPnRwBLUGu+QrAmPaGmpk79aV6H2ySs5tPUVoP0Yj8v
	4PPu0wYH/D8WQjEUhpQazDaYs5brg2Aqbs+iIcdEuOC6iARTVxTpGDk4nDmDSxGhnPk9bhyR+yeRZ
	d0dtaB2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nBmQm-001vdr-2E; Sun, 23 Jan 2022 23:37:56 +0000
Received: from mail-co1nam11on2047.outbound.protection.outlook.com
 ([40.107.220.47] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nBmQj-001vdT-1L
 for linux-nvme@lists.infradead.org; Sun, 23 Jan 2022 23:37:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsy6duJP0QzsjQf5tA3ruT7+jjgNFf57QbWAgAGiOuxv1q5BCWUc2mI+t8bv6sd4Hwzb2z43vMmSSP3TBhYTzwsSrjB1Ht6j3aRxev20i+lpqAH2AS+nJY8IyOvtHafqCkUy5uv9ACPXzppxTs9MEk0CUWuUx5t2hC8cnnE81N+Oqs61Hwdp+Su+BaUDzTcS03YX4I8Kb8DqRcYkcp3WRachi1D82kfRcjzY6Dm4uj2/Pl9df17c/XOZ5MgopLpwWxZ2Ik4FHYzlEvhbOfYViWPAuUg7PSIxC8MsCjwDcc+MAsBvtX6MOXkThYKsAhuf6OxOiWNInDBGyZDXl3RELg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PD/npWym33diuvCoDT/xpA50KA51aFlRCXfe82Ovk0Q=;
 b=mSIRpDJM0fmEUxpWJg9ViAMmJQw0LjhX2vB2Jq69IJzeGOV9A98ric3mLFnAaia3mf5EKaxJxiA45tOeCfdyhOxvbNRgX0lJpHj/waVjcFU+UEEQLDU+X3/odOQNPNYak6hOj2amV/oUNepwd/Rojwj773EpOwsK4cU2iCYOVs0zMRmJYxZpm6YiP6QOmiZEnBoR00V/tVp+SVpJqn5VMif8BMwKCGrHp0pGzOMXdDJH4MnyaB+5XTIPyPMqL9FwA1FV3cYQ1ziLv4VAu7340Z2rx41EOK6EmZEs/nGhk8Nllgg8tqcA/5TuJk6SVNgII71YTL5LXII4BpBNDBhSQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PD/npWym33diuvCoDT/xpA50KA51aFlRCXfe82Ovk0Q=;
 b=h6t24NHCUM8E3y6hH/5CZw6YM8DE+x0z6V+8v/Bo8Bh3BCq2nGj0DCNj3rhRhAHWrQqMJYgD7GlOS0uI+FL+kKGYuTasACJDNu6Bk+vXe3aWnjdfpnUX515ls7eJ7OZQYLCafZrCZDch58erxOrbu+sl+1L1F7QWl4KIXTI6f86lWzcjPYtez22EA4BZ1v8Ii17HsuugdcNCvRlisJXTIPMD0e2D/AsKT1KeRuJt8Q7nq7A9bgxX4nVxcw4tKF+eswFOyJvWI4d+XZ5zm53I1vNsyCD7aWPcTSujSLSjjBxPfcMFlOO/rgM2Zt4nK7y9QGw7MEvkGauxmBx3mpH1tQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4563.namprd12.prod.outlook.com (2603:10b6:5:28e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sun, 23 Jan
 2022 23:37:48 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::75e8:6970:bbc9:df6f%6]) with mapi id 15.20.4909.017; Sun, 23 Jan 2022
 23:37:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] nvmet: add helper to set ns->blkshift value
Thread-Topic: [PATCH 1/3] nvmet: add helper to set ns->blkshift value
Thread-Index: AQHYDQUdSZJsd9EDmkSOrWMmUEs956xwWmMAgADwBoA=
Date: Sun, 23 Jan 2022 23:37:48 +0000
Message-ID: <226f4cf9-4e15-3909-e9b0-e1e50c8b707b@nvidia.com>
References: <20220119072038.3942-1-chaitanyak@nvidia.com>
 <20220119072038.3942-2-chaitanyak@nvidia.com>
 <ac69fed5-c1ff-d36c-d88d-e466de3dfcb2@grimberg.me>
In-Reply-To: <ac69fed5-c1ff-d36c-d88d-e466de3dfcb2@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f8c60ff-49fa-4bad-594d-08d9dec95d18
x-ms-traffictypediagnostic: DM6PR12MB4563:EE_
x-microsoft-antispam-prvs: <DM6PR12MB456315E8AECF50BBA441FA5DA35D9@DM6PR12MB4563.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: btCBQ/qHfZ4+6FoH+gaF5VkB/laPmGOeUeYddbOOwJ+7JG3ux+esOTf76iiUlFcaXu6dsvnQi8mC6TBS2Zz5lraeZyY6XhXqM3QP0m9agz4jZubKjg4ZIGgMPpOtBZPTqixAT9rEmxy1cbmKW666pphJ6EezSo9d8VyQkcWn2xxlL7/Rf+t/PhkrgC0x8b/qWpYpMvpN3OgpAEjG6H5otJjUfqyfF9TRAq50pxvOWY1ZXG73C2DAXee7/+7FPGjvLbs+EKxKmdDkM0H+JYM8VZ9fyK8DaZl8qWJwHmopaFMMJ6Quj9QGPnvWmnUvpW04hf/09JiZ4v93AuNIxreuxeXnOP4B7fgJGrMoFn75766z6kGPXqmgsIlZJESH6k+mKgtuTX74GJsMs4qpukCfAuc9g10Ly0zzAWIiG+jnY1xxZ32b1SYK+W7ZaT/gkc9boKcaBffeAnws0mx9jp9Xvw+jcvd4w48oIyidiYWHdwgr2+QF73uOpGTtKIcH9sQLerqLvIBJ6x/i89GRmjNHpxRngIS5QeD79f04KyziER0SD8yeeradmRhR7P1gkrc40SE00q9ZK2d0jgG4JnTN+if4GvB73nmx/CPK4Xc6vUzSUZtURhgvDHltkz1V9+nTUHrX63n8SfDtmM0PbLXBKyWT6SJkwE9J86FZLJg8LxD+q8w3xJIEMxAqJiG4aBcPy/CxedRPuVgh08iA2puq7l1y10QOECwEaqQbW2PKrYTciDdNQE4dD8bFJhGYI/g3eJTWaHtoSgMgCoTAcsFkkg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66946007)(8676002)(2616005)(186003)(508600001)(6506007)(8936002)(64756008)(54906003)(66556008)(66476007)(91956017)(76116006)(38070700005)(66446008)(316002)(36756003)(6486002)(53546011)(31686004)(5660300002)(122000001)(83380400001)(71200400001)(31696002)(2906002)(6512007)(86362001)(38100700002)(6916009)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2lsNjlNT0hvM3pTOVBjM1NCMTVaSlRxVjNZcmo4bnYyTWhJVExVUDcxb3Aw?=
 =?utf-8?B?NlROSURsbVBtT1Jad2NManlRTVdMSEUzSkZnRFFNUTNGcW1nQXh4WnYwa2xn?=
 =?utf-8?B?VUNaZS93NXBoU1dKcVIxM0NWb1F3blBwMFE1cmx3eGl5ZHExNTdVWWY4MUxV?=
 =?utf-8?B?ejR1RXkzQ0p3eTN5SjQrZ0xwZ0JsSE51ZEtTTTZ1YmhTbXFMbUJIQkx1V3pq?=
 =?utf-8?B?NXlvanprMDN6dUo2WG8ya2RxZ2s5aytNSUh1ZjJBTitON0ZNS2NObnFubDA2?=
 =?utf-8?B?M21DRk9qdGpwNk1XTGFUWWZ4djhSZkFuNjQ0U0krVkhxdjlNU0FHbjVpZ3dH?=
 =?utf-8?B?cXkrcTdOQm9WL2trSWl1Q3dNSUdJUXBuQ28zV3ZtM3FoZ2VVT2VaQ0pkVSth?=
 =?utf-8?B?aE5xRWNkNU9QVkdZWnAzVmwrQ014bndFZm92L2ZHMW1VRUtiREl1SERvaU1m?=
 =?utf-8?B?NTlnM2JWWnRBdHA0cHFFaVdDaDZoaG5yNTFUTFlIaGdSSEpZbEI3eUV6NFFr?=
 =?utf-8?B?MGdVM2NwK01hMjFJenpnNERpekxZKzRvU0VOcVlGczU3T1pubWxnTjdJRWlH?=
 =?utf-8?B?ZEl3MkJ4TVRnR1ovWGg0c2QvSFFkaDJIb0lvdjNoTUZVbXNNbDg1MXdKNnRE?=
 =?utf-8?B?a2FXUU94ME9rakJFUzVZaWRyZzgzM29ISlFlZWhsckhvc1FmbW8zUXlzcFY2?=
 =?utf-8?B?ODV2eUVkcmFJTmRMT0hwaUxDdlVnS3JFTXUxVmZZYWRJQ3VMeWVTVmdMc0Nu?=
 =?utf-8?B?eHJOejZHZm44Q0pzL0x3RFFFWkJNbTJMOCt1Y2VrN1NOSTJCNHFjajRGYWxI?=
 =?utf-8?B?bUdHb016VkJaU3hHVjNkblBzSU0wZnhCd1N4NUlDU3ZKazZLeklnb2lPK1NB?=
 =?utf-8?B?Y3RzOXZGeC9RNzc2WXo1azhEVFpLbzhXOXNtK1J4WG1DVjl1TkVENmkva1Bw?=
 =?utf-8?B?dGtraGZjZDNGVEV3SWhRVDh6amhnQ25CUVcwNzdIdm1GT2JOdXBrTVZsL1Y4?=
 =?utf-8?B?ZjFwbkNPaGRza2ZYZ0djM0JNaW5Ba0Rxbi9ybmFNTXB2cHQ1RUtaZFBCWCsr?=
 =?utf-8?B?TWMxcGRvRVErbkhoZWIyb21qcWgzWFJvSDJRSUpHRjR4NWI5bitjNjlGd1pn?=
 =?utf-8?B?S0orRzZYWU9jOTVYdzBrNmZVeTg2aDVQSWV3T25WMHJYTjlrdnBCVHJubWwz?=
 =?utf-8?B?Z1BBUWRRWFpCNk0xNGNhUEJheDFVOFVJQTkxbHppT2Iyc1lyVVY0NEpFQ3RK?=
 =?utf-8?B?dlV5TWlnM0pnelpSSkxFbk0xVEtBdVNoZVJmQm5JMzVOYVZQSi9TQlhXdVVj?=
 =?utf-8?B?TTg3Nnl6RU9rQzRKTUQ2MVczeEpRUGUxWlg1T0VvL3BrZlZnakdLeExkL2R1?=
 =?utf-8?B?RUc2UVZKVUZQS0k0WVJVVXB3UW5OQk54djZndVJhYzZVaW4yVzlNRUc2SHUv?=
 =?utf-8?B?bnNReHZDVDB6aUZrQ3I1S3UwNkZKVFNiS3NHTmVTaVFseDRWbTlDN3I3WHhk?=
 =?utf-8?B?alVVUEVMdHN0TnNaY0huUGV1TFZXZW01S1RjVTFud21RNzFLcCtwRzgrZEIw?=
 =?utf-8?B?ZWRsSFJ5dndINTB5NzN4YmxIOS94NEM4b1dYcmlLTW1Wak4wWmJEWEZlTGZo?=
 =?utf-8?B?ZmdmZnEwdWM5ZWszR3lra2ZDR0Zqd1o3RFlqNElvcGYvRlJvN05rZjVNbVhV?=
 =?utf-8?B?K0kyd05kOEN6MG02Z1FpMzRSUGVObmZoaFQ5cFBDcnhSY1c0a0tHeXlvN2RQ?=
 =?utf-8?B?dFQwS3JPRWhWWGppbWpaYXN6RU9JcWVqVEhmcGVVYStrSUM3THlGdHJESFNH?=
 =?utf-8?B?VCtjTzAwSEdPVld0YVB1Y0lNVzR1Nk80WUJ6RGpHRHJoR1hZbjQvcU9reFk4?=
 =?utf-8?B?Y241RlppNUJuUVB6Z3BONkl1SytqYUQxTHRDNGZTQ3p1anh6QXlqbiswZWox?=
 =?utf-8?B?VlhDbjJ4THd3TDBGNUlVc2pHLzdCaHNpQThLbXhlU2xLemhiak5TVStYL0tS?=
 =?utf-8?B?QlRMNS9sS2FZK2VSc3E0NHE5UEdjd0tCUTdaUFNkSU5Cd1ZTTngrdTN4RGJX?=
 =?utf-8?B?YzhhRE5tMGFBQUV0a2RhY0NPcWVyUHFsLzdkOXlaU2VweVNZN0lKMllkZWw0?=
 =?utf-8?B?TnlVUnROcUdQUEs3emdhVmNYRkNuYUpYUzNmYVdJSGQ0Rm1GK2UvK1JqVGZs?=
 =?utf-8?Q?bHmPnM0P0ci1wS3pvDSzsqK8tePsNbi2R4GZx6X8Mt7S?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B32134A0B2DC734184AC2682267126CE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8c60ff-49fa-4bad-594d-08d9dec95d18
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2022 23:37:48.0524 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xi4qWNptvC7VO2TTag6UndZG7Wq7NRF1JXRxjrtWCm50joG3kgM+O9wsogPOuuAjc7zCeV/r0vXw9SAqBRWP6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4563
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220123_153753_272597_54631D49 
X-CRM114-Status: GOOD (  13.90  )
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

U2FnaSwNCg0KT24gMS8yMy8yMiAxOjE4IEFNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPiBFeHRl
cm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRhY2htZW50cw0KPiAN
Cj4gDQo+PiDCoCB2b2lkIG52bWV0X2ZpbGVfbnNfZGlzYWJsZShzdHJ1Y3QgbnZtZXRfbnMgKm5z
KQ0KPj4gwqAgew0KPj4gwqDCoMKgwqDCoCBpZiAobnMtPmZpbGUpIHsNCj4+IEBAIC01NywxNyAr
NjcsMTQgQEAgaW50IG52bWV0X2ZpbGVfbnNfZW5hYmxlKHN0cnVjdCBudm1ldF9ucyAqbnMpDQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPj4gwqDCoMKgwqDCoCB9
DQo+Pg0KPj4gK8KgwqDCoMKgIHJldCA9IG52bWV0X2ZpbGVfbnNfc2V0X2Jsa3NoaWZ0KG5zKTsN
Cj4+ICvCoMKgwqDCoCBpZiAocmV0KQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gcmV0Ow0KPj4gKw0KPj4gwqDCoMKgwqDCoCByZXQgPSBudm1ldF9maWxlX25zX3JldmFsaWRh
dGUobnMpOw0KPj4gwqDCoMKgwqDCoCBpZiAocmV0KQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byBlcnI7DQo+Pg0KPj4gLcKgwqDCoMKgIC8qDQo+PiAtwqDCoMKgwqDCoCAqIGlf
YmxrYml0cyBjYW4gYmUgZ3JlYXRlciB0aGFuIHRoZSB1bml2ZXJzYWxseSBhY2NlcHRlZCB1cHBl
ciANCj4+IGJvdW5kLA0KPj4gLcKgwqDCoMKgwqAgKiBzbyBtYWtlIHN1cmUgd2UgZXhwb3J0IGEg
c2FuZSBuYW1lc3BhY2UgbGJhX3NoaWZ0Lg0KPj4gLcKgwqDCoMKgwqAgKi8NCj4+IC3CoMKgwqDC
oCBucy0+Ymxrc2l6ZV9zaGlmdCA9IG1pbl90KHU4LA0KPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZmlsZV9pbm9kZShucy0+ZmlsZSktPmlfYmxrYml0cywgMTIp
Ow0KPj4gLQ0KPiANCj4gQW55IHBhcnRpY3VsYXIgcmVhc29uIGZvciB0aGUgY2hhbmdlIGluIGxv
Y2F0aW9uPw0KDQpTbyB0aGlyZCBwYXRjaCBpbiB0aGlzIHNlcmllcyBzZXRzIG5zLT5iZGV2IGlm
IGZpbGUgdHlwZSBpcyBibG9jaw0KZGV2aWNlIGluIG52bWV0X2ZpbGVfbnNfc2V0X2Jsa3NoaWZ0
KCkuIEJhc2VkIG9uIG5zLT5iZGV2IGlzIE5VTEwNCm9yIG5vdCBOVUxMIHRoYXQgaXMgdXNlZCB0
byBkZXRlcm1pbmUgaG93IHdlIGNhbGN1bGF0ZSBucy0+c2l6ZQ0KaW4gdGhlIG52bWV0X2ZpbGVf
bnNfcmV2YWxpZGF0ZSgpLCBzZWUgbGFzdCBwYXRjaC4NCg0KSGVuY2UgbW92ZSBibGtzaXplX3No
aWZ0IHNldHRpbmcgYmVmb3JlIG52bWV0X2ZpbGVfbnNfcmV2YWxpZGF0ZSgpLg0KDQotY2sNCg0K

