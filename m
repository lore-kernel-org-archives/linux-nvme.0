Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39B3C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 02:34:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF9861056
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 02:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9FF9861056
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vzm2Cp161T2Yb6vOK/wtpeqzAKLAHmOhI6X9I/5P7VA=; b=eoOqb6CmNfdORumrCAF2Pnl6G9
	kqdRmGHG+9subK/sQzPz3vyOm5Ef3AEPiO9JB+DJAQCvGLEJo6N3sQ4SNFilbb6Bms2W60/m3ThdH
	jLNkGZncN+XCbznLTKFUdNMgYScS48A/eMfHIt6J1vhPftQfwpK/O48VgOxrj1Tmza8sCRqc2d/Qk
	za+NNHljOjZh6dERo8sbX3sP4Q5wn+HziwCOMcqDGP9vjR32fUh//5sCB2Fpvlb3UPO7MwO0E5o8j
	Ic9nfsZGG8lXI10CXC9wlAMUVey0Ip0c/b9ZUr0MJtl5xNxWQrxz/jtr/p0ESNPYjEBkTSMZhqYiT
	E91fiy7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmRp9-00EH4s-C4; Mon, 15 Nov 2021 02:34:23 +0000
Received: from mail-mw2nam12on2044.outbound.protection.outlook.com
 ([40.107.244.44] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmRp6-00EH4V-HI
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 02:34:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLfQiJ1VhFkSSoI/YqIBC71wHgvyWP8mR17zzp768XBSQlU866kyATAMduA0OteiqBIsS4MsA7Y451svh93lG8NX8EwpPrVIKHvsXqLPe3sJrSE613gVVUX8d2X/Pn4WudKAPaATu3C9xELhCZM2INEoQJD66MIZUAqCR+fueCurObiBRVMOtSGZWt/C4AB9jqX2qYJuqn627YVGxpciMxyhpCqIuWVTp2Jj4Sbs0aMK5uA7wksmhiEm6chrNgF9tShDU3cSR8UwpiO/UminwnLXxOwldrsfy0UXoo2KH1C5E0WUE6qZUHO/y/hQISDmDRdNwKw6OKVo5xLOe60mwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vzm2Cp161T2Yb6vOK/wtpeqzAKLAHmOhI6X9I/5P7VA=;
 b=W1t+sJnkteSORqQ25NcpFpSfUPvvikE+Byd9am7griSgQMBlY+TLfmr+M6p9AuTZKhUQTYfmkVeCy+ONlP+4SbDi0KYZ96hgnuA8AzFCvI5xSWNm2MY6Omupa983cozovQhP4Adm4g84eudDLkZMSUa8SGP/rbhPXAJQBW50IXqvyD1okL9Op9/4uKExuvytML1yf2BoAAEoMwhRml5pNXrp01N/chTNFP0ZKIJ+4NMBSPwUBj0SfpbYfUdirRVvYYEwkFY2wyXM2As8QIlcbjDw90hDcEwjsQ0PmbaLYKaDk+2AP1qUtjzYrORMgnrGlMS/p19yn9CAmfFwKbK4UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vzm2Cp161T2Yb6vOK/wtpeqzAKLAHmOhI6X9I/5P7VA=;
 b=uQb/rZhvndEkwMTiep5vpnS/PrESMPDvGn4dNZXhDAN5JFaMStu9zEIMv1k47xq2pUQVm/iVUjH2ngKida657b1ylXYx7AxUULe2oR+mEoXSroLYmssnwpt4XwJX4+ZTO6RH/B3xNe334lwA/l1OdAM4SiZKoz3u+pBLxoBURV6cBHMHo28z+u9es4ooqgMmfWJ0wNx5dKXkqCeslTIXR2gbwazeUo3cDte+mN1C49e+os+xMqn7w1Z3aMRvgAsLayKp9GBmXT4ih1p3C5nqMY6Q4Y1TZgI/csT4PhFgl11UYPshuEQPukQzV6ukN+7Jf/jIZQtFzlluJYQGsvtbQg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR12MB1328.namprd12.prod.outlook.com (2603:10b6:300:c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.27; Mon, 15 Nov
 2021 02:34:16 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::c961:59f1:3120:1798%4]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 02:34:16 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>, Omar
 Sandoval <osandov@fb.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/6] nvmeof-tcp/001: simple test for nvmeof-tcp connection
