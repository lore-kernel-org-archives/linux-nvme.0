Return-Path: <SRS0=W3/M=PH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5942C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 06:26:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77DFD610A1
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Oct 2021 06:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 77DFD610A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E64B6XzxGu9Urm/3X8Jgw2dhwepjMPfCslXJZBOut+Q=; b=pC4XX81pSuaqMX+H4n3S9y3Rot
	NaVn5S3Ne1+2DE8Uk9ZHzSWYJ9XvrfWkhxx2WhLGyeWmD6D2yIVzr5zbe7gAvojLJzCH3eYtsw3kd
	AQb9rJ9PPwaIhpxhMAuIhv0YPfH4z+cxGrkZFS44xfx2yJsAj7aj4tn+ndQYTfdt6JAbQssWtJjep
	imtC7nhjzdIqF6Wp5JBzXFerNROUh+LnaoMXFU4PHO8A4L7eCMN8lqQlNhcOWbajSXHfDhQTHUCaF
	mSzDDNybYlDSZkBo9CZCCTlkB373zVqvJRPtD/zWfHffa4ZsScaJ4zghF5+fAHJYj1IYZllnzVx91
	kNg+f7sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mciZv-000Hi6-5r; Tue, 19 Oct 2021 06:26:27 +0000
Received: from mail-sn1anam02on2077.outbound.protection.outlook.com
 ([40.107.96.77] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mciZt-000Hhc-0j
 for linux-nvme@lists.infradead.org; Tue, 19 Oct 2021 06:26:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijiuxna2oaSnnMJld9onHYSX/ChdNJGgglWh4q1Qm0yEt6hzInVcgsBs/yqNs3FtWG+IAUl/RDteLzWa30kPpfoXJIlcG9Z+dj+wOO0co0CgyMC9hPRgESGxxomPvSB9+ZBNkmTRAo6xvufttymw0APrqKCmV5BswEnMmxPxI1yzZbn7CAlRGZK9U0WRsN0V2UKUci9CbQl4Me3uhtAeTuEoRoGgjzKEfBpISlAmWZRzvKYOvjWzrCxaRPSWNUjGSb+Q593JiHZqpmGxhN/gEeVf8VoxsFHGqor5KMU0CmOXPYDWJmphkM5Yx3AEkfLG/FlWGrroUue9j08nYpcS4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E64B6XzxGu9Urm/3X8Jgw2dhwepjMPfCslXJZBOut+Q=;
 b=CutmRqGh/6jvWn4n/2Zq8ZBspGEO0G0rWpLUk6IzOQw9p6Q3mE/1bAZ32MTY9Bqitu5EwuEGTG2pyRTNPDh0t4WkLOSf/XoP2zSROTzRr1+UAMTkj5iB00GVnSoy/GvRCPRCws3ERTH2z8KxA5RjdNaexmwxtkZ/b3hVuJY9U8YSTwT6bjI9QDAqKjLirVxCxx3lKlLsLBv3R4TSTPYP/AE4vCBKXYwFuJzGExXsV/8qmj2WAL0PaUBEKyXslVJSBr3v1NlXb86O6zcc/UqIvhVfbScH4lgDS8x3V7evp/hl+r3RUspDViCHHwgFaO3EcgM6vu/nvilnQobg7HKIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E64B6XzxGu9Urm/3X8Jgw2dhwepjMPfCslXJZBOut+Q=;
 b=Zbgosxb93xW+O7aZjsmJ1Q/tbOkH2fC3LxRzZOhjd4enLDNsHlD0waOFnXDPG0rEq6w1Qhr0h71GtztJo0CLZwO3Tax2HoMYFfO9T4D643/19sxyHoEfJcGlbdijVCnjJ313b1lmkXxtWvP/AtNhgyz5jJrm4O6j2sID3sLARG8HzVkpYBfGw78dvRj7x+M3lIDLE02fXVa3hPvIDZfwHVVgwkVEfAcoYXryiJXV9rzIVCaqWh4jrQWSR/ss+0Zv5tut43clRIuD8sujd4f2dA4qAQaqwViFjKFbW0CIyrIIIib/oRXjF4QORZOl7TJUlvaXcl6TBYAGMYjz4HH8dg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1135.namprd12.prod.outlook.com (2603:10b6:300:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Tue, 19 Oct
 2021 06:26:22 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::3db1:105d:2524:524%7]) with mapi id 15.20.4608.018; Tue, 19 Oct 2021
 06:26:22 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
 <sagi@grimberg.me>
CC: Israel Rukshin <israelr@nvidia.com>, Oren Duer <oren@nvidia.com>,
 "jsmart2021@gmail.com" <jsmart2021@gmail.com>
Subject: Re: [PATCH 2/7] nvme-fabrics: introduce nvmf_reconnect_or_remove API
Thread-Topic: [PATCH 2/7] nvme-fabrics: introduce nvmf_reconnect_or_remove API
Thread-Index: AQHXxCXAVkg1HCzEt0GxK2xxyFkxAKvZ3CwA
Date: Tue, 19 Oct 2021 06:26:22 +0000
Message-ID: <c976d0ad-cfe0-2f9d-c8f6-570893b85cdf@nvidia.com>
References: <20211018134020.33838-1-mgurtovoy@nvidia.com>
 <20211018134020.33838-3-mgurtovoy@nvidia.com>
