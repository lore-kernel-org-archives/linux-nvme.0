Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48B1C3A5A7
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 04:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SG8Xl0IbU9NAQDY4cuXEQpiFfklz0SC7/XzxAIpdn4w=; b=cC3R1nLbWtrGuVmf+z9NGOcr8/
	9JZxuh9BzLsxFo6FGZOP/LK1r8sT33sks3jxXCt/eFb5FwhbJws/AcJtPOhl9r9xUW843WcviCa8t
	zQKLoCb/RO4sNY3E4TJYU3yU3lLuHazx0BOAG0cb9XAw4RYkEGr0B1KyjIkT7q7xsdQemi+hoR3FG
	g18ioIQ+f46aOO2RnqIE2KcCiSzZmz8Qq2elhybsSlMCFPBPKXdir5ud/mS+/KedUN9t+LhLz9S6p
	8mEL4+oSrJCsYAoS+HHxWatD2hg0cgJlAH4nweZRbSsbd0SiPFAjlIaoE9N9OnSHkcL+Gv9u+szR5
	xtWxLFlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2PX3-00HRXk-4x; Tue, 06 Dec 2022 04:26:13 +0000
Received: from mail-dm6nam12on2061b.outbound.protection.outlook.com ([2a01:111:f400:fe59::61b] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2PWx-00HRRg-4s
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 04:26:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqQE9NDBG1HALLxCO5iQetxOC7ALE15rLFQFI94EKBd3mXl1PsHhlWuzqhuHgUzm0XRnqEy0vG6JPvsYp/etZWk+N4siEdYT+s1HvgMdiY5x+AP1Ge4IJl8QH/bn6qrCQwM190TqY7Fs3csUqwJskmDBpRn3te+mAHhX1yjF31BDIRKUpOOGuIGz43RlTpNGewUs0xsdF/sVZy50FYd7uJCzD3LMaRXG6Td7gJyhxFrEFzbDhE3xisJPovMyoli4/LYSTrj3orfG/QrPXf7Y2hdIXzBMT6FWdbBI7myX7rNOzaogW97Xn/JLLVPzjuaDUoj9V/y2hoNNR9rHFLSgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SG8Xl0IbU9NAQDY4cuXEQpiFfklz0SC7/XzxAIpdn4w=;
 b=eq0OZzbHVgoLLdi2CxgnwHddQagZeH4IdMB/GckwXu0Sb5eAmOLQNavcY6FYTHwDSQh9kPbt/VtiqmUnokS9nCWtflJ4qmUcJIyD3001iYaJYr4srn4I2JlVDjQYdJsf5u79/BvWWyuECXEKy72VVyjKJCFrYyHUsnfw+NMp2+0wbXpvkIrZbLViZKSB8wxpPa7RfMJz2qmJe29gD6H13OfU/5CuYLk46EUOjVxKJ/bu3vtZtD9h1RmtRemgFw1F0iOgcqgr6b3PShzuzsuQMc6KtShDPWJckpOwLapdy9JrSUIMHJ4E5UVrHYxQFuRKH5NOL4Ac8QLvFTdFhzZIOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SG8Xl0IbU9NAQDY4cuXEQpiFfklz0SC7/XzxAIpdn4w=;
 b=uGi1DHvuI5NK7ggiFWs90Q4e22pukU+3GMS5AVgXgYRHLaedDd28jdDf+4NDs2aUxnVSzQDUddwaSaeAeg/BHH1cFS1oytyiV0/UIqwjMXfRODj/9pVHuX9WLGC0w050/aSfdj6WIypgKE0Bd0OU8RUu0wlwqeIQfPtNyo2ySwbQme/wU9WeIma9RPoFZWa8GTsK9nQ8pfdd8j72ggQABzDa+ildPHlJ/PmTZgmXaHwGYEWbcQo/x5w1VlFd6WUI2C6tBLYVSAA4YVRsPKV5dVANWgQEAas1eWse6ePk9BuE5I+1RRlH4XihP5RKqE3t3x22VAKKheRkoXHacl6pxQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Tue, 6 Dec
 2022 04:26:00 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5880.014; Tue, 6 Dec 2022
 04:26:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Joel Granados <j.granados@samsung.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
	<kbusch@kernel.org>
CC: "p.raghav@samsung.com" <p.raghav@samsung.com>, "javier.gonz@samsung.com"
	<javier.gonz@samsung.com>, "joshi.k@samsung.com" <joshi.k@samsung.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v5 1/1] nvme : Add ctrl id to allowed passthru commands
