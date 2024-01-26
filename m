Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A404FC47422
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 06:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SxzNcLxvr0/YfoJaY4gqtgOzHebJu1SqC8kA+PZgcDM=; b=kJCcPBWN0xHQF65D3f9GtqqAp4
	jjhguRB1jJcazyGRfMI2q3y/oqkYr/EUGhB6lzOU5rz26iSbngfRCOv8VRmvJc7lpE3AS2Q3zI3pV
	HutJXVpYI9ESRKPgk8g6XzyBV4YWkDrX/fm4y3moBxH8Or1upDA0OKIUW81axsWS0kx0e/RfPeeLz
	pGHkh1sAOirmMCZxhyMrxwxiybZ6YHt/09yCPsKq8H+qjCV08sALUBluvuJFlZJxPQQh28whmxwiR
	atTEasKjOxR4D+Qvh0ytFZ713BqGXcELi8xjCWxxlHXuGhJiOJQXb+OMOQRBTznDKyUNbpr2XPqIi
	nDO452xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTFwR-00000003Gnq-2Ye0;
	Fri, 26 Jan 2024 06:43:55 +0000
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:200a::601] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTFwO-00000003GnR-1W11
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jan 2024 06:43:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU2y3GV9Iv6qq5NJ8kFpJ5YjFpwhwumU7yzJAw2hTz7uItXjFtHoVYX6n6hM0xAoNa7XQ3pcE4jhyEVCSYMZgS7ax271HCu6Z29WdbkzzG30OuTKumkPpdYRelq4CAGiqrR2zlQPEsjWQKy3whmO015i51T9vfCEqVEMKzSlNEwpbiW0ihKD++JxSioj+LQO/j4uob+EkLVUILAPEo8TV1Z96MUz/JVjHYIV+gQpS16uKeo/j6YmEhE4aclFwM0KO6iLAlpTpXuUfZy3em3rbd4MPL8eiXn9FAvtnvbgdDwVipbfoPxREZ7JvkvCk0H+RWQWFpQ7afBCqOr4mOZtCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxzNcLxvr0/YfoJaY4gqtgOzHebJu1SqC8kA+PZgcDM=;
 b=RFCiuXtFh6xNtxSxHpmG+nCvvimxl3Zc5kReoLq60jhEQMi4fh2Wo3l/RghDujdafEwtfI92o74tg+1kzJm/th3XQVHYJ/3u2c+2vp2kBk55EA4FzqUEHa1cEQBjuw4IDXcvL0xPpS9x0nOEJg8K+RdfyNYRb5cA1a8CLhpkWE8Iw4ac49bPHzYbw33h2FjuBDaM/yMAM2l//vvPx/sK48trAYyXVH3So/hdAHkPjElthA19/22+J+kSWE5oK3tnxh+NT0nXmb4izAcigfGH8DJdPTjGX1n8DazxIGGjXLahX8nGvIBMTC42dwZ8zG1r6wnnxu1WVZXM+fDcreHwlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxzNcLxvr0/YfoJaY4gqtgOzHebJu1SqC8kA+PZgcDM=;
 b=ssD9kE9N+xJtaa9YX12pOLb02K7C3AYKtmI2u31W33QYHEKXKM16uM+4W0Crc8pwo4ejpKy8OxJOMN1F1kshxz/HpfyvBHjidjrTjSG16/5Kocql7pcwCpMsLw0Os9WMTKILYOLtkOVV9VbtVnbKcENOlijx1auAr+55mP6SindUNluRWApMDwdKSyBONtjlJCtfEzNy18Y8wH+2EUh+TlHp2MnNMlfQmHi8a6Xtul2sBi++ikHasFpu9UtVldrzG21G1v9Zgaik3R0ujmAZO2HT6IWxZ2h9BxUHePJFOqcpKDKs1tgwV+dDMX+kr0pKP+xWQtUi/dGfdvrMXwEveg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 06:43:45 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 06:43:44 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Kanchan Joshi <joshi.k@samsung.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH blktests] nvme/046: change nvme io-passthru command option
 from -o to --opcode
Thread-Topic: [PATCH blktests] nvme/046: change nvme io-passthru command
 option from -o to --opcode