Thread-Topic: [PATCH 1/6] nvmeof-tcp/001: simple test for nvmeof-tcp connection
Thread-Index: AQHX19b79fpsBvrvy0al5c+0/wHp6KwC1dQAgAA3rwCAAA9HgIAAxhsA
Date: Mon, 15 Nov 2021 02:34:16 +0000
Message-ID: <0d5efcea-e72d-536e-2490-a334ab87a79e@nvidia.com>
References: <20211112144510.98523-1-hare@suse.de>
 <20211112144510.98523-2-hare@suse.de>
 <de1a1ff4-0c1a-6642-9d94-30b3d1cb0406@grimberg.me>
 <6a8fd808-8a92-3215-597e-7e094e753a9a@suse.de>
 <2679a2d0-7786-026d-c00c-8fc02a78c7a9@grimberg.me>
In-Reply-To: <2679a2d0-7786-026d-c00c-8fc02a78c7a9@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 290a4f85-7d79-4fc5-9ac5-08d9a7e06b88
x-ms-traffictypediagnostic: MWHPR12MB1328:
x-microsoft-antispam-prvs: <MWHPR12MB1328F14D2A6EFDC8564ACEA2A3989@MWHPR12MB1328.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7sqlOUmQLsgdcsLssWEUNmR4cZzDoNHuJnNeAS4DLMPLsHc1/tH0Sdr9sXHLMApyzi2ruZ2fCtJ9/VUf8LmTfITCcdhWTtc0Vzr88rDNk56tYcGBdwLAUfjNE2IDaSbFgBpFyT3LEnYnKIllyzhLyc4596Tw2960IK4xYfR1yS9STSsQ136KV9xVhoJ5Q68xnPFtLL+nzE66f1vFoUAY8qyTdL2lfRSl9xjTbHXIjPqJX9ihJspdOfvRphkAUvfHoL2JeNKBzCHY+0bFAWdPavqeQpgO4qrQ61xM7dB3fX9K0oHB+ECb5ZlXwffMC69MXP7TGd/ym5is9cnxxe7Q5mATwARybwiSeJa8Dh9bgs8rqr++qcosChnrmS2/tTW/BF/imNG2nmLFHrDoSP7Rcdo09LlYDLyEGCFPSXQDjQPTGxRFEIPWGkl/ZAqcSOexTgtDjorHq3g8rdqfwWsem6pD8Zf8j6jrlwkGg53iDCL81HAjFEd4RdzZRopkBPtPWJ6LuDpKe+ul5Y6VLYbfqCpdM0SjF34QtILMQPzfHcNgGTZJ80FsY2FZEye6JnI16QbOi9IonwyhAwHMAlvNtV2oSblbimnDK4PnqKJxqJE+BkN+pXkAnoLZMsjsVaWUS0MOV0QuYzHUrff2AQUsxe7/bgT0CNRCb1toF3iC8Y927Hh0hSuFgMyVEI74nOtSwIwkx5rORNPDUbbvKo4PnDzWxQ/zm/CpAUhDh0H8rb0s4yu3mvolNVPAJyOyfKfhbjN//IHWU19iYgpTwgfiUQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB4667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(76116006)(66446008)(64756008)(91956017)(31696002)(54906003)(66946007)(186003)(66476007)(66556008)(36756003)(38070700005)(31686004)(6512007)(508600001)(8676002)(8936002)(5660300002)(2616005)(316002)(71200400001)(6916009)(122000001)(2906002)(86362001)(6506007)(53546011)(6486002)(38100700002)(4326008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODNGeSt2ZU5zZUtMRlNoZFl5YlpORjdDSDl3eXpqQTBKUW9LZ3JyUFRBVUR1?=
 =?utf-8?B?UUhsUGRIRElEMzAvVm13eEh2eDc0bGsvZys1UVdWcWdRTGxteEc5dFN3S2hW?=
 =?utf-8?B?R3kyR25aOE5pOTRSRXVDSldlbno4K2xEL1UrNVYremUrQmF0c2VVSUE5d0tP?=
 =?utf-8?B?dEFBSyt4VGZkc3RDZ29adGdTeDJVeEljZFJ2c3l3WFdJVFljNWx2alJDamQ5?=
 =?utf-8?B?U1BidG9IanZGU3oyWjlYTTRGTDkwSTA2WUxxWlQ2c0dxcnp2R25zNlFmQVh6?=
 =?utf-8?B?SWFpZklkcC9CSm1HaFNyVUx5VlFHVy8vVkJESy8rZFBwSEN1VCtFeGtCekM3?=
 =?utf-8?B?aW1UQU5hYm5UdE9sZDRmd0tIdGZCWk5IUld4d3NNN3E2MUpTTmxBZ2Q4ZWF2?=
 =?utf-8?B?OGM0NEJjRktLbWU5cUJEdGJkVG1hdG5pa2I5UDBBczF4bnh5TFIvQmJySGJq?=
 =?utf-8?B?VnhUaFNFZ2lzckhjNllRKzZRaHUwaVRTMUgxNEVzWkxJM2dNMm9XaXMxMDM5?=
 =?utf-8?B?RVlRUWJRcVhnQlMrL0x6MUxUejJ6OFlWdkt4TWZlRE5MZXpjekJJL2VmVXpQ?=
 =?utf-8?B?ZVhBRnVyNjFkNU5tM0tray9qVEZGNFZ1c2tENWE0aVJNYks5ekdKaVNwTUZR?=
 =?utf-8?B?aE9UZ29STHFaSHZlSlNEeno2K3I1eEVUcFBYNC9TK1RHeFMvcFpYa1gvNkZH?=
 =?utf-8?B?RlN1QURCcloveFJYcW5MY0RhZ3MvdHJSdGNMb2paUGJVdTk5eEpDM3FJRG5H?=
 =?utf-8?B?cDBkZkZwZ2tDay9PM1FxNG1Yc3J0cHZVa2c5REVFekF0VWVQbXpaN2JlR3RP?=
 =?utf-8?B?TG4rU09DR0lWeUJDUnB2b0lKcFFBc09kdjlTNnZoYVNQYWZGRW50UlVDcUsr?=
 =?utf-8?B?bnByN1ZoV1dJMzc0dmEvY3U5YmNCRDg0RmNSL3BERTErYjIvQ0RCcWMxaWdI?=
 =?utf-8?B?OGV2QWlWNkFFRm5jY2lTai9oWUFobU5ZYS90SVFmUURJTkZmeVBLUUdiMHdl?=
 =?utf-8?B?eUJEY1J6ZTA3WWJMeVYyNXJqMHlVRXBtQ2p5NVJNK1N1ZFhWblVVM3JSOGta?=
 =?utf-8?B?Zy9qSERoQ2xMeFQvaGc2VENYdENXcEhHR2djNDVsL3FEczFsNE5zMVppckcx?=
 =?utf-8?B?NWVwSS9oenBmT0R5VVk2cUdkS09GMnFkcExJbC9kYTkzVk12UlZpenFranY1?=
 =?utf-8?B?ZkFKWE9iK21pWEpobE92cHhPc2h1ZU5IZS9DRWxGZFRzZXllQVNnbkZJZjJE?=
 =?utf-8?B?YkxWcVVTUUdqcTZrMHV3UnZiYzdWN2dHUFdaaFJIaXRabUp2UWJUTnJIeEFX?=
 =?utf-8?B?WURobllIazdsMzM4SS9CUWhtNlVKUjRxRm1IODVhMjF4bTVjOFdDUlFJRjFO?=
 =?utf-8?B?RDJMcW5DS3R2MVhhYVgzUWtXeWNIYmdDT2dBSzVHelVkU1J6R3JTcWdXM0Jz?=
 =?utf-8?B?UFNlNFVSZ2lPOVo2dFB2cnJ5czBmRldDSHFQRE5JSC85MEpDZkFRWkN2bjlx?=
 =?utf-8?B?QmdzeTh5SmxVQzlmY1JwYVNBNkM1emh6Zzl2K0RtUXlhcDdkNmpYMmdrYTdn?=
 =?utf-8?B?RXkwUEJkVllZdXM1VGpEbUJJSjlNTXpubGc4Rkg1d3M1MlJHelo5TVRUM1JU?=
 =?utf-8?B?a3JudEQwUHA0bmZ3aVY4TlVtSFVZUy9aRkdjTWtPMWRyaCtQVHk0TG90dHRt?=
 =?utf-8?B?Y0kyUVRtRHluamdWNVNQekxnREFrdXA1ZGI2cWtwWVpFRmYvVzJJVnlXNjJB?=
 =?utf-8?B?TlMwKzQ2SGV1SEpkd3BoQzhZY29iRTkxR2FubGxnT3lvN21YK1lYQkQ0YjhJ?=
 =?utf-8?B?SS8wVmhpM1hQZ2trZnJEUzdWbTNxVXZla3dYSU4rWTNDSmtDZDEvdFFHL3dE?=
 =?utf-8?B?M1VPMGZBWG9Cb1BvNGlxMHhUc21vYmlFcjkrdStpbTBxRDNvV29BSmpXVHo2?=
 =?utf-8?B?QlRRTVhyQUd6aDZuckxuVEJTRzNVbzA3TEREc25RMEtlQXRiTitMbXMwTU5p?=
 =?utf-8?B?Y3h2b0ZQQ21XNktlN2FDaHdXV1dZTFlkUWVyY0prSHhYbXRLSUZRV2hxbTRt?=
 =?utf-8?B?Nk5ZK2t0eUFnVFRaT0dTY2NCUEM2Z0VMeWpJZXh4WTJUWHpHZzFEQVdoRjk2?=
 =?utf-8?B?emo2Z1BMZVBBZ2dlb0l1NGZBc1VGd3lpZ3VWTXlLT3RUbVhBZnU4TE9veXFa?=
 =?utf-8?B?Ti8zTkQ3KzZ0cjExSnc2RnE3RWVqSUJlUnB2NFlNN210RVd3bllzN0hlKzNW?=
 =?utf-8?Q?QX/07aYQuXEquEfgVP98TdSuuqPzx0dTl3eSM+Xasg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <53AF225CCCDDA54D88889C0B42D672AC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290a4f85-7d79-4fc5-9ac5-08d9a7e06b88
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2021 02:34:16.6794 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UwsxAO+vd0kb/lufmhzHo8bbinI0Yl5B0heYGXyqHC3rd+Ce/fcqHIcJp1AXLYoN4Q6Dy1/lfZ0ouyyrxiV9og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1328
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211114_183420_815370_04113526 
X-CRM114-Status: GOOD (  21.85  )
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

