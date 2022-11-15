Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C92AC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 04:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dn4KKH50s9XSCd+bv9PmvkqCNGdO+xTpWaRTg5B42cU=; b=xQzWWgUPrPtq8ZmFwyduNEx1xb
	CCq312DoQizJgAUr9t0WQyr2i0EzXeS7gX0+qqqVgYLwaQrGRxEr2afId86I6wmP8GT94U6V0g3E0
	/6qheRFTmowjX1jehEUO74E5ObE4VR1MmiYe6m12INC1mpYe2vKHnFXkv+J0Ty4SUkuWxMtSq1GJq
	5gFNC6oW4xSKAZfR6Ud9xidH9jWLGC7fUssEoqhXgigxvIYtHYlRimjiAR5oBamzo93xNe27C/Flu
	vMuFTZ2fNwivk81Ak3iJBNSIciKIGuGnPOdLl0On6sftQkMEX3Xm+imOQzgTziiFnC4vMzPQsv+ao
	UsmFCyGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounBk-007PAS-BB; Tue, 15 Nov 2022 04:04:44 +0000
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com ([2a01:111:f400:7e8a::601] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ounBh-007P6w-B2
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 04:04:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdePmbxvetr35MDPR6sNX7maoGCj75FknZ6lK2gRHFViR0/dkdTcwNy/y0HgWhCXyTPXMOKeygh0Gzt2ymRSDMzJkSjbwt0W3A4eNQEyd0MFxZlw/XtpNfs9A/B+YPVRFCinltPXG4Lc5lkFRDXnUIGsO986TRtoU0j71ZKr6Q2q+9OHO//uWI66IYk4I/rMY7Jm+tm+ou8jF6nSvOTIZV7WQONefwtC1Za6ffkquJpDuLVg3/DWkh3XmAS0t6U3Um+9zbcny6DYnVDMvFphZY21qi1hWDdsAKW8914GJL9gcjTZhfeOW1uSeHVYvDKtNqPOLki02n/9HeXLEde2UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dn4KKH50s9XSCd+bv9PmvkqCNGdO+xTpWaRTg5B42cU=;
 b=krCdfsvudm8MCZ9GY5hmam9juCC0mQfj079O/r87Rg/kbCsb+5NbPRWS9yZrNhlYwLy7Rn0ET0rcKC9e1EzEWU0Ebt3t+QDLhXMlAG0KOLhzz0JVdFk8Uk1RUXhBP/LSt+D6kMUIVeJjboAjPcIJsISLK/6VQuxIO9h9IV+SkNMlU67c9Z2fxQfe04v571/8bKvEziZ/HABMW9MJmc99nyaYKHmGcp5nBkUzceAXs509oOiWktcqWpy+J3XaUP81vBQJBBmhP6sz4RglM5C/cJzz9Ukq9rq5jZ3CDdqelBU1YeqRX41FYdTFFe0eQ5CDalJQ0ViQJdeYoZ9i+bshDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dn4KKH50s9XSCd+bv9PmvkqCNGdO+xTpWaRTg5B42cU=;
 b=QbCTUFBvPxODrgMHJIUc/1+GveAZUgVY2Rc2qBX6l7m1XOtMbSKSFy3sG2W0wItmVWJYB+1W9A3pW39FUU8BxLjDfAxZlxsfsv88TyIdtm/nQwO98PsJEgeRWgLL9ODqh7y9jfNSNZW3eOoiP/ReATzFTd5ErTeWviwtWSaZj0WIBBq/1/tnpoIs6YOilfd32lEhL02S7C67pjHWBYsgOfO1z5tbNAIdaD3Tm+Dc+fydZKE7i9ET9mYo6uBnFBIkZ5yzV4G+rl5aKQPPFobZmu4TD6iQrJwkXuaf8gHMiruxgiaf6msxY1iZ2ozCf9uUpDsb13q0IYkdifxcdjwhiA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 04:04:35 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 04:04:35 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 10/20] nvme-auth: guarantee dhchap buffers under memory
 pressure
