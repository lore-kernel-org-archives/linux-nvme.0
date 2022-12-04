Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E13C4332F
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Dec 2022 00:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pb+qugVND50zl8XR2YQ7hoL37vAwy8cg/D76zxDpw6A=; b=I+4QZsReafa0Jr2yIc+Xyrq6QV
	9Dva3ycMOT/9jCaV82BGB//sOCPu1SFP7sDoctryxmDY19Fk+bpaVA4uDxyAznhYorEWhmG+lvPGr
	VvUtpSkXh/W8F+hWjv6Sn0AFZusQcDn8XvfeceH2i8Mj2OID5fb0IpBUAIkw7wj4S/l/EJhb3iDW7
	yCU3skTyPQ13z+CWeXSmKUBkNenD30IBA5E9KhSq9Sk3zXqBwEnsgZ1I5fQoWYWdDFHGcItvrOKh9
	BOOV3vrhlcAOxWSkODiLv6bS4CDzmWtTSNQpFRtCcjCdXPL4Kz0g46f1XRtEbkGyzF9UxDhB6ie3a
	E6XQp9bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1cTS-005r7j-H4; Sun, 04 Dec 2022 00:03:14 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p1cTP-005r7A-3s
	for linux-nvme@lists.infradead.org; Sun, 04 Dec 2022 00:03:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KTLKu80B3DAi4qe2DCYLT6ctYQ9J1z6CGlgEvmsrK3q/jKzvd5eac/pIcWWU7isZARbJS8Zu/6vBxVK5aHWp4gi/TFC6wzVxWI7ZltH7T7AM1/FvJONEUWVA1PnNETRzx7J/XfrR0H9UyMXBeMWdAhhj2RfLG4EbnuMJoDFbQ07Gctkq3ebDaudIu7JB3tCJ0JfX9J/Vny5GioD7rty4eJ9WUTcuLCCLr5A/1WOD5crOAUPTbcx+arThBki61AH7Jr/FHePE/GnvYabejONqfD9qoXOp0CJRhnrGT3qWO0hUifPZ/DctN7ogK21/z9Uy0ZdNVB5UXbifmk0gD3WYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb+qugVND50zl8XR2YQ7hoL37vAwy8cg/D76zxDpw6A=;
 b=bbezkx96m0UHvyUjoVLqH5+bPRtw6y+Al9pamIpWmzvBVQPK1S6ZGCSi+g6ZwYnJ70jj7UgtkDsJ1Ttt7Pxz6ErUX9JCLqN+Hj7ZS7gvNPvRBfkWFL6hSxqS6hdw6MoI3nKpiKDctykeFPl0ESmwbFIY1DfEvdpBKn70csIqXcREfG20gQtxwC40qsW5xpyM3Klkz5d/Wio4L5mgbYXKugpqFPF9PfqfnvZPT7OVQT6NsL8inej6JR+cY8gGxA5Hwm3PtLC+KvOu2/7xY1z9ZhFd3/0kChmY629ItWjgkgRyrW4hClWAQ4vJyFHTVqfQRXui9XX9eXP9pOBGOwgIyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pb+qugVND50zl8XR2YQ7hoL37vAwy8cg/D76zxDpw6A=;
 b=JjPS7d9NbJIEJc0wWc+mlPMp5W+P2he7Mcyv9S0FTEmZlA2jVWUwtC25Fmg26dDsfX7JbBTHCcKu/1CHAw5C5EdIxA8V2KHL+4QqU6kJU6p2+c82f8u/ktChjIbwz95mEkmw80P35/vfl2H0v6qgwmpoz9T6wsX92CRWH52K7p7JFPpHNyrkXox+3u3+JNFB90caaiZKJNonnanQZor4HppOh+eq6R+nxpIvuWKLxqA7dUoyajAk4LL4S6I6HgsH1PQLcwfW4I0v94zDDT3IN3VjzmYq5iseYIMz51P3MlMhNG423jgyWZU7ZQCOrmqzQoj2r8xhULRmHeRqoc8Aiw==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Sun, 4 Dec
 2022 00:03:05 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3134:69a3:d1a3:beae]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::3134:69a3:d1a3:beae%7]) with mapi id 15.20.5857.023; Sun, 4 Dec 2022
 00:03:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: =?utf-8?B?0JjQs9C+0YDRjCDQkdGA0LjQutC60LXQu9GM?= <igor.brikkel@gmail.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: Bug report 216049 duplicate IDs
