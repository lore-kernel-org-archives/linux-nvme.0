Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24B6C77B7D
	for <linux-nvme@archiver.kernel.org>; Sat, 13 May 2023 10:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I7YWdpak7uiprY/TY31UN43FGrD/VKP2QvlLe0R0D4I=; b=mW1E9dsLl0a7pGILvPoRMyuznv
	TZCoGb6hCcAoJoUIcxWFfpEefwgyW2+SekPfz++lderZvNjkZUmdtSywSHdC7GXrJy+qqT6VChFGJ
	Ne9QVuRURrRw9AB9R9cwrV7wsSM6Lhiw2zWpIuw0DJ09ZRoIMm0GFcH1PGjvw1eYAmPOpJvNTiJnS
	lZdTWUfH1R5XBEczr7FtFo+gx9YRoWttY4b12NNlooAFZQEMwhT3XZIxdwAt56awWmeT34EHdfVOB
	X+0n8ddMuVjnWw0wTjklaVyeFFavjFGODt1QgfjzAJuUpI+S6ZnKLeT4gYgQxP58drcy5dmJpV9LA
	S/ViCZiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pxmFz-00EFfN-0H;
	Sat, 13 May 2023 10:13:43 +0000
Received: from mail-co1nam11on2061c.outbound.protection.outlook.com ([2a01:111:f400:7eab::61c] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pxmFv-00EFeA-2U
	for linux-nvme@lists.infradead.org;
	Sat, 13 May 2023 10:13:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Knx3spbaO21dp6JGgDoOX1OBQLuK4qIAjq2+ZJVOrU/vU2E2C0V1iWeP/kwti4TqqE5m+Yib9KbuP7oiS+kmHejKXmceU1SvdMpGRrmWu8DfBvoW3CG2z43C/9jXOJYkvPrI1lazq/EncrrEjVbqEh/QIO2GkKLTEcMRVLS2L5ptoDRzXoe6GiP195pHepOGHKR8d2xqldi1n7Bb/x5aw7rRhn5/QkRflrqGNij2E5cxZIeySbMxJJgn8mF1gDmZ27VBre0qq+jIE4kL5oVU0XjdjjQs20Rj5ioxrC2eJhawI9z7Z/ULpXkFeGdTJZz8BmKmfmwWEiOo2XY64TLgXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7YWdpak7uiprY/TY31UN43FGrD/VKP2QvlLe0R0D4I=;
 b=nsZ3k5gRRlXxKee/6BTcIwBqFszzwiODtjD6Nvx2IHo+WVgEioQKltSURdevrgX6j5IpMbunezZyIy/P/Fkg/IlUHY5lN86bjwuK7Lt17gfUqIMdBusr73WoUwwy4PyZQEMmnZ9JdbCy/k3a4urJWsqR7vLMqXqqO7uUFsEgL0SQ5fu+YEqwU7wAad+LnZZszb3qmr1GOaspern1KgVGzkINpNTqBOtURwt/U04oj2AhpNj5pdPCLSdjIAofgfY7szZkwAtKPH3dvKs4c39gGqksMaSn3Gl3oB64YFQ/01UAXtIsB8JjfWpaz8uDFUNoL8N7luArglEDsaZiZOfrRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7YWdpak7uiprY/TY31UN43FGrD/VKP2QvlLe0R0D4I=;
 b=Edcl3wM8+WdpUKQ0XYc6okIVhoet1E6GBkgFebivL9p1zFQwX4tE5d4+yyUktc0KoA9D4O857Yej00C8fQA9GeASP66UNrivSb0iZ/jGrjzACSnh3RL+WahaVrNzCdSL52GYWrcs1pb3zqjAeEVmb2yfW3ucQxBcg+dmQUSxVyEFO+JLvGPnWYXYEECgDBvp0NWJgdhu7sNf3B6It85uHCE55q14rfz3x+/BWTOyZr4ysgVYFZZ7+Ft+G0eNsZoY1mVMbSXwD9V78BwK/licjuQIplGWsr12JtlbAgd8TgbRlmKDdjD9GqvkiPgoqd1hQPM1YQLIwWJkEEKx3e66WQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Sat, 13 May
 2023 10:13:34 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6387.021; Sat, 13 May 2023
 10:13:33 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
CC: "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH V5 0/1] nvme: allow passthru cmd error logging
Thread-Topic: [PATCH V5 0/1] nvme: allow passthru cmd error logging
Thread-Index:  AQHZaynj0FvmtPMRR0m2hZrgt4zZb68lPEoAgABY3gCABc28gIAhAIqAgAAgiICAC6zaAA==
Date: Sat, 13 May 2023 10:13:33 +0000
Message-ID: <ec94b0a3-d95b-f4b3-3114-54c53f2ed7a3@nvidia.com>
References: <20230409212538.18647-1-kch@nvidia.com>
 <0c50fbf6-4bc3-7289-2a39-072191c81dbe@oracle.com>
 <8a811508-f53c-bae5-fe32-da65101bdec2@nvidia.com>
 <551a5499-c4eb-0416-0d2f-9951817346ce@oracle.com>
 <c9ed84c9-58fd-37d1-138c-869726ccc7d6@oracle.com>
 <6835206b-e28c-8ad8-b468-32b7d7208535@nvidia.com>
In-Reply-To: <6835206b-e28c-8ad8-b468-32b7d7208535@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB7747:EE_
x-ms-office365-filtering-correlation-id: 586bce04-ddac-4882-41fe-08db539ab54a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Kjs18kkQ0yF2yJ+rPlRwfDre8f60XALIMwySvS3MuqodSEZGO//9P0lJIaKd9smMKuVLMNSwtfYOsBAh5GXKkrIl5CjEgiqREd3Wsq9Lr0qZ11EbF2PXx7GpYoiqCVwU8EHTaZtwIJkoZpEqTCC7c27GxnVHKW5bbQWQ24AL2YjUzVsk/20O/w9/1ulk2x06V1xbEQeDnTlsxMGpJzcFSjjRGhiYmtH8R+1Uzw+lIiPEhmjDYtiYVqjk9tyhYVLOkXZ+doP0j2XmNRMRlXzRzOcOhjHQZ9K975yFj4uGuPJSYT8QTSXd7tjWYa9U0uCqr6zwCd0jmOCv2FAHPK/y7akE51U/4rSC+LpJAfdRbSMjRvqtKvh+FhnTYgSwrA8vFj+Sd2EKuk7y+Q7VXyGBAJwZ1hYSvcSnNNnf/Uy5jGQ/qTcXtRx4ksPz1Fa+sn6RyzFwdJ+ZAr+zmlyTJXiq7sEg84hpQveSNhfm8ShflP7mNid0DyAa65Xh413mt+QDgIy3RSlq0rvSDowLdtQ9tVZm5gN2yqnfsuupW6MWzinF7p2mNCpMnCRVPszm1qGqmedkFrI2VErlFE2PG4sfhHG8TeoLPI95D6HM2iJoDYV/4+sPZJWPNP2caQnqHN6oI5qizkkABp1B/aS7xshZeFuL1IwPDbEPatOxwDSYRkw=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(31686004)(2616005)(38070700005)(38100700002)(122000001)(41300700001)(4326008)(36756003)(8676002)(316002)(8936002)(64756008)(66946007)(6512007)(66556008)(66446008)(91956017)(76116006)(31696002)(54906003)(66476007)(186003)(478600001)(6506007)(86362001)(2906002)(5660300002)(4744005)(6486002)(71200400001)(110136005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?aElKM0NCc0loQnZYN2pIZDlSOHBUUEtFdXJobHlMbkh6SjA1WS9WbzBDQXps?=
 =?utf-8?B?VHIyTFhndHg0MC9nNTZ2MkhUbjNnbEliWnZUWjZNejhwWmEva3ZBZWRHWnli?=
 =?utf-8?B?enl6bnJCSDh0cVRySUozV3FWYm1qTjgydjBWeTZBNXRYM2p4UUsxeEk3aW5J?=
 =?utf-8?B?SjhtdUk0ZXc0L01NTmtNN0p0eTJ0QUVXejI2bmVhVWlRVGxxMWZwcWJGOGgz?=
 =?utf-8?B?MzQ1M0g5NUZzTm9xVk0zNmtLelJWUjFoS3lrSVIrYlZKeWdCQlJ3Y2Q0Ymlt?=
 =?utf-8?B?c3ZCM1ZrREtFOHN4UGVKTE5sWURFdE1HSm5tR3FoL2RlRXUwMnp6SlppbmQ5?=
 =?utf-8?B?ZWtoWUdaSVJWbVNYZkl3NDJrWDc4bTJyTjJYeVk1NU5ISFFzWDlIdFNJdlMx?=
 =?utf-8?B?WVVPVnRUUzNrS2Z2N3FzeG1tWnJaY0d1dmltMFRMUXpDaTdTTEk3TjREOThh?=
 =?utf-8?B?SXZPRmNNNHEwQkxWcEh4Q3gvYjdtRTRGbXFoV1Z2VVJGOVRzRUhCV2g3aEJY?=
 =?utf-8?B?K2ppdGRSNmNIUnY5Wm1GckFQblhXN1NsTFZGUGs2K3dtTFF6eldaaWtYNGdm?=
 =?utf-8?B?amlGNlVaQ01hR0s3MngvaFZkNEtTNlBkM0VZQXhQVEVkcUxjQlNGajhIejIr?=
 =?utf-8?B?ZGhzSlJod3k2Z3hkS2NGSWh4d1NRalNuNDhVNDBjRkc3VnVnQXFwcWRoOTE4?=
 =?utf-8?B?RTJOODNwSlNhd0ZVNUtwQVZReWVNNjJrWUtNUWNONFluV0VaUDhVNWdNRFl5?=
 =?utf-8?B?YXhTYWptYnFjTk9QN1Q5NWRsRER2bE1LUGpCbHZjUUdDVEtUa04zdkRhclIw?=
 =?utf-8?B?S0l4bnl5RjJUdUNtNGFPOUREMlFYOEJHV1h1bHFkaDNuM3Q4aHJiUlBQTSts?=
 =?utf-8?B?YTVQYSs0NGR3S01jU0hkdDJQK1Fpb3N1U1Y3bis4SFcwZ0VpbGNZd0dOaFN4?=
 =?utf-8?B?Wk5qbXFsQ3B3K3BBZ0plSTlTdnkzQXRVaFNGcUkvWVdxbDl0UXJXS1YwdnRC?=
 =?utf-8?B?OU53SWpNeHdDdk5BTnRIMm5pdUNweDNKOG5tODkxT1hUeWN2bGtCMC9TOWxF?=
 =?utf-8?B?dVhWMkdRTkNiS01DNFU2M2FFMVRSVTgwZ1ZDS3VRZk12QnM4ZlAwWC9hM2NG?=
 =?utf-8?B?QlZvYXlBeHBIV2dJTFZ1azBFY1BZR2ZmNUF5djBkSUpvVVl4ZUtZdDhYcTZj?=
 =?utf-8?B?SHRZSkZ0ZTBkYUUxdXI1UWgzS3JVWTBkNVJLczM0ejlTSXZyZ2N4UzBFbEJX?=
 =?utf-8?B?dlM4OW9GaitDMVlJeTVxOVZLU1FBeUxzeEQ0dXA0VlVSeEVVMGtyNkpva3lY?=
 =?utf-8?B?cGE4bnlCSG5XQzg1MDB2eDBYQlhzZFlKYy9leUkwRFpidTVDeHIxa2ROVGI5?=
 =?utf-8?B?QUIvUHVOZmxrRnp5YWNRa0VhUk53N1l5cEtZeWJaQjYyRXVGRVRieGt1YmhD?=
 =?utf-8?B?d05PbVBBbmthUHRGdGlWT1RHUnNOdC9LRFd4Y3ZjWWRKOVo1WHNJSElGcWZt?=
 =?utf-8?B?TGNMZ05zL2IzR1QyY0NSNHBQSy92WlNiSW5LdjR3cWtFVVg2RjltKzBrSU1r?=
 =?utf-8?B?UTd2ZUNOYlJ6VkNXSWRNN0t5RWptNStHaXcxWUV6T2VLbCtnK3FKTmxJa0FN?=
 =?utf-8?B?clovb3pJZ1dUWDFuNnhtQm1xMTZnMmFqUXBGYlRnakZxSENRU3JrWXQyUGpR?=
 =?utf-8?B?WGV4SFlyNyt3Y0hYNCtPeTdHWms0M2VqNGpKYXY3b2NKNm5yTVJYZmczampD?=
 =?utf-8?B?bzJGZ0VMMFNrMmhpTFhublZBVUFjUk13aUFUT3czcGlLckUzQVdCV2c0ZnEv?=
 =?utf-8?B?SzhhSlJiMC9Fem1HY3ZyNkZ6VzRmS2l6QnBlQy9PZ002Z0ZKbStDWmNGZDgw?=
 =?utf-8?B?WnFsQ0RFSVErYW40Ums2Y0xNUXVvTEdMblhmbXZURkxQblpEZmwzckkrTmhY?=
 =?utf-8?B?SW1TR1p2MnlWa3FTMWx0UktDVWJGb0lGdGh4R1ZxVW9KRVZzSWZPVWhkYWY4?=
 =?utf-8?B?OVBEaDFMbFROSWhwVVQrYkZoa3BUUFp3cG16dVpxMUd2Q3lnVzdwZ2ZtMVBr?=
 =?utf-8?B?bEExdU9wOEhhQkpSMWRMVzRNMTJobWVCV0hKa3hJbkhEN3VsbEtoQ09CMGV2?=
 =?utf-8?B?RnBnRW1zYlE3TW9qZ3dWVDd0VWJrc08xaTVTUWFVVXh2VHlHVmh4UnhxUG1E?=
 =?utf-8?Q?5wejLr8wKnJ12pZ/eEF9WRFLMkFULMF5jOjOzMOHsxQ+?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68395A4639F9AB40B4BB0BF4B68D6404@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586bce04-ddac-4882-41fe-08db539ab54a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2023 10:13:33.4286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWx67a4+UPauOGTXAJqjCcqheC3aLAJkj/bRb2sIiCUsDUZAbj0VnhXSMAKYiBhm2RCmkaDnIJCT1x9ni6RZIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230513_031339_817457_0B73EB4C 
X-CRM114-Status: GOOD (  13.43  )
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

T24gNS81LzIzIDE2OjU2LCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+IE9uIDUvNS8yMyAx
NDo1OSwgYWxhbi5hZGFtc29uQG9yYWNsZS5jb20gd3JvdGU6DQo+Pj4+Pj4gSW4gbnZtZV9lbmRf
cmVxKClfIHdlIG9ubHkgbG9nIGVycm9ycyB3aGljaCBhcmUgZm9yIG5vbi1wYXNzdGhydQ0KPj4+
Pj4+IGNvbW1hbmRzLiBBZGQgYSBoZWxwZXIgZnVuY3Rpb24gbnZtZV9sb2dfZXJyX3Bhc3N0aHJ1
KCkgd2hpY2gNCj4+Pj4+PiBhbGxvd3MgdXMNCj4+Pj4+PiB0byBsb2cgZXJyb3IgZm9yIHBhc3N0
aHJ1IGNvbW1hbmRzIGJ5IGRlY29kaW5nIGNkdzEwLWNkdzE1IHZhbHVlcyBvZg0KPj4+Pj4+IG52
bWUgY29tbWFuZC4NCj4+Pj4+IENLLA0KPj4+Pj4NCj4+Pj4+IFRoYW5rcyBmb3IgZG9pbmcgdGhp
cy4gTG9va3MgZ29vZC7CoCBJJ3ZlIHRlc3RlZCBpdCBpbiBteSBlbnZpcm9ubWVudC4NCj4+Pj4+
DQo+Pj4+PiBBbGFuDQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4gVGhhbmtzIGZvciBoYXZpbmcgYSBsb29r
LCBsZXQncyB3YWl0IGZvciBvdGhlcnMgdG8gaGF2ZSBjb21tZW50cy4NCj4+Pj4NCj4+Pj4gLWNr
DQo+Pj4gSSdsbCBiZSBvbiB2YWNhdGlvbiBuZXh0IHdlZWsgc28gd2Ugd2lsbCBtb3ZlIGZvcndh
cmQgd2l0aCB0aGUgcGF0Y2gNCj4+PiB3aGVuIEkgZ2V0IGJhY2sgb24gNC8yNC4NCj4+IEknbSBi
YWNrIGZyb20gdmFjYXRpb24uwqAgV2UgY2FuIGNvbnRpbnVlIHdpdGggdGhlIHJldmlldy4NCj4+
DQo+Pg0KPj4gVGhhbmtzLA0KPj4NCj4+IEFsYW4NCj4+DQo+IHNpbmNlIHlvdSd2ZSB0ZXN0ZWQg
VjUgaW4geW91ciBlbnZpcm9ubWVudCwgSSB0aGluayB3ZSBjYW4gcGljayB0aGlzIHVwDQo+IGJl
Zm9yZQ0KPiBuZXh0IFBSIGlmIHRoZXJlIGlzIG5vIG1ham9yIG9iamVjdGlvbiAuLi4NCj4NCj4g
LWNrDQo+DQo+DQoNCktlaXRoL0NocmlzdG9waC9TYWdpLA0KDQpBbnkgb2JqZWN0aW9uIG9uIHRo
aXMgdmVyc2lvbiA/DQoNCi1jaw0KDQoNCg==

