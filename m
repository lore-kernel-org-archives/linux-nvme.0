Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55609C54EBD
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Jan 2023 07:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gyj1rGrduYZiubRyrPWkVJGFx55pC92HQkGNgiubvyk=; b=vnMiwH3RNdWTyRg1psIeU66I1M
	r5aA8JuNSCLTcfwH7twzuYr6wnUCXef8uqKHs3Ty/leuS4F8wr+6uxF7UNZdEzLz1I1/eMB6u4izf
	F/J8cr1/XI22Eutikge+b9aipdZWAf2Fb8rLFy1UJvujZGDhPaZin4wGotXaOdXd5E6cf9bTc31xj
	XHrT9uhBHupeKk0G+2bhJDUl/IuQhZXDgWukhEMPikrOf9i/ERiuNwtl6/0tF1OrPA4S8PJcBWsY7
	avppw4jt2dhjs8b/HflLJYqxl9RAIXtCfrO+AqYiqmB+Q4QrUOLMRpjsFoh8EXqtx1xz49Y/yojE4
	RfngzETw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmFh-0006xc-Ss; Mon, 09 Jan 2023 07:07:25 +0000
Received: from mail-mw2nam04on2083.outbound.protection.outlook.com ([40.107.101.83] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEmFe-0006wX-Ig
	for linux-nvme@lists.infradead.org; Mon, 09 Jan 2023 07:07:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRKOG/RX1aaGVLciII1RTt8GsE+3X6UYgorpsQWPIpjZbSTZRLs5RPFFkCZZawNdeSTBXJhYLv9UemnOITld5zqQMedj9PARhrVLxCQKucDEX9UAP23D1i7tsB9UtMLs8Tuwv/WdvMxm636bUgsosXSGiPrlULHp0sLRSXiZVNFX+CLR+lJ6yLtfG6NZavcSP775lrSIKBLCqg4a7hux57+Z9RkRR0otf3MG7dA87iWst3T3w3kkFE8R6c1Jnv2qXHqpdUrVGubWtYS/lYqArxTmqRDzeXoB5p61VuI5Ua75Snp7LXbVu9XDN1LiSzVdE/AqTqfeUNbT7wZgkZwP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyj1rGrduYZiubRyrPWkVJGFx55pC92HQkGNgiubvyk=;
 b=Ji7ijew3NPW/A1CKh52B0d4zB1TqhBo6xkfSdu6MGdOUcWk4WGtyssQ2Or6XxITxhOwijYYnSwMQAYPNFIiXl5hw3CZzYKnyy04FDWniL62yVQIDujGQEd13R+oTebJkzfwjHs0qnAIXsYJpmxpIQkSFcLzEuKWzQEOndNMSduwBXmMRU+manu92AGTbo1BMyD4V9lN1fiUJ81U5V2rZkKODaK/A1hEPGNVhbMHicYF/k2XOs4B33GxWGuWW8nmMHfCxOrNugTYjTdnhOZdsZMQHjTHYJoP+941zB8ra9GIzcYhHEvBNMZatnV4/UjRqC+aGHX+1gPl8qcwpw4+BsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyj1rGrduYZiubRyrPWkVJGFx55pC92HQkGNgiubvyk=;
 b=sUdPyYslcOxIoO6GW86EmMCX3fRk6bVmyIn5qB8xc56j7H2OTJwTeL2iiKz+1NH6VbeXADdfoP8Nwr7ew/TgfQhJ/pGNdlP1/8jPejZF4HtFCw431RhDkzLc1qDtMaufH+eC3K32lY0DWL6nduHYVvNsKwRjwMiHryk+zRqPew7s7BiY16zBiAb58U/Do/+Y/5msdZR41JhnkoDKqKi0+xVLlhqrjUh7Tth2y1vxfWUvduskgUNTwlrUH02UduSBqFePxG/0kvMKIddvm/p1dBXhD2du9jvq/kY9RBTV+XT3rvM4edb8GsAttL1kuVllGxFieTfPwIpuW7Z4bZEhvA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Mon, 9 Jan
 2023 07:07:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 07:07:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/4] nvme-pci: remove SGL segment descriptors
Thread-Topic: [PATCH 1/4] nvme-pci: remove SGL segment descriptors
Thread-Index: AQHZIVz/Yhcy9P5/AEK438SdWg+mp66Vr0sA
Date: Mon, 9 Jan 2023 07:07:18 +0000
Message-ID: <f33dcc57-c99c-75ca-452e-b92f24405932@nvidia.com>
References: <20230105202833.3225645-1-kbusch@meta.com>
 <20230105202833.3225645-2-kbusch@meta.com>
