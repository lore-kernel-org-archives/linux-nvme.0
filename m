Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE43C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 06:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KDv5oq7mOdAvkl2GfEYg7I7qOmVQqItY9nXVafrl56w=; b=aAR9uPPztSUCJfmRL1pKBlLKNX
	ZY4NwGCCKjM165qASHaMIpB5XJgph+cfU6WFrIz/RMr9Wo80BLLvk0WbO1uWQfF0D3sRpd4Gcpuos
	FrZm1R9Yt/ppUQ1rIN2YURkEZzaL/EvYy3S2rqs4VsBm1s9oMsG15iWoha+XRHUZ9ZOAwFjfWiTGK
	lBpsQOyJUjlCtqsacQsIn8UWk2OKfFlyCrWKmsiafwz5kJYluFl8riaSI5GTzbWVeojFvU/bVLfu2
	4dBgl5HLTRhrPvCcAYbCNZ9TAEBR8xIKuHC7Bho88fIQT1GGisAz60pftLcP2K5i0tXT4d+xA5OxI
	5awR4Qrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nySKe-004vZc-Og; Tue, 07 Jun 2022 06:04:48 +0000
Received: from mail-bn8nam12on20607.outbound.protection.outlook.com ([2a01:111:f400:fe5b::607] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nySKb-004vXS-FC
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 06:04:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9ZTaD+ZdYONkL0u2aM8blKsBoEYH8Gsand1gd/jC/bng/tW9CF4yvcgjOQ6n6pjsylkaliztKNqbrv1PbSYj2Reu03G5bxbgy9oZESxMi0Jgm7nViQs8H5fLEGPi2NQumLPqoQLCDIfxu3iCdyS1y7FxYSQONlQqkxvR7dQxq/nzMY8VZj2JPAyMZEi6sxc3QLFJa2K0YT7XL65cDECRjpa720+uYAXFVNE5hZ+TrJf6d1NH52XFh+7vIfirUR1Cv5EYb8vbZCnMFQlc46BTrneTYgNsAhryDWK6AGXgyFaLCqlCAUBpN0T3BlsXjzeHsgU93DaofCVHru62KSIlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDv5oq7mOdAvkl2GfEYg7I7qOmVQqItY9nXVafrl56w=;
 b=PhXzWu+geYdy/1XjQjoQ9UaTfhiWZN1ellZOcYbbCSVio3gwblWbZEsU/G/pq1XNMhaoE484tPmSL9FbNEj4KP05yNx4bhziLS6qFsz5jQZCjuEIuAkRYjURavq5mFzlHWVub9ENsk77vDDtBcDDwTv2vNhP5vSmsom9ufpLWsc1z6NMHKvNMkdDB6SyCDCkkU61+mk0vPr3bvzsGa7+EaWFFCLksD4gGCJQOtq7EHo2dGeAupX2Pkne7nRbwJJL6v0RHGltpu5kfKMcofNBBRm0bvLdsyJtJFniuQm+r68ktXpwsS4wtZfoh3tqkfQjeN0CjLVgQoDCi+KOQKv7NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDv5oq7mOdAvkl2GfEYg7I7qOmVQqItY9nXVafrl56w=;
 b=IdOmGIWeel/CbP/3ymC1n3OQDXHTuLb+dKilOoA2I7S5FMjXTYfa7+Mg1b6zr+sUZ2DLLvLHN19JC8eoaJz2gDCqVhJbL0vrRfQyR7W90bbdLYj2DTg8AMtE07f7JwNvvuNFjc1dPKPnOXbEFyTjQCxvgPla9paJbzS4YgmxUW+kJtr24ojwiV3sFiYVs13FTdNZ3YTkzAJDk2BTEnWPh3hREmibDNiBph8sBg6p7QRXvskEGq8E1gwJ0MaBhg74FKZ0aTzkrY6Zv1lqYbjihHJMI8ooEh7mlWEpauwK2JHn4z/6yI2U/l4WMpwl7hnREF7f5iCUtGoOmzRlMsYeaQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SA0PR12MB4573.namprd12.prod.outlook.com (2603:10b6:806:9c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 06:04:40 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6dff:6121:50c:b72e%7]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 06:04:40 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "james.smart@broadcom.com" <james.smart@broadcom.com>
Subject: Re: [PATCH 3/6] nvme-core: remove qid parameter
Thread-Topic: [PATCH 3/6] nvme-core: remove qid parameter
Thread-Index: AQHYegxdGRv35/pX2E6QMmqQB/oc5K1DXRoAgAAVnQCAAAC0gIAAAW4A
Date: Tue, 7 Jun 2022 06:04:40 +0000
Message-ID: <3c512c62-0461-e1ef-8848-ade79ee8a7cb@nvidia.com>
References: <20220607011647.24105-1-kch@nvidia.com>
 <20220607011647.24105-4-kch@nvidia.com> <20220607043940.GA7847@lst.de>
 <ed876e75-c6e7-ee2b-fd3f-e87daa4d5179@nvidia.com>
 <20220607055933.GA8927@lst.de>
In-Reply-To: <20220607055933.GA8927@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9dbef875-2b4e-4eb3-5a02-08da484b9c2b
x-ms-traffictypediagnostic: SA0PR12MB4573:EE_
x-microsoft-antispam-prvs:  <SA0PR12MB4573F232B28D3C6C737371EBA3A59@SA0PR12MB4573.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  1C8dV24OKiOF5RLWq2Y1L16zNTlDyoa7yqXmtR7ZLzqsHHxqH6xJx3K8OroIfKOdCYGQT5lvNZI8UDGLnI3KjQqKj1ScgUween+puRHn5Uzu4iPEzr66wKjMTnWMJRDHrMz2K44T6GNLjQzC7IZDBOw4jdvlLdKLRXwFW6jGoi4N1nGinW+0y8dCmP1+gyblvskALbvtw3dc2CGMcpkgSM1Zbb3QYljdW7WTEFh4x49evzTPH/MvjmNvLsTFTw9JRlPNfmyI1Gj6WPOiMIRGCeiTg/vnzV+PAZ+WPa4BSvb7CQrJbcfp+FbxshnCPdL5TxEhTAGh+GLaeKnmeiPUOATytpVe4S/WKJOZWwiWMMA448Gok7myk+mnan7J97FoajG7x7SjVeMyqhDLduiA3Yn6bTuRH+rhV+CU4N0mxxLxbwIgvz1PEwidOSQF+8szD9ziJwzv37eEgXkhfnZhZ4RgrqIDr1YIvj+2Ky+LnKIgra0cpxYsnNLbQH9f0ltF70aeiMHoknIeOsry3Cn3ifrHAGk6nNzYvtf86sPBV+hhKmZbx1Yrsa9YaaJYvQcO/wk/zHHWAWF+C6fc3CStliYndy1oyjs/s5xsCvAOs9zjfWydVyPsb5zIcDlVie8MYZoIdYUix8JRxQCn+b4Q6dGpVoKY6YVmmzcqBWNceSRPhRy4XG9uTs6pTugUARkQ736JhOHtJdDoJmkVKHLuYyM0V8456BvDsA2yi3PSH+OSOsMlzx2n2EoV5KMbus9tYRTfv6n8iWEEiFPNe3c/5g==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(6486002)(5660300002)(316002)(66946007)(2906002)(8676002)(76116006)(4326008)(91956017)(64756008)(38070700005)(66476007)(508600001)(122000001)(54906003)(2616005)(6916009)(86362001)(31696002)(31686004)(6512007)(66556008)(66446008)(36756003)(186003)(6506007)(53546011)(71200400001)(4744005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?TTE2QVJvbFB6WVNtUHpaWTNLdC9FRy8vemRHSFQ1NHJOQWVRM3BCWmNTc25x?=
 =?utf-8?B?VWFNQUg5ZkY1ZGlYUzYvQVByOGgxYktBMkdCMURYOTlSQTdmUS9NTXNycVpy?=
 =?utf-8?B?UitlRjczbUNWNm5lSExkWGNzQnRJcXBQUVRGS3ZtbmJWNC9UNXJJYmJUc2NF?=
 =?utf-8?B?MU94UXRxUHBjYU0rbm14VUR0TTVuRitPdk9rSjl5QjVnUDhsdDNnVUZnYkVI?=
 =?utf-8?B?dDRSOVc1dHJ6eFUxeVluYm41QTFIcXcyejFIQUR1ZWxaWVJvRnovZmpGTmlC?=
 =?utf-8?B?NzZMQW01MFIrYThxN3o4M2tFeW1TQW1RUVZJOG10cnlGekM1SUMyOVkwbjlH?=
 =?utf-8?B?Y3ViWUcrZWx3MVlBSzZBdGwzamRqVHNsbC9xMWlSdFJHTnFSNGJWc0QwN1lp?=
 =?utf-8?B?MXJMMzEyYTJrYWwvYnoza0V6UWIwRzRxQkRqY2hGbnBrOUMzbXFXUGlNYmNQ?=
 =?utf-8?B?RFlMa3JUbHFaZ0xGQjdtMnloN293Y2plUG1YZHY2djZyeWhjbVBEOGpSZmdL?=
 =?utf-8?B?ejNiMngwZjZDVmJJS3FDR0huVGtpWlphTzZzVkkyalQ1TllDVEIyTFMySGkx?=
 =?utf-8?B?S3FxSVQ4U0Y3WExMQndscjNqam82Syt4Yi8wV0RvYytPODNIeXhMdGhOWjYx?=
 =?utf-8?B?bmlaT0o0V3ZRb211RzhLQnBqT3pXSlpGQncwVWxMTWJiVnM1T1ptMTRGbUwz?=
 =?utf-8?B?aVdidTVaZzZ3Ymk3VHM5ZWFzenFXWVI1cDA5dU1TS1N6Tkx2VTkzNE5QYndP?=
 =?utf-8?B?OFpiVzBNUW1Da3ovUlFlakQzazlWNjlZaDNuSzQ0am1zbVFIelg5YTJIQVpu?=
 =?utf-8?B?eUJBOThGaVVXRVpWRSt1d0hHUmZiQ2htWDFMbzZaUUpuVDUzNEx6cVNPNEZq?=
 =?utf-8?B?WHdWcXU5TmJCSXhwekxJY1U5b3RWRmxheGhCL3pmQnpTUVdFY0tWOTlUTklT?=
 =?utf-8?B?cmRmYk5tV2FnaEVzbTVPbmo2ZlhZeVZ0S0NFaVRFc3E3SlRXRWNiUzU2em9G?=
 =?utf-8?B?VU83Yk9pb0xIL1hZdlNSRS9oY2ZDMCtMRFAvRmJoN1ExaFpmRnZsYzZXSXFI?=
 =?utf-8?B?THg3aVlUMGt4T2NVVXBpSWRFM2FkSTBxN1dZZ3o5SWlGcnUyRnNoQ2FaR2kv?=
 =?utf-8?B?bjdkeFRHdkJkUUIyalF6bkI5K0xSTVN4aVkxMG9sbEdXTkhDRTVJWGp5amx1?=
 =?utf-8?B?U0F6emkweHZVMmIzNkh5TmhNa3pBM1VKZXBxL1JvMUdacGZUcmk4QXZKdkQw?=
 =?utf-8?B?dnlkMVdPTEs4blRaVmZHYnN2RlUvNzVUeldaQzRsdzdlcUZZdzZ6OFhyRU5i?=
 =?utf-8?B?T1U2dE15ekx1MG1nUzhSMldCVW13dGZvQTJIVHdNU2dqcHlUZGJzODB0ZTl6?=
 =?utf-8?B?bWVYd09PRGNlUFExekRZc2l2WE1ja256MlRBdWE0aGU3REg3NklKZjAxNk5t?=
 =?utf-8?B?T3ZRdThVZjNuRWpJMFVHTU1QZG95VXpCaGxxc2gyQXlycGhlck1GemRKZ3hv?=
 =?utf-8?B?NVhZL2UrVnAwVTR6UVdNZkxGNk9JeTM5Wi9HVWM2SnR4bnh0VFRGaWFwaU5a?=
 =?utf-8?B?VVNLdVowUFRPY2Uzc1dSNW5yNmVZRXYwSHN2bmcxcU9EV2dIZ0VIS1B1azEr?=
 =?utf-8?B?dDB1T20wZ3pLS3MxNDB1ZVE5QnFSWmIyeUY1NnZwZDNJZ1J5aEpKQlF0dkNv?=
 =?utf-8?B?MTlzQWZCYkloOUl1MXp2dUF0QzJ2SUVxMDMrWnhhTzRYeDB6NkIwdEZ0S0hJ?=
 =?utf-8?B?ak9zV1BZMGw4WERhUk9LMUU5aVd6VWlLbnNibTNxZmtIOWhHdy8wN21FeEFH?=
 =?utf-8?B?NlYzdityWFJidkpFVFlsRTVNbWVwNFY1MjVINmxnZG1VNWF4NU9kcVhzN0tw?=
 =?utf-8?B?dlU1SDEyZGlpSUhJUnRsNktrNmdBdTY3NDN6Mk8zWHRzbFBvYTJFQmNVNVNh?=
 =?utf-8?B?aCtIVVJUNWZva1ROd3J2NnhVTFhvWUQ0aEYrSE9FbDBQKzBWUjlKVEl5TUFE?=
 =?utf-8?B?RENmVDRpOE1NSzNFZWQ5Y1VwVGtnLzVvOFpUT01USWw0NStRZUs4ZW5PbFBz?=
 =?utf-8?B?SERYTEc3UEpqYm1xVVcrRUNGTThJOHlKWHN1eGNwV3hvN0Yzb3hLOXA2TnRx?=
 =?utf-8?B?ZVQ2eGJTOFFkY3FMVUJ6UUxDdXU4VUhXNytYS0E2OUd5VXorUG1TKzUrMWZt?=
 =?utf-8?B?Ry9qMWJDZlV0c1Y3VXJrb1hGQzlKaEVXZTdMT1ExUTZaRVhsM0ZUYlFUU01W?=
 =?utf-8?B?M1YyWE9sK0lHTDRRNDhvUS9oUTVZLzI0MnI3dk1vcWQvMEtRTXdqc3NnUzFh?=
 =?utf-8?B?Yk4xSmtRbTJWckorQkxXNGNiR2xiT3MveUQ1azdjTVR2emNmTHRIdG9qeFpH?=
 =?utf-8?Q?r1VLKgxWlSzOvYuokPkYHFoxtekXPy97vIIRFfdr/eItR?=
x-ms-exchange-antispam-messagedata-1: VxlgBn7KckcWKQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E75501B0126B84782819B51E6DB0F0C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dbef875-2b4e-4eb3-5a02-08da484b9c2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 06:04:40.5867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XJXqClLR8C4yzgyGqqIG3M2aiTG3vldjXPXvirss032m92Qip11XsEtkEl6T46GmbsCfyNgoArLeXqnX1LxBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4573
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220606_230445_586472_607B38F4 
X-CRM114-Status: GOOD (  14.14  )
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

T24gNi82LzIyIDIyOjU5LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVHVlLCBKdW4g
MDcsIDIwMjIgYXQgMDU6NTc6MDJBTSArMDAwMCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0K
Pj4gT24gNi82LzIyIDIxOjM5LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4+PiBPbiBNb24s
IEp1biAwNiwgMjAyMiBhdCAwNjoxNjo0NFBNIC0wNzAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3Jv
dGU6DQo+Pj4+IFdlIGNhbiBlYXNpbHkgZGVyaXZlIHRoZSBxaWQgdmFsdWUgZnJvbSB0aGUgbnZt
ZV9jb21tYW5kIHBhcmFtZXRlciBvZg0KPj4+PiB0aGUgZnVuY3Rpb24gX19udm1lX3N1Ym1pdF9z
eW5jX2NtZCgpIHdoZW4gaXRzIGNhbGxlciBpcw0KPj4+PiBudm1mX2Nvbm5lY3RfaW9fcXVldWUo
KS4NCj4+Pg0KPj4+IFRoaXMgaXMgYSBwcmV0dHkgaG9ycmlibGUgbGF5ZXJpbmcgdmlvbGF0aW9u
LiAgVGhlIGxvdy1sZXZlbCBzdWJtaXQNCj4+PiBoZWxwZXJzIHNob3VsZCBubyBrbm93biBhYm91
dCB0aGUgY29udGVudHMgb2YgdGhlIHBheWxvYWQuDQo+Pg0KPj4gT2theSwgd2UgY2FuIGlnbm9y
ZSB0aGlzIHNlcmllcyB0aGVuLg0KPiANCj4gVGhlIGZpcnN0IHBhdGNoZXMgc3RpbGwgbG9vayBn
b29kIHRvIG1lLCB0aG91Z2guDQoNCldlbGwgc2Vjb25kIHBhdGNoIGFsc28gZml4ZXMgdGhlIGNv
bmRpdGlvbmFsIG9wZXJhdG9yIHdpdGhvdXQgbG9va2luZw0KYXQgdGhlIGNvbnRlbnRzIG9mIHBh
eWxvYWQsIHBlcmhhcHMgd2Ugc2hvdWxkIGNvbnNpZGVyIHRoYXQgYWxzbyBpZg0KaXQgbG9va3Mg
Z29vZC4NCg0KLWNrDQoNCg0K

