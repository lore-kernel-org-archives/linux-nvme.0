Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F014C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 04:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UArHckiGNtSjGBPu0dO2MBvkGnC/MOQibBmcZNr7kn0=; b=2a+MsLQYcqediMQLz+O2PWHuj9
	FMpofPquV4VCauyXSkm/3orcdHhbUaKXgzlJUz3THDEoJZx8ioOqCcs+P07+6zay+IvhIn0nrBrd/
	xIeAMzPh+Ko/Dnfjlofk5eLdQzm0uIgOoOb6vk6RFK8xGW9Sl+0JDprO7Hn3s+WvEx6ytvOEBt/dT
	hQ0jTIOnMosscPnAAYgDFy1XQ+GW3ZJ7j37tzcjLTq0XGu+hnaURlg9Q92o54vZAU+A6KS1UKmG//
	giFpfDu4/CACyPr0DtgIn3kHtBwzWFke6FNXkC4rtC52CRcOUv1P5N0/BCpKTSO3ngS2HlwZqwSHe
	CgP4uW4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oun9S-007NQs-OX; Tue, 15 Nov 2022 04:02:22 +0000
Received: from mail-dm6nam12on2062f.outbound.protection.outlook.com ([2a01:111:f400:fe59::62f] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oun8o-007N5v-Q4
	for linux-nvme@lists.infradead.org; Tue, 15 Nov 2022 04:01:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpBCaW2CYghrdLdMqswgkTPEvFZ9Ovr1tH3RT/PdqPygmQtvegtH0OrirqnYAxr7rbQbGteu6D1Kscz2e6f4ZTaKrraQ8CC0l6j99BHzx+akWEP8gBozjuV8HU/h23nugtnbHcX2GxUhXWVq3PmfuSTdNaiCS3wATBP6WRKvHbnpfSkoT+XVqO0qrJ6NRzA5tA/t166cJ7sNYPDL5lrQ1JxQzgDKxcPyaYbvfndQ20yeZCJSV2JG3aLBOGkL4wkZiGcjg7IPhRCUCCRGWKa359INcQ9S7G+9oXDMTxr9xsqsz9cU2ScTRrms219CdMYUwR2QPWc7GXEnB7r+UXyMLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UArHckiGNtSjGBPu0dO2MBvkGnC/MOQibBmcZNr7kn0=;
 b=ghzhufjub/DbxF+5/rLC3vuUl/xtjKw1rHpXQUjjjzn+eusozXduJZX/2nIW7NY2OBgnjNsK8YI/+2s3xYMYIdnz69lNyG1l6vUNaPMtqm4vLM97zRotirKbATTi5Dq5k88KNM0z1AF0+jYHSxFRFv835i9XP8hSdD8Cl10PDaLITTDVWcZ2MQ3VPLve8jN2QQ/zrMJQk+wq8fJcb3LvQY9dTpk7eYrUUHiAggEGxtsQy+IH/xo1XdnUkPSdVM01SwTtw3d+VcQPJeMQ2mH2OefYr42FeKWoWFg0VX4XHxqr4HkNttW0D+EvehYSL5VLwMZ4HDPRTF4GSaaMxoqcGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UArHckiGNtSjGBPu0dO2MBvkGnC/MOQibBmcZNr7kn0=;
 b=SWwDpbtTgpqNnUsiD/hBwFwhOwyNDcegmMwhcdCrh/11v+W0lqWEUT5IoiOR8O3O2tJnD3ISLwZaV68LxJoPL3YaNLYpeYk4ST63FZ4gHtPRjhUmt68YHZCGTHfShTZuyQt7FmrjMDm07slmSb4V8N+ecA+CIodztqB9GuHmwC07U3TravAbS0m+nzsEbE4jDaxnnP7wsIs78zrRNeJeUIzOVy4d4sdbeP8UPi4/s3gw+SM75bGrTFohA7i5C31rOn0WioBZamtKHZGpYv4PWEJeeasDX68bN7ezo+b2Pii9qNQJJyvBxwYBNHFCFrHwHmLmqeA6wSg0kwKJpkvMnA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB5831.namprd12.prod.outlook.com (2603:10b6:510:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 04:01:38 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 04:01:38 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Chaitanya
 Kulkarni <Chaitanya.Kulkarni@wdc.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 09/20] nvme-auth: don't keep long lived 4k dhchap
 buffer
Thread-Topic: [PATCH v2 09/20] nvme-auth: don't keep long lived 4k dhchap
 buffer
Thread-Index: AQHY91LS7mSKJ3vk2EeS/pdagVGFxK4/X0YA
Date: Tue, 15 Nov 2022 04:01:38 +0000
Message-ID: <1d6136a0-a8d2-1ab7-d553-381404e164dc@nvidia.com>
References: <20221113112424.1049834-1-sagi@grimberg.me>
 <20221113112424.1049834-10-sagi@grimberg.me>
In-Reply-To: <20221113112424.1049834-10-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB5831:EE_
x-ms-office365-filtering-correlation-id: e3f2b36a-8b30-4afd-b6ae-08dac6be18ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  uAMU3G+4Y0XVAXktS2+urZQ9Xi3FAJT6bIeBDH1ba4icMXuGroHfETM8OwHThIMfV4B0lySFHPTN6ndyColfc1jT6MB3gI6ekQ3kfdqN3l0gpFY+ObVQSQpJ1JEA5gZDbOtAjuA8zQuFeahlqRITsIFqbgmHenVNh966xt5h1jpQ9O8ATFQoZeqFKgzMxViwMdwio7gptr3kQOy2qU+2J715i32R16PmZ8kaXRngdpnSnpPzOveSsg1Puya5TOvhp+v/tWBIFeDfPPRguKJrjq0Q5Ha35/9/W8b62yiT70zuGN9eeUze3eOMSLu/HPVerltzuP7KJN+Ntwcrms+4n3603JIirT9makmLh9JxGoCJ86iat3ueQLyEWu92TXNyxg7ct7mpJXuXv/l8PufK4+IWiACuUCWQA8N1Q4gIODfhHynWhLfE8CeO1u7XFJiGvulmn710f8CvcEEP58CmZiJqhh36/CYjEbmLjffL0xUYchPJuLoFD4ovwFnnBz6Z9OKPVOKSn8eh17DmWpEpKEaYQghqIPy7l0jfTcd8qjHMkeVvY/j0kSKqsobKae6HoXlpceyinF65bVMyxddVdOj1CMpwP5RC6G0QVpQGzxDes0AyWz+KIDsNC3xjmCQCOWtMqtMlhnGOQZxbArY7i/FPEfSnawPKHsxdJxGoJ/m+l1aiXZA6yQqf44TFriHbokSiJHPjOUdXyKWiWtUrt2M1pRffgtfP4lgWoeiZMGJdNIToX5+WUP/TBAPOwPrlxJ9X2hona6dSfdsTdST5q+jx9ZvfhNPZDTGM61cGXphK8Ee0n/GumnUK+BrcgyHmhWGavppIy8dWElhhvT/osg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(451199015)(2906002)(8936002)(5660300002)(4744005)(41300700001)(316002)(83380400001)(122000001)(2616005)(186003)(6512007)(38100700002)(31696002)(86362001)(54906003)(110136005)(66476007)(76116006)(91956017)(8676002)(66946007)(66446008)(64756008)(66556008)(4326008)(6506007)(53546011)(6486002)(38070700005)(478600001)(71200400001)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VXdCQWJDZHQvYzVWTnpyK0dESmlJNG5jelczdGhoZUdQRmNuMnlZcFFnbWVV?=
 =?utf-8?B?ZllHMExObW5zQ3NDeU5YOTg5S3lBeUZXVHZ3RGwrT3RCT3ZSZ1BNWGdDVVIw?=
 =?utf-8?B?WWIxcXBGUVlKb1IwUnBaOTNrT080TlFpV3BIVzR3dHh0VXU3ODlQMnNkUzJw?=
 =?utf-8?B?SG1Nd0taQVhDUGYzd0t5MFl0Q29wUFQra1dDYTI4bHRVQlRtNjFBYldFY0J4?=
 =?utf-8?B?blN3dlhZQUJrSmVncWxINXFrK0V2ZlhzVDBmQUwrWUVwTWlWVHBmbU14YnJ4?=
 =?utf-8?B?eXhZUUxaTjh1YUcyOVpjUFBKK1c3NlFLbzRLMEdCZ0hYaThHZjZJMlR2bGpU?=
 =?utf-8?B?ZndFOFlGTG9mcjBBZDluYU5aYzdnSmxPa0NCMHBGZGxDMlJRUS9kRzVjU3hO?=
 =?utf-8?B?dFA1U2NUb3p6YkYvZHk4ZlhDdyt1SmtWNmZuREFRTzlwbU90SnFaRkNBbUFV?=
 =?utf-8?B?KzQrMUFtalNOQ204MzJnd3dKMVRJaEIwaU9KSEZReXkrL1NFdVZ1eC9pencv?=
 =?utf-8?B?SXhaaXJlSVNlOG5mQUNWUkxtS05Pb3ExVVoyeEs2NHAyQzgxbGVSZ3YxRGc1?=
 =?utf-8?B?OGFSMnk3TlpNT0FiVUdKOFUzSlRtSUVmbVltQ2VFcnlsYTlPRW00d1ltbHRG?=
 =?utf-8?B?blZneStBVjFGLytwSkRNT25CNlBUeEhHbVBJUUFwNWt2UzR2ZE1jU1lVSHd4?=
 =?utf-8?B?Y0FuYlh2REJTQkhhUGIxYVlTQmh5M0tLVnlZd2IxcHRPTy9neVJGWXpmcGxU?=
 =?utf-8?B?UEhWSEVkcy8weC92QXBsWTQ3RENjVXd2cW5zNkJMQ29WajJLSUxUR3pCUjlC?=
 =?utf-8?B?RFRuMzB3UEdBdVUybmJqd2o3RzFVU0xLb2dWbHlPMjhvR1lDUTRDR0pKM3Nv?=
 =?utf-8?B?VVJ4NkpXeFFYb2ZXdy9ROXh1Y1JpTVNtbEl4S01CZndleTB4blozNkFsUDFB?=
 =?utf-8?B?RGU0NnFpN3dOL015OGRMTWZKUnA2dFdwL0hMVHRod2w1Yy92Sng4d2hEYzRu?=
 =?utf-8?B?dFBLY1ozSDA5L0YwSDVJT3JJNFAzd2IzblFVeG5iZUxSMTRSSDVEbXBsN1Vm?=
 =?utf-8?B?UDBBYlY0N3MzSFBIV3pOR3EzRjlpYkJEcTRUZGp4WG5ERCs0L2JmNmxpNElq?=
 =?utf-8?B?UU5oaWc1RXVCTVpLNWpGdHZQdXF5UnRCdWhRMzBkL1ZQOElzUDVaN3F1ZUtM?=
 =?utf-8?B?S1ptYXpwVzhQUUZMdGxNREt4VnI3aWRUWk1VVkt2UGxacUtQckFuTXpNWGdB?=
 =?utf-8?B?L2c5RUNTbGVvNjBmTU1qbXpvbXoyT1hWcThvbEtQQjdMMHVrcFdFQW5WNnBy?=
 =?utf-8?B?WXdPTUdHVnJPNjZEek52L21xa0g5Q1BjUy9BVUtzM05La0MzQTNuWGp2VGVV?=
 =?utf-8?B?M0RxY2VZYVErNzR1OXBKUFQ3OG5BY1hCOE05VHlHQkVuU1YzVkdIV29oQWhH?=
 =?utf-8?B?Rld2d1pUNDBGTU1DLzlBWXluWUsrMHE3cXNVWnlmOXNZZkRzMXoxVUZrUThi?=
 =?utf-8?B?Nk5hc1lVYWtFa2F4LzVIaFB1Wk02RGNhbGN5amMvVXNxcGhEbERzVENIUEJB?=
 =?utf-8?B?Sll0eGFZcGE3Sk00WnZIZEtvUnlYM0hNYTByWVB2QmhSTS9SUGVCV1lhSXVr?=
 =?utf-8?B?NVovRlJOK3M3SGdyKytEMkZ4NkZpWDlBZm5JcmsrcVl1cHRPK3A0VmthZDc4?=
 =?utf-8?B?QksvU2FMOXRWUUIyS0RENlRETWxKYVI4dUNqU1BDbDdseXQxUzgwZDlnaEZW?=
 =?utf-8?B?c2hNbk1uaXdiWGtWa0hBaXp4OUNua2h0ZUU5cmZnekNsSytxa3MzMDM0aFBK?=
 =?utf-8?B?ckJXc2hpU0w0SzlQSmN2Tmc2M25Pd1ROcGV0bzBBbUJ5bmJTTk90QzR3dmxs?=
 =?utf-8?B?dGN1WElaazdudW5WTFoxWU1QZ1FOUlBzREtibWh0UDNBOTc4NENXdHRrYkhO?=
 =?utf-8?B?ZGsrODVRd0JPa2dvNW4zQ3Q0OHhqTEU0ZWlJV0pSTlFVcTNsRytaUnVWUnV1?=
 =?utf-8?B?NzR3WHEvcmhXUlRoUmg2eTlXdUxzSnhhbVp2dWFDaGRDVDZObWtQbnFOd2RB?=
 =?utf-8?B?NzRiT2tBZ0xtazZGbVorMUY1NTZNWDBjeldremxxYUkzdWhnSlpJTFUxaWQ4?=
 =?utf-8?B?YnBMcmY1bG55MVkxZzE4TkFPNzE1aXBJZ3NneGsvMmhnSWdJQkhNRXJzQ0ln?=
 =?utf-8?Q?p5tXkWNZORLYhE6Cy7F2ooANkmU3nlfbgnT/hYa9MKaB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <632EFB91D05D494C92E9C0B1C1229107@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f2b36a-8b30-4afd-b6ae-08dac6be18ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 04:01:38.8007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LGnvoats7QvL+FqcoEHstPYmxbRKrmPFpDjeCVrH7UNyS3fF8TlvUCoHVwny9Yf0Vr6Tu00mrmdcWyApAt8NeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5831
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_200142_911091_EE32801C 
X-CRM114-Status: GOOD (  12.50  )
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

T24gMTEvMTMvMjIgMDM6MjQsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+IGRoY2hhcCBzdHJ1Y3R1
cmUgaXMgcGVyLXF1ZXVlLCBpdCBpcyB3YXN0ZWZ1bCB0byBrZWVwIGl0IGZvciB0aGUgZW50aXJl
DQo+IGxpZmV0aW1lIG9mIHRoZSBxdWV1ZS4gQWxsb2NhdGUgaXQgZHluYW1pY2FsbHkgYW5kIGdl
dCByaWQgb2YgaXQgYWZ0ZXINCj4gYXV0aGVudGljYXRpb24uIFdlIGRvbid0IG5lZWQga3phbGxv
YyBiZWNhdXNlIGFsbCBhY2Nlc3NvcnMgYXJlIGNsZWFyaW5nDQo+IGl0IGJlZm9yZSB3cml0aW5n
IHRvIGl0Lg0KPiANCj4gQWxzbywgcmVtb3ZlIHJlZHVuZGFudCBjaGFwIGJ1Zl9zaXplIHdoaWNo
IGlzIGFsd2F5cyA0MDk2LCB1c2UgYSBkZWZpbmUNCj4gaW5zdGVhZC4NCj4gDQo+IFJldmlld2Vk
LWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4NCj4gU2lnbmVkLW9mZi1ieTogU2Fn
aSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4gLS0tDQoNCg0KTG9va3MgZ29vZC4NCg0K
UmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0K
DQoNCg==

