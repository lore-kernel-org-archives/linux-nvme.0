Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D68ECAAD8
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 07:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pFjlYsprjgxOMVzaZ9MvR+rwVhTw8zNvRVAmG3EyTG8=; b=urd3ZnVWU9MgoTGbB7Ae509YhJ
	8zJw9B3RIQvGTVQgk/d9vfSSM64dUdapfx3cXH5hzcnaPPrK9BL2Hs5AFGC1DY0n3JGjlJa6mB8ZG
	r/sDXeiyRu86tHKEIb6tG3X4h8DdYE2CwmSBdWdpVAb5GlvOD7nWGElA/i8BvxITzV5+4RWO1MClK
	GLWN9gc5qzN6qY21Xs3eFDr/7ktj5I2qj3kTn4a8BMCWPm3i7wB1QDuWYelUzRUZis3qoAZezLtjH
	51fzcaH/gy5p9PvdhzjbT1UR4hukad3/qIgHiMF+H3ZvNSF15ZQuUZnl5ZZt2EZxBfg2d0LVtcvmt
	DLM4Mlzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSvmd-00EnqL-K4; Tue, 30 Aug 2022 07:35:39 +0000
Received: from mail-mw2nam04on2053.outbound.protection.outlook.com ([40.107.101.53] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSvma-00Ennv-VM
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 07:35:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMLllsrudn00/06q5SsgUgfZHnU2DnEZ0LRuEE+e85FpF8dbBUSTLBMLaTpbAIayEucvsWa0e9RlZFxiiFQEWKbRaHOll/QEc+MACUWhDBPStNDha7EqI+tfKgrUVeddMX4DTsBYIxK89MbFKVgfJw5yaMOmSwXh1L4AXSlnl0m/sA2zZqUUzoimMLUtofrhAMVXHUyi/iBEBkXb1jR8UZvmYtkvXlFOVWJx+OSeg4TuV2fQErCkN8w6jezBEY6yvxuGRIcOM9lgO5e50KekD1ymZSrajEuV/p6Lyv8Dj6jQSXXo3JoHjru+jwsE14XwTxnw5WhTJYs5fM7OTPqBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFjlYsprjgxOMVzaZ9MvR+rwVhTw8zNvRVAmG3EyTG8=;
 b=n0G1RaQ17Xfbu6idFYr38U6kTCkUXkDrHYgCIHWnNXcgbMqsVqYXQ/pIELnQ8vlK11aAUeJlzL7W8HUtjf6U9Hw1AdeLRxRc+z4/btDKRtT+nR0bFP8dmrtPdPHocOK9y4C+3B6uXwOhKlyukZW4xGBogDuf4Nzaq3DZbnSgYbYFlcMQ/CS640h9LqVfUIHXkH+QIzqUSwlq32Eg2VJWHVdWGnpqrJTOxPm+EA2EDjqYc3/IpulgEwsKLkXdzdtgcr9EDG2WYYdOaW11skxBFN8sCOS88A241RsrdFVL5lmGFJqdFOFsVaYADFegLbVGqpmISMJVc+WCkwDCKsWdow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFjlYsprjgxOMVzaZ9MvR+rwVhTw8zNvRVAmG3EyTG8=;
 b=V0CXGr/r89vJbvLJETvfABRzZjc8nJEHnjpS8OYd5vBcpaorQQoYbmjp1wxymaUhwuTNz0VUyiaHq+6r+cj9xFBMrefv0C4Bm7ABw+NzDF388nJug1wog5rpPDm7Qch5Mg73KrEI8rs139hZjXMtJlVby8p/sVycEG0Yl0EYMfrpB2xIpMs18UqQrJCztDz1qIv8hbzASKBt2IO5NSgQbNafJZXxqysrHmhbqlAUahNLh2kRoaZfsTLZf+mbeinHlEkfNmgh0dK6Sy54S2jBmDqYTVmUmAivMZpWPrE0b0GvXv8X/vq/40goodMMsYa65aLXykkIQwVE9prHjxCMoA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Tue, 30 Aug
 2022 07:35:32 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c04:1bde:6484:efd2%4]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 07:35:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@redhat.com>, "sagi@grimberg.me"
	<sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH v2] nvmet-tcp: fix unhandled tcp states in
 nvmet_tcp_state_change()