SGFubmVzLA0KDQpPbiAxMS8xNC8yMDIxIDY6NDUgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+
IA0KPiANCj4gT24gMTEvMTQvMjEgMzo1MCBQTSwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KPj4g
T24gMTEvMTQvMjEgMTE6MzEgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6DQo+Pj4NCj4+Pj4gU2ln
bmVkLW9mZi1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2UuZGU+DQo+Pj4+IC0tLQ0KPj4+
PiDCoCB0ZXN0cy9udm1lb2YtdGNwLzAwMcKgwqDCoMKgIHzCoCA1NSArKysrKysrDQo+Pj4+IMKg
IHRlc3RzL252bWVvZi10Y3AvMDAxLm91dCB8wqDCoCA2ICsNCj4+Pj4gwqAgdGVzdHMvbnZtZW9m
LXRjcC9yY8KgwqDCoMKgwqAgfCAzNDcgDQo+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPj4+DQo+Pj4gV2h5IGFub3RoZXIgZGlyZWN0b3J5PyB3aHkgbnZtZW9m
LXRjcD8gd2hhdCBwcmV2ZW50cyBpbmJhbmQtYXV0aA0KPj4+IHRvIGJlIHRlc3RlZCB3aXRoIGxv
b3AvcmRtYT8NCj4+Pg0KPj4gVGVjaG5pY2FsbHksIG5vdGhpbmcuDQo+PiBCdXQgYXMgSSdsbCBi
ZSBsb29raW5nIGludG8gdGNwIGluLWJhbmQgX2VuY3J5cHRpb25fIGFzIHRoZSBuZXh0IHN0ZXAg
DQo+PiBJIGZvdW5kIGl0IGxvZ2ljYWwgdG8gaGF2ZSBhIGRpc2luY3QgZGlyZWN0b3J5Lg0KPiAN
Cj4gSXQgaXMgdW5jbGVhciB0byBtZSB3aHkgdGhlIHNlcGFyYXRlIGRpcmVjdG9yeSBpcyBuZWVk
ZWQuIEJ1dCBhdCBsZWFzdA0KPiBjYWxsIGl0IHNvbWV0aGluZyBlbHNlIGlmIHlvdSBtdXN0IGhh
dmUgaXQuDQo+IA0KPj4gRXNwZWNpYWxseSBhcyBJIHN0aWxsIGZhaWwgdG8gc2VlIHRoZSBhY3R1
YWwgdXNlLWNhc2UgZm9yIHVzaW5nIA0KPj4gaW4tYmFuZCBhdXRoZW50aWNhdGlvbiBfd2l0aG91
dF8gZW5jcnlwdGlvbi4NCj4gDQo+IE5vdCBzdXJlIHdoYXQgeW91IG1lYW4uIEZvciB0aGUgc2Ft
ZSB1c2UtY2FzZSB0aGF0IGlzY3NpIGNoYXAgZXhpc3RzDQo+IGZvci4gVGhlIHNlY3JldHMgYXJl
IHByZS1zaGFyZWQuDQo+IA0KPiBQZXJoYXBzIHlvdSBjYW4gZXhwbGFpbj8gTXkgdW5kZXJzdGFu
ZGluZyBpcyB0aGF0IHRoZSBleHRlbnNpb24gZm9yDQo+IG52bWUtdGNwIFRMUyBiYXNlZCBhdXRo
IGlzIHRvIGF2b2lkIG1haW50YWluaW5nIHR3byBzZXRzIG9mIHByZS1zaGFyZWQNCj4ga2V5cywg
aS5lIGp1c3QgbWFpbnRhaW4gdGhlIFRMUyBvbmVzIGFuZCBub3QgdGhlIGRoY2hhcCBvbmVzLiBC
dXQgbWF5YmUNCj4gSSBhbSBtaXNzaW5nIHNvbWV0aGluZy4NCj4gDQo+PiBXZSBjb3VsZCByZW5h
bWUgaXQgdG8gbnZtZW9mLWF1dGgsIHRob3VnaC4NCj4gDQo+IG9yIGp1c3QgYWRkIGl0IGFzIG1v
cmUgdGVzdHMgdW5kZXIgbnZtZSAob3IgY3JlYXRlIGEgc3ViZGlyZWN0b3J5KS4NCj4gDQo+PiBF
c3BlY2lhbGx5IGFzIHRoZXJlJ3MgdGhlIG52bWVvZi1tcCBwcmVjZWRlbnQsIHdoaWNoIGFsc28g
aGFzIGEgDQo+PiBzZXBhcmF0ZSBkaXJlY3RvcnkuDQo+IA0KPiBUaGF0IG9uZSBpcyBmb3IgbnZt
ZSBhbmQgZG0tbXVsdGlwYXRoLCBub3QgcmVhbGx5IGEgbmF0aXZlIHN1aXRlIGZvcg0KPiBudm1l
Lg0KPiANCg0KDQpJdCB3aWxsIGJlIGdyZWF0IGlmIHdlIGNhbiBhdm9pZCBjcmF0aW5nIGEgZGlm
ZmVyZW50IGRpcmVjdG9yeSBhcyB3ZQ0KbmVlZCB0byBtYWtlIG1ha2Ugc3VyZSBvdXIgdGVzdHMg
YXJlIGdlbmVyaWMgYW5kIGNhbiBiZSBhcHBsaWVkIHRvDQpkaWZmZXJlbnQgdHJhbnNwb3J0cyBh
bmQgbmV3IHRlc3RjYXNlcyB0aGF0IHdpbGwgZ2V0IGFkZGVkIHRvIG52bWUNCmNhdGVnb3J5IChu
b24tbXApIGNhbiB1c2UgdGhpcyBhbmQgZXhpc3RpbmcgaW5mcmFzdHJ1Y3R1cmUuLi4NCg0KDQo=

