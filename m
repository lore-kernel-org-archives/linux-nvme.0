Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B4FC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=04rOMzso0U5jZms/QFtri2a+AQVRRPN5U4StwTTBLqc=; b=Mclw2n7NLhY+L8Ij8S3/WoPXOr
	iNj0nsk37AvP47nV93vtkTQbCSrMpoqWqoP5Icf947cmvW0Vr5wo307Fo9O13r9kmsxqZw/6tjQ95
	Lu6RFMFpi3BRotuUhi6ilAzGmzxJolwGLTn6XWC9CGUB3j3+D56YJNsPQ5fgfRIrXpI8D+krcs/Xy
	kRHJG+RAkzT3kVjX6JQ+1Fwtp4jOaWSi9zR6EmaUDQ39xkLrm9h0tPmhcFTEFwdea63Cme2ZgqC7p
	9Bb2d1EWJeAgpgGvE1Go13FjW0hi4Tk3u1Piri3CnPw4SkBMNXP54V3EwZrdZ3BCT6VGNtYlZJ88b
	2AFFcIxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRzou-009iBu-LE; Wed, 09 Mar 2022 17:09:53 +0000
Received: from mail-bn8nam12on2062b.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::62b]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRzlC-009gdm-Bw
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 17:06:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEunXL0oVSRFy5O3PIniet3G8dkedi3VbG+c8rSYx646h8FDVYtqFzipFKYFthz/ZOGk0/MQ/EOly3oYtUyyeU1SovdB/0uVqSEOKGpaai78nWVCfZjzzE9htQKeCHmwAjwnR55kgTe4Rmwm9aQdOXAGgy9QLl5L6Dbb7AVGJCFCi/lkmoUjmqUk3i+ITth/wS7tvddoOLljMfpp33bf1Z1UXtkjl7c6NMsp9G9eBbKxIU6/TEOKMtu39XbnfxxiFKkFccPr7yA491W45Tp0s9E7eF4hR2MrTkALI3lacBkTHkE1b0rateHZcf7tnfPtWPMiuWvWkh326YpcGj4iHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04rOMzso0U5jZms/QFtri2a+AQVRRPN5U4StwTTBLqc=;
 b=lFU0bAsEPkTh6d4xe4ElFRNbztj5+kO6ISNuVz4I3qftY4qE+ryI2Tl4nx/1I8jcLYo9ky8B0tI1OhbpqKdJd+bzbp5Dz9zz2EJSvwqMTp/5cqZP+I+pHXdiMbtHLKWx3GGyR4w13ltOAJIS9JT1XX1wT8dvfvnucikOkKvFTh4lnMedpHB8BSc2+QtnfesZ4oa47j4KLXbetgKq4zgJ1TAk8GcIkXqYePH6XRUpAvMPp4ZX5rm1OfRgCGaR7/hPl29RfR86ZrQyIHldT4WJV+s7+cLJ+qss4XUVlEvSpXRMB/Aa1+4OQiwq+tc3JQ3JYQdaG84PrShID4YuyqL9Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04rOMzso0U5jZms/QFtri2a+AQVRRPN5U4StwTTBLqc=;
 b=ZxB5I+Z+f+fBs5GuGrTZdMfOorSmt3P65qYzL2NNzIBuMZKlpfZ8ddunuKI73EBQ9hP8b3XmVRK7UaxUFGuZBOcwkLjcGxsZvJRaJQSEFyPmZiOjJXCoAZymoKS3NpLzGGbIoI1UPS7M4AWgvaLoDv8Y0j7Pn6zwIreyencEYEBepS8ye3Qegi1rO2gMQt6a1OTxNw1iXkAL5ktK4Sf7JiqxEaPFxTn+I9n2BeXeq5CCZcN5qWDpcEmrDB8FZ1CbYd0yTiiiTzW3ybFFoiSZF6S2tCxkUJrIQkfLTPOkqnSbmqq7KCE5gXwEQ/AFD4+IfLi6Cf2dcU83DgAEK/rEFA==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by DM4PR12MB5844.namprd12.prod.outlook.com (2603:10b6:8:67::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 17:05:59 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::6065:161f:451:70fd]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::6065:161f:451:70fd%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 17:05:59 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>
