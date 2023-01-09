Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E24EC5479D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 07:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8g72qj4Gmesi+m3lE3yPFDArfBPH1NnWIiDkctznrkw=; b=hiswsZZy9/nqOLPacV4sl5ceid
	DIHKiM6gdwDHzNZLsA0bKrqSArAnEx163umr86yH3oivepgTIQocYQMlcaN6CQ3J6Gc+5IdV/zXNP
	jg+gvqW1JzOEHDEwFiCScgGETYJGqafcwUsQ5mVVbLlAqaJUvM0o0CjcYtXMKYBYi2eQ9HZVsGExN
	fRM9Ov5zDk++P2KYxBxvy3FiWTvEZiFR/cyIJp+J0xsIBE4TY4g0tisq/RGXJ5aGSoDBFVU7IceJh
	/Jf9+GtRRfGHFPB4wqKjc1csghlnOXwzsLocvukYqnPU7bZzXYOhOV6W6B3he4TuKM/7mZcfGbqrJ
	j5UfOZhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmfp-000DKk-PA; Mon, 09 Jan 2023 07:34:25 +0000
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmfn-000DJq-2Z
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 07:34:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/r2NkU5w4avOhhm1t8hX0RpRTawliImJJOU9S/lJk0UjRYt3qjPyC1ftL56X/1aGCUHIxyvmQFeiCDIAJBemS/i8UXeExG3Gp3vW7IMoBGujsGYN0tZZEjZcbaHQaavqJzioSg27TxyPyrQQ+1iyCazB4TLQYf3aMn7NL0yvFHUTmDK0KM2EbEn4snAUjpYTBca8ue7LfoYZJ+PVU7KI3zvY9e65B4vtcFm8G1G0W824NuzVD0Ccitl/ZcMHZOKgo78MXl7b6rMJgzYb224X/+vU3wBVYSK3K5VpWaHriUjv5+ntoUMfsOiZFM1+mu3p2Koj/t6UlvQJrnzkBAn1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8g72qj4Gmesi+m3lE3yPFDArfBPH1NnWIiDkctznrkw=;
 b=aOx+pTta/RkIVk/Q6IV5eElXq1mSCvmm72508eyeww2bqqbbRLX0i3eQyVfM5J2u2rdDZf+kphSCzc0Lyrc/Ezo7b0yrZiFunnTevelYO8le4997/X01XG0+7sa3eWczOW7eSSJdm+s1F8u6ORwdSQg4VAiqK/CYI8s7gQcQaFTsEcUPhUKTU3XjNbRVA3IBQDRkn0giuiTw1wYi7n2+4FbFYPxe3KNxeMZW8bltKxNge8soOoQfVEYGRVPN7y3qimGTIJjicOoCeAe5IgBBBuXoVLSenTqSRilLyIr6zTUKcbVqvHCLPa47jzQI9zDf9zDNIoR5jBj7NGIH/DLCgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8g72qj4Gmesi+m3lE3yPFDArfBPH1NnWIiDkctznrkw=;
 b=sgNhfQrINymDcT/sX2+B1u5CYlbQUk+EHmN3jeuBz6KLDNQCJL1eCPhOLeVKAW09OKm8PEH8xuci/UxL7bXqEbKsRA7ePBGvphQqgSzvjfO+sgo3fbZGxC6rvJ7H/2HmdQAl/FzxZGrog0RjBRUjor2PaQkme+hA0P6ybdoBPJfoQ0xaS7/JZcd2MWE4EInnvqfcOdyVUZUZGcVHznL84YJx4oLJyiay+OsUPfPawUvHNjq6Vkwgh7ARlNEMveQYB4gk7YPDUlMwOo+MRI3z4KfdN1DCB8rEa8CDNOxYf56sbbfaIR+2O9SWJGhOMeTXJfSgMdbksb0bvaOyqovd+w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 07:34:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 07:34:17 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Kanchan Joshi <joshi.k@samsung.com>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 1/3] nvme: remove __nvme_ioctl
Thread-Topic: [PATCH 1/3] nvme: remove __nvme_ioctl
Thread-Index: AQHZI4FcIRIqMjNPJUKpwWjsUgoLT66VsosA
Date: Mon, 9 Jan 2023 07:34:17 +0000
Message-ID: <814a0383-8be2-426e-b2c3-c6d5113b82f1@nvidia.com>
References: <20230108165033.380842-1-hch@lst.de>
 <20230108165033.380842-2-hch@lst.de>
