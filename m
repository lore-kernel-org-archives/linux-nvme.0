Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20418EB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 05:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s/jHs1xvHVSixx3F42ucSww/5dH8aI2yOplkxKAPg5g=; b=QKJODVhsBZoxp/8xL0W31nx3+S
	Bt9WaLvfV/RvbB9wFpRnQjV2jF5vyJOZPRJTwQSQF1mthJZt6mqFNT3gKcyuxya3LwtjQTlYl0bVL
	wriDTAE4ADrSec023ZROat192a3hGedGUmy0ZmtnG56NpleCL2MgKrglwp5klOsYZQw9JL8Wt8dPS
	+yt0Z7XtUFKl31Kk/8t1q04pjnwmLYrjNmxvTAguu/B0k9FtrPa8TbbIlFbjIFty624Xv1ub5jRQB
	QTYV4PxnazGuW4u3RMezb7y/KVlHyqdd+OUYm9BqBE85QdV1a0F8NrstMP10jI2CE/kPPlZ0A+kbU
	yX2fAvgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBUCY-00ADFz-2g;
	Tue, 20 Jun 2023 05:46:50 +0000
Received: from mail-sn1nam02on20606.outbound.protection.outlook.com ([2a01:111:f400:7ea9::606] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBUCV-00ADFU-36
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 05:46:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QFb0q7Clx8hX3fm/ggbFYZy6/DUc/vO/V61p//W0bkAnDiVqkFlmRhhtnSlviWdMtBBj6E73KB8xtbDGstqMzVIjr4WqSGtQZrSLi+Yva03Zl9Bwr9/NlklGVOCUggcgdwS7gycW3i+j6IcDtHXX1zUrjyxGVXyW1gGqCNhp09kNOOGi18ejldViM4t3sNOY9kU8yyyN3XfOZ5gXsjkUjtgaPgZEOswhwgJx4qw7qKvsdlaDa/UeD+WPTipe1YsBVC2lH9SLzdDgLEIvATx68il3eDvgzPprmuPZbvUfhDVYn24g4+ogw4T35bs+OzZuMdSwV0+PfO2iSvifTT8xww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/jHs1xvHVSixx3F42ucSww/5dH8aI2yOplkxKAPg5g=;
 b=Ky1DUVeF3sBS+FMLRyeppDI0O250YXGNjqp9xMwhsOHgpfmvidjybwuE9BuucrcDO2Jv8EWPSpSx5CWEk4dMjgxmJ/RKJ847chsbbzTehy8xfWC//XLjVEE+63xNfrZ6XhhpdmZCE79DZH3gn9ATeDLDf5ylCC5fs83El5BWNo5EY3C4l4gRis94pzxH8HwavESJmE5+11IuAclVfgb9qXJeoC31JH3PhQhJEl+HkveW4g5tjh/iv24/cv3WYNhLlVmNbWZrqtbnrCDUbc7/AMKxvfQJ9PjENusPMn//W9MhwLRUY8nD7qISj3I7M+Y7SpbL0yVP7EXttgQYHp5TlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/jHs1xvHVSixx3F42ucSww/5dH8aI2yOplkxKAPg5g=;
 b=JLLBKB+Dt5aYi0dAaDtj9VZQnPw911egcBR0qHqq3YFiGAuHPUy0oDVYKIuCiXgJ3QKIfcVqGVv4IndCP+gw2QteEQIO/SKbTqNbgJW9mPSTI0EiBnG3N/+pr7cx1oJ8lPmEHDcg5tZa9c0KzKoxhcUdc3m7AXz8ySHNIXCq/zIuHnF6+Uq9gWqwntQbE5z2duVQgj2OOD4fWqdwDjPad1phM+79sH/LUBum5rPtKWvLAW/oS8UhZZK6y/x3ZsKnVNnBNrIgnDEjeiVnvepuUmxyY+3UhFTasA5qSWicV/TciaNOs+39jXqboIfoiX38Q4So7J6OV2UA9aCKOeG23w==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN9PR12MB5306.namprd12.prod.outlook.com (2603:10b6:408:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 05:46:43 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 05:46:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: Fix debugfs_create_dir error checking
Thread-Topic: [PATCH] nvme: Fix debugfs_create_dir error checking
Thread-Index: AQHZnhwFO6whqGgjrESq7JhwWY+2Qa+TOPUA
Date: Tue, 20 Jun 2023 05:46:43 +0000
Message-ID: <c1d19813-f6ec-f073-2fde-bebc8331b145@nvidia.com>
References: <20230613172421.6988-1-rauji.raut@gmail.com>
In-Reply-To: <20230613172421.6988-1-rauji.raut@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BN9PR12MB5306:EE_
x-ms-office365-filtering-correlation-id: b9ef4f70-b0b0-46ae-333b-08db7151ba18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dxq0S170bCDECwRAzUgmBohaRyEuqP81SM+1OyXMH6fHmevI9JbIyjQgI0hVvPmyi3Mxw5SWJKUR3q73vQoRt7cr30aWU3u17IQwyHPo8kJPfGskTf+P74ATydEqNNDp/DTZ6hD+Kh9sOwkguwIcJunNYznm7+hD9M8bLE696pUvotNdQsbZHZTEdB+OveZ1J6pmh3qN59p3gmOJXlX586gBbylhFsvieznGwaSisM5nVEidYmu9PwqK1oiDHISb7rJWSMByeqP6tWjz20R5nppU2GAPHo3OemlElVBjjeK5fpZjoJWJZhUTVZm/f8uPEToyrk/Q39BMrGiqpPvXUfNKCCTYgQGAxzuu7sa7cfwHOXX7Yc1V2RlcWWuJzMgVOOJNH+0OZ6wMsgKT0HMawbeJmDztE5JktUFvyH48Jtwsyb9OZ4oeD7KTneKma8yc+agYQoOTtByh08PmUn2D1wMaMQoDToJTwjr//t7uGlWbCH6Buuqi+TOoFJgQlQZKdgwZE/rrriz3tsMArUJCmwTHOtbRVk/wVcV+hvZkH/VYrE9H/90aeN++I6TWUl9cGX6VwM+dPPhCVi8W/eeDo+VCKl7u06qgrSS9lkFTjcapBui+qtA2QsTnkiXatiRIho/JMY3EFJ2ViH7nzY18SVJ0VIiO4YAspc9pd1A8F3ZMv+sXipDU4NETk5Z20YwJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(31696002)(122000001)(31686004)(38100700002)(86362001)(41300700001)(38070700005)(8936002)(8676002)(5660300002)(66446008)(64756008)(66556008)(66476007)(66946007)(6916009)(316002)(2616005)(6506007)(53546011)(6512007)(186003)(6486002)(76116006)(478600001)(91956017)(71200400001)(2906002)(36756003)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0RTdjlRQlNndG5CVER6bXRmenVpNXl4RGpzZ1Jic2NFQkRHbmVOVElsQVll?=
 =?utf-8?B?d0ZGOG5Bc2h6NVh6VjZKWVpGUTdPdkdVNjBZbGFZYmJNZ0MvbHA2Ri8xem5y?=
 =?utf-8?B?RmNYK1ZQVUZrc2lZdk9zaWo1Q012ZUJTclp1OUZtL0ljVGV1SHpRMVR3L3R2?=
 =?utf-8?B?RldYVldpNGQ4SFFBb3ZaVmRuSWxXWkU4VDBrWWxZRytxNWJhSHQ2VnpKQzg0?=
 =?utf-8?B?ODQ2SDVjWWhDdGdObk93OU9Da1A0cHlFT2ZzWmdRUCtwWVFrQk1QS2sxN1d3?=
 =?utf-8?B?VU8zRkVVaURWTk85eXJlOVpNTlBqNWlNRTlBNGYwcG4yQkVvWUwxeUgzSzVt?=
 =?utf-8?B?bU1NclJGZEQxRkgrbkd5RUpNWHp6OHZtWGhsOUovemxPdnFHd1lOWHUyTWRa?=
 =?utf-8?B?aDJySExPMnpNanVLMjduRFNqOTVXd3I4WWsyZ05pN0pKa1F6eE9TVzdBVnBB?=
 =?utf-8?B?SmVkMDFXb2xCaTBGUDBqS2VLR2xiMG9lQXB6QWZOc2RFai83ZmUybUdYeVdt?=
 =?utf-8?B?bWZNUFlEYTAvbk5zcWlVSVNpU0xMTjlFaENpUlBlMUZyN3hIN3k5V3poNDUr?=
 =?utf-8?B?dnhkQXg5R1VRODhpd1kwRGtGWHV6cnpZVlBmK0FsM1BkUXI3ajFPMkR2bnFL?=
 =?utf-8?B?RWR1WVFWTnBNQlJhdUoxS2l5Zmd4S2VJbE5hUEVjeXlqaXJYNnB5Q2RqeUhD?=
 =?utf-8?B?aWNJZlAwSU04clJtYStBaFFHelBFbGlySHpaNld0M0o4MlIvdzU5aEVScXhq?=
 =?utf-8?B?eXRBOFFQSS96VVA5Q1krbG9QWUcwNzErV3pPSHVzN2F5N0pmdk5CTlRLdXlD?=
 =?utf-8?B?SmN0enl2Vy9RYkQvbVRjNDl1aWNaUFZnYTVMMTJQS1NRaFFhcHhEb09YYSto?=
 =?utf-8?B?TFBsamtlbUlsWEIrVXZ2Y1ZWdUZINndFR0ZLS29NRGtwbnhwUjFadUdTZWhN?=
 =?utf-8?B?TUVHR1RUMGpHMng4NUpTLzkyclo1YTdabXJnVjI2c2lrR2QrZXd5cHNCNTdO?=
 =?utf-8?B?YUxZWG55UHNmYy9ONUZzaUpnbjErOFRTN2IycUxRZkpDSzlFREU5M085aHBG?=
 =?utf-8?B?UVdHN1M0YnJyOXlFaTVxQzlsdXNSRHlzM2pnT3V4aEs1OGVrdWJvNk83UmNQ?=
 =?utf-8?B?d0ZUeUFYK3NJSUlvczAzZWJWWWhIUGRTdWdqeVJQWjRzckEwd09tNWRLc1dP?=
 =?utf-8?B?cmJIbTExdHB4eGxqcGVUdVFiV01wTTZIeHRCVWtQNnN4TElYVlcwVVJ0Kzg4?=
 =?utf-8?B?VFFpbFJzZzh1RTlaYlJhU3pTUjdqS2phNFlKSXd4bVFJTDliQU9TUFFMNEt3?=
 =?utf-8?B?a1BJVk13ZGl4VHhZdmYwUm5SMGtLMUhwV0hEU1dnSTh6SU4rc1JkRUdjUUor?=
 =?utf-8?B?Y2ZScjdFMUthT3RFa1BtTExZdy9La0s2Q205bjlEK1hXTDVVRmpNblhWYVRI?=
 =?utf-8?B?dnJJRUFtQUVxdzVHUjVCbzlRU28vUzg3WGxYbUh1ZnpONW9zOTczTWMrb3d0?=
 =?utf-8?B?YXBNQ3RCZ2ZVYWp2NEx5UW5XeWFHVkVqQWFEMmN0aG4wdlQ5Y1JJVEE2bXh4?=
 =?utf-8?B?ZTNMRnhibnVlWXJjZHpsbDB3a3llc20rUCttMThuWGpMZUV6c2c2SGhqSnZ4?=
 =?utf-8?B?b1Q1M3p6UnBJWGpuVDJickxJVHV3eGw5ajlreStITXh3M1Y4blJjdmFmTURa?=
 =?utf-8?B?Y1dKT2hYZzVBMGg3QmVFRkx3ZmpNcUtuR01GYjNQNWMzVm83c1hWRjBPLzA3?=
 =?utf-8?B?UDcyN1dWRG9pSWlFK0Z5RGRDaFhMLzNBQ1g4dzQxeXBSMFQxUnhPNTdoVTZm?=
 =?utf-8?B?QkZ1d1o4bHhyem40c3h0VjIwUCsyN1kwaDFXcm9lNUMvdmJaYVBMeklNcTFo?=
 =?utf-8?B?dHhyNWFxNm9LTW9zYU5ZVUdRMldDTE1Hek9VaVFUSDNZWVFZaE9pcWdaenNn?=
 =?utf-8?B?bFpSVWpRWitBbEs2RE82ZzFyd2RMR1VxbHBVcnpaWlZQN0liejJMa1A0QTMw?=
 =?utf-8?B?dmFGU3Mrd3hNTzBrM2VZSGIwUmVCdFFER08wRzFyNlJuaGhSWmVZNU9hbTdt?=
 =?utf-8?B?WjI3THlvOWpKTmxiblJnQVk2eEpmRCtjWGJ5Z2wycXNYc2VsWm5jVTVDMlBr?=
 =?utf-8?B?NnFWK0JFMDBtdmlJd3VmcE5aWTRobjlUZGhXVTNtWHo1eUxVS21TalVVMnZy?=
 =?utf-8?Q?OMXd1yWED5C67pZzti5HMwqXRc4a/X+jir+Fdct08mN7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45D32DCECC6BA347B6A28A9DBB1ECD80@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ef4f70-b0b0-46ae-333b-08db7151ba18
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 05:46:43.1473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ci2QL6o8YvJxbThf5jO/3EQV+wzL9EODikJa7aJ0xjOTls+2erlPiyQVHUOsiiNyErTNMCwcW72xXIl18tHfBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5306
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230619_224648_025443_1EBB0994 
X-CRM114-Status: GOOD (  10.39  )
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

T24gNi8xMy8yMyAxMDoyNCwgQXR1bCBSYXV0IHdyb3RlOg0KPiBUaGUgZGVidWdmc19jcmVhdGVf
ZGlyIGZ1bmN0aW9uIHJldHVybnMgRVJSX1BUUg0KPiBpbiBjYXNlIG9mIGVycm9yIGFuZCB0aGUg
Y29ycmVjdCB3YXkgdG8gY2hlY2sgYW4NCj4gZXJyb3IgaXMgJ0lTX0VSUicgaW5saW5lIGZ1bmN0
aW9uLg0KPiBUaGlzIHBhdGNoIHdpbGwgcmVwbGFjZSB0aGUgbnVsbC1jb21wYXJpc29uIHdpdGgg
SVNfRVJSDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEF0dWwgUmF1dCA8cmF1amkucmF1dEBnbWFpbC5j
b20+DQo+IC0tLQ0KPiAgIA0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