CC: Hannes Reinecke <hare@suse.de>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme-multipath: use vmalloc for ANA log buffer
Thread-Topic: [PATCH] nvme-multipath: use vmalloc for ANA log buffer
Thread-Index: AQHYM7ndJOlBcUYiMEO4Kg5u9rovaKy3OI8AgAAMp4CAAAM6AA==
Date: Wed, 9 Mar 2022 17:05:59 +0000
Message-ID: <d04ea39b-fccf-947c-481c-0134d56bd562@nvidia.com>
References: <20220309132900.1171-1-dwagner@suse.de>
 <7ce203c8-792c-8e34-eda8-3b44f873c5f2@nvidia.com>
 <20220309165425.dcu24zgltmswpbh7@carbon.lan>
In-Reply-To: <20220309165425.dcu24zgltmswpbh7@carbon.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29b473a9-6dc9-4c25-f6a4-08da01ef1544
x-ms-traffictypediagnostic: DM4PR12MB5844:EE_
x-microsoft-antispam-prvs: <DM4PR12MB5844F2ADF1AC578A4644432BA30A9@DM4PR12MB5844.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5Rm2kzcqSHJFH3HcE8Gf2CM6bbpVq4WnsSw5Phq0DTAKN0wQyx0wldYP/uCjgB6lVL4L4bTDTNXQnQFI8xsUefVQM5ARIbCEf4UCNMOLc+caAw5LaD0ohzXOZ9IkKg5DmVS2VKtrd2b6aI0CB8NpIXZ87Ok2fD2SrkPHBLJz9qpfLTrxIBAYaVPwijdnGLWe6O9YFLYUVXgeff37wlxr86+sOA8Sx+7YzzJrJu2NDKu+dKM5Bz4JWfLJ320nZecmdIuGcZi5aEB3GBu/ZnJU8fDhMmg+ft4H8yCW5JI0q2A6VwzXwNgcpwGWK3SDiPCz51wcogDBghR0+BqADNsMdQlCBwwF+C7QahZdoCjZNNWFryGoN3ego2lB24b5NqnoFqrOnijalrAoDFVTa7Xr+XQZe0woIZdmkpzSd+pGNXv/Y5TB+4T64Cn9+qRGSolDTN6lAkWl55n0LYqHQSBOYdP7ljSZc+YxU0cyo6enmitZRrE+R/iVcNeMr7D12v9kwp2OCtdlrBeThueOTergRxQZZDWyL95ON79zoBMwWUL7QLL3VNmeBADwzeROw1DKjUk196zhR/KiCqiufNjdMxdaslHQLxl//RpU1GXRX3LuQ9wZyGl3xziEHnQf1xgHrX+7ZrZ2gOCBi0rNQouGrFNH/qZvKUoJ3Q08SQBTXb5SlCL0os2qoiOg5mYW82F29SLI6VmlKOFNOWUbtpta26mmrnZ55A4rlIm7D+uYc30CYfVCXo2fl9Wt3uaoqz2UWsIbynFFgLo6n3xJ3Jp0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4659.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(31686004)(64756008)(8676002)(6916009)(4326008)(54906003)(316002)(66556008)(66946007)(66446008)(38100700002)(91956017)(122000001)(76116006)(71200400001)(36756003)(6486002)(38070700005)(508600001)(2616005)(5660300002)(83380400001)(4744005)(53546011)(6506007)(31696002)(8936002)(2906002)(66476007)(186003)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1FRUWd0K08wcTVPZFJ5SjVKSjIvMW9EZ1ROZU9NVDdiakZBUzNZRDh4SkdD?=
 =?utf-8?B?TDVNanNseUpHbW1oZyswUEJQYVM2ODNLNTNUMkNsR0d0MWd0aTIwVlprV3ZH?=
 =?utf-8?B?V1NLYXpObE5peTZzc3M5U09qWHVmdUxIaFF2aXZWeFFubkMrMSszak5WT0Qz?=
 =?utf-8?B?d3p0Z2lvWSt4WDJScGtSOTVRdmthem9vd2ZHNjQ2MStMMURYTWUvUmU5djdQ?=
 =?utf-8?B?UXVGd2tZeGVsVzhZSjZyOU9HeXIvdWYzaGxXcVQzN0lTYWZPbG14TDNhb1pT?=
 =?utf-8?B?VllSUkU1ZlQrK2gwaHkxM1Noa210Mm80anpxUE5FRyttcnpkaTNJY1FMVVYz?=
 =?utf-8?B?WG1VVzI5Qy9DamY4aUJoN0VmNXZST3NSTnhVbjNzM3p1bEN1R3dUZFZFeWdj?=
 =?utf-8?B?S3ZSd0tMcVNkQ04wcnVVdlV5b3A0NFdDbThJanFONXFpQ25PYXZ0dkhOK1Nn?=
 =?utf-8?B?cXhaZURrZVBmN0dvOWZ1N1J1Yy9jQkdkNGNOeklCSHZIaVBKKzcvcDdpVzY0?=
 =?utf-8?B?b1R2SkFCMGZnRHozN0NvSjlQSUh1N1hJM3F3UC9IbXBNc2pRanExMFdkQW9t?=
 =?utf-8?B?dDV2VDl0ekR0YUl4Nzl1UnhPTHU3anMrblhBZ0lLNS9oODdTUGkvMjJJQkVP?=
 =?utf-8?B?UXV2bDM3NitOWDBVTVZoZW9QRGNvMnJtTGN4RXdhS2ZpTnlYSUlSRWFoYmR6?=
 =?utf-8?B?NzZDMXUwbGVxMUJzNUlwS1JCU2JxRVNUdFVUMEMwdFErYVdBWFIwM2xXZkN1?=
 =?utf-8?B?bERVUlBUdGZlMTkzNTVGRGdmRS96OEc4U2R6bDRteGlQVHB2OWJVbXRxQzdE?=
 =?utf-8?B?OHoyRlJScnZuMU81M2s3aTg4bjRXNDAzajFVcURuM3hCR21sVktTWTJPMWQ1?=
 =?utf-8?B?ZXhBY3ZxeGVUS055VTErSDRMY21uWGljMk4wbkJ0ZG5zdXZQSHV6emFEeC9Z?=
 =?utf-8?B?aGJ3dDRSdXJBSmw2SEEyZ3AxUFQxYzh5NktCWS95Qk14b1RnYmxKc0FzYmVH?=
 =?utf-8?B?UVdtOFVKRlYwTFJlZWZuc0NOc0kxZzRKMlpyd3JmQitLeHowYWZNdUlMcHZG?=
 =?utf-8?B?WVhoT3lTREhudG83RjdqajZvenIrV0ZuTkY2NHoyR1RxOHR0MEVYd1FCQUJx?=
 =?utf-8?B?Vi9HMWtQZFNKQW9KWURUL0pxcDRaWE4wWXhoL2RyNzJKNWZWNDZzVXFWMXl0?=
 =?utf-8?B?Wm95MmlUb0Fma0k2UnY3NGUwMFZicDAvanROT08xVkNVR3FndlIweldtNStu?=
 =?utf-8?B?K0FVbTYzR1hiQitUMzF6V3VWeTBWcnNPZzJLa0NwdkcrSWRTMTEzaDBEc2hI?=
 =?utf-8?B?bEwyQXJVY1hnOFVHbWFOUm1ycWNnN3ZUS2xGdU9EWFJvUmloMCtiU3RtK3V2?=
 =?utf-8?B?N3Rwck96aTRiN2pJRS9SSlBTSm5wZDJUcTArNVhIeFh4NnIrTXBMZFUwSDVi?=
 =?utf-8?B?dVo0dkh6K1g1TW94d2grR1NjZjJiaU9odnFpeitTUk9DVGhxWDJ1RWVyaE1F?=
 =?utf-8?B?Mi90N285cGhHY2ZmYW1vWWVpMkdSdDhXMUJWUXdCTGNQckk5dnl5dW84aTJJ?=
 =?utf-8?B?Wk5YdVEwV3dNVUlRR2ozSUpXYTZscFhxZXJXUWNtY0kzbStKODl4ZFVJaE5B?=
 =?utf-8?B?a3VpVkMrMFJDcSsvRW41aVM4QWdudmdtTDY3UHJLSFpQaEJ6U2VSQ0l5aDlU?=
 =?utf-8?B?OURsdklicURWT0RGVTNHRDZuNmRINGFkVmFWUjEwd3drVnFDMEhFSXljTExL?=
 =?utf-8?B?VlU3SGYvcm9oZ2s1T1JJMHdiS0lnT21KZ1BWN2tkdUhzVVl3RXVQcjd5TUlH?=
 =?utf-8?B?ZG5BNFFHN1VHRHdNbmJUVVpsK1JXOFlCdy80TjRaTE1RNFNycklzYTNiOTIv?=
 =?utf-8?B?S1E1M1Q5dFBvTnBEdEU1MUNQNG1oaFpDL3BrMkFPck5LUzRndnBCQ2JZWFBp?=
 =?utf-8?B?Nm85S3VmVk11YnBoUzhwcTc3QkZqWkZRZWRGcko5U1ByekVBekVwb3lrTm8v?=
 =?utf-8?B?RStaSHhGQVpHYmowSHJGTUNOWWhiQmNGNjFJU0FFOU5sK3lKNHhZQlI0U1BP?=
 =?utf-8?B?WE85MzBKYlMyRFJaemNVRUd5RTlMdTJ5NEhBa1dFTThnNlY5ZHBQY0hTdHZ3?=
 =?utf-8?B?MXNJNWp6dnlwc2xIRW9LYm1YU0d1anZ0SEZraE9SUlNxeHNVNjBjbzk0aDRw?=
 =?utf-8?B?VEhqMGd3dXJtd2tOZ25RN0l2eXpNdDJzbjljUU81aWU1eDQ5aHVpVEdldExG?=
 =?utf-8?Q?edIG9aVAAAfV4oyz+W2VTqJUO0pVIiENRja64npNfk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53F791031EBB57429BD05C653E22D5AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29b473a9-6dc9-4c25-f6a4-08da01ef1544
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 17:05:59.1374 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fWWvu1T/29lIOvozPMxOextNBYLxDwueiPtghHWwcE1CMrRZikvngfeUcfFVMG4a+qAtQMSoZDJsU0xTU2zbzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5844
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220309_090602_483541_06C59591 
X-CRM114-Status: GOOD (  13.96  )
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

