Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E18CC46CD2
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 08:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5jteblCT0S32HSy7/ORHOIAYmzshW7idpx1tSR5rbdw=; b=TazIAnvA1Yi+2WWSRyGkMUBQQu
	Bu5zB/dxa+FSUZZWpXfIYUnpaR4FPDQQl4TYkO4x5lRuk9e0HVTjuE8LP+lcgQk88N7bvuM6bmlEP
	fTzbi879yBBD65iY2+qZ2wqz3Ok01exxh9QxqdYDUnLEnGpf52IYcefCT8P7lO9TYoJAIosjhqr6K
	BCXwT0YO5je7It0uJOp0lRWirmdQIX4QICCDYjNM00DmlcML+K19N3d0EIQ64iEyHILNkp6MooiaK
	diX0lVN8Zbwynxqb5TsjmbJMI+V8yy2z66DzlPzdQ4h5Vgl84ZbuCmH6rYVeZ7tOo2kzp8h3xj5HY
	8Ra8o42w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rF8sk-009SD8-34;
	Mon, 18 Dec 2023 08:21:46 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rF8sh-009SBu-2o
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 08:21:45 +0000
X-UUID: 77eab78e9d7e11ee958cff29c719f35b-20231218
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5jteblCT0S32HSy7/ORHOIAYmzshW7idpx1tSR5rbdw=;
	b=kqkcvQCDsATBafw2oks8yWREcPzp6hXqACHe0/NRBeHsSyeCDN3S6IDl728u7avu5e9kBapGObxuPX2sj0hCjj+0RZTZqIu+uBrnzlJrlZqlKTlSQxOucltZbf+6ilKBG+j8QGqMdcnNy5zRx/gui6D2jS7xNnnqMf9oE+yz9G8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:fd4ef538-88f7-496e-af46-71e423d70767,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:9d975261-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 77eab78e9d7e11ee958cff29c719f35b-20231218
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ed.tsai@mediatek.com>)
	(musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1097803200; Mon, 18 Dec 2023 01:21:39 -0700
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 18 Dec 2023 16:21:25 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 18 Dec 2023 16:21:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dg6Qk150MoxvCb5zFZ3pV5Oiwr0QVmvmLx/oYhHbk32UY3mVqDv+OgvcsONuNJdmbjytWKGtA6HCk5F//ERWKJSPxeMeMrGTe6VEvHSjf0ZQpaqx2GQm+DkO1is9DFDpRcXtprfmbcEFQrSERtbqgv4YOz7uhFx9Cipr4c4wUzGnHHBxBs+uO+6A1A7hAml0fDYimesJ6qygcjkOMfNl4fsxc/kLliim4OMbsSGnnTG7/+SW8J0xS2gRVZZBnVbR5RWa/LS2z/u9iKb1RbtjHk4a6LX52+PaUlayO3OU8C3u2RaCqKY7O5bWUhCMt48ZkCqX3CjYmcYskFD8qqt8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jteblCT0S32HSy7/ORHOIAYmzshW7idpx1tSR5rbdw=;
 b=FJJcboR3RItb+aOrwXJK3dXI0uvUcjlFRawCtE9zKNuJsGZarXrIHcRuSjoSbQxOhzAibLcS6nDwm2+88OIpjY7rDHokkBiKpccgPGtoSCmBDpqNqg0jpJQv6h2pr8pLoohctOcdhgFaS8SNJ/DLOC/lUNUjkh7lyp7Ag6VmkL8UqzRVlzPokW+0SZbX0fumtmAHi6Niz4YGJ7jFLXCWSxdhU4094JxHZyF6XOn7peklHLboADEyKNZ7eKM6f68XPScHM1JbxJKbCoS0r6C2W/d8g8ZvFi6/LzhXj/zgnnQTZet2jf9hXpqg7Q+34i3jLQsSLHPiH5HohE90PH6EJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jteblCT0S32HSy7/ORHOIAYmzshW7idpx1tSR5rbdw=;
 b=D+IxXJomuzKr7pXGX2ErJWLbVtBjoYDQn1Lp1bGG6u+hUQ1cjmPFtHAa0mcP2BCVczQCpf1Q7fOpOZxv3SsMbcygeyldT3nXwslH6RC62Lq5tuJ+/5ZIg4cxKpbZalDNgXDx8qjkD65O6fRpXGgvrXmz1HAdwMioEsAXoz0j8Bk=
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com (2603:1096:4:131::9) by
 TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.36; Mon, 18 Dec 2023 08:21:23 +0000
Received: from SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9]) by SI2PR03MB5545.apcprd03.prod.outlook.com
 ([fe80::d398:103e:796d:76b9%5]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 08:21:22 +0000
From: =?utf-8?B?RWQgVHNhaSAo6JSh5a6X6LuSKQ==?= <Ed.Tsai@mediatek.com>
To: "hch@lst.de" <hch@lst.de>, "dlemoal@kernel.org" <dlemoal@kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	=?utf-8?B?Q2h1bi1IdW5nIFd1ICjlt6vpp7/lro8p?= <Chun-hung.Wu@mediatek.com>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "stefanha@redhat.com"
	<stefanha@redhat.com>
Subject: Re: [PATCH 3/5] block: remove support for the host aware zone model
Thread-Topic: [PATCH 3/5] block: remove support for the host aware zone model
Thread-Index: AQHaMQnzmungF0TUfUKNyx6s0ULXRrCukLgAgAAK6ACAABiogA==
Date: Mon, 18 Dec 2023 08:21:22 +0000
Message-ID: <f19c41b9ea990e6da734b6c81caeebb73fb60b29.camel@mediatek.com>
References: <20231217165359.604246-1-hch@lst.de>
	 <20231217165359.604246-4-hch@lst.de>
	 <b4d33dc359495c6227a3f20285566eed27718a14.camel@mediatek.com>
	 <190f58f7-2ed6-46f8-af59-5e167a0bddeb@kernel.org>
In-Reply-To: <190f58f7-2ed6-46f8-af59-5e167a0bddeb@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5545:EE_|TYZPR03MB7153:EE_
x-ms-office365-filtering-correlation-id: 39095a42-c383-4899-a7b3-08dbffa251ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C3hmFWa0dqXj+ILB4sbNAPRQbB3dib1yxo0P4E6Bb0KeJfz8NzIHO4D/lvPra/wZJIjOfIhmah92Zki2fnXELf1zeXslNPUjEHNDkE56h+pfHafWo65YNlQeSEcFpwneDJ9ZpnEVUFcnS+FHouaFh987QkFUXN453QEGPNmgllX10GzK69Mt2o7KrzSHc6iEUxexSgsxDAxZqgAdq3o9l+4po4vGepM79PGnW/CIJMNY8NZIyDnUzpzYw3ziqLQuB/mQzPjSMVWE0bvUaxYwsmx+YwevWuWEQtfwlXpky5LH9UA/CynWbm4zk0J9SQ+yLSncda/VlW/Wnao7scvuZz2KJLanXyw7hqlTs615yF3YTNxw9/en5WrGuQRjG/dAh9CeAg22ktGXMaSIADMHK1EaIzeJ91SgBue3A7NBOsMKt1Z6Swm/HpvHP1jOUkWeDItJDwDibSwCeaEnuWlJcoNLLv1gvgqcdN+ESBQUo5CAks7LcTBdiLuXrOvpgBGrLKOF5BO06AyZFWzU7yfExmPAV4DE0ahgn6chAjrsRP3VRP+iqoWbCgxbLAp/UX08BZ7pJoZgdcm1aiUBrbSQ6yj85+k+O8zl1o8l7fFT0jYp3097z4SavMuUQM0ceCybMvVvW1Iw3tx6izGgRsRgG8RntoUAg4DvoSZM3TEE81PdciwFSPA/EQaPT24vYfE2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5545.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(71200400001)(86362001)(36756003)(85182001)(6506007)(53546011)(6512007)(4001150100001)(7416002)(38070700009)(478600001)(6486002)(83380400001)(122000001)(38100700002)(26005)(2616005)(41300700001)(5660300002)(66446008)(66556008)(66476007)(64756008)(54906003)(110136005)(91956017)(76116006)(8936002)(8676002)(4326008)(66946007)(316002)(76704002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFlRVTR1Ulh2RWx0MGFxYTFBM2pTVXJYb2lNTWJJZWFIS09ydzVHVFF0dGl5?=
 =?utf-8?B?cEg3SnFycmZ5YU5BbzlYRUpjWDRaMGVsdE43c2ZhSTFMMGFXTmo5azNXbmdL?=
 =?utf-8?B?YkNaWWEwKzlwd1MxNzk2K0s4QVJsbzlTOG9lWDhBSVFHRHdiR1hWWUxCaVBX?=
 =?utf-8?B?S0hJVVNLdkw5a2VZV2wzVGx4UWpINWNXSFBYUFpQT1hYbW9SMlRkV0JJM2h4?=
 =?utf-8?B?d0ZJVkJpUnVCK2Z4N0xZRW04ZUxEejhLMi82UVdMNnhGaENudVowS3JpUG9h?=
 =?utf-8?B?QzJHbElBMmRNOXo5b01FYmVXRkNOazNLckNHMWwrZTJ4VGFqY2R4Z1pLT3pH?=
 =?utf-8?B?djBqMlpCR0dLN01YNXVrSXlvZHV0Wk9qcmZiaWwyWWJYVUt6cXpIMFEzanRR?=
 =?utf-8?B?aW9scWJtVktENmxiMUppTTI3dXJvclByMGtxbHlwRDhlNG9tR1VRSDhhczQw?=
 =?utf-8?B?ZGY5RDUyWEc2azFTMlBpZy9weVAwcmdTNWEyTzA2TEFocDlYbW5jSy9yaGtk?=
 =?utf-8?B?STJ5MG02ZUF3bFkwdUZaNGhkN2IwdG1YY0hSM05wbG5za2ZZenFYdGNqUWJ6?=
 =?utf-8?B?QTE4UXcveHVxdlMwblpoSzloa3pzRVJhVml0dkZHdVEzaUVHOXpIdFdNYmJj?=
 =?utf-8?B?NkVkODhUenBXRkZpTThLR1JoTjdMaysweGJ5eXlKcDJhSTJVbXpudkVLVzBN?=
 =?utf-8?B?bG44WWFlUWNkbnJwd2hQRldRaVRQUlMxYjhBc2lOL3c3UDNzOXBPOU00TmI4?=
 =?utf-8?B?N0VscHBoeXJaY012dXlPb2oxcUlKcHdqVHU1VkNWOWZFZ0Jyc2I4WHhCcmhq?=
 =?utf-8?B?R0loQVJBWkJDa0hlcjNqSzhIUGhDaGlQWW9CWlFodExVcDJpQkM4NzdLN2I1?=
 =?utf-8?B?QkZqTnlKM2tyU3lRRUZqVWVCVHhpUVQ2NGdXNUJCSWdaY0lXWHcwb1VuS29M?=
 =?utf-8?B?YXNRTm94TEZyaUk2WkMrWjZ1VXdVTkFhS21aQW9Pb0dCL2h4KzIxeTA4Rm1Y?=
 =?utf-8?B?RGl1Z0JyQlVCaTFjOU9XUlZCeTNWOFAxd09HcW85Z2ozS2x2RlQ1TUs0bVJl?=
 =?utf-8?B?bGF0dGpsSFNaQnpOU09haVAybVBUeEFGOStaU0Zkb0JpaUZhcmxXYmptaTc3?=
 =?utf-8?B?c242eS92anlRTEI0MUJIbmxIWFBzNUFBalJrRkRSMW8ySzNUT2plMUx4aFlJ?=
 =?utf-8?B?WDlyOEtaL0Y2M2FNYnV2Z0M3UndLdVZzaXJjZ3BJMlZQNnlrUDRWVU5rTFY5?=
 =?utf-8?B?UVhGdFZ2eWRIc2VJbGRobnRlUzgyY2pwME1xZXo2M2ZzUlNxT0RTQkQrb3lI?=
 =?utf-8?B?UHBYdllERUZkaG15SDFZTUJ0UW5nVXdTbit1N0xLWSs0Q2huSTAxZXh5ZzdK?=
 =?utf-8?B?b3c0K3h2c3NDS1liak43R3pIbC9wK0VuOWpMaU1OcVBSZXpWemlHdkQ2V3lG?=
 =?utf-8?B?eHBXRWM1SzlUdnZIdkx4OU1EYlFzRmJlT2RrdHhVUUJMOXRZZUxZZ24yN3NV?=
 =?utf-8?B?N29UUFlTRWtmN21LNGpqczJTb0p2dGphNlR0VmxaakNXNDFuZHNjalE3V3Ex?=
 =?utf-8?B?bWVoZVZEQUJDRklnWkNxaHFHQWJINzVuSGhUdVJnVVVNRVpEY2owV29TMWhm?=
 =?utf-8?B?dzQ1K1dvWmEwUW96SGFLVVppVUZJdE80VlE2VHNBMmxWQjY3SU9rSEhFTDBS?=
 =?utf-8?B?SDZWMG5KRDZxS2JOaXlPZ25SbTA3ZUIxYTJoR1pKN3N5RGJvbGtXVGtRellF?=
 =?utf-8?B?NGtDMlptd3JKZXB5emNGZ1ppNFA0OTVhYUVYamU2U0lIRDdOWXJwMHZJa2Ry?=
 =?utf-8?B?b3AyNHAyN3ErdU1UMEEvVWVRMkYzTEhNTmZrZHN6dHkrcGZXTlpCcDRwbndl?=
 =?utf-8?B?L00xMWdVLzhSQWZ3aFFyVU1nMVBIRDF5R2F0S2Q2bEt3SytjdkJkdnoxNGVx?=
 =?utf-8?B?MXhTaXhXRlM3eXlBd1prVEpGVjJ1ajE4dzloS2dLblRKVjA5YXRJRllCUThm?=
 =?utf-8?B?OFlzSHVJSlVGNGE4cjNwOGV0elhlMFVHRHMzZEZteVlTTmRTVFMzYld5Ymh0?=
 =?utf-8?B?aENYZlVvME0yT2E2QWlFenVUajExcWVzbTkrMlJMV3dNbExRSGdYQ3RuUWpB?=
 =?utf-8?B?TldvZGY2bXo0dVBsYXRIdHhUMFp3SklyalhVTHl5cGc5VUMybFV2U2VxN2ZC?=
 =?utf-8?B?b2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C35C0714C198A14AB0F355450D6A7BD8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5545.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39095a42-c383-4899-a7b3-08dbffa251ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 08:21:22.3046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 22NrNWH+XIVLpCSKI5f4WCueMj7DcmKYrWl7BD5LUhFeS4IAIz8xAh4NeF3neCwYPKtnx77GImHmfbw8S5vCeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7153
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_002144_011601_AA8C7A3E 
X-CRM114-Status: GOOD (  24.83  )
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

T24gTW9uLCAyMDIzLTEyLTE4IGF0IDE1OjUzICswOTAwLCBEYW1pZW4gTGUgTW9hbCB3cm90ZToN
Cj4gIE9uIDIwMjMvMTIvMTggMTU6MTUsIEVkIFRzYWkgKOiUoeWul+i7kikgd3JvdGU6DQo+ID4g
SGkgQ2hyaXN0b3BoLA0KPiA+IA0KPiA+IHNvbWUgbWlub3Igc3VnZ2VzdGlvbnM6DQo+ID4gDQo+
ID4gT24gU3VuLCAyMDIzLTEyLTE3IGF0IDE3OjUzICswMTAwLCBDaHJpc3RvcGggSGVsbHdpZyB3
cm90ZToNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWQvZG0tdGFibGUuYyBiL2Ry
aXZlcnMvbWQvZG0tdGFibGUuYw0KPiA+PiBpbmRleCAxOThkMzhiNTMzMjJjMS4uMjYwYjViOGYy
YjBkN2UgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbWQvZG0tdGFibGUuYw0KPiA+PiArKysg
Yi9kcml2ZXJzL21kL2RtLXRhYmxlLmMNCj4gPj4gQEAgLTE1NzksMjEgKzE1NzksMTggQEAgYm9v
bCBkbV90YWJsZV9oYXNfbm9fZGF0YV9kZXZpY2VzKHN0cnVjdA0KPiA+PiBkbV90YWJsZSAqdCkN
Cj4gPj4gIHJldHVybiB0cnVlOw0KPiA+PiAgfQ0KPiA+PiAgDQo+ID4+IC1zdGF0aWMgaW50IGRl
dmljZV9ub3Rfem9uZWRfbW9kZWwoc3RydWN0IGRtX3RhcmdldCAqdGksIHN0cnVjdA0KPiA+PiBk
bV9kZXYgKmRldiwNCj4gPj4gLSAgc2VjdG9yX3Qgc3RhcnQsIHNlY3Rvcl90IGxlbiwgdm9pZA0K
PiA+PiAqZGF0YSkNCj4gPj4gK3N0YXRpYyBpbnQgZGV2aWNlX25vdF96b25lZChzdHJ1Y3QgZG1f
dGFyZ2V0ICp0aSwgc3RydWN0IGRtX2Rldg0KPiA+PiAqZGV2LA0KPiA+PiArICAgIHNlY3Rvcl90
IHN0YXJ0LCBzZWN0b3JfdCBsZW4sIHZvaWQgKmRhdGEpDQo+ID4+ICB7DQo+ID4+IC1zdHJ1Y3Qg
cmVxdWVzdF9xdWV1ZSAqcSA9IGJkZXZfZ2V0X3F1ZXVlKGRldi0+YmRldik7DQo+ID4+IC1lbnVt
IGJsa196b25lZF9tb2RlbCAqem9uZWRfbW9kZWwgPSBkYXRhOw0KPiA+PiArYm9vbCAqem9uZWQg
PSBkYXRhOw0KPiA+PiAgDQo+ID4+IC1yZXR1cm4gYmxrX3F1ZXVlX3pvbmVkX21vZGVsKHEpICE9
ICp6b25lZF9tb2RlbDsNCj4gPj4gK3JldHVybiBiZGV2X2lzX3pvbmVkKGRldi0+YmRldikgIT0g
KnpvbmVkOw0KPiA+PiAgfQ0KPiA+PiAgDQo+ID4+ICBzdGF0aWMgaW50IGRldmljZV9pc196b25l
ZF9tb2RlbChzdHJ1Y3QgZG1fdGFyZ2V0ICp0aSwgc3RydWN0DQo+IGRtX2Rldg0KPiA+PiAqZGV2
LA0KPiA+PiAgIHNlY3Rvcl90IHN0YXJ0LCBzZWN0b3JfdCBsZW4sIHZvaWQNCj4gPj4gKmRhdGEp
DQo+ID4gDQo+ID4gU2VlbXMgbGlrZSB0aGUgd29yZCAibW9kZWwiIHNob3VsZCBhbHNvIGJlIHJl
bW92ZSBoZXJlLg0KPiA+IA0KPiA+PiAgew0KPiA+PiAtc3RydWN0IHJlcXVlc3RfcXVldWUgKnEg
PSBiZGV2X2dldF9xdWV1ZShkZXYtPmJkZXYpOw0KPiA+PiAtDQo+ID4+IC1yZXR1cm4gYmxrX3F1
ZXVlX3pvbmVkX21vZGVsKHEpICE9IEJMS19aT05FRF9OT05FOw0KPiA+PiArcmV0dXJuIGJkZXZf
aXNfem9uZWQoZGV2LT5iZGV2KTsNCj4gPj4gIH0NCj4gPj4gIA0KPiA+PiAgLyoNCj4gPj4gQEAg
LTE2MDMsOCArMTYwMCw3IEBAIHN0YXRpYyBpbnQgZGV2aWNlX2lzX3pvbmVkX21vZGVsKHN0cnVj
dA0KPiA+PiBkbV90YXJnZXQgKnRpLCBzdHJ1Y3QgZG1fZGV2ICpkZXYsDQo+ID4+ICAgKiBoYXMg
dGhlIERNX1RBUkdFVF9NSVhFRF9aT05FRF9NT0RFTCBmZWF0dXJlIHNldCwgdGhlIGRldmljZXMN
Cj4gY2FuDQo+ID4+IGhhdmUgYW55DQo+ID4+ICAgKiB6b25lZCBtb2RlbCB3aXRoIGFsbCB6b25l
ZCBkZXZpY2VzIGhhdmluZyB0aGUgc2FtZSB6b25lIHNpemUuDQo+ID4+ICAgKi8NCj4gPj4gLXN0
YXRpYyBib29sIGRtX3RhYmxlX3N1cHBvcnRzX3pvbmVkX21vZGVsKHN0cnVjdCBkbV90YWJsZSAq
dCwNCj4gPj4gLSAgZW51bSBibGtfem9uZWRfbW9kZWwNCj4gPj4gem9uZWRfbW9kZWwpDQo+ID4+
ICtzdGF0aWMgYm9vbCBkbV90YWJsZV9zdXBwb3J0c196b25lZChzdHJ1Y3QgZG1fdGFibGUgKnQs
IGJvb2wNCj4gem9uZWQpDQo+ID4+ICB7DQo+ID4+ICBmb3IgKHVuc2lnbmVkIGludCBpID0gMDsg
aSA8IHQtPm51bV90YXJnZXRzOyBpKyspIHsNCj4gPj4gIHN0cnVjdCBkbV90YXJnZXQgKnRpID0g
ZG1fdGFibGVfZ2V0X3RhcmdldCh0LCBpKTsNCj4gPj4gQEAgLTE2MjMsMTEgKzE2MTksMTEgQEAg
c3RhdGljIGJvb2wNCj4gPj4gZG1fdGFibGVfc3VwcG9ydHNfem9uZWRfbW9kZWwoc3RydWN0IGRt
X3RhYmxlICp0LA0KPiA+PiAgDQo+ID4+ICBpZiAoZG1fdGFyZ2V0X3N1cHBvcnRzX3pvbmVkX2ht
KHRpLT50eXBlKSkgew0KPiA+PiAgaWYgKCF0aS0+dHlwZS0+aXRlcmF0ZV9kZXZpY2VzIHx8DQo+
ID4+IC0gICAgdGktPnR5cGUtPml0ZXJhdGVfZGV2aWNlcyh0aSwNCj4gPj4gZGV2aWNlX25vdF96
b25lZF9tb2RlbCwNCj4gPj4gLSAgICAgICZ6b25lZF9tb2RlbCkpDQo+ID4+ICsgICAgdGktPnR5
cGUtPml0ZXJhdGVfZGV2aWNlcyh0aSwNCj4gPj4gZGV2aWNlX25vdF96b25lZCwNCj4gPj4gKyAg
ICAgICZ6b25lZCkpDQo+ID4+ICByZXR1cm4gZmFsc2U7DQo+ID4+ICB9IGVsc2UgaWYgKCFkbV90
YXJnZXRfc3VwcG9ydHNfbWl4ZWRfem9uZWRfbW9kZWwodGktDQo+ID4+PiB0eXBlKSkgew0KPiA+
PiAtaWYgKHpvbmVkX21vZGVsID09IEJMS19aT05FRF9ITSkNCj4gPj4gK2lmICh6b25lZCkNCj4g
Pj4gIHJldHVybiBmYWxzZTsNCj4gPj4gIH0NCj4gPj4gIH0NCj4gPiANCj4gPiBUaGUgcGFyYW1l
dGVyICJib29sIHpvbmVkIiBpcyByZWR1bmRhbnQuIEl0IHNob3VsZCBiZSByZW1vdmVkIGZyb20N
Cj4gdGhlDQo+ID4gYWJvdmUgMyBmdW5jdGlvbnMNCg0KVGhlIHR3byBmdW5jLCBpcyB6b25lZCBh
bmQgbm90IHpvbmVkLCBhcmUgZXNzZW50aWFsbHkgdGhlIHNhbWUuIFRoZXkNCmNhbiBiZSBzaW1w
bGlmaWVkIGludG8gb25lIGZ1bmN0aW9uLg0KDQo+ID4gDQo+ID4gQWRkaXRpb25hbGx5LCBiZWNh
dXNlIHdlIG5vIGxvbmdlciBuZWVkIHRvIGRpc3Rpbmd1aXNoIHRoZSB6b25lZA0KPiBtb2RlbA0K
PiA+IGhlcmUsIERNX1RBUkdFVF9NSVhFRF9aT05FRF9NT0RFTCBpcyBtZWFuaW5nbGVzcy4gV2Ug
Y2FuIGFsc28gY2xlYW4NCj4gdXANCj4gPiBpdHMgcmVsYXRlZCBjb2RlLg0KPiANCj4gTm9wZS4g
VGhlIG1peGVkIHRoaW5nIGlzIGZvciBtaXhpbmcgdXAgbm9uLXpvbmVkIHdpdGggem9uZWQgbW9k
ZWxzLg0KPiBGb3IgdGhlIGVudGlyZSBETSBjb2RlLCBITSBhbmQgSEEgYXJlIGJvdGggdHJlYXRl
ZCBhcyBITS1saWtlIHpvbmVkLg0KPiANCj4gLS0gDQo+IERhbWllbiBMZSBNb2FsDQo+IFdlc3Rl
cm4gRGlnaXRhbCBSZXNlYXJjaA0KDQpUaGFuayB5b3UuIEkgaGF2ZSBzb21lIG1pc3VuZGVyc3Rh
bmRpbmcuIFBsZWFzZSBkaXNyZWdhcmQgaXQuDQo=

