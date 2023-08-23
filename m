Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF429C3DA6F
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Aug 2023 19:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TAPPn3UUW/yWvzk6xAMCDBg6syDwRch1ZyLaZC70kkI=; b=1bXgOR5x8Lq28qoYCwcpdNab70
	82Ay+JgC0O1svpfTvJNm8gHlqnHKRFShCEIB5LNvMAbG6kH7IakNl/Gh8sYDJdaJsJAI5+rzuOWk3
	f0sGwcxwGO5H4n5X8Um0A10rbx5uGZ+uE4LyLoTwQPY4l+9yYiT9rhEY2L93e5IXtuuROYD4KohkW
	RK+kqG9mc/BwTZXcUHKPHhr0CVc3sVbfa5650lPNoNg5P4W9xMAcvRUcS65Sbcu6r9Zq3RtQO030v
	sJP2CU0b5feKLYIXv8sqTINt8c/yiHqembHUyAjPCI/XjPmUHfbsYtzCfgaLq5Q4xuwRExghpaOmT
	KPIH2scA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qYteQ-001QHq-0e;
	Wed, 23 Aug 2023 19:36:22 +0000
Received: from mail-dm6nam12on20624.outbound.protection.outlook.com ([2a01:111:f400:fe59::624] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qYteO-001QH4-0G
	for linux-nvme@lists.infradead.org;
	Wed, 23 Aug 2023 19:36:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty+thhQyykBa2UiPYTigjbFgteegckc6OfSAN7kk7/4ctGSnk+gpxZupE4zp7RMNFvzaEYpoTBAIrjHpE9ThXhCz00U6rjGlfidHwdPyXuMFIpDF4npnwNCt9u5zJLVAoPtetNJpmIjTzu2yGLKkpj26M+KTOSNeASMkdIUo2XJQwL9KSetbVCuuErOyOoPGRTJ7nROR3Ai2T1OoXt6xxP7UztMbU0LSINEgJC4OakjFIgRVYSnd67aLykhpiNBsglNfmK4cz47HFPS/6zyE84sUnEuYxZpc7/BT9ZdRIDMtI5ltQeLPZVtibChN+dxKQGQh5kQ3FfNNXaOGFqGNOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAPPn3UUW/yWvzk6xAMCDBg6syDwRch1ZyLaZC70kkI=;
 b=PGyEnid/InqXB3W8CNal1WCWevTJPMBJoU/xf/mIgzl64zT8/0XhPc1DdJoOnKJaZ+NZSEDk4oY+scP5UHRZ1eoInDjpNcJi3esMAK0TcvCCT7HESUR7jUaR62pAYc+zdHfanczx53Nc+z0yOWZzGtOf/rL8qLF9n7ucoUuAUk8WXtwW3d+oTdcc4eucJ0pTdbwUDDBkWecIFM0KlQsb7bqp0Y9QmRVueuQuJ34t3jFwd8n2cQFLwgmhpHEGDXj6PX7gwYjefTmHAMgo2r3O5TjSK3BcG79wiMaX63MtM5jyNV6cCl+k8DDFH/FWj2xCLHZ0rJeBXP2uj/kFUfIFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAPPn3UUW/yWvzk6xAMCDBg6syDwRch1ZyLaZC70kkI=;
 b=PCQ7Z47xn39zsbTfUv4a3ianqUKslorE7mhX/Cc7hTSDcH7Eq+bXSj5M9h0HJT29lXGBx9/a86t/eR9HtLKEwIW29zwn/IZr8U7zEIuLSk4G53HvmV52oGsyAW24QpmBQ/w/aVL0YaAc3hqTftFveBoAgE9cNTdk0L0DbkftPoWAneIfGihwRaRI/3VQ6d6s/CVfFOLyd7RV7zOcssgKDEicOJhN1UD4UWFAE/qxvQAFN9O8g+tNQBXRRuUyTiR1LrrUXtPsKsY/iHuQ7erse/I6e1HJk222DryPCDDNKe1NIoxuU1ykbtO9CIPyFBCVv2nXIhp2iNHfQede6Dduqw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 19:36:09 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 19:36:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [PATCH 13/29] nvmet: Convert to bdev_open_by_path()
Thread-Topic: [PATCH 13/29] nvmet: Convert to bdev_open_by_path()
Thread-Index: AQHZ1a+IEMxzs7PskU2CLMV2gFbmza/4RsSA
Date: Wed, 23 Aug 2023 19:36:09 +0000
Message-ID: <d598a6ad-8542-ab06-66a7-415236a680be@nvidia.com>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-13-jack@suse.cz>
In-Reply-To: <20230823104857.11437-13-jack@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH8PR12MB6794:EE_
x-ms-office365-filtering-correlation-id: b64ab9dc-b2f1-4868-e84f-08dba41033c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zllC8ZFDJiBVdahtWQ75kuoXB6UOXa7W+ELvgf30DjufGfkdTvUgWirJjE2QoTpx3aXxJnYPOWyxeTHI5fjAqqGb4WupxMds84YqSUAZabH3kGuB6E61LZDd8oFmiVjHj1z1yjTT1Cd2Nn7J/H8dLnTZLK7kRSZVr3w6lKFnEyGu2cx6+Z+csDJeTZgGw2bV9KYayWGmKQkZsLCMwL1/Jl99MRXjqw0CEEk9y2pzPy7MXJ+R7lBIglsmf2UHQ1OsovvlYzaSlmKq9V//oDXhgXmZCfw1SAiBIKXqeVSV41ewdWCKdrwItPhk69zLKUggD2vSt67zCB20tga7VaZB17mlSqbg22wALJe+zMHmXBmUOFXFCvYP8h/ajYcnoT1tQRmL/8NrbPRkC4Tpl3dclGXDXbi+hlIct+8eqVX9DQJHFt2++7lB+AgSzdh9aOlyw4fnDrILSg+DveK3qQxROb3vY7KfySDA368ZngB1e2xUUT9/od3dohKOHNJPwGsv9EWYn/74vFoClVdAYl2QYNpoKHbX0DIGYQDYKf5OrePMFygBk44ERUYpxeFMpxzZhlehlcwyG1CS3qWUY/LJ1n3NDYs/SGERg3OpLDCG9R/WgaNwxIgWo1V1agHmQT/z/TSq60nbYv5fxN9GWMYbFxboBD93wR90/wQ9krq/JvFRCj0KJnKH43Y4BDS+zccO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199024)(1800799009)(186009)(2906002)(53546011)(6506007)(6486002)(38100700002)(558084003)(5660300002)(38070700005)(31696002)(86362001)(31686004)(8676002)(8936002)(2616005)(4326008)(6512007)(316002)(66476007)(64756008)(54906003)(66446008)(66556008)(76116006)(66946007)(91956017)(110136005)(478600001)(122000001)(71200400001)(36756003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0ZtT3drbklrNG9RU0NLbnRCTzJWeGY0dk5Vc3UydGpEOTMvUVc1ZG1uOCtT?=
 =?utf-8?B?bW1iVUx5U1VlYk9CekUwMGtnTllYR0ptdndsaG5ORk5PVXJyZ3AzczNKY2lu?=
 =?utf-8?B?L0VHWEJYbWZjYzg2S0hveE93U3VRZG9JVGZpOHB0UWVVYkh2bEllblIvNE9H?=
 =?utf-8?B?V1J6bEE3MytVVVI5SGZYczB3LzR6ZEloc3BRck5VUVQ1eEYxQlA2a3hTSit3?=
 =?utf-8?B?MTZqUWcvSkF0YjVyV0Exb2pheE42U3QvajJZRWdUSUNRZ0VvblNlWml3S3c5?=
 =?utf-8?B?R2dDY0sybDBoUlRxVGhYN2tjQmR1d1lPQ05rVWRFencySVB4d0E0ZDVjZDhI?=
 =?utf-8?B?eU83R2sxYVdRUXBQUmxHcGNLWUVBRWIvOThOMEVWWkVVT0Fxazk4ZnhDam1s?=
 =?utf-8?B?bTFrQUl2M3RaUVIrMklUL3ZuYUF0RHpNYUJXMDdxMUpQd2lDd1JPRVQwOGdO?=
 =?utf-8?B?anhxa25MQittK29YeGdhbTYrK2FsZzluY2p4d0RSWktab2dWT3FyTlM3L1VN?=
 =?utf-8?B?U2EyZ3NONkZ0cFE2ckhCT0JqdkRzeFh6MkdDbVZjNGhuL0t3a25aQ0UydTkr?=
 =?utf-8?B?WGJVYXpTaVdCclNPS2NUWHhlTndwazR1T0VpbWh2djFCci9wc0ZQdGs0Zkd1?=
 =?utf-8?B?NGVHMXBUMHU0bUtCeTNhRUJid3RrUmFVNWl4VXlIbEpoTFJxajdwaGVLR0lo?=
 =?utf-8?B?Qm1wZDNsVnFNakg1UUJiWDZnbzBUNUpuOG8wY1lHTElGbC8rcFhya3U4KzBL?=
 =?utf-8?B?aHhZenMyTVp1YmRHOWRydWJuODFWKytUYUoxNUtVdXV3NHpFMzk3UW9uclpK?=
 =?utf-8?B?OVo3dXltcmhPdU0vRnM2Z3A1eHk5aWo3R3g3dmRUZWZDcTlqd3d0TlVDVkVo?=
 =?utf-8?B?WWFxdXUvcFNNUUlvSFdySHNnNGxNbWduYnNGUGpYbkFyREhEM3o0b1RuTklU?=
 =?utf-8?B?MFVPQ0dZN1dsTFVENGFKZFFsUVc4WVJNTGxtN0hTOU9RNmFPcDk0M2Y5Ri92?=
 =?utf-8?B?cXkrUStueDArSDN5WHF5OUc1RXVkeFQvU3VYMUZ6TXdERjMrVHAxSThCSFdC?=
 =?utf-8?B?eGUyQkNsbWh5SWdvS3g1L1Z6Z1FaWkRnc3FlQ0dxQzhhWmhmUUF5U2tvTHI2?=
 =?utf-8?B?NVRuOUNkbGFpc0tlaDE1TFIvS0JSK2R3V1ZVV2VMMkdFaisxOWJzN3BIQ3Rh?=
 =?utf-8?B?cVpySTRMUngxVHhHQlVBdFBuWGFHOHpqcFFLU3o5cnlzK1FOUUQ5TXFpdXk4?=
 =?utf-8?B?eC8rNzlRVVRFYWxVMngzYkRuOXpYUVVnZjRrM2Q1WDdqK1dKSXBXUzBRdTBt?=
 =?utf-8?B?NTZ1L3JXMDd4ZnhpNEpuZ08xbGVvU1R6dmw3YitDT0h6UDQ4U2sxby9qOTJS?=
 =?utf-8?B?T0Jvcmllbk5WbVoxZlZvTFN1TDkwd0ZCVzluRy9hWklXNDBDajlqcWhOdURr?=
 =?utf-8?B?eXNQRFVWQ3BlQ0FUR2xXbVlycUlEV3RSNXh6WHpGeFBQaVYzVkQySk1WelJH?=
 =?utf-8?B?VFNGQytiYXJhTFVSZ2ttZHpVdHhDMHJMRzk0UW4xZUEzajZPV1p6b2FMZi9B?=
 =?utf-8?B?M3RjUTVaS2t5dTVMNWNoRXBqZlFjTDk5QVhLZ3R6TmdQVVZFNXR1amRQMnlI?=
 =?utf-8?B?SHQ0SnhXVkxVUUp5TXlrVDZOdGw3RTQ3QTA5b2FuWHY0eGtYOGtjZ1BXYmN3?=
 =?utf-8?B?R0x2OFA4QVJLTXErbVZoZ05RbVVDem4vMnpTUktQajFaNXl4eWhUYW1kcjRo?=
 =?utf-8?B?cFh6djBLZTVZcTFvSXgrUy84MFI2dGpVbmdBbGJYWXpOaGt6ZnMxQXlIdlFS?=
 =?utf-8?B?V1gxc3k3elRhd3JSTWpjZkpuc2FvM2ZmRXgwcGZSL2FUVmdURWtMVm0zNEY5?=
 =?utf-8?B?UytjL1kzY2dMVzIyb1VPOGtmNkZDWmlCUUJzbkZocTBKUGFyMnhOeGlWNCt2?=
 =?utf-8?B?VUt2eCtuUDFnd0x2NTdSSy9wUm5LNzYrcG81dThaN3U0OG83dHp4TG9YOGIw?=
 =?utf-8?B?NTlkTysrcWc1cHpxUFptRVlvL0F0NGVMSHZVTnJndjBxMXBiSGk3OXVhSDBH?=
 =?utf-8?B?MnR5TFVranFkYW1iOWpNN0hlZEU3dVpFUm9FVFFZODA1VWs5ZnlzUTZ0NFJN?=
 =?utf-8?B?NnZObnU5aDFEME0vaVFpUWpuZFU5VTYzSnZydjRaZ3VuZ0RBQUpPeXdLemgv?=
 =?utf-8?Q?p/m80c5uiiXZC4PntLNyZB2/Z+Ti2SW7byFssVrhUKkb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F78614EB1E05E43A089EA6EABDABCB3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64ab9dc-b2f1-4868-e84f-08dba41033c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 19:36:09.7810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iWH7TqSfDckkuxLf5UbrW7o62vwEpgEQ+hFMSqQ2yxgxiTEHn0cX0Xoq2bOAv3FFI1Cddz4TkvJc9FPlvDXIJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230823_123620_189415_AE8982C3 
X-CRM114-Status: UNSURE (   9.11  )
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

T24gOC8yMy8yMDIzIDM6NDggQU0sIEphbiBLYXJhIHdyb3RlOg0KPiBDb252ZXJ0IG52bWV0IHRv
IHVzZSBiZGV2X29wZW5fYnlfcGF0aCgpIGFuZCBwYXNzIHRoZSBoYW5kbGUgYXJvdW5kLg0KPiAN
Cj4gQ0M6IGxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBBY2tlZC1ieTogQ2hyaXN0
b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQo+IFNpZ25lZC1vZmYtYnk6IEphbiBLYXJhIDxqYWNr
QHN1c2UuY3o+DQo+IC0tLQ0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hA
bnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

