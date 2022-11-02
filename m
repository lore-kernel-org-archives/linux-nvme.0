Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCCFC433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 15:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=daW/pfiqHKgHDLkK7QAmAh2Q4kdqp4xIL6EAar2VI7Y=; b=zBlev3I2y7RKbaTS3IHVU8ZFyn
	qqIQCgFvk9BuNP+es6hqaTksH9nne5GcWWKDVe97Rxd4ZcOIdS39qo2upUCi9OKJszYh+k10Nep3k
	f2y5GQXOA9Ci3Da/zhlxXNZVVm4mZCP8RKfuGWjPT/EcLD52315VNv20qytsg2sqxDXYrKfDXfmkJ
	ig9IfNva9ziQ+PTTZYzr5VxhZc6eqTF4zVSdyuZUdceN6x6K8Jn7mBUdLC3Ju3JSWTvlDlLNott/p
	THg6FgLJJbs+IgHCkYtz3L2+9EaSo4e4PDoSfgQLbw/EqZ1z+HqzKgFy4qzIcop304xeE2ni7xxHX
	npjeAyKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqG6G-00Buw8-LX; Wed, 02 Nov 2022 15:56:20 +0000
Received: from mail-dm6nam12on2081.outbound.protection.outlook.com ([40.107.243.81] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqG6E-00ButH-OB
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 15:56:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8ZwGLdmGLglKkXGfqn0dtDix8HSBRgDTZSgCzlNvEKr1TeTZtCPzUTYqSdH44TENX0jMrIxwY13xlKD6Kl5RlJIjBXy+lY+C7zNOZKm4FuiplPESW9PaJE/mNRRFNmDMG+1VRHFL5v6GPptiF/j/lHGnF/+GboN7GcVJZSdF26v1q4Kt9VPHuGcbZUz4+Ed1c1stcljBFwcCbSTyWhIl8+C+K7/uHBM8TiDdv+8rLlbtuYjEj0typAWPwX1CKjeLFceEqXuB3BhYp6IvNMRs/3l4rsU9Fp3AyRlMLFIOSQ3xpu+n/xMTXR7TqiHW65EUPp7zyVvQRRG+OBXd/qv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daW/pfiqHKgHDLkK7QAmAh2Q4kdqp4xIL6EAar2VI7Y=;
 b=iUTgKGMPY0AHqOPDB4q30MZZiCDtxjqS8h5B6ZPZjE0IJ2wbNG4k+t+GmQ0gLtH+Zm7XknHkGLBoLYfnWejSNcQgviEXlgg5fr1tXk8Ri+gxdZRmCrQLtnHOfRW1CR0BskUNw+XSjr7FLOeP0LDF2vwVrhaGz68ZtXvUe78CydbyXuO0EpT8wDS2ABhLbb8bMH5KH3NjKHFQElP9JDLWxzrDBgbIwsbAGH1GTTjK5HljdQkFAzZBnN6cLhO2a+6O7gLlC56vohnsC6V1z1oVy7htLXZIC6eyyWdUhElT3IFOVPcAy1y3b7TpYk7NmSHhDnOb2p2MRZYa7oudThAasg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=daW/pfiqHKgHDLkK7QAmAh2Q4kdqp4xIL6EAar2VI7Y=;
 b=m3OzQuMOxEo9InCKj/Y4ZUCjVBfzTeuFSzh9RGPZsXaMd4IZ/fap9FHTEmTtYnBwl+U3Bd2ZY+1Dvc5f9GMD7pui1UqwgR82o6ANwR+2tJKs49jH0cvPPjLAEKcbQr1vhP0aAJIenZnFuADwnq2o5P+mkg3VuJN4LuYAOxTDWWwNsRtZ+i8qItHgyAph/LzM1dyLAmkoXopDPYGlr2s2Qr8K98go/3VEiA65pt50mTnyTKVpJiNlHaZJGOw1cnMUIIcYGVNVwJs6NP59I1GCLreLR/BukqtNkMIh62UzHkCu4Gug541wK6M68bulZMIgxOzhK1UV8p+u9AOA1Xs+vg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MN0PR12MB5882.namprd12.prod.outlook.com (2603:10b6:208:37a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 15:56:14 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 15:56:14 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
	<kbusch@kernel.org>
Subject: Re: [PATCH] nvme: implement the DEAC bit for the Write Zeroes command
Thread-Topic: [PATCH] nvme: implement the DEAC bit for the Write Zeroes
 command
Thread-Index: AQHY7HzZahvORDrNM0uFqqCp4z9Tl64rzkqA
Date: Wed, 2 Nov 2022 15:56:14 +0000
Message-ID: <e0806497-dc43-2537-3ee2-a7118a405e9b@nvidia.com>
References: <20221030162906.3390-1-hch@lst.de>
In-Reply-To: <20221030162906.3390-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MN0PR12MB5882:EE_
x-ms-office365-filtering-correlation-id: db7caf1c-be86-4784-945b-08dabceac546
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  BanqYoZDM5z3ViKc5dcc9RWZUcqw8oOb+lTtS8zmx2sABGoObbglkbIhH+PWgJM5x4wRTpHHLTZEvpn18fMYpldgGYS6slJH+TTJ1sMGKYUiv6bXPdCNiju2A3qlNXx0+X6qJkc+c6uTWQhlXTAVTylvjYC3nwCR7/KwRMQLO2epJTTSju541ECdoJoJcy81osfwoM92Eb/Th3yUtCg20liKQmQ81XBNDwASa4Pb/b1HYybmDOE4wrMPKKK5RlhKCJYpYlsRq0g1RmL8dEATYXDq5ZKbsEaDzXFdsTNogB3QrviQVVdyji21va0npneYw4JkndqpYqHrK6N3J/nxRkssUQqrd3WxKzrFUaEDLvjzduKrFrjYm/4L2tJ278NSH36Z35OGK7A6P1KBQTc9mYUqAc+irW8U33ZdJQObT4BNC/1DFDTZGVxk5bCqzcRR9hkoiC6+dN76vjhx6couiDLA8x1JUuyLxiFJeZ0UbF+Chi1B2DDpmFk8xQYrMAFmAf30vpxycMFWAZM1N+Jlf05tlSK9GZ3jQrOMfbMcL9rQIPGdpx5b6+wDw9xNuLXE5l4hithar2KXWnH++vDZ6CxfPj4YPAepoHq9PHX6NPs01TuQP966S4tjagcyKCCpbniBsYYW1eD5SfcWsj3EQekMpB+0PuaV9j2/kJ4jcrScAKnDYPjt81wQmYYXhAdZDJFG10JbZ4dYbdpr9o0RKENLA/DL6IDbNcwAk9bd1KNMerMIas5TcRS9fBddvk/D1Iw9eoHmngLLNhv6aO69ZZkR0WpAub+/M70nkIvrbo3dGyCupSrRXYhbrNwPChgACkuNtpt6kRcDCONfvvM2Ww==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(451199015)(6512007)(6506007)(2616005)(36756003)(38100700002)(478600001)(38070700005)(2906002)(6486002)(71200400001)(122000001)(53546011)(86362001)(186003)(31696002)(54906003)(66899015)(66446008)(316002)(64756008)(8936002)(66476007)(31686004)(66556008)(6916009)(66946007)(4744005)(91956017)(8676002)(41300700001)(76116006)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?a1pDdFFMWGtreVVuOXZsTkNMWEI1U1IwSmVJOUNFT0pWdVdrSEo2NFFmQ285?=
 =?utf-8?B?MUNzZklLQ1pqOG9hLzJ2SjdoM2ZzNUdSMlBjK3VWU3BJTXZWbEdVK2NyVWlM?=
 =?utf-8?B?WEl4SVRURVVBU2tTb0pNbm1JN1RMbEt6ZkNUQWEyQk42RTg1YW50dFoxN2lu?=
 =?utf-8?B?ZUljR0wyZWJPK29mYjM5Z05UQ3Y2MFpPMDdZL0pCcnpubjI0TkZFamxYTHlZ?=
 =?utf-8?B?QmlJOEQxYUpNWWFkSmZDdUU2NU9xY0dmS21rYVN1SWF0M3Q0YVZUQmF6emMv?=
 =?utf-8?B?bFBGOTZvVHF5Uk1uZkJGMEhxYkM0SnpFSjYrM0kyRVNrT1pKVU1Kc3k4L1o3?=
 =?utf-8?B?NWJzMnBya0lZVXpiRnNXalh3M284YnlsYzQyQlVBNldHaDV1MkJQT1dxZGVL?=
 =?utf-8?B?YWVxa3hUdnBjelRZb2tDOVo5bWVEcEJOTFEwdGxZZHAwMFpiSWtsOTltbEFl?=
 =?utf-8?B?RXovREFCZnM1SFNaclovUlN6azJkSGMxbkRJMnBFc1kxbm1KVTc3Q2QwdEd0?=
 =?utf-8?B?aVZwU2FCVno1L3dtMjludjJKT3YySmcxVDJlRzZ5Y25GYS95MG9KNzF1R3Fq?=
 =?utf-8?B?WlovUnNrOGF1ZkZjY3ZKZzMvMDh2WTM5bkZYb0p3LzhYR0RDK0NBc1ordTNJ?=
 =?utf-8?B?VjRselVmNlM0TTBGNFdmdEsvdFJDQ1Y4KzVWOVVoS1NQY3RmaCt0ZjJHTW1C?=
 =?utf-8?B?TFRNMTBWZkR0dDlTa3JXalZ1SVRVaEtnZWhIYW5la0xsZzBJaENGd2R6SDJN?=
 =?utf-8?B?V2pBVlVxTVA3UFoyM3RUK2dKZ1VzMGN0aWd6M09TWlZCODI5VFRxczY5Witi?=
 =?utf-8?B?M2t1bzVYb3dWd0l5TzdmUmplaE1xclRKQ29EMWxPOFdJL2RKeDF1bVdrRzNL?=
 =?utf-8?B?UGxVWGJGcy9rdFpVdTNXRGd1TWRjZ00yYk9XNGVaQ3FZcFEwVEVVYzlmS0RO?=
 =?utf-8?B?R3JaRjJWZERoRGQxVnZmbGhhQ1FhNGdsYVRFenJMVWRTbk5HWmh1MmtLV3Bq?=
 =?utf-8?B?UnBMREptSEpXQ3gwVGpxSkVhZkxGeVpSTWkwcE9IcFh0VmJrKzBLamtIWTl4?=
 =?utf-8?B?R0g3aHpvQlQ5TXRDUFVka3ZDN1lFM1E0UEFNcWdTRXdwR3Fxd3BCOVAzb1Uz?=
 =?utf-8?B?RDM4WFFWV01UNExvanRkdGxpTU9zMnErUllCOG9aMGNnSkViTjYwVlhzUWVK?=
 =?utf-8?B?S2hjREtIYW1SSXlsMnV1eUFZRUNzL3ZGeHNia1NxcGg0Zm5sRXNCQ2dUM2lv?=
 =?utf-8?B?NW1wb1NldCtzTlhxM2VOeTRNdDBUejB3bnJGMmpqRUxIYURMZ1Q1djY4WU9L?=
 =?utf-8?B?VGJmb3lRSTJYVlk3MFYyYXFtdjYyVHM0dzlFcmcwS1g0MmE0SXV6VDdGZFFP?=
 =?utf-8?B?WTZlSDdjNW9xNDZxelJkbUprMXQycWFWWWZuK21WdnV3eUpvQjc4SXM1ZHZI?=
 =?utf-8?B?dGNFSlZDZWx5TlpMbWx5OTh4d2dVZitBTFRDZlkvZGFncTZxTVVhU0t1OXhU?=
 =?utf-8?B?N1QvTnd0U1M4cSs4VWh1WjQ5K3U2QjZPbTRsVG9SMU0vNjVScEZ0SGJhUUdH?=
 =?utf-8?B?VjlFRUEwaHhGVUNpNnl1MWp0S1NzR0RVRHVwRW4yQ1RBWEtZbWZGdnZhV0VS?=
 =?utf-8?B?K3RKZWk5MStHRjNWTFlLWm0rL2h1S0diWVhTTVRLNHJ3MnRFTXBUZU10L2VV?=
 =?utf-8?B?NVdYaWpmWlR3NmpzUlExVjh5K3piYlN5WEo4ZHFQa1krNTI3clFDQ1Y4dTlE?=
 =?utf-8?B?OU9tVERQb3FQWUpUYUZaK1FCSWN5ak5uQlQyeWNrZittOVFmS1NZVzZ1UVNa?=
 =?utf-8?B?V0MycHJMUGJDc04yT283QXhRcythMVR1YXNLOFVQRjhMOTV6MW9mN0xUUTVZ?=
 =?utf-8?B?UUdoQXRObGI5M0l2VHJFdmZneStUcG1CS0JicVBpRVBadXlXczI0T21td1Fv?=
 =?utf-8?B?em8wOVozamNwN2YyYkNMZGhlVVhrZVpyQnoxNE1PeHlNRnJTK0M5bGFqTmVw?=
 =?utf-8?B?NXh3MDhsbnp3NndoOVRKazVqa0FGWVo5QUcrRGVWWDFOMlkyM0FBY2FxYlJr?=
 =?utf-8?B?OERyS0dyNkRnT0Z4Q0N0N0RMY2wwOUE5ZGh0OFNBYUpWTzFMVUFESnBTU3Z4?=
 =?utf-8?B?MThjc0YrazhOK1BMVkxkb3Vkc1B4YUwxbUNPYTNiUDRJR3ladVc2bzNTWkM3?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B986CDE3C5E9B54499EAEDBDFBCC17D5@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db7caf1c-be86-4784-945b-08dabceac546
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 15:56:14.4296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1LsFZtnaYzSE+WAIj4inZTs8Drq0nynYM1QMSis2cIoWZZ1WkxmtE7QYrkdFKlPAp4Nz8C0RVq5biN71hfg6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5882
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_085618_829109_35BF6058 
X-CRM114-Status: GOOD (  16.05  )
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

T24gMTAvMzAvMjIgMDk6MjksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBXaGlsZSB0aGUg
c3BlY2lmaWNhdGlvbiBhbGxvd3MgZGV2aWNlcyB0byBlaXRoZXIgZGVhbGxvY2F0ZSBkYXRhDQo+
IG9yIHRvIGFjdHVhbGx5IHdyaXRlIHplcm9lcyBvbiBhbnkgV3JpdGUgWmVyb2VzIGNvbW1hbmQs
IG1hbnkgU1NEcw0KPiBvbmx5IGRvIHRoZSBzZW5zaWJsZSB0aGluZyBhbmQgZGVhbGxvY2F0ZSBk
YXRhIHdoZW4gdGhlIERFQUMgYml0DQo+IGlzIHNwZWNpZmljLiAgU2V0IGl0IHdoZW4gaXQgaXMg
c3VwcG9yZWQgYW5kIHRoZSBjYWxsZXIgZG9lc24ndA0KDQoncy9zdXBwb3JlZC9zdXBwb3J0ZWQn
DQoNCj4gZXhwbGljaXRseSBvcHQgb3V0IG9mIGRlYWxsb2NhdGlvbi4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCj4gDQo+IEJUVywg
SSdtIHRlbXB0ZWQgdG8gc2xhcCBhDQo+IA0KPiBGaXhlczogNmUwMjMxOGVhZWE1ICgibnZtZTog
YWRkIHN1cHBvcnQgZm9yIHRoZSBXcml0ZSBaZXJvZXMgY29tbWFuZCIpDQo+IA0KPiBvbnRvIHRo
aXMuICBXaGlsZSBpdCBkb2Vzbid0IGZpeCB0aGUgV3JpdGUgWmVyb2VzIHN1cHBvcnQgcGVyIHNl
LA0KPiBpdCBzaG91bGQgaGVscCB1cyB3aXRoIGEgbG90IG9mIHRoZSBkZXZpY2VzIHRpbWluZyBv
dXQgb24gV3JpdGUgWmVyb2VzLg0KPiANCg0KSW5kZWVkIGl0IGRvZXNuJ3QgZml4IDZlMDIzMThl
YWVhNSBidXQgSSB0aGluayB3aXRoIGFwcHJvcHJpYXRlDQpkZXNjcmlwdGlvbiBpdCBzaG91bGQg
aGVscC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+
DQoNCi1jaw0KDQo=

