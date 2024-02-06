Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691B1C48286
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 07:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pno1mJLK4hJFzMxrRpTtMFX7OqhB2tvZcqRBxh0Gwho=; b=KUWwMfVRw6opnqFJgBkGB9Zgoz
	9pbWqW0jW42B7IlRKbSFn6837exBj0Wp0fUF9zCZoeXLYkgMwZWf13EkYC6898f0Vmbb0Az7xEFKZ
	flFfUmIsD5ltyl+S3pc7j0jyBckBWA4tiLHsPj2O7PC0PRWYObaPd640HpaL8+9GEelKdpTLTZs95
	Sha4Z3NVFMjVHymo/DoVasJhW8PwSiB+o7FZ/MBWA0HZvJ0QIjH8F6i1/rbNjRZiMIix02aCuT4Px
	zkQYLhADJDzdATcPCssdLYu3wrwb0t+RLnJVuS5PiwxQ2Mazo6qaKZlW14MJo4CUH4xz/qcohxtvu
	d8Q8BRfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXGM4-00000006MOm-2HZV;
	Tue, 06 Feb 2024 07:58:56 +0000
Received: from mail-bn1nam02on20600.outbound.protection.outlook.com ([2a01:111:f403:2407::600] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXGM2-00000006MNd-1HAH
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 07:58:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgZJxOiR2aLuSuby2pSPofGcxYrL+ns9aITbfxN7s7/GA0uL7zhQJsweRY8M3EZQspcxHqawoicJZbGco+dflpq9t91h5rptmEldn4TzFAfouq23iUk0OJR9FARGe/iSbEcnZPQafShorzM8Dw6PBlcdrtZIKAqqFK+hu0BZYTBbZECJ0QUj2AA7rSVemnaQx7hmNhPNUYGA1j3lABd4Z8Q/iZTwRm3iMa6XA7RhGP4quur072rD6PNUYlNYB56f1XK6qZKGYGVPEaj5xnjVAJ7/AHMHlV6bQT2dBRyRMZgJug0DZBu8cXqqrIKMfFTiur6eSJ5P4pCu2wTZ6ZFQrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pno1mJLK4hJFzMxrRpTtMFX7OqhB2tvZcqRBxh0Gwho=;
 b=X1UyxV57clgRegUHLTZUNgaVWuirN/kjXeOMZWraXaoQ0F8Ko6+W6IJebMJK8zlsDhVj82IYROnOrY4f7We6MAl31IRB8jIJWiWQSMSZLP2Qn303Wpa6qLewKqCc97isYHsIyM6z4bnTwG4cIsv4QLfOWvXKuUWLbxtkyr7OmoP8ADGW6jORFm+ir/4zY3VeClNKbu0Xtey6yQsiGu0B2B2R7E1MlS2WsiGouRfYcSByiKke/f2ExxMLDd9mpGjNXYvnH/CE8bWbRQw6u0h13Avoo4Z5KTpidIWD6FlbIDfqykCeacttB5NuwBxFDtrH8h5HIUVzF7Y/7Vh5hhBY3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pno1mJLK4hJFzMxrRpTtMFX7OqhB2tvZcqRBxh0Gwho=;
 b=rTpSvoB4RpQVqW57blBYpOyRBPg02hKAAqCKodyQRpyiEN8cKo/TbVXK9sVsHXtWwGzLCRQ6ghp5TtWm7EUSSE6Dy9w2bBnV02GvQ1Tbfyk02O51TQfKPwmk0parhIxNaSW/cQHiHUcdsdjPG0ca7BpmkZCYoiml3bxmhOld/2ksiKCV22BCfAr1qrsZ1KoY72dIEL0cBJ/iXQbPjbouuQqY2UEddvJjeePEy768CobpuSfeSlSQGrV3HSd+QENrwbFqcnp1BA7zPAeR8HBJJU8JdwVUa87eXSnlCNSoQhfhumqmHwPGtgFKjtKH/8CxaMuMSNKNNaGbmuwF31EFIg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 07:58:45 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 07:58:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	"hch@lst.de" <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: implement support for nvme relaxed effects
Thread-Topic: [PATCH] nvme: implement support for nvme relaxed effects
Thread-Index: AQHaWGgxalKD9zrmkE+IrxCCZGGDXrD888wA
Date: Tue, 6 Feb 2024 07:58:44 +0000
Message-ID: <3c8443fd-fd61-48ef-b4a3-0e6545990140@nvidia.com>
References: <20240205191703.2990948-1-kbusch@meta.com>
In-Reply-To: <20240205191703.2990948-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB7740:EE_
x-ms-office365-filtering-correlation-id: 4c8163fd-c3aa-4585-1fac-08dc26e97129
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FI1nq0XgUJOlVjWtgn4IQRkYihTlxmnrIjaCtonh3EM779yjycPPFXdepGg8Gw9DVu1nb3MfklUD5qvN7BrB9h/cqG2JE8jE2esymgQCI2/gg+1DE1Vx1KG31ra6+AwHCPvPiSrGe3ZIdYO9TEF6gZLxGi5DF88ZWMTmYRYJ9OLN3Qgj2RraV155n3OHLecBItlx4r486uVJcTJ+QqFA0t6v7T1O/XMTUVYqhsK9Jf59GxrIl1D6vpeNUf5zNMLuwlNSCrrYjWXS3ZqX0Hlt8vXWzHRR9Cko3BscIQFIrFR3acdlcAPRc9UhUxOO3GUW4pGjuob91cKf/ry8fne83oUYiwWmN81Mq+ZSrxSQ+VQnmqo2Gj1BSOmO+oEUEq48DVDOQKIysNXrs3ymU41urZsHJMTg2fAuHEIv37wc31q5MYjNhEK5rQU/td7Hi6b68tOGUh2UhPsG8QcnpqeQ8c2iLgEffpC7NlN+rlWuhj3f+FWtPqDvXpjE4gNQAezMAislH1BsNrdNoJAx78oIYDjjA10EiSq7U6FkT1sQ1rrPB7likkIysYVPU7J44EWcyt/tNynl9Ao43Cx1Q1dNaf1AbrSNhfV4OaK6x7ZTv26o59whdpaD8UPXylDpEbHpq8vAH94T6Do9xh3Ig/02OOdHAdvMDUvGvbfv6d/UR7I0iw78p1hrNyemiQp7GXeT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(6512007)(478600001)(53546011)(31696002)(6486002)(86362001)(36756003)(38070700009)(83380400001)(41300700001)(2616005)(6916009)(316002)(66556008)(8676002)(2906002)(6506007)(91956017)(64756008)(76116006)(66446008)(66476007)(122000001)(66946007)(71200400001)(8936002)(5660300002)(54906003)(38100700002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUNXSTFzT1gxTis5OUE5NUpJYXhTNFptb3BjK2VzY0YrcHBIaDNMK2s0U0Rn?=
 =?utf-8?B?by9laGFDL2JuMHJYaTRuSEdyOE1QNVZZK3FrT1oyb1BOeE53TXhHUWY4ZkZT?=
 =?utf-8?B?ZitMZHFJMWEzdnY3OXFYTVRvenlvcEtkWnV5cFhEVDV2V1VXcDdrUC85Z2pv?=
 =?utf-8?B?RnIwbUtiQUtsaHR2MjROVnkyU1lwcXAvU3ZsYVgvSXg4VWplb04vcUZSa3RS?=
 =?utf-8?B?KzhQWTd0UVh4SDVud0gvNE1BbndaT3FMRFZvU2dHNXgvYXZYWmlWMG4wTk5F?=
 =?utf-8?B?dGM3WWMzQ2RxMU05UGoxSUpOaTV1N0ZWMmgwNFhBUVV3VDZFVFN3VzJweU82?=
 =?utf-8?B?cnJxL1JlRDJGZ1k5TU9NQ3FoLzA3RERPN1MvSUlGamdFeWlON21rdVpQQW1E?=
 =?utf-8?B?NVpKQWRaekY0NXJlUEZ1dGd1WUM3TEw4bWpMcDNQS1pMVjZzWFlhcHg5TThj?=
 =?utf-8?B?WXFHbGxoNS9DbE1SYW9rUWx4cHAvZStJL3ZHdWxIWEdCTzZFOGNYQmJLeUdn?=
 =?utf-8?B?YTNTVjdtRU9zdVU5eW55ZCtQU243TlNMdkdxQ2lLcFIyZVY0VzJSNUFxUVRv?=
 =?utf-8?B?RzlZNFdpK2FYb3lMemYyaTJjZ2RBd1YxeU5kNXd2Q0JmMWROTUZSQnBMaTBI?=
 =?utf-8?B?Y0dBalpvQmt2c3c3RUh6M2w2cEpDQVN1WS94WVlXYk42VGN3eXFuaEdEeXpS?=
 =?utf-8?B?V1p5dk9vMTJZTGJuT3loUVhnNWhTZm1MaDhRSzl6VVRHdTdiRENqbFdvSjcw?=
 =?utf-8?B?czRhYWRGMCtXM1FhNHM4bXNkQ2l0RzgrMHFDRDVEb0VXcGlnbE9QMjJHTW1h?=
 =?utf-8?B?Ui8yL2grd0tLN1BaODhlSzlUYnlqK3d5TFoyREpVVXMrR29DRVQ0dmZSSkNs?=
 =?utf-8?B?WS93Vnc2RzZ5NmwwN0FYbjJMdmUySEtkMm5rWGkxWHNxdURsWWZmK3dKOTJn?=
 =?utf-8?B?dXRXa1A3RG55SDZQOU5RRm9sdjQyU1FBZUV3WlBPbThJV3JKWTNhcUxpc09t?=
 =?utf-8?B?VTMxVS9xV1N3MlN4cFVZSHNnR2lzejFWeEc5WmRQVTlHdnJ4R1lNQW5yc1A3?=
 =?utf-8?B?YURKbzhzazVtalpKTThiTjhpMlFBVmJzQ1JlRk16TFVKaVVaRlMzSmVkUWhx?=
 =?utf-8?B?ckJZZThBRE8zM3VDL3dadFV4Z0tpSWlzN2IyYmh5bXVNdXpRcTFzQ01pZjJS?=
 =?utf-8?B?TFVtWmVNc0R4TThyMFN2V2NiVitlMlBTUkZXektXREYzYjdjV25JWk8vYUoz?=
 =?utf-8?B?cHNsRXEyZno2V1VUaER3SUUzNHNxRnVnbm9ONnVvdEtnWXNQRFRYSlVtaTZZ?=
 =?utf-8?B?bHFxY2pKelJqV2VTTXF5cDB6YXZMRDBPVUhSbUNwOElIbWpTeW1oVWZYYlNx?=
 =?utf-8?B?cnZ3L29VdDJORXZSQ2h1OVdvTnp3R0ZSMERTeDlhekV0MCtzUjgvL1hibDF4?=
 =?utf-8?B?M2RwRU9CRE5hN01YZWZRYlZKTXFSVXZRd2N4QU1EWmN5NnZ5dTUxUFlFQ09U?=
 =?utf-8?B?a0NJcC9KS2JhNHlnU3Yvei84K1U0R0NncE5UUnJPbE9hRmtIOFZlZzZ3YTQy?=
 =?utf-8?B?MThHeFlZaWVFTm9kTkNtUXlpVy9FMk13ejBDYjNyaTVMbnhjcGNUUnMrZkFT?=
 =?utf-8?B?cm01MEV3STVLUUNGemk5TDBnTnZudzN0Z1gyTUI2aVBpajVhK3JsUHFhbUNM?=
 =?utf-8?B?MURDaDQ5amhSZGtPY05RTTdzdW5LYjlzWDBWSVVQL2x4aWFPYzlPTlU3cXhi?=
 =?utf-8?B?bVo3cEY1TTZaNTJkQ3BUZlc5aDczVUxnZW1lRmRQYUNBNW8yVitGNW82cTZh?=
 =?utf-8?B?SXlCYi84SmwySGFYb0xOWXBWQjZRZDVVMjNhZXNaQVdlRDVBSzI5aTFIMDRZ?=
 =?utf-8?B?TnFCZkQ3U2pTem5RTm5YUXk0NjJyVEJTZEZSMlJPMWJwZjVKM2Z0WlE1VFRD?=
 =?utf-8?B?bU82K3Zudm90SEM5SlA0WjdDM1J1WVZqdFVVUVhwK21ZU0FtTTB5bzkrQ096?=
 =?utf-8?B?bDB1WE5XVlA2ZlBxQnYyZDZvUlZpTU9uVklnUU9pNWE4bi9sdjRrRFdLWXc0?=
 =?utf-8?B?VU9uc3k5VDhxbGJRVVhrWm5zVVFxWjlIY1NpNktNR01OWFdudDhuUkwrVWo5?=
 =?utf-8?B?QU1KdHRzcWhDS01lVFNuNTdYKytNdFUrbmlhKzhqNS9mQXIzMWI4ajE4dWpS?=
 =?utf-8?Q?5jhrlCA93U59dZ80waud6dMIXIHBANbjKsgg2FkjGdzm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C1A5766E2B9A7418FDFD52D44F9AE9E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8163fd-c3aa-4585-1fac-08dc26e97129
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 07:58:44.7369
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3YmRv1ZNOEaQKN2KSA4DD6JIdpyFaANGE/WtbOA9QYhiXFAUH4T1ruxgB2PGzezLWH65s32ph4/PjwZ4VoZmTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_235854_380646_4F089F9F 
X-CRM114-Status: GOOD (  18.82  )
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

S2VpdGgsDQoNCk9uIDIvNS8yNCAxMToxNywgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtl
aXRoIEJ1c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gTlZNIEV4cHJlc3MgVFA0MTY3IHBy
b3ZpZGVzIGEgd2F5IGZvciBjb250cm9sbGVycyB0byByZXBvcnQgYSByZWxheGVkDQo+IGV4ZWN1
dGlvbiBjb25zdHJhaW50LiBTcGVjaWZpY2FsbHksIGl0IG5vdGlmaWVzIG9mIGV4Y2x1c2l2aXR5
IGZvciBJTw0KPiB2cy4gYWRtaW4gY29tbWFuZHMgaW5zdGVhZCBvZiBncm91cGluZyB0aGVzZSB0
b2dldGhlci4gSWYgc2V0LCB0aGVuIHdlDQo+IGRvbid0IG5lZWQgdG8gZnJlZXplIElPIGluIG9y
ZGVyIHRvIGV4ZWN1dGUgdGhhdCBhZG1pbiBjb21tYW5kLiBUaGUNCj4gZnJlZXppbmcgZGlzdHJ1
cHRzIElPIHByb2Nlc3Nlcywgc28gaXQncyBuaWNlIHRvIGF2b2lkIHRoYXQgaWYgdGhlDQo+IGNv
bnRyb2xsZXIgdGVsbHMgdXMgd2UgZG9uJ3QgbmVlZCB0byBkbyB0aGF0Lg0KPg0KPiBTaWduZWQt
b2ZmLWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiAgIGRyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYyB8IDQgKysrKw0KPiAgIGluY2x1ZGUvbGludXgvbnZtZS5oICAg
ICB8IDEgKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+DQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMNCj4gaW5kZXggOTc1MjQ1NTI3YzFmYy4uNzU5MjdlODU3OTg1NyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
Yw0KPiBAQCAtMTE1Myw2ICsxMTUzLDEwIEBAIHUzMiBudm1lX2NvbW1hbmRfZWZmZWN0cyhzdHJ1
Y3QgbnZtZV9jdHJsICpjdHJsLCBzdHJ1Y3QgbnZtZV9ucyAqbnMsIHU4IG9wY29kZSkNCj4gICAJ
CWVmZmVjdHMgJj0gfk5WTUVfQ01EX0VGRkVDVFNfQ1NFX01BU0s7DQo+ICAgCX0gZWxzZSB7DQo+
ICAgCQllZmZlY3RzID0gbGUzMl90b19jcHUoY3RybC0+ZWZmZWN0cy0+YWNzW29wY29kZV0pOw0K
PiArDQo+ICsJCS8qIElnbm9yZSBleGVjdXRpb24gcmVzdHJpY3Rpb25zIGlmIGFueSByZWxheGF0
aW9uIGJpdHMgYXJlIHNldCAqLw0KDQpub3QgYSBibG9ja2VyLCBidXQgSSBmb3VuZCBmb2xsb3dp
bmcgbXVjaCBjbGVhbmVyIGFuZCBlYXN5IHRvIHNlYXJjaCBpbiANCnNwZWMgOi0NCg0KK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKsKgIENvbW1hbmQgU3VibWlzc2lvbiBhbmQgRXhlY3V0aW9uIFJlbGF4YXRpb24gKENTRVIp
IHRha2VzDQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICrCoCBwcmlvcml0eSBvdmVy
IENvbW1hbmQgU3VibWlzc2lvbiBhbmQgRXhlY3V0aW9uIChDU0UpLg0KK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAqLw0KDQpidXQgaWYgb3RoZXJzIGFyZSBva2F5IHdpdGggb3JpZ2lu
YWwgY29tbWVudCwgbG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo+ICsJCWlmIChlZmZlY3RzICYgTlZNRV9DTURf
RUZGRUNUU19DU0VSX01BU0spDQo+ICsJCQllZmZlY3RzICY9IH5OVk1FX0NNRF9FRkZFQ1RTX0NT
RV9NQVNLOw0KPiAgIAl9DQo+ICAgDQo+ICAgCXJldHVybiBlZmZlY3RzOw0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9udm1lLmggYi9pbmNsdWRlL2xpbnV4L252bWUuaA0KPiBpbmRleCBi
YzYwNWVjNGEzZmQwLi4zZWY0MDUzZWE5NTAwIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4
L252bWUuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L252bWUuaA0KPiBAQCAtNjQ2LDYgKzY0Niw3
IEBAIGVudW0gew0KPiAgIAlOVk1FX0NNRF9FRkZFQ1RTX05DQwkJPSAxIDw8IDIsDQo+ICAgCU5W
TUVfQ01EX0VGRkVDVFNfTklDCQk9IDEgPDwgMywNCj4gICAJTlZNRV9DTURfRUZGRUNUU19DQ0MJ
CT0gMSA8PCA0LA0KPiArCU5WTUVfQ01EX0VGRkVDVFNfQ1NFUl9NQVNLCT0gR0VOTUFTSygxNSwg
MTQpLA0KPiAgIAlOVk1FX0NNRF9FRkZFQ1RTX0NTRV9NQVNLCT0gR0VOTUFTSygxOCwgMTYpLA0K
PiAgIAlOVk1FX0NNRF9FRkZFQ1RTX1VVSURfU0VMCT0gMSA8PCAxOSwNCj4gICAJTlZNRV9DTURf
RUZGRUNUU19TQ09QRV9NQVNLCT0gR0VOTUFTSygzMSwgMjApLA0KDQoNCg==