Thread-Topic: [PATCH v2 10/20] nvme-auth: guarantee dhchap buffers under
 memory pressure
Thread-Index: AQHY91L3WDR6sSt/WUCFIh5GcixJv64/YBiA
Date: Tue, 15 Nov 2022 04:04:35 +0000
Message-ID: <73d899af-a934-9692-7704-508d3c5d26e8@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-11-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-11-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB5831:EE_
x-ms-office365-filtering-correlation-id: 7c6d4089-3fe1-4dfe-6628-08dac6be823c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  E0iGn79XuVT0cvrYbofjyupZUJj+TEVKUm5OrPgz//ILroetloIzYAM6kfMLeGYwSEmVctTkQkgPYwL8NJLoEDSjyJwjtXcrHnhdRTF/3by52aAJp6kaeFzjCkoXBIji1/o3M3qGOKLSYqWjj31zEd208f72Ff9PjdkRBUVtMJrHe5Ke7qjp0zxXJjV7cad60wkHlmppcWQ984hN+knaYIinBuP9Zcomeo1sv7Sx+loO49VC40JqAbrKjdasASr68+GfJiXSsmOCJrV4FmOAr8PE+q3NibzKpqG1KTUAl73kt6FFRQUTcjclyP7mcMPbKL5VO/7ucdW1JycuVZcSW+ZTxMJXk1or4fMrB1W0LaD24NkWLkXZjbl4YZAFr/7EMfb5RrAsXr9FSW9Fk67jUFdf/2FefRwcP847bnap09lQaaC/6K/LU8JnjNI5nzcbEc4zcUNaePJ+sBlx6Dn0hpGliAKekwMuVrFAXi7MLRAQBUYoCb0Az0+IpPuz5NrkIMOcFjDX4h67XrYu5WzvcUqgByvNfTe5PPryxOP9toVUmrMvFJb791vL4Mwf7KxuxnepYg58n2X65KSw4gznIMU3APNvI+tnyYu2X7OvzORCabXoW3mK42NohIeT2tgCpm90e/Loz77jtuvWDKypvxV3KHGB2sF66+tXpwqydCj7JioYBNiFCVHFentDvQYSvtRkyKETYxSxrBO9bDavAjPXUzwuKL0YqlYNAU9MX6APadp1DajDqcDx+P+cTtdTpCJV299a3WYKo6JQKZbB3nC4T0y75BX41g0tMvs30r9bXHFxN3mB/oGJG8akMCSxMUBb7b/5F0RK8h+1R23MOA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(2906002)(8936002)(5660300002)(4744005)(41300700001)(316002)(83380400001)(122000001)(2616005)(186003)(6512007)(38100700002)(31696002)(86362001)(54906003)(110136005)(66476007)(76116006)(91956017)(8676002)(66946007)(66446008)(64756008)(66556008)(4326008)(6506007)(53546011)(6486002)(38070700005)(478600001)(71200400001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?QjlKWDM1T0EvRlo1Qm1qY3lDb1VvODFZRWZNOEF3WDIrMGJpcUhsUmFvTGlq?=
 =?utf-8?B?VXhWd0VLdy81MGN1S2s4ZTFUS3U4WVU2UFU2dXpnRTlJa1prWXpxSDRlRjJi?=
 =?utf-8?B?VHZDWlpyWElKd0xwazZMQ1l4Q0NqRTRMbVZNYkpmSEpUOTZZZStMWEoxR3dJ?=
 =?utf-8?B?UEhOTmNwNzFjYTNaMGJpYmEzK2c2ZFcrZ3BPeVlPMkNHWGpKSzZ1WUU5THlG?=
 =?utf-8?B?ZUxHMWtjdzM4R1c3amhwV2RFb1cvNlIxR1o2V2VPNHpRUktPTFJ4ZWlmOUdw?=
 =?utf-8?B?VUxId3BpY0JQamo5QTZxaVhWV0tQRk03Y0hseFE4R0pkaEJTY2QyT3kzMGlS?=
 =?utf-8?B?YlpUOHBTV0oycjBXZnIrcThacTJrZDYxRE5KWW53eWl1Q0JDZ2hCWUd1UVNp?=
 =?utf-8?B?OVdJUWhHOGFFUW9qQ1dId1VUQ0o2VFFVNFI5TEdDRFd3YTJ4ck55ZHBwbTFU?=
 =?utf-8?B?YWpnSjdzU1FjYVUzRDAxc2FHcldYZXN2eGloa1ZYR0JYYXNmNm80Y1F4M2Vn?=
 =?utf-8?B?dXY5RGhvaFo5QkJpcnYzRFNNOVRiRlBkOTY5NUJUUGNuZnRST1hpZVRDNmQ3?=
 =?utf-8?B?K05ReUh3QzQxZVFySVg1YkJTb3NxazlMYVUxdG1SaksxRXY2ZDZvdHZjZ1Fz?=
 =?utf-8?B?Y1pSV3QvNWFzZ09ibzFaRGtQZmkySlo1NUtTQWY3T1JjR0NUMzV1SXJwYzFa?=
 =?utf-8?B?VzVrT1k1UE9DZnpUR3haNW9UTXp5Kyt2bFBjRDgxRnpydjZtTG95emZJTWhC?=
 =?utf-8?B?c21Nd0RjY3phVGdrRnk5M21ZNEM1U3krR0hOVk51b2xzcisrMXFtbjAwVnZw?=
 =?utf-8?B?NVp6bkt0ZVZYZzFkYzUxU3oyd2EvNjRIRTkvbEtxcE5tRldFTUo0N1hrQ0JS?=
 =?utf-8?B?V1IxT3BMMGxWREdSUmxZYUh1bDFncVpiTDdnM2FYaFhuODlrYUprRW9QSmNw?=
 =?utf-8?B?eXdOZ0NRMGsxTnFuVis5MXBnbCtBeW0rNE1DODNqYWNSUjJUV2kyRUpxNHNK?=
 =?utf-8?B?TzBTc013OFR2eWRPbnNmWDQyWGI4ZlFVaVpnc3VwclBaOGF0RHVWZDdFMW5O?=
 =?utf-8?B?V3JoQnFNa0tvWnRuUmdBenNOaEJ2Y0tYcm11ZStJR1ZBS2J3NmV0dzc1ZmJF?=
 =?utf-8?B?bzFHSE1qZHZQWVFMMFVxOHRCcUtHVDV6WGo0S0hQakMyVWxaT0JCVWVoUFcx?=
 =?utf-8?B?Z1FWQms5Zk40V2VSb3lEaWF0bDlRVHpJd1JYQ3pEdGMrYUlOUkNuTnVWOXlL?=
 =?utf-8?B?cnFMN2tvbDVCbEVtVm93NE1xZFRKbHNSZThRUWovM3M1dHllcGdWazFyVVVF?=
 =?utf-8?B?TmI0MkVUZStNbEhWekk3djEzQy9wYkJROGlrNXd6UnhudGUzOEVUMWZIK3Ur?=
 =?utf-8?B?SENTNjROSkxTcGhjZ2xsRG9kTVJITVNaY0RzejNSRm4rNHg0RldhUWh1V2FF?=
 =?utf-8?B?bnRiTUIzQlhrZjFIajhQZ1pYRDBlVy96V1RRc2JUNVpNekZickh3K3RsbmZr?=
 =?utf-8?B?OXJ5VE9uOG5VQTdXQVlIbEc1bkMrNWFOZDFiMDZkaVZ4bFVkcE8zY2lrUmtB?=
 =?utf-8?B?VU5jRjlnUjBjNHFXb0p6M3RBVFpWamRCemlaQnNKOTkxNVNCSGplMDEwM1Zl?=
 =?utf-8?B?a1FBOE9vSTRDSi9MdDFuVGJXZVVUMk03NlMwajFveG9BU0QvdENtYm50OE5Q?=
 =?utf-8?B?SVlwMDY3MG5kUExkaGZ4TmIzSytKMWxiU0JqSUhoNUJhY1BOMXVROU15SmFR?=
 =?utf-8?B?WVNqRGNPUzZaRndSTDZjYVlBQWRsZVVoOGRZVDdKUnE4ajRFTVgydjNZWG1X?=
 =?utf-8?B?YkN6TVFlSkRqNkFJWTZob0ROWEhlYTlDWm41TXZOUmVkRlpqT3V0ekYvQjE3?=
 =?utf-8?B?eHIzb21LWHAvS3JRZEhWY0lsWHAybFFaTDl0Sm50dGxlWTRraVdPdFhoOEtr?=
 =?utf-8?B?OXlrVHJ0N040QXdFaWRhd2krNjdlaW54K2VhVFBGL0dJQWE1UnMzKzA3TkRL?=
 =?utf-8?B?aHM2c2kzNjZmdm1oTDFXU010Nk9JeHZmTGpIOTFVd3cvOUdKb3FwUE5lZkxy?=
 =?utf-8?B?OTZFUGdoUUtKUmNsdmdJa1NLMHB5RVBFdWpDRG5vSUpRdTluRlpRajVMZ2pH?=
 =?utf-8?B?QlM0eVJLMDV3Smx5dERRaHRpMnE1RXFpMXJXMGZZdEVZVXc0dm8xZ2RGTThE?=
 =?utf-8?Q?edCNCy3k+bYloPTZDl+BeDhYeYbqSFKya6Rg5AQcSofz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <494D5CD7EAF8B64EAE6960FB64F7F146@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6d4089-3fe1-4dfe-6628-08dac6be823c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 04:04:35.7272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gP2QlUasl6s4AM1WaMwyvzWaVvQzwz5m/2FpoWIKG8GBJ+tinhMRIsLl+rW3xMGCG/8io6oz08ym2D/xWrn57A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_200441_400716_C4C154A5 
