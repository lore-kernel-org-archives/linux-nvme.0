Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFE3C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 12 May 2022 18:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eImuw2hS8XrpfubM/2vUacazPZiwBmBpst3jYYPK5RU=; b=BoCU8bufUtne+6gCriB6nrKWH5
	e6q9cb4k+iz6kEsZ9bZjXh4LuC8mFRdByXgmbcrjfkMnJxXRaP4jv/NxW1TX3Pw7IQPHrtxXEmghB
	SGM3/kVAKD8vLr0dgfcdOaqvlfeQsNBhkCax+hl+mi9I9zgXM5wgi8Rg9rDj5nNuNV5Nc9Gftlsc4
	Sxs07pMZsc8vcrp8LQMwU3t7PQJCeTGBqF5icMvHa9QKQPuZRls7UqobV6yLax3aRJ311hOt8agtM
	ZgSjLGM8iDi2uPSfnoVyccTnaPnT5qeoMsslAED2QPsaTE4/Txjrd5133SN5ecMwkn6lC/p1JVYYu
	bpgbrbTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1npE1e-00DB09-Os; Thu, 12 May 2022 18:59:02 +0000
Received: from mail-dm6nam11on2061b.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::61b]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1npE1b-00DAyu-Cl
 for linux-nvme@lists.infradead.org; Thu, 12 May 2022 18:59:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVHRgxmBry6YsFQMxsm6XpGEYu5fZSi4EmEpgASaxg9pnpLvcQSP5K+LQu4aertsshsKVXgpg9JQ1hvMyXkoEraoeshpo2uCDw+ulY/FGXH9MvnBUztipZYrVoEft9n7dNMKb0MSP2Moy7kDTi+1mKoLdFfZrRT6Cv63oZNFndP8zZXWlBWiFMr/8qfWLNKu23gw+BJtarZs0eectdw1jyRmBkUou2yTDhYYpX1WtEM8VHHPeSiTbnh3bCXtL6nOCTGqbFrFaRHwErTDYA4KrYt2lMSjo+qvQzS9ij5DZ7Sy6VZrxXOguhQalduCVr2lkLkDC4dB183kDwrzZwRoKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eImuw2hS8XrpfubM/2vUacazPZiwBmBpst3jYYPK5RU=;
 b=F07ZnzeF0CS7xhDfV+KbCFWVl1N8INCTjmqhKGx6ZQrEe7BhOtv1REKihP0wA9jy8R96N9/vg9QZh5DHgFQiH3pT23Q5PtMc3/xQnPZzuMTWEFqhFmloDTcYCQvJf2FTWvV8Gsd8XOkPepQi1blPBcLFL92McN0NdKfP37zKF1w2aMLI3Hm4xNQaeo2G55yKtQVdRKYtFfpiW/f94QSYYmZTz5QSOEarujdkuIHCEgmOVm+50k+br7NPl5QN6Ygws2drgZjStzp5SSqSp6afBXh+gheH0C8ApczkQbLcl0vbOrrDtJpLQ+JVl5Vg8/hYSUDc7CaWoLkSPNgIdSummQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eImuw2hS8XrpfubM/2vUacazPZiwBmBpst3jYYPK5RU=;
 b=n6EiXMbLPdQEvuxHn1B74osZc65qWNlLWvuHuWF3WBe7PmpfsSLaepTHX+O2+5Ee2/gUA9SVBocdC4Jz0/Rr+kxVynX8maRew5LH6ErkDkyA5xBER4VpvT+BvBgcK/omk3Yd7mQJkCKMVUJ22jW1h4mXH3Nrbt3ewwK1XK3flHDyCtUiIRFEg3jsdsvs7ql1NZMB5d2q7SCxPp0vLY+HG9vnAZX/9O7cxUe6KD8gj/ibja5fCfCJLRXpdDTfdzP8f/Xe78kzrFTCgfwAixZpbBequOnlEpHmnstdI5Z8p1aQI/c5c6btwhZ/mLTUtstRai2nH6YqHMqqcN9dsDdGKg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BN6PR1201MB2496.namprd12.prod.outlook.com (2603:10b6:404:a7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Thu, 12 May
 2022 18:58:54 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 18:58:54 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Alan Adamson <alan.adamson@oracle.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH blktests] tests/nvme: add tests for error logging
