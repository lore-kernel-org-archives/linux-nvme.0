Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A03C74A5B
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Mar 2023 23:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ix/eF/14wW4UWAkdkc9D71Som5oFNNisWjoXZhUdTRc=; b=mHEBCm6LkmaYXFTpTHKjdrNa1U
	HgUncC9F8sBE2iR5KkinICcy8mc96CW/9F586uYHqmmN6c+xbQh01+G02I/gvJlgBUIT0sUxzf+Wi
	asBgCDyLHZmhmnh0wfry0H6hsUSvP9mNIlN9q258lN1iDabodjC9hPY1t+wiKnA4C/lMsZG8x17ca
	irzNTr07p/S90P4i8UyrAF2YRqlFSMzaoVod1TdBGFfNU9Hrq8y4o2nnIxjxXi/9pWBGzT9U5T88x
	t6eEOEXgQzsOKCVJPJEzsyJJKbak93Km7A39e56cMDSrzqSOWMU78GXCCj0lVqFE7qRt4gI7EDj6N
	jWBoPrYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgZRw-009JRg-2K;
	Sun, 26 Mar 2023 23:06:56 +0000
Received: from mail-dm6nam11on20623.outbound.protection.outlook.com ([2a01:111:f400:7eaa::623] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgZRt-009JR1-1v
	for linux-nvme@lists.infradead.org;
	Sun, 26 Mar 2023 23:06:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIq2ch8z7tNf2BJ7Q08bU7inGWiO1tW31SUt0NL++64Hnsr4UbaHjDeZcSiFeC5TiRYa+OLkyL3i4eouAMHqkwUj690cqoLCvg319tttH/YtESf1FYnLQ1sDacfXJpBA58ncB7/iAvfwV8R762E+6UctTAFHeytpAyraGFHsEiH2/nT3/YlEVQ66FZUk5b1E0WiwWydBRl6e/cZIZTEtOw4o5op+bMuxcr7lQDk1iWwF70yE9r8QBbRdDITJ3X0DYmwI6dTkVgAgRR0TrwyIlsYBmy479Jwf9e9VVLAV2m4VDxGpWmzuuyDzLqrCQ+23IObuVNJ41FjO1bWSHW5dIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix/eF/14wW4UWAkdkc9D71Som5oFNNisWjoXZhUdTRc=;
 b=aYtWfCgBIU8AuBr6NUyZ12/h8op2AsbES9E39GF/WxtcfzdMwhQ2+T3ijC9waNjkybnaMjqDW0lcMfvDgDv3/fb1Ju/YA+TMFadWhuasBQYsOYXLmEfHN7mGHyks7CPzQ0jsALIUWWZUvmLNC9QaC2nJAB7gCVYyC/yI8q5qMR0zWs4JHNwUETNz3JlUWg2Kqnqegxylf7yfy85vYHy5FZzE9vu+iIy3KYbjbKViDnkZxV6unUlAvR0CYtOpMHfeqXskTBZ8hBUa9bO5S1hh0w/PGs+vFO0M4UQWMmXXzaKAQJxfxAVVMcGnfhLohVBZeBx3TqrTq0MAHNgFVr+kPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix/eF/14wW4UWAkdkc9D71Som5oFNNisWjoXZhUdTRc=;
 b=eETSxqqai/sj/PpTOG9YON4TGK+H6qNEv63VXokabMOpN4cWFbQKr+ZDxkV9flTVWGwL6VDxLo6gqubUHgSU44iNzQd8A2AtQ4PM5cNreAwK2UKlHGEpQhHnXR3gjF/+7n901P1kKJAi8m9Z2XldYKxdoLpiZbgtJavldOjj7W9mLGYjGEVTgZyjqFonpPUZYixAt0Srun29gFnEuzTxs7/H+W11hBB4JuZvNI1eorPI2HT3LNgWtdL8txbXEuXXBkQ42Io/7z8n/YRRuE3g7rlMEgcf0jj2NRBPqHFbRmcJ9+LxtYKbX82dAQhxirBRwEx9owD+xQ1yuYfPphYwZg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CH2PR12MB4165.namprd12.prod.outlook.com (2603:10b6:610:a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sun, 26 Mar
 2023 23:06:46 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::9f90:cf3d:d640:a90b%4]) with mapi id 15.20.6178.041; Sun, 26 Mar 2023
 23:06:45 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"hare@suse.de" <hare@suse.de>
