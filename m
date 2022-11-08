Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7800C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 03:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ihMAaZQ51NJPNqnGA07FmNXttZWjyoM57Fyd9q/5888=; b=QkdykLzjLGW9ko36rnq16VHCFs
	zZ7F/H0lwQ0lmQTdYrTEFB/r8ZA6E4/l1dcp9v4VlxMhpw36H/mpqdGip3E/VvWyokgdg1jhvrhT5
	OX6rzSR/FrlCUO8v5uDHYz0mooOxAkeeugTvEHer69RBOOPCpMOgtdTXwnvKu6Z7Gp5VORHCTQerH
	Tn/Gw81l36GF0X6CF19nt3xVocIh8HxRs0og9Wzf7KaOapZVzIEIM/cPAAW0nwGHYlIdH6g1ZCEI4
	wUMAj8wK9PRb6Ph+QxaIUgQZReThrJN5GQWQ+7qvUPfD4PvG0yU4hEimI4n566V/fygkrWz9WfjaJ
	2DlGA4zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osFhX-002X8U-Ua; Tue, 08 Nov 2022 03:55:03 +0000
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com ([40.107.94.73] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osFhS-002X7o-Bz
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 03:54:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQvuZJqVh0npuJZ+xZvTkyPjEjO9iJ0LfUH9+zxGMT3jwNbri1J8MXp3X9T6wgs2fk2EeRbfeC+0wucTJfVFCCO37sCy3qUp3Oil5CzavZoc0c2PAdEp7csIS2HCUHShvwS/KHR1lx9w5dEwKsJnQj6z893djWWaU6X+ImeN4r1oZ6RdLXGLWV+dERcgEKm/e0E2mgEMQe3laNVrDkuawJ1wS2QeM9O8BmjFFTXCEg/Fxsv9kSTNxNuwBpMqAFqc6bndCvLBDSIqj8jy+Rm+gMDkLA08SEE7jZLezqieaMSsNcwrJ7ZsN5VHP8uD6fe+abHdEPRzhOGxfJJs2/Z5GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihMAaZQ51NJPNqnGA07FmNXttZWjyoM57Fyd9q/5888=;
 b=f9co25Iu99vi3VVnBfZLs9cf2ofDTrNUrRCR9Rc61/SDdP7M6cTpYwvHtFHl3zRZfosR2yjyG6b8qAnIAiOBJMKx8xg9LWnD4rffuOw0pQ0MR8XxVRjlF39vT86ZNZlrLMT10TX7bhD+IvBcGXAy28OuJnAbk5mOoG7pCKJaJlPtg+lqYyQdsouNt2OQouj2VOfXrNGA2OxnxhpV/f4mKwFeS7zYM9KEvtQIsjuhiXbmHT1huQc+el/zYETZjbteF4mylcsdwcxvVaCNfqH4Be4B2H+kyTvwy/QF66dbJzym5fPzp90BFuLVZjzBRtIQYOq9Px6ufJD+QcOptLwQLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihMAaZQ51NJPNqnGA07FmNXttZWjyoM57Fyd9q/5888=;
 b=lyyG5dDCroE4ADR/6cDIMjIv+0e4SlIWYwFk2oXrbD4iOTQz/aD4hntefAyWl6cY7YVd9QnU9zQ7wrn2Y5QOcUSBznscg7ht/a0o4OMjhov+TNwy+KMigSLr5t1UOnkdI1sHz3SrP9yXjN2EhYsLs6MkNQ9siIeUhgfkIkKKeE3zn2u52X77Jbb6htEZxzdz4sYPaPU8pvArKkRXr4c2ZLYz98fRuVoVPKxhz8TEIIQNBi+GDK8jt3tKm2jhVIVfIVFII1fmCdIwNwv2Mfft/qN0bpHaj8BYVg9lfFKHfSplspakrpSEklXBy5/ZejFZyvPHToqZnY3tSOGAMjeG1Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 03:54:52 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 03:54:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvme: implement the DEAC bit for the Write Zeroes
 command
Thread-Topic: [PATCH v2] nvme: implement the DEAC bit for the Write Zeroes
 command
Thread-Index: AQHY8sbMQS3O1pRmiU+5oq+DBi1/f640ZieA
Date: Tue, 8 Nov 2022 03:54:52 +0000
Message-ID: <d33b41d7-936e-82f8-ee1e-45ccdcc7ade9@nvidia.com>
References: <20221107162108.1777681-1-hch@lst.de>
In-Reply-To: <20221107162108.1777681-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB7677:EE_
x-ms-office365-filtering-correlation-id: 6c591175-0285-4978-df14-08dac13cfd78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  TvkN+tXs8jnEmX2tG52Df7kYXQ+JdnIKCMmjQGFdAZTTzut45f5zBYPqaNoU5L4j7qHlSfAlz/EMLut9Ic83Oxr/hEjw2j1uC5WCgGafq596b++z6i+6VbB4bJg66iZ9MEHU5VpSYFgJZkjLap8sx/wNQMN8a8MgeY7PKc8VKZKjK3zlL111GE/Q20s5U7jUs5p0mi2n3Qrh2CUKQZs430bd5K1zpnCT4HEe4Uxvs8NfjJjAL/k3vKufxHEcqFKC7AIsk1m08oYNEc+v3XzVcxk0cCrxxCBgrn1CXUJyLLrfcyf1cSSv01f6i3ySQZTIHCvJyjKFw8m2MSITVsz2EZxCZo+PaE0Q3UKyMuK0DpUaZWqd5LR/atupTmBOsCtAm+rah/HXndm+V2cZ/oYyuVNyYkiEHglm1Cvc9YodHCIaz9Pv+DiguK6wQWn7/JxieMEoLCMHp0cxjt475AgBYtZo886uePVvTPCkuTL5GJmL6wkMvUNCx9a/HxzMBtzqdI8v+Mq/f+TyZRA3nBrCEgVg1g87OVMVCErBhXgoIeqrIo5J3HIe8rvphsBNx5wa/HfWL6Up8JGdjUKG2CXBTlQbIwjvGI607hBLxDJCzHlTogCtJ6OkodXmFre9L9N2L45KVfzNpBZyG+BUqMOei+RARv04+lOcqsjTfZqat/xjeYtcWozTjwl3u8DDXvVGszJP04Cwzpt1DEvqOR5dwJHAq8hReGDS/YVAXDz9YuFRN4tT0XQ8j7Dq9z0AwIjXx5ON9qeLOzWz26dV1G/d/Wcj6ZkiJnDT7wPLxOv2k74ns2dZqfrjhis+hkoRpqx4CC/u5b7Pslj9jmpXKYK4kQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(38100700002)(66899015)(31686004)(110136005)(36756003)(4326008)(41300700001)(66476007)(5660300002)(76116006)(64756008)(66446008)(66556008)(66946007)(31696002)(4744005)(86362001)(8676002)(8936002)(316002)(91956017)(71200400001)(2616005)(38070700005)(2906002)(122000001)(186003)(478600001)(6486002)(53546011)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dkt5R3BxbE1PQXVSaXc4UU1jT21UT0ZSTnVyM0h3THFYdGZMK0FwS2phRHZU?=
 =?utf-8?B?NXQ5UE5ua04vYXh1UWxsY3Q1VnBSWUw4bmlqYlJVZTYvOVZ5VU5wMC9MVXJR?=
 =?utf-8?B?emdYT3VSVzllUHRhWDJwTXh0UW5tTzRJNWxkS3d1UVJJcHVnSnF0dWcwS1J6?=
 =?utf-8?B?VXVCQjFHZTJNUG90Snh3ZlcyTkJGRlVMNWRkZnVRQUt1QXd4aVRjdmdNUTBo?=
 =?utf-8?B?R1dEeDhJNnRQMnRITUpCVkNISjhDSFI2MTQzZVBzL2FDZWc1TDVRRDdCL08r?=
 =?utf-8?B?MCtoeVpoaUdsTy9URUxPQnZ6dWVCeFpJVGh6WnB6dUN4WUQ1WWM4aE16emR1?=
 =?utf-8?B?aEQ0TW5ETERtaW04TWpMOWNIWTdobkp0bGY2NFlGbzhXWXNMTDh0UXArYzNl?=
 =?utf-8?B?aFJ6L3ptQ1R1bGROSmNVVWZuZ0toNVpzZ05NYURHVUZiVnNHVlJxYVgxMFdH?=
 =?utf-8?B?T1NBcUU5YkdqME96eGZMTWM3VWlvSEtkUWtDWlZjYzB2MHlVMTJsNXRxVkJs?=
 =?utf-8?B?WkpKYnNtYnd3VDRGUitGbmVaL0NKL0tjWmhYRmI1MEJNS3hpQVlsY1FDbVBz?=
 =?utf-8?B?aWZSVHJFaGZiZmRTUGtPMlB6VjJVbDc4SzUxeUVnUDRZZC9nVDhmWXM3S21G?=
 =?utf-8?B?NWZTZGJmck1aSzhUMmp2YWdJeUgyN0JCdlpmSmNVMVMzU3d6ZExHUzhYMmJI?=
 =?utf-8?B?Y1RtcXJkNHhwaE5mK2h2UVdVaVVDWGs4cUtDVFJrQ2hkYmVUY1MvSkRNMklL?=
 =?utf-8?B?RFBoTDhhTjdOaFJFKzM3aUkycW96emNiTThOeDQ1MGxLTG1UbDZZeHN0b1oy?=
 =?utf-8?B?bTM3UHpjRmtuellBSWtWbVJCWEkvSjM1TjNvaUxCS2pLemRnd004bWhuQkU4?=
 =?utf-8?B?U3RlVzJMZ21wQjZkbTVXL0R6dHNqWjk2a1JGbE5QcU1QRUdUVHVmL3pvcGR1?=
 =?utf-8?B?NElTWjdUbUdUQzd1TmhwSTR5TlhvZHk0OUdpR3E0d2cwSUxYdW5sOTVUYk1U?=
 =?utf-8?B?UjVSSDBEK0dTUitaa09yZlpkYkxObVUwa0NNZ1VNZWFhL01NZTJxVkJzMHVl?=
 =?utf-8?B?VzlPclhtQzFoOWhjQm9QVHN1YjhYejBBaGMyYUdrcVlQK2tLdjFLbFp3L04z?=
 =?utf-8?B?VElwd3hNUjF5eDZUd3JkeHFEVW1KTnhLR1QrVWJ6K3dIV293U2xybFNoY2R5?=
 =?utf-8?B?VUMySFZHcytrRWlzaDVvMkY3REFxL2ZPZ0hXVzFUZUl6NFI3RVdUaUJoY3V0?=
 =?utf-8?B?WGhESG5Ra2M3ZFNaanBxZTVYemZSNjJtSkppbjVxLytieFB6b29CckJpSXF2?=
 =?utf-8?B?Q0NDZTZNdXRYYUxwVXlCeFlCWWZQOXYzd1k5MXAvL0JzbjZoREEwNnJ5UVhv?=
 =?utf-8?B?VldBYUQ3QlpmMjZkckU4YndvZEpRMURsdWlXV2E2R0VGWjNjOVljVEV5VUt0?=
 =?utf-8?B?M2NRV1FRZkFtR1hFWmZNTU4rQjY2VlhFZ2lrQjR0MCtrbHFoZmhIMzlZTUwr?=
 =?utf-8?B?SWVkOERlcCtTWGlkbnBRNVI2OS9vaEFHci9vQkZDbWdTek5pa1hibE9TMTVt?=
 =?utf-8?B?b0RabjM0ZHFKYloyOEtiUWxyZkFYYmJTUHZKVzI2dnQvZS91Z0pLbjRnTDU5?=
 =?utf-8?B?MXBqQ08wTGZWSTdGbFFxdUU1SzU0SVhoQVdRd1BKVld3S2FFZUZEekR1ZWI3?=
 =?utf-8?B?MDAvOExxZG1TQTUwNlRYdlVXQU0vcGxBcC82Y01BVWM4bnZyNjJ1SnFKYWMx?=
 =?utf-8?B?YjNGSkNPYUtHWHJDSjVzandrd0xiczhqWlVkWFg1UkxPc3dhOTJsOTFFTjdZ?=
 =?utf-8?B?QTlqQ3V2bUhTbzJ1Z21zZVpqVHp3UzFJVVoxTTZQWEZVZGttTWhMVWNic2lq?=
 =?utf-8?B?ZkRwdmVEeXVaMFJiQ081VHllQUpud1ozcHlKWDFuS2JlWW1TN09ZMVRMMUsr?=
 =?utf-8?B?anNQNXNIOE5UVkI2RVEvaXBDUWh2aDBPZUQvMkREVGJoMnlObHEvdEp1Qmpp?=
 =?utf-8?B?ZHczNUc3ZkdhbzFVWlpIb3lRdVRLYlZHQmlUQVJTekNHcGQxS1J1SjNtNjRG?=
 =?utf-8?B?WUZkc0s1QjJtOHFVZFU0bFl3Uy9sR0szU2RVcTJoWDRNWWVPSUNWTG5hSjRl?=
 =?utf-8?B?Z3VLUHlmbmdMZmU0RG1Pa1RockROUDJIdlZrRlRlblZTRUtXOGJOa2c3bitp?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5949ED0A5C77A344AD59209C2D788F59@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c591175-0285-4978-df14-08dac13cfd78
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 03:54:52.0477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3LRrjFR+5TEZIMBhU7T9iVlCHt/5gxbzgzgpSb8RlY2dAYCeATTNG/UxNFq5YroPA4GDF2G1/zCLNPKNY9s71g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_195458_430429_FF5DCD50 
X-CRM114-Status: GOOD (  12.64  )
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

T24gMTEvNy8yMiAwODoyMSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFdoaWxlIHRoZSBz
cGVjaWZpY2F0aW9uIGFsbG93cyBkZXZpY2VzIHRvIGVpdGhlciBkZWFsbG9jYXRlIGRhdGENCj4g
b3IgdG8gYWN0dWFsbHkgd3JpdGUgemVyb2VzIG9uIGFueSBXcml0ZSBaZXJvZXMgY29tbWFuZCwg
bWFueSBTU0RzDQo+IG9ubHkgZG8gdGhlIHNlbnNpYmxlIHRoaW5nIGFuZCBkZWFsbG9jYXRlIGRh
dGEgd2hlbiB0aGUgREVBQyBiaXQNCj4gaXMgc3BlY2lmaWMuICBTZXQgaXQgd2hlbiBpdCBpcyBz
dXBwb3JlZCBhbmQgdGhlIGNhbGxlciBkb2Vzbid0DQo+IGV4cGxpY2l0bHkgb3B0IG91dCBvZiBk
ZWFsbG9jYXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4NCj4gLS0tDQo+IA0KDQp3aXRoIE1hcnRpbidzIHN1Z2dlc3RlZCBjb21taXQgbG9n
IGZpeCAuLi4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQoNCi1jaw0KDQo=