Thread-Topic: [PATCH v5 1/1] nvme : Add ctrl id to allowed passthru commands
Thread-Index: AQHZCLZPxXV4tHhzg06tKOhrmR1ijK5gREKA
Date: Tue, 6 Dec 2022 04:25:59 +0000
Message-ID: <bbb80606-688d-f84e-6695-38127227d9f0@nvidia.com>
References: <20221205142746.1026912-1-j.granados@samsung.com>
 <CGME20221205143143eucas1p2c4044196a8ff0cb9b563f99d2a5183ce@eucas1p2.samsung.com>
 <20221205142746.1026912-2-j.granados@samsung.com>
In-Reply-To: <20221205142746.1026912-2-j.granados@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW3PR12MB4363:EE_
x-ms-office365-filtering-correlation-id: e3008fac-2711-4580-59ee-08dad741fa61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Sz42CNJIBzmbMpcaQa1TSPwVXVJBf7oi54Iz7SQEIj5VEgzBM1ACqTC3suxtPvsaqwGLXl8qrtnpSwNlWhaAzumbFINJubNDiZJZ8xCciRcARGHKuQoajz9gY1I7+T+7Tywe96yvYV96RODnotOuzdXtN9IbZWccAh45l0EaJAPNXoSWn83OhCfXkU/XmJffu4CDF6V8Smq2f8bOUZsRg5V9f8jZIoDJbPZjtwkjEhHBisEO5ZvUBaw3Fp2ivRSEdgwHQfEkw2AESQk4+FEVilIU1sI7d128gqbtUi1ZcMXwkJ0CmCQEEFltIZTD4u3iUrJD0BgciUCjeqOoUV4a2lpodnLfaq2y/4m06bzX3uPDFJ9K8BNdXj8/ricFZpiNH2G6itr+8tZootlqYGv7iZZz12j0bE4fgGk5KVbtc7ZvidswNSPEz1voc5xiSRRofy60A1Y8fmfIpBQBrt0S6l8fAag9kwts1cNwYMKfLic/yoB3xGNTOE2Vg7A/MgJe2RY18WMWkRK4CF/X2TKXP+Wh2IwhYm8LtkC/GvY6mzoQ+0tmUteYIIUgJi2PTAJm7ntvwL+kJ9FgU6nrlFfoL8kgZNuFaYPyhZ6fw+9RFFKH5OId0OidNKv5h2PlT30raeS0rZu4qjFTKHk40l43KEGIvL+7lo+CFUVNyKXkVrGcA85bCohhReTp8kzomapjmdftg3z8sOPzhCMKQNv/vYADjwJIcMZzbxOkGgla1Yt2KKt9t0K/bwT4gl+7A8OjzALvNxC2oB5CY7Gyfb/+KA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(2616005)(83380400001)(186003)(5660300002)(31696002)(86362001)(8936002)(41300700001)(122000001)(38100700002)(38070700005)(36756003)(2906002)(4744005)(31686004)(71200400001)(53546011)(6506007)(478600001)(4326008)(6486002)(8676002)(316002)(91956017)(66476007)(64756008)(66446008)(66946007)(66556008)(76116006)(110136005)(54906003)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ckNzQzc4bkhrZVoyR1ZTWUUzK2JXNUFWUnBQeUxaWWxIV3hScjNCa0JhWGha?=
 =?utf-8?B?QXZSRjhCNHorWjA3TzFuRzk0RmRuRGtISXpyeVM5V1VoZms3OWcvdjdBYVpp?=
 =?utf-8?B?RXhlclAvVDJBR2dRSVB2WEJYejNFNU05Y2NzUmp4MmZwNWhwc0JwUEk2NEUz?=
 =?utf-8?B?NWJXRXFyUDNmcGNXTGZNZUdDRzg0VXFaQUVVenV2MitRMTlxTVJOZGJNZUdx?=
 =?utf-8?B?T01lTm5FalR3OCtDci9Xa0JFazNyaS81RzU4WCtxeTZCb3NENXNaazd0WXBX?=
 =?utf-8?B?RGtWdzN2TW53d3N1cDlDK1VjdS9RcTVwV0tpaWUwSnlYbTZYd3ZRU2UvYXJv?=
 =?utf-8?B?dU5DOUE0NGYxWjAyNjRuNUJpOWU5REkxWmk5VjFJSm5SOEJGeHhESm02TXBY?=
 =?utf-8?B?VmNML1FBNkgrL3JHM0JOVVpwNUlzT3pCbGJwaCtiNURNRVpmcExpVmRiT1hv?=
 =?utf-8?B?UWpwRzNuNGlQWnhjanJxQUtQbDF5T0RGZFhkeWlWVkdFTlZSNG55b0ZOQ3Fw?=
 =?utf-8?B?dGxiS0FVeCsxYUJlMkN6ZEtVMW5VeFJreXo0eUxoVUxTd2dkVllqUGI0d1JW?=
 =?utf-8?B?T0ZCWnU2ZHNtSlVMVGQ5S2hnYVdtMGhBVWY0VUdZVGVPTDM1U2tSaHBkQWMx?=
 =?utf-8?B?LzRqbFJtUCtSS0VkZDV5OE5LcmFqSzVwNjRFeWYwRUtFRkxvVmdncXhUdWEy?=
 =?utf-8?B?RXIvMVdjQUVwMVR4bWNNbUhhRmZVWUp1SUhUZ0JTL25qN04xK2JUUmEvbGpC?=
 =?utf-8?B?S3ArdTZINk9oVFV2L2dnSlZXOWcwQ1BXZGdRRlIzenJHcWVtQjZmYXNGNEIv?=
 =?utf-8?B?SW1rbDJwS1B1R0ZmNUttaGVVZ21JMFZkY0hUVm5SRGhDOW1KMTE4bVRBNTRP?=
 =?utf-8?B?VURLK25vRjJLS3lCOVVKSXFYY1JOUUNOc1ljc214YVFnRVJPUlo3QmxuV2k0?=
 =?utf-8?B?V0t3czk1bjBPRkgyWlF4S1ZaaU1EQlNkc3hjby9EMXpoQ0JLN1I5Y28wNjhh?=
 =?utf-8?B?VUhOZnhVNUl2WjBRWFh0elFaTnl3UXppNm1QZjhGQ2ZFeGs2aXZWS0hhbCtq?=
 =?utf-8?B?T29QWm4reUhuSWVZR3U2eXd3ZitKYUJadC91aHZmNjZPaGZjQlVjRXFCVkJD?=
 =?utf-8?B?MjNPVndqMmZPTzJqbFUzak1qZmRNeUhkT01ic0NLRC9aQ285WGg4Z0tuVE1S?=
 =?utf-8?B?ZjMwMGhlb2tiam5rMlM2RjdFUWR2ajBtT0REZEgzV245WSthTU5FYmZxNDBn?=
 =?utf-8?B?eDRwaFAzVmJIdXB6UG9RSG96VVpFN05lOXlSMS9LMEZzMTR5UWhRVW9qYXVU?=
 =?utf-8?B?ZFBJL3Z2K2RKcncyVmxaM1ZLYWxYeEp5cnVwampjdTZlVGU0c1VUYTlVVWlZ?=
 =?utf-8?B?Z01mT00wbndIdVIrOFd5Q09NUVUyS1Z0SzR3a25JQWZxVXRkRjlsUFVGMHNu?=
 =?utf-8?B?TnFiN25pZCtndUxJTFdod2hNSitwWmpLVGpBSzNaWmQ4QWN6WnpaS1ZkblUz?=
 =?utf-8?B?MytVdlQzakJvQ014WHh6TEhVMVNLaDByNDVNSEJEbzZicUdUWXNHbFgvU05k?=
 =?utf-8?B?VHMwWVhWc0c2YUJReUY2RGF3Z1ZhNG9yTmNLNDNFVWpSMmZpdzIycmIzN2ZH?=
 =?utf-8?B?Z3ZSR0VMVzJQd1V5MDR5ayt1YVlSSldKbDlCWjh5andINEV0QXFPMTV5aE1O?=
 =?utf-8?B?bFZzR0U1V0NGT1o2c2N2Ky9SYVU5U2RCdjFwZUc3eTRKR1A2YWVRU1BENDFr?=
 =?utf-8?B?aW9zdXcyR1ZKdFJyY1BuQ3dkMmtDOGdXYjh2NUNRdzBZQ3NFS2tpZG40ZlFY?=
 =?utf-8?B?dzA2aW5GVG5xcENscGFGMmlrRmdBcWZjVVY2WVhLOTNIb1BMM0ZtRmU5ZnZB?=
 =?utf-8?B?bkNCRCtxS1RESmlzNTJIek5vd1EvZDNpYSthZ01iY2NnUjFxZmQ4RkRxNEZM?=
 =?utf-8?B?Lyt3elIwY0ZBWUJ5L3hzQkIvdkVIOWxldzZ0azJYalRmaXR2Si9CRDVNNElz?=
 =?utf-8?B?dzNOYjFmNGMwZFFNY2xjRGlIaEpxV1ppLzlSM2hSTUF0UVU1SlRtUUdMcTJ0?=
 =?utf-8?B?N0QwdVNYZVYxTU5ORm1Va094NXQzSlRtNU5BUkxKa2M1ZVdOK3NXSFJEWmtP?=
 =?utf-8?B?RDV6T2lrSHlISHJMZnEvWFlJZ0xnbEdqbENtbTl0ck1VTzZBOTNtTy9DcER0?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5D10785A1AF614DB2EC92897B69F09F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3008fac-2711-4580-59ee-08dad741fa61
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2022 04:25:59.9720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aD47nCS8HBUyOC6BFtt2xp7otf1VWtyBWx/Fcmw2+zTUUqzRhLWTVtCT7dhV67NhluF4L8Ip19U7rI6JfPYxyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_202607_212709_DE7B79D1 
X-CRM114-Status: UNSURE (   9.16  )
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

T24gMTIvNS8yMiAwNjoyNywgSm9lbCBHcmFuYWRvcyB3cm90ZToNCj4gQWRkIE5WTUVfSURfQ05T
X0NTX0NUUkwgYW5kIE5WTUVfSURfQ05TX0NUUkwgdG8gdGhlIG52bWUgYWRtaW4gY29tbWFuZHMN
Cj4gdGhhdCBhcmUgYWxsb3dlZCBpbiB1bnByaXZpbGVnZWQgcGFzc3RocnUuIFRoaXMgd2lsbCBh
bGxvdyBhY2Nlc3MgdG8NCj4gYXR0cmlidXRlcyB0aGF0IGFyZSBuZWVkZWQgdG8gZWZmZWN0aXZl
bHkgd3JpdGUgdG8gdGhlIGNoYXIgZGV2aWNlIGluDQo+IHBhc3N0aHJ1Lg0KPiANCg0KUGVyaGFw
cyBtZW50aW9uIHdoYXQgYXR0cmlidXRlcyBhcmUgbmVlZGVkIGZvciBjbGFyaXR5Lg0KDQpFaXRo
ZXIgd2F5LCBsb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg==