Thread-Topic: [PATCH v2] nvmet-tcp: fix unhandled tcp states in
 nvmet_tcp_state_change()
Thread-Index: AQHYu6S6fYslqnACqk6+3RN59aSC/q3HDuCA
Date: Tue, 30 Aug 2022 07:35:31 +0000
Message-ID: <d0decfef-6af4-114b-d9b1-27b89825a0b8@nvidia.com>
References: <20220829124030.1194759-1-mlombard@redhat.com>
In-Reply-To: <20220829124030.1194759-1-mlombard@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33f6ae60-c9e6-40c5-e387-08da8a5a380d
x-ms-traffictypediagnostic: CH2PR12MB4184:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  PPfEj7lkNTb6J52WxHwAJQktUiC5IyYR6jEmj/E3NbV/Pja7j8oKtAiP30Kf+OzYVcAUuD8IR7+UhH5nEhsnaOdld50jD+DRPWYt0REAX5kw4dyi5AI5lpiJwrfH18aUX3oZKU08otKgjg6+B4COVZG8dxlX2qwMh785T5My9LF4ojeWAuyDwqOgaCTPN+lFdOojYzwRscQ+8l1+UKYKHAcRFM46AgKjhHjUrT9/jfyyLmS54jov6EGu7jMTw//QAMndL1WApaommXApTR7OZ7LUnxqZMp6C1in7DbT4el7jtBkSICl9ypjqAC4RCsZ6UqVTQsfxbx3hEteUrnwtnD05V75MRScAAswzfn4SPEK+WuXOcuyAqy+J85g01CHkDKHPRQPRIzxqn25S3WOesb0iBNIKF6GjlYBsiotpUfOhhHmnr3/uL9B8R68BwhdCpvtsX+H9D9heObfl9xzSzpWWwKw+VL+tUQexKYkx4wO1HN2aZXrT4s3lYgcpMOReoem+G6MnNxXPRnMMu5IYUJh75ec1aXPABecwomn6M5OEfVrTIcrFNHINIuRTLjZIySY8CasCGY0yEZfYIqj2Vbah5uMEwrxAbTxkL5t1ipnUtpSzFscjkH1hUZVIiTMLSmh8x0Jo+a2SOZ4BbWNntR4XMfAqooK19iBCQ8Y7VnQ5CyA6yshD89yQpQEmVAAAIs7z9t8repnokCjI1uFU1LbGzu77uIX2eHdNNbL41thNyaLXM+xOjfAOGklo6jlN71sYV5KnwQ2UUYLsmBJzs5BkaEs4iZwbkho7x4xs9zHvD7NXtu6jZpzTF/XUqjPbyF50J7MrFMZpWOWQYYOVLQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(346002)(376002)(396003)(39860400002)(31696002)(6506007)(26005)(53546011)(2906002)(122000001)(186003)(86362001)(8936002)(38070700005)(478600001)(38100700002)(31686004)(6512007)(36756003)(66946007)(110136005)(5660300002)(2616005)(71200400001)(316002)(54906003)(66556008)(4326008)(66446008)(8676002)(66476007)(64756008)(6486002)(76116006)(91956017)(4744005)(41300700001)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VEpnb0JENzZJaW1LMHF5WDFFeC91MEZrVHpJR3NpcWxWS3VrSEU3dUtwN0Rz?=
 =?utf-8?B?MU5rU0NHSkFWckh0U1JqUGNxdStGQ000TzRuMjA3dExrTHpCcmtneG02S0E0?=
 =?utf-8?B?QUtrWitlYmFUVzZpbjJDSTExTHM5UWhOUkN1MmN6cHFSWm1uTXhXOVJXd2hP?=
 =?utf-8?B?eTdQdHFVeWgvSngrcFN0blNvamtyRm5rYllnLzdialU5dHl5K2dUdGFGMWE5?=
 =?utf-8?B?SXlBVDZTcWFpSEVKN3M4b041WHcxNThUcEZUMEZiSHBLUDM4aGFweXhyQUVh?=
 =?utf-8?B?ZHRMbVV1UnhmVzRBL2N4Rms5eVRsUGJQTlBTT3RIUkUwV09lYXhvZHdyd2M2?=
 =?utf-8?B?ZW42V1ZBS2NHYWx6N2w4cTczRU5rK3g3Snl0TnVqcTl0VzlYT1VqUjF2Vk1K?=
 =?utf-8?B?d1hISE9Gb3FOQnE3bUhUK1hIZU5tMTZyNnl1aFRCSWc0cldFMCtoM0J1Nnhs?=
 =?utf-8?B?TE9SWFFTb01YMFZuWDVJekwxK1ErOVBOMlpyNjE0ckp6R2N4UitJcnl0WWJs?=
 =?utf-8?B?aUZsWDYvckh5T2tMcWE1NG4rK2swS1RWNytuOEpxMzNkVzRVQnBiUUsxSEIy?=
 =?utf-8?B?U1U0UGJPcUJ1ZVlHNTRCS3hUL0VQMjJVOSs1Qkc4c0RGc1UwcEZtdG96NHlB?=
 =?utf-8?B?VU5BQ09IWlRuYWpDV0J6dFBGSG5SMDdNODh0OUIrcU5iVFRiTjA2NW1QZ012?=
 =?utf-8?B?ODNkTWhCeHF1eGJsWEpFakFpNlZwckdGVzc4WUJYa2NpN1lvZENYWmsycTFi?=
 =?utf-8?B?UG1Id1dvd1ZDNnpZM1VGdDErakErWmVmRmwreDhlVGswT3dwZTVQSCtFenRZ?=
 =?utf-8?B?RHk2MjdWQzFCbUVOU3F1SmlrNjFzRm5Zb0hTY3B6YmdGZ2MyN3JTeldEOUlj?=
 =?utf-8?B?Wmt2UkhhMks1dUp1UytNRndjdHRPcUU4dGkveDMvc2wvd1NRVGc3Tjl3WU41?=
 =?utf-8?B?MHZPVVJmWlg3QjE0ckNibVVvWGN2WWtMRG9RWmlaZUFpN2lFYjh6cFVEMG9P?=
 =?utf-8?B?TTA0Uk5UK3c5YlJrMXZyWlloa3NxQ0lOL2FRanNtL0d0VEdBQTQ5T3BLVFlZ?=
 =?utf-8?B?MERISFg4RGhtNUlrakNtVGx4UjB3R3NSZmp2N3BoQkJGYkU0OFRMMzhrdHR0?=
 =?utf-8?B?OEtUdzBzdXVNYVRVNWVGZSsraElZUnVqSEdPTWpLQzVKY0FLWkZGNXRZeCtW?=
 =?utf-8?B?di8rYlhlOGxUYnJIYTMxV2RkUHptVGswSkhDZlR4L0IvQU1WMktWL0RwMVAy?=
 =?utf-8?B?RWh6TE5HR3dGRFNRcU1tUkREbDkwOGZyK2FERjlYSUkyRHZVSTBRYnB0S1F5?=
 =?utf-8?B?SytZbnY4bTQ5bUtvdWV3VHJWZ1lFMFNqc1ZZZU9xSUplMDFhaC9ZRXdoYmJq?=
 =?utf-8?B?MDFrQkZXRndGVTVmb0V3Z0FZSzZRSWVnNWdmT0h3LzFxbFRvSW00Q1hpNk9F?=
 =?utf-8?B?bFdPMmtXeW9FU1NMS0VmQnlLQzZjMSs0UUszeUI0VFhmRFJ0SnlSVXlDZU9L?=
 =?utf-8?B?d3M0eHBNeTJXNGVBMy9EZVRla2R2NkFERjhuWGtrL0RhU0FZK0Q3SlhVeC9p?=
 =?utf-8?B?VVNsMG1JVWJwU0s1VUIvcVAwUCt2Z3ZGUmpQWjhXNENPZ0xkbUlVOFE1RW9R?=
 =?utf-8?B?QjFRZFZDTnQ5cm1GNGZGU2pCTWFhZzhMWUt5N2lYbFl0SmlKelh6aVVzd1pq?=
 =?utf-8?B?SExtY3hkYm5oWjZDOVRqc0g3U3RnaGRrSGJyMmpTM1h2U0RoWnpUWXJvWEFB?=
 =?utf-8?B?OVZBZHl2SVNPUmNNUUJtcmtYaFNES1J2SDFJWlVqMysrSjdlNEhQMmVsOEsr?=
 =?utf-8?B?ZE03OGtIZjdxYTNDVm5oZWt3UGZZNkp4UmxxRWQ0NkVoWkJ3Z3dBZS9xKzlH?=
 =?utf-8?B?TkZKa3JrK3I1OXo1cXg5eDI3NkhDODJwa04xK3l4cm9GWE5XeW9JUEhiWWVi?=
 =?utf-8?B?cWxpQ1VDajJhdFY0Z3cyaUFLa21nUkxHazVodE1lSXM4Szh4ekhuYXV6cTQw?=
 =?utf-8?B?R1pLRmZFK1RKUGdYbkdTYU94ZldmcGY2azNZTnZVYzBrT2RBa0tGSmgwWkdF?=
 =?utf-8?B?cSszMk94Q21zS0RwMUdZb3dNQU5GM2pRZ0lnblFCUEEyN29qdFNPTm51cDg3?=
 =?utf-8?Q?he9Tde5ZfKpqNB6dn9z2GtkYn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86DA91D532272E4D875D473993EDAC9B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f6ae60-c9e6-40c5-e387-08da8a5a380d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 07:35:31.8158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yIsBCMwjIexyW0FvMcjePB2VR4VfOZ8Uc5CgG272aHTUwwjXxGeT9cteEfx5nJEX0eDPfwALv+zCnpVN1LahVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_003537_281862_B17C337C 
