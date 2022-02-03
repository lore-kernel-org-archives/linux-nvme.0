Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B28C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Feb 2022 12:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=25xgpWpmyLjonTE/KfPS7nd44fabPfow7Sx5wadjaz4=; b=rLng84wKHzBepaAv4Y1cnKrKIO
	EMygrM45rd+Mzf5ytaqBsAJ6YQvf0ealv6voo/U9c+dY0/4EvSpn9tEWG3a2uqJICrDOOHGzOraLL
	AUHaHW9sd3rXjr9Duk8J37kiGEucRA5PLAIppEYCXFTUCaMfGSiBaiG3C9HYnf3SHHxcFOZMk/bSg
	HGI/lk9YPAlimehWpROcXhUgzBqWOUJQ/ZakfcLsXj6UK8pg0qWYYt7t9FuRFX0jvYoQeitLxEN1A
	I/Zi434XpoZruEjopRStzw90Y9TV+HOinKTAhasE2El+YIY/PNgTfus7ou5adnA7Q1OPPcrlT4xq8
	FKCStnCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFbV7-001Keh-Er; Thu, 03 Feb 2022 12:46:13 +0000
Received: from mail-co1nam11on2079.outbound.protection.outlook.com
 ([40.107.220.79] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFbV1-001Kdr-DT
 for linux-nvme@lists.infradead.org; Thu, 03 Feb 2022 12:46:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhCA22klibGaa0iwmvFvJOi68PStXLVRCTYosZKCmGK0eb7/rbnWJvOj/uWp1l1dsxBYNmGmr2mXYjkTuz7fqqbHUxk/Al73ChqCpcTwUe8osm4EVZpGVyZ261TmOvL3Sdki9NUe3dX8wa7IUpiyOSaps2ryH1VTBbZJf6E0056XuyQxKvh/Czu8wUGp+uk/tZwF/8kHcIilLOM9TY9fbTMcR+w4wMthVXsfjRADX7yQe6p3Nsw0CbP8pCkfCm/5uOlDVcHRVIOiX6rzxwNpPp0EQ5PSoX0nsVbb8PV3ErfrapfHSBzDgKe+vmhFu7UY/skYq/C3dseQsniIhN4kiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25xgpWpmyLjonTE/KfPS7nd44fabPfow7Sx5wadjaz4=;
 b=W08PDIlmay9ptOtuscJfzBOI1SFw4O81a3zJwoOQZ9pr8K7Hl4eCX25sUaqFpFpEKuKn/b9n7N/q1D71Wkv1r+zK/4l/m9psbRuA6fFEJEpM9Df+NuahomzK27Nmczd184kEAg4q89C3wN/oaq3taephwZ2ss1CSU+9dFbsWqlAAdXWxi3QAxntlDHseTk9pd2qLQ9BEIfH+WT23lLfMRp4CrvUqB5gb8W2AbNKi9ydpooOUdVSrpsWWWLzWh84/8XSOeJ+eRaBJjddxgn5lB12yCsWjr3/IWHIhcxglWyrUkmdyN3W7c2o+FmqBsiOfxStuU6Ja+vZKC7wDBeDITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25xgpWpmyLjonTE/KfPS7nd44fabPfow7Sx5wadjaz4=;
 b=ooeyxPKp6utRx2iSEtKg3O/lxu4kMZC02fawr3tnymCMKjJgQChnxVm8XRN0kiTYwF284+kNktOcPVZIrKOxX5jgeWNJeKIa7XhsN+hynPCK7i9iRCy/BnvZRlS6Y59GUrHP0SkrLm7JgoXgjOOd4qxsMQvwHLhTetiWHhH115dLxk58jxjLCH1VikZIxMyZgDkL2ehymCLT6E9gqWvJTOsm9uKZ1oGeQpKz/Xa0MHpH/AOcbq+FCv2VO4eTh5pgLxtYNKB9Xo52K25RNXYFnu66gi6c/P/AlIi8pNEssznhmVj4NzElq4RpGSrfKxM5Se0YPTRN7PC0lSYH4//oTQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by SN1PR12MB2589.namprd12.prod.outlook.com (2603:10b6:802:2c::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Thu, 3 Feb
 2022 12:46:04 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::846c:d3cd:5a30:c35%5]) with mapi id 15.20.4951.014; Thu, 3 Feb 2022
 12:46:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Martin Belanger <nitram_67@hotmail.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hare@suse.de" <hare@suse.de>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
 <sagi@grimberg.me>, "stuart_hayes@dell.com" <stuart_hayes@dell.com>,
 "charles_rose@dell.com" <charles_rose@dell.com>, Martin Belanger
 <martin.belanger@dell.com>