In-Reply-To: <20211018134020.33838-3-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ae207a8-a63d-4f6d-abfc-08d992c95e9f
x-ms-traffictypediagnostic: MWHPR12MB1135:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR12MB11354D70FB41D19E525A5DC9A3BD9@MWHPR12MB1135.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZATz1BcV/AHyjuCBklARJAGWiI9m95JCskJokg7LkGCVfPVjwbF3ZOcy8yAw+lHRD/TqxMOQQ4LPDILfVW9ZAUDWC3ndyQGVPHYvAn8AZhJj8x7VNGHmgHfjX/agZekmNSm8026xGv50zZoY9rUajfnqiIVoVJKZ9eXqoeZSylM5R84dged37f6KkzlOm/rI0WWSlDTNlh4d1tRRFYh3+9pRLD7V3SlPTtriKDU7jR1e306rEOLZWSX8VNAJQjIRpHyA9SpoaYNc1R/FRviZIBIRIoLURKcPSRdmjkWA6iPb0lQ2dlIzwDl84ogW7aexOIaO+2mnehJMTxFOxS8yPQofgwzNHbgRaXuxANB8zOAQ5arQ3YIwYNRi8eVjKUB75G8eyn0CFfssIJ8sJJUnsrJIsl7tdAbuYNLoUpJ0Jj837cHs+HIfklaVXz3EEpfWfxNjgLdy9bCioKS3MMh46LbsadJVvdIIZFFPzTE0foaMVHpBQcKr1OxKwV9u4lnnURO7zVJimuxDR2haSwass5Xo2uAhjR7L6gyZiVpXb24Xj7KEm2v51dcb38NuRDXdqXa3cIaieadPATYDRlkdzh1D60WyYvYleaNIcm2NbfuTUOuzl5k0tfLqugAKh/HPnJAduN9f8ALEk1HWN7gNmRKqNlOa0yN5ssg5t4Z2ip8QGIQwJxdgitCx65dFbKAgApbs7cSz5IYTcjo4lyrpGnLJrsP0w59x1A5WGpSmbzXK4n3MJ2pCSgMSYNObsrmQ9O3xiMwHFfUWyIcOzshnIQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(91956017)(2616005)(186003)(508600001)(6506007)(66556008)(83380400001)(31696002)(53546011)(110136005)(54906003)(6486002)(66476007)(86362001)(66446008)(64756008)(2906002)(31686004)(4326008)(38070700005)(8676002)(5660300002)(316002)(66946007)(38100700002)(71200400001)(6512007)(122000001)(36756003)(8936002)(4744005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TXZZOXVKTU91Sk5mdCtkRTdkSzM5VUkwYXBMMFdTVnRETFlpK3FtZGVQeUF3?=
 =?utf-8?B?bFg2MXMvcGhUVlV1ODEvVUMvT2d6M3hPYTZXdnl6cVRRM1NDRzNhR0NiMHFm?=
 =?utf-8?B?dG1Xa1p5bU01QlZpeDdwaHZYUUNxeFZpTWZKQjdWSXhFaVFieXVEWEYxczRL?=
 =?utf-8?B?bXA2am05a3g5YytKU2JQWE1IMFpiOXVRaFh0SW1SNFhQc0dUaE9WRHJvcnNI?=
 =?utf-8?B?WnFhQmZZOUwwend1S3RkZEtXWFpmZmZRQi82Qi9aUzZualRoMlhpM3BwRGVn?=
 =?utf-8?B?dkJnaXZBbktaL1h1Y0pSSFBMbmVlNEpzdmtMWFYyMkIvb0psL2hZRkxHTW9v?=
 =?utf-8?B?NXFZOVJDNFp6cWVrOGc3cFJBMS94Z1BtelNVT3R6T3V1MWxqZjNIT2ZHc0V5?=
 =?utf-8?B?Zzh0R2k2NFlKaytmSGNpSGRaSnNtTUJzUTBadDZkWmJxMnFpZm0yMHBVb01N?=
 =?utf-8?B?ZFFNb0xkTXdLaFA2cEdKR1dXd1B2VkpvQnZRNnUrS3hvdlpsK0Q5U3Y1dFJ4?=
 =?utf-8?B?NlgzY1RiRW9nNVhLYlE1cjZSYU9uREhVSGo3VmxNVU1vbXlQdnorQjZIb2VL?=
 =?utf-8?B?ODlTWFVhVjBnVWwxUDdIOHBlSkQ1ZUtqOCt1blU3VTRLY3UveFJxV05OVE1z?=
 =?utf-8?B?Mm9sUTJVWklqZEYxMGFXeno0cVVYdzZwS0w0UklYU2lBT1ZJRTVFK3B4VTQ0?=
 =?utf-8?B?bTIxb05uazZYemQzekRUZFkwSVoyRExXalV5eDNBbEJsOUZ3ZjdVdTBKcDlj?=
 =?utf-8?B?Q2ZHc0VLdEh3N0ppWklhOXRhSnYvM0w0bk5JMm5zV3ZEY3ZTTWJpY1UwZTBN?=
 =?utf-8?B?QWZ1WEY0S0hpWWZReFkzdkN3a1pmYTZJeUQ4S0kySEVHNHFvQWxnazFCMExE?=
 =?utf-8?B?Rjl2Q3JpTW5EalREeDRKdFNiank3aU9ZaUl4TGRxd3ZYM1dXR2ZoampFSTZT?=
 =?utf-8?B?K2hQWEQ4QVowamtFUnFEK25LNUlyMXBpZVRXRnVmMVNqUnU3OStGNWswT00v?=
 =?utf-8?B?b2lBNVdsOFpic1N1NlB0cS9uYWdleVI4YVl3WGFwTmJMZGZhVENEUTBNLytX?=
 =?utf-8?B?cGthdXRReksvOHpUUnJZUWt2SCtFWEx2OFMyRFd3SkhYTFRqUTFrVzRRMTRw?=
 =?utf-8?B?N0gwb0VBdGh1QnJESm91eW9Yd0lYOFhYOEJ5aHVCdTkvc1JTSXlodzg0Unln?=
 =?utf-8?B?QUxtMVlUR2l3amtWZlBmOU02OUY5VjR2dVpoZUpPRVY1OVJMK2p6Y25JT1ZN?=
 =?utf-8?B?T3Y4Y1g3eDVTTHkvcHZRdW5pdnFaeDNRbzdpV2tzWXF0U3JiUHZrWHVUSERU?=
 =?utf-8?B?QmtTQ2QwbnYxM2xZQ1AyY0JiUk5mWG9VRE5nYnlya2lFRktKUndlbEd5K0xX?=
 =?utf-8?B?aG1SNFlhVndleWFoS1h2WWtBVWxqakgzSnUxZ3VuRnVrVWR4S1ZndVhCK05m?=
 =?utf-8?B?SWFvQ0tNM1RBY2lWSGZNT2JxQlljYmJRc1ppNElYY0k1YzdzVlhYSVc2eUk2?=
 =?utf-8?B?TVJNUXFxMzhZV0RxWFk5K25iVGRJOUFsU3RYRERGNG8vbVVIZ2wrUU9GL2Yx?=
 =?utf-8?B?TTA4N05OY3JzUisySzBqT0swTjJWWEhldnFwMXNDQ3NweHZReTNWRnAvQTEy?=
 =?utf-8?B?bjRRQ1BjZnZuK0hZdVZEdm5UZUxraS9YVEZ6ZkFmZkR1QUVwOEhCS3MvMUZm?=
 =?utf-8?B?bkh1dmF6L1Zza1NoYWFaWGwwR1p1ZHNUSVc3ditJYmprRllFUjZKL1hyVGMx?=
 =?utf-8?B?WjQvcmhVRU5udjFoN1NDL2w2MWhjTkNsT0R4TkpXS0czT05NNEdmejBETVhk?=
 =?utf-8?B?NDdPMzJHZHJYdU4wV3MrcVFLUEFTMUxXbk90dGswMWhCRHZGU05zTy96VzUy?=
 =?utf-8?Q?vZ/oDNGyA27BU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E5B04367D248642B4F23E1D5786E0DE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae207a8-a63d-4f6d-abfc-08d992c95e9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2021 06:26:22.2160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UA/ceyFofZIFAOBkWOAN93bBzFpWxsMd7eHzFmriKZg0LQBF1g1IJjaor42QJ8jXWHUu5ZNFuH47ylasX1tIhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211018_232625_085632_FDD578D1 
X-CRM114-Status: UNSURE (   8.73  )
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

T24gMTAvMTgvMjAyMSA2OjQwIEFNLCBNYXggR3VydG92b3kgd3JvdGU6DQo+IFRoaXMgbG9naWMg
aXMgZHVwbGljYXRlZCB0b2RheSBmb3IgUkRNQSBhbmQgVENQIGNvbnRyb2xsZXJzLiBNb3ZlIGl0
IHRvDQo+IHRoZSBmYWJyaWNzIGRyaXZlciBhbmQgZXhwb3J0IGl0IGFzIGEgbmV3IEFQSS4NCj4g
DQo+IEFsc28gdXBkYXRlIHRoZSBSRE1BL1RDUCB0cmFuc3BvcnQgZHJpdmVycyB0byB1c2UgdGhp
cyBBUEkgYW5kIHJlbW92ZQ0KPiB0aGUgZHVwbGljYXRlZCBjb2RlLg0KPiANCj4gUmV2aWV3ZWQt
Ynk6IElzcmFlbCBSdWtzaGluIDxpc3JhZWxyQG52aWRpYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IE1heCBHdXJ0b3ZveSA8bWd1cnRvdm95QG52aWRpYS5jb20+DQoNCkxvb2tzIGdvb2QuDQoNClJl
dmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQoNCg==

