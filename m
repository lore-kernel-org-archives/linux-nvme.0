Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37749C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 07:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ThQsml2b94aXZl6Kutr6lqDrrWAYseblewuM3bWk4g=; b=ucDhWSqnkavcYW8lQZoxdB6wam
	GafPNGt9nM89w3v+4SJYuXtZb4wx+KogfdmdGr5YxPN5lNzu9gcfzckN8Xn8saUtsD5aCJbo4OlMB
	kgKIU9Z17RfLcHQgy70HBmvcmBH+c96FIi5wA/V/qSAuTODLBM7SenatpUvBJUUCXhE5pupOsMaIO
	QltbeWgfPXc301+sJyat3n2S2SAU+EjK6re7AI6/EfhOtphog2t11VKazKS3HLafOoTA/VGd5+dCn
	hfauAukatRNvzTlcYH/v3n6UM4ASDrRPmpldBbA0t6o8AaKkt4T5gUlzAeka8+9Zh0GNJymU7q96R
	EJ6iMYfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nogqp-005iV2-Rl; Wed, 11 May 2022 07:33:39 +0000
Received: from mail-co1nam11on2062b.outbound.protection.outlook.com
 ([2a01:111:f400:7eab::62b]
 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nogqn-005iTk-GJ
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 07:33:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwjLLMFFI5nq16o6fhHAz32JGuB134yhdeva01Q0hTf8kZGETtXUpZzriFRyRyclKiGL4GB8yBCnyIbDj60EL6pynSugPeT0cLIEkXssYjDcc8VXMhOEVSlgi8kLDE2w+XeAG90QPYlj5dalrIrq5kiA1UyfWgpCxwBCp0IEbvc/wq7lCDQHY/SEJMAjGribN6CXKF5k+8qZpGIf4d72P5g5VP8LidPnR9LLCiTmnSKVq+6PX76O5pw6tHBKDz6x5iOVjUYuqo2MPpbC2vXYoxJcZvSc1urDykKQfULdsWhpc14saIYMz9rW3nZoZQ3OO2/MW3SuprtPfX6ylcLL5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ThQsml2b94aXZl6Kutr6lqDrrWAYseblewuM3bWk4g=;
 b=eUwObM948HhgM1s+w+QNGwBf6Sd4HgKuOnZROSsWqlBj9MKiahWFLcaFAcjK9VsyDDyQvrr+k+FFSdggOdTY35h31V6ekejPQcyzyQLOqoUZdZDuEUH0hQdfBKbCw/aZ9Oz3NlFb5wW4nARCI22IYqDuz1nk9kVY0KQUjufEGYFSCvVLxuqTcp3U4zJ0Ydy3fPQ3NCSsZq8tOPVnkEyMlaf3kMJ3mPQ0/d42E9J4mdqLOX4LuaOwCr4jSzEooW9y+jZf0NGHmk4XcZ0y99ut4Zcdq+EnkVo9K7WX0WirdnK20UOpPmFbaqxkUXCsoFq0GJpi92V1qEf5e2DiF5OOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ThQsml2b94aXZl6Kutr6lqDrrWAYseblewuM3bWk4g=;
 b=ojhyuXbubLpF7HJYu1Zae1/OTg5WYN52xNyJYoeao8UjBY+wK6JgoTOyffOr7Ot4k+eOCC5dKzBXNI90p1z1ATirpJR7q7WrHe38J7MLY2NOD3LjoXd4i10xXp/VEaafyy+EWf4DbSD4euLGhWkZK+acjnUfna/ndCUfYxGw1RFPsnXb3VoHRkMHYfaDCLKFiek0QU8L01inS6rr3z/rCIfvf66rW8D8UMtScNm1/EG+ZdY1ymgUcuAP1IEY5yTZje9kYsZFi0+/RjDuNVnjIIPZSckyvxMutFAD+GrV1JAzfbXfio18BIy/m7Dk5XnTBFg0z80vbBh1B+Xj6nuB4A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR12MB1916.namprd12.prod.outlook.com (2603:10b6:3:112::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Wed, 11 May
 2022 07:19:19 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 07:19:19 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/3] nvme-core: don't check non-mdts for disc ctrl
Thread-Topic: [PATCH 2/3] nvme-core: don't check non-mdts for disc ctrl
Thread-Index: AQHYTVIa6YR5KcbjpkWDxqSgwxqmEKzqO8CAgABHEQCAAAY7AIAAFk4AgAAAvYCAAAfjAIAAGkuAgABtG4CALKJkAIABonOA
Date: Wed, 11 May 2022 07:19:19 +0000
Message-ID: <44da4ac0-4f22-0d6a-3cb5-bf70ab90cc0c@nvidia.com>
References: <20220411031249.5158-1-kch@nvidia.com>
 <20220411031249.5158-3-kch@nvidia.com> <20220411061301.GB14797@lst.de>
 <34d61434-27cd-f918-a3bc-fdca3196ef99@grimberg.me>
 <b5dd1bb3-e001-ac66-d461-4d699a2dadd6@nvidia.com>
 <d86c4a83-ac9d-f0b1-de41-5d411f5444f3@nvidia.com>
 <20220411121209.GA21711@lst.de>
 <63d1842c-35d7-e482-21c6-57cab24ae83f@nvidia.com>
 <YlQ3xWkZNKcMvvOU@kbusch-mbp.dhcp.thefacebook.com>
 <cb42edaa-a545-e7df-f9ed-fcb57caf9139@nvidia.com>
 <20220510062138.GA11163@lst.de>
In-Reply-To: <20220510062138.GA11163@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68f1dc20-2dc1-4bae-e23b-08da331e9086
x-ms-traffictypediagnostic: DM5PR12MB1916:EE_
x-microsoft-antispam-prvs: <DM5PR12MB19161CB56B9F67806CB77B43A3C89@DM5PR12MB1916.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +He9ZMe/EzwGVErQn5grUaflN9UXPSr2gUgRc1EW30S48K0N2XxygeUpzWrG1i4b20OPgxGFtClhZFnEXj5NPUrMky1Ay3Ld3QeRcwr/L50WJDGXJUAMEVd8nzFLbpgdVx7sZ5h5UXBKLuJXyhriWufplnsPrbMOBQU/7dbX/+wScDPuqbfxJanl5NEMAZH/B/5ANuYZyeHq6AR3vO8kXxCDsQhkiRVBVWFsc+vTMLERFj39CMD8ah8I0HB7+o+YMsVsB7xhM0Mpq2lG6Ajqptz6LFwHroJuEjBKc08+gU0jgNZo64Hw1a7rTjz7WsD6Ihyi4nOiumjq7pnMfkb4ZnjjOIV6Z7273CjlDtpthje/tfvcWBCazwcFTSURKGlmXUxN2n0uCoutNZ3mbCmdRZHhF/WEyIIAHYerGk76uNl38crZ8izd8SLk6JRcEQ7OIDKW4quN7Dv6HfCByyRvMhj818UjsYwtMSvntdhi2YWcJYoxqsZN6BRQnWx5HJgqbblpO3UBZdX8XqPB03d3VlYP3dlnTEWpPNa7l13R+8RL6cKwLcg2z9CSxfGq5h+Y88vCOPFxznwxNvLvV8UWSHnsQISKA0Qh5AFtKDfKlvJCjjbj4VmklzeSS1ucAO2UuKQIGnAN+Ny72/Dk1IDBouJ0sJaSdBdQM/beJp0FEsdNoVtz+LGNM9zBQ8P4qeh3KnSt18N1l3Agggg+kt/0s/+4DEoBiER+6NQuni3E/0x2Yj747DI5JsvCjyP6oGNSENrk9nLQ7yLDgfmRp0a6aA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(53546011)(71200400001)(508600001)(186003)(2616005)(6512007)(122000001)(6506007)(31696002)(86362001)(38070700005)(38100700002)(6916009)(64756008)(8936002)(4326008)(316002)(558084003)(66476007)(66556008)(66446008)(8676002)(31686004)(66946007)(91956017)(76116006)(36756003)(6486002)(5660300002)(54906003)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHlGRFFPVW9Bek9ITUhYV2RoNHprYiszbitkNlFrVTB0SVh3Rmo0bmlpSmlO?=
 =?utf-8?B?Q1JmdGJqR0hvcXZhOERtcHN4V3NiWEVFcStLdmJZWWNrLzlGYzRnVE1XcjBP?=
 =?utf-8?B?M3pqbFJ6clV6YTdIVTZSTXpCUURFMEp1TmZUajgwMzVvZXJBS2hCcjVBS2F5?=
 =?utf-8?B?cTVpQnczZHV1RWVuUVhGQkJZemh3S043Zm1DQXBYb1BFb3B6Qi9EN25ZdlVr?=
 =?utf-8?B?VjVlSHNhcERjMENZMGI4YlNvMGpRbmZpMURyZFhKRHFuUDZLeGNqcUdwSk0x?=
 =?utf-8?B?OHRrN1dCQlpUK1VhWHdiK3RQQ2ZLNnFvSG44L3ZZT1RlYi9MZDRLbEExdFla?=
 =?utf-8?B?QzE1VEl6VFgrdzdxR3l0czdGNGtTUUIzZlJzYkJaclNQb08xeWhXQjl4QWs3?=
 =?utf-8?B?WExiUWdBZVV4TVFvS09ISWRkK2lNNUI5UjhpbFdMSmVPNjRoZ245RGFmMk1Q?=
 =?utf-8?B?MkdXajY3ZnZWSFlZYUVya1pYS2VZbFNBMDE0TGdWcjlUVEhCNzZkamtOQU1w?=
 =?utf-8?B?dHRpRmJ1VTkvNFVCSXluTCtsOWtWZEg3OFJmcklBSXp0MGRaV2FWaldyb080?=
 =?utf-8?B?cVZHb3F5d2FHZ2x3VzEvS3BIOEMwVVBQcFM4cUhrbmVsQUFhaFlDVk1PZTM5?=
 =?utf-8?B?TEkvTjlzTzRPdVdWZ1VvVUE2M2p0ZFF1d1EzTXRnUUllbE1oenJwaE1nVkE2?=
 =?utf-8?B?WWZqM3ovcm9FMlp1c1UzTjNQTStxVks5M01SVExRMUdSWXhaaEttVmp2QWVn?=
 =?utf-8?B?WDdXeE0rWmR6OEsySXFQOHVpaG9vb3lGZUl3emtHUDVhdE0vN0ZxTlJtaWl3?=
 =?utf-8?B?SWJBNUtObEZTNVVyck1pdDArUi9xUktIbHFvam9PUjQ5ODlTTVd1dTJNWXJL?=
 =?utf-8?B?SmdmMy8reEJsNGpWYlV5L3Z3ditlbzhrUmNzL0dRVlhBY3A4NTk0aHUza1BG?=
 =?utf-8?B?MGR5Ym1JUlFVelRLNFZOenJxd3FtL3kzS2NkSG5MSk9zSjQ0a1p3Qk9IRDgr?=
 =?utf-8?B?UXpjem50dFJnQ1JBRU8vQUNELzY0NUJkSkw5Mlo1MHQxS1BGTkpka3hqdjRN?=
 =?utf-8?B?b2dvQUJLME5GTlhjMnFTanVJUDZscjBFcDYxbURTNStPNjQraThRQXNMUHVz?=
 =?utf-8?B?ZTZMY3BTQkhnbzRKR0pOVnVWY0s5TG14S2hoT1hmS0NYVkwxUkg2dUNLUzdn?=
 =?utf-8?B?RmduaEtybTRacHpSUDRyMkNmWmZiWEJpemRZTkV0cWJ6QkFRQ3A1QnZuTVhR?=
 =?utf-8?B?QTErQ200Q09iek9za243blZpSUNQUGtaKytFZXEra21ZMHFHV3Nybm1oTmJt?=
 =?utf-8?B?d3pvTVRzQnFRK1JUakd1SjMydTJtRzViWnd4UEFlTVBPOXBBL0o1ZHFMaWN4?=
 =?utf-8?B?a1JOV2VldXgvSmlMTGZ2dEJZY3kyVHpGbjJkT1M3M0VPRVlnQlJsS1lDQUpX?=
 =?utf-8?B?SmZUZm44SFNFeFVic3Fqb0toSGpUU2lwK09HUjVkM0xwQ3ByYlp6M1pDWEVZ?=
 =?utf-8?B?dVZUTS9WY1NydnByQi9FazhDT2VFQ25NTzJYUkVIc2lqOGVtMGVkMDVHMy9J?=
 =?utf-8?B?aXJnUUNhdmVZMUN6U0cxZmlkNFhUOTNDRDVxQ25waVFXYjVQeHFad3lkbHVW?=
 =?utf-8?B?VnVKd3RUVStieUREUGpzZGlWUWErMjFaVEgvdmQ1RzM5aXgvM0ZmTHJiNnRq?=
 =?utf-8?B?ZVdUM2dxMGZLZ3duNWJQUUJsSXJ2UzlHejdqVHRNTXdJaU01dzVXUFRmTi80?=
 =?utf-8?B?OWtxZEVPL2JNazV4dDVBZkdCZlJDeHBIOUdZeGhsa1oyM2U3YWhhcnowK082?=
 =?utf-8?B?VHZxeVd5OWFlQTRqS3lTbUZVR2xFY2dkb0pHMXptTkFneXlwbXcrTlhRNTRu?=
 =?utf-8?B?SWUzd24zVXY1a21mdmRPNm1odXNPK3VUT01BWTFmSE53TDI1VmtSTnliTkRs?=
 =?utf-8?B?MXMvVXQ4MUxkTU54aUd5NXhpWG5MdWZKTldYRGM3bnZndTRxRmN0MXNpWk0z?=
 =?utf-8?B?YWtXWUdJU0o2TU0yTTBOallOWk9XeUlyL1FRNlVoeUNHbEFzdnIxbE81YUF5?=
 =?utf-8?B?WklTc2luTi9PSEhWSGtTZnRLOStkOGN6WnhkZUZwblorK2JXSm1wUXhvT1hu?=
 =?utf-8?B?T3RscnkwZGQvMG1PamZOOFNCWFB1RGpwRUF5Y3J5Uy93RFM2QjM0cld4RlRR?=
 =?utf-8?B?eS9yeUVCVzRSMW91Z3F6ZTVndFl1aTdaRitVa1JBQjVweW0zdDlIZW1wQnVm?=
 =?utf-8?B?REh6bHF0YlUrYisveVh3TmdLQ05UNjRYVVNMaHFYYmtiMmt3eTRSZDVpVWJM?=
 =?utf-8?B?OUhzMlRmVGUwOENRRGd4WklZNW1lbVNYS3ZzdVRiYkRLMVJDWlo1cE0wZXdv?=
 =?utf-8?Q?FJxusJ9e7/8P5Jsvdl/G5sabBQfO+WT0S/kEr0AIH3/TI?=
x-ms-exchange-antispam-messagedata-1: ode5V1q29Vfobg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A278CF1D7AA76D4AA7458E50CAC813A9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68f1dc20-2dc1-4bae-e23b-08da331e9086
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 07:19:19.2672 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KG+0Dj8j9c55n/4Suc/UmvHokOZdqj8snFNPelGaH+shwX18FAbrriDrw3n9KCeMLg1bLF59kJNXmDQqkVEzTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1916
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220511_003337_575275_CE7B9A20 
X-CRM114-Status: UNSURE (   7.79  )
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

T24gNS85LzIwMjIgMTE6MjEgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBDYW4geW91
IHBpY2sgdXAgd2hlcmUgd2Ugc3RvcHBlZCBhbmQgbG9vayBpbnRvIGEgZml4IGhlcmU/DQo+IA0K
DQpZZXMgZ2l2ZSBtZSBjb3VwbGUgb2YgZGF5cyBwbGVhc2UsIEknbSBvdXQuDQoNCi1jaw0K