X-CRM114-Status: GOOD (  10.21  )
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

T24gOC8yOS8yMiAwNTo0MCwgTWF1cml6aW8gTG9tYmFyZGkgd3JvdGU6DQo+IFRDUF9GSU5fV0FJ
VDIgYW5kIFRDUF9MQVNUX0FDSyB3ZXJlIG5vdCBoYW5kbGVkLCB0aGUgY29ubmVjdGlvbiBpcyBj
bG9zaW5nDQo+IHNvIHdlIGNhbiBpZ25vcmUgdGhlbSBhbmQgYXZvaWQgcHJpbnRpbmcgdGhlICJ1
bmhhbmRsZWQgc3RhdGUiDQo+IHdhcm5pbmcgbWVzc2FnZS4NCj4gDQo+IFsgMTI5OC44NTIzODZd
IG52bWV0X3RjcDogcXVldWUgMiB1bmhhbmRsZWQgc3RhdGUgNQ0KPiBbIDEyOTguODc5MTEyXSBu
dm1ldF90Y3A6IHF1ZXVlIDcgdW5oYW5kbGVkIHN0YXRlIDUNCj4gWyAxMjk4Ljg4NDI1M10gbnZt
ZXRfdGNwOiBxdWV1ZSA4IHVuaGFuZGxlZCBzdGF0ZSA1DQo+IFsgMTI5OC44ODk0NzVdIG52bWV0
X3RjcDogcXVldWUgOSB1bmhhbmRsZWQgc3RhdGUgNQ0KPiANCj4gdjI6IERvIG5vdCBjYWxsIG52
bWV0X3RjcF9zY2hlZHVsZV9yZWxlYXNlX3F1ZXVlKCksIGp1c3QgaWdub3JlDQo+IHRoZSBmaW5f
d2FpdDIgYW5kIGxhc3RfYWNrIHN0YXRlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdXJpemlv
IExvbWJhcmRpIDxtbG9tYmFyZEByZWRoYXQuY29tPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdl
ZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0KDQoN
Cg==