Thread-Index: AQHaUB56uY8Rnm69G0qKlLC7merclbDrpcYA
Date: Fri, 26 Jan 2024 06:43:44 +0000
Message-ID: <ee716c95-8c03-4f03-85b5-f71bd5cabac5@nvidia.com>
References: <20240126061037.2169224-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240126061037.2169224-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|MW6PR12MB7070:EE_
x-ms-office365-filtering-correlation-id: db195bf3-579b-41a3-6ce6-08dc1e3a2463
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZRVzXMLNs/1YxPXavYNZ3QtIWvuQBrXdyBLyNx5zgmTxS9usReVFLhdRHJz0DF2AnPv5BMynraO7ihWxPP+6ZI0fJDVdV28l746K3OVG2Lq8pIGLSXGw+0FSvyRbFmJCN39ZbmGUljD9Aet8rZLHftVWs9FH6enflmYj6heRaPpP693XXzcW7D2rg9ZeXo7m9XidmRiElwrXoEPc6UVql0Z+5bhv/FEefsWJ+nG+HM2qsbCiR4oGPHRcRtKeTDJ0Z7KddznUS6IkB3iTILeIj7pch7GBOgWhahSoa3h4ocQVP8CHkLjtRHvw0u+DFODCpiMWmVswp8nlJF5kT1lAvTnx+9JSgVFLNGqWO8p9Fi3VbIxS6LRwGihfoYF9LPIfrDzBZKFiU+A/V+QHML2KKOoY5BgatzHW88uBDDiP5/Do/GMCsrM8/uyeQ2Iezjvc/4FvJ5FCNzgLSO2qccgrS1mJwkZOyEHQboEzE4NmGWX3wDemBY7NSfIZARAUSCPH32uaDtr00/f40hga42j8LeYRqCPPVHLymimUtzrFajDIukti6YxA10J4d3W1cUg1koYllIRSTFXoGkWAhBdgMXMgFJbZgRpT4mK2qeiHJSX++vJ+YwekfmupZ/2XXgiUuvp4xHmL7WDoAh3Jw+nEMWvaJKkL2mHhsM1XwC9x9Zxwb1xWtW7630wlz3IeO91c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(31686004)(41300700001)(83380400001)(110136005)(31696002)(36756003)(86362001)(38070700009)(38100700002)(122000001)(6486002)(26005)(2616005)(6512007)(53546011)(6506007)(4744005)(478600001)(2906002)(76116006)(91956017)(316002)(66946007)(66556008)(71200400001)(66476007)(64756008)(54906003)(66446008)(5660300002)(4326008)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M2Y0T2Y3Uk1mS2Q1cHhYK2t2N3YxUHJwZlludzF4dXJWd2JIdXFrYjRVN2s4?=
 =?utf-8?B?WjdhdXlwT2tkV2NaS2p2RzVaYnZMR01tOW1sRHJmN0lkOUhSUjZEYjlNMFlH?=
 =?utf-8?B?SHhYbGF3WUdpYjhFRXE1VUhQS0JsNVlVYWh6T3Y0NzFjR3BYaC9iNkxxVFBW?=
 =?utf-8?B?K3d5QTRzNURIdUJCNXoreG9HZW1zOEVLWmtNbnhobUovbVZ0aVo0Z1pHNXc1?=
 =?utf-8?B?TU1wa2R3ZVFkR1kydGhSTTFHRjZOcjRoZnRVNHZ0alBtWkNkeHJjQ0RiYUQ3?=
 =?utf-8?B?NVRpeXcySFRqUHQ1SWVlcDRuTlJBYU5ub2hBZ0NqVHRQN21HSjJjQzJ3THN3?=
 =?utf-8?B?SUIrcjJXT3Frb01tY3ovSkZYblV2REJIcndLSk8vdjExVG5wRVNzYjJYdE9p?=
 =?utf-8?B?Y2JtdGdOU3p5K01PWWUrVDJwajJRajBZT2hLK2IyU3JyTHJqUHlmZ1FCeERD?=
 =?utf-8?B?SXZRWkNHTTRzQ3U4YXMzUGE5TE5EY00xNTh4bko3aC9xSXVHakZ2cVpERnU2?=
 =?utf-8?B?NVl0Q0VBYUozSkZPcnVzblZMR0J5L1piTzh4QTA1cXU5M1RVWXB0K05Od05V?=
 =?utf-8?B?TE8wcjczZHkzYlEzYUZuaFRrbCtYcW10eUZWVVMwUHBVMzFObi93cC9rOFVm?=
 =?utf-8?B?NTBmZkJBYllZUmxMU3M4TFFpdFFwUzZMeEJNQU55T1dkVFArajN0NzQ5RU85?=
 =?utf-8?B?YkI0RjgrL09YWWZaSldobEZsaDkzd3Z0YTlaUDVReWtoM0J0WTRVN0k1dnNn?=
 =?utf-8?B?dndhTk5rY05ZbFY0VEZtUFlMUVJSZ3hBQ0Naa0lybjZZQk43aHpKUlZQWkl5?=
 =?utf-8?B?TGppYm4wRmIxNmsyUml5MUptU01SVHVyYmUvOVZCdVI3N0hadThHQXd1eHZy?=
 =?utf-8?B?ZWI1cUpXNENUR3dUazE2TjhkT3FGekhhTnRPUWFxeXJIaUVVeGkwa0R0TDdq?=
 =?utf-8?B?emdwb3JUdjlMNStiU2oyZlNjNlhUMVgxYnp3OG9EVWhHMGI5SVVJQ1NwcXlM?=
 =?utf-8?B?RTNkTlZ0OHd6WW85aWFua0lsY3JCTldMVEtLUDVEM01ZOGdDaXdNdkNjZDNs?=
 =?utf-8?B?ems4ZE55NjFWbkpiQ3JKb01IYU9FSjZpL3V2dUg2UldVTHhUOFErTGtSMWZQ?=
 =?utf-8?B?UjVwVEljcjJJSUJzMmppM0orSjJMRGNrR1FaWWpyOUcyVVd4aGMxVUdOaWV4?=
 =?utf-8?B?K0RSSnpFdld1SzJqYTNhclFQSU5JUklmSXNvaStNS3pzbE1QNHJnT1NsM1g0?=
 =?utf-8?B?WUZIWVNENWhoNGZSMU1NZDMrRlBnSHJrcE9mNlZ3aGM4R0FHaUdpbE9FZENX?=
 =?utf-8?B?L2ZtSFJ5czNNUXh5S09hWmxUVUlMd3UyQWhaSU05YXpCRnNrSzQweU1jZGZD?=
 =?utf-8?B?NUY3UFdZRDZFYzNCdHhZeU5NQnVGZFNjdnFyWEk5Q1ZEdHMvMllWdDQ3ZFF2?=
 =?utf-8?B?M2xleFE4RkZhT2NwOU5KeStGZWd5THNGSzlQc0NoaUNsaWY2WTFONGVoNHZG?=
 =?utf-8?B?TWlBYmYvOHRKQTZUanEzcXdRZm9MV1ExUitHZHpDN3hvVVc2TWNPZElvbFly?=
 =?utf-8?B?aUVVeURlOWM0eXU2dDMyNFUra0lvV1BBZmNIQmdJMXRERmIxKzljeTg1NUxk?=
 =?utf-8?B?cytHcnR0WkljaTNDRkJvb0I3dTB5VkVCQ01uYWJaNkhSUTM0OHpvL1RFSDdJ?=
 =?utf-8?B?WUU3V0M5dTF6SnBjQlptZ241bGZnY0gvY0xZcWZMYjhZRU5iQ2I4T05WaFJO?=
 =?utf-8?B?bi9yR25TSmxwektDT29CQ0U5Nm1Sclk1bzZrTytlOFR5M2pSc0ZxUUlhdEVk?=
 =?utf-8?B?NHBQZXl6OUtiN1grTTBERmpTNW1WanpkMXVhQ1NXSUYyL1h6dHZ3SnZpMkhk?=
 =?utf-8?B?ZVJ3WVd1a3NCaFkvUkVGcnllemlaRWVYck14eUlWc3BWdUhOdGp0Q0JqbXlN?=
 =?utf-8?B?ZUJGUjZjWktlM3ZiOURTSkhUVVZ5NllwWDlaWnpZNHU5Ulptd1FYM3JEcno2?=
 =?utf-8?B?eVp5NXpSLzZsZysyZEJkcjBYOW1SRHk2L3QxbW5pN1ZMckYzK21sdkg5VklM?=
 =?utf-8?B?ejBaRjh4czdOeFluTjNUNlZkc0N5UVFNM2RNeHQ3SitBRk5ncUVCQ2lPN2o1?=
 =?utf-8?Q?SEvByIJ0s+cktbGIBtjiNCYpx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D34753D7EDF2CD40A8CE18435FC236AA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db195bf3-579b-41a3-6ce6-08dc1e3a2463
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 06:43:44.6767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmoo2Oq2/VLPQMUdZohCcCITpKYs8bjAY0VLFs84NcI9uqoeZ87Fj1QFpOgVyJcOKhlXnAjs74Aav7naejJMFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_224352_438774_B52B3E65 
X-CRM114-Status: UNSURE (   8.42  )
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

T24gMS8yNS8yNCAyMjoxMCwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IEEgcmVjZW50
IGNvbW1pdCBpbiBudm1lLWNsaSB2Mi42IGNoYW5nZWQgdGhlIHNpbmdsZSBsZXR0ZXIgb2YgdGhl
DQo+IC0tb3Bjb2RlIG9wdGlvbiBmcm9tIC1vIHRvIC1PLiBUaGlzIGNhdXNlZCB0aGUgZmFpbHVy
ZSBvZiBudm1lLzA0Ni4gVG8NCj4gbWFrZSB0aGUgdGVzdCBjYXNlIHdvcmsgcmVnYXJkbGVzcyBv
ZiB0aGUgbnZtZS1jbGkgdmVyc2lvbiwgcmVwbGFjZSAtbw0KPiB3aXRoIC0tb3Bjb2RlLg0KPg0K
PiBTaWduZWQtb2ZmLWJ5OiBTaGluJ2ljaGlybyBLYXdhc2FraSA8c2hpbmljaGlyby5rYXdhc2Fr
aUB3ZGMuY29tPg0KPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1
bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

