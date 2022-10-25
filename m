Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F485C67871
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 00:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HTvXDC7b/Di/AWc2NS1pNKWFHp7ohgmsCsOSD7PpnUM=; b=O65EnVr0b31YM7ndvoc69wZ/Qm
	F+bcdMsPMgf5N4bmJTIzo/LoWDjEyusdUwejof4fLqXdHyiSPRJIGvsrJT7bY7/x4vbz1dulo25Tk
	FxDLrXlcJtUNpPLGWP5LC7sL8j7J7nXuZCFu4+HyGF0fjbfDv1AGeXn/nDjvg2K0pu8E0DEuK0nmC
	DqQmeCCx9KMRijHWbExxKfGOzknXyEmS7QqRYVVis9sWASnPu3NYqHD5RWgpmVtReFYG2+MB6F8bW
	S1TM8sDDzU88HjEkQaPgqwLTGe/aLJH+MQMv5vKciYHbl5KYrXhAAFnZ9yin8fcU0WnLaQ73cOXpa
	j3+7P0KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on8DT-003TcV-AU; Tue, 25 Oct 2022 00:54:51 +0000
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com ([40.107.237.82] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1on8DQ-003Tc1-N5
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 00:54:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hb0x7pqdK/it+I1QW8rqRchFTk8kzKONqLl3w2jeKgaQ9EHG9TE91+AEsAD4rNZiLMbxgyFtlXm3HICMHkODMw36pjG8601kbnj5DHITZg+RWapLkKmIdP9l4zoo8lgCXnF1o1KXtMXWsbvgTt9CouBTk5z30Q5twSd77QvLeMTh0sZ0o1EntAb8t3lYTzItn7FyMLOJGuRj4OHY7/FgcvWlUZTxhyXfT9bhRP9k9iCTnMVqg0lEUlIHgf/T5WB3tURdxl83Wl2eomRzcU5Y7c619ayr2lMtTyUQIS1893aAvNq5dFLlQs4NZtFAGg8xS0YIUg6IIS9m/LVl58ogwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTvXDC7b/Di/AWc2NS1pNKWFHp7ohgmsCsOSD7PpnUM=;
 b=kjcS0P85xN+ufoky2D+FYsopueype/cMQbgrbQ/i/v1cWoRxtaHrNgGQwafgFMiBqojdSwH6ZZc1TJUVQEE3NjRsuKzYw2l9mKi0p02XJory7vRr6W/zbKT35uJKcI54tdY8/JTqEn0VkxsefxRypeW3e7DZRdy6BijXvQdJjtCJzEA99uiVpNXc7PgTADNZ1DPYfl7VD/2EKBT5vRMYOMF2cjOFj6/ubIla88J/RzEjiSYSF8OqaM1GI8zx7+4u6jpdV9RNgAd6fazhBVgmuYHP1JKeQhrcng/fpQ4qDGPQy/vhn9LIrhPdOYCXEp6eIu3zUlkTIkbIEcDCUZyWHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTvXDC7b/Di/AWc2NS1pNKWFHp7ohgmsCsOSD7PpnUM=;
 b=e3UEkZf8vnhLcQD/hfublpzYaEOAbQtJHIyPkw2Zgtjrbax3iP7cZUSMpO+BpoOACaZI1c6gp3Ri1N3J+fHNd8/Z0Ehz6kxDnBcWbS/1DkGo4UV7KnuLRHX3oIbNeRb5MXEndacyYDkUB0ZOv9tF9aE3yyJ1SB7NJetgJfFuXcFCHTpxzsIEnAmSR5BC5sgRW4pArp2y6j6/AUgamwSMLs1Rq9VP0xhC5YCIzf7au0vSxEmxIH70wHmyvkFQ2OlDOhnG4OfUwlO/QIu2oiz0laeEXeG6MuTYVv01nofHv/fYwq/NDpYckSLN9yb33FdUPSvDOqQm5zJ1i2WRqFhqeg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.33; Tue, 25 Oct
 2022 00:54:43 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::1402:a17a:71c1:25a3%7]) with mapi id 15.20.5746.021; Tue, 25 Oct 2022
 00:54:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH v2] nvme-tcp: send quota for nvme_tcp_send_all()