In-Reply-To: <20230108165033.380842-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|SN7PR12MB7250:EE_
x-ms-office365-filtering-correlation-id: 8626bdbd-04eb-4e88-c7b5-08daf213ea0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Q+tacf6wX9fPJ40CZCTqNNMvtL4stD5wKut0g8jxGHLqGPJ7AP4FmHl88K+5OPjvVO25GhJdv30A0A3hxcgM7QxjmsRU//JuX4r7ZakcAxpddVQ8veVzzZk7qh97adRAsFta5KeHxpReJtLmEnfk5qL0EfpMtProGpNvHFrQDwd1NxFTRhb1zLhTZp9x3KX35v7eKlHDnItwx1GzKMLnOF3ZJBEaHO8NFN2M7Ii0jmH7GxQB0wCJKmw9cDEoFmAOL3aA2VobpzX/c5UcoDHcTJMc1psxg1MyG0oVKwdrvCKWerD7PkWaxaoRwXYxZYByAl4ElRmjgMIStQlsUO8s9rvkVYYRu1bfbGPwp+kfLlXjTLjfztCzUWStOUB3e5Wm7wMcgPmzVI+ZMl41q+//vmsdFvnblRgfI4REnGsyPVFtpMxdEMWzyFd0BUK/OYm0v5gMdPb4V8YbVt+PqfCdZOkkr13QPv7dGxrPCrBWrb39/mEczVrdahI8d1g6hx/Gl+xRvQ7IfVpM+JjhDyJYinRDg1CwNm6bAQ56ulsW8g9MCIVl+ME3feGLgkNOg1ZJcm2b9qEFghihfwo9Oqw2dA3l+PXZqQUYBYf365daDbHSlsy/Vb9aTRN6J3w2KCRQFjAooZhHMzkvY8jrLcS5/sKwwuZj42tQf51dCj/h4zZ7dzM4h+qV6Msh2Dsw77HAErZIS/GZR4t/qhpweIUZQyV70qnh+OLrUAj2HX4tL0TVk/qaDtyPHW2lKSlwaNS6g4c/U28+gfKgIpckbOaRaQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199015)(6506007)(38100700002)(122000001)(53546011)(31686004)(107886003)(2906002)(6486002)(478600001)(2616005)(558084003)(186003)(6512007)(5660300002)(316002)(71200400001)(8936002)(36756003)(38070700005)(86362001)(31696002)(41300700001)(76116006)(66476007)(8676002)(91956017)(66946007)(64756008)(4326008)(6916009)(66556008)(54906003)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dGhDeW04RUkrZmllNkZia3hpRU9zeTRKRXJYN1paNWtlSUJJc3FkWEhBTFE5?=
 =?utf-8?B?T005R3puWmRaV3NqT3ZSU3htRkgrcWFuUFRGVEM4czlEdHJadURYNU5ybVJN?=
 =?utf-8?B?NzF5b2VweWFvWnUxOVFXNG9POFJQeDRCdit5aFN4aVRrbTVLQkpLTmdSamdU?=
 =?utf-8?B?dlZCaENjY1U3VGc0ZTBDczY1bHpLYlVScEZaaHNGWER1eVg5VUwrdWFhNFRv?=
 =?utf-8?B?WFZkZEZ2NzRKeVRKU3N6WHlTVzRaU1g5MWhDeXJEWUhOQmJyYWpXVjVZMktH?=
 =?utf-8?B?NllySDdDQXB2eFFrZ0VlVGRUclhkdkFBYi9PZUhLbDE1NFFEWURFZ1BJc1VP?=
 =?utf-8?B?aGVIdnVQNXZwcWNKalZkUkZTVCtTcDJ0YmpTcW4rOE52NFQ3ZmdKVjh6YlJv?=
 =?utf-8?B?cjZjZTlFSFlxQlYvT21ueVBrdjNCaStONy9SNTk3Z1EvS016ZG9sRjUvLzhy?=
 =?utf-8?B?QUVhR1ZLZGpzRzQ3eGpjRU5LOElQeTlJRGhqZnZQYXhORkpKdGRub0V4ZWdY?=
 =?utf-8?B?V25IQy9paENEaDQ3b0ZQRWNsUTFjejFsRlNFY1hwUWZheXEwR1UwS0pBS3I0?=
 =?utf-8?B?SE0zMEozbENIZ3JhakRVUmdJUGp5eHBaeXViUGtUb25qbmx6S0pWakZEVnhG?=
 =?utf-8?B?MTk3RUtPN2ROUzF2WE4zK1dFbmlkc1VDYTVlN0w5SVZYNG9xWlV5UG14VXhY?=
 =?utf-8?B?TzJBK0J0SkQ4VGd0b1pTaDNZMWdRazZOV2l5T0U0OFZ2R2hXWlhJYW1Vc205?=
 =?utf-8?B?UzJia2NGanhFQzV0KzNPeERNaG5WTFluOGNNODJXbW4xYWJIZldxTXJmT0w5?=
 =?utf-8?B?dkg5bTFZamo5YWJGaitkdy9aT04vM3FRaElYOVNteUtXV1Rhd2dubnc0Qkh5?=
 =?utf-8?B?RlVFeS9hQkZXNlM3bGxnc3BGNnJVWDdOQ0FRVVd2UmVJTnFCeWlTZGRoNWVL?=
 =?utf-8?B?dkZJNWNqWC9lK2ZQeDhqK0ZZQi9NSTZqV0d3SnJKK2hCdVJXVzRIeGk1UnM2?=
 =?utf-8?B?SWRIUTJrYjcrWUZCNE5ENHBESENvMHA2eFBsL0ZvcjhBaWpCS0lBUHFGUWJy?=
 =?utf-8?B?WUlOcmNQQ1VxWWJPcXI3TjVOcGlSREE5YVE1NVFsV0NSK1Z5L2JjWHlyRUdJ?=
 =?utf-8?B?bDcxbnRJQXo4bGx1N1FHWDhQK3M4SlYyWGlSR1RiZEdOcnVjU0xSdmJwb082?=
 =?utf-8?B?Uk5kcVhhdkZvekllOXhvUyt0WThYOWNoeHpBNitRd0V6Y1ZsSkdJemx2bnAz?=
 =?utf-8?B?LzZ2Y3A1d1UxQWQvYUZ1cDU3Yi85cW5pTWJyL0FVeTFQU1hjV001YWxHT1R4?=
 =?utf-8?B?cG5PdzFWL3VhMVJ0Rm5lNStyVGRqS3MyMElhS1NMSFd1d29SMTQ4R1BwL1oz?=
 =?utf-8?B?aEFidnBQYkROOC8yL0IzNWZpS3Y3ZGRKUXUvMW5wVnBHcEl4Q2tOcm9GTmZo?=
 =?utf-8?B?SWVkV3F3YmRHZjY4NHA3QVREZTJ4RVRCN3dUN2xwV05SbDE1VkNFSVdieGRI?=
 =?utf-8?B?cFk4TTk3SUNrMld2cEZsK2E1anBwcmgzejBRMFlEQUdMT1lXY2grYWp3bkxj?=
 =?utf-8?B?aW5ad1JLWnkxdHhFVkFKYmwwN2RWWWJIUElhVW9tKy8zZzZIby9YV1VNamY0?=
 =?utf-8?B?Z083OWpWOXlpRWZVcS9RRWR3TmYzbGFnUUNLZGhaQ1FiYk9UY3lhYm5zRUp6?=
 =?utf-8?B?MUpKUEovM3FzbXp6dm50c3FGL2lhT202cFYvWXo2STduZGRnMjhjbnZxYzZS?=
 =?utf-8?B?RkxiLzNpQjRmNXZZMHNjM0k1MFRVa1I5VjY0UVFCL1pNaVdJRmVPZk8yb2ww?=
 =?utf-8?B?Nk9pOWlYV3NONXNSVGJyUFcwQzdaUUM2ZktjMG5kZjFuWVQxZmxWSXlyZ2dO?=
 =?utf-8?B?SDBzUTdiODMyY00zdVl1UGZxTDhjNjhDdFJkMzFoWkhVbnUwTHNsZ24wT2E4?=
 =?utf-8?B?M25yUjlvbmszMmtUcXpaSlhXZWpXKzdzbm5laER3ZkpZeFlLWkY3TncySFJK?=
 =?utf-8?B?OExBVGp5YXp2VFdYbXVjSFVKNVY5NG1PZzJMQUkydWlMcTRTK3Rzdis4Nk9W?=
 =?utf-8?B?UkxvVUxzeG9ianRPemx4eTJ2cjQyOXNGUE1RemkyRnZSK0E2UExYVEFxaGp2?=
 =?utf-8?B?Z3NKbUptVURHT1FKbVVXNnZuTVk3aHJNbWh3Q29JcEpNZWg2NUFCb0tWNmJK?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6FE6E1FD8855B428AD0C2EBD82EEE40@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8626bdbd-04eb-4e88-c7b5-08daf213ea0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 07:34:17.1262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mlWWElw4U2Ggq6Ng5eEaKvC/mhFXtlQuE0FcwZXCjLvQ7oirIwdMMkZ9pAfQ4/Q1N/e7bCrtiW/sjV+zltWZhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_233423_135267_4F613425 
X-CRM114-Status: UNSURE (   9.89  )
X-CRM114-Notice: Please train this message.
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

T24gMS84LzIzIDA4OjUwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT3BlbiBjb2RlIF9f
bnZtZV9pb2N0bCBpbiB0aGUgdHdvIGNhbGxlcnMgdG8gbWFrZSBmdXR1cmUgY2hhbmdlcyB0aGF0
DQo+IHBhc3MgZG93biBhZGRpdGlvbmFsIHBhcmFtdGVycyBpbiB0aGUgaW9jdGwgcGF0aCBlYXNp
ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4N
Cj4gLS0tDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==

