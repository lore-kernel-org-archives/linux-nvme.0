Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287BECD5BD1
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 17:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1zcstS1whKTjLCME302cVbMi7UGN8lNJcicPx8ihBVA=; b=2c0vxD8GGSmvjbz6kRf2RArL75
	zGuqdlSrcl8FURkvzTIWC2Cl1p6hKkCLluZyBWtqlAbo810dYZRkuZAl9YLZdtBClycEG5pqm9RWD
	94/l+ApqhO95+V0FZrxSwkFkbZclEWzd6g3iKhG7ScJ2dYTByvkCfFHq8Vu58Xz3/9Hv9pu1Krlq/
	Ux5ORsPAp5o0dQkXUkfH/FuRvLnzxwESh9QM6TmsrMbKqJ3nSGrY97fj1iNTpoNcE9ZXQUEQ1+hxS
	6SNnX35lAbIskX7XZFA+Dmwg4slSYw2YUad4kQ6bwLX/ZUhCjyiNoePXXt+tFvOPZd3jKe2tsatIz
	RCcq1Ysw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRvDO-00000002eI4-31l5;
	Tue, 26 May 2026 17:05:14 +0000
Received: from mail-eastusazon11012012.outbound.protection.outlook.com ([52.101.53.12] helo=BL0PR03CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRvDM-00000002eEJ-0Rl1
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 17:05:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwrSCp4ZrhQvGsgQUzqan7nZal21Hw31KQXaXqoufRMhnqbHOo0opZokA5pOzQMya8FITzl21FvgA4EE+QAjlItIOXmUOrTRKEKpL5BgyxSgeuTSmOTjjzd7drtI3ukejskXoes68gs0SMKi8Dk86+tS9zL0ul5SBas5arApmuoALEbhcTB/oxO19rYEHWpCZ/ObV+g+apWUSus0e8LHPdMJYdfjgH9Ewlupv+coqEPcHg9wW1frEsW676NaiYzMSuTmK+nI3sx6wTAhElBf9BNWk5MqkPLCmnI3QgHabFwoezGmqcbBYF60WvJP9h61DmTs47gy5MnVn3KlHpgs7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zcstS1whKTjLCME302cVbMi7UGN8lNJcicPx8ihBVA=;
 b=QjcWU7bCo68ui3Ruccrs5JFUloRC+hN6EGsJdrxPvkt/MNzZ+c+R4zJzsAZbtUbFfzmuwl4FGGfWGadgxfqgHqo08Vm9Cx6VAJ2TD1zIk7TLqXlGCt75syiH3nQdyyo6TK7IXyKGK0HpVxJi/cg7Z2dY4Cfh6tmEBSo+qyFIQx8pWQFfINU8L49jQ9pYYj87jcFygUSiZRLwaHe5Bl5WmnwDZGbnNUyJOxIazAJ/RfY7iKSw1eM8Jfh8micKI8ec0dDaT//xNNS8AxQCbdhqeyvBOSz0ezTVnWl4wmmHiPsjbJ1Ta6MbKXLvvrZxsnOtQVg9PBSwlHJg8leYlrDUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zcstS1whKTjLCME302cVbMi7UGN8lNJcicPx8ihBVA=;
 b=Pw+C0g4JinBCOji8fw8oE+xye9yLboxUPwXbLHf2K/AKbWFLBhTV0tgPVS9TWsV+cxS9JWArpnV2IHeAtpa/p7K6jGC09FNnpL33j8Fqr5CL5elol5Axe0PQ7T3HJW40ThLF+0NZMMnwW3Ccru+uUpgzCbqFo+vY00WGiahdy/7wc9F5b6dS6nY3yzpN8glMpxMSRBJhZCZ4FK816cJhWgiK8MBoV2cst2i5TzNi3WnPHGaqhBAUka8HgRPZk82pph/tLBimlNvk6RwnD7/p/34SlOJK+lBCk6w+BLT/RRQQtEk8Eusq6GLx7av4avxktZEWVujbvKd1Tv6nBMuS+Q==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 17:05:03 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::edab:eb80:ee7e:e9b7]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::edab:eb80:ee7e:e9b7%3]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 17:05:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Geliang Tang <geliang@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, Maurizio
 Lombardi <mlombard@redhat.com>
