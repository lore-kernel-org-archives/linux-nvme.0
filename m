Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A19EC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jul 2022 06:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ECGTdUh+khk3mZrBuFHlImb3lhPDT+uE6E+sTEvmozA=; b=KEZ9UGAgikPR2zWA97PaVopiJ2
	BbtGjvhK6leINFc48YsSw4gluNbjdE1Lceg90B7zJGiCf2K7LcCLwnnjc76NAOEWsWIl7Va5eCMF+
	M5SBPXG5+Z1aZPaoyIdGnPmlNUNpHadNKDUEv1WQR6oQBilGgNlXcZiMYKY1PhKmJGbpL1DquabEq
	xnMoI2qetA3IKYwZv+l1bChFJctDQuAdq9kUtqEpS+UGgoNQ1zPNrEioYaV4JjxDd41aEqLgUFLAC
	BbnE8xOMzgbFJqPcDShW6No8qeooYkU+h7aZWMQ1Tjt08s4Bm6046xAytBBjWyE1gDJLRhun9moMu
	+WdK31Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGDt7-008jTX-7s; Tue, 26 Jul 2022 06:17:49 +0000
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGDsy-008jNB-Hg
	for linux-nvme@lists.infradead.org; Tue, 26 Jul 2022 06:17:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TsmUNP29genFFnzH/nuKM1WxbaWs5hCOeaDFGVrl+hRjR9+bCqhr7lEa43xQLtS189uiGa3O2gCOSA1ttL+X3JhzX3VF4Ese4CwKRUm5bFQ1I9GADsMsjMgE5sH3tzXrIJmEGihdNU4Vm5rAOJVn7U+aJ5Stv3KGJKogwts2SfTJm/85Jsuy8/xrBXJIVDemgNnIf136Jv2pLGs4+CsqGg12RsW34VOu2WEH0up0Yhe8XdMKvNu+V7cVbp5WKfXFRNzuTUfPLHOnF0Oq/T31R0s3yqJizc32zYmBhWB9H0VcbX0WLojmKRZFDjWDqnhcsTk5zElamuke9HRhaom81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECGTdUh+khk3mZrBuFHlImb3lhPDT+uE6E+sTEvmozA=;
 b=TbYC+0htS5PSeGS5RIu/DjkPuX/Bh40h+7Y7JJ+CwZeS8eZq6oTRY7DSwKdRTfrLEA6F2vi2nJpwOzjt5kc6JtmwMDTSjJHI9v/Grgh5jWLQ1itP7iqyq4YIcdvNiQRwA/8hoposuOoqjnQklyZY+/uON70qdBIGgaWnU6eB42tDtPmeuwHePTWGi41+nzOW/a+7yO1rDBi/yyW9o+Qs6tKew7VFd7/rlDiBy0B8mAxyifmcNIP3n44hn5w4F6y2CVDKTgq46LNbyBUQvuw+VEAHMyASJ84nwUNAHEn8tz8LEPh/xBnjyhktBh6KhjoITik1EnDZiDJFEiF3RoBRlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECGTdUh+khk3mZrBuFHlImb3lhPDT+uE6E+sTEvmozA=;
 b=p4GNdtDXbbzKvleTRCp0ziATtAZUe7LjiY0lvL3JpOKetLHp3F3yvhPb86fgJKCVhOCeaCBnPo8ivo57PNS7Uy85E22Q/4cSoCFGpIkULEB87zv0E0CLtgz9v5mZwpn7qQUYjPUJy6NUWzrtwG5Qujt5GVlIuV7GjOctTrq8qnkwQeicIGdgRUhJO1JiNNGJFb8MGgG8g7qE4Yt63fR/4WJNMZ+0bfPdPJgNNPrS4gFe0qxqBZExF204me//v0G89uJGP1iAWME7+eSB/aiRGmF2LAw9CdM0vWrSoEkJeofzsjC8SXDh6oWe3+MwqBO9iLDq2F3y0qdDMyKMMFkUDA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by CY5PR12MB6322.namprd12.prod.outlook.com (2603:10b6:930:21::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Tue, 26 Jul
 2022 06:17:30 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512%5]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 06:17:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"hch@lst.de" <hch@lst.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH v2] nvmet: avoid unnecessary fsync and flush bio
