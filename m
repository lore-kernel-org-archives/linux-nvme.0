Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC05C77B7A
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jun 2023 05:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=32VWArjfMOh6Ws2NUfPPEJGGymY6at7HhiR2xt8QrtE=; b=W7isEfJTyQwCQN7RKRic3F1q1K
	IAE1RnlyF+yHkDy4eQHyk2c0pJ3NkKzQevtCYndHx2J18KQHkzTH2jiujX1OQohpLWBZ4UIHYi57r
	QyAW8SRXj3ZACZ9LlyVCi00kYrvLb9w4XWuO9G2dCrwoKHMv8NUEasG95/5AozK+4Bqc0xlLsHhaT
	W8O4MrlcBGFVAGwbS4Tw1/vY2XNZZn1qo24J2uZ3DUVoOBGIYAOmQKHpYuEpIX1We3HghqqxiZSgU
	abyPMceeWQDI3FQLLOyoP5AK9nfQSptGybBVyjAqII4FYtNPURBX0rAF+k1LswMjqXCMUkZ32Fzrl
	TRrm34YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4x0i-005kaY-1B;
	Fri, 02 Jun 2023 05:07:36 +0000
Received: from mail-dm6nam11on20607.outbound.protection.outlook.com ([2a01:111:f400:7eaa::607] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4x0f-005kZo-0t
	for linux-nvme@lists.infradead.org;
	Fri, 02 Jun 2023 05:07:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BP02LlQn4nYr2zWNqrnhDe7EKugTXDHSenatf6aMB7mS9rgxt2EWKiEOJVIsq5Eie1F4dPksMiinV71G2AUtVMoFy8Hy5xZp5NqTLolxUoxLSg0Gp2C6sEq0AfDSBXDeDyWrHzCSEieifRFDfw3STgdA8zwequxr1WL6NIdMcoC6EkxePSe6DFE/xZ9y1o8QTTzg2gxxo+X5Uegz1O8Gu/ZwhDTstP97kP/pHjoCtLvwwqds/85pd+sxmTakrZqdkQC7mXSWO1/fOU3jMnzcO27bqZqop/tLyDfc0HS9RJZ+JrITirljm2WB4mE8GVUlM7kCuxc679+54+67bWRIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=32VWArjfMOh6Ws2NUfPPEJGGymY6at7HhiR2xt8QrtE=;
 b=WrhTIXJGUjMO5yN/03XKqZ0Mt9k8dY69d2KtVSkJ11eQ5p3lJcenPXF8LWzKChKPObOliFvHanYCJMZpCXtAAikm+rfkvNHVKH+nZuAx+CIn9Q0tNXGakYMpQH9eReFJSfdX00fxmSL3Nn5eEGYhNsiogKFgr/Egf+0B0M08BCUZEunX+YjLcSm5tnnmADOXN6UuI/rH3Nw77iRrKOrU2C7+fkjqUY5Zdo+7xBNkdNJadWCSQNtYppK9j72ndNjJCvQB21aXjbPGHTRke63qdIS9JJRTHCE9Hd0olihDrDmoTTcIp9/kfbIi7BSTj81RLtByS604lUvWX6Jr8NWzww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32VWArjfMOh6Ws2NUfPPEJGGymY6at7HhiR2xt8QrtE=;
 b=j4hU2UiEQMXfemCaaBWw8lR35+GMqWM2FxrUeHCXlnNpRWEhqBekMATRue9FlNXb/hqFvx+h+BsF5ezjWpjzNPTYcu0F532YMeD6pbfwjIlfhnRrnamtyBCsG+gs7rb0naknVc2y1GFM7nSlMq7p40vG9qF8ccDXIHQ0LUPqZDDK6ExH7w096P1CyHJOvSTdjhPag7jdM+xKPhXX6iKGsVE3jTgITt+Z15nuL2l7Mh0kRbx0tZH59fjvP7200/hjOtVOrqP2BQl8j27Y5KDEsydCTBvxMH/N9HokJbEan8dgmZKuERB16kaaUl3PeJN6quF4Ld4f2kDS7qFOgDDbTw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB7381.namprd12.prod.outlook.com (2603:10b6:303:219::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Fri, 2 Jun
 2023 05:07:26 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6455.020; Fri, 2 Jun 2023
 05:07:26 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: "oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>, Max
 Gurtovoy <mgurtovoy@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Israel
 Rukshin <israelr@nvidia.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [linux-nvme:nvme-6.5 15/21] drivers/nvme/host/fabrics.c:96:2-8:
 preceding lock on line 85 (fwd)
Thread-Topic: [linux-nvme:nvme-6.5 15/21] drivers/nvme/host/fabrics.c:96:2-8:
 preceding lock on line 85 (fwd)
Thread-Index: AQHZlQ6oL+6HM1S6/kOUtmcdwnCgSq929h+A
Date: Fri, 2 Jun 2023 05:07:25 +0000
Message-ID: <ad237568-3d7c-a2d2-02ac-e75688d768bd@nvidia.com>
References: <alpine.DEB.2.22.394.2306020654430.2925@hadrien>
In-Reply-To: <alpine.DEB.2.22.394.2306020654430.2925@hadrien>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB7381:EE_
x-ms-office365-filtering-correlation-id: f8b3405f-d5a2-4bdf-abba-08db632741b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DRTOMjjK3pUvHNgyde1Foyki6w8QGPlwOxMWGigEXzg5exxXVCYKEY+h3tACQtMvhDJNT4XFw9xzq81N3xsMPlkDt/kA4/MhO4R+xLPlxG7SS7EDJdHK0EggA3QeiRXzQU7Zf1HMgcTRpnRAFl5FSYv8tGQ2qfsiGzZlfXb6BhBjaFJap+It8d+y3kgepsACVfcl47KocU9Sif/QiXsp6V3TUhuyZHrzTta9YfVqHV36Lldvyxrad+7bihi3Qxms5j2lNMkRqupmyzU2CXUqZ4r2o8Pj7s1J8YJDiOSM9cUtzWGoFcwDKthLJ23tkQB4roA9Vt0dKqd7ihjY/TiBOU8IFRBuip3GyXDfYVVMLkWIsN4HZatXaUKiTbYe9c8B9dzrMu9xDEOQkcHM9UORSHqkilvUNeHy3cBb8uZe+12QHQtkdYzIrpKgnUnVwaNOsTC9fT+731lpZIWJvqAKUkPNBqQdfr+AUda5IuvdVyB+ItL/2g0hqWdso5zX7WxQMkjYc43Hd3oJH9rb1GXCBj4rpVZYJiIXb4ukg6qOUmw9KPdQC6M9kUbFrNZ9JFDOYmz9/x6oZ8/GQuUTktDWxBx2euQKahxJyw1jSeBHNY6m8ApY9P0JsPQTzn4GBdeE+YQGM6fU3Gk2DqsJ6PLU1f8QjKxYTinIRED4/pFxpyarDzdTC79ikiGplDcEoihJhJqlE1inc8Hoi+HbT8dJBUItnA2hgomypho66K93ts8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(451199021)(91956017)(66476007)(76116006)(66556008)(66946007)(66446008)(64756008)(31686004)(6916009)(316002)(4326008)(41300700001)(54906003)(5660300002)(8676002)(2906002)(8936002)(966005)(6486002)(71200400001)(478600001)(26005)(53546011)(186003)(36756003)(83380400001)(6512007)(6506007)(122000001)(2616005)(86362001)(31696002)(38070700005)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0YzZXRFamwxbTl2YXFrK1JQRitqWnhjbXlraWR4ZDY1cTBtM01WS0E5djBt?=
 =?utf-8?B?TENQS2xYWlpqM3Z1QzliZkNSaVBiSDlMaGV1U1RkSDJxeGF1VWdIMllzUGh6?=
 =?utf-8?B?QWJnTzFpRk1MWkFqdnhYQUxZWGFPQTduSmNSL1VrRTFScHV6SmNJT3QwQ2dV?=
 =?utf-8?B?TzVXa1VRaFZMbUZ5QVY4Q1dscUJLSi9BMFVPK0pZQjdObEJUMHkyZ3psY3ow?=
 =?utf-8?B?V093T25YYi9QTHBmWmJSWEJhY2g4enBhbHNJeG9ZcnZoUmxIcXMzYVFyc2F5?=
 =?utf-8?B?NkVoZlhSdjNncEttOTJhbGw0OUVNWlFzU3Z0L2pnWFVaRTlyR2FaaVRydkVa?=
 =?utf-8?B?b0owY1JvWWM1ZGtIL0prZmVuSnQxNDRYVkZkTU1yWUhQcFB0aEt0QUx1MnpT?=
 =?utf-8?B?Vy8rNHBxSkd5bnJwOUNoT0xwYkpHWHdEWnRCM2J3eXZNa1pRY29rTzMxdVNq?=
 =?utf-8?B?clg1M3NYRGRVcXF5RkpGeVlpZFMxS3MrQVQrOU94VDFESXdQUXgvcTlHRk03?=
 =?utf-8?B?ZU9zUVFIQkorNGZBTDFvQlh3eW5IdEFqbFpCckx6NjJtV2Y0V1puMHhWMUdE?=
 =?utf-8?B?MEJPRmdWWnRhUXhxOW1DRDlQSWYyR3JOWW1IMk81R0hGLy9rQnpFTUpZZWJK?=
 =?utf-8?B?L3QzR2M3TjBPOUFiNVhjSWlOZ0IwcDVQVlJaZzFEaUhNOHVhemJBTDlyTHly?=
 =?utf-8?B?b3RtMVluMk4yTnByeUtRYVZ4Nk1UOXkzRmFDUFl3QVpDdUVyeTZOTms4RHZC?=
 =?utf-8?B?dTRPS0p3c04ycTcxYUNBdERzMnBrdnFKKzZNd24xTkdveGpZbjNkZ3BFckc1?=
 =?utf-8?B?cjBjK3h1RkpONE81cmROZnhnN2M3OERURU1HaXM2WUhvNkFrbjNWVjhIOEJa?=
 =?utf-8?B?azdBUUhTa1R1eXhFQkFCZEZUWklKSmsxNk1WSW5WdFJmSzFlVmdxTlVtSjYx?=
 =?utf-8?B?WU9mZCtFSDlEeVNGN2d5QnNRcTlCTDVIOWVvb3Q5RTU5ckZONzhHN0JMYlpY?=
 =?utf-8?B?MTZUN0NXcjN5VU92Tk85cEduZzRBc09OVm5vR3ViR2l5UHhlOHRPZW5ocGxq?=
 =?utf-8?B?WDNHblNBUXJNTGpVY1lvWk1ZbC9NekpKYjRQeDJFM1pMalBvR2NkVkt2dDNj?=
 =?utf-8?B?QU5MNmxtRENHYWwrWnN1NHdyTnJqdDRTdWdBZEkzUCt5VlF6cjUrN29STENa?=
 =?utf-8?B?dHd4VVRaVmhIQittN3ZqTjdCcnRFVVdjWTlsekg5RUZlalVtdTZHZVU4QXpj?=
 =?utf-8?B?aXh2czRzMEVwbDl1UUg0YnR1UFNFUlNEZjZoZHNCY081TmdHNTZsTGdheXNB?=
 =?utf-8?B?czloczRKVmN1RWFoVmNGbFVrQzBUQUl1TU5EYzZzVE9FSXgwVnRvWmN0bXMv?=
 =?utf-8?B?QnJLNlpFa2JyWWlRUlg5aSs3VXU2ZHNGdTJMdlRuR1pXUjM1QjJoNTdGUmpV?=
 =?utf-8?B?dVF3QkY1M2lkVlA5K1hobDZEdVpMN0h2NFJoZzhwN28wRDkva3ZEUXh5Y2Mw?=
 =?utf-8?B?bCswZTcrTG9YRnJRb25FQ3cxVm5VQTQybjQ1SlMyZ1VXbk0yazNJaDAwdkMv?=
 =?utf-8?B?SXN0S1dJL3FVWFI2U2hDL3cyL1hGcWl0c1ArZ0FxeWJpZVRuNWp5MGFvbUJm?=
 =?utf-8?B?WklLZFFkQkR0UzMyRzRBT2w0c3hwRWk5cmg2SWMzRDNUMjVYYVRWSHJBbWpD?=
 =?utf-8?B?eUJmdGR6dmRhbjBhak1PemtRdWkxLzlTRTUvRGM1anhJSWhuVTAxVXJqZm5k?=
 =?utf-8?B?NjQxNmJkWTl4bU1CSkdodExkR09SWXJZNy85dHVrZnFZQVR2bFNqcHZSVlEz?=
 =?utf-8?B?WVlKSlE3RTkyRGNxazd6Q2dlQTNLdnV4ajBpZjhReVgyVHhnRFRybDBVUDc1?=
 =?utf-8?B?RnFsQlpPRGJwUVFPN2l4a1l6TVFyRnY5cWFMaVFuNXdqVGVyU01UMkEzTzlZ?=
 =?utf-8?B?SHZUSGFxV25JbDlnZzdiWTBGYkhBWjc3MWVOa2FpblNaR2ZyM21kMTdzWFF6?=
 =?utf-8?B?TENLRnZqSG8vTVBwYTJYZll6aGNENlE0ZGN4NjIzMXpOdTVua0pMaWVCUWhZ?=
 =?utf-8?B?MWVSNFJ6U0xYUS9TalBDcXplWHgvQzZYdXVqanlrOC9kVG43NUFnUjNPem8z?=
 =?utf-8?Q?FE2pypQRulBcReqSYxUkDiB2w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69B362EF4E6EE64FB154266D1D675C6E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b3405f-d5a2-4bdf-abba-08db632741b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2023 05:07:26.0196
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZ85XISsvlaJ2V1lJY7caq2uR1eFu3M3L9i1+GoCcRRrZUBlZGv6vn71WwIsMr1LjQ+rncDV5t2lAB7LW7raFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7381
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230601_220733_422882_040094FE 
X-CRM114-Status: GOOD (  18.05  )
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

T24gNi8xLzIzIDIxOjU1LCBKdWxpYSBMYXdhbGwgd3JvdGU6DQo+IEFuIHVubG9jayBhcHBlYXJz
IHRvIGJlIG1pc3Npbmcgb24gbGluZSA5Ni4NCj4NCj4ganVsaWENCj4NCj4gLS0tLS0tLS0tLSBG
b3J3YXJkZWQgbWVzc2FnZSAtLS0tLS0tLS0tDQo+IERhdGU6IEZyaSwgMiBKdW4gMjAyMyAwOTo1
NzowNyArMDgwMA0KPiBGcm9tOiBrZXJuZWwgdGVzdCByb2JvdCA8bGtwQGludGVsLmNvbT4NCj4g
VG86IG9lLWtidWlsZEBsaXN0cy5saW51eC5kZXYNCj4gQ2M6IGxrcEBpbnRlbC5jb20sIEp1bGlh
IExhd2FsbCA8anVsaWEubGF3YWxsQGlucmlhLmZyPg0KPiBTdWJqZWN0OiBbbGludXgtbnZtZTpu
dm1lLTYuNSAxNS8yMV0gZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5jOjk2OjItODoNCj4gICAg
ICBwcmVjZWRpbmcgbG9jayBvbiBsaW5lIDg1DQo+DQo+IEJDQzogbGtwQGludGVsLmNvbQ0KPiBD
Qzogb2Uta2J1aWxkLWFsbEBsaXN0cy5saW51eC5kZXYNCj4gQ0M6IGxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZw0KPiBUTzogTWF4IEd1cnRvdm95IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4N
Cj4gQ0M6IEtlaXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4gQ0M6IElzcmFlbCBSdWtz
aGluIDxpc3JhZWxyQG52aWRpYS5jb20+DQo+IENDOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxz
dC5kZT4NCj4NCj4gdHJlZTogICBnaXQ6Ly9naXQuaW5mcmFkZWFkLm9yZy9udm1lLmdpdCBudm1l
LTYuNQ0KPiBoZWFkOiAgIDE0YWQ5MWY3YTlhMjk1NjJmMjNiZWRkMjA1ZWYyMDkyNTVkOGI4ZDEN
Cj4gY29tbWl0OiBmMGNlYmY4MjAwNGQ2MTBiZTNlZjQ3YWJmMzE1ZGRmOTVhYTJkY2QxIFsxNS8y
MV0gbnZtZS1mYWJyaWNzOiBwcmV2ZW50IG92ZXJyaWRpbmcgb2YgZXhpc3RpbmcgaG9zdA0KPiA6
Ojo6OjogYnJhbmNoIGRhdGU6IDkgaG91cnMgYWdvDQo+IDo6Ojo6OiBjb21taXQgZGF0ZTogMyB3
ZWVrcyBhZ28NCj4gY29uZmlnOiByaXNjdi1yYW5kY29uZmlnLWMwMzItMjAyMzA1MzEgKGh0dHBz
Oi8vZG93bmxvYWQuMDEub3JnLzBkYXktY2kvYXJjaGl2ZS8yMDIzMDYwMi8yMDIzMDYwMjA5MDku
TVRVRUJlSWEtbGtwQGludGVsLmNvbS9jb25maWcpDQo+IGNvbXBpbGVyOiByaXNjdjY0LWxpbnV4
LWdjYyAoR0NDKSAxMi4zLjANCj4NCj4gSWYgeW91IGZpeCB0aGUgaXNzdWUsIGtpbmRseSBhZGQg
Zm9sbG93aW5nIHRhZyB3aGVyZSBhcHBsaWNhYmxlDQo+IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0
ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPiB8IFJlcG9ydGVkLWJ5OiBKdWxpYSBMYXdhbGwg
PGp1bGlhLmxhd2FsbEBpbnJpYS5mcj4NCj4gfCBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3IvMjAyMzA2MDIwOTA5Lk1UVUVCZUlhLWxrcEBpbnRlbC5jb20vDQo+DQo+IGNvY2NpIHdh
cm5pbmdzOiAobmV3IG9uZXMgcHJlZml4ZWQgYnkgPj4pDQo+Pj4gZHJpdmVycy9udm1lL2hvc3Qv
ZmFicmljcy5jOjk2OjItODogcHJlY2VkaW5nIGxvY2sgb24gbGluZSA4NQ0KPiB2aW0gKzk2IGRy
aXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYw0KPg0KPiBmMGNlYmY4MjAwNGQ2MSBNYXggR3VydG92
b3kgICAgICAyMDIzLTA1LTEyICAgODANCj4gZjBjZWJmODIwMDRkNjEgTWF4IEd1cnRvdm95ICAg
ICAgMjAyMy0wNS0xMiAgIDgxICBzdGF0aWMgc3RydWN0IG52bWZfaG9zdCAqbnZtZl9ob3N0X2Fk
ZChjb25zdCBjaGFyICpob3N0bnFuLCB1dWlkX3QgKmlkKQ0KPiAwN2JmY2QwOWEyODg1NSBDaHJp
c3RvcGggSGVsbHdpZyAyMDE2LTA2LTEzICAgODIgIHsNCj4gMDdiZmNkMDlhMjg4NTUgQ2hyaXN0
b3BoIEhlbGx3aWcgMjAxNi0wNi0xMyAgIDgzICAJc3RydWN0IG52bWZfaG9zdCAqaG9zdDsNCj4g
MDdiZmNkMDlhMjg4NTUgQ2hyaXN0b3BoIEhlbGx3aWcgMjAxNi0wNi0xMyAgIDg0DQo+IDA3YmZj
ZDA5YTI4ODU1IENocmlzdG9waCBIZWxsd2lnIDIwMTYtMDYtMTMgIEA4NSAgCW11dGV4X2xvY2so
Jm52bWZfaG9zdHNfbXV0ZXgpOw0KPiBmMGNlYmY4MjAwNGQ2MSBNYXggR3VydG92b3kgICAgICAy
MDIzLTA1LTEyICAgODYgIAlob3N0ID0gX19udm1mX2hvc3RfZmluZChob3N0bnFuLCBpZCk7DQo+
IGYwY2ViZjgyMDA0ZDYxIE1heCBHdXJ0b3ZveSAgICAgIDIwMjMtMDUtMTIgICA4NyAgCWlmIChJ
U19FUlIoaG9zdCkpIHsNCj4gZjBjZWJmODIwMDRkNjEgTWF4IEd1cnRvdm95ICAgICAgMjAyMy0w
NS0xMiAgIDg4ICAJCWdvdG8gb3V0X3VubG9jazsNCj4gZjBjZWJmODIwMDRkNjEgTWF4IEd1cnRv
dm95ICAgICAgMjAyMy0wNS0xMiAgIDg5ICAJfSBlbHNlIGlmIChob3N0KSB7DQo+IDk4MDk2ZDhh
Nzg3ZjA1IENocmlzdG9waCBIZWxsd2lnIDIwMTYtMDgtMTggICA5MCAgCQlrcmVmX2dldCgmaG9z
dC0+cmVmKTsNCj4gMDdiZmNkMDlhMjg4NTUgQ2hyaXN0b3BoIEhlbGx3aWcgMjAxNi0wNi0xMyAg
IDkxICAJCWdvdG8gb3V0X3VubG9jazsNCj4gOTgwOTZkOGE3ODdmMDUgQ2hyaXN0b3BoIEhlbGx3
aWcgMjAxNi0wOC0xOCAgIDkyICAJfQ0KPiAwN2JmY2QwOWEyODg1NSBDaHJpc3RvcGggSGVsbHdp
ZyAyMDE2LTA2LTEzICAgOTMNCj4gZjBjZWJmODIwMDRkNjEgTWF4IEd1cnRvdm95ICAgICAgMjAy
My0wNS0xMiAgIDk0ICAJaG9zdCA9IG52bWZfaG9zdF9hbGxvYyhob3N0bnFuLCBpZCk7DQo+IDA3
YmZjZDA5YTI4ODU1IENocmlzdG9waCBIZWxsd2lnIDIwMTYtMDYtMTMgICA5NSAgCWlmICghaG9z
dCkNCj4gZjBjZWJmODIwMDRkNjEgTWF4IEd1cnRvdm95ICAgICAgMjAyMy0wNS0xMiAgQDk2ICAJ
CXJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KPiAwN2JmY2QwOWEyODg1NSBDaHJpc3RvcGggSGVs
bHdpZyAyMDE2LTA2LTEzICAgOTcNCj4gMDdiZmNkMDlhMjg4NTUgQ2hyaXN0b3BoIEhlbGx3aWcg
MjAxNi0wNi0xMyAgIDk4ICAJbGlzdF9hZGRfdGFpbCgmaG9zdC0+bGlzdCwgJm52bWZfaG9zdHMp
Ow0KPiAwN2JmY2QwOWEyODg1NSBDaHJpc3RvcGggSGVsbHdpZyAyMDE2LTA2LTEzICAgOTkgIG91
dF91bmxvY2s6DQo+IDA3YmZjZDA5YTI4ODU1IENocmlzdG9waCBIZWxsd2lnIDIwMTYtMDYtMTMg
IDEwMCAgCW11dGV4X3VubG9jaygmbnZtZl9ob3N0c19tdXRleCk7DQo+IDA3YmZjZDA5YTI4ODU1
IENocmlzdG9waCBIZWxsd2lnIDIwMTYtMDYtMTMgIDEwMSAgCXJldHVybiBob3N0Ow0KPiAwN2Jm
Y2QwOWEyODg1NSBDaHJpc3RvcGggSGVsbHdpZyAyMDE2LTA2LTEzICAxMDIgIH0NCj4gMDdiZmNk
MDlhMjg4NTUgQ2hyaXN0b3BoIEhlbGx3aWcgMjAxNi0wNi0xMyAgMTAzDQo+DQoNCg0KY2FuIHlv
dSBzZWUgaWYgZm9sbG93aW5nIGZpeGVzIHRoZSBpc3N1ZSA/DQoNCkknbGwgc2VuZCBhIHBhdGNo
IHNvb246LQ0KDQpudm1lIChudm1lLTYuNSkgIyBnaXQgZGlmZg0KZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbnZtZS9ob3N0L2ZhYnJpY3MuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYw0KaW5k
ZXggYjFmYTI3YjYwOTE3Li45MWMzZDdjMWZhM2UgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWUv
aG9zdC9mYWJyaWNzLmMNCisrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYw0KQEAgLTky
LDggKzkyLDEwIEBAIHN0YXRpYyBzdHJ1Y3QgbnZtZl9ob3N0ICpudm1mX2hvc3RfYWRkKGNvbnN0
IGNoYXIgDQoqaG9zdG5xbiwgdXVpZF90ICppZCkNCiDCoMKgwqDCoMKgwqDCoCB9DQoNCiDCoMKg
wqDCoMKgwqDCoCBob3N0ID0gbnZtZl9ob3N0X2FsbG9jKGhvc3RucW4sIGlkKTsNCi3CoMKgwqDC
oMKgwqAgaWYgKCFob3N0KQ0KK8KgwqDCoMKgwqDCoCBpZiAoIWhvc3QpIHsNCivCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG11dGV4X3VubG9jaygmbnZtZl9ob3N0c19tdXRleCk7DQogwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBFUlJfUFRSKC1FTk9NRU0pOw0KK8Kg
wqDCoMKgwqDCoCB9DQoNCiDCoMKgwqDCoMKgwqDCoCBsaXN0X2FkZF90YWlsKCZob3N0LT5saXN0
LCAmbnZtZl9ob3N0cyk7DQogwqBvdXRfdW5sb2NrOg0KDQotY2sNCg0KDQo=

