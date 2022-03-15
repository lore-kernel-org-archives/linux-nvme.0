Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D450C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 22:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qzVje+zbe1PHw1qVeXPBiK76dhkRtgOkJFky1g1Asgg=; b=o7Hul5juYHVYjoRQ7K7fxHbn0z
	HUNXHPWJKJ9C6a4lNXZAgSBmkUQPGASomW66epd79V5O5o61n9E8zQt1KWn0fWr9bJt33d6fxsS4T
	VQ1zXslYBAFo1/kzrVd2he2pHqQvLCvm4nGnFNp1ZdbC97bur7vy8zO7mgbINl6Ja2YurTrusKNOe
	z9i7citbBl4+3zsZaiN0irVbBiBQaD1fQfoAaWlOCHI5ONkhsfNrWw/1AvKgNQL4ilrj9WyJI67nN
	L9E1Kx2MH9IyPfHUtNMLNFGyH3ds6OWkkn3EQ+riNR6rzcHnmGJL8DoebgBO0gUoi381vAVjKfKkG
	aPAnQoIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUFP0-00Akh4-SA; Tue, 15 Mar 2022 22:12:26 +0000
Received: from mail-dm3nam07on20608.outbound.protection.outlook.com
 ([2a01:111:f400:7e83::608]
 helo=NAM02-DM3-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUFOy-00AkgV-R6
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 22:12:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIinvm3kxnhFmsvoShNC72fU5EDp4Oyyu+Rhcq/t97yVG5jiIUCRcNzPW8alQjpKifw1oq6QEGOgMdy0ohvbsd2f09wYdIUOj1eXvhG2TJGjbrn2TnBQyNbnaw2xLzcRp3DbzGwWlDkJUDTxn6AI/JjNiLjGE8VONr8wAlcqx2J0YZUdsPMPz9CjsHuQ4Ph0jPboLM20dTdAo0POslx/ZXF8ZY6lazkRfVq2H4mtzzQCuIRfIATIc5EGN2mzZnQOOtgfBuGPhkswi0e+NdfU4GN5oGdHHTQqZ/ll6J4/mVVqonz0Rc19cLswmJVlFETVHCqxhf0g6Vw85Ho7J+6Qhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qzVje+zbe1PHw1qVeXPBiK76dhkRtgOkJFky1g1Asgg=;
 b=P6ZLq7zXvU2KszVgmRz7IwqsMXjpCJ+uk5qvfUMOZrV6rXYiDVfzwNutRqKEqOz6eubEiswEWG3RzSlwR8+eFqPQLxUa8lbdg+qwjzpcm44H34zE5x3+ioG4ppnZEPO0uwokzL8R2NvkAqhXrceRYGuPtUOLJ3Auwco+hqlzLmwBvQdwnEq1uPdbBJkDtlotBkqHa7zT9Z4crKA5pjItiGEHAcoWPTz+AUsmUvt8tMKp+tqhYQAUIHBTgv8hOtq3DiDW5YP21LKtuPlVrpZIuQmC6qHzzRHVlP85uUsvM1Mfs9AAGjFLe1zoVazhVbNCFVvhl8f3Ra9S0XGgKRQoDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzVje+zbe1PHw1qVeXPBiK76dhkRtgOkJFky1g1Asgg=;
 b=PvN6huc1c+F3Ad4yxdUn7CiJz9FgcVRa/LzVQnF8KmrFWPv2R8BspA4K2FvAE5j0EaEib3nOQPwyNwVqMDuHiwCUUVDCPCIW0aWPBUvZMKwCkv5A46Gdsp/tkVdoGi0A0/3QVCnN21i9O1j62xFeq7XU1bIjdJm4J/q21eyLypiUVrmdRD/qI0+8kwGcFhQFakjDrucm2NAPCHinn0UIBprh21NH/YF1KknqhDPBBT85W8uX91FwWAW/l7WCqCgkQyUUjMD3pXfmAu+4C32oTf8MmYgE0pXHgG8Qx2RHVqxYAcenIWgQP4AOrotMGvy4UdDo/aXiBfDISDlRSM0cWA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN6PR12MB1188.namprd12.prod.outlook.com (2603:10b6:404:19::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 21:56:28 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::204b:bbcb:d388:64a2%4]) with mapi id 15.20.5061.026; Tue, 15 Mar 2022
 21:56:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: remove nvme_alloc_request and nvme_alloc_request_qid
Thread-Topic: [PATCH] nvme: remove nvme_alloc_request and
 nvme_alloc_request_qid
