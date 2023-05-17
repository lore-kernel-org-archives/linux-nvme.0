Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90CA8C7EE23
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 21:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gl3M4cgWCNwr0x4iI8u/dWG/3BXimRN3l9JwUjJeLc0=; b=LgBBltfhgH5ZUNLpN925z7G+Zc
	103mVik9XN8Ac0YJwfxVoiqBoAKuMwxkvjoN1Wu4FJ/sOB1rtGgqjWNnIrBqCpGNXcJBhhy7hx9By
	wS8qlwBdPmEUc+8MFRkx1UIysp4rk7LVCP77X0RoYQcxVxsCX2WY7oDYfwmwEaYRhPl0BpW/j0ONP
	IE7t/VZcGE+USCTvFWemd+euJBuLzVE8/yJi65BFRT5nk0uOpiQDQIgnyHV4MthRtvW3rxc8eNw1i
	MQ8blQDAmxvJLhALsfiTBVLEagDV6Fr5xcDdith3foSE+GNtHrZe+slj3RoWz63sJY/zQeZJwv5e+
	BnQBYpHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzOLY-00B3xY-20;
	Wed, 17 May 2023 21:06:08 +0000
Received: from mail-dm6nam12on2060f.outbound.protection.outlook.com ([2a01:111:f400:fe59::60f] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzOLS-00B3wP-0b
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 21:06:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m/YVjOxgnMsNqZXr+GgbEt7tKK8gsbh2/7cUQ9Q472EiMOx15xp5ras8t5ozF7/VQ3rOjLY/W29NUGDzhhHRj9bS/O7Mf1fErPHtbeiwociEsTx/IFAcBOzAoqVbuluwZIXASrvgg3GZLklhv53kvLhAKKKdSwGyVlwymSykXEkTpi4vAPSinZp5kjoH30XPxVboiT96GYpiihP5g2bs4a42dDrVNewv0ZLa4deUPD1h6alpO/HYpQEVRGPk3ao7Xgr2oMW4geRs2fmLRCqN2axVeY4/+v1dm2i1AEtLXaKAwCvEVlT1iF5CFRt0DKIy1ihcC72ltv7aLZsiFuyMUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gl3M4cgWCNwr0x4iI8u/dWG/3BXimRN3l9JwUjJeLc0=;
 b=Od37RAtgi56DcED+lyRfh3kq0O/ZnZpCMj1D5yWvoArFddLyJbovJXVr3QlJpQi4MTXj3UtjiYFgnqe/S1hMre5E5BwAdL9Gy6EhulkWJyYHvwjpuhqK/OGd7kRwl1A01gLfRWtM+Pa/T83blC5Qd8CRxmeLz7JtSAxegGWVd0WUyHikRrRG5M+X/I0BccXorzNOzC3sj1f1ZqouSF7go65LVKQUtpUyDhH7UlxG820Sck472BZkjLsoxRp9BQ7RvCfp9Kg3SMFdUOIkkih8I1s9mpbcdNJ6Ck+G2GaCR+sivw7I65YxgxG1jxy3VzQ6J9GqXVgin6Lu86bUyzpVLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gl3M4cgWCNwr0x4iI8u/dWG/3BXimRN3l9JwUjJeLc0=;
 b=jLiry6YZm8p9eZhAK5TN1apbhHVpwDRPToJTZ5B6gUl2wPbbpNkuA5n7Gp+YRpqNAdO6EuTtTkjd3y/twbZTFzgvj+AMiZL79I+29wdLb5DiJjYTApX7s6PUuAVi1iOk3svElgXlcCk5nl0BXzyV1KKM8J3G8gyXrl3YL0To3yEKWXBVhm3+YtgheH0qezX9voH1DbpiUA6L+Jzlg7i0gCK+WOehzUQSjNk9kjtiqYtYaXpIrr6iL9Q2WUCBtxSLfJjwyb68gScjru7XsDTCNcRvZyKqdO2FYPcs94kbNFD+m8GBUXZYJ1cHsjJDV9P1RRowaFMMn++qLj4+w9X6BQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS7PR12MB8231.namprd12.prod.outlook.com (2603:10b6:8:db::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 21:05:57 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 21:05:57 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "hare@suse.de" <hare@suse.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/3] nvme: add generic helper to store secret
Thread-Topic: [PATCH 1/3] nvme: add generic helper to store secret
Thread-Index: AQHZh94aS4XJaHoZski697stSLisUq9eE22AgADjlQA=
Date: Wed, 17 May 2023 21:05:57 +0000
Message-ID: <0c0dadfc-53aa-6131-2e0a-4985e19e464f@nvidia.com>
References: <20230516100605.53712-1-kch@nvidia.com>
 <20230516100605.53712-2-kch@nvidia.com>
 <05c40aed-755a-bbdf-4e22-c529ea4d6e17@grimberg.me>
In-Reply-To: <05c40aed-755a-bbdf-4e22-c529ea4d6e17@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS7PR12MB8231:EE_
x-ms-office365-filtering-correlation-id: 7fc2838a-0c1a-41aa-fada-08db571a8262
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  YeGuwWpNG07xdpG6j3akFmwYEHCZ6xFKAx33d+CEHr/uKdcYLxJ+g0M+BiSefST1+2Vf6pCWO3xVaaJQBl7IxSEO2eVJ/jPvnXhlq7ay3y6H8ooZBJpEWpeiHc2WNHHWEYYx1cjSo2UPZVkpq0J4ommczY365QgLVASAYl/aCv+cXYirO0vlE0eaIuYmM4gDphewerEL1dSef3XP6+qxftV6cy5uQRyP2m/0SRTK7O7wb5QpW/htkn2ydtKaA4nrppG8AWWE2Y2iTvXB0pqk04TIFT0i3912m02XjL2gA35hWEPQzR4LXT2yReVGorsLCtyjzIqXmDAzul260Mow4s0mop4N4vMM9S2c3ADirQNX2GWi21XDMCbABUjPB+qQ8ZpnRCEh3zPgozrC1qjx+Mgy9esjC14a30QGDvpvPgwH7gXb9hQdNVcSDTU10p1Wgy6/UbMZrt5UoSAdpSO1qJfDznmjk4sMNbjpKNB6seGCyMPBcOmfDZF2NdSrwqKtXOqeVL97Wxxj26DR68hBgTs1u6vvPH/J+Mz19hshPXbnivCoQbiFKk9RgmW3QSFM92IBzFif1O+recOgfXJuEw/0I8beHekdJU35F7Or4t4Gk1whNIeioU6PrYRO2tXte7wmQoIidopD2FanmUg6coI6Xwlq9a8ZuO3hzc+d2Dr7uxmXe1754UG7EqRoq1R8snDc5lWf/SsmbA62IohxNfkzBQ5aWWhaxgP4YBi8lNM=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(451199021)(54906003)(110136005)(8936002)(5660300002)(83380400001)(186003)(6506007)(31696002)(6512007)(53546011)(86362001)(2616005)(122000001)(38100700002)(38070700005)(8676002)(41300700001)(91956017)(6486002)(71200400001)(66446008)(316002)(66476007)(64756008)(66946007)(76116006)(36756003)(4326008)(66556008)(478600001)(2906002)(31686004)(41533002)(219293001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?KzJhRU01UUN5WEJickc1TlRGRitKMEFPOUVTRlRsZlhqZTBrUnRIZWtCbkU2?=
 =?utf-8?B?TzFSR3kycDJvNjJQYnJ6cHBsY2czMWxmWllqendCdlFpSzE4aGUxNXJxSTNm?=
 =?utf-8?B?N2VBZ2tDblU4bk9MMi9QVzFPTEhWR3l1QzB5NDFrV0ZuZDM2NDBJNkttTnNC?=
 =?utf-8?B?YUdQZ0JjdE93d0lDMk9UNFdvVDNnMHptbXJsbUo2Um84Q2RWc1VaV3ZEcXVi?=
 =?utf-8?B?amRwOEhYU1FUL0RlV0FwZnRNa2JxTWRROHdiRWU3TzluaU5QNkY5UG5yTmsv?=
 =?utf-8?B?TWlMUnRqYVVOaUsrcGhSd1h3L0xzOEZVV3BENGMzUE1QRmg4cERGTEl5M1pM?=
 =?utf-8?B?Uk56eVkyWmwwMlBQYXMrb0VRRFIxT0M5Z1RMUExybytqc3BjV2hRYzVzU1lS?=
 =?utf-8?B?bmNLdk9yN3UwdGZ4SE9lWVpjRkM2Tm9RL254aHBiUEtrZy9VRldQUWdqclky?=
 =?utf-8?B?QzUxY1o3UG9wRlp2bFBOMnp2bXJaVFllY3Y5MUxGZmVRRXF0TjR4WmZZc01T?=
 =?utf-8?B?ZjVmT0doWFVlOGFqcS92ZkJWckFNN1ZXTXk4RktacTRTZDlsbWlrM0IxdnBo?=
 =?utf-8?B?VDVIKzBvWnpUek5sV1BnRWlHOXhjUllRb09XRk1tQm43ZlBoaXh6TnB5Ukxw?=
 =?utf-8?B?R3ROWFJLWm1qMStUVEhySzlCV2JBaTdDK2EvcTZ5TmpReVVYc09WS3lKcUlw?=
 =?utf-8?B?MWU2eFBPQUJ0bUp3MFZLSitMemNpZ2NseVJWK01mV3ByTHJrMUZWazE3RzFM?=
 =?utf-8?B?SlJ6V3pBeDBNM1VoTHRrclRiMHNXTXpxb3BHMFRlTWFZdThPT0prVWZvUXNX?=
 =?utf-8?B?VWhtNThPZmg1WE54cWJnZEFPUXpJdXRuQm5MU3BmKy9PME00bUZhZk9WMStI?=
 =?utf-8?B?ekZ3bVJ1SCtPSGg0RDJ2SEVtdmVIamM2WkdoWmEzemFXN3FWNGNuaHZoWnJW?=
 =?utf-8?B?Zm5BcmNob2wrZHlVZFI3OVlUdjgxT1RJWXZhRVdXemNwU3lRa0F1VndYSTZz?=
 =?utf-8?B?cVBaNHkzbTlEdFdPejNzUEZmWnV4aDQ0cDJoWFJFRjVjQUFUTklQUmlHbkJR?=
 =?utf-8?B?by9aWHdIckoveUF0eUpVeXRMeWV4ZDAzL3RZb2Rma2lhVDZCUzZ5V2dsYlAv?=
 =?utf-8?B?ZGJ3S0VYa2lFL2h1bUszL05HZHVNUitNNFVwR3BXcGNWYUJTMnNpY21QcmE4?=
 =?utf-8?B?aGg0NDNxT3FJMG9mQ2hRZ1paNlBIK2xaK1plb2VFRGhvbGs1NndnMjZCc3dm?=
 =?utf-8?B?Y01kaGQ1amZ0RDM4QWdJbk5pa28yd1FObnA0WVdzYzhRQ3czVHR1akM0Y2xV?=
 =?utf-8?B?cHp4U3VyN3ZtNVN1QjJGWTluY1RBVTBXYjB3U3hRclRSSXZ0a2ZKSDZiaHMy?=
 =?utf-8?B?TXZlSHJFdW9ESGo4SkFxQXlRQ2Y1TmwvMUpGU2hUc3dkeEQvUFVUSFgrOU95?=
 =?utf-8?B?MGFvMjk1NkRJSmVSQldKUUhtWVB6Z3NyRWMwT2dJaXh5MExuUkl6azZXcGsy?=
 =?utf-8?B?M2pnYzJNSWFOdWFndXdLVDQ5Tlo0RTBoN0NJU0tUWkNUWmpBZDdKSHVsZGFL?=
 =?utf-8?B?M3oxK3NWZ0ozRGNrM2FEWUVEYVhWNGFIKzdpL05rVDhLNFpNOXEwTWlwRlpS?=
 =?utf-8?B?aE1SZjRwQXlENDV3VCtDYVlGU0hmNGU0alBhSGVtZ05nbE0xeVpTMGJxWnBi?=
 =?utf-8?B?ck9zQjhnYTVnOTJWRG8wOFFEbElURFhyS2FzYWU1eTBUVjZxaXJac2dHUi9n?=
 =?utf-8?B?cjJTblF4ZzN1NzZxbXlUYk9Ra0VIY0tWVzBoMWlLSngwdENXaHRhbVlHaHVy?=
 =?utf-8?B?N0c0cWhLRituWVhFZlgydWJxcGdVWUZIMTZvYTl0Sk1LQUxUVW9jdzFvYTA1?=
 =?utf-8?B?VDZFRG5jNmdYNWxRUW4yZkJ1bmQreGZSRzV4MmRheEJMVGhrSkdUR0k4QXlq?=
 =?utf-8?B?QWtOalVFZ2orZ2NkdG5ITjdCUUtPeFVESUtkTlVMQVhqUytPdE9oS1oxZ3pm?=
 =?utf-8?B?SzJPeHdIcTNsKzhvc0d0WUk0Y01XYzR5TjlmSDVSK2RPYnVnWmJmdmNoVXRU?=
 =?utf-8?B?bUx5bEFLMjkyZGQwQ1cyN1B0V0dNSTk4d0xTU2FtVWdZbTBrWk4vYkRjQlZv?=
 =?utf-8?B?ejcySDVjVXU1dGNWSEoxUjZlR0d6TTZ1aDhBeElGQk1qOVo0eHdvZ2hlYVFq?=
 =?utf-8?Q?G6nzg1MLOA5jtEbnFu6Mk8OxDD4T4melT49tDbyiUJhL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C4772B7D9BE10F4A8238C27B3B187755@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc2838a-0c1a-41aa-fada-08db571a8262
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 21:05:57.1210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jmL/PxpwmQ9vnzYlOmJfM6OlNOFvtrmWIYCUNuCIFyM+eSwrlH3RR/YVDPjbWl+4ZzVt7xJkLFu3cNds1XacQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8231
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_140602_224024_13C169E7 
X-CRM114-Status: GOOD (  19.34  )
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

T24gNS8xNy8yMyAwMDozMSwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4NCj4NCj4gT24gNS8xNi8y
MyAxMzowNiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gUmVmYWN0b3IgY29kZSB0byBh
dm9pZCBkdXBsaWNhdGlvbiBhbmQgaW1wcm92ZSBtYWludGFpbmFiaWxpdHk6DQo+Pg0KPj4gQ29u
c29saWRhdGUgdGhlIHNoYXJlZCBjb2RlIGJldHdlZW4gdGhlIGZ1bmN0aW9ucw0KPj4gbnZtZV9j
dHJsX2RoY2hhcF9zZWNyZXRfc3RvcmUoKSBhbmQNCj4+IG52bWVfY3RybF9kaGNoYXBfY3RybF9z
ZWNyZXRfc3RvcmUoKS4gVGhpcyBkdXBsaWNhdGlvbiBub3Qgb25seQ0KPj4gaW5jcmVhc2VzIHRo
ZSBsaWtlbGlob29kIG9mIGJ1Z3MgYnV0IGFsc28gcmVxdWlyZXMgYWRkaXRpb25hbCBlZmZvcnQg
Zm9yDQo+PiBtYWludGVuYW5jZSBhbmQgdGVzdGluZy4NCj4+DQo+PiBJbnRyb2R1Y2UgYSBuZXcg
Z2VuZXJpYyBoZWxwZXIgZnVuY3Rpb24gY2FsbGVkDQo+PiBudm1lX2RoY2hhcF9zZWNyZXRfc3Rv
cmVfY29tbW9uKCkgdG8gaGFuZGxlIHRoZSBzdG9yYWdlIG9mIHRoZQ0KPj4gZGhjaGFwIHNlY3Jl
dC4gVGhpcyBoZWxwZXIgZnVuY3Rpb24gd2lsbCBiZSB1c2VkIGJ5IGJvdGgNCj4+IG52bWVfY3Ry
bF9kaGNoYXBfc2VjcmV0X3N0b3JlKCkgYW5kDQo+PiBudm1lX2N0cmxfZGhjaGFwX2N0cmxfc2Vj
cmV0X3N0b3JlKCkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxr
Y2hAbnZpZGlhLmNvbT4NCj4+IC0tLQ0KPj4gwqAgZHJpdmVycy9udm1lL2hvc3Qvc3lzZnMuYyB8
IDU5ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPj4gwqAgMSBmaWxl
IGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9zeXNmcy5jIGIvZHJpdmVycy9udm1lL2hvc3Qvc3lz
ZnMuYw0KPj4gaW5kZXggNzk2ZTFkMzczYjdjLi45Y2UzYjE2ZjA2ZGEgMTAwNjQ0DQo+PiAtLS0g
YS9kcml2ZXJzL252bWUvaG9zdC9zeXNmcy5jDQo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9z
eXNmcy5jDQo+PiBAQCAtNDE4LDQzICs0MTgsNTMgQEAgc3RhdGljIHNzaXplX3QgDQo+PiBudm1l
X2N0cmxfZGhjaGFwX3NlY3JldF9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4+IMKgwqDCoMKg
wqAgcmV0dXJuIHN5c2ZzX2VtaXQoYnVmLCAiJXNcbiIsIG9wdHMtPmRoY2hhcF9zZWNyZXQpOw0K
Pj4gwqAgfQ0KPj4gwqAgLXN0YXRpYyBzc2l6ZV90IG52bWVfY3RybF9kaGNoYXBfc2VjcmV0X3N0
b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwNCj4+IC3CoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNl
X2F0dHJpYnV0ZSAqYXR0ciwgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpDQo+PiArc3Rh
dGljIHNzaXplX3QgbnZtZV9kaGNoYXBfc2VjcmV0X3N0b3JlX2NvbW1vbihzdHJ1Y3QgbnZtZV9j
dHJsICpjdHJsLA0KPj4gK8KgwqDCoMKgwqDCoMKgIGNvbnN0IGNoYXIgKmJ1Ziwgc2l6ZV90IGNv
dW50LCBib29sIGN0cmxfc2VjcmV0KQ0KPj4gwqAgew0KPj4gLcKgwqDCoCBzdHJ1Y3QgbnZtZV9j
dHJsICpjdHJsID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+PiAtwqDCoMKgIHN0cnVjdCBudm1m
X2N0cmxfb3B0aW9ucyAqb3B0cyA9IGN0cmwtPm9wdHM7DQo+PiAtwqDCoMKgIGNoYXIgKmRoY2hh
cF9zZWNyZXQ7DQo+PiArwqDCoMKgIHN0cnVjdCBudm1lX2RoY2hhcF9rZXkgKipvcmlnX2tleTsN
Cj4+ICvCoMKgwqAgY2hhciAqKmRoY2hhcF9zZWNyZXQ7DQo+PiArwqDCoMKgIGNoYXIgKm5ld19k
aGNoYXBfc2VjcmV0Ow0KPj4gKw0KPj4gK8KgwqDCoCBpZiAoY3RybF9zZWNyZXQpIHsNCj4+ICvC
oMKgwqDCoMKgwqDCoCBpZiAoIWN0cmwtPm9wdHMtPmRoY2hhcF9jdHJsX3NlY3JldCkNCj4+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOw0KPj4gK8KgwqDCoMKgwqDCoMKg
IGRoY2hhcF9zZWNyZXQgPSAmY3RybC0+b3B0cy0+ZGhjaGFwX2N0cmxfc2VjcmV0Ow0KPj4gK8Kg
wqDCoMKgwqDCoMKgIG9yaWdfa2V5ID0gJmN0cmwtPmN0cmxfa2V5Ow0KPj4gK8KgwqDCoCB9IGVs
c2Ugew0KPj4gK8KgwqDCoMKgwqDCoMKgIGlmICghY3RybC0+b3B0cy0+ZGhjaGFwX3NlY3JldCkN
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOw0KPj4gK8KgwqDCoMKg
wqDCoMKgIGRoY2hhcF9zZWNyZXQgPSAmY3RybC0+b3B0cy0+ZGhjaGFwX3NlY3JldDsNCj4+ICvC
oMKgwqDCoMKgwqDCoCBvcmlnX2tleSA9ICZjdHJsLT5ob3N0X2tleTsNCj4+ICvCoMKgwqAgfQ0K
Pj4gwqAgLcKgwqDCoCBpZiAoIWN0cmwtPm9wdHMtPmRoY2hhcF9zZWNyZXQpDQo+PiAtwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+PiDCoMKgwqDCoMKgIGlmIChjb3VudCA8IDcpDQo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+PiDCoMKgwqDCoMKgIGlmICht
ZW1jbXAoYnVmLCAiREhIQy0xOiIsIDcpKQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAt
RUlOVkFMOw0KPj4gwqAgLcKgwqDCoCBkaGNoYXBfc2VjcmV0ID0ga3phbGxvYyhjb3VudCArIDEs
IEdGUF9LRVJORUwpOw0KPj4gLcKgwqDCoCBpZiAoIWRoY2hhcF9zZWNyZXQpDQo+PiArwqDCoMKg
IG5ld19kaGNoYXBfc2VjcmV0ID0ga3phbGxvYyhjb3VudCArIDEsIEdGUF9LRVJORUwpOw0KPj4g
K8KgwqDCoCBpZiAoIW5ld19kaGNoYXBfc2VjcmV0KQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybiAtRU5PTUVNOw0KPj4gLcKgwqDCoCBtZW1jcHkoZGhjaGFwX3NlY3JldCwgYnVmLCBjb3Vu
dCk7DQo+PiArwqDCoMKgIG1lbWNweShuZXdfZGhjaGFwX3NlY3JldCwgYnVmLCBjb3VudCk7DQo+
PiDCoMKgwqDCoMKgIG52bWVfYXV0aF9zdG9wKGN0cmwpOw0KPj4gLcKgwqDCoCBpZiAoc3RyY21w
KGRoY2hhcF9zZWNyZXQsIG9wdHMtPmRoY2hhcF9zZWNyZXQpKSB7DQo+PiAtwqDCoMKgwqDCoMKg
wqAgc3RydWN0IG52bWVfZGhjaGFwX2tleSAqa2V5LCAqaG9zdF9rZXk7DQo+PiArwqDCoMKgIGlm
IChzdHJjbXAobmV3X2RoY2hhcF9zZWNyZXQsICpkaGNoYXBfc2VjcmV0KSkgew0KPj4gK8KgwqDC
oMKgwqDCoMKgIHN0cnVjdCBudm1lX2RoY2hhcF9rZXkgKm5ld19rZXksICpwcmV2X2hvc3Rfa2V5
Ow0KPg0KPiBwcmV2X2hvc3Rfa2V5PyBvciBwcmV2X2tleT8NCg0KDQp3aWxsIGZpeCBpdCBpbiB0
aGUgbmV4dCB2ZXJzaW9uIC4uDQoNCi1jaw0KDQoNCg==