Thread-Topic: [PATCH v2] nvme-tcp: send quota for nvme_tcp_send_all()
Thread-Index: AQHY57nzFPwBuHuVp0e2Jkqmxm0Yrq4eSUmA
Date: Tue, 25 Oct 2022 00:54:43 +0000
Message-ID: <529264d7-c3a6-04dc-f705-c0ce3a49759e@nvidia.com>
References: <20221024150334.29215-1-dwagner@suse.de>
In-Reply-To: <20221024150334.29215-1-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB5998:EE_
x-ms-office365-filtering-correlation-id: efda1ee5-7238-485e-84a5-08dab623815d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  nBJjZu1om6NfaV3EQeUVhgYxgGnh0ZtGetobMz6m0cZC+K6+OtmvFmprdkPhqi/+UfUea6S+V7LiD+X/aynKuPJlpgv5MAIHqaocB6IsZL10ymR0No3iBnsfbsx/zM1Ag7In7sTViJidFegzwRHSTfo9tKg3fqhCs18hs3sLRtRwYRfvNzxGDhyRcqh9n71C4RXzWeU0NQJzBfTl9ttNTSVjxgfuDyg3KIN5MOtQFIDc4q7BjlhR77qcj7leV4Ie93OPJYe1HboXjAkGOvyCatShVtjXB36ILE26Zs/1lbQK+UbdE5D+E+7Q4DTCM5ijmCXIZOooAE5cAaEjR1wW62sC3jRjwEKHJB3xT6bca2mmREi98/gi5MJ7ghft4aRCySMIEZIZWlm5J6HnDrBbAJLMMq6NznSm4CN4w8czIW6H34jclO0EWelzXhXexEbcoJFDuJ8TxEd8w1YX5wbOQsdOWFZQa2MzvOpkRnpbTNHdwEC33fRejMhWnm66riOwmHbs7jDUUxwkLer1CrUBgQURwA8fNHi8UBHvGQGc1Gfk31bkt2nf8cpwMY2hpVRqpBC1a6kedOMDOz49Kbi9SxGj4dexuZJGd5cijMmxC/oyG9SuejZ2XUkw9gpWDIz4X+72NcTqMqeHGUZqculy7HUMMTiDWtrN51Q2j0OYHy7hIjGiJ1b+BWhvdC34dRLTONRAbwSs0kzYH3rbbnyOxPC0GiA/9YdqpR7pFXSwWfjnzbYnKEnHm3IdPrq+kyLlv6V3AMmL3JQywPcTtIMiS3YMpGSTkXbY1dSvbH+X5xclO60xak16mNU4WZ3eLs6HPl5hI8tNmRFfz9iOOjwwW5PcsjDZonXRYW1r58Oo/W9+7J6hXLssr6qm2pipBnmBKXu76z37HE7dmH4pa4xsZe2vTfRzt4iyc+qHeoMOHBU=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199015)(86362001)(31696002)(36756003)(31686004)(122000001)(38100700002)(38070700005)(5660300002)(6506007)(53546011)(83380400001)(2616005)(186003)(6486002)(6512007)(4326008)(316002)(71200400001)(15650500001)(2906002)(8936002)(66946007)(478600001)(110136005)(54906003)(66556008)(76116006)(966005)(64756008)(8676002)(66476007)(41300700001)(91956017)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VTlXTXo4V2NmOXhvRisyQ081RTgzY0d0SitCeHJGdnQ2eTgvblNBaEgyNmhC?=
 =?utf-8?B?U2V5RmJxZG1OV0dybkZuRkhPVmJzUE94eFJVdVliZ3FkSSsyeVBjVzBsOXFW?=
 =?utf-8?B?VGNzZFJrVnFCdG1mWlhValloWGRlN3MwZS94TzRmSkhGZUU5ZUxMa0Q2YW96?=
 =?utf-8?B?SnNuZCtiV0dZSUpPUHIwOENwQVVxS1dWdDczS2ZVVXk2Z0dRWUJIKzQxQkM5?=
 =?utf-8?B?N0ExNEVlSlFZZnpTSWg1cUJCdndRTHB5YWYzRlc4cnZmMm1ZdFAxVjh3Skcx?=
 =?utf-8?B?SU9xc24rZktBbWYzTy92aDRjckJKNCsyRktBWWFtMkRPRld2NkQwTHluQlBu?=
 =?utf-8?B?M0p4dnFZb3FrMjFOQ2NUWTBORXMwdFJtZFNWZE5WTTVEbU9hcW1rQkQrYWhY?=
 =?utf-8?B?ZEJ4MUd1T29BenhnY09yR1NXNjlEWjRkK1dGVEZ2TTB2cGRoS3drem8zVHM3?=
 =?utf-8?B?aWxLNFoxUXcrLzR4cDI3b2wvbWhrZzJsV3BUT0ZNRitncUpVc1ZEMlkvNGQr?=
 =?utf-8?B?UzlkUFltRmJRUkppUWpNdWU3eS9JbkRtQ3pMSlhaV1ZYQ2JSQ1BxbG9tQ0pZ?=
 =?utf-8?B?bWhTajVQN0VRdEU3eWFadEhvNGs0MTRhd1pOTkFpQWJhcFpOUUxGblhGbm1o?=
 =?utf-8?B?bGFLL1dnN2txWW92ZWo2RXRLWWpqdktBK3lkQ3JoWEx0YTY3aFk1YVFjQ3Bm?=
 =?utf-8?B?ODA0VWMzWXBJb1FQd2VER2h6NVlMa3VPZ0lqOTA2U1BZZ2hkMDJjcG1NWW5Y?=
 =?utf-8?B?dEJraDNtT1dIWnBnOFNtUmxTOVpOT1NBL0pSbUdxZTZ4bGJLTFBxenVYRW8x?=
 =?utf-8?B?MXA0bDdKdmowZmlzOTJiYkhqRlVER0lYckpSWDBWM3U3WmoyNUhMZUUxUllp?=
 =?utf-8?B?UDZUSU8vNUlMaVhUYkdzcWFxc2V0TEk0YnlNWHY1dCt0QVNSOVpSS1g5Z1lh?=
 =?utf-8?B?YkN2NmQ2SFduOGl6TGVTNi9reG5ZbHhRcUpwTzlUUUVUdWN6VkpGRlQ5ZWRp?=
 =?utf-8?B?NEVtYkFlcXBNNGR5c0pTZUt1WUh6ZkZ3MW5oWGM2WHRWZUF0L01zZmYvOVlB?=
 =?utf-8?B?Qm94NmlZMklsUTNoL083NlpqbUsvMWlJUU5lZkoxUkJVRHBTM1d1MzBhOHh4?=
 =?utf-8?B?T1NpTzZOaldZTTQrQStreHp5NEJ2RFNJK1lUbTlqTjN4ZG1DTW5kWVlYdm1t?=
 =?utf-8?B?RkZwQVVoWUFMcVphNXhCeXB3MXpQZTVnK1VUcSs1Q1VFU3U2UDJ3YXRuOHJY?=
 =?utf-8?B?Um5Eazg1blE1ZmJ4eHNZT1RoVzh4NVM0MGI4MS9kdTBjRnVSRkxaa1F3YS9V?=
 =?utf-8?B?TkJZU0RGbFBUOVpKWjB0ZGptaWIzSTl0b05zSVFMUjRqeEl5YThkQTEwS1Az?=
 =?utf-8?B?TTgwSzJwZFZiSG94UVlYcHIxbjhNeXV6TGloaksva3NybFN0SUxNRXBibmFP?=
 =?utf-8?B?V2NqNmIxTGovU2djZ1ljMGVoVUp0eVJJU1plRUVaSDY5bThESTE3bU8xVDcy?=
 =?utf-8?B?UWVJc2llcEtKaHJXYVJGb3hwVHF6SjdEZlZXdmtXdXVBNGwzOVpOKzJBQkk1?=
 =?utf-8?B?N2RlV3htN29hVlVYZ0VVamFZUUh3TTdwbGlqN0p5eXF1TkVKREhFN05ENzAw?=
 =?utf-8?B?TC8xcy9lYnlKNDF4K0taS2R0UDg3QVhkQklzRi9McUZUcEVERSs4NjBKWTVm?=
 =?utf-8?B?dlVvN0RMbStBSEFDclJ1cVEzRHJBQ28yZndFakQxdjJwVWQyeEhsSW42RmhX?=
 =?utf-8?B?TnZWdEpJS0NJK2V5M3c4WkdNcXdHY3phWkJqUUg4eElrUzF0S2ExYTFhaTV6?=
 =?utf-8?B?WHF1a1RpQm9idXNmeXZxVkJQelBpWklsZTFRRU83WDZ5K3RoK0R6RVcwaUR0?=
 =?utf-8?B?QS9FVFV5R2ZDbHpoZENmUkowUlRoeEhFMVV3eGpEQzFzcUIwRGFMaXIveUFB?=
 =?utf-8?B?b1l1ZjUrZWhxUkRScWZsZTd1Vi9BdWE5dUIzU1ljMGhNeEk3UDFFc01MemxD?=
 =?utf-8?B?OGZhblJwaTRtclh2OWdWMmJJQnZMcG90aTBRcldQdDhOU3gyRmNkN09GQjc5?=
 =?utf-8?B?NWlNVCsxS3lZdUkyMlFaRzRPS2M5ZW1ZUkZZVjFRWmZKOE5jZEVGNno5a1pQ?=
 =?utf-8?B?RGx4cW5oVmRrdHFOWFRLVFVRd3BwYUJ1RVYrd21BWFdBcElqalZUVCtMZUk5?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A3659A642D9E243AF7002F2FC979693@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efda1ee5-7238-485e-84a5-08dab623815d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2022 00:54:43.6221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zttSClBbrppLveDi3lZ6/Vsvh11mIk2R9SuxuWrFrzr/QuEAxAEcVmTG/uvCTuV+fVYi3PntxxX9WnNS8ssjJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_175448_776511_1F79A3AB 