Thread-Topic: [PATCH v2] nvmet: avoid unnecessary fsync and flush bio
Thread-Index: AQHYn++/mGmmktemIE6tvGsDVUi4Gq2QLuSA
Date: Tue, 26 Jul 2022 06:17:29 +0000
Message-ID: <844d5caa-3081-95e9-b76c-3672edd0f4a5@nvidia.com>
References: <1658730498-11857-1-git-send-email-kanie@linux.alibaba.com>
In-Reply-To: <1658730498-11857-1-git-send-email-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36a25ec5-e483-4e0d-a41b-08da6ece84b9
x-ms-traffictypediagnostic: CY5PR12MB6322:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  mkTM5FWlxilgaZh7qcqP93Pmhi0zNp+5p6NYO31JP22ydm2iR0WOtFmG7CVMbpecL88pgtKmADzi8/8CT9DzNcMUX6GEkaVN+dKWEQfSmxKapA4y6CyokRNgsvkux+eqkSICXWcsyeOqqF1ERVMdUK27VmudGcvARSxT5zlU7T5BqrLTW3O4JDwkMnFPb/GW6D6moN7dDMXkJ1A1YqMnbmV1Nu0anbf69H47XoYz5ae0+gC41Zbt8THfEj0EX8G/gXcuRh2pM6op78e0FhMiR2tGFAFnA35GKxJUCVoilGkXtB/ImYgzgSwdcr/U+dKC3fsKUPE7HmpqBrtI1D95drEXAtz2LKz1UJQUe1VC/YU/NWWp7GrIlxcEohMqt0f5DuVCmct2gU7z0kSlG6lLTqcLuSK+Wbjo3Tvu5DRaL+M8mMQIvNHXIX2Bv8KZBpg5sfjYi1Di6f7C1q/rh4s8i5jR2GpxJTTCZFc4KIEo7QVBiFXNeUFvn05vthLr1mERkjjfCV6U8t1zchaBTeUuG+NpSTLprzdExUd0xPiT5NuB3BSXO9iBdApXP2TxTp6iRHS7NtjE4/Y5pWlSXf1ozCBxg7xyvQ5IXMq70N69/heMYuXZ9uBEDw3R5Fn6QPOahj3e5vWpURbPEFd5wvbjz26mWPaHm9IYM64EhIYApN3RBUzOCwkATFxxoOid4ADBqkYNMYM0tgLJSpNjroZUC9uo/SUC90hwYa+ECJIO+CiqvLSaLixGkbprcUZMBKVoz/EjsH2+7p/1j7SI/0SJsBeCwMprh/PotQV3GCqGXLXfuRI55xjUBiaxEci7MVk1G5gXnO50W1sOEZoGb0Qeu+ASriGABms6Y7tAZ5QcjEfbO6p54IQ/BYfXN+FJBZaw
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(86362001)(122000001)(83380400001)(31696002)(38070700005)(26005)(53546011)(186003)(2616005)(6512007)(6506007)(36756003)(31686004)(316002)(71200400001)(41300700001)(6916009)(6486002)(478600001)(91956017)(8936002)(64756008)(66556008)(4744005)(5660300002)(8676002)(66946007)(4326008)(66476007)(76116006)(66446008)(38100700002)(54906003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?clp3WHFFN0wwTHQ3cnhOa2Z3M3M5eWhnYTh5NVpEVHRnWGJNSi9JQ21QOFha?=
 =?utf-8?B?U2dSRS9SazFlRVdoSVBwWnFtV1l4cVZMVHl0Nko3TDhWVXFFNFdRVEY2UWtM?=
 =?utf-8?B?SnNvMW81UUJRY0tnQmNhQmsxaUlheE1IKy9RRVdSZkh1TEtoWGl3SmUxNnNU?=
 =?utf-8?B?bm5hNjJCYjlVZkVjSm9rRURtb2N0bHZDSnd6QUFtb21SUGpkS3c1TThJaWpQ?=
 =?utf-8?B?N29mWCtGeFVpdzY3NXpzaUFSRzc3SEtab0JOSlJVS2pFNEVRckcvZWZ0N3Zk?=
 =?utf-8?B?ampSNVJic2VmWWtCNHhpNUYybjFNd0FHMEp1Tm5yd0xHdE9JblZVUGhqejha?=
 =?utf-8?B?ZTAxSjAzendvWDlIakZ4T0FveXNDYnVMYnIvVkJVQ211NEdvRGpqNVZRZU83?=
 =?utf-8?B?aWZ3T3pKUkVQUDVLZ3NFNkdOWjdMM2wvN2wwWHAwNlVkM2VlZjhqU0lMUmtt?=
 =?utf-8?B?Zm1UZ1lzMjNIMVhta0h4MnU0dUhTbGU0RkhiZGZ1U2t1bk1XaXo3aHl0K3c0?=
 =?utf-8?B?MkZmTUNpS1JzSWo4R3hMVTdOeXo5L2gzSEF6RkYyQVB0RngzcWNUWEZKU2dX?=
 =?utf-8?B?bWhlOXc1NkJzRXUweG9lWGdnVkd1cTR0U0srN1ZIeHpEMHR4QWJJYWhESk1x?=
 =?utf-8?B?eDVjM1E1ZHZoSlFlNGNGYlRIM2xpMENvVFRTUStlUEYwQ2pNZmcwTTBlcHJ2?=
 =?utf-8?B?dUpEcXlCcHQydEYyNHJhb1Y4WjBmNnhJSE15K2VvbnlYeWxVYkJDK05FamhD?=
 =?utf-8?B?T1dlZnEvQWZoQkhJQ09Nbk5scHY1cjJZaVEzZnQ4TVM0QlYxRllYQ3VGYTNh?=
 =?utf-8?B?ZVA5NjV5Vm1ETVVXcGZXNGM5OXRRRFlGbDByalBLM1owSlFDZHlBUk91OGMy?=
 =?utf-8?B?cW9xOStPNzYzSXpJNjJuZk8vejBEaTNwZDJ3RnZOM1dkSC9UWE1LMnpMb0pU?=
 =?utf-8?B?Nng3U2tVY2d6bDhkL2RsOG5IWnorWFBWV01xUU90cytacUtxbWdFQ1ZVS25G?=
 =?utf-8?B?ZmdrN2lIMDR5NU5Vdm1nd0QzcWNCN1hCcDBUQ2orWlh4d0JrcUV0TmJudm1F?=
 =?utf-8?B?ZlVsZmI5aVNscDY5SG1PMmtiblIrWlFHM0hRVHptTjhzektETytqSFVBSFhI?=
 =?utf-8?B?eUg2cXdpRDM2NkJiekxoSjZNOHRwV21NS3d6aEJaL1FUUWpMM0FMWUNqVHRy?=
 =?utf-8?B?NlNVaTZRNVVwWWVHTk9wT2htTGtScnZMWkpxMmNHdDNiaUtWcGNUNXRTT2xH?=
 =?utf-8?B?d0s2b202M1pFQm9uQ3dkYnVWM1MyY1NZNW0xZ2VsdXM4eG1DaDhjaG5GSHZn?=
 =?utf-8?B?RjN5L3dVa09YM3dxMFNxNWhhcUcyZG5VZ1pGSVQrcTlDMElBTjR6Q0MwNVor?=
 =?utf-8?B?MzFjN1Z1Q3VpamJZdDdCQmpqanQrRGtBY0FxMFJLQUsram5vSUk2MWV5YnY4?=
 =?utf-8?B?K1JvN1dnMm1oNkVES2pzMUFiNWE4VjUwaW9ETk8wZHRDaWN6Q3VydUhibzZw?=
 =?utf-8?B?dmJyNHMvQWZySHdZNU4yUms1Y2I0K3VBTW9vVUgweXlJVmpyR212M3ZlRFp1?=
 =?utf-8?B?V3I3S2RhVlBvUUVVVkNCOTBwd2VhNjBScHBFTjcvT29GaitwTnM2TFlOL2xG?=
 =?utf-8?B?ZFYydGM0c2NzbGpaWHoxR2V2VEdzaERBNTFzWUdValJPeEU5UWpMcW54KzNv?=
 =?utf-8?B?RnRTRStkVXZuVGZUcUoxYXFRUVhqZ0hvWnk1OXU0aENEdlJ4dWRhbVRNdlhN?=
 =?utf-8?B?enBzNEUwSk1XUjJoRmdBZTI5bnpBZWRGYUJ4RkdjcnkzWFljZUQ2RUMzc2o4?=
 =?utf-8?B?bElxSE05SGV5OWxxR1hObmJJQk5KOEE4UjFvYmZObklrVnYxamxKYTVtYkZ4?=
 =?utf-8?B?NkRLa2Vwcm5VR216RCtRVnNRRjYxVzlzUkZtTmQ0Nk9hRkZ5S0JwUENqdElC?=
 =?utf-8?B?VDdaOG5Jd2htdzZWVGRsOTJNdU53bk5TOWJFQ1oxY3U3ZERnWmNZcG01VFI2?=
 =?utf-8?B?OE1PNTJ4bU5nZWUrUGxQdTVjWW1PSHUyV0FGQmVoYkQvU2xlNEVYdGJ4OXJ2?=
 =?utf-8?B?a2dySjZzZEgxVWRYcXBmVlVudjcveTN6ZGhDbzNCYnorNk84YWtDRXN4RmJK?=
 =?utf-8?Q?Ci2QlssdBJB8JYLYRAAYfm+4C?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52473C9020C1664CB5CB3B180E5C0542@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a25ec5-e483-4e0d-a41b-08da6ece84b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 06:17:29.4798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: en+roDSE6iPsKhVemKOlEd29t9dIeqVQkIT5x9dr6+hTpWMQpJlkzoDm/iUKxqWjaFo2EYAJ4giGO0IeXX3PUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6322
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_231740_870996_0F32FFB5 
X-CRM114-Status: UNSURE (   8.47  )
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

T24gNy8yNC8yMiAyMzoyOCwgR3VpeGluIExpdSB3cm90ZToNCj4gRm9yIG5vbmUgYnVmZmVyZWRf
aW8gZmlsZSBiYWNrZW5kIGFuZCBubyB2b2xhdGlsZSB3cml0ZSBjYWNoZQ0KPiBibG9jayBkZXZp
Y2UgYmFja2VuZCwgZnN5bmMgYW5kIGZsdXNoIGJpbyBhcmUgYm90aCB1bm5lY2Vzc2FyeSwNCj4g
YXZvaWQgdG8gZG8gdGhhdC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEd1aXhpbiBMaXUgPGthbmll
QGxpbnV4LmFsaWJhYmEuY29tPg0KDQpMb29rcyBnb29kIHRvIG1lLCBJIGJlbGlldmUgeW91IGhh
dmUgdGVzdGVkIHRoaXMgcGF0Y2guDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fybmkg
PGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

