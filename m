Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36792C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 07:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ze/8VPvPQUK6ezUmomFFVWwGWiOTVr0pFCLFtsgtBh8=; b=PjDPyt31ZkfYt6qxlvd3JfKsR/
	JGx4ZLotTw+/vYljultg9cLBvJh6DJZjdt5dD6rdivCzqLUeeUS4Wa5WpOCiNuGpfgj5vjZxzO1TV
	ENlsVY3+ZGg15+q2/rnbQH6lgEkRd7ShXxJKiHVqjtyfODsx+2r0BBwhqS8y5NZ60/TNrY5pEO77p
	yQyli/yADAZMLuBaJ1C2ILEWWV2IkEpUYaTAg3bl4LiA3phJqNtz3gTa00CzwG/CwkyozURyvBmD1
	BW6UC/Vhl29ltp5SDOY3DCfq1Cvmjmp02WIqDcFmRFdv47Dk1pEbkt0zRnNhJ3ziTtPtA/7TSCDsw
	KEwFi+Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwfw2-0087ZY-Nu; Mon, 13 Dec 2021 07:39:46 +0000
Received: from mail-mw2nam10on2041.outbound.protection.outlook.com
 ([40.107.94.41] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwfvz-0087YS-SE
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 07:39:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZIkBcxhPKjlLZWDCr+XpnZS7HUL6GRyZD635UYuordRFzBnkmDkumIbI03cekKK0q4Oj0wNabtokowZelkZnHhjGk+4TGtnmqOu8Ua3Zfa5iyDbDUnoevh7YIr2d32o7HG7LJwo/deM9moHUfbTosc9oKtoDLo2AxTg9voDm6Cir65fghwBDyuXGvImTJ9EjvXj4gH/m/6oI4iUY8VqlteNskM6D6XdbpeQZ0eITrMTm0Rn5CYZzSnvl+rOJ5YLOmI9V2U9GP28VI7nk8DcX6iFwXKur4zS5QvcHXEja+10c9BOOp7Bs0zeObzJgj5Mv66cfwG5x4iXZsuCSXNy5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ze/8VPvPQUK6ezUmomFFVWwGWiOTVr0pFCLFtsgtBh8=;
 b=j35gom0wT/smNvSeNEtrx8XKW+vqdvfA0Elxm2AzGUkdgQ5VqLArj310dfBn3dEQ4fXPvqHKg5NMpWcBiSD8kqsLH3VzAfGIjoVsPTFh1DnQU1hgO9QscjOo9ZsABJawA2vyq8aTVLrAA3pZDIRmR2NoucV6PBENWPVNuD6a8Ph38nxManXLcr82ic1nSk3D8Pizz74KVUAPtV3XvHjkGrCWUjpN2d1nlZFgOBSMe5RaTDLJzM9XldO+ew9Rn3XXsOxowsFNkLIuEp66pjX4XE08AVC36geE+Rc+oNN7dGLTIu1VJb6VWXfAd9rDfHJ+9E72BmBSt4cSUjU7loNsAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ze/8VPvPQUK6ezUmomFFVWwGWiOTVr0pFCLFtsgtBh8=;
 b=ebMe6K9eRGrSJpaQKGWrJBClOGyYaZg2nLo5TosYbJ4ub4IHe6y8Jb+oTkHR/WOlU2PvT9OSOpeCbyGfqvlKcdt7MMlMFrf6hqSTr6D4GuQb/p+gU3gPjmQ2FzuVcS03YQ+uYLm28/XJk7a+Ux6EDB5Unf5gSue3t4e2NsrhfRoCQWZKoLl4Xf9/Dm3TcH5S4A454SMbr0t+03ltR697xVf35sEmivS9VltWg+ieNmvvLI2HTDeWQQ2Ow0qDTQWyA/qU3RmX3FSyc75mQxjOL1SGhDVUmFskb5Pyeb2FHSMvmwoQ0WJgxohgxgI3unW3pYh3KKdK1LaCIZYPLmfPcQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2380.namprd12.prod.outlook.com (2603:10b6:907:4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 07:39:41 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6df1:639d:74ea:d39e%7]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 07:39:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH 3/3] nvme: add KConfig options for debug features
