Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A47C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5yq/ULbQcu/NmySYjxjNMIDikUI9nmGs8zqqzuTmO/c=; b=QJpEx0U5mTdNRb3b9DVP3WftXT
	pZRqVekEciPsVlfqp15NTBxb7z2ueajzRlTtSoH36Up6+SwbTfQHzfx4nVAYyUGlr6UutE/ye0MhV
	5iXJ7O9/Uono3pv2NXR+PyFyy91XC2geOZlPha8T8/C8U7uCHO71OuG9T8bykEBA2jdi7EAPfuqqq
	dvrnxP5RlZuxW/gOSXAN1mGu5YWJaEl6mK2i8T8QCaJ6gmL4UD86/0NqPWT+H37hU6Zpf0cHHhTiz
	9QRvBr/ogp22aKnh5ZKUaLpIdwhzfMatPtLB2+YnriFG+S0HNOK8oOGhbrtqJdZU7aT2I/P/UuuCn
	Z2KR2jzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFcOK-001SnE-4e; Thu, 03 Feb 2022 13:43:16 +0000
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com
 ([40.107.237.66] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFcOH-001SmU-T2
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 13:43:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qe/uSQ2731tFCZSCIWLtXgHZDuDQNW10R55umHtq5/UY+QEVPbHKK3F6vrdA28/4vzFC6uv4jpOkNCD+6l7eoH4KxRUUz0ZXrD/m6BhWEZ3IaaEWoc5fuoj9t7+0jMGq8KYE8w1EcZTfLX4Pxms8x2cG7tHMiMfkBgb8i9aNwYfX0RE5WDDflTWUBbrfLHKQsG6mkHZLzCl4/GtJQACZ/dgqgDKm7mGu5bsL2WYZqcam6/c49DoVXN7gXRy5PnMeTKPj5qD++rB078SczBAXIwvzdQCOHYLdqAWSXVS46RooCLCnSe3QRNv/ewPbQR624jMguBqh4ZzXX8arg1yMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yq/ULbQcu/NmySYjxjNMIDikUI9nmGs8zqqzuTmO/c=;
 b=MOui7GonbTPsntI/p51lM18CzNTT8tvyKGVVPZMrjP6+potm7YdSrJFQqlphpaHLeCkZb9M6o8XdFDCWT/SDdv71V9mL2gVLEjmPsOIpDACH3oiJytEByQicJsWapVUwRf/Jvmt8hKCpcI0tjZZBpvZlIbz6wwaJcgSScA5qnPDBKmV1SkEvrk3PZAm+7Fnn+UXdu5t9A3QBmOXnvluCpUzzoUjSXbfHGdSmTjXQrzIpQdmLKahODWr7cDFs1b2pc6mXUKhM5U3HiD6xxoXONfU+lFwq/V1qkJDTGij1smXPdgL6Q0eeMdwAdBw4LMv6kFdMpfIhI8yPIvCknqAWGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yq/ULbQcu/NmySYjxjNMIDikUI9nmGs8zqqzuTmO/c=;
 b=AWGX+0E37GVwSdpLTfxI+NeIpuKYYrRyj5f4gKg3T2BkKrhW5i+vB9Jr61CBWFlgjLnQXSeFLL06UTyT8Wz/zok2XAQ4cx2Lt9HNk9pL7WJsx+nfV96aB+SyIJ42IJame5LOqDfdGb1r8ubqb1V8TA2LiUEYd1qMT6prv0LoKgCwIznkaNWxSsB49Kq+/nPK7IdpTJtEHGr7Yp0DilFMd/PX9oOqz7PjZW6doMCk2C/pd33Cj4klFY0P/0A+9eZrn6G4rImsDQrlg1+Or6LE0y3gOVDuJK40R52yjZp1kqN94MY8trnpF0xDBIRTX6Chzvhr7OMgmqSIPLNi5M5ewQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Thu, 3 Feb
 2022 13:43:11 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 13:43:10 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Martin K
 . Petersen" <martin.petersen@oracle.com>, Alan Adamson
 <alan.adamson@oracle.com>, Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH V7 1/1] nvme-core: Add verbose error logging
Thread-Topic: [PATCH V7 1/1] nvme-core: Add verbose error logging
Thread-Index: AQHYGNXNSMdKFetEYEicIhQuvt0CiayBfLAAgABX6oCAAAGxAA==
Date: Thu, 3 Feb 2022 13:43:10 +0000
Message-ID: <724ed8b9-0e4b-4b7c-d87d-32bc6e716d87@nvidia.com>
References: <20220203081153.162956-1-chaitanyak@nvidia.com>
 <20220203081153.162956-2-chaitanyak@nvidia.com>
 <87a89963-edd7-a0d9-02ba-723efe25f498@nvidia.com>
 <37bcb94d-bc95-6ccb-abf9-32e15bcb2a1e@grimberg.me>
