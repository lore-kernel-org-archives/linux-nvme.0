Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B13C636CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Jan 2023 21:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PSwJ4cyauA+ciWrmUxLNuHV3zbzyTpzTsqxeBiVeomY=; b=pofVi8PwBTqVtCmLF2KIZ8/jEb
	J7xm+TdA3uuUVzK4Z5tAE7h5w0PCHnkLAo/gfP+JcoP08l8o7fq+ko6+gF5RutxCu4xFS5Ye58YYO
	3n0ZoV5hbWZS03ebA0Z6piAxv3Ts9l1TeMtzqdGxW7SRDOeskQb2eCjt3MvXX/RMXU8wtg88UGCK+
	TE6c06F7hiFzNv6kfdkZcqz397JgqPp8u6UKqzrtiCM02ecdaAjuwYaeNgZsYdw+784wqjcb+Q0Kx
	smLOgiycYPtLBP2i/MXg+q1C9siK1h6mKznGFOaFf4lNJH73UH4jZDGDi2AQKRuWaDbcTND16LMXV
	aA9l++mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMxuy-009NF8-AM; Tue, 31 Jan 2023 21:11:52 +0000
Received: from mail-dm6nam12on20615.outbound.protection.outlook.com ([2a01:111:f400:fe59::615] helo=outbound.mail.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pMxut-009NDK-F5
	for linux-nvme@lists.infradead.org; Tue, 31 Jan 2023 21:11:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1fJ1ix/2TxbxfnIIhZU1zIINf6/yV91LqG1u0Am6RrFwerc5mmf3xfVbyS6M2WbTZgjev2x3/m+j5KXvOVunVTipk/0HDCnJVk8YkfvcPsllzJeFdlYnaLazbiOQz1I76KzdAK/BLx/qwEWp48+y2VADHZLllVt7PNUkcnfa1VBVnPouzA0P4LmmkFNKRlbZ6z2fpknyQ3B+gjTBUQ3tyTzpF4qVjEv9XmVeGM1CDcaM4NDfhZdLwbD4+fUvgHBtTC77ecdTug+w3In5/Ki3lXAMm67jzOxdWdsyXHoeehMX8CrYtAxf4GSnzlj+Iv63r8m/qXhBYIF6SByRSic/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSwJ4cyauA+ciWrmUxLNuHV3zbzyTpzTsqxeBiVeomY=;
 b=h1N+m49gTNBfck07ct+uIaVFS+/LMEh5iV23e1HYoElT92Xh1pkFFJI0rIm9dTHv/+jpo+mrKf9AvZXapOTzby1uMUXAus+vTlKpklxMHFaT4hBT63yPf5sPrwRDK7TByeUe2mnaPSglZDzu9DHhayuWNC3T2tPi3nWz5dalrskkFvRlxiw64y9tBfp6dtovHbug5ukZpO6nX/3RNJOfUI7WmGoeMFTZcuO94K2o3bN3EqDVCHRGED7Bbpsc8S+89K6YcOJG1iI0znVBzHnRuyktlppjO/LXzTRfrHjdwbjgMrcMh/sqXzFHN7hxcCndjSsmM6GD6OkegRZ+aYD0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSwJ4cyauA+ciWrmUxLNuHV3zbzyTpzTsqxeBiVeomY=;
 b=KaqdcCxbNwq76FnbXAYhwYsrS95PRk5IZf8XyJuQD6TzDOjD6IVZFz4ylNMg3kz5N7P2saVd81A0OyBqPKvBRD7lUEDbn6e1ZSaNiJDih5qqv7ivzzG0U8YTHkWDgznIzWZZlBFHH9uS4oAwNF0d+wfDNFeTQDfVAvQW7L8JVx3bwC/NRjloOfYgixihLF189nUnWDEwEDrpomBXxAOWPlZbjJkSf8Unkn0mH+SYJXYJMhuotvAgiAcY0liJ+NWt6bpNV27e/P90lahc+QQeHRhOIj8wtaOX9eGA31ZQHXOZICqE/000c6pGLdlIYrlXzUdJ5XHF92kxZ8Xf7HGysQ==
Received: from BL0PR12MB4659.namprd12.prod.outlook.com (2603:10b6:207:1d::33)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 21:11:42 +0000
Received: from BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::57ff:d53b:f3e7:d2d5]) by BL0PR12MB4659.namprd12.prod.outlook.com
 ([fe80::57ff:d53b:f3e7:d2d5%5]) with mapi id 15.20.6043.038; Tue, 31 Jan 2023
 21:11:41 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@redhat.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>