Thread-Topic: [PATCH 3/3] nvme: add KConfig options for debug features
Thread-Index: AQHX7bg+0z2vwmZ6tkKVZ870DSJHNawumBKAgAF1qoA=
Date: Mon, 13 Dec 2021 07:39:41 +0000
Message-ID: <492750cf-b031-5709-0836-c28e475c29fd@nvidia.com>
References: <20211210112116.9299-1-chaitanyak@nvidia.com>
 <20211210112116.9299-4-chaitanyak@nvidia.com>
 <c467d85d-77da-fdff-53e9-938a7bf01763@grimberg.me>
In-Reply-To: <c467d85d-77da-fdff-53e9-938a7bf01763@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6214b740-2279-4dd2-9384-08d9be0bb986
x-ms-traffictypediagnostic: MW2PR12MB2380:EE_
x-microsoft-antispam-prvs: <MW2PR12MB23804D7FA384D6E30A6E1739A3749@MW2PR12MB2380.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wz2Cq6TdIxlxqnVEIX0mrWkaRIsCFovP10par07LZUoXScwlHeBXaHRD4yt+DfVW6l8lF65NZcfEgJFbVyxsDRoudOnpNgWCXLPj2pmAVxp2gxRqrGfMjufzI66nMeFtIaYUBDEOJd/HOOAPPMR6+bXWeHeKksvRW3yjsri0Dr9bQC3EgrU+hzcZ4STx8RDQSaWG2AiylVz2fIUQ2Eumg4rCIlq76HSQHp1epBN3Gj4GzC0rY7GxXrJncMCOg/XRLrxpHZBPsVyzVWBAKsYuSNZNUjVoJKkH0wGKlXp67ssvd7Fb+HXCzwubtcuvIN0cKymwtumwLlRto3PvPmdxhNhZpLvgbGK+XlHRUun2wzMN9/qFQ2pXUNzRgPl/I/zPdpzSpPslvWRuqFLWM6wbGhyweKJrZGGIZWH604popHPQlcxpvfLJ1iT9DxTxiQXO5soci2QTZnEUcHUuWKJlgtR73PAm1Bcq9lY2QGiVEKMQZMr44V6FnvEFbnNRrrLNSrLEvJrPzaMUgxls1XxKbdtWw+bGtDecx4kn8568WVRJ86zdI4PdKjf1byoTftOu1F9mTu+kZ/dsxUuscGicXMowOUphI5zejPT8CeXwWySpxCMTWxfoll5IjYd9ukMQhb4sBqcfWZvcnVq1m7Z3J5q6nqkCXv4dyOQHtB2zBx/iA+ncsoDYpsjSTwbtpiOl/EaOK4FEoLcvS3V+Wlt1OmtJi8aScSs+L+Pbeqhlttm9ZwhLLCcZ7ApV5EpFoClXJKMwq4jPnTHvfU3jjfg77A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(38070700005)(36756003)(31686004)(5660300002)(8936002)(6486002)(83380400001)(122000001)(38100700002)(86362001)(6512007)(4326008)(2906002)(91956017)(76116006)(186003)(66946007)(31696002)(53546011)(54906003)(6506007)(2616005)(316002)(64756008)(66556008)(8676002)(66476007)(508600001)(71200400001)(66446008)(6916009)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGFYMlZmZGNGYnZHVU9qRGdoVjZHOTBCeEo1UFNqTDIvR0xDellLRjNXQnpS?=
 =?utf-8?B?c0YvZ1BWWkxJUVM4MjJNMVF2TjhiOUZOMDdoUnU4K096T2ZqRHFyenVwejdz?=
 =?utf-8?B?Y0xJQ1p2SlFDRXJsVHcyeXJwSHdZSmoyMnloUDJoWlNOZHZFU2F1SmhXa3lT?=
 =?utf-8?B?akNHK01Ud3B6UjJlalRsTURVWXhicy9QSU05V1dJMklxeEl2VkcyL1g1ekZF?=
 =?utf-8?B?THRXb3N2YUkxOTZFMFN5UTFQemRnL0k2NUErWnk2K2dCM1REcFdkOTdlbjk3?=
 =?utf-8?B?SjJ0QlUxLy9saW1VT1EwY3JNdGtIeUhTMlJwMXc0aGJlQ3FianZFRjRncmd0?=
 =?utf-8?B?L2Q4NHErN1N5MGFKUUZqZTByOXEyOWltTytuVE9LNlhBUkVEc3FpRlhzK2Jz?=
 =?utf-8?B?b3o0blR3eGs3blhyVzRIY05UbTZTNGZrWmVjdUxPbndPdW1PejZuTysrd0ZT?=
 =?utf-8?B?Z09ubVBhWDBUeTJsSnZxc2NCZjNWU21kSE9WVGQzbkFYZ3BqR3UxbGVlelc2?=
 =?utf-8?B?NXd3ZW96U3ZRVWJCR0RwZDNQNzNPaUVoYmVmTWJrT3htWWxrYVVxRTJMNHFS?=
 =?utf-8?B?OEYrWGVZdG5LWGdVKzl1M0l4OC9DclFvckQyeTJUdGptNldPUlpSUS8rdERX?=
 =?utf-8?B?WG40UXdMZnBvMG5zNHV3dlNFb1lMRFdhUGdFcksvMEg2MHp5NHFvUjVLS2hm?=
 =?utf-8?B?QmV4SzhUak81a0xpOWI1b2RYM3AzalJZZ3dnenJlYW1CcDZ0UTFMdWNUbTVL?=
 =?utf-8?B?VWdoUkl4eHlnUStyQ3pSeFZxR1dqS2JNNVg1N3llNHhvQWNtcDQrKzdqTk5j?=
 =?utf-8?B?ajdzaXpYQWtpTHVCeDRJYXkxcmV3ZlNBQ0pZbjVtdVZTamdqSjlkb3NIVEFO?=
 =?utf-8?B?eXhONWxKNW0vYUxxTmd2Y20rRE5Sc1ZjOHl3VmNQdDN4UTJKc0RxWmx1MDZE?=
 =?utf-8?B?ZlF3SklocjgzbmdrMzFCMlRabUpRWWk4NzU2cDRucXBzZXM4V29PV3BEeGVm?=
 =?utf-8?B?bjk5MWRaTDZlT1JuSU9iV0cxSXNRMHR5UG9uVmRJM0xNZUZGb1VSVlREaXNV?=
 =?utf-8?B?UjVnWXhKeFRWWjRMcU5Icklnb2ZIeEs4QW9NMkVSNjN0TVUzbjgwMThNZ3NU?=
 =?utf-8?B?dm9XT3pMdStPN2hZUWZwdmEzR1VySWVMeUFCT3NzNVhnc210bXU4VXhiWE1I?=
 =?utf-8?B?dTVENGgzcUJsdWlQMzRGTThzYWVCN2FlYkpuQ3dwb2VIT09HY2s4Y1A4SmJv?=
 =?utf-8?B?dFhyVy84TnhIMmFwMDc2RWxBMmtTd2NlZzY1dUxEcjRxU3AwaENnR3JnVXJw?=
 =?utf-8?B?SDFLaU5YZzRtZGE0ZzJaU05tVzU3MHVVZ2dXUzg4cDE5OWpVRTdUVHR1QTkw?=
 =?utf-8?B?MDVienQ2T0xpb01JMENEVHRNeUR4OXJ5ZVBvWlFHVmxoQ0NQTUQ2d2tRSDZm?=
 =?utf-8?B?T2gvZHgwZkEvM1AwTkNlTUJINkdUdWQ1MzRZTlp6djNSRmRML1Jwei8xbmtI?=
 =?utf-8?B?VTdqN2kwUU9rYzVUem5lOTBSTzJtdVRJVWp2R09nckNYbVM5dW9yZ3N0eDFm?=
 =?utf-8?B?S2phUnFVTE5hZWZpclBHb1I4NU9VYTgwNGJ3WEx4cnhKaVJzSHkzdTc1TlhV?=
 =?utf-8?B?YmlxTFQySVhJSXVtcURHQUJic0gzcjE1aWdWcXRpbWdDdFljTDdXVEg4b1Yw?=
 =?utf-8?B?aTdlQ1QyeUwxa2I2VU9vMFdhZ1ZHckxmNnQ2NW9hUVhjN0VrRTlxclBsUjhY?=
 =?utf-8?B?dy9ueGI3cUd1aEQ4bHNXVEtoZ3dCWjFzS09ibUZLbGpLcStEVm5lVWI5VHhs?=
 =?utf-8?B?YnlZek0zSzZGQjVtWWQwZWVtbFQyZVJ3Rk9PWi9GODBxNVlDcC83dnJIaUhj?=
 =?utf-8?B?cktBeE5lOHQ5akcyTGhISVVTUVAyb0JQd3FSVHhNMGthM0dMV1c3NGtRMUJt?=
 =?utf-8?B?RTZMUmk2Vk9NVDFJU3IvM0V1ZmRNZW50YnhDRlRiTHluMEZyS0F1aWczTTVE?=
 =?utf-8?B?N3U1OVBOQTQxNEJsL1kxVmlhR0x2ZTZXdWYveFRUOXRpTDlJTXUrclhBRHVz?=
 =?utf-8?B?NU93VlpNdkpkZ2UvNHNqN2x0cThTRWlkQWlQU1VPYkJDTE5jc1hMb2dJWjRw?=
 =?utf-8?B?b3VLeVMxT1dNOTlTdHlsaTFWalNrdEtNSVhrcGgydmoxcDdvZ3RLU2VMUGxZ?=
 =?utf-8?Q?6rRNbxs/zJw0VqDam8jOX9s/jWYohWrF5XSYtZPvj66p?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F12D2E9A6D0E4F44BFA9F813380BD93D@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6214b740-2279-4dd2-9384-08d9be0bb986
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 07:39:41.5388 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQOOUibg/XmL9tpPfBhVjJGKSORLmFwP9jAdHjxzaCfR9XzPSRuMwrkHcjhBXFJmEVFB8++cIaTytTn8JPhPvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2380
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_233943_944493_21C647CE 
X-CRM114-Status: GOOD (  20.65  )
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

T24gMTIvMTIvMjEgMToyMiBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gRXh0ZXJuYWwgZW1h
aWw6IFVzZSBjYXV0aW9uIG9wZW5pbmcgbGlua3Mgb3IgYXR0YWNobWVudHMNCj4gDQo+IA0KPj4g
RnJvbTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4+DQo+PiBBZGQgS0Nv
bmZpZyBtZW51IG9wdGlvbiB0byBlbmFibGUgYW5kIGRpc2FibGUgZ2VuY291bnRlciBkZWJ1Zw0K
Pj4gZmVhdHVyZSB0aGF0IHVzZXMgY29uZmlnIE5WTUVfREVCVUdfVVNFX0NJRF9HRU5DVFIuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4N
Cj4+IC0tLQ0KPj4gwqAgZHJpdmVycy9udm1lL2hvc3QvS2NvbmZpZyB8IDEwICsrKysrKysrKysN
Cj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZS9ob3N0L0tjb25maWcgYi9kcml2ZXJzL252bWUvaG9zdC9LY29uZmln
DQo+PiBpbmRleCBkYzA0NTBjYTIzYTMuLmRmYTI2MDliNzAwNiAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvbnZtZS9ob3N0L0tjb25maWcNCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L0tjb25m
aWcNCj4+IEBAIC0xLDQgKzEsMTQgQEANCj4+IMKgICMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAtb25seQ0KPj4gK21lbnUgIkRlYnVnIChFbmFibGUgZHJpdmVyIGRlYnVnIGZlYXR1
cmVzKSINCj4+ICtjb25maWcgTlZNRV9ERUJVR19VU0VfQ0lEX0dFTkNUUg0KPj4gK8KgwqDCoMKg
IGJvb2wgIkVuYWJsZSBjb21tYW5kIElEIGdlbiBjb3VudGVyIGZvciBzcHVyaW91cyByZXF1ZXN0
IA0KPj4gY29tcGxldGlvbiINCj4+ICvCoMKgwqDCoCBkZXBlbmRzIG9uIE5WTUVfQ09SRQ0KPj4g
K8KgwqDCoMKgIGhlbHANCj4+ICvCoMKgwqDCoMKgwqAgVGhlIE5WTSBFeHByZXNzIGRyaXZlciB3
aWxsIHVzZSBnZW5lcmF0aW9uIGNvdW50ZXINCj4+ICvCoMKgwqDCoMKgwqAgd2hlbiBjYWxjdWxh
dGluZyB0aGUgY29tbWFuZCBpZC4gVGhpcyBpcyBuZWVkZWQgdG8gZGVidWcgdGhlDQo+PiArwqDC
oMKgwqDCoMKgIHNwdXJpb3VzIHJlcXVlc3QgY29tcGxldGlvbnMgY29taW5nIGZyb20gYSBidWdn
eSBjb250cm9sbGVyLg0KPiANCj4gVGhpcyBpcyBub3QganVzdCB0byBkZWJ1ZyAtIGl0IGlzIGFs
c28gdG8gcHJvdGVjdCBhZ2FpbnN0IHN1Y2ggYQ0KPiBjb250cm9sbGVyLiBXaGF0IGlzIHRoZSBw
dXJwb3NlIG9mIHRoaXMgY29uZmlnIG9wdGlvbiBhbnl3YXlzPw0KPiBUaGUgbWFpbiBkaXN0cmli
dXRpb25zIHdpbGwgKGFzIHRoZXkgc2hvdWxkKSBlbmFibGUgaXQgYW55d2F5cy4uLg0KDQpJIGNh
biByZXdyaXRlIHRoZSB0ZXh0IGFuZCByZW5hbWUgaXQgdG8gImRyaXZlciBmZWF0dXJlcyIuDQpX
ZSBhcmUgcHJvdGVjdGluZyBhZ2FpbnN0IHN1Y2ggYSBjb250cm9sbGVyIHdoaWNoIGlzIG5vdCBz
dGFibGUNCihidWdneSksIGkuZS4gaXQgaXMgZG9pbmcgdGhpbmdzIHdoaWNoIGl0IHNob3VsZG4n
dCBiZQ0KZG9pbmcgYXQgdGhlIGZpcnN0IHBsYWNlLiBDb25zaWRlciBhIGNhc2UgaWYgY29udHJv
bGxlciBpcyBub3QNCmJ1Z2d5IHRoZW4gaXQgYWRkcyBpbnN0cnVjdGlvbnMgaW4gdGhlIGZhc3Qg
cGF0aCB3aGljaCBhcmUgbm90DQpuZWVkZWQgYXQgYWxsLg0KDQpBIGNvbnRyb2xsZXIocykgdGhh
dCBpcyB1c2VkIGluIHRoZSBwcm9kdWN0aW9uIGVudmlyb25tZW50IGdvZXMNCnRocm91Z2ggcXVh
bGlmaWNhdGlvbiBwcm9jZXNzIGZyb20gdmVuZG9ycyBhbmQgZnJvbSB0aGUgY29uc3VtZXJzDQp0
byBtYWtlIHN1cmUgdGhleSBhcmUgc3RhYmxlLCBzb21ldGhpbmcgbGlrZSBzcHVyaW91cyBjb21w
bGV0aW9ucw0KZGV0ZWN0aW9uIGlzIGEgYmFzaWMgcGFydCBvZiB0aGUgcXVhbGlmaWNhdGlvbiwg
aGVuY2Ugd2Ugc2hvdWxkDQphbGxvdyB1c2VyIHRvIGNvbmZpZ3VyZSBnZW5jdHIgdGhhbiBmb3Jj
aW5nIGFkZGl0aW9uYWwNCmluc3RydWN0aW9ucyBpbiB0aGUgZmFzdCBwYXRoIGFuZCBrZWVwIHRo
aXMgcGF0dGVybiBmb3IgZnV0dXJlDQpzdWNoIGNhc2VzLg0KDQpNYXliZSBJIGRpZG4ndCB1bmRl
cnN0YW5kLCBjYW4geW91IHBsZWFzZSBleHBsYWluIHdoYXQgYXJlIHRoZQ0KYmVuZWZpdHMgb2Yg
aGF2aW5nIGdlbi1jb3VudGVyIHdoZXJlIGNvbnRyb2xsZXIgaXMgc3RhYmxlPw0KDQpJJ2xsIHdh
aXQgdG8gc2VuZCBWMiBpZiB5b3UgY2FuIHN1Z2dlc3QgYW55IG90aGVyIHdheQ0KKHRoYW4ga2Nv
bmZpZyBzb21ldGhpbmcgbGlrZSBtb2R1bGUgcGFyYW0sIEknbSBub3Qgc3VyZSkgc28gdXNlcg0K
Y2FuIGNvbmZpZ3VyZSBnZW5jdHIgY2FsY3VsYXRpb25zLCBwbGVhc2UgbGV0IG1lIGtub3cuDQoN
Ci1jaw0KDQo=