X-CRM114-Status: GOOD (  15.43  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IFdlIHdhbnQgdG8gZ3Vh
cmFudGVlIHRoYXQgd2UgaGF2ZSBjaGFwIGJ1ZmZlcnMgd2hlbiBhIGNvbnRyb2xsZXINCj4gcmVj
b25uZWN0cyB1bmRlciBtZW1vcnkgcHJlc3N1cmUuIEFkZCBhIG1lbXBvb2wgc3BlY2lmaWNhbGx5
DQo+IGZvciB0aGF0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBn
cmltYmVyZy5tZT4NCj4gLS0tDQo+ICAgZHJpdmVycy9udm1lL2hvc3QvYXV0aC5jIHwgMzAgKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tDQo+ICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
IHwgIDYgKysrKysrDQo+ICAgZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oIHwgIDcgKysrKysrKw0K
PiAgIDMgZmlsZXMgY2hhbmdlZCwgNDEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9hdXRoLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9hdXRoLmMNCj4gaW5kZXggNGQyODgzMzNiMGZkLi40YmZlOWVjZGExMmEgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2F1dGguYw0KPiArKysgYi9kcml2ZXJzL252bWUvaG9z
dC9hdXRoLmMNCj4gQEAgLTE0LDYgKzE0LDggQEANCj4gICAjaW5jbHVkZSA8bGludXgvbnZtZS1h
dXRoLmg+DQo+ICAgDQo+ICAgI2RlZmluZSBDSEFQX0JVRl9TSVpFIDQwOTYNCj4gK3N0cnVjdCBr
bWVtX2NhY2hlICpudm1lX2NoYXBfYnVmX2NhY2hlOw0KPiArbWVtcG9vbF90ICpudm1lX2NoYXBf
YnVmX3Bvb2w7DQo+ICAgDQoNCmlzIHRoZXJlIGEgcmVhc29uIHRoZXkgYXJlIG5vdCBkZWNsYXJl
ZCBhcyBzdGF0aWMgPw0KDQotY2sNCg0KDQo=