CC: Geliang Tang <tanggeliang@kylinos.cn>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v2] nvmet-tcp: check return value of
 nvmet_tcp_set_queue_sock
Thread-Topic: [PATCH v2] nvmet-tcp: check return value of
 nvmet_tcp_set_queue_sock
Thread-Index: AQHc7PIC7po1CxtagUifqXGu+fLGe7YgibKA
Date: Tue, 26 May 2026 17:05:03 +0000
Message-ID: <7b5a85fe-7701-4418-8dd7-949c1c5e68a4@nvidia.com>
References: <f83c3bb5e83450b46394f3c14c50f07860c0cb10.1779787436.git.tanggeliang@kylinos.cn>
In-Reply-To: <f83c3bb5e83450b46394f3c14c50f07860c0cb10.1779787436.git.tanggeliang@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|SN7PR12MB8819:EE_
x-ms-office365-filtering-correlation-id: 18a3dc07-4273-4319-de55-08debb48edea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|18002099003|22082099003|56012099006|38070700021|11063799006;
x-microsoft-antispam-message-info: 4UsFZjtL03a/epSvkF3zvfuCSIj9oqfUAJFxHbzZfnuq5ok6ZvQsBa/lkXifzTeAlJqinMNLUNq/1tCci7oORe1gNuQlTa+D1b1QmG44hvKOce0bjP7YzQQTWh1ZQveJqrRbPNSGR+BltrBzfhivCxOk/vuaNO47gfoy8pnBZrUQPHNMLpaS6uoWbBIsehY9XxMbbBGcrnMLwz0Evv5sxiCD64nRWLiHxPOBazuUezzW0+7mBeMPnTi+oEZ5Axzip3MI448Hw+pydZU/XJbmB/egG8U0RSGVNBrN1pDBmq6c4aAvCDzS/XJ/CbyPHW6/YqT8ILLiSE5U8PJ3UhgvhvwOG9fSJcwvtLlBgk0t4EMldcaux2Px2LnkhptcoKR3gdxS0pBOnZMt255Dtz0sNFkaViqX3Ad59IpAR9GioSmRsVtslbQcotsmS+W9mrstONM3U60apTCVaswYr0U/6wNmmzNEHsI5TwbtmfbzY9W3+0yuo+puCrvHWSy7Wx2sXvr5cmdW8XeK3ma/hERGMnP+C68G26cNP5wou0tBLDnK37iXNakOHXDalGq7rjX7iqabLGdONO8xl8iwXx5N2CFEwEGCDWIFFPRnA5n+M5eNVOqIHPV4EIeuuvE+sVOJ72t12u5slPGI4F2fC+JJ5HG1qARQ4xf0WfFjnoLxxkOmeWjbsvjKRULTe89AkInbnjcQDeYzr6uTDIQzKGZH4uBalIKIcLg/B3jCCrSX+L5bONGZK6hoBlyudC+rtL6c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099006)(38070700021)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkFsNWIycXNxUGJnUkk0TWRFb0UzME9HTWRvbExkNktabjlzcW1SVGF3T2xI?=
 =?utf-8?B?T1QyelBRa25XQ3ZjdDhKbTJsYWYweWtha21BbDNQSXVjU0swK3BaK2VlQ09n?=
 =?utf-8?B?bXNFa3hsYys1M3JLSWxIL3N6blczTG85ck8vd29kdDByNzhJd292NlZ2aFow?=
 =?utf-8?B?SzZ4bTdQTXdBMHR5a0QrNHRqNXBoQ1JjU2VxdW1najJjMk5GU2l4TzBHakpr?=
 =?utf-8?B?NzJFTi8xd0h2TVdrdDJBVGFpaENFSzduU1MvUTF4ZUZVb0k5QmIxWWZNVGJ6?=
 =?utf-8?B?a0U3MVdwOGhJY0hHZURXL1BHZEd3eUpVTmNjRzMvd0JCTWlINjJ0RlVRbVlT?=
 =?utf-8?B?QmhjTU9ZOGxoV0lZc01za0VCRFAxTGpqZ0swTk90NEVMU3p3U0RnNWhMK1pa?=
 =?utf-8?B?UXZJWk84cS9DQkxkM0VXUXhOOVlVWllWTTVkcVo2RkpSMEJuM092NGt3VHAv?=
 =?utf-8?B?bkNpZGFRcC9ldmNabVdPVE9YMVQ0b3dXa0lld3lsaEQ4ZDZGMHloOEwxMUky?=
 =?utf-8?B?UmlTdEoreUw1bDhld2JxdS9vMCs0S0I5QnlEd2c4SU9CRmh0MmhaVGVFalZ2?=
 =?utf-8?B?VVdXckxXYW1wWXVmVWpHRVZxZExPZzZLQnpIdVZNN3RsZlF0d2RFTWt6S0t3?=
 =?utf-8?B?NlVKNkhjaEh6U05OV3V5ODZXeVFhK0g4eVpVdE5scWM5cVdEQktsRm02V1p2?=
 =?utf-8?B?VzZnNXRrQ3BNenF2RUI1dU9TaWFZZ1pOSUJMOEtzYmtrRzFoTUZhYUJiSnlE?=
 =?utf-8?B?Z0ZoZm5lOEh5QTN5ZXdBYjFueUF3d2lmdW01aFkzQXUybmNFdzZ2UWc3eUd1?=
 =?utf-8?B?SXN2ZkZscmdTdlI4dFQ2SElKTGFuMzFEMy8xUUhERGxzWjdjb3JpNzk5bVBq?=
 =?utf-8?B?UWhxYy93WkQ1bDJHQTJpRlBlSkpiVmtTVm9wT3N0V2wvWkdqRHRCNFlOOFd2?=
 =?utf-8?B?ZmtsK2xldk9qaU5IT21GYTFWZU5KWUJmMFNZdFV6RW5ZWXBXdXBVcU5hUFN0?=
 =?utf-8?B?QTRIVm9sNnkzOE1hSGNmeHpxS1ZaWUZrV3dmKzByMzB5RndTV2tyM05wcDVy?=
 =?utf-8?B?QVVSUURLM3BsOXRaT0trZC9OZ2l0aW1UVmFTN2hzcU91VXg3Zkh1M3YyTG1M?=
 =?utf-8?B?V3J3ZW9waHpzZ2ZFaVAyVkxuK0RIQ3ZmQWZSOFJ0dVAvRjliaVNkdFEvanh1?=
 =?utf-8?B?NGI2MUtVNndRL2pVWVhUTFlhMlJqQ1BBN3FsbVRLUnZacFdXdkZhL3lVZk9s?=
 =?utf-8?B?dWFZUENVcmJ5Y2Z4MFg2TTRDRVk3T1dkeHFMWEpyMWphcm9QNTV2OUNBSlhM?=
 =?utf-8?B?b2owbnpCTUh6ajByc3RvdVc4OVdoVXNpeUtUbVNvQmVqdkZNOXNmRXR1OGh6?=
 =?utf-8?B?bDRycmNYYTJGVk1ZckZTN0duTnd1ZVV1QjJmZ1FnaUd6UTczQzJQTitSY1N2?=
 =?utf-8?B?dHlLZXBqVDQwamlsSkZRbHovekI1VGpPN3FpOGtqWEFzL2ZORUxnbmVLNklR?=
 =?utf-8?B?dG1ueEo2c2NWWE5ubGlkeWNIczJBMEMrNnBERFM4R0VicnVrQmtPaWtxcWVu?=
 =?utf-8?B?UWNNWHRaVTJvN2pxK3NITmwwMkVab0ljQVdja2Fxc0tTTmU2QVFwN0gxVXJ6?=
 =?utf-8?B?UDhvVEtyTWJYUlZCZmxXMVhIWmdmKzZ3dnBvdUY2SWxHRUw2NWZmKy9NeGVP?=
 =?utf-8?B?QVNodzNoOHpoTDh4eWdLWGJSdEJDaGJGdEhqalZvYlBTWmRjWGUycjRyd0RC?=
 =?utf-8?B?S3QybkdHYStPZ2VDSnRpRlRoMXpVc1BTTXk5cGRENjAwSXZza1MxTnNhR1lU?=
 =?utf-8?B?ajdacGtNOG5HZTk1dEdCM3N2MW51bDNuWnZOL3prdjZRUDFOa0kzV2ZDUmM3?=
 =?utf-8?B?a3pnWElLSEk3WVl0Q2tIUnViUWlTRXNhWm9MREdMNm5LVTJwVit3bWZnd1R3?=
 =?utf-8?B?bGpZaFVFMENBLythS05rUFVNeWo4aER3eHpSZExvY1JPbFpnM2d5Q01nUTdu?=
 =?utf-8?B?ejV3YVlIVGowVGJBMVFoK0NQeFNqUXoxWTg2SHE1L05UQjNRTDFjNHcxb2pM?=
 =?utf-8?B?SjVHWHFqWHp3TjM5Vk1rRXM2YVVsd3gwbGRvaGpCQmlWTWkrUENlRlhnSHZF?=
 =?utf-8?B?eFJsVC9wbXUzcEp1dnNHNWZSbDF1YURjdklicmw1SGdZOVhNcnNTWU5BVVV0?=
 =?utf-8?B?QUtFODZoK1hHZXFHSzFZa3RFUDUwQU5DcDlkSE5BMzBzdWdoRzJRc0hoYVNk?=
 =?utf-8?B?bEc4MDJrRklxVm5GQ1E0MDluUElMS2hvcUpma1NYUlBUV3o5SXByV1hGOUlZ?=
 =?utf-8?B?QXJOOVNzTGFwcExRSGtEK0FwOWVLenJFcDY1RlVEdzlkYldwd2gvTk1KT2xm?=
 =?utf-8?Q?zn73MR174E4Xmd+KtFEVwsritNjYuvlfpXo9q?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29601D49018FCB45A86F3A9B4139F7AB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a3dc07-4273-4319-de55-08debb48edea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2026 17:05:03.6231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9dyiVyabqhLrRj5L+vqRuA5S8H3/2j0Rxfx4GzchMphNgDfWRQXMX90sb9O49XVDEboAXw8+/HpVlVDbQ8jpbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_100512_148831_0EB734F5 
