Return-Path: <SRS0=aga3=QF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1853C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 01:57:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92994619F6
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Nov 2021 01:57:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92994619F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=24Ah/RnPTz+0UwnaKqwpWt/5/1yHOa6uUdYF5BM4LCc=; b=BPgREVCv1FvTyDnOXjEHqHVuvf
	XRX4toaYFGhvB+fYBOdhjLq+W60Em6pX8+9W9qE0bjFlZajF3OY8zneqmc0G/9slHa8PqEYepfulV
	RcwUfwBmBgwTfs/5sxzDq4mpBjyXfOCSfVVks/8p5nNX/G0J6YQlLCNdF+6zwWLYzmlUPemwXF1nd
	2kFWtaiqb1QtOgm0nW/Y24su3RsMDiA5s3BzwP1arNndle4yj9hhCu2pDb0h0ccfkUJ86NP6oClSk
	k8pmnd9kbTjVM90xrt16lrc/H54q0bvZYc4kNfREFHZ1HwM+EjC3FSmm/vCsixm5KR1+IymWAFtuY
	eH2iEurA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnWfd-006iJQ-15; Thu, 18 Nov 2021 01:57:01 +0000
Received: from mail-dm6nam10on2057.outbound.protection.outlook.com
 ([40.107.93.57] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnWfZ-006iIb-TK
 for linux-nvme@lists.infradead.org; Thu, 18 Nov 2021 01:56:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNI8DD/HIBamx46si+LpuQ9kw5kEisLbVh1EPncZDQYt0jd1NIlo1A1y4aO7hsDA7anJBiflOrRNo9e+LxWiqo1luk+/nk8nxhu18ztWBISHIOewIvGIMYAswPDXncnskgSgbHNhYLa+81S8eGx26PYEtgTBkzqU7DAtCM3uodSdjXTG7+q/PWR8rfEGmZNxHDxLwnt26mNlFWZkfq/+NXAs3Llhbq6FNDzO/lxnxeFDqCDUAgdF/ZFQQHQmd4mK4WavIj/u47Og2GtOqA4wFUPFGWy7K5IGBGZJykAMBdHsZuvyK+pQXthtCxX+qCvEz2ZCr/LFZWUJ+JrAXh0tSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=24Ah/RnPTz+0UwnaKqwpWt/5/1yHOa6uUdYF5BM4LCc=;
 b=g9wZ/hx1gesfoI32JTEPlyzNGYWlEPYe6aqB0jgtMxxexqN11u5mfQYEf+Wui+xAfR+18bG16tpuyJAegx25ZzIKKvjmSjm4bsiYRJH3WxsYgfmvAhL9/FumGkE5sOuTLVaskFb2QNjozUjn/V21xJTMmpQQeyreDiRwPwiT5ZaoqHW3lsUTh0ohOaygu36Xs2CGuPUa4UZkQ2my/D1KARQOp3sgQ5bHw67V4Wc6isPSKQBm02OKUUdPaGTgl7kakP0cruyoglJsYvHRrIxa92jI07lSoR4qpLLpzGhETxUU6S8mFsSAsZn7vWDBp+6y68VH5NW5EQ+CIudwvoWrAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24Ah/RnPTz+0UwnaKqwpWt/5/1yHOa6uUdYF5BM4LCc=;
 b=pdBhUzN7Ix0sGarNpeJeKzH7EoJNuJmZCHkpS8uOy1lx44w9mUqeoOHdK/0LYzvBTq64TCg+2Ux2QzU+GOBvYN9zGzpgRfDj3G4u7OAr47fI1Iw11sfUsKWKmuJIQDV/PTvnVT7s1D1FdywiK1iOuJbP0wq6ZWe+WfGWUj02XtuPqF1OyZ0E6yCgGTkD7FtjY/ZjLbVKQ9Hu0hkq9sRejMKvGxoE994ltUByeiNod84cuRz/V8AWNQfgii68hLG3Bchcwgrbp3E0q2FYXAoeFPn2XhKaaIlCZsGfuYct3kRL82pPg/ncDPyXWeDVSgr9N7sIeJLZ3fKw177aZj4nIg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Thu, 18 Nov
 2021 01:56:50 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4690.027; Thu, 18 Nov 2021
 01:56:50 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "wenxiong@linux.ibm.com" <wenxiong@linux.ibm.com>,
 "anaidu.gollu@samsung.com" <anaidu.gollu@samsung.com>
CC: "keith.busch@wdc.com" <keith.busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hare@suse.de" <hare@suse.de>, "wenxiong@us.ibm.com" <wenxiong@us.ibm.com>
Subject: Re: [PATCH 1/1] libnvme: Add new events support in PEL
Thread-Topic: [PATCH 1/1] libnvme: Add new events support in PEL
Thread-Index: AQHX29l2d1B+6Gj17kC5/zUekc1URqwIh2cA
Date: Thu, 18 Nov 2021 01:56:50 +0000
Message-ID: <67a4106c-6cfc-cd3c-ae37-b2c88b9a4e6c@nvidia.com>
References: <1637164899-16984-1-git-send-email-wenxiong@linux.ibm.com>
In-Reply-To: <1637164899-16984-1-git-send-email-wenxiong@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45c8a79f-2f6e-44f2-6446-08d9aa36b010
x-ms-traffictypediagnostic: MW3PR12MB4348:
x-microsoft-antispam-prvs: <MW3PR12MB43486B50C41256FDB21BF15CA39B9@MW3PR12MB4348.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:913;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a5ahuqAdHZkiAfmNJstTbdRUeVRRMZKIm4i6f3vfX/9vVfm1Ucdq3G+zLltsQgM+Tu0rqIigsBNuU80q2qRI0F6F90mZZXz2fYkJx0UVp9AMkJG9ldqJduzQ77zYFDaciuiByLScAKzaFEeE1IBJjHuFvtlfFc4kGu/lOi9cKygY65CegruNkeArOxrLvLPvTpHZ/br5ZLoprilhNJxrb0DtiXdWfcuql8bXum6QwUHUUepakokAQpzT1SiIO9YoDDilthQgfL0DNX06X7R49jOyzBs/YQ1f/nSyXMLxXgRpfH1+VyXMEb6Ia8BkWjjwWhxGEe/VyJR41Gd2Gt9+P53mx13AgiE930mhMePZPE/2lcAJmHQamdPxeYiCaI/Q66tTOThbUc+FeHP/d8daGEXvehEiiTeN1UFkU+Q8bt76QGs8g++OBG7pMBvOu6QR6eQxZj71+ij98pUwJv2o7Ni3DHe/lDxQrZ5sYJ9GZuEbiS4xeUcCTIrWW1EULzgVPeVGqSDPOy1qLNZQ4eXnugfdfVEJOY6cHGba2zCk6wLYLBcj99Yms7luFO02YbjQfGHlnRaannRAG5H0nfAaDW6DhoeF0zBS34pc8vfIpP5//SPxrhJq82YhfHEcRy1hZkL1hoe3NtTH+B7t51CbHFpPXyH9OMGcHo9Qe7b86ko2G2X81Bzx6ismSe2GXs/h++PqgFifudUoZNPYzJqdwR13sTwOJNFwK3YHruY0f3OxZu1PYoB6QG2HEeYEOSTcC4ynPm3qtTegV1BJVYcUsQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(71200400001)(2616005)(38100700002)(36756003)(31686004)(6512007)(8676002)(5660300002)(8936002)(26005)(6486002)(6506007)(122000001)(76116006)(31696002)(91956017)(508600001)(66556008)(66946007)(2906002)(64756008)(66476007)(66446008)(316002)(110136005)(54906003)(38070700005)(186003)(53546011)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWtsMnltWEM2UTNTNkZOMTExT3d0TkxVbTVzOFZMcTg0Yyt0T3gyZHFPUDFv?=
 =?utf-8?B?ME96TmNiRkREemFMTFpzYjZpQjI1MjgxbzNiMWs2VGZIMUtPNWhjQnlkaVkz?=
 =?utf-8?B?YTE2dm9wQWF0R0NZSVZtS2w3VU5YZi84WUdVVmFvV0FxSDUwWHJseUsrTnVs?=
 =?utf-8?B?UDhDSU14bUtZM3ZCQVFESkw3ek9kUVNFT3pRUkhQOE96K1JIQm1zSUlkZFkv?=
 =?utf-8?B?YWxNMldhQlVTcCtPWXdXYnRwN3prMnZrSFZBUzM0N3hEdnZDZW1qTUJ2clRz?=
 =?utf-8?B?WitWQnB0VHZFQ0J5a3E0L0xUOENDQVZ5Mi9SSGt2OUhWU0E4alU0ZG9IckZC?=
 =?utf-8?B?dHRYVTl0TWo3anFncjZrWTRTdjJrYWtCbGVBZVBJcjZlUVhST0VhaThMV1Fp?=
 =?utf-8?B?VitNQzZxMHhaSHdsMHlPR0wySEFwMnR4TGdRZFEyQ2RyT0VjU1MydEo5SXlp?=
 =?utf-8?B?dFNaZGNaT1Z3UW5xM3JUaStLMzJ5dlh4c3YwWnFRZ0lxWlc1ZXJSZmRwendj?=
 =?utf-8?B?Q1oxckowak9IZ1BYOGVYNTlnV2wzcTBjOEtZRmdQR2ZXTmRrMCtQREM2MWFM?=
 =?utf-8?B?S1pGUEI1a0gxbVlsZHRHY1V0blo3US9jalNMTzJiS3pES0tzaldKSFRoWWxU?=
 =?utf-8?B?RDZUNHQ3R0IyTDhGNVdzZHNsVURVbU03V01ReGZqc21KdXRzaUszL0dlbkhR?=
 =?utf-8?B?cXhuRm5VU1FRMXZDdUdnU2EyUDVNUHlwSHJJTkMvOC9JWjByWVBjSEVWT0dp?=
 =?utf-8?B?OVJKaXNObXgxa1RobkR5di9Ecnk0dmViT2ttZ3VBN2YxNzk0TnZGUFgvVkdN?=
 =?utf-8?B?UjdNL3JlK3BFUzgvelJEQU5vdWFRcm5zYW00SVhVeHowQlBXQXNHYnFjcFNk?=
 =?utf-8?B?ejB4VitMS1dWT01VcHVtUlFLQW1RU2N3OEF2TE9RU0c0L1pFeituRG03TzhI?=
 =?utf-8?B?NFd4dlU5WEtLeFpmVlpkNFJpek9QSzFvR2hheHUyL2lnZlkrQlFGczcvMkZo?=
 =?utf-8?B?dElyYk9iam9ORkFlM0M1SXZjSUpLcE5YdENsSWttTXNaVzhMSVRWVFhuZWFi?=
 =?utf-8?B?dUxsY3l5Ylc2aGdaVndGZWg4ZHpOR1hRT2J0TzZlMVhhRkdYL0NJV3hucU1s?=
 =?utf-8?B?ZGhvWmpNRHVZOGo4cEpWWndjMVFFUUhKMXhxMDZiOGFrejZtWTdCL0g5c05q?=
 =?utf-8?B?aER0QVVoaEo1VnhFS1ArTDJzQjJWV3VjaVlLcDh2Q3Z0bzBScXpadmhJakVm?=
 =?utf-8?B?bWlleCtwdHNVUXc4YWJjM2RVeEFleThnNWpaRHdZd09VcDIxV2NGaXlJbGFv?=
 =?utf-8?B?NmZuVDMwbGNabTVWWVA2Mm80YmFya01DWWlIVFZrRDJHbXA0MGNpUXpuaURS?=
 =?utf-8?B?UUNuRTNBSk00MVRHT081Mmp2UkxlUHhyN2ZUTnk5UU9zWFM4bDQzQUFMVk5N?=
 =?utf-8?B?L1NlWVpQcEdmRDg2ak5CcnBPZmg0a3hWY1c0M0FCUUVLQ0gzSDdBeFIrYTJK?=
 =?utf-8?B?aXBlRDNGL2swRUNrTHF3SEJGV3hyZnpiazkvVnNKNndkUlljb2tmSXlpTlpY?=
 =?utf-8?B?bitVOUQ2TkFHaHlXeWQyN3Z1L0dFYjBuTnloTThGV0pPb2JrTkFJNGQ0WE50?=
 =?utf-8?B?eitXRURZbTgzSDJPTXM3RmVyNGNpOU5lWWlDV1B3a1VEOUZ3TnNPZ2pDVTRa?=
 =?utf-8?B?dFpMNVNqeEpFL0ErRDRaRDZLbmlWQ1Z2SUFQeWhxNkMwRGgwODlYR1FYUTlp?=
 =?utf-8?B?bForWURjRUVrYTZ2ek01V1J3TUJpRnBSRmxiVTZEWEFDT2JocldOdmYraDlG?=
 =?utf-8?B?Q0twcmYxRzkxU0NodUtsT3F0ZmlWRFJNWStBTHNBZWtEaGtwKzA0N25ab2Mv?=
 =?utf-8?B?WEtVMEV6b285a3p4ZExpcWg2dFU3UmovNEQvWm5TT0FBd3ZvdGUzNEh2UW1L?=
 =?utf-8?B?K05odnRkdFZFSWlhMDcvMHpCWDIzeC85QjZEN0c0YWFWOWdWVExiZE14aCtY?=
 =?utf-8?B?Y3RRR0VSZnl2M0NBSVUzTzFadENYSFlKSGh0bGJyeUdXLzZpSzNkRmpQKzRD?=
 =?utf-8?B?dTc1elphVnlTUlpha0s3cmZ4c2g3YTd6UHVzSm1DRmhqQjNQeXpnTjBxQVFv?=
 =?utf-8?B?eXdaaFRqR0EyY21YWnEvWE9wU3pzM3EvQXJlYkhIdUs4Z1pUK2tCSEdieEdW?=
 =?utf-8?B?Qnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7000C5B00B22DC4AA89A0010A95A8E8B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c8a79f-2f6e-44f2-6446-08d9aa36b010
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 01:56:50.7676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zn6fFuQt96WqX4Jj6ODf0+NGD6xm60rbvxXTlaHczFWC1gmFxhhK5Ma9CRkchRHUclULP3a5ZbONnXy7QOIzig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_175657_981226_AB28EB48 
X-CRM114-Status: GOOD (  17.50  )
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

T24gMTEvMTcvMjEgMDg6MDEsIHdlbnhpb25nQGxpbnV4LmlibS5jb20gd3JvdGU6DQo+IEZyb206
IFdlbiBYaW9uZyA8d2VueGlvbmdAbGludXguaWJtLmNvbT4NCj4gDQo+IEFkZCB0d28gbmV3IGV2
ZW50cyBzdXBwb3J0IGluIGhlYWRlciBmaWxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2VuIFhp
b25nIDx3ZW54aW9uZ0BsaW51eC5pYm0uY29tPg0KPiAtLS0NCj4gICBzcmMvbnZtZS90eXBlcy5o
IHwgOCArKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9zcmMvbnZtZS90eXBlcy5oIGIvc3JjL252bWUvdHlwZXMuaA0KPiBpbmRl
eCBiN2YzZmNjLi45ZTJlODA5IDEwMDY0NA0KPiAtLS0gYS9zcmMvbnZtZS90eXBlcy5oDQo+ICsr
KyBiL3NyYy9udm1lL3R5cGVzLmgNCj4gQEAgLTMwNDQsNiArMzA0NCw4IEBAIGVudW0gbnZtZV9w
ZXJzaXN0ZW50X2V2ZW50X3R5cGVzIHsNCj4gICAgICAgTlZNRV9QRUxfRk9STUFUX0NPTVBMRVRJ
T05fRVZFTlQJPSAweDA4LA0KPiAgICAgICBOVk1FX1BFTF9TQU5JVElaRV9TVEFSVF9FVkVOVAk9
IDB4MDksDQo+ICAgICAgIE5WTUVfUEVMX1NBTklUSVpFX0NPTVBMRVRJT05fRVZFTlQJPSAweDBh
LA0KPiArICAgIE5WTUVfUEVMX1NFVF9GRUFUVVJFX0VWRU5UCQk9IDB4MGIsDQo+ICsgICAgTlZN
RV9QRUxfVEVMRU1FVFJZX0NSVAkJPSAweDBjLA0KPiAgICAgICBOVk1FX1BFTF9USEVSTUFMX0VY
Q1VSU0lPTl9FVkVOVAk9IDB4MGQsDQo+ICAgfTsNCj4gICANCj4gQEAgLTMxMjIsNiArMzEyNCwx
MiBAQCBzdHJ1Y3QgbnZtZV9zYW5pdGl6ZV9jb21wbG5fZXZlbnQgew0KPiAgIAlfX3U4CXJzdmQ2
WzJdOw0KPiAgIH07DQo+ICAgDQo+ICsvKiBwZXJzaXN0ZW50IGV2ZW50IHR5cGUgMEJoICovDQo+
ICtzdHJ1Y3QgbnZtZV9zZXRfZmVhdHVyZV9ldmVudCB7DQo+ICsJX19sZTMyCWxheW91dDsNCj4g
KwlfX2xlMzIJY2R3X21lbVswXTsNCj4gK307DQo+ICsNCg0KSSBkb24ndCBzZWUgd2hlcmUgbnZt
ZV9zZXRfZmVhdHVyZV9ldmVudCBpcyB1c2VkID8NCg0KQW0gSSBtaXNzaW5nIHNvbWV0aGluZyA/
DQoNCj4gICBzdHJ1Y3QgbnZtZV90aGVybWFsX2V4Y19ldmVudCB7DQo+ICAgICAgIF9fdTggCW92
ZXJfdGVtcDsNCj4gICAgICAgX191OCAJdGhyZXNob2xkOw0KPiANCg==