Thread-Index: AQHYOH7V0qSX/I8NqEiFfsDUBFWD2azA/gyA
Date: Tue, 15 Mar 2022 21:56:27 +0000
Message-ID: <ce873c8c-e75a-bdec-5398-8df19302f4e6@nvidia.com>
References: <20220315150222.2590959-1-hch@lst.de>
In-Reply-To: <20220315150222.2590959-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da9a5714-2552-4315-9709-08da06cea7f5
x-ms-traffictypediagnostic: BN6PR12MB1188:EE_
x-microsoft-antispam-prvs: <BN6PR12MB11887898A4B38E14EC0F423AA3109@BN6PR12MB1188.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n04KVXtCXcQt+f/8Dti6bgp0ipF4kDjICRRugIcIeM2gU/KWF5Sa8+ki0vEnoW8EeK7f1FRe1lK0esNK9Tsg12Sp8fmvQKtDHKz/jMf7D7A9R4kVro47+98kMMpHkRVmhWWmdrKJIbDP0LakpZVHsomcbs+2l8qDXy7KCuEF1wdkADwVBwtveA3iSzIFC+WAQYwujwOiIi/CaC21oE/sN4ayD+e+GEFg2XrOUkFITtTphFKHaBoSg8f2jNCIxG/tb/l8+rjONkYY6r5obgDobfTjPoIL1e1cFegpT2Gt1GsC8vVV1M9+kwY6Xi1nXRHwkqk10lQo1jsjDY6xrsTRVwNJjtIKLeocyeWxu9rkCp4Hk2bQAOauFxEkLanA6/Xmamedzb2pUi/9hPaEb5p9Hw8tHCamyzVVG2gXYrjipsePghRmPWUP5O0z0KmYx39JoIFbdlFYnzd7yO55K8rF6NImELUyp7pS0QJyZYzf/0vhO+VKJ2FBq+ws8u4qpAU1eeUIhJRNzTHy6yrUSsFg+trOYEuNfKn5EZy1ITUV4/3TB+TEhLi67EAKRj9oh8I5GK/l1sNRDPvq6dj6quQPMERSVsY/V8f7nKo/y/tsxQP29S8X4piJLuVRy2wUND32jeOG+2/y5KtBkuXuHUsYpyIqSdFMcXXky2R+39t3GI8ZR3xDdfBXS8ZyGdKkumxbK/Zszyyai3Akdy2L7QhcdNdwY6y7K2omQNWAYKWKlGzdrodvf8ZYus89CsbKZx8gprjXYV3Rt8Q5Q2mVCTVv4g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(64756008)(66946007)(66556008)(76116006)(66476007)(4326008)(66446008)(6512007)(6506007)(186003)(8676002)(2616005)(86362001)(508600001)(31696002)(91956017)(38070700005)(53546011)(71200400001)(2906002)(36756003)(31686004)(6486002)(8936002)(5660300002)(558084003)(122000001)(38100700002)(110136005)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1EwMk9jV0FZN2VXQ0dlNG5YY0RFN2hJamx2cEZlUFBiaXlZdzlUUDBmcEJV?=
 =?utf-8?B?WjR3VC91eUx5dFN2MVhNb3FYandKdzY2clZmRmFYTUd5VW5oYUk5bjlja3NH?=
 =?utf-8?B?SndHREZ4UjJOUmQzVnYwdjdhVjhUT1p2V2ZNcGJwdVhlRkNUYlJoVUJVaUNj?=
 =?utf-8?B?TU8vbUhvRUo5T2RkRDRQcnBISWsxS0lpRzRsYWpOZXlFV2ltU2NURktEVkFE?=
 =?utf-8?B?S1hkU3lNb2pMM2FyTHFvMlBRQkZ0cHQ4NmluVE91bGNsNUZ6U2JCVmhhOHZa?=
 =?utf-8?B?MTRVRUdSQkhGSy8wbEpIZnhxc0JsS1R2ZTd0bFBZMWlHYUd5NzdKQUFyazdy?=
 =?utf-8?B?cEt2V0xCYW1KWFdjb2lDdStxenhsNkxQUWVSaTV3bE5FNW9sL2g0QmppMWxi?=
 =?utf-8?B?d3o0c0xrVldhRzgzZ2Q4QmE3dFBjNWJlWUdVSGpBK3JhVlgwTU1KN0xnSVVi?=
 =?utf-8?B?L3BhN3FtTHpXcU1adU4wbWE5eUVZSWR3NW92bjRlU2MvNndaMjQwamlCdFZ2?=
 =?utf-8?B?bkw3RmxlYTFMZFVCMjRYQjJlS2ZGYTliTjY1TUp4TXZFcUg0WTFIMk8vNVhS?=
 =?utf-8?B?STEwNW5YUlNLc0x4c1lTZ1M0cEV1YkI3cnBhR1FRbGlQMElUWC9EdDdmS0tL?=
 =?utf-8?B?ZHVxcXFzNUIyWmwzOGw2QUdkR0JvWmJQTTBNeXlkamt6UVh6QnNqb0VFQnFz?=
 =?utf-8?B?TTZMMTdJWGJQMFVFM2JxaExQUzRxQW1Td0RqWXI5bTFzc0hVZzNnQUVuSGZu?=
 =?utf-8?B?MENTenhIVjltbWRGZzBvTTlTZ0FlRVZSc3R2dFIycDJjeVFhVDFKOWZQdnpW?=
 =?utf-8?B?SlJERDJudkpCOWZKTFV5WGNLcEpKYjNBSlV4REorZnJhSVZLUVRsK0crOGJG?=
 =?utf-8?B?Nmk3R0ZsZzJKcFhHbnZZSGo2VmN6QmdGUDlkZllKb1JVR0dmaEN6bjdJWG04?=
 =?utf-8?B?TUtod1J3WFozcXJsUHd3OHVUTno3VFJVUitkbnoxamF0Y2JzazZaWjcvVWpa?=
 =?utf-8?B?SXp6eUpubTQ3dVNkVktnZ2xqanpNMThsMGpRZkp2ME0zYWU2Q2ROTk1Nb3JW?=
 =?utf-8?B?cUloRXgrWFdIOENHMWhtWnhRWVNQQWIvZURBWXp4MzR2VGpCU09pUWJQZmlG?=
 =?utf-8?B?d2dnRUJHSVA2Z3FHUU1BUTBkM29UeDBSakpTdWNaREN3bmVaQ3h6UlNiOVFk?=
 =?utf-8?B?Mmw2L2FLMmZXeHB4dU1pZmJJNXh2c2dLV2lPSnV3YzFCTVBHTThtc2xLSHpC?=
 =?utf-8?B?U1UwL3cvTi9iU3d0Y25EcCsxVG94YU9XM3BpQUVqUEhja3A2andkUUdRay9Y?=
 =?utf-8?B?TEwyOWlidzdRNktiZncxTGlybGY1NlBKanRRbWhDdVpGTTlab2tYV2NlU2Qw?=
 =?utf-8?B?dkdpb3pEd0UvcVpSNUVBUE1wcWpSZDBhbVZpUjdHY21xU2xhRWl0S3pCNDZQ?=
 =?utf-8?B?YnBtMFVYZTdWRk8wSzNFcE5UTnZGS2V4VkZSWnpyS3J2STN4bmhVbjRUVWQx?=
 =?utf-8?B?SXlQci8yTnA1Y2lnMGJVRG5vWHZ4RVl3RHVkKzFoajBOMnAyZFkvSHRXVTl6?=
 =?utf-8?B?QzZWZkZqdGJQL0xLUjRycjhlR0hJb1NEUUJOODRBYkdiMCtldkI2a1NXZVI5?=
 =?utf-8?B?clpMR1hiY2svdnNqdnA4RnNpUS9xRHZmT3p5OVRnTW1XczBJSXowSzl1ZXlp?=
 =?utf-8?B?SDVtMzd0MXgyZ2VLbFhkVHpNeW1FWW9xR2JKQ2JBbUFRZDFXVkpRMkw2WHBG?=
 =?utf-8?B?SnEvbFNnQVpGQnlhbFJkSGRncTVjTjg0bDg3QUIrSWtpTGtFUXMrcm5XaElM?=
 =?utf-8?B?MnZlVkhPYmljRUM0RTBnSU9lbG5IOXRCd3BONW5TbnBJZEZDRmxyU3Fyb2h1?=
 =?utf-8?B?VGxtTGpkTXZiaTA2U3dYZ1JZUER1dUxoV09hY285dlgrdXMvYjBHWU9LQzVl?=
 =?utf-8?B?djFkU2hzenVtVHVDaHVuMUVPNFdxZm1LcVhKYlQxR0Naano2cUwyVzFSL2Uy?=
 =?utf-8?B?dDZZMGhxeHFBVGJ4VVdoUWlCZjBJTm4rd0p5ZThxOWZjR0NjRVhxNUZqLzRH?=
 =?utf-8?Q?ODLTVp?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D54E3B3B1B4E5746AD2B832CDEC99389@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9a5714-2552-4315-9709-08da06cea7f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 21:56:27.5703 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bj1+LMj6XZMgw70TMCm45yqk96oIqnRfA9Yy0GUbheMliO3BnYUC5Xc4yIqXoKMikZLsPOzAqNkjb5bSjijUOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1188
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_151224_891561_C3096855 
X-CRM114-Status: GOOD (  10.73  )
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

T24gMy8xNS8yMiAwODowMiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IEp1c3Qgb3BlbiBj
b2RlIHRoZSBhbGxvY2F0aW9uICsgaW5pdGlhbGl6YXRpb24gaW4gdGhlIGNhbGxlcnMuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gLS0tDQoN
Cg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==