Subject: Re: [PATCH 1/2] nvme: send uevent on connection up
Thread-Topic: [PATCH 1/2] nvme: send uevent on connection up
Thread-Index: AQHYGH0p0HUmmKZ3IUOovrhognpEfayBxweA
Date: Thu, 3 Feb 2022 12:46:03 +0000
Message-ID: <74b10770-df76-d880-ef52-2989fadc495c@nvidia.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
 <BL0PR13MB42913A07097FA13CD1B0B1089C279@BL0PR13MB4291.namprd13.prod.outlook.com>
In-Reply-To: <BL0PR13MB42913A07097FA13CD1B0B1089C279@BL0PR13MB4291.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 08a1f5e3-4891-43f8-5b16-08d9e71323c6
x-ms-traffictypediagnostic: SN1PR12MB2589:EE_
x-microsoft-antispam-prvs: <SN1PR12MB258903747F62FCA1CD2A644BA3289@SN1PR12MB2589.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xuwvwfjDsUuhF9yogTYDZ+cFwXysu62xEpmwWyAgVskONCFUomoBGy13mAqQ0TJ8wEKyezoIgwO+x5igauRoYfZgfWM/Q3Q9epghebJ5svig325U5EgYNGGpDOYJFydqNLuj7gwj2WyZIv8h2XX5r4ntsSGXPz0gQg95nYC72p98TFXIpxSd+PpKDByziZrbgR+fdP3iLkq8T0TU8EpmiFMtdDEsZV5+iBP6U824lmT2CSx8Kc3iposQ2+x6Oa3W+PW55GjszfDhscvAc6E6Fa0+yFc2QJdDefY8acDUzS6KUDvq5aI1Dvzug6maeSsv7sLhR/tjAtgRAxjoaQNn0XrbpBqykJFVd8z+jANao5mV5hkvlfkRiMaE/naxqoGeMsfU/UBSerBPWCoJy1YVvj7m1UeGoag5ctc81FTik1h+fhfuQxjw5FnFGRgFY0cP52GNTMC11HXNIlLmhg4KAxKrN/mUfyrgXB2fCsG0/HY39mhD8713+h9gTPcTU6V9rZWLQQmLUBnWf4Fpp+8lrCIAAvJ/3xYPIZCpJXu35hflRM1RzvbFL+G4ZUDCIgJeHGHGbxwOOgHoPeLfxSIeySak0o5hZgtVFBEl2bnJu5ovvvR3GFIF72CAQomqoXevLYQoavu5WpO+CX3rWByh7z6kf1J4DnFQ/adStAMr7zY0qiduBncojcakbF0eQjEL9g1qy8caQCXuB5wfO+13JZU/sxo2/dJwHqE7Dh6XVGlTBSWGSH80NJzQtwhuZ1xYJ9frWCOy5zz3XcMd77BPSg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(38070700005)(122000001)(6486002)(508600001)(66476007)(6512007)(86362001)(6506007)(83380400001)(76116006)(71200400001)(53546011)(91956017)(66946007)(38100700002)(4326008)(36756003)(7416002)(54906003)(8676002)(5660300002)(8936002)(64756008)(2906002)(186003)(31686004)(316002)(66556008)(2616005)(110136005)(4744005)(66446008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TENPbi9NN2NiYUpFVkk3NW56RU1oa3NrWHU5Q21mN0liUEExNWdIdW5FR2VJ?=
 =?utf-8?B?bWdaL0VhWk1wQ3REVXpTcWM2YnFmbmxYYWpDcm5tZGk2RkpFb3BTRUdtK0ht?=
 =?utf-8?B?cHlSVDU3dmpOOWtmR1NFNWNrbGYvajNXTExiV0ZFZDV5VmkyZjRxU1paM3R0?=
 =?utf-8?B?TWg5OXZ6R2FrL0cvK05qZnJ2N204aWhYVzZyMzRkWjBJd1NvRVdIbVU2ZmNk?=
 =?utf-8?B?RTJSb21hSkh5TncxNC9pcDhVMHVWZUF6SjFUbWpKb3l3Y05QS21NNjcrQ01x?=
 =?utf-8?B?YXZGVWVrWkc2QW00WDBIU0l5dmx0TW9qbWhpYllGU0x4RGFxeExEMHFjU1pZ?=
 =?utf-8?B?MDQyU1UvRjZwV0pTUDZGM0JqMWJkMThKTnhDQUhrMW4wNHVCRFFXYlllMU10?=
 =?utf-8?B?WElEY21ZZU5pOHV0OHozQnJ5ckRFemE0QzZMc00wYU9KZHBZV1dBN1phV3ht?=
 =?utf-8?B?RllFWlNhTGtmK3NObXQwR0tVR0owZEZvMzRJK1VnenByaFd0SUduN1pjSUx1?=
 =?utf-8?B?QVFPTnlkSklMRkNzT2FWYXRwbEExS1FwZUViUUE0ZkFkV1NKaTRPc1BLdnNt?=
 =?utf-8?B?KzMramlwYzNZcnBPb1lRVVc5T2dnQUR6MlVvUVAwakNuditBN1ZSU3RRdlZp?=
 =?utf-8?B?OE15WG9rOVh6dm5lek83dFA2YjQyWVRZTHAyODZQdThGVS9DWHhuY2JISngr?=
 =?utf-8?B?QjdIajVNZDBEQWhvVjdwdmViZ2JqTWc3VXpoVjIzZzhnQmk0Y0hZdVFKNzJl?=
 =?utf-8?B?R0VGOHp2NiszRmh2b1AzZ1dVazd3STRlZmp2blZ1S3FOQkVPN0ZDNGlGK1NV?=
 =?utf-8?B?ZlVSMTRMMGlYMTJ1SjZTMDcvWTdxYy9nMXpxRTJhZjVCMkgvRmVUL0NzM3Ni?=
 =?utf-8?B?L2IwVkl1dENOWGZCMlQrWXk3a3IvVjZUNXZ4OXQyZGJBM3VVT2lZeG9YLzNQ?=
 =?utf-8?B?NWxwYkE4SHRqV1kzWkpscHNJbkdXYkdWcnROcVRuQ1kvWHhQMUcxckliaUl5?=
 =?utf-8?B?TFZjSWdMNXBPVFYrYTF3Q2JtZm04Y0hZK2dVY29FK1Z6QkZFYXFLWjE0WHNu?=
 =?utf-8?B?aEFPNm1OcS9qRXNRSjczeWxmU2dMMVF1ZldHc0tnVjVvODNrZFRBSHBiUlVB?=
 =?utf-8?B?c05KeHIrZVJITWVUL3BxUjZRMWRzamZSWVJiWk9WSktPaGJXWmlpRHpwTzFj?=
 =?utf-8?B?UGNyTm5kVk9zL3lkanZqMGlUWVpFNXltV3BSSjV5akdEZi9BaDBCdkZUUGk3?=
 =?utf-8?B?SisxYmF1enpVK2Q5cUNpMnhtVmVIZnFwVEhBdWx1ZXB4cEhORmpDcmxlOUlN?=
 =?utf-8?B?b2JJMnBqNklkdXBFQjl5VWZ0YWJYYXdYNUZWd1JwazRLUEJZaGZBTVhEdk9G?=
 =?utf-8?B?NkcyQ2pIOE90Y0h5VG1nVVZmbUpvYlg4K1E0TnJpTFd5a1cyNkZ3WW9zeHNp?=
 =?utf-8?B?ZDRvNUEwWGkxK2VVZlZSKzlIQ2ZkYjd5aTIwVkZDNW1yQkF4eHh0YS9XdElj?=
 =?utf-8?B?azFSemtrWTR3NUgvaytYMFdHUVMvekhPYU42blVjQjZSQ24xY3lkMWpmMW03?=
 =?utf-8?B?VVMzNk1PSnMyRVBwc2xlUzVqUmtFbVVEVU5rSG5Jdmx6Z2xQb0xCQWkxNUdI?=
 =?utf-8?B?b0lFN25YWm1IK290NVNvRFIxbEg4Q1AwTVpkdWcxa25XcVpGaUMrNVdOd2Nx?=
 =?utf-8?B?Tmw3TGRKRitnQmNmRzdHd2JlcWpFbER2UTFzUnpESWtiUS9kNW9PaTVGRXJX?=
 =?utf-8?B?TjJqMzROL0FvVEsrNGNkdThmOGdNUkxTUkFLSnNQK3lsZHl5YTFMUnJqVzZr?=
 =?utf-8?B?QnBnRUk0YXZ4ZytEOEVZQUQ1QXliSkh6c1dRN2o2QS95RjVQZTZRVXJPVGx6?=
 =?utf-8?B?bkdhRHkvUEdzUHpIQ2FXRXdSaTRpSFJ1OE5FVXl2b1NiR29iSzdFNU1qQlYr?=
 =?utf-8?B?aFk4UmN4VHhZL0RRZG1JWGU0a0ZwaFRBbE90alNkOUlkajRJdUFPRmhVeTdU?=
 =?utf-8?B?clNiZGNpVVJYN0NUQUltYkw1WWc5RW5wRzhaWWFtaFV3Y3ZuNVZmUVd3dVFR?=
 =?utf-8?B?Y2dwMkZvU3E1S0VlZkhHOHh6a2dCUFBOV1RUMDJ4THJuNVlQNEVDR2Q2N1Uw?=
 =?utf-8?B?SmozcXEvK0hoUkcyNjVIS1VvY0YyS2xWREVSVGliV3ZjbDlwUitzRjJ4TzFy?=
 =?utf-8?B?aG1rdnl0Wkp0TzdjUkp1K0VkRW5CQlB1VWFTMVZTdnJZM2l6eXlqS3VBNU9D?=
 =?utf-8?B?cStXZ2VaRzJWV3ZoNzN6YXJTZGpBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43B42E15B844CD438AB2D1556E9128E1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a1f5e3-4891-43f8-5b16-08d9e71323c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2022 12:46:03.8982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mbp5ZjJZeOI53fBPCzwD7nUGvfHGCNs6/1AFJyRKvwBEl7/ZWpC5ZsvXNvgBLSMh0g5kKIMz55Y9G65Mw+JfuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2589
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220203_044607_479533_40C95087 
X-CRM114-Status: GOOD (  13.71  )
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

T24gMi8yLzIyIDEzOjM0LCBNYXJ0aW4gQmVsYW5nZXIgd3JvdGU6DQo+IEZyb206IE1hcnRpbiBC
ZWxhbmdlciA8bWFydGluLmJlbGFuZ2VyQGRlbGwuY29tPg0KPiANCj4gV2hlbiBjb25uZWN0aXZp
dHkgd2l0aCBhIGNvbnRyb2xsZXIgaXMgbG9zdCwgdGhlIGRyaXZlciB3aWxsIGtlZXAgdHJ5aW5n
DQo+IHRvIHJlY29ubmVjdCBvbmNlIGV2ZXJ5IDEwIHNlYy4gV2hlbiBjb25uZWN0aW9uIGlzIHJl
c3RvcmVkLCB1c2VyLXNwYWNlDQo+IGFwcHMgbmVlZCB0byBiZSBpbmZvcm1lZCBzbyB0aGF0IHRo
ZXkgY2FuIHRha2UgcHJvcGVyIGFjdGlvbi4gRm9yDQo+IGV4YW1wbGUsIFRQODAxMCBpbnRyb2R1
Y2VzIHRoZSBESU0gUERVLCB3aGljaCBpcyB1c2VkIHRvIHJlZ2lzdGVyIHdpdGgNCj4gYSBkaXNj
b3ZlcnkgY29udHJvbGxlciAoREMpLiBUaGUgRElNIFBEVSBpcyBzZW50IGZyb20gdXNlci1zcGFj
ZS4gIFRoZQ0KPiBESU0gUERVIG11c3QgYmUgc2VudCBldmVyeSB0aW1lIGEgY29ubmVjdGlvbiBp
cyBlc3RhYmxpc2hlZCB3aXRoIGEgREMuDQo+IFRoZXJlZm9yZSwgdGhlIGtlcm5lbCBtdXN0IHRl
bGwgdXNlci1zcGFjZSBhcHBzIHdoZW4gY29ubmVjdGlvbiBpcw0KPiByZXN0b3JlZCBzbyB0aGF0
IHJlZ2lzdHJhdGlvbiBjYW4gaGFwcGVuLg0KPiANCj4gVGhlIHVldmVudCBzZW50IGlzIGEgImNo
YW5nZSIgdWV2ZW50IHdpdGggZW52aXJvbm1lbnRhbCBkYXRhDQo+IHNldCB0bzogIk5WTUVfRVZF
TlQ9Y29ubmVjdGVkIi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBCZWxhbmdlciA8bWFy
dGluLmJlbGFuZ2VyQGRlbGwuY29tPg0KPiAtLS0NCg0KTG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQt
Ynk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCg0K