In-Reply-To: <37bcb94d-bc95-6ccb-abf9-32e15bcb2a1e@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce3e8902-9dca-48e3-289c-08d9e71b1e69
x-ms-traffictypediagnostic: DM5PR12MB2486:EE_
x-microsoft-antispam-prvs: <DM5PR12MB2486CAF4218C86BF985C1663A3289@DM5PR12MB2486.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:318;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1L9tb4tAhgfhJvYgIsZtIGgVpUkpxymHDZ7UA5bGjoNlL3ZG3Joiu7pfMF51AAifrovSCkHGufTdxP7Ua64yvOYIHH4DXL5Tut385krhycwxv1NvpspKdvfgN5gIGWz4H8h/xAfyJbsX+Q3wLR+p3SB/gNFz/5hhm3rvoZH8q6uGQNSllz8XVORsXEnWYSaf8ZkkGxBZa5yv7H2GGSeWCvGF7cpPnkxLhwrYXBToGsEUE2v1g63XDT0HkzqwVoPRCd6eLhXLca+35CogmQQB4jyLzEnbo2yeeQpZ4B2k7K7jmGmyugaf7qwc0YmbDkrA9njfCh0u6Mh4JqVPZfijIsgT7FHjHZde67IMDY3eLcan3jZN0HqKKIbs6zd1c2KvxO6Pl4tbrp80+L1heeMtWS03rlQJ/httdk62OKWyeDeve4iky8Pu5YBbHd6rVurxJQWvraYrsnBSASaYKgBLJT+HdrKqlH8efwaIg51UCJT1SQG0pepVXp8walW5x6s4sS4d3+OICQWXayrD8kENFGx7GTK3j0HFAqrY8aaqRbYALuMNBo7i8HFYKdFR/SW4u8wvmI5cWUEMdD/NYgg7EfuA9/GHto9l0B/b7OBIZFcVajFIMjLl0N0alXKP9lN3u9pjcmwdHlI9zPsbPFsmiUoBiM3rmlGth7iM3iv5+xx4XeEkpI49c0DhaM+cfWxthn0VcSrysN7q/SnvJrrAgBF4OzdynxcJSQhcfdQ8yUirRZJ3QYCDppHws5bZNuIXtM+hbICdi3JcQdF+lab7ng==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(558084003)(316002)(54906003)(6512007)(6916009)(6506007)(36756003)(53546011)(31686004)(38100700002)(91956017)(122000001)(6486002)(38070700005)(8936002)(66946007)(66476007)(4326008)(2616005)(8676002)(64756008)(66556008)(66446008)(186003)(31696002)(5660300002)(86362001)(76116006)(71200400001)(2906002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3g0bURoM2VCRndpVmM4dHd5VE1TMTZQT2JXMFVwZEErSi9rVGk0ejkvK080?=
 =?utf-8?B?UktLSy9MM01TYWp5QUJMemxrcjE5YlZEKzdDV3BRSFlxdjVvR2NDS2dndW5Z?=
 =?utf-8?B?dmcwakZISUJmeUZDbUY1NUI3UWg4d0pIVithclNKTlIzWXNheG5MR3hNMU9t?=
 =?utf-8?B?dEY4M0VVS29LRU5Ud2UxOUxqRFZ5RkdxaklBVkJDWjBmaHhpcnVlVloxdlhW?=
 =?utf-8?B?dEtGUkFRME5BaHJxN1R6OVMveUtMcTBNL2lLTzlEZGhmU2ozeWY3OVFXQzRC?=
 =?utf-8?B?NkVrU0pkSjJtK0gyV1BXdk8yeGNxcGlnQkdCZWtKcTF2OHF2czQ5clJwREZI?=
 =?utf-8?B?YzFMUzQwYnIwV09GK2lvenpHTWxmaEF5elJEZU1YTHN4ZU5CS1VYSldIUks4?=
 =?utf-8?B?bkJHNCtvOXJRNDRHUDdhYnprMVdoZTZXQVZCS3laaGlpRlVTZ0NxU0R1VTk0?=
 =?utf-8?B?cjIyNEhRaGFLYUpMUXBLU0Q2Vm5teXVrQWZWcGpZeUV1aitRTkpEek5pMWhw?=
 =?utf-8?B?N0E2WjVRWWdhaXZkVzNnanIzWlJhalRCUExaWUZuUWdVU0NHOGNsVzB1aytK?=
 =?utf-8?B?MW1yRCthNDVkcUw3SVVsU2tLN0haenNmRDFoN2Q4UjV6SGp6VGVDOFFrU3Er?=
 =?utf-8?B?cWR1MHNJOTJ4UEdZaGdLT3QyblhpR3JZQnZMZkovNFdCZTBqeVBvVDBvT1Ra?=
 =?utf-8?B?TThuR1VWQkNLb05OSTBFeExFOFZpOHFQd2EzZkFUdElDV3pnY1A3eEJSZFlv?=
 =?utf-8?B?UXJrc1BuZHlTZlNWWGVIZy9POUgwckxRcHZFd2ZlUUIxOXA1alNrRUZScDht?=
 =?utf-8?B?aFBZbGlZeUhxKzVUM3hYMmlidm4weUxSU1pFRHREdTdpdEFKcE5uYWtuUXlZ?=
 =?utf-8?B?RktxbXNQL0dJdXNrMi9oVFBVVStQY0dEUXp6ZnE4YzJiVnVmU05vWno1OWRS?=
 =?utf-8?B?b3NaSDBFNVkybEk3MXRKZlBHYmFYUXNEUjVsbWtjVHFMWEtWZFc2YlhZV21H?=
 =?utf-8?B?NWZwak1UcHpVVW9aT083d2VPS01TbDd6aTh3blBvQVUweW1BNUZjNGYzMFNi?=
 =?utf-8?B?SjZqeWwxYXh6SGJzSkYreHZlWDRMbGlaRDc5cjdQZDVFT0tHczIreDZTbU1m?=
 =?utf-8?B?ZXlRaDUvZUZYM1hPRGlqUXU5U21KUDZiejVqVXFvUzQ3UWxXOTVRNXFtTVcz?=
 =?utf-8?B?NXMrL0dHTmtQMWtoU3VDVk40Qk16QWpJNFBjeisyRHI2cmszR2YxSlc2UlJK?=
 =?utf-8?B?dEdSVHduTi9JallKampGU1VmTzJDVDIrR3A1QVpwd1AwTGpjMEhCY1c3TXNl?=
 =?utf-8?B?M2FZRkdwUjVzNWdkRjJmRHJtcUZkTVRQTEZUQUxNbE5QKzdOeU9sa1ZFWG43?=
 =?utf-8?B?czNwVFNVNHRXWTRkUEMzQ0Q1eVczZW5NZG5xcTBuRVdJcms1K1JnYjFPYU5G?=
 =?utf-8?B?SWplb0xGZ2xxeUF6TUsxVHpGZVFGcmc2clNBaGgraGpEc2JxY0YwNU5PbjVl?=
 =?utf-8?B?UzRsVEpoSDhjMzJ2cUdzNVNHRmhncUs2ZFRWT2hleW80a3c2VDdKcHpRZkJj?=
 =?utf-8?B?WjNIL3Rnb1lIUjlrZnRQVHlKMlVUMmxxMkFFRWJ3UUNrRVF6c2JYZ3BsNFpH?=
 =?utf-8?B?S3pvUVpzRlJKTENTTzVzd0U5dkFjQjVqdnFWdVhISVF4UzJKNkJCU0ZNTzhM?=
 =?utf-8?B?ZENhdC80YkttTmZGUUw4YlhYYWM4aTlCaWR4bWNyaTBYVEdZdVFtU1dGWHhy?=
 =?utf-8?B?ZkFjRGp2TG52R3BsL2h0YXA1NnFjcGQxTjk1NHVkRlZOTnozSlEzejFTTlFL?=
 =?utf-8?B?RDlSUDJ5QWVha1BObzZvWERmMXlhVmk3WS9RaGoxSEo4RDdldVRseHRSbUhP?=
 =?utf-8?B?VXpISUViZTBnN0dsa2tLV0w4bTJDakhEN0ZUdFRJdzMrVTJOQTJhVHhqMDBM?=
 =?utf-8?B?RjlveDkxVGt6YXZLUjNGMXRQT1FON0ZtMzZuc2NydmlZMGJVRG1lL1V0M2dr?=
 =?utf-8?B?ZUxIWTVieHdzczE0S0N3b3laQjByZzA3dlRHR05rMkd3SHJybU9UalFwdlBJ?=
 =?utf-8?B?WjlnWEhqK3lnaTNGRUhzVEpNNzc2em1pYklCVWZlYTlicDZON1p6Vkd0dk9m?=
 =?utf-8?B?bXpYejlqWEM4M1lMRkZ1cThaVXAxM3d4eXZSOWtJa2lXTllxK3NCd3RwV3po?=
 =?utf-8?B?UHFpZWpMNEJUTjVtUkk5VkpqZzhicnJUZU4ybWlnTmZEYi9IejZpRnBINE5v?=
 =?utf-8?B?MkxlR0tDY0l2VUw5cnNrdVMvMmhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <045C2D7F3308FF4B8DD19FF1DCE287E3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce3e8902-9dca-48e3-289c-08d9e71b1e69
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 13:43:10.9039 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lF9DlpRff930Ge1TKB0zesbmaiEu53dTdWLgN+2W8aZ7xvdmcRfTe/nTZji0gkBGElvoIlllOj9FLwLsIAZIbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_054313_968481_D449E928 
X-CRM114-Status: UNSURE (   9.74  )
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

T24gMi8zLzIyIDA1OjM3LCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPiANCj4+PiBGcm9tOiBDaGFp
dGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KPj4+DQo+Pg0KPj4gSSd2ZSBubyBpZGVh
IGhvdyBhYm92ZSBsaW5lIGdvdCBhZGRlZCwgc2VlIFsxXSB0aGlzIGlzIGhvdyBoZWFkZXINCj4+
IG9mIG9yaWdpbmFsIHBhdGNoIGxvb2tzIGxpa2UuDQo+IA0KPiBZb3UgbWFuYWdlZCB0byBjb25m
dXNlIG1lLi4uDQo+IFlvdSBzZW50IHRoaXMgdjcgb24gYmVoYWxmIG9mIEFsYW4/DQoNClllcywg
c29ycnkuDQo=

