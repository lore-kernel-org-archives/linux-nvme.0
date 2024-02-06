Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1F89C4828D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 08:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hL/g972Jc5Zmc1xLDof3fCcnzyYRUdrAJCkJd/0nvjU=; b=idWMQXNOmqqNkrs2Yticv/bOlB
	U7ppNDIh3YFocu9i9j4LWs6qmZwKIfAgbGF6J0ueD+2BDkXQx7EFsmQs8m8A2miU+SksbkAJrQ3Wg
	Fpb88saxt8tr/thWX/EoLvzB6cGmQ+ChYAiVoYDoaUl+PR4165+GQKurxeSJOSn9/YSWn3+OOWJ0G
	izh2mmvlzIrE/yLaXpoFAIxm5vcMU+gzY4HcOslC+JINfrZK9bBfV8W1A/WdBCmAqmad/k8qY+efA
	JfpLc3LJtxm+BchJSrStzI+0aOXWFVHWlg4CZQzWEz4US6XJ1apYpeZZO05NbBXZbJmw7sHK72qyp
	FU7bnXdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXGus-00000006S2z-0mQ0;
	Tue, 06 Feb 2024 08:34:54 +0000
Received: from mail-dm6nam04on20600.outbound.protection.outlook.com ([2a01:111:f403:2409::600] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXGup-00000006S1R-2Hzq
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 08:34:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H0/2uHKTT+DZZSr+ZQgZt5OJXBOnUJgs17Qdy3S6lkBxvUhejaBUv/VPyycLQ71miyKtGa3vE4t3C7s/P8IAJ9/kdFwDB4v8EwHFk7zUoSti9R2Pd4Utq/Oi1g9YLC9f81gT0vEFZqHhxElX+FSBsWtNBZWW9sP18i4HpCBRsLJdlvGUYymU104W4bcXhOqBE2cr36p5nr2AQ6CcujtxUvc0yEfrOmImQXQBDwOTPoEGDpxBRqZbirvc3B4GcFIMD+bePBCF9qstZ5p34uA0O3DkyTC7COW+xMO2WFSJ4/ZL5MA8q1+TROXUT4pdKCfpOhuzj3zDOJFA916EQR9/nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hL/g972Jc5Zmc1xLDof3fCcnzyYRUdrAJCkJd/0nvjU=;
 b=N6H0srD/sWBjYreCfxMB3Pofv6uDdHZimaFD6nnxUXFo5mp3X6RI3ic+xdlGeouJ2sIIvoZEFMbhzFLxmISGHWPieviGV8L/25sbDQmEAsnHC8Ugpt70A+ulyXlGZxdqdb93nM4alkKqGmbDu59qmGGgMunpLoS9XXXa34FRLs78YoJ7oh0+ja/yCuvC3+dvOGHU2eHMTV70TnDdEWp2azvKF5o7WLnMZGKCkVeBR+Gpj1jN9t2XclKEsAZ/WZSNQsAkMw20maUTHF4+z6MMDXv4oN4q04JWIJGV+YYQ3pPiXfZolIIkOGXE4nCxeuNq4PgpYLiJWaxa7usDvj8EbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hL/g972Jc5Zmc1xLDof3fCcnzyYRUdrAJCkJd/0nvjU=;
 b=qcE1H4GrlUjqW5JvfX/pGzrHiP5ThsibI4oQFnfKgllBc/0OTqBXwSpNeODRXR3FTbaQKQAHb+8OKbowdrCzIK3X/v1fCv3IzIOjIdLvwvPyNEkpzgPZAHccE2q04y09pE1j4asY2J/h+nYVwtdflZ4GMASt5eSnpnNIrCCHNWKCssxq19CzHXSz7nI6EgJeW87K4zaCxIInLvjaYt//ftLAsDv6xkRRvEg+PCKotp/l72ySf3hLBp4Okp/Xnz7Dpaqk7iJeAo7AZrJcovFZuLOPEyFURSwqDKr2hcO+TzFw+n91agj9/VLzj2MFpygDLwEB2mb1Q/r4YNT1WvJ8hg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY8PR12MB7706.namprd12.prod.outlook.com (2603:10b6:930:85::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 08:34:39 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 08:34:39 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	"hch@lst.de" <hch@lst.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: implement support for nvme relaxed effects
Thread-Topic: [PATCH] nvme: implement support for nvme relaxed effects
Thread-Index: AQHaWGgxalKD9zrmkE+IrxCCZGGDXrD888wAgAAKBwA=
Date: Tue, 6 Feb 2024 08:34:39 +0000
Message-ID: <4efa4fd8-b351-4948-a6c0-c5969c973bdb@nvidia.com>
References: <20240205191703.2990948-1-kbusch@meta.com>
 <3c8443fd-fd61-48ef-b4a3-0e6545990140@nvidia.com>
In-Reply-To: <3c8443fd-fd61-48ef-b4a3-0e6545990140@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY8PR12MB7706:EE_
x-ms-office365-filtering-correlation-id: 0e8922ae-f0af-4940-631d-08dc26ee7547
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Vw9qtNiDQWEiiKWNkHAiVsh/wTYunHvYNDv1ibJ8triGN0II+7gvm6HaMJEKYIbZUQupqjmj80IXoWzNFe1OYiMf4craaV82l7VmnO+w6JIuhVwNkVO92Isa/pKIGaFcMsgPI4CYzg+CsM0NmdY0VqAUq9cehvcAs3pUVB1GQtyazfeSyX7jhwP0bgg+6dHMHENdlPwgtopx5PL/BvkI010WuvEat5b1WBl94pZdcOdZTsu9rG8qrNehBcm8koCVjh3ZnSYCp1UU0xNHqijlSdXap8mW5qtwavDn9pARrL/2lYBgXGJc639MYkHpGuDN0z+TTl4SMBFz8u2xuQgMInLkoovxjRlUOALcPz9zkZOBn44NdQeieO7yvQVb0AuqY6h9WVVhWb8rkvuaNd3AxwLkpTLkUBDa5FuMsMWLFXvRZkGdqGZZfevang9YJuRM6KzymVIhnwaZW49X8OSSz/rglFDpP2zzHE4mBITxLrRaCB9w+TPthw0nyy4NK/RJ8IIn2xLnHoFWFBXY45AGuhKzKtuZW8F3hVLsRhnDPU0GkrjhUdj7r542oJVXByleh1SLAUtB2YexLfKRDzAlq+wafoGgltsNtIFlpA0zAEECR9zK1wDIzF75zeUtK73jCQkCYAZjBOrrLeAOnBx0oCAqrTYyeGMWgN9SV4KrAUwiFyaSjPAQHzOP17WrxwN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(478600001)(66556008)(83380400001)(71200400001)(31696002)(2616005)(41300700001)(5660300002)(4326008)(76116006)(6506007)(8936002)(86362001)(122000001)(38100700002)(66946007)(91956017)(2906002)(316002)(8676002)(66446008)(66476007)(54906003)(64756008)(6916009)(38070700009)(6486002)(6512007)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0JxUE5hU3pDU3pCdmNITnYxMVBKYXQ1OC9qdkF0VjM0MzRvcmYwK3V6ZnBC?=
 =?utf-8?B?ZU1qTnZjcm5IaktYbWpCa3dRcURDRHJPOXowK21QMnBlNk8xZjkyYytuYTRN?=
 =?utf-8?B?YzVBT3V3Z01rSlBHdFhHQWxJR3IxcS9FUFNTRHNwL1RPOEwyZ0hXeUFMM04r?=
 =?utf-8?B?RXMvc01oOE9QSWtBV1h2cElmLzZCK3Z3VnpmaitUYVVYMlFHbEt3NjJFMGtU?=
 =?utf-8?B?WFV0Q3hJU00xSWpuTXNmVThIN09MRlVtWnJQL3l5Z0poWUZKZ2xWS2tZbHVO?=
 =?utf-8?B?SEo5eHJlSjU4dHI2TndCNitRUncwK2VreGl6N1V3ODFtQitJRmZ4OU9BOWZr?=
 =?utf-8?B?SnZtampSd3JQcmJQaG9IZ2FzNXRGcmNKSXRTOE9YRlhBQmxBaTY2M0pNci84?=
 =?utf-8?B?aDhXS2JZUWtDaXQ2SnFScFlMaEFtYlpINUpmQ0lQeTdCdXdoKzIzN2hveldF?=
 =?utf-8?B?YVMxOEQzZVZZQk1qekVNd01KaWI5bTFkSVpFb1RWRW5xcEVJa0E3QWpkd3F6?=
 =?utf-8?B?N3huMU9ocGdFbWtXRlJFMElJWHRzK2VoTUo5aTZDZXlLSkl2dEJUV01GNmJ5?=
 =?utf-8?B?NnNNMkZLWXpkSU1iZW5UdGV0MVVINTVkWnArTncrUGhtcEZYTkpzY0w2dm1G?=
 =?utf-8?B?ZzNtb2cyVWFoVVF6TE1ieVRiV1JRVFpqVEJMWnEwZXIrYVlNanh0ZW1zLzcw?=
 =?utf-8?B?QXl2QlVRdE1qMDVxNnR4SGtLTWFmNUE4eEhwZnVVSGVqSHdlRWd5OWV5QXFn?=
 =?utf-8?B?MHhnMVZDT2RCVnd4NHVqUU0zOWJHVStrRkxBUVV4L0xRRWxvRHpHTFUvckFE?=
 =?utf-8?B?Sldzd3dEM0ZrT0FHWUYrOFAyN1NnamN0M0ZvaEJ3eGVRSXhDZWovOGFYeGlV?=
 =?utf-8?B?WWd1dTZnbFVZblJqSGVoa3loQ1cvaHhDMEZuamxiQldTbjZ4bDM2WmxYa2wr?=
 =?utf-8?B?OHFQQjNNdFFDYnA5TTd1a2FuWVp6YkhQWVVjVkplOWJha2gzc3dETGdzZzl5?=
 =?utf-8?B?NlMzZU1lT0JCd2xzRWRBVFV1bnhXRFh4QnkwcWE5a09CZ0tvdjQvMFRXN3Qv?=
 =?utf-8?B?VHFKUEUvTUV2YXpYSmo4YjBjS0pZZzNPK2M1a1kwenEwMXp5SXJIT0ZNSU1I?=
 =?utf-8?B?Q2U1eWNTZVJDM2F6QXYrYndiUURVRVQ3ME9XOVZST0MwamFqQnRuTjlwWVli?=
 =?utf-8?B?NDBRN2tNWHdTdFhSTmNGZDhRM1JBWXRBbXRIN2VlY3VNNDVER3V4aXpJN2JL?=
 =?utf-8?B?R3dCZmNYWEYzNGlqVFZHWjNNRllIWDVCaEd0Yng1eEQ1R05SWUpLYUdQZW0z?=
 =?utf-8?B?ZktzaksrOVlUZmhuVVZEREttNDJORFUvNk0yYi9wYWhhaVd3TmJDaWdBOE41?=
 =?utf-8?B?dnRhT2c3N2N2cjBYd1pRYWVHd043K3JkMkRaTXZ0UjByY3dkWDNCb0dlN3V5?=
 =?utf-8?B?YlMrMnhRckErZ1RKMHZZRHU3T2VYTnlVL204N25Cdm5XNVRaYWt2ZXNranhu?=
 =?utf-8?B?dnpNMG9RT1Yvd01SbTFlMUdqYWFJS1lMVDFUbFZFSWRndTlJeXExbUxwWEo0?=
 =?utf-8?B?NXUrU0VCdlM3N1RvT1ljMFhMSHlQQnZXbHBIcm93d2tTL1l6bHhuTjROS3p4?=
 =?utf-8?B?d29BdERRQStuOVNCRGlqbllkUHp1Zy9vQUJPNUhZUnJHTVB4OS9UcGw5am5k?=
 =?utf-8?B?dW9UdjBxQUtZTWpSUlJHNlVaR0pRVWRnb2syT2JlY0MwWVJTNnY2Y1piR2tp?=
 =?utf-8?B?WEREUXN4YkdYZjJqMm9yR3R5MUsycjl0MHUybE9Ya0lCK1JrdmdxZ3pkdDdl?=
 =?utf-8?B?V3VxMWpSMTF5SlAzVjRkcmRHYTZKNkFFNjA0K1JmaFpYeURhYzJjTFIwSHdG?=
 =?utf-8?B?dkpPSmE2UHJjVTM0eEx6bHB0Qll2a3puTVRLc3UwNTBtZ05ZZU80Qytnb1JZ?=
 =?utf-8?B?YkNOZzQyaktHRnFvQ2dRbWl5Q1Y1MUNxcTE5ODBTTDAzYmFobGxpazRGNFJZ?=
 =?utf-8?B?clpZZ2VlcWI0UEVaelc1cGN1ZHRHSGpWaGdxWGdNekM0a3BiaXZJaytQLzY3?=
 =?utf-8?B?M0NlRytJUUhOZGhSQm5ZcmNQZUpXTG94N3FVSHgvT2k2TXFJTHFqK2RnSWlX?=
 =?utf-8?B?TnRyTHlmV1REV0lHRXViWUVIeFV0QnR2YkZaTktxSVNLQ0hWVXNkN2Voa2pZ?=
 =?utf-8?Q?0oCo5MP0WUGyT/AqljUVON7wFgsQB136FGc+JTOHFSuh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A52FA7433F3BFA49A0BCF278492571F7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8922ae-f0af-4940-631d-08dc26ee7547
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 08:34:39.1304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYee8uitOl/4gvyMNhv4Nolpy5+WXsuM2lgPf+08P+rKJ8fKBWYqNxIlevV/NT2Y1mxsgVmYH25ZoFEJTHIRIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7706
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240206_003451_608442_1FEFC308 
X-CRM114-Status: GOOD (  12.74  )
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

Pj4gKwkJaWYgKGVmZmVjdHMgJiBOVk1FX0NNRF9FRkZFQ1RTX0NTRVJfTUFTSykNCj4+ICsJCQll
ZmZlY3RzICY9IH5OVk1FX0NNRF9FRkZFQ1RTX0NTRV9NQVNLOw0KPj4gICAgCX0NCg0KbG9va2lu
ZyBhdCB0aGUgY29kZSBhZ2FpbiB3ZSBhcmUgbm90IHVzaW5nIE5WTUVfQ01EX0VGRkVDVFNfQ1NF
Ul9NQVNLDQphbnl3aGVyZSBpbiB0aGUgY29kZSB0byBndWFyYW50ZWUgdGhlIGFkbWluLWNtZCBl
eGNsdXNpdmUgZXhlY3V0aW9uDQpndWFyYW50ZWUsIGlzIHRoZXJlIGEgc3BlY2lmaWMgcmVhc29u
IGZvciB0aGF0ID8NCg0KQWNjb3JkaW5nIHRvIHNwZWM6LQ0KRmlndXJlIDIyMTogQ29tbWFuZCBT
dXBwb3J0ZWQgYW5kIEVmZmVjdHMgZGF0YSBzdHJ1Y3R1cmUNCg0KKkJpdHMgMTU6MTQNCipWYWx1
ZSA6LSAwMWINCipEZWZpbml0aW9uIDotDQpUaGUgY29tbWFuZCBhc3NvY2lhdGVkIHdpdGggdGhp
cyBzdHJ1Y3R1cmUgc2hvdWxkIG9ubHkgYmUgc3VibWl0dGVkDQp3aGVuIHRoZXJlIGlzIG5vIG91
dHN0YW5kaW5nIEFkbWluIGNvbW1hbmQgdGhhdCBhZmZlY3RzIGFueSBuYW1lc3BhY2UNCmFuZCBu
byBBZG1pbiBjb21tYW5kIHNob3VsZCBiZSBzdWJtaXR0ZWQgdGhhdCBhZmZlY3RzIGFueSBuYW1l
c3BhY2UNCnVudGlsIHRoaXMgY29tbWFuZCBpcyBjb21wbGV0ZS4NCg0KSU9XLCBkb24ndCB3ZSBu
ZWVkIHRvIGZyZWV6ZSB0aGUgYWRtaW4gcXVldWUgd2hlbiBjb250cm9sbGVyIHNldHMgdGhlIENT
RVINCnZhbHVlIHRvIDAxYiB1bnRpbCBjb21tYW5kIGlzIGNvbXBsZXRlZCA/IG9yIGl0IGlzIG5v
dCBkb25lL25lZWRlZCBmb3INCmEgc3BlY2lmaWMgcmVhc29uID8NCj4+ICAgIAlyZXR1cm4gZWZm
ZWN0czsNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L252bWUuaCBiL2luY2x1ZGUvbGlu
dXgvbnZtZS5oDQo+PiBpbmRleCBiYzYwNWVjNGEzZmQwLi4zZWY0MDUzZWE5NTAwIDEwMDY0NA0K
Pj4gLS0tIGEvaW5jbHVkZS9saW51eC9udm1lLmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvbnZt
ZS5oDQo+PiBAQCAtNjQ2LDYgKzY0Niw3IEBAIGVudW0gew0KPj4gICAgCU5WTUVfQ01EX0VGRkVD
VFNfTkNDCQk9IDEgPDwgMiwNCj4+ICAgIAlOVk1FX0NNRF9FRkZFQ1RTX05JQwkJPSAxIDw8IDMs
DQo+PiAgICAJTlZNRV9DTURfRUZGRUNUU19DQ0MJCT0gMSA8PCA0LA0KPj4gKwlOVk1FX0NNRF9F
RkZFQ1RTX0NTRVJfTUFTSwk9IEdFTk1BU0soMTUsIDE0KSwNCj4+ICAgIAlOVk1FX0NNRF9FRkZF
Q1RTX0NTRV9NQVNLCT0gR0VOTUFTSygxOCwgMTYpLA0KPj4gICAgCU5WTUVfQ01EX0VGRkVDVFNf
VVVJRF9TRUwJPSAxIDw8IDE5LA0KPj4gICAgCU5WTUVfQ01EX0VGRkVDVFNfU0NPUEVfTUFTSwk9
IEdFTk1BU0soMzEsIDIwKSwNCj4NCg0KLWNrDQoNCg0K