CC: "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvme: fix potential invalid pointer dereference
Thread-Topic: [PATCH] nvme: fix potential invalid pointer dereference
Thread-Index: AQHZMmaKpyswjclSOUmZve659AAe5q65DG2A
Date: Tue, 31 Jan 2023 21:11:41 +0000
Message-ID: <cd50a85b-09b9-4790-45dd-31a56029f106@nvidia.com>
References: <20230127154237.349113-1-mlombard@redhat.com>
In-Reply-To: <20230127154237.349113-1-mlombard@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4659:EE_|LV2PR12MB5749:EE_
x-ms-office365-filtering-correlation-id: caac9659-823b-4b96-7d96-08db03cfc01b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  1wLRx4gAsnmChcANVkA0UjUQwMelFWigcm5cMWp/6afPUbozjo4z68VWjJcJFTnFBqI0LElayZzv0ZZVBuPRogKb7y54+RonBEYEbyag3RjN+E7XtZqKLAW1d5Wp6AEZYF/WxOxAXrS4ZED5+iDB+Sr3iCHsfx2Rausjfn0nArX1aFPnzEy742MVbOwSRJEvqizK/q48UBH1k0V+mryqDvHQ2iOg6B8UAw/dIgjamtx+YhLYte9UNO1TTlRN8P3u/BGeLXRusZtWcN3F/OnRoMIIXsuUHyjwrDhUG4wUEIVA+ZcTeTzH+ObapyALaideNXSaTY3pYu0DnZf5B7QZoPAAGcqLofH8KMXeiVYrdbmnLoXJAmGeqZYaFKS/6KQZ8IRp2eNLVIpmAoTTMPgGQ5uZ+ESK0x9h3xtszbMwtDzeXb/qPrDi9DisV+iUiR3hGz2c9iRfij5C00B7VSutANXQKFhI2ygeTQXZWPbraVepiCN+O+yAEPuJ9eJQVDqdgUi0tVkrX0Ar3Se8CDNH2ByDjLs5XbR08SCw9hM4ijzEB8SNzdQzSdb+PDF99PCTEnXQ/jOeBRIWf24JPhXMw7TeneoGmVJnO5aeepaPeH/hQpg0YztCKmYIVn/5KuK5PfeJkB2elf2Yqw/OcwGtm2kdhG3fOhuIECKB8FK0/dSQPtntwecMIjIG3Lm8E/zmYPLJY0pJNwU3M+CCCdmZfLp7nG82hvOyNhRb/GWLl1lBunluMQp5IRRtU+rTe3P7qqjiwqb3+D/h3QxIrPz4Mg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(451199018)(54906003)(110136005)(316002)(71200400001)(8936002)(31696002)(41300700001)(86362001)(66446008)(2906002)(4744005)(4326008)(8676002)(66556008)(76116006)(66476007)(64756008)(91956017)(5660300002)(66946007)(31686004)(38100700002)(122000001)(36756003)(38070700005)(478600001)(186003)(6512007)(6486002)(53546011)(6506007)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?WU1TWTZ4WHh0M0crVGxEdmVrVWlhdU9ONVY5RGRZUWl5ZkpMZDJnMVM1VGlr?=
 =?utf-8?B?OEZGZWVQeFpieXF3UGl0Q2JNcGwydnRueXRKT2NVUDJZeXB2eXdxM2VHV1RU?=
 =?utf-8?B?eE50OTZ5eCtOeXhLRXZiYTRlSXJLZU1jZEJVVmVrU1BXeGtTUmhSc1cwSHlJ?=
 =?utf-8?B?aHlXRzJ3cVZuMGNZYk1QVXlOZHMvTlRZRHlndHhhVGtJN0xBdnl2eGdTNTNF?=
 =?utf-8?B?SW56dnpaY1dWSmVtUFFkV3dFOTdTS3RlZFgvaGVBVmVPbzY3OFA4K3dLeG8r?=
 =?utf-8?B?SUNXNmRTam5NK3d3b1N0ZkgwT1FqSG9wNTJmdGVpV0N6bmZhYU54RmF1dHY3?=
 =?utf-8?B?ZzF1N09LdG5wNm40b2grTERFRzVLYThDNDY1dnJxZFBnZVpiSU1tSnh1SWhR?=
 =?utf-8?B?VzF6dnFoK216SXdVNDJ3Z0x6cEJWWVA0aHByYzRxby9sVExKSW00aW9BL3Yv?=
 =?utf-8?B?Skp6ZkJpWk1YUTJsek5ISFE0V2o0MFpWdnJzbU4rL2M1Zk9wbklWWFNOSXBa?=
 =?utf-8?B?YkhNT1JzTWxvTE5pUHE5UVhWVzJ0SVZ1RFhKd2ZURlNkaFZYSDNYSUZ0aWtV?=
 =?utf-8?B?ZUZHTXFjeHFRdWIrb1FMaEZOcmFVa1R6Q3ZCays5RjVlN1VwZjhhaWJBK0V4?=
 =?utf-8?B?YXBOYzFYbmxHYlhnQ25HZUM3K0UzL2FqS3JqSFViMDBCREZubVNpY0RHN0Fs?=
 =?utf-8?B?QWpTM3k5UUk4Y0F3aS9RRzYxa0dLZVErcDZ4ZmQyVzh1dUN5aXZDMXhwWnc0?=
 =?utf-8?B?RmtyQVBuL0ljM1orSU9nWVlqbnBOYVRFSmc4UnIweTZBN25ZK0VtdHVjUFhq?=
 =?utf-8?B?RzEwYXdOeHRTRFUveDFJVk1WUytrdGpzeE93WS83ZENtVkg4bnl5ZkxBczhY?=
 =?utf-8?B?bVVJNDdNd292aHlnWkNpTG9IMU55TFZPQW9OVTFyNkJpbWpkTlBKUHo3Q3dI?=
 =?utf-8?B?akd2RHpPY0FKK3YzS2R4MUMzdktmSGRKWkVvTmNVc3BuMFQ3b0VEKy9JQmFR?=
 =?utf-8?B?NlZtZi81T2ZDcnc3RmUyY0d4RisxTWl5bzM0ZmdheWE1MWEzMXErRjBLNFlQ?=
 =?utf-8?B?VDNjVzZBWmd4SE50cjRnbStoOTMrZlNNRHM2anRMajhFZ2pYem9idDMwQUQx?=
 =?utf-8?B?VEFEWm5JM0Y3N0JWbWpZR3BlUlloT2cwNmgvMFBzdXUzUlZjWFVGVGozVUFn?=
 =?utf-8?B?TjdGVWxBcStZVnl0aDcvNGEvZzFpTVdrNHdvSzZwZVRIcCtNVnBEZVp6RXl0?=
 =?utf-8?B?UjI1clVlSUR6U3lKWlNkaWdUd0Nub3J6ZXhwVHl4b2pMT043dFRISlFYL1A3?=
 =?utf-8?B?c2EyS0dYdU4xZlY3bjc0cmdqM3pPRmhGYjhFV3JsMDJLUVJGZDBwRnp2bUVE?=
 =?utf-8?B?M3luQnVLZ09lK05xUWtKOG1YMmdVZnRsaUx2VmZ0SUlodkxDS1Ntd3Nwc3Mw?=
 =?utf-8?B?Z0ppN3VPdlFMRit5K3J4aklibkJRc1dpVjVzaHJaWEN3ekJnSzROc0xCbUxY?=
 =?utf-8?B?TU1MeVBTNkpCb0NZSktpMzNiajhuOWM4RlJMWjY0ZW5QNlFTVG1XRGpMRGlM?=
 =?utf-8?B?K0xta0w5eEVUTVI0RTV0TDM2YkRjR3o0ODd2UkphckxKQlZmN3lFY1hwZE12?=
 =?utf-8?B?Q0VobkQyZk9sQTE5amp6bWlOb0JLejBXVElRd1JXZWhLLzNYUys2S3NVb2xV?=
 =?utf-8?B?RERhZTBxZ0RiWk9kdk5TdEZncDJZRGhROXgzdEwrWHFYKytxMVdMMmc4TzEv?=
 =?utf-8?B?RlhmdFEwWGlvWGU5YkQvdlVpZ1ZqRGpwbU1OMHhqZ1czK2p5VnU5cFN3R2lP?=
 =?utf-8?B?dEJRb2o1S1lkMGF2QS8rME0yYVZEQmZQbEsvaTJjVlRVb2xxTGVEK3FFSGdE?=
 =?utf-8?B?SWZTeXJnVUZIOGEwTWljcS8vc2Nna1NXRnM0cFpCbU5NaDYvM2ZmNXZWYWVy?=
 =?utf-8?B?UzA0QlRxUU9zdEl4cFJtNkEwaWZkS0Q1TEdmVTU2V2d1bnIvYUxSSmlMVFVT?=
 =?utf-8?B?WjBBVXZQWUM2QXFXRUdiYXpCNEVzZXp6UFpTbWZ0N1I2Y1VSWE1HV1FqVzNC?=
 =?utf-8?B?ZGJGR2VRREk5YU1FQzU4Ym9lMytNWkc0eWJkT1orTWd6WXFJcGZLOWN1TzlN?=
 =?utf-8?B?TTFSUmVESnpXOW5XamFoY1c5clV5NWJrZXpOMytHK2VmSG5uN051OUErb0xJ?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5F29A43AC4DC8479F96C4D12A9BBBC8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caac9659-823b-4b96-7d96-08db03cfc01b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2023 21:11:41.9041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fmQfsoZNvZFDnJXeWwk3MWGxFtHUx1OqmpIvdDnIhLoUEeFBFfBhx1iUJlohxn/AJ1LqhY+32bB9/fyv46XDxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230131_131147_828732_5230C7CB 
