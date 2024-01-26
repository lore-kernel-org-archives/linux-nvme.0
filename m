Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F23FC47DDB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 08:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=inQ/6qPZqXNfIZvhYLi3AI4lSrXj4zMIcx/wRCA1sbE=; b=Za5U/JtXfUQlmqvhCHaI+tZS/Q
	fCuKgroyUE6qs/pZdIKpFwLmBSeqilK8eBCULbctA0jYobFt1fAqI26bL+VOjcmi1+E8CP8mzSZ+2
	9zchA8SgnVjjOZhlxwRqchNXxrJUM06dhIn+kvbvsXcHiRPcNWUrvmLxJNim5usNU8D3ljCQf7w6b
	a8CxOe0G8URuvDXkOe1HTuc8QaMS9vAB14KhmUkb69rrBwz9dpBj+zG4W4yonMephwYosUhCkhCIy
	q+Yfa6NQIMWUfrV2vmWuk1eO40Acom09R4x3NJ617CyBOoXW1BUbOtgLMd+y5FQ2P4cy85/21ZXqW
	j5hXo+tA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTHX6-00000003ROG-37H3;
	Fri, 26 Jan 2024 08:25:52 +0000
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2418::601] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTHX3-00000003RNX-30MC
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 08:25:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQpVawLa05FMCu526Mvcprpr7xgIa0+7QhJSaeNOaullVj5bL2JpxB+xjTZg0hzMErflxIMIhS+5d7fY6mVsPw1Q5n3Cx2bQ/ViyBQoW82Z68j3xUnoXqfMz3zvRQozVikxLizwLPrJmIdxx7jCARVO2d6ptCsweEVS5BQs49oocVTlRYhv1RTNn7vZVun8c0GBJHOL0ey/i7j8GEyrZBjOAZ/9KfFmQrPp9MuVkzTwBeu/kdEMCF3q0yEcfw4XJ8w+zO70+W5cw9PnmDLIy2L87guBDSWpEZX48o/f/+98RsapxCyH6Cy7FEiCyzy5qfsO1VYmhvj8k70jKYw3x3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inQ/6qPZqXNfIZvhYLi3AI4lSrXj4zMIcx/wRCA1sbE=;
 b=XJv1DXq9kFQoDi5elFNM3DKmxmP/wNXaHBQgT1TMnA0I3qPniAPdHYAdp/ZYReOhsQC1cTEt8OJWJtSMmwOMMYvDDJ/ucnzYE8CREWkqSr4cWA8f9zbtWfpVGJ10vnfSKgrlVKpqMgc6dp4wTiUwxZs3Ukj7plG13l4o4282/ncAlHrN+QTGaY8qjkqk8bKSKAvlDhfJNsvEWC1j1egeAafYmlvJo3Hqh3z2YXxaQ63UXkp6lxVXqr5hUu9+2UGQGWFU58eu6CZSszGXBfiZL0p1RgUxwv5ykZiBQoywajziJ2NPQjmvG0i/okMCPqRXGie2GCBICpj/LyTTWf3bqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inQ/6qPZqXNfIZvhYLi3AI4lSrXj4zMIcx/wRCA1sbE=;
 b=KWVPVFEWcG0hQ03rBeDwQB0f38FPGtou+G+kI+UbV0ir105nmFz63c76c8LWO7Bw7omVChNUm0BGigZxr0uL7yfPQC0iwrphtaTHcI4ryQqoOC3vlFLmwIZJDdbW6BDKhdIOcdyGgFf4BGIfk/ASB4BR3XJsyML8ip4HJPGB3UI25t0JGwfN3JHYUDef06CKaD+zVtZj8cbuDIhR0ulQA9jwM6eDATVpqVKD5mrziqiIjX4uDrLN5jJknDvacVyPro4VnZra2MEGHrRvXKqXOrlYTAVbmw34M2KftX4y1X4wctL0r9OpQaYHbSU60E71vsR60r3cstjrJLaztvbYLw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB7589.namprd12.prod.outlook.com (2603:10b6:208:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 08:25:39 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 08:25:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>
CC: Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCHv2] nvme: use ctrl state accessor
Thread-Topic: [PATCHv2] nvme: use ctrl state accessor
Thread-Index: AQHaT6aBj2KydFX2G0mmuY1T9Zjm4LDrwy2A
Date: Fri, 26 Jan 2024 08:25:38 +0000
Message-ID: <221c0e4d-2aea-4e5f-8b17-76cd0a5284d7@nvidia.com>
References: <20240125155213.3727106-1-kbusch@meta.com>
In-Reply-To: <20240125155213.3727106-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB7589:EE_
x-ms-office365-filtering-correlation-id: 598a073d-0750-4189-c1b1-08dc1e486061
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6HhdmHZYFGgz/NydiYBKo4Ha6pK22VPAVfUohKYfoaES0bhX7WUnLiCzc8GEtMu/6aza7dZz/pXUv2UOyIglw8SDXRvGu7j6Rh2j3zOkzRF8IFn8Qm/i00DNXkQdSRA20BenGkPSqu0ylTrNpQ7wDqTgrWY9UXHYy0XmOuD6Rz8/jqfB9MvZlDCpj+kpNQxGUWWXyGQPAC46KvqiUcmIesEd3JbO9bivh8fWAtOgaY+woSDdQJkswGUmPl6Y7vb6faELCs84gCVVpDc79a7WeDORkN6f+JzZryv83Onr59t+EOeFtnjeV1PvAqlBoMJiBGPsT26QE7YYb5rXN+hzqm5/2GIn5oONUrzvTSPWAfm/PjPbRvaMLYPjllFuB+22Q7LNMp7/VfVtmP8aBOgK0z4wdCPT/AxEoM3uKbVSEBpmUzZmj0JG2ZDNZrFRwrmPWHp8Y5aj7bTEi2UKc8gvKD2Ihug7gtGdhs6tg2erUplQo3H5XC8kxP7ylttecHAIPOw5MvKEbu9p2e86pmAUHhnC5GMx+g0ccTz/0fcIPKqazAU9a4Nk9a7MMrF0Fid6GRsRgTWXA8EkJ8D+dO2T5uWbwBz++87GVvDBf4Ct0uTp1ON+/VNxsEfpkj4T5hrLiD7W0YQHIsEqzqz69VzqHoZFrdsYcVODi4MSaj4Xpe2gqupCVs1F2nnjOwoihDPk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(26005)(83380400001)(122000001)(6506007)(53546011)(38100700002)(36756003)(71200400001)(2616005)(38070700009)(6512007)(31686004)(2906002)(478600001)(6486002)(91956017)(31696002)(41300700001)(86362001)(4744005)(5660300002)(66556008)(54906003)(66946007)(66476007)(316002)(6916009)(66446008)(76116006)(64756008)(8676002)(8936002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTd2VGsvcGpvQkRoVm5GbHhNWG9BNHd0TmhJMXMxR2J2NmtCZk16aDcxUkVp?=
 =?utf-8?B?ZytXd3lJMGN4Z1dTbHpxckU5T2planJRRXlFYWgyQVNvakZJa3RzTHUybVZW?=
 =?utf-8?B?Q2hDZUoyRExkSU5HQ1pZWk9PL2FETndWVWNUc3duYzFjVGZqSUtDYVpJTVZY?=
 =?utf-8?B?M3dZcDNFek8vNFhYL0pldlU0a2k0WmFTYnZ6M1pxNkNJRnYwdG9FL28yQlMy?=
 =?utf-8?B?cEw3VFVqVTN3MHRxc0hWeis2YVVmK3FOSUxpRWk3dG12ckd4M2RjbkNzMWh2?=
 =?utf-8?B?TUdrZ1ZOVm1tekZMUUtiSzdxVnRsb280bURzb2I0T0ZlZGlEK1NPZ2EwKzk3?=
 =?utf-8?B?anhCcDV1S0VTeUp4ano2aVBiU2Y4Rnc5NUtHQkZGVHBvOW5uczJITzdWUHdO?=
 =?utf-8?B?eUg1aWNGSml6czMxOXdvSk1jMUFUbEdCWlNZMTQxU1JtUVdZMEM3Sll5QVpZ?=
 =?utf-8?B?Z2s2Sld4VzFTdWM5cjVWNlBqUEVPTDdhSXN2bllUck4zUW5wV0lOd1RxMnNv?=
 =?utf-8?B?SkdHbjdnRDFIc2Jlak5ISFdmNERHOVR1czAzNXVnMDQ4ZXNZbGxTVTNPa2pB?=
 =?utf-8?B?MUlpY3FNRk03UmVWMGM5TEVvWU1jdVlRSVg4cnJBNEFON09uMW9aK2llNUls?=
 =?utf-8?B?cW5IQUw5RFZia2c3b0VpdnQ1RnRJUGNMRWdvSWZZZ0E2N1dac0k3UUxJWHVt?=
 =?utf-8?B?UGRGdGo0dWhzRUhkWHJIem5TSzFDWkdOUWEyUCtGcHpIZ1hpYzhoeE5pMXlv?=
 =?utf-8?B?RlIzSGNNM2ZXbGE0c0JqUEZKRDBieXBORGdHNWpMWkZEUjlBa0ZoMDRMcVVL?=
 =?utf-8?B?b1hxUkJhUGhzUXRWaWl4cDNHOFd0eG01S1BEaHBCWDFrVS9qZkcwcFJpQmFl?=
 =?utf-8?B?MWhLZ2c3enZINnFldFdESzByclRTRVlCcnlyejFiSnFsRDJLNFNwY3NGbWds?=
 =?utf-8?B?Y2Z2cHlhOEh6bnVBWG9iTitSZzVxeDk2Z0hYaHVhNWpySUhRRVI3Uk5EKzlZ?=
 =?utf-8?B?N05HRXY1Rnl5bjFMUEJNYVNTRkFZeGk5ZHVnbXhtVjlwbjBxOEJEdU9aU3NZ?=
 =?utf-8?B?U3VHQVhmc3lXUVlZV2xSaFZiUTlPQWJtUGpESmRWNkUrZjU5c3RqdnRpUlVQ?=
 =?utf-8?B?WmdNUWFFNlltdnorczhWdVV0VFBuVXBIckd6RUE2MjI4aGM3S0poS0RBYnZG?=
 =?utf-8?B?ODUxYkhCVGFOclVBOFpuTEVsT2dRclFQbXpoWjZyVGxJcEp4WFB6MU5nMXhZ?=
 =?utf-8?B?L3ZZUUJ5b2hSUCtGME9xL1dpVFRiZkl4dFBFWmk0dC9zbVBQWENYUjhDY1lv?=
 =?utf-8?B?dFgySUlyVDNORTMzUEp6dUZrZmlqUEtqTnh5SzNNZ2ZqWUNCR3RwNDg5Rzdu?=
 =?utf-8?B?SjQxL0JqcGFNdUltL1g5MTduWkY5TncvSXgrTDFwV0xsMXRXdlZHdW1WdVg5?=
 =?utf-8?B?cVEzdmR6QnpQeEp3VCtreENQNFRPMTVnZkUvVExVK0FGMHlMLzlIMU9DNmJ0?=
 =?utf-8?B?d2hpRndhODZCZUFWbVFaWmw5TkZvcVMxc2wyQ0dmaWJJdFZGUFVVTzFxb1VB?=
 =?utf-8?B?QU1adHpVdExNUXE1Y0syL3NVeHlFZU5Wem5Fcm5Uc2tTZkNMYXRiNkNhRm9n?=
 =?utf-8?B?QjQrSUU2cXFEVy9yQnlGT1BRWGF2Z3NTTjQzdUVPcFVVSTlmNWZnTWhkU2Jt?=
 =?utf-8?B?ejcxVkk1QkFuUStPWHlydnVweXc0U3QvdGlodkJsYkVmNk5mWXN2S21raFpw?=
 =?utf-8?B?SkVmc2s3cFBIcEdUUTV3aHVmWnhHSWFBQjlHZnJoU09jR1RWbzRmZk02Nngv?=
 =?utf-8?B?ZGhNSlZhYmE4Qlk3WExBYWVONWF2TVArbmllOXQzNi96ekpyRGpubzhxWXJq?=
 =?utf-8?B?TTE5UlJ6a0p2WWtnMmNzYi8vU0F4QkJRSW52Rno4RnNRM3NCV21IdloxMFh6?=
 =?utf-8?B?Sm04QkxFK2xYZE1XSzl4dGlTTmV4dWJ5Qy9PSkcxSlhtVkdwK2NaTDBOSVhV?=
 =?utf-8?B?bGxnRmJLRFBPOWNaaDdoYllLOVhnQ1IvWkFMRisrOElzOWZFbFMzb1VodGRG?=
 =?utf-8?B?REVjMkp6RXFmQ2poT0hFdU5vYjBwSWorS1Q4NkZHS3ZoMnNaZi96UzgxU1Vs?=
 =?utf-8?Q?PpRuVTj9Uu0HhOlJrPfwu61mG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BFC856B557CA1943BF4B35B3B59A684B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598a073d-0750-4189-c1b1-08dc1e486061
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 08:25:38.2680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZaGOL1DNkbt2WDIcTCLgjQt6zYRes4wyqxRoURGcNGhGKvr2fxhZxyl6wN6Obtxk/RtD6a4T0D09++QDqDrsCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7589
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240126_002550_521366_0AA494EC 
X-CRM114-Status: UNSURE (   9.50  )
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

T24gMS8yNS8yNCAwNzo1MiwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4NCj4NCj4gVGhlIGN0cmwtPnN0YXRlIHZhbHVlIGlzIHVwZGF0
ZWQgaW4gYW5vdGhlciB0aHJlYWQgdXNpbmcgV1JJVEVfT05DRSwgc28NCj4gZW5zdXJlIGFsbCB0
aGUgcmVhZGVycyB1c2UgdGhlIGFwcHJvcHJpYXRlIGFjY2Vzc29yLg0KPg0KPiBTaWduZWQtb2Zm
LWJ5OiBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPg0KDQpLZWl0aCwN
Cg0KTm90IHN1cmUgaWYgbnZtZV9jaGVja19yZWFkeSgpIG5lZWRzIG52bWVfY3RybF9zdGF0ZSgp
ID8NCg0KY29uc2lkZXIgOi0NCg0KKiBUaHJlYWQgQSBydW5uaW5nIHRpbWVvdXQgaGFuZGxlciA6
LQ0KbnZtZV90aW1lb3V0KCkNCiDCoGVuZHMgdXAgcmVzZXR0aW5nIGN0cmwgc3RhdGUgYXQgdGhl
IGVuZCBvZiBmdW5jdGlvbiB1c2luZyBXUklURV9PTkNFKCkgOi0NCg0KIMKgZGlzYWJsZToNCiDC
oMKgIMKgwqDCoMKgwqDCoMKgIG52bWVfY2hhbmdlX2N0cmxfc3RhdGUoJmRldi0+Y3RybCwgTlZN
RV9DVFJMX1JFU0VUVElORykNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFdSSVRFX09OQ0UoKQ0K
DQoqIFRocmVhZCBCIGlzc3VpbmcgSS9PIDotDQpudm1lX3F1ZXVlX3JxKCkgb3IgbnZtZV9wcmVw
X3JxX2JhdGNoKCkNCiDCoG52bWVfY2hlY2tfcmVhZHkoKQ0KIMKgIGN0cmwtPnN0YXRlID09IE5W
TUVfQ1RSTF9MSVZFDQoNClNpbmNlIHRpbWVvdXQgaGFuZGxlcidzIG52bWVfY2hhbmdlX2N0cmxf
c3RhdGUoKSBjYWxsIHdpbGwgcmVzdWx0IGluDQp1cGRhdGluZyBjdHJsLT5zdGF0ZSB3aXRoIFdS
SVRFX09OQ0UoKSwgaGVuY2UgcmVhZGVyIGluIHRoZSANCm52bWVfY2hlY2tfcmVhZHkoKQ0Kc2hv
dWxkIGFsc28gcmVhZCB1c2luZyBudm1lX2N0cmxfc3RhdGUoKS0+UkVBRF9PTkNFKCkgPw0KDQpp
ZiBpdCBpcyBub3QgbmVlZGVkIHBsZWFzZSBpZ25vcmUgYWJvdmUgcXVlc3Rpb24sIGxvb2tzIGdv
b2QgdG8gbWUgLi4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRp
YS5jb20+DQoNCi1jaw0KDQoNCg==