In-Reply-To: <20230105202833.3225645-2-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB7216:EE_
x-ms-office365-filtering-correlation-id: 64bc9ff9-7624-4318-2662-08daf2102553
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  A94Ag14/fDvYuSzf1hhrLA2saQ69NkBiZEIS8TLK/0ht1aZU6svfAOxgYhoUvfzuNgYEon7BK2KdBU0qb2NKrOG8B7WaNFvn6oGNFmYSG3FpcVI/6PPDsTMGc4fKMSi1UAWxVVIluPisOfRt8f+BllLWLIYARMEFmf9cmWBk6n39BiAJcGue5JvgNvSag7/NlPb96IVY1Rd3kuEFHnNixb2hvvjUDLJRkI9qCuVIXVcZDYCqyk99CxiCFoMq+ZNU+yco3o/fgP8IqutDFTnAXZKwJrnw5VcOZnR2grYn3wSz7YMqJPFMOr0uQwhcNFNnO6Z+MJGKWzqo/5zGFOQntUd+tcF4Y6a/Yx5iJVAPfKInakKMuA1q1Cz1cfY7ykIdhQh+jOfBPfN8hF/G3mo8d+1Y5q9awygjNuKayJ/GOwnH35TnMOsZihp1FllsDLIaIXGa77rf29M5p6I/uq/a6ORwchjB5BSQPYY2pS+Smiru1nDNoedWhDQv9ySf5qiaHxS1yeAgzt3M6HADS5oy4nXCmrhJQcmMRjaRACL5oB8lJEX4uq6OaZs1Mvm1QC//SMxf640kHiE8QMSoiZ8sI29UM9D3LvwMmv/GaNiloQrdfMoDnR/mB+RFhEEYHOqqaCxl+dZ5Pn5b69fAcFXGD5yTol1DbN6a4FhgL5gUWfkIhqLkuSvW2tmD4QYVtLlOmkBU7dYfMnkmxVjW1gi4dY/00rxLr+lqjPNPRJeV4jaqvTLAOMpMFtmIua0b40cR
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(451199015)(53546011)(2906002)(71200400001)(6506007)(6486002)(478600001)(186003)(6512007)(31686004)(110136005)(316002)(2616005)(36756003)(66446008)(76116006)(66476007)(66556008)(8676002)(66946007)(64756008)(4326008)(41300700001)(5660300002)(4744005)(122000001)(38100700002)(8936002)(38070700005)(91956017)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?M29FYk5VSVRHVmxSMU5WVWJQM1R4WGdsaXFJdmZ3TFVXR0xYSllrN21uT2lB?=
 =?utf-8?B?NFZna3B2MjYrcFNETzZWazltZ25YajVrbVd5VnM0QjhxUE84NU5lNHlyV0RH?=
 =?utf-8?B?c1pkT2tkMUhrVEhkTmRHTGU3d21yeFF4TEpnM05kbzQ5blVNVkF0OW5oYXJh?=
 =?utf-8?B?VkpOQUk3ZG1EeHBQUU5RYmFkRi9sYlRwczN5em5CZVJkYTc3R0ZWSFlNVlhP?=
 =?utf-8?B?WUsxcUNHUVhVTGlCOStVVW1HNVhkaWpzU2lUNjh1YTEvb1l3UDNsYk1QaHFT?=
 =?utf-8?B?aFpaSnVtZjBtR0p1YWcyakZLWmhLWmFYNEJKTjY0aVhuNzhyZ0s5ZGVZUmpG?=
 =?utf-8?B?cW1EUmxidHAra3Z4aWZXMzMyeVd0ZlFmQllYL0pWZjJDbTRPeFpQUkRFZG1S?=
 =?utf-8?B?TStQdGRFUTBHU1dtbGI1TmZDblZhSWFQSDVqbFZIdC9FTDZmb2J1RFFzOGh5?=
 =?utf-8?B?NG9RRFNnRTczMTJQZnB1ZHA1emp6TnlNdit5ZmltSUFLMjJXb3FoYzNMRjFO?=
 =?utf-8?B?OFFrYmM1VGZtbHFtYnlTTS9nTjJVYzNwV0tBSkdMcThWS2krd01CUC9zV0pt?=
 =?utf-8?B?djRBOFNweHBXcVRWQTg0dEEyamlOSG5xYnB4ekl5OE42SUZHckl5dWE4MlF0?=
 =?utf-8?B?OGM4ZVUrdXVTd29DYlI3T3NxeXZ1ZUphVUdPcE95SEhXaEQ5Mml5eE0wS0hL?=
 =?utf-8?B?NCtDc01lR2lLVVo5Ri9wOU1xL2ZMM1ZmbVAzVFJNY01NbWtVc3JZQW5IeDhH?=
 =?utf-8?B?a1praG5idFVLT2NKT2VUUHRrNWpEUDI4UlF1ZVdUaWV6Rzc3L0dRMHdCZ0c2?=
 =?utf-8?B?dWFTWVlnb0cwZXlwUVNCWDZ3Ylg3ZHAxS2djM011WWNXSDlnK2pIM0RyNlFj?=
 =?utf-8?B?ekZVSElTUzNPUngveGZBaThHZ3MwbGZkWm9Rd0RJSEhCN2IrMzgzblBBVEdL?=
 =?utf-8?B?enlTQ241WGZReHI2QWVmS0JoV0pvYldLTVZuL3VlVTZNSm1OalVsK1ZQek12?=
 =?utf-8?B?Vml6Wjg0cHFveFFNMytUc1pMbjZ6ZVV0WXU2c0swTWU4M0F3M3Z3eW5FaTBa?=
 =?utf-8?B?RGU4cWZqZTg0M2VLWjFjckdpNHFkL2lLUHUwdzVEK0x5eUpEVjBoRWhUQnUz?=
 =?utf-8?B?b3FtUHpjTUU1VU5wcGx5djd2MXlRRFg4TzRmeW13SFA2V2NQcFJQVnE3eXdu?=
 =?utf-8?B?YXFKWWxnU1JYOWRwbEtLRVk3QVhmdTduZWZoYUFURG5LNERQUk9sZVk0M1NS?=
 =?utf-8?B?Skw4dVBuZUJTcTJFN0VvWjBlMHRjRmpvblByRkoyR3ovTURBUGxISHZwcklm?=
 =?utf-8?B?Mys2T3dhdy9TQk1PekMwNEhnMVpjSGo0STlDbHJnYW12MVllQXFkcytHME5j?=
 =?utf-8?B?N3k3R3puTlZuM3dtSmlLYnJiTkYxOEJoaHlxZGdUTUk2Uk9MdVFuNk1CS3hR?=
 =?utf-8?B?V3RqNnNMWDFXZmtLalplUVhkanZPemUyVmxUU1BzRmpiNmFHUWdlNVRDSmNl?=
 =?utf-8?B?UU0zc3JkVGx2UDU1eDB4SWlnL3VoVElxYkpXemRGWlhCa0ppZS9oSGozYytR?=
 =?utf-8?B?K0JlejlLSE1DRXFUM0M2S3B2cjlWMDNQUUR3dzRudC94aGJ3a2lLTHZsYm81?=
 =?utf-8?B?WmdwYk42MFFjMmxwcEZ5Z1k1cGtWenUxZVZzempIOXN6TTAzM0hYa3RHNUdE?=
 =?utf-8?B?MHRieWpOREUyOUg3WStJdjRROFRIbzFlSDJ3dklkbFR5TXlrNVBBcm1wTU01?=
 =?utf-8?B?QWNHN1krM3htY0VxWU5mcnMvcFFRYlFhM3RoN2wwdUNxSld5VnU3SHBMbkp3?=
 =?utf-8?B?S2NjSzF3cnlmSnpKVjkyWWFheDNRMlZZOGJhYy9Ud3dpTmY3UnhVSS9XSGZX?=
 =?utf-8?B?NnRHeE9MazFjQ3FQNTdhUXl0cnhhUS90WTIxZU5QaWVWaGF0bVlYYjlOTW95?=
 =?utf-8?B?clFveXhOaFByRW0vbzhJWXREdVJSMVpCbnoxeTdtdHVpczZ0UFdkNVdXWVdE?=
 =?utf-8?B?MC9oS3h3SFpoYno1RDVHV1NtYytqNVpxeGhmOXFqNHJSL2c0NDZFY2srMlJl?=
 =?utf-8?B?VkdYYWMrQWFZeVFSY004cE5NNDg3REJjaWczcm5RY1lDeVhOUEZhOTBsVkI1?=
 =?utf-8?B?MmxZWnQ0SnlhVjZLM01JTWEvZFdpS1ducjdpWnlqZ2YyUVNhZXZibGxCTUFI?=
 =?utf-8?B?d2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9DD0F3E8615E346831ED216CEFA5821@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bc9ff9-7624-4318-2662-08daf2102553
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2023 07:07:18.5638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfoVc/MZEOgP4OlXbjNXdfk/6t2kL+IZu+5udRGyBwhSLOG67VfptwSLXT7s+7At84fZDcSXJCPW/nQXP3KBNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_230723_039625_B3E4F0AF 
X-CRM114-Status: UNSURE (   9.21  )
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

T24gMS81LzIzIDEyOjI4LCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gRnJvbTogS2VpdGggQnVzY2gg
PGtidXNjaEBrZXJuZWwub3JnPg0KPiANCj4gVGhlIG1heCBzZWdtZW50cyB0aGlzIGRyaXZlciBj
YW4gc2VlIGlzIDEyNywgd2VsbCBiZWxvdyB0aGUgMjU2DQo+IHRocmVzaG9sZCBuZWVkZWQgdG8g
YWRkIGFuIG52bWUgc2dsIHNlZ21lbnQgZGVzY3JpcHRvci4gUmVtb3ZlIGFsbCB0aGUNCj4gdXNl
bGVzcyBjaGVja3MgYW5kIGRlYWQgY29kZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1
c2NoIDxrYnVzY2hAa2VybmVsLm9yZz4NCg0KVGhhbmtzIGZvciB0aGlzIGNsZWFudXAsIExvb2tz
IGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29t
Pg0KDQotY2sNCg0K

