Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4883EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 08:42:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1208561B3E
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 08:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1208561B3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G/1NSaaCE/q6Q/iduehXRJXgc7ObM7yPr/Us8YnDZdQ=; b=lim0yBhSGQ40Blqbc/V0obI4Ed
	lF2ecfHzb3jT3x5cbFwsKcDeJ1ntJGXNqQFSz9Vd+nT0tBt9eGNTHRt76yuY6HMahFsrZFkIuxefw
	qkQalwtFcNKuJsnumdddq4eqC0MteAQLPiu1AJJqq3rbnUvfpmfBjDoj87/CPQ7UGCoTOjtALlSx6
	XnQ4KuEMyreJMvNo4/YyumgjGmPn9/KYuzLz7FC4dMaoshEopO5dxYaaex/8Mssx3eToYCqEkRJqN
	yiHOZ914B4p7zOhAx41AeZAIeMjaAVBp3QEy9paXqzTgaIo//rsVGucGKxMgXPYtDIr23yuCMOIuf
	N6SfBaTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnd09-007EkM-Cg; Thu, 18 Nov 2021 08:42:37 +0000
Received: from mail-dm6nam08on2084.outbound.protection.outlook.com
 ([40.107.102.84] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnd00-007EhA-EU
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 08:42:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4gDPUKguX4if9jfOYmocQvE96Cdeoi0ELj2Sk1UYWod1UtHSCYxIVUUjL66j23VXKgwjM2Y49XJ5ntjaAre/AebZIFoSGAKVTpEtchHT4EnjYeCWyO/bu6R/+XQAdUQ8r1XWeOuyHzK2iGG7Opf7QVK8thswKQkTmmHRjXdsasDHwvr6EfYOgo57QabWXkGXHCApsQ/2ufSoJQ0L9lukCutDR2SObwIGjqIxAXiFu/Asju/lhLOj0GF6fJ8UlanyRw/r68dOTIdDwHzWfEQmV5q/yeaAwp+e0zk6urA22fgmetRf4qK8IpnkSYHgPqkDauFHCivBiwWl2/udupuqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/1NSaaCE/q6Q/iduehXRJXgc7ObM7yPr/Us8YnDZdQ=;
 b=lvFGFlLjcxtxqpBJaGXzzRdQNQBha7kjBHFbobWo3Swjc/KgBMc63QPkK3hGse3jNZ3E57l8OwWjE4dKpajXwN84Giz7PkHTnGukjdXzybObG3UFAshyNGafqNunKAOin9dk+pzXouH8efLx+quCrgrZ3T8gc6ysoGBlNUQdsmWoK0VVpnbDVcYDEz7Z/A59Q5QulNiqbxL8FLAo5y6CdX7b4zV6nsIlPHn64XqPStAG2Zg0UopXLnK4jYhXKmxIndVsYazZQgxrlGBFNF6HHVhNWUceDXb17FrDboZ69o2hbuGX8ogN1FIL17Z67kx6E4aRaZ2U3GbYKdM8rvrSTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/1NSaaCE/q6Q/iduehXRJXgc7ObM7yPr/Us8YnDZdQ=;
 b=fhL82XaNQGa2QbpGHL5xrs3vl3pE5seKG1bMpNRKm1zi08Yz75Ndq/XaTesEq3yMLJgE499NjBfVz55X3arqDw1tjDTj9Gi19V8eso7c0Qa8zqYnigRU+bvxejtlaRXjvKqVYDzmXzRE/z6Ez7v8lvM6f32KFvG/vRhYMvrL8SX2XSzAO1NbO/Mk1TQDSm8HbyzkOsZICBjy743xCQgcRjKTrOtafVoDHzgbKDlIiLMqv0QBFQx40/ujpdv5mRqhHcKtWD09qfRis4xRWa+EYSWnN3RjhmEpAeH3p11W2tjPVWA31N0pGg4rnAxMFEIDcSca6oQ+Fv+HciKrjBZ8fg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW2PR12MB2442.namprd12.prod.outlook.com (2603:10b6:907:4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Thu, 18 Nov
 2021 08:42:25 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 08:42:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@redhat.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH RFC] nvmet: fix tmpfs-based backstores support
Thread-Topic: [PATCH RFC] nvmet: fix tmpfs-based backstores support
Thread-Index: AQHX28dMLa7pEe33C0eG5lxvCwWZk6wIiEmAgABs9QCAAAOgAA==
Date: Thu, 18 Nov 2021 08:42:25 +0000
Message-ID: <51450d94-43e9-16d7-46fd-c678afc34e53@nvidia.com>
References: <20211117152454.122014-1-mlombard@redhat.com>
 <b0c0a83c-df9a-0a91-1dff-f6bc647a5b81@nvidia.com>
 <20211118082928.GA82729@raketa>
In-Reply-To: <20211118082928.GA82729@raketa>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 768cf4af-02f9-46f4-a3b4-08d9aa6f58c8
x-ms-traffictypediagnostic: MW2PR12MB2442:
x-microsoft-antispam-prvs: <MW2PR12MB24420B371E73382939182ACDA39B9@MW2PR12MB2442.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FDEDFthuHU7g6K3lrPHfsNXivmxBUCEaduyL3Jq/tjtGnaivLyLEsKVNl7EQEMPq/TK925G4mFAstxv69mVyszHMtqegQb29c+FSYiU6TmNLleehyHHP3Z2l+0vyQ9Hc5aSDtjG63bu7033VIcbrBRn9uYf7/kQrL48vP5MoszGwtt8K2TgoGQJk2XxwoJ74tb13WJFv0boWcjSy+CSK59JeAwFPQ2jn0ATZd80l4/KJKR0eVb3VlYvQqesQ89IYoAwpxIuStFcCWSAT/gnVTg+Bu1GSvTznOV8XEsRKohj1Dh2xi9Gqy9DxekuzHSPe7+o6auo7aOlyzjw+2/9Vslhqm6ZXBM4kMQshQChHwWCSC49j6d+RzYGu5/Uc+mozM9grh+jc0XVbRtU2VfFIoSxW7zq/iTKblWlEE6cyeTz+jx6MsEp4HlTnl9iTE0TibK7dx23h7BlTiMYHwpchDPdZT2mrRCVR6u+CAylZ0XPcV+yq4wFfG6f7uUmZ5Tt8WdKLaxo7Se17jmGL9OvEsxycbkOxIrcwQQpYxwIYuwvSnaGJwwZnOZH7wv22AtgEDiTcsLJgE4p1hwLhWZyAI+bNAgnD4UhCqMQFWeKfEgDh7kxiaJFJw5LkDZ0t1qcAbfzb34L1QLOWhrAVMfdGYrJNE54bWX27Au7VikKwKrY5/pY1jH+d79buT2g1QiS/R1616u61vjgfPaVzpZRyqYVRpI1GZ3YQWtcSh7oAvCdpB9kktkQK1RnzqcSflPwiS90WDT6B4kIIHkvBBt2f+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(31696002)(66946007)(508600001)(4744005)(91956017)(38070700005)(76116006)(66556008)(66476007)(64756008)(6512007)(66446008)(38100700002)(122000001)(4326008)(6506007)(6486002)(53546011)(316002)(36756003)(71200400001)(5660300002)(6916009)(186003)(31686004)(86362001)(2616005)(8936002)(54906003)(2906002)(83380400001)(8676002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1h0NXBGYTJqc3Y1dzZKKzR4cjR6OHFoYUpzT055SWNVdVJXOEVLRlNvOFRj?=
 =?utf-8?B?eTF1c1NSVjBsM0pTZXJSY1lYaE1BM1RJeitxL3h0T3A1WXBkcktJbnFDVUpY?=
 =?utf-8?B?aWdMQm1keVlmRFl5bVdOOHY2K2pKcC9HZWhMNU92WWtWZi9zYm9nUGFvZGNs?=
 =?utf-8?B?SUVJbDBRWlpEeXU4UUxJbnh6aFMxVCsxTjRjN1FJeU90RGlNbHlSWDc0N0pN?=
 =?utf-8?B?YWdBNXpHRmZ3V1BFTlZUR0NSN0tBN1VxMXlvbko3K2lGNmR3aHQ4T1E5SHN2?=
 =?utf-8?B?dHBlWE00RXl2Z1FpOStnWDlLd2tXSlF0OGxQKzN3eVZ2WDV1TUJsMTJkdmhJ?=
 =?utf-8?B?QThsZGJYUjhudVMwckk5UEt0OXJTUjZSbU9LUTd3SzI3a1luMkZwWElPU003?=
 =?utf-8?B?RG5ENXhZTTBNcVVsTGpNeGhnWHZ5VCttc3VDNXYvOUpKV3JSWmh1RXhhTVVC?=
 =?utf-8?B?VjMvbzR6RDFkVS80a0FhcXQ5NXY2Nk4zZG1VeTdPdWFTNGVVVGkzVzNEaEMy?=
 =?utf-8?B?NktubkdBdTVXWVVISG80Zmd1clpQZXBLeEFDbGNkV3dYcktiZmZrT2dac1p2?=
 =?utf-8?B?R0JVVlM5NFpIbEdRQ2NwMC9NY0xCMk9OOVFvUUpBRjlrcVRzVnZMVGo1NWt6?=
 =?utf-8?B?UFVTcmErZ0J1TldoYkZWMS9FQVhwZ2hyUmRNOHprc3JFa0gzTHpMSVl6WTEy?=
 =?utf-8?B?ZXBKUVg0WGhvbmZScDN4RVRxTkhKZWxENmhlM1haV3FlcFFhd2hpT3NiTFZ2?=
 =?utf-8?B?UFlQZ2IrWW93QU1Fb1RuT1VtVC9qaDlCd1VvOURZMU4yYU1CMG5WalFxUW9X?=
 =?utf-8?B?dVZUd3BLdzdBTlh1UVAyN1E3Ni9UKytiREpqSzR5bzdCNG9JeG45UHMzOUZQ?=
 =?utf-8?B?ODNHaUlQb0x4SFNhSmR2b3VRZjBCVmxwYzQ3T1EyMnVYd1drSGdCeTE2Q2Vr?=
 =?utf-8?B?c1NpaG41M0J5SEZFVGFsK1RTWmtsSVhYWjYrZUwvb1VHck5lN1pvWkhxUG5a?=
 =?utf-8?B?RUhucXpnbUtZWW1CbXJ6eTBJVzFzSmtQeUllWjhUUElWV3JIL0pGZENPRTNH?=
 =?utf-8?B?QjlCcWhpb0oyYXA0SGl6VFcwNkx6czNBYzJvTlJ1N21NTWFCcUcwdHd5U0l2?=
 =?utf-8?B?MEtFemdFWTFjY2w4WGtwSWhBZ1diUXlEV1FSaFJPK0VYWUpqWGR3OHorSFBV?=
 =?utf-8?B?QWU4Y0xWVWpjVXRrL1VUc1Yyc1pSbXpqTWtRVTdKTWM1QWZWNmhtejcwZzk2?=
 =?utf-8?B?ODFSMk8yejdKYU81OVNGMVJhN2hPY09sZjZIK1N5OWhFMFkzMzVnRzBVRHFw?=
 =?utf-8?B?MUZobmdkenI0VnFZdzBlZlRzaFJncXhEL2dFa1U0OE5ienBwQ051cm5rYyth?=
 =?utf-8?B?bXNHVW1UUlRDM0VjZHBYYW44Z0VqbHVIOWMzYW91QnNOWEgwWXhOeDBrRHhU?=
 =?utf-8?B?dkthODZsanp2ck1CRHdQcll2SmIzN29SV1g4VWwyQ0hqdWdoSlNjVGtWZUVH?=
 =?utf-8?B?TEtvZThPMEQyWko2YUNLRTY1ZHlSQjZOeWJ1bktDdDZHeGJmaGo2N0lGN3kr?=
 =?utf-8?B?djNaNkJtUWRGNmRFZDh1ak02NW1Bcyt0YnlNQXRjK0RCU0RsUDl6SGJ4WlNM?=
 =?utf-8?B?eGM4VkQ1dGE3RFIrdkMxTU54TnhSTzFzcHpydFRIOWMvaEpmSUQyZEFTbnZj?=
 =?utf-8?B?M2RiSmZWOVdYYUJCRTJWZk5aR1Z5SU9jN09LVXRZeUFkOXBnMGZvL1QzVzBE?=
 =?utf-8?B?K0NEcnZkWU9wZmFpSmdXeE1JY3Q3dEZYbUhZQm5qQmltTUpSbEx3Qm1xMWhM?=
 =?utf-8?B?N3JVQm9OUmszaTArRCs5MHo2eW9qUjhzMVFpL0Z3NFNEbUlxSlVESFJsMmRT?=
 =?utf-8?B?d0RvMGRmVTY4Q0ZIQUtTWVRjbnA5dGM0bTJFMEVUSTNCTFppMWVwaGNodVBO?=
 =?utf-8?B?dUFYN0Z2UjVZQzJ2SldFWnozZ2ZVU1kxVTM3YksvVS9SNmlJVXB0MGdveERK?=
 =?utf-8?B?d3NWR1hXR25NZHl2M01hdlRGbWxkR1p2WUhzL0xyMG1wS1dNdWg2cDVZN1F3?=
 =?utf-8?B?dms3MHFxTURxM3NDK2pJajZraUlremlkUmhSdUhuZkNHQ3FTUGJnL2ttdjVU?=
 =?utf-8?B?UkF5MVQ4UjUwazZ5amk4RG8vT2RoNDcrVXZZMk9YVHM4NnJMbGp2N2FXQm9Q?=
 =?utf-8?B?L0FqSDV3RkJ1aUllZldkTHFuL0psRGR5SUtnMmdNL2ZKOGNGcmM5R1hDOFZ1?=
 =?utf-8?Q?uoJdTaQF+z5eQdv4ojylACyB7wwCuRasomdmHznP8U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6E7884921A5044385D7C80B8AFFAAA7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 768cf4af-02f9-46f4-a3b4-08d9aa6f58c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 08:42:25.6242 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 712AuG0VnebuGrusveC0AU9dzAwwNXpXnu7hB92JVBym3TLuf7iiVC7jV48xAIDvOcrPpDVf+g9KDf+78fDo+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2442
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211118_004228_549973_D57ED529 
X-CRM114-Status: GOOD (  10.00  )
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

T24gMTEvMTgvMjAyMSAxMjoyOSBBTSwgTWF1cml6aW8gTG9tYmFyZGkgd3JvdGU6DQo+IEV4dGVy
bmFsIGVtYWlsOiBVc2UgY2F1dGlvbiBvcGVuaW5nIGxpbmtzIG9yIGF0dGFjaG1lbnRzDQo+IA0K
PiANCj4gT24gVGh1LCBOb3YgMTgsIDIwMjEgYXQgMDE6NTk6MjlBTSArMDAwMCwgQ2hhaXRhbnlh
IEt1bGthcm5pIHdyb3RlOg0KPj4gV2Ugd2lsbCBuZWVkIGJsa3Rlc3RzIGZvciB0aGlzLg0KPj4N
Cg0KDQpPbmUgbW9yZSB0aGluZyB5b3UgbmVlZCB0byBhZGQgYSBuZXcgYmxvY2sgdGVzdHMgd2l0
aCB0aGUNCmNvbmZpZ3VyYXRpb24gdGhhdCB5b3UgaGF2ZSB1c2VkIHRvIGZpbmQgdGhpcyBwcm9i
bGVtIHNvIGl0DQp3aWxsIGdldCB0ZXN0ZWQgZXZlcnkgcmVsZWFzZS4NCg0KDQo=