X-CRM114-Status: GOOD (  12.16  )
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

T24gNS8yNi8yNiAwMjoyOCwgR2VsaWFuZyBUYW5nIHdyb3RlOg0KPiBGcm9tOiBHZWxpYW5nIFRh
bmc8dGFuZ2dlbGlhbmdAa3lsaW5vcy5jbj4NCj4NCj4gVGhlIHJldHVybiB2YWx1ZSBvZiBudm1l
dF90Y3Bfc2V0X3F1ZXVlX3NvY2soKSBpcyBjdXJyZW50bHkgaWdub3JlZCBpbg0KPiBudm1ldF90
Y3BfdGxzX2hhbmRzaGFrZV9kb25lKCkuIElmIGl0IGZhaWxzIChlLmcuLCBkdWUgdG8gdGhlIHNv
Y2tldA0KPiBub3QgYmVpbmcgaW4gVENQX0VTVEFCTElTSEVEIHN0YXRlKSwgdGhlIHNvY2tldCBj
YWxsYmFja3Mgd2lsbCBub3QgYmUNCj4gcHJvcGVybHkgc2V0LCBsZWFkaW5nIHRvIHF1ZXVlIGFu
ZCBzb2NrZXQgbGVha2FnZS4NCj4NCj4gRml4IHRoaXMgYnkgY2FwdHVyaW5nIHRoZSByZXR1cm4g
dmFsdWUgYW5kIGNhbGxpbmcNCj4gbnZtZXRfdGNwX3NjaGVkdWxlX3JlbGVhc2VfcXVldWUoKSBv
biBmYWlsdXJlIHRvIGVuc3VyZSBwcm9wZXIgY2xlYW51cC4NCj4NCj4gRml4ZXM6IDY3NWI0NTNl
MDI0MSAoIm52bWV0LXRjcDogZW5hYmxlIFRMUyBoYW5kc2hha2UgdXBjYWxsIikNCj4gUmV2aWV3
ZWQtYnk6IEhhbm5lcyBSZWluZWNrZTxoYXJlQGtlcm5lbC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6
IEdlbGlhbmcgVGFuZzx0YW5nZ2VsaWFuZ0BreWxpbm9zLmNuPg0KDQpMb29rcyBnb29kLg0KDQpS
ZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoN
Cg0K