X-CRM114-Status: GOOD (  28.29  )
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

T24gMTAvMjQvMjIgMDg6MDMsIERhbmllbCBXYWduZXIgd3JvdGU6DQo+IEFkZCBhIHNlbmQgcXVv
dGEgaW4gbnZtZV90Y3Bfc2VuZF9hbGwoKSB0byBhdm9pZCBzdGFsbHMgd2hlbiBzZW5kaW5nDQo+
IGxhcmdlIGFtb3VudHMgb2YgcmVxdWVzdHMuDQo+IA0KPiBDYzogSGFubmVzIFJlaW5lY2tlIDxo
YXJlQHN1c2UuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IERhbmllbCBXYWduZXIgPGR3YWduZXJAc3Vz
ZS5kZT4NCj4gLS0tDQo+IA0KPiBJTU8sIHRoaXMgcGF0Y2ggbWlnaHQgc3RpbGwgYmUgYSBnb29k
IGlkZWEgdG8gYWRkLiBBdCBsZWFzdCBpbiBteSB0ZXN0DQo+IHNldHVwIHdoZXJlIEkgb25seSBo
YXZlIG9uZSBldGhlcm5ldCBwb3J0IGl0IG1ha2VzIGEgYmlnIGRpZmZlcmVuY2UNCj4gd2hlbiBh
Y2Nlc3NpbmcgdGhlIHN5c3RlbSB2aWEgc3NoLiBXaGVuIG52bWUtdGNwIGlzIHB1c2hpbmcgYSBs
b3Qgb2YNCj4gZGF0YSB2aWEgdGhlIG5ldHdvcmssIHRoZSBzc2ggc2Vzc2lvbiBpcyBjb21wbGV0
ZWx5IGJsb2NrZWQgYnkgdGhlDQo+IHN0b3JhZ2UgdHJhZmZpYy4gV2l0aCBpdCwgdGhlIHNzaCBz
ZXNzaW9uIHN0YXlzIHJlc3BvbnNpdmUuID4NCg0KSSdtIG5vdCBzdXJlIHdoZXRoZXIgaXQgaXMg
cG9zc2libGUgYnV0IGlzIHRoZXJlIGEgd2F5IHRvIGdhdGhlcg0Kc29tZSBmb3JtIG9mIHF1YW50
aXRhdGl2ZSBkYXRhIGFuZCBwcmVzZW50IGl0IGhlcmUgdG8gd2UgYWxsIGtub3cNCmV4YWN0bHkg
d2hpY2ggYXNwZWN0IGlzIGltcHJvdmluZyBieSB0aGlzIHBhdGNoIGluIGNvbnRleHQgb2YNCiJz
c2Qgc2Vzc2lvbiBpcyBjb21wbGV0ZWx5IGJsb2NrZWQiID8NCg0KPiBJIHN1c3BlY3QgYSBwcm9w
ZXIgc3RvcmFnZSBzZXR1cCB3b3VsZCB1c2UgbW9yZSB0aGFuIG9uZSBldGhlcm5ldA0KPiBwb3J0
Lg0KPiANCj4gRGFuaWVsDQo+IA0KPiB2MToNCj4gICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtbnZtZS8yMDIyMDUxOTA2MjYxNy4zOTcxNS00LWhhcmVAc3VzZS5kZS8NCj4gDQo+ICAg
ZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgfCAxNyArKysrKysrKysrKysrKy0tLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMN
Cj4gaW5kZXggM2U3YjI5ZDA3YzcxLi44NGE2NmNhMjA4YzggMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvbnZtZS9ob3N0L3RjcC5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jDQo+IEBA
IC0zMDgsMTIgKzMwOCwyMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbnZtZV90Y3BfYWR2YW5jZV9y
ZXEoc3RydWN0IG52bWVfdGNwX3JlcXVlc3QgKnJlcSwNCj4gICANCj4gICBzdGF0aWMgaW5saW5l
IHZvaWQgbnZtZV90Y3Bfc2VuZF9hbGwoc3RydWN0IG52bWVfdGNwX3F1ZXVlICpxdWV1ZSkNCj4g
ICB7DQo+IC0JaW50IHJldDsNCj4gKwl1bnNpZ25lZCBsb25nIGRlYWRsaW5lID0gamlmZmllcyAr
IG1zZWNzX3RvX2ppZmZpZXMoMSk7DQoNCldlIG5lZWQgdG8gcHJvdmlkZSBzb21lIGZsZXhpYmls
aXR5IHRvIHNldCB0aGlzIHZhbHVlIGFzIG9uZSBzcGVjaWZpZWQNCnZhbHVlIG1heSBub3Qgd29y
ayB3aXRoIGFsbCB0aGUgc2V0dXBzIGFuZCBIL1cuDQoNCkNhbiB3ZSBtYWtlIGl0IHR1bmFibGUg
YW5kIG5vdCBzdGF0aWNhbGx5IGNvZGVkID8NCg0KPiAgIA0KPiAgIAkvKiBkcmFpbiB0aGUgc2Vu
ZCBxdWV1ZSBhcyBtdWNoIGFzIHdlIGNhbi4uLiAqLw0KPiAgIAlkbyB7DQo+IC0JCXJldCA9IG52
bWVfdGNwX3RyeV9zZW5kKHF1ZXVlKTsNCj4gLQl9IHdoaWxlIChyZXQgPiAwKTsNCj4gKwkJYm9v
bCBwZW5kaW5nID0gZmFsc2U7DQo+ICsJCWludCByZXN1bHQ7DQo+ICsNCj4gKwkJcmVzdWx0ID0g
bnZtZV90Y3BfdHJ5X3NlbmQocXVldWUpOw0KPiArCQlpZiAocmVzdWx0ID4gMCkNCj4gKwkJCXBl
bmRpbmcgPSB0cnVlOw0KPiArCQllbHNlIGlmICh1bmxpa2VseShyZXN1bHQgPCAwKSkNCj4gKwkJ
CXJldHVybjsNCj4gKw0KPiArCQlpZiAoIXBlbmRpbmcpDQo+ICsJCQlyZXR1cm47DQo+ICsNCj4g
Kwl9IHdoaWxlICghdGltZV9hZnRlcihqaWZmaWVzLCBkZWFkbGluZSkpOyAvKiBxdW90YSBpcyBl
eGhhdXN0ZWQgKi8NCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIGlubGluZSBib29sIG52bWVfdGNw
X3F1ZXVlX21vcmUoc3RydWN0IG52bWVfdGNwX3F1ZXVlICpxdWV1ZSkNCg0KLWNrDQoNCg0K