Subject: Re: [PATCH 1/9] nvme-core: use uint type for shutdown timeout
Thread-Topic: [PATCH 1/9] nvme-core: use uint type for shutdown timeout
Thread-Index: AQHZXTjBXaqTKuNmt0amN2Iq/alJAa8H/26AgADxvICAAASbAIADt1+AgAEHr4A=
Date: Sun, 26 Mar 2023 23:06:45 +0000
Message-ID: <8a9ed8a9-baa7-dca3-5cc0-d733332d379a@nvidia.com>
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-2-kch@nvidia.com>
 <5639f28e-ec89-f2f8-5737-8209b36088e9@grimberg.me>
 <2745623e-2b0f-edf3-2cf1-7a8ca9415545@nvidia.com>
 <3584deb2-1bdd-4980-b2e7-a87067302118@nvidia.com>
 <aa985b18-5ee8-2af3-24a9-b04eaa756a0b@grimberg.me>
In-Reply-To: <aa985b18-5ee8-2af3-24a9-b04eaa756a0b@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|CH2PR12MB4165:EE_
x-ms-office365-filtering-correlation-id: d20496a6-0b8a-471b-7ad2-08db2e4ec582
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  wqFd8jdq2rgUavLAvYMAyPds7RK5dvx/jc9EF1+QLc7Gi/ihjCkM1ZpkVG0b+xY2ffY8KEA2l/3bpTLbvkNjUB9Pjk+Wk1jzmSbjj6tZinnw6fMFl5r2LzXg3R6MPe68vmsSlbrD/Z3281oFpbqNHbmLlAs4597RyihiudXajVzkfHcIgGa0G1UNmo2nrhm95/dWiQ0rSNAgkGeFpAQJR6OGzFf5LfyQHLivivSMcNX5QrYylByN5DnBbmtI68OtOJcYbNB0X6rSmtnOeYMK7cUM103LF+6+PC59Ar9/u0kKjTbVBU8IgyP6jn9qUIiCCRzBXKE49GIFqK41QtSis9lLUFMFJMFqmftvX7T3h75kF+ptO/RXHTWqjrDVMPfhyEfzs/JBfnXZlnZl3FiT42HlqREztOIVi1BwCxhKeKHecLnLp0ztVkAULsTlKkHF3mMGjK8Z0M/+dbhHV7vtK6eTfcB38nDBRziRxAJLOOdwSVsdElR7vN/fnQnGYxgVat2Q3lOsiBMintbr+tg8lDL7s4fr70mxdOAb/kIaamByraNPMMHAKjK3fB3xqe4joJ0aR6im3L0kFjGMuTJk4cAHoZZBWuF2F+n6T3rZwgxzoNr82fJItZgCWyL1ALzDqG+w3f8Z7Q9cgp9lJQgG9HShTAc+Y43v5mUy9IU3RyY=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(346002)(396003)(39860400002)(451199021)(2906002)(86362001)(31696002)(83380400001)(186003)(2616005)(122000001)(38100700002)(38070700005)(36756003)(53546011)(8936002)(5660300002)(4326008)(8676002)(64756008)(66446008)(66476007)(41300700001)(66946007)(76116006)(66556008)(6486002)(4744005)(6506007)(6512007)(316002)(110136005)(91956017)(71200400001)(478600001)(54906003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?VW9kN0o3SmdJZUpldkl1ZFJrVzc1RXhsdy9XbllrVlp1dGVmUWZKR0dPYmxw?=
 =?utf-8?B?WStmbFpuS2I5RjlQdlVCVmEwNDBLdys0R3VOWmVzOGx0aW9IUzRJclhCM3FW?=
 =?utf-8?B?NUpJQTFUeVptS3I1MFVLMDg5czFOMnE3TzNJb0YxbjJHZExCbFNDZFdqdmla?=
 =?utf-8?B?bjJhb2IzQ1oyd3lGVDhvRDlsS0lvUS8wVUl0TWkrNndlaExkYjVmbkFlMHpM?=
 =?utf-8?B?K2VvTUsrb3FqRW5sUHNWTlUxSU13WlUvTlUvQ1J3akNvalZkdjBmemtmZEtS?=
 =?utf-8?B?NU94WDlUOTEzZVlpb1BzdEJTSnFVVzF6Qk0zb01WS2JWMlhEMDUxUVA3TUly?=
 =?utf-8?B?cWVZRXBtaDU1SnJ2Tit5U3MvYzhMUjRLYy82dWQ5NFdaQ1EweUdTdTB1UlBJ?=
 =?utf-8?B?cTQ1SUVXN3dRSWFzZUtWSEw2cEhRVmQ0UUM4M3ZqcEU5NnZYSEN0Q2trbFBv?=
 =?utf-8?B?VUthcE15TFcrN2FTaWJOMHZoTFZXd1VLd3o2blhJVnBZOXRwWFBjRXVHZENP?=
 =?utf-8?B?VEhFRkZYbDZLUnhsWUJVU1pwbndzQTlodXRwN0ZiS0VLekNnY0tILzBRZEUz?=
 =?utf-8?B?dGpISnpHb0k3UUFGTmEvSExtZkFSYm1ndTJ5c1RyR3U0d1VxQ0c1Q2pFOFZC?=
 =?utf-8?B?bUtUY0hBSjNpTXhxdmVFSkdFbHhXRUQrOWZQRzdKZDR4dVN4azdaaDRKMTh0?=
 =?utf-8?B?K0s5QlVIVFZkd2x4dXI2NWlTdkZvbFUvTzU1TGdiUkwzTUtVOVhWb2hvandM?=
 =?utf-8?B?ZjNDZ1FKWHg2aHc5YVg0MVJoS1JmdEZXV2xBZE9nL0JoM1RyeTh5clQ5cTVq?=
 =?utf-8?B?aExuOFlTOTlZKzdHZWZhN3l0b3BhTFlxcHJRTjN3M2lvc0U5S2xNb0ttZC9a?=
 =?utf-8?B?WXZqdjQxNkQ3TkRMdDBQTE1KMm13Y0lkTy8vbmZNLy8wdG5KUjFYb2l3MEhz?=
 =?utf-8?B?dXYvcCtwYU1XLzV5cVoydDAwaTBOVW9FZXlIcDgrOElYaUxPZThJVm8vTDNw?=
 =?utf-8?B?QXZWQmNMTFVzdkVOMVBMcVlmVDE4MUxvZkFGQmo2K1dHajcvc0tlY0JrWi8w?=
 =?utf-8?B?L3FmbHdHQUhLbUpqSDZvdWRQTmQ2N3NySTBTS0RWRXBHQWcwLytlcEp6amhj?=
 =?utf-8?B?dDVyeFhlbTk0VEVvVnVYUGlvdUN5RjZzaHpmbGRuTkhJczgvRWtSc3Jidnhx?=
 =?utf-8?B?M2FWQS9YTDR3YXBoTFBEZ2wwZ3FibThsdnBtcnpZVEROdi9qY2FnV3ZZSzBp?=
 =?utf-8?B?dEgwL0RERG8vcmJobHNGaGZaVkgrT00yR2hEaXRyNjY5VU15NjlMa2lpa3ds?=
 =?utf-8?B?OFNTQzdwbjJoYVNxOEpUZlRCTVFhL3dHcVNqME5RQWZySVA1Z1MwajRqNDdY?=
 =?utf-8?B?U0dFSXV2L3F4YjBPNTlpODI2Tjg4dklwSDhnUk1zc05NenR3S3ZQdEROSlNu?=
 =?utf-8?B?YTVtOFNxM2RpRXh0TVlWbVBtajBiaDFCMUxzNDc2VzhYa0dqa1ovSnAvTjN1?=
 =?utf-8?B?L1JWVUtRZVpSSTVnKzZPVGVvYURHblpleGVoMitETU4xZXc5TTZJRE54WHBD?=
 =?utf-8?B?Qlh6d2NhOEFOOElrdGY1UncwVWhnMVR5TzVZWisxR2JIekZBcXdQYVUwS1lH?=
 =?utf-8?B?anY5QzhZWHFwWWNuS01HY1lPY2VLbXRuRC84QXJoK01uNkZkaEQzNzd4a3pL?=
 =?utf-8?B?VlRURXdDWm51Mks1LzBXUW1mWWdHSVhkaXd1UktRL0dKU1Q5Q3JRUkl4RDdL?=
 =?utf-8?B?L04ydWpFcldDVXI4a2lMcS9pTnZPdk11eWFxdStQVWlTeUVnZWpnV1pWMm01?=
 =?utf-8?B?WjJKbHV2VUU4MFNNMTMrMUhBbGRzRkJhbm5wZmZYemtGMllwSlp3QjNIRUVD?=
 =?utf-8?B?azg5Rmg3bEJ2Sitzb0FULzNtV1RJY3JrL1NTdEZWRzdObWQ5Nm5GdkFNRVly?=
 =?utf-8?B?ZE45UzdxbVg4emxzcVg0UHBCUnFSTkhXZUllL1M2MXlTNVF3SlJGandSRkpL?=
 =?utf-8?B?cFdLRjFyRFNlNHRhOUVpbkt5NnVoanoyRVRMUWZDYjQzWmpFN3o2V2MxSWFs?=
 =?utf-8?B?Mlp1K0Q3MUVhcjR4T0Q0aEF2VGEvVmtReGs5Y2lpWjYxc2wvd20wUUFJTk81?=
 =?utf-8?B?MGkwemhncVpoWVdmdEkrcHg0ZE5odFA2bkJXQmZHL0NPK2hMOC9HV2YrTVNL?=
 =?utf-8?Q?ZeFrZWcjFiGub7+mpm4lWpqeJjRC2P8vv3DnoTv6dU31?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B1F648751E4DE4C84BC2D01CA1EEB26@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d20496a6-0b8a-471b-7ad2-08db2e4ec582
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2023 23:06:45.8890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fHBATVnPlGxgd8VjYf+FSlo2d3zMyaHChTjS3dM5akziZQXmqbXLaxkbjPyu4WO0/U3daHkQ7kfX969a15Uy2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4165
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_160653_640587_0D64B535 
X-CRM114-Status: GOOD (  11.06  )
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

T24gMy8yNi8yMyAwMDoyMiwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4NCj4+Pj4+IFVzZSBjb25z
aXN0ZW50IHR5cGUgdW5zaWduZWQgaW50IGZvciBzaHV0ZG93bl90aW1lb3V0IHRoYXQgbWF0Y2hl
cw0KPj4+Pj4gb3RoZXIgdGltZW91dCB0eXBlcy4NCj4+Pj4NCj4+Pj4gRG9lcyBpdCBtYWtlIHNl
bnNlIHRvIGFsbG93IHNodXRkb3duIHRpbWVvdXQgdG8gYmUgdGhhdCBsb25nPw0KPj4+Pg0KPj4+
DQo+Pg0KPj4gdGhpbmtpbmcgb24gdGhlIHNhbWUgbGluZSBkbyB3ZSByZWFsbHkgbmVlZCBhZG1p
biBhbmQgaW8gdGltZW91dA0KPj4gdmFsdWVzIHRvIGJlIHVuc2lnbmVkIGludCAoc2l6ZW9mKHVu
c2lnbmVkIGludCkgPSA0IGJ5dGVzIG9uDQo+PiBteSBtYWNoaW5lID8gYXMgdGhpcyB2YWx1ZSBp
cyBpbiBzZWNvbmRzIDB4ZmZmZmZmZmYgaXMgd2F5DQo+PiB0byBsb25nIHdhaXQgdG8gZmluaXNo
IGFkbWluIGNvbW1hbmQuLg0KPj4NCj4+IHBlcmhhcHMgd2Ugc2hvdWxkIGNoYW5nZSBpdCB0byB1
MTYgZm9yIGlvL2FkbWluL3NodWRvd24gdGltZW91dCA/DQo+DQo+IEkgdGhpbmsgd2UgY2FuIGxl
YXZlIHRoZSBpby9hZG1pbiBhbmQgc2h1dGRvd24gYXMgdGhleSBhcmUuDQoNCm9rYXksIHdpbGwg
c2VuZCBvdXQgdjIgd2l0aCBjb21tZW50cyBhZGRyZXNzZWQuDQoNCi1jaw0KDQoNCg==