X-CRM114-Status: GOOD (  11.44  )
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

T24gMS8yNy8yMyAwNzo0MiwgTWF1cml6aW8gTG9tYmFyZGkgd3JvdGU6DQo+IElmIG52bWVfYWxs
b2NfYWRtaW5fdGFnX3NldCgpIGZhaWxzLCB0aGUgYWRtaW5fcSBhbmQgZmFicmljc19xIHBvaW50
ZXJzDQo+IGFyZSBsZWZ0IHdpdGggYW4gaW52YWxpZCwgbm9uLU5VTEwgdmFsdWU7DQo+IE90aGVy
IGZ1bmN0aW9ucyBtYXkgdGhlbiBjaGVjayB0aGUgcG9pbnRlcnMnIHZhbHVlIGFuZCBkZXJlZmVy
ZW5jZSB0aGVtLA0KPiBsaWtlIGl0IGhhcHBlbnMgaW4NCj4gbnZtZV9wcm9iZSgpIC0+IG91dF9k
aXNhYmxlOiAtPiBudm1lX2Rldl9yZW1vdmVfYWRtaW4oKS4NCj4gDQo+IEZpeCB0aGUgYnVnIGJ5
IHNldHRpbmcgYWRtaW5fcSBhbmQgZmFicmljc19xIHRvIE5VTEwgaW4gY2FzZSBvZiBlcnJvci4N
Cj4gQWxzbyBmaXggYSBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgKHRoZSBjdHJsLT5hZG1pbl90
YWdzZXQgcG9pbnRlcg0KPiBpcyBvbmx5IGluaXRpYWxpemVkIGp1c3QgYmVmb3JlIHJldHVybmlu
ZyBzdWNjZXNzOw0KPiB0aGVyZWZvcmUsIGluIHRoZSBlcnJvciBjb2RlIHBhdGgsIGJsa19tcV9m
cmVlX3RhZ19zZXQoKSBtdXN0IGJlDQo+IGNhbGxlZCBhZ2FpbnN0IHRoZSAic2V0IiB2YXJpYWJs
ZSkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXVyaXppbyBMb21iYXJkaSA8bWxvbWJhcmRAcmVk
aGF0LmNvbT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEg
S3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0K