Thread-Topic: Bug report 216049 duplicate IDs
Thread-Index: AQHZBPjN1/tvYnhoOUin66S67aiH565c3Z4A
Date: Sun, 4 Dec 2022 00:03:04 +0000
Message-ID: <f7c4d9b2-9a05-5d87-bffe-12f7302dda71@nvidia.com>
References:  <CABPTj+oWpSHaD_N+Xhbu1QiRqsH91wnbGtw-YB5qWfH5gQB92g@mail.gmail.com>
In-Reply-To:  <CABPTj+oWpSHaD_N+Xhbu1QiRqsH91wnbGtw-YB5qWfH5gQB92g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|MW4PR12MB6873:EE_
x-ms-office365-filtering-correlation-id: 6e2955eb-fa42-4644-7d85-08dad58aeac8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  R9J1Qqa/w8o4Xdwm5JN8rK2S+tb5nm4wf1fGM8f3+Kcrs5rOeP7MKqNrT/sZGU0TJ5KesyXmI3NqISKVmVOFKWo7XC3EW4MOvi8N1GfO10WB5oMGPBbXdYB6Cc9OnjDPYXPot8pvYXcazq1SdmUQ7SL9tulDWsjj8uMLBCLOq6p/KD5m5JtAqWMuI0/P/yjUSIwHppOqusRh1dRbPhAULB5MBf0XG55OIckrNMaUn6Fi4vC58Mvm7DWNLhnKl6lzy24iTaVdRqaJ5GrS9sduAOSB1rDuxvkl03upObe8a5v9vFitrkOTKTLmLEzJG4FodyjnjSEkbf1dy510X6adf8pzX+5X13fiSQigpWpCkj5pa+cN3HfVg+qAcV+OHXn/nfjvAgtZ8WRDsMMfb3VIK/aM4ZvR/DWPFMVA5Do050GWtabRCYfwERpWKS4zq/691p0go9JQ8PbBuYDpf8B7TCFwJDVltYRSwpXi6bDAM4X0LElwZRkRcK3uCFRiVlfETOiXVG+UGpmfNSV+QpbaN1UvBMYxzluS8L2vMvTH0Gaeteqf/uR3RKBtbLnfMBlZQWqd+ecMr6rqmcQfiBHSmNlAvbCmAsd5G47bAVByKwad6u50JZUVwhw9duAcdLWYPTKPE6G1jlqK/EG6CDQZLaB+D5PhOxFko6lvx79WEYtgmQhvF0B9dsZ3v2xvemqnL9D8rfhVsJDe/AIOmoRz8LtAYfXjgmIXgyVKUxNJeBH8se1aC2wpLHeza3TjeQq0
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(451199015)(71200400001)(53546011)(6506007)(2906002)(478600001)(31686004)(6486002)(6512007)(110136005)(76116006)(64756008)(66556008)(66446008)(91956017)(66476007)(66946007)(38070700005)(186003)(8936002)(2616005)(41300700001)(316002)(4744005)(31696002)(36756003)(5660300002)(8676002)(86362001)(122000001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dlFwUGNVaHhybmRSMWxqWEZJUjRUNHNINmo0Y2UrNFZMQ1ArZzlYdlBNdGpT?=
 =?utf-8?B?ZFpXbUU1SysveEdGSHpSTGNiMWpicGFRMnRJZzVNMlFTZ1kzcU1SbXB1VDRG?=
 =?utf-8?B?NENwaU9yOFFqVXkyc2FQdFNNbFBWZW9aV0FBck0vU1ArZThyYjVFdmo4NDlx?=
 =?utf-8?B?RlFTazdzVU1oTE5Ha2swMXRmSzBId2xjenRDb1lsWTFTSmM4L2Y5ZS9hT3E5?=
 =?utf-8?B?Vm9hNEN5Y2g2alppVmYwNlJSbUltL0U1aktQQjVJVStBb0lKOGZEOHRMRHBs?=
 =?utf-8?B?bjBXZXdZT01NamNwcjBBZ2xZUnhBS1pLQ2VyLzl1TnZXaEk3UTl3dGs4d2hG?=
 =?utf-8?B?OGo2Z3RsV1h6cG5rUkZXbXV0bXYyaUdJRUFMMTRIYWlQN2RTNVFKS3ZlMGh3?=
 =?utf-8?B?UG82Rlo3cUd5K3lSd01yWDNZUU1ETFNaVE1tYkp6ZVlMd3NwU0FhMTY4TmtZ?=
 =?utf-8?B?Mm5NVW56bVZ3blpkZ2VYWEt2UVplSThFNVNZWmJoVEpVS25EME16TWxLMytY?=
 =?utf-8?B?cldPWjljM0l1elJibzBsY3EwUHk4WGtnMDhvN2NXQ1dzejNCT1Rtem9LY1FU?=
 =?utf-8?B?Uk5ScHJFMC80eFJDR0doRnFiMDNHYzVSWUIwMm9naTVGRm9QbEQ0MVN5MDJF?=
 =?utf-8?B?UDBqZHNuM3lzd1BFM3QxK3ptbFdEUHgxcFNVYkRPZXkrTi9hUUhiWlFiNWtn?=
 =?utf-8?B?anNHSTRhTTVrN3BlWkFsM0tGaDNSWlZOMUFxdFllVDdwc0ZTM0M2eUVTaXd3?=
 =?utf-8?B?YlhnbWFJSmcxMUNvQmhzWGFDeTVBa0lUZGttcTRMQ0NlckpRdGd4S0FPV2FK?=
 =?utf-8?B?WEl1MW9LVFduaHAvd3NvaEN3cTRlU1NGZHRXU040M2orMWxXMk81ak5zYllO?=
 =?utf-8?B?L1M2MFR6R0NsN3RySWV6dStuMXBZWHBpMUo5ZEhud1ZBNDJHa015eGIyaVAr?=
 =?utf-8?B?VE04aVZlT1V5SkFPNFhTbDRmRmlZUkRlUGdhRGlVZzQ3RGVSMTk4UFFEcy9H?=
 =?utf-8?B?MC8yTkRRTWR0a3RIRkZHaDB5Y1pReWF0NGhPdFhoZHRzUXl5dW10aThBMERN?=
 =?utf-8?B?V3VMYXVlNndFQU5VSUJVODNFcWhTclUyZDdIazZwOU1UN3NDYlJOVmMrV2JW?=
 =?utf-8?B?eGcxWllFVnZlZkMzNWFUTzdGTnEvcGo1elFJTjd3clVFY0lJMnkyNlRDZkdL?=
 =?utf-8?B?NHdYWjUreUsvL0I4ZGZMWktocWM2REpLLzRCQ28vSEZWeE1kWXFIUWc1dGtS?=
 =?utf-8?B?VWdhYzRSaVY5bm40bFNxQWhNekRIZFo2V2pHM3E2cTZ4TUJ0eWVRU05yL21Z?=
 =?utf-8?B?V3ZyQ0lVYUpRbXRid2JpakZSYUlaRzNlclphNXllVHFaU25nNmxDUE1OenVn?=
 =?utf-8?B?Tmx3dnZ0bng0ekg1ZlZiTEVGbTVkMkdsTEM4MG1jUGFwcWtIS00vN1R3TG5n?=
 =?utf-8?B?eXoydmU4ZitqLzVIT3BxQmdxK3N5TVUrdmR0SEpzK2I1dXRKNnFSK2F4aHQx?=
 =?utf-8?B?N0tIWHFuMEU1cTJuRlRBVlQrNG9LQ2lZWUdTaG9uSEh1bnBlYnZqa1RnTTdF?=
 =?utf-8?B?aFZ6VExOZFBlRE0xeTZDMGRJbG0wRXh6eXA2M01NeHoydkNwNTFUYXdtZ1k5?=
 =?utf-8?B?bEtzZ1BmemtpSVUrOWxxQXNJNFpSWUpyM0pXcUNGVkpDZjIvME8wRVQrU3U3?=
 =?utf-8?B?TW9GUERtbEZ2aFFBbXBrTUtBbnAxWUR1RzVXN3VSajNFbWxDOXVuamk1M2ZV?=
 =?utf-8?B?ZHMrY0Q5MXl3RkxZZkFhWktZNUpaVlFTd0RDTW41dGJuNXpNZTdMTFhSWXB5?=
 =?utf-8?B?SzNmRUJMeWo1UngwanZaVmthYzdRQ3hwZnNPVGZsRlBrTVYrSVdMK0VGV21i?=
 =?utf-8?B?ek5PN1kwZ3dhSlF0SHpSS0N5YmFicFhGd0x2bEhjSzFFNVVmQlhNZm5YRzVY?=
 =?utf-8?B?RU42ckgrUVMrZUlhbHZUbzRaQnppVUhEOCtlUzRQY2Z5ZmxZczR2T3JPbUhz?=
 =?utf-8?B?TjVyQngvUVBzdys1R2JHTjRqTUgvNWdpNmJ6VS9VQVJKSWNJaEI1OWpBQnhB?=
 =?utf-8?B?UWlVTCtqVEFjckpETjZFVEJUZy84RE9VVGorRWtzNThLL0xEUG1mQ2R6UXBa?=
 =?utf-8?B?bU1sT1lLTm5wRDUycFBVbXJZaXp1Y0tBRnpkalhlM0prOHBsejBMTW1WODA3?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B291C18C9B21BF45AD99FF699FC219FC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2955eb-fa42-4644-7d85-08dad58aeac8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2022 00:03:04.7245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VxQuig6cYyOA6HJ28zoM4dYXyQrnRtD7dWuBy/Lu3ZX2YyeWED8XHjmwjZJCfaLWkA4JU+MG+hVS9WlYU+hmaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221203_160311_522991_724280AC 
X-CRM114-Status: GOOD (  10.37  )
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

T24gMTEvMzAvMjIgMTI6MTYsINCY0LPQvtGA0Ywg0JHRgNC40LrQutC10LvRjCB3cm90ZToNCj4g
SGVsbG8hDQo+IEkgaGF2ZSBzYW1lIGJ1ZyAiQnVnIDIxNjA0OSAtIFVuYWJsZSB0byBib290IHN5
c3RlbSwgd29uJ3QgbW91bnQNCj4gYmVjYXVzZSBvZiBtaXNzaW5nIHBhcnRpdGlvbnMgYmVjYXVz
ZSBvZiAibnZtZSBudm1lMTogZ2xvYmFsbHkNCj4gZHVwbGljYXRlIElEcyBmb3IgbnNpZCAxIiIN
Cj4gDQo+IEkgY3JlYXRlZCBzbWFsbCBmaXgNCj4gcmVwbyBsaW51eCBjb21taXQgODk5NTk3M2Q0
ODg5NTk1NjBjN2I2MTBmZTlkMzAzY2M2YTI0MmNlNA0KPiANCj4gVGV4dCB2ZXJzaW9uDQo+IHJl
cG8gbGludXgNCj4gaW4gZmlsZSBkcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KPiBhZGQNCj4gaW4g
cm93cyAzNTI2IGFuZCAzNTI3DQo+IHsgUENJX0RFVklDRSgweDFmNDAsIDB4MTIwMiksICAgLyog
TmV0YWMgVGVjaG5vbG9naWVzIENvLiBOVjMwMDAgTlZNZSBTU0QgKi8NCj4gLmRyaXZlcl9kYXRh
ID0gTlZNRV9RVUlSS19CT0dVU19OSUQsIH0sDQo+IA0KPiAtLQ0KPiBCcmlra2VsIElnb3INCj4g
DQoNCkkgdGhpbmsgdGhpcyBmaXggaXMgYWxyZWFkeSBiZWVuIGRpc2N1c3NlZCBvbiB0aGUgbWFp
bGluZyBsaXN0Lg0KDQotY2sNCg0KDQo=