T24gMy85LzIyIDA4OjU0LCBEYW5pZWwgV2FnbmVyIHdyb3RlOg0KPiBPbiBXZWQsIE1hciAwOSwg
MjAyMiBhdCAwNDowOTowOFBNICswMDAwLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+PiBX
ZSBuZWVkIGEgYmxrdGVzdHMgZm9yIHRoaXMgYXMgZWFybGllciBjb2RlIHdhcyBuZXZlciBleGVy
Y2lzZWQNCj4+IHRvIGl0cyBsaW1pdHMsIGFueXdheXM6LQ0KPiANCj4gVG8gdGVzdCB0aGUgb2xk
IGNvZGUgcGF0aCwgeW91IHdvdWxkIG5lZWQgdG8gbWFrZSBzdXJlIHRoYXQgZnJlZSBtZW1vcnkN
Cj4gaXMgZnJhZ21lbnRlZCB0byB0aGUgcG9pbnQgd2hlcmUgYW4gb3JkZXIgbiBhbGxvY2F0aW9u
IGFsd2F5cyBmYWlscyAobg0KPiBpcyBkZXBlbmRpbmcgb24gdGhlIEFOQSBsb2cgYnVmZmVyKS4g
V2l0aCB0aGUgdm1hbGxvYyBpbiBwbGFjZSwgSSBkb3VidA0KPiB5b3UgY2FuIHJlYWxseSB0ZXN0
IHRoaXMgYWxsb2NhdGlvbiBwcm9ibGVtLiBVbmxlc3MgeW91IGFyZSBpbnRlcmVzdGVkDQo+IHRv
IGZpZ3VyZSBvdXQgaWYgaXQncyBwb3NzaWJsZSB0byBET1MgYSBtYWNoaW5lIGZyb20gdGhlIHRh
cmdldCBzaWRlIG91dA0KPiA7KQ0KPiANCg0KdHJ1ZSwgc2VlbXMgYSBiaXQgc3RhbGUgbm93Li4N
Cg0KLWNrDQoNCg0K