Thread-Topic: [PATCH blktests] tests/nvme: add tests for error logging
Thread-Index: AQHYXBXvgw8igX/zVk6hotp6/G/rIa0WbaWAgAU+FYCAAADAAA==
Date: Thu, 12 May 2022 18:58:54 +0000
Message-ID: <f1f62d79-6e03-7d1d-f7b0-595a127ff549@nvidia.com>
References: <20220429220946.22099-1-alan.adamson@oracle.com>
 <20220509105242.hv52nmc7yqd4chnz@shindev>
 <4a655f3e-a5dc-6aac-c1f2-a9620d05ae4e@nvidia.com>
In-Reply-To: <4a655f3e-a5dc-6aac-c1f2-a9620d05ae4e@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f27dbf2-148f-49b5-918c-08da34497643
x-ms-traffictypediagnostic: BN6PR1201MB2496:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB2496F00F6D4021D914B174A1A3CB9@BN6PR1201MB2496.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+hkQcNBclcOHSEz2Jju2CVdH9OmnCTIuYr+z6U2D+baw/FBPhsl0WL69y7FhSCn+RhaQ7k6320lWgozO4Yq1anIr5ujyODQd5vqgjFupkXdvj3Pewm4i7wk2sf2QVtSBICbhu76XZDli19lxBQHMHLACVgv8bgp6KzLsILF/EKGT50LRgAeU+sp7SaI3BNcPx3igoEXmbrEJwRvgOd0GvLV3fJ4rlAS38L0uFnMBoG4n6I8RM3rV9+vnMa4tloz5BC1scfXgf2r9/rqLkc/GHUypRKglUUgXYfXczCB6WKOa3sOjpk+hz3vxqaR65EY+qS1Q3r8IuBdYNgfgohZ1rVMwp8XKzYNYAnjAPp2gf0ZmxVQGhY1My0kHSR7EWe6PBQyqc5K9c5DTPIq/vWzJxxGfzjhPtqM8EPOFVotmPRd7vkQrGHe7kL6LIvDH/VIm/+iHOv8ebyuFrswKJOI2O3rWNsTYUcVekhflmOkf990IcMHi8ur2yYSGimXIIb0C8Zq7rJeBucgblXKxGp16SYEo59MVmYK7QKXxnzdZd1lzJyiV+05/2C1ioHSfQ2w5Dy+aMfa4YQLaXANPFdIIqoKgcFeXVW4zlv2keRw9GTwTVkMgrUpweUEWOaZHCUBAfVHFVoQLjVqSoMDeD2Eyd5j9PQ1mOpApsZSGXypeBQ+/d1O4QuuykvNwB48iB+uVrd7lWPaAISUauZWz8jdC5yjjNx8x8kdaBh1YOZcB3xTH2phougMJs+oSbT4R/os7oYY4ByKS5Jg3PjercqgPg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2906002)(6486002)(186003)(71200400001)(38070700005)(508600001)(558084003)(6512007)(5660300002)(6506007)(2616005)(8936002)(6916009)(86362001)(54906003)(66446008)(66476007)(76116006)(64756008)(8676002)(66946007)(66556008)(91956017)(31686004)(4326008)(122000001)(31696002)(36756003)(316002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3JhQ2YveTRTd2NLcmt4MHh6d2hMRGZ4M1VFR3FiaThzTEt5c080OXJJSmJX?=
 =?utf-8?B?THljNkl2RzBsU2FFQXhiNFp2VmdlU1NQRmxYTnlvbEdVS1pHQllMVmlFOVM1?=
 =?utf-8?B?MGVnOUI4UGo2SnAzV2J6dXR5OEVTc3NTNDB3NFdVV3lGMXNrMld1ZzFTYWg4?=
 =?utf-8?B?Q0JFRnRxYSt0aGExM1hQTUdtdHkzQlZWbWhWRnFSYTZuWER4SjdPRytjcG1v?=
 =?utf-8?B?VFZYOEpqWHhkVDVoeWxXSDNLekt0RU5SSkJCZ2pGZWVJYUFFbCtnZjI3eklj?=
 =?utf-8?B?aDFwMDh1clUzVlR6NUVScVRXSjJuQjBrWVJQY09lbW9BYnZLUVk4RjNtRlFi?=
 =?utf-8?B?NjN4dEpTdkVNbEVabW1oOG92VWRGUm10NmkrU2hJcU5YQ1NRcXRiZysweGhx?=
 =?utf-8?B?ZHYrQWdMK1VqZGpnY2lpelFoczFPU3Y1QzVhYUdETEFSa0hkeGViYlZVbW9l?=
 =?utf-8?B?K0pUQkN3OUExanl5RitFUElUT09DZHRrTzFjUFNqb2RHSFA2VzF4UlJrQzgr?=
 =?utf-8?B?KzAzM2ljMVdaUkdTbVV3clZQaEFMa29JdEx2cm1EVFRQMDZBSWtuUmdnTVhE?=
 =?utf-8?B?LzhJUnBUOUhmMGYzMEZ0WWt6WFUydmJ3dys2TTRSZGpUQWVJU3FwNk5meEpu?=
 =?utf-8?B?MkdKSWJSVDFIeGlpQmJ3QmNiWDZiU0h3ZzQ3N08vekZpa3h1alZORmV5UkZZ?=
 =?utf-8?B?SVNmanZtVm1GUlk3RTQydEtrY3VmQk9xRUZZSTBNaWtndllsVFRXNXk4ajNQ?=
 =?utf-8?B?Vmh2OTBPcW53MU0yNStqM1pRQ2s3S2ZxVTltTnhmWmZ4NUFGUWhtVVZIZDNX?=
 =?utf-8?B?WFJXNk5uNkh3dGJReC9LdUF0YWpzMVhBaWVsYzlNTnM3L0FZY3BwRXgwdWRZ?=
 =?utf-8?B?c1FmZGt1ak1qM3lnbFBMWGtOdFNRWjBidXU5aWdOUDBBc0t3UTU0NS95RmlI?=
 =?utf-8?B?THcyeW5DVVVGUkxFaFNHS2J1M1lscGZiSnM2RGR6QUNua3NtZ21xcy9kL0hR?=
 =?utf-8?B?VCtlVE9pVXE5Q1lnNmxRQm14OGlHQmp1YThJTlZ6ekhFSHRXZTgwSk5wdFZ5?=
 =?utf-8?B?bDIzTVh2Z3liNUlic0VUdVl4YVErTmtJZklhckVoKy92TFNkSlY3dmVBT04x?=
 =?utf-8?B?ME0yYWZGM3JXd2M0SDlYYi9KNG9hZmtiRysvMDlQMDhENThUVEttRkl0S3BP?=
 =?utf-8?B?RUY2azljM1Iza3BMQWRwZTlUVXBMWjJIRURTSUxGRlI0NmJTS3lueXBXc2Zt?=
 =?utf-8?B?UGNjeFFiN2VGWEs5TmgwVERUVDEzNzU2czJ5aWVSaW43RG9iREp5WGUwWWNS?=
 =?utf-8?B?N2l0WHNxN2MwdndLUDdjT3dhUWN0R213eDZWT0Jyb0NDSWNPd0xKWXhlb0tH?=
 =?utf-8?B?MnI5ditDNk1lNEFZNExYelpBMjBkZFJIclR6Q2hCTkRrc2ZhaVlwcmVMUDhj?=
 =?utf-8?B?ek9LNklRZmVkL1BLN3VseElpSWN4SkY3Q010TU9SVEV6b0N5U1JpeWJjNzlB?=
 =?utf-8?B?VEZhMi9YVmVOZlN6MGRKeGllemQrU2VuT2trTC9ObmlLTDkvWW9UYmt2UUoy?=
 =?utf-8?B?dWRpOTFFWFg2MWRrVWNxc05sajdNME9XaHlQMzd2amczWUNtK3U2V1ZEc1Yv?=
 =?utf-8?B?dnI1ZnlqNFhlUGVjdWtES1A0L2NwWFlwQ1Z6QU1DZmZGdEpYZ284N3JkZzla?=
 =?utf-8?B?UFcyanRwNnhPV0xqdVVQQkt5d3A0d0IvcGR4a2wxWFN4M3JSb1lMbGRaVGlQ?=
 =?utf-8?B?U0ZrUU9aNzUvWEVwSjhVVGZ5K25rdkJibVJ5ck5ud2I2MVRockhQZG9FeFRa?=
 =?utf-8?B?dDBOYk42am00VzV5S2ZCRDdObEFTTmVadVlUNm1qMGZsa0pjMGtnS1Ara2sx?=
 =?utf-8?B?RmJJUFlLTlJVcGNVN2ZXVDNhWVZGZHpiWlJuc1NRSk5qcWE4dUQ5Qjl0Wjh6?=
 =?utf-8?B?ZzdHeFVFTVEyKzZkWTJuM3JIVi9mWVhNL0xBc2ZtbXZ0Y3NXdHFMTDBNbUVh?=
 =?utf-8?B?azZlOEVQb1hRZCs2NW96NnVvYmwxK3dHN1FMSHJ3OW1KRCtYUWNKT2gwdm5S?=
 =?utf-8?B?dUFhWU50di85aG5lZ0hwNmsydEpPdkxBQ0VNeUVobGxkdkg4V0wzZHB2UWc1?=
 =?utf-8?B?Tmp6N2NBZVZDTDhlbjUySEo0Q2IzQi9tUUxaWTg1NkNEdlpVdlFUTkMzZkZH?=
 =?utf-8?B?OEVGRisyNXlMSFpxa0t3QUFUSTV4TWJLUERYdTdQQzc2V0RuU2NSTU1tc3py?=
 =?utf-8?B?QjRrUHVrNktBQ2tNUGErU2hSNkVQMEF6UXFXV3QxMjFscVNwdjZBcXZhRXFv?=
 =?utf-8?B?Wjd4eEpoQXhKZHYwRXNVS1poQnFUZjhOMkhOeVpiL1NDWUh4cDBHSUNXUk5V?=
 =?utf-8?Q?9XwED1JQOuX+f60c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1E4259C8A1E9C4EBCB27CAF126F1A7A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f27dbf2-148f-49b5-918c-08da34497643
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2022 18:58:54.7274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MJCH/tCpb5G5Zip5WsDOgKJraxRvQPWNhwtofe/NtL4ObRkKWi9sfSyrZi1sD6+5y654kk7NU3o3W18W/1ooig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2496
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_115859_473065_9D84EC50 
X-CRM114-Status: UNSURE (   8.19  )
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

DQo+IA0KPiBjYW4geW91IHBsZWFzZSBzZW5kIG91dCBWMiB3aXRoIFNoaW5pY2hpcm8ncyBjb21t
ZW50cyA/DQo+IA0KPiAtY2sNCj4gDQoNClBsZWFzZSBpZ25vcmUgdGhpcywgSSBjYW4gc2VlIHRo
YXQgeW91J3ZlIGFscmVhZHkgZG9uZSB0aGF0Lg0KDQotY2sNCg0KDQo=

