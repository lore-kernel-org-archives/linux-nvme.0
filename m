Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A63CC43334
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 23:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5JiVDTgt97bZvqj5gOPtpj4nq6taLapYVeWu6MvdD7Q=; b=0ImMESF7syukCwMc22jMHouIp2
	7YaOFOKHdDse836inyGH9AaODhuOqHUh9bTF1H8whTBt9jyiudJRv3AsuU/MUFSvSldg2uG0O2Gu7
	H54ddEeG2CEbYoZEifQWJiWmOC1jsyCoEMNzxw0WJTEVadBvBfBskypRR2Wt0UJjRWn8DtARM+dXo
	EFxJIqQNrDzz3WY7TwuKa0ptdg+2A7TEGakSZlJ8uZ2hNsRlUbVNaNNnoNjA3Pko0K7/i7Jlpqt1G
	kd2gzJ99k4GKYUXO8pN7tmnuXi59TvxT/C8ih+eSKXhfwODt4AdrKMTrfMGBSKAAWPgky5VtKYmqx
	poO+kKsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDaEw-002jEX-Hr; Mon, 18 Jul 2022 23:33:26 +0000
Received: from mail-bn7nam10on2055.outbound.protection.outlook.com ([40.107.92.55] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDaEu-002jEA-0v
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 23:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLVrTH8JxJ9ZpfwDHwp76rLTnNU1z+YTz7VJ25RWiDjMouSz/PoT6hV+w+wOFcOa2s4Ur1mFbnHgU4r6GX0h4NA9gWzyiByh8FweZFWVRYelXQc/9gS/ai+mB3HlEzMTFl4wJrDnrvK/suzlPlmKroWBDVSxuVCjl2/G/SCKTD23fCy7WAvKELJ+XdHlyDRT8w9SAOIx2V7jPr4NtYoSf67HAC5L3sQve/6r8OxpBPMKbFq7KLzbm3WoDNK1GbmE7rXiMHkrYxpyObWORj8dFjTIgveSPeIA97zLZMCiUq6ggcvSMoZbiwgd8F6JgjYTeYXHE8IQnoISXz58mhmEjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JiVDTgt97bZvqj5gOPtpj4nq6taLapYVeWu6MvdD7Q=;
 b=O1RY2wJsgBw97+P6QE8ycT/tgvyr4X/7FcoK9HQXfwNKeAzDImpMOtKTRwgJQxB8TKvgczKTLCY86nBQbq0e3tQUjRLjiQQhPh/dh0kM9jHY8uX+i0Zw/FKIM9z6oL9Q7Bx/f4njkAhvaJRzPznXwEM+aXgs7B+xcYgo5mqgYIAU1RrIm1yl7rVYi2m0qgNXbIml5X+G80Fz2btSR9oUkw4+QQr/xMzjxQpz2tQcRWbl7BPsqdTpu3fypiEXkzmNDbWJmMPAPOOPK/yB6USr23iho20v1lEdp24jZhxRWuze9PbwdyC/8jzNImXP/rcn3RbalL5BLAglivSLHwZOtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5JiVDTgt97bZvqj5gOPtpj4nq6taLapYVeWu6MvdD7Q=;
 b=ldbgS5XmWdcMPxof1ORV0eypKI9JPUfy3wTo+uTdh3hYBj6zMQHhtNKsCzY7PgNEnEY2GtkOHK0ARH0Yx6nMbi7Feh+O8MovpPfvmblZ+R0cryRb+6GupOtVIAh+pxYc7uLKPbhxHLj5dOSbf2zlGrewCQzoPioQpeA4+64hlcMskt9/eFIPM28WNz/sPcW/Sqk/jQ5y3DI0EFuVo0xOvLd6Lqzf/jfiZgabRJ10JrkGHzeG8Cf4RSB0j6EbuyTeK7i0SpaANjv5mS64hAY/LQsfJ2nrE7eigFpk70SwNOTAUQym3WOqLUSu81pvjDo8WfTFmgVnD6BMCBpe1gq8Vg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM5PR1201MB0249.namprd12.prod.outlook.com (2603:10b6:4:57::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Mon, 18 Jul
 2022 23:33:18 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::d01a:8f50:460:512%5]) with mapi id 15.20.5438.023; Mon, 18 Jul 2022
 23:33:18 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>
CC: "shinichiro.kawasaki@wdc.com" <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: NVMe In-Band Authentication blktests status
Thread-Topic: NVMe In-Band Authentication blktests status
Thread-Index: AQHYmv7CoKmZfXV9NEWBBHTpa/U3uQ==
Date: Mon, 18 Jul 2022 23:33:18 +0000
Message-ID: <e647c133-f54d-b731-3fc8-1f0b523aff42@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2761fc49-9771-4b2f-58c5-08da6915e515
x-ms-traffictypediagnostic: DM5PR1201MB0249:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  euC+W9v6fRU3ul4t/AxAeDE05e34ececLh+k2A5X/MnwglB0RTIB/Sfzy+VH2Arq5qDcLewHz1Hq+DqRVL1H3/Djz4QUE+QsFpvGHCuI4ZVrwfwLf2Q8iuAIXrvMMNS/oTxPKf80FsE4PE7bog99DwMkALTkWEdvPXg3t0wFkgPTu+tifoQSB66UfCIPYLG2HRYEi+d39DJgH43cITyUfahm8/V8OQY+8LyTPgSdqfhPzPbzDRMuWUKgW4+DM+Te6ziHQtUg078yq4eSXF3mVTBmatiGc5eFNyORpcmjwiuoV814q3C6H5pSzu9QaQ40Ps1QvZp4by2xabLF0v5kzofocIUIEDjgfuNh4XAMbrSe6ZMrtntYje1j5eodxUE+0JHLXEheCirksemAuf1mhAMHdHcadba3o/Cciw7VIxF8TUlAjR/27g9C4PCTGGNAQp9DzMEOR21CELu4L3T6/xY4BEHNSQxfJ0XSVKxSxppiXn6LRmg3J0k4GC171n/GtGaCCpo+CwXn8Wx14KQd+shYPRwiPJ3GBqsoLeK3FW2O3P3nB/hqHx/m+8CpnMrjVpHEJ/790Ij/9nh+u4gGiELWuQFdw3L8bqcZG7+FoM+3LqRLgcdgVYiLjVNyGu0cDJZ5zU1gUjv9BHK6L1ChWvgLiUxjHGgFcuexP7Xt8M/YYxsFqZgE+2SO8UR2odrW5dwP9+znbaKWSPT0x8XK6W9vImX/6X1LHHHL1+bt7T4l4hOPgMm9m5Y9mxihMsB2BOMx6CABRGXhiwaC0zwOKECN2WwFmLelUEb3rb+0IqC3JhKEM+aLInzXmMci1J/gad37hvXCkjoy7bOH4YHhgldScoOwHj0iFXLIecc93Cc=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(6916009)(4326008)(54906003)(5660300002)(8936002)(66946007)(76116006)(66476007)(64756008)(66556008)(91956017)(316002)(2906002)(8676002)(122000001)(31686004)(558084003)(38070700005)(31696002)(86362001)(36756003)(38100700002)(6512007)(6506007)(66446008)(6486002)(2616005)(478600001)(71200400001)(186003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?amdsSzhyb0JhYUE1SVFmRDJsMVEzdFhCSkEwTE1EbisvVVRwd1NHM3haTVQz?=
 =?utf-8?B?SlQzVjNQbVFyb3JnVlpLNkdncE1YTlByZDAvclNXVEdCRm1KeGZQbjV5ZmIy?=
 =?utf-8?B?OHA4QjdySWd5MUVBSUgreVNUbEZkOEh2Z2lVNzJFOHBPWi9uYTY0aDd2OS9N?=
 =?utf-8?B?aDdkL1hMR1J1NXRENnl2TmFWaGN6eThUdWNmRzhMQUxCN1lBTmxtUjVLbE16?=
 =?utf-8?B?a1h1OGRDTWFIU1pnWE1LbCtZNmQ2dmZ4TmdEY1Z0eGxJalJ3alBlSC9SRVRa?=
 =?utf-8?B?VVl0YURzNEtTTUpjaW5tU3BabkEySmM0T0lmbUxIYXJiMWthelNjUkRqWFJa?=
 =?utf-8?B?YnB0TjdwSVAvbGxMZWxqV3l1aWFDQklGK3dmd0grdW9yT0t0emVZSUlUSTVN?=
 =?utf-8?B?Wm52dkMxbmtHYVg0aExEakQxSmNFbm5Ca2Vob0c1SjQyK29GN2kyU0w0MllW?=
 =?utf-8?B?Q29QVjB0OGk4Vk1YMHJqMVVLWFBYeE9QNmV4TE9pekhQby9tdVJPdEJTbXlL?=
 =?utf-8?B?OWhldXpUQkt6MnFLQVVBTjRuby9xV3lPY2prSHRLcEE0alNTTU85KzJZWnJ6?=
 =?utf-8?B?SWJLNEdCMUdWZUhpRkdmdjZ6UkY3dzNmRXhFbUZKZ2lXZmk2N3prV0VMRm9X?=
 =?utf-8?B?ZHJQOGxpSUhrTGhLSlVSQTI3dTd1RWkvUVBRZmVaV2xSaHZTdUo5UHhuS1lI?=
 =?utf-8?B?OEFjL1dWUzZrUDF3RFNpcGVlRUYwSkZ1ajJWdkVCY0hHU0xnZ1JUNlc0Nm1q?=
 =?utf-8?B?Tk1DZStHVHBpOEg3Wk5DT0pyNnBhcTNVNE4yNGJvU2ZRRExGcHhnNmZjNmt0?=
 =?utf-8?B?UEoxOFAzQjc3RUM3Z1cwRTUxSTFCZ3Z6VGxIZXlBUkJ2V0JNcWlJRXNud3hG?=
 =?utf-8?B?OVI1dGNIWVBmbzZ4ZG9qeWc1eVNlc3BwZjhRSjFoTzJyR0w3YXFQcG1IalpE?=
 =?utf-8?B?aTg4QkNYT3pVRzlvUlNFZDltQmNlZXJ4dlptNXd1WDJ1ZDhIc2w0em9RR2w5?=
 =?utf-8?B?ellnTTBWV0FLNlQ2clV0cmNrNlZCdWtDRmV3MEtLcVVjUmVzTWM0UGhiNEdS?=
 =?utf-8?B?VTRqWjZhTkZSbkpzRk1nOXFDUE56eUdYR3Z4d0ZGOXRIWUVWZkxpZlNROHk1?=
 =?utf-8?B?RWRMWE1ZL3pRSWNqV3ZlbXVvODBJWnBXM1UrQ2lraWtkOGs3bWhtV3hIckNj?=
 =?utf-8?B?Y0lHQktmRlh6UlJ3ZmF3Zy9HRnh1ZVZkbHgxYkUvSTZ6c3NZVURiRk9QZUFN?=
 =?utf-8?B?OG9lUHNQQWZ0aWcxMThyRzBqWHMrRWlvZmhCc0JUYkgyUENWdzVYanVuTkUw?=
 =?utf-8?B?UmJ3bnJYVXRNK04xZ29zZDBzQXVCTmt3RGpHK2YwY21GNFNuazY4bjNuaDhm?=
 =?utf-8?B?RWNhV2x3Tm1mblhxcGNZOUxRQWJKNklFNWxvTGlzQmkxZkdGNmw0b0thSGlW?=
 =?utf-8?B?M2RFcGtNYmx1RzkxUmM3bVFTZ3pqQ1NSaVlHWEVpdjgycXZwSmdJT1Q1dmNV?=
 =?utf-8?B?dE9GeDNqcWpyTkNaNFB1Q012L1lOb01VLzJxa1pvTXI1VkVjNjE2TGRvU1N0?=
 =?utf-8?B?ZE5ENlZ3aUZRNEd0QVE0RHduRjFnMVIvbjA3TGVCL2hLVVFsdzRrVTdnbk9T?=
 =?utf-8?B?T1FreldOZEdWRWQvb2c2aHFhZkdrZUwvdGpxU0ljZjZleTluekYxSHFTYmJu?=
 =?utf-8?B?VDV1emMzV1YyWkJvdnJtWHRYYXFkWHpHOFdndGtiZU9NS25yS0U0UmlrYVJN?=
 =?utf-8?B?bVVCS045VG5WSlkrVlF1KzFUb2dROEtPbmJ3YTE2aEpqWmFMdHBZdXllZUtD?=
 =?utf-8?B?SitoQ3d5L1hlbzgwdFdUTVJYSEpZZFdjY2N4Q09GYmhqNm9OdFA1bEpCWk5Z?=
 =?utf-8?B?Z0hFcWZLV29BaCtRSkpkVFZQSnJlSEZHOXNkcXlqZGY0aitIYWpuRjVXRnZX?=
 =?utf-8?B?SW83NDVIRk9PUDJjUkpXejRJYTNZN1BYNnh5UTRDQ1FYdlZ0WGtsMjJaVEYv?=
 =?utf-8?B?c3lyaEkwNXpndWRnRXFpWWdCWVZJWmxCUVRKQ0NhTm05MmdpOTg4L215Nm5H?=
 =?utf-8?B?UlQ5RXRCdzB6NE1XcFlqUTRZV1VSUXRCckhUK2FoaHBLM1FqaU45eGhPaFFo?=
 =?utf-8?B?L3BaSTU2R2x5RGR5aVY0dFV1aXZ1bG9yTmF4ZXZZMmhiQ1kvU0lLd3dHZllr?=
 =?utf-8?Q?XEw6c2/pISq3GopWzpJTWWZ2ZgOLxnyE7v/wXaZuJXIH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2DECF08C9913240B71AAFEEE4851E81@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2761fc49-9771-4b2f-58c5-08da6915e515
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2022 23:33:18.4801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5DuE6om5pILjACbQmvY1nDV9sQ+RzGCvRGc8YNmTK3OQBHFBpPTTgr5rNsPZBQPqSjwSVV07MgmFXzwtQPMpxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0249
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220718_163324_090135_92AB8690 
X-CRM114-Status: UNSURE (   8.08  )
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

SGkgSGFubmVzLA0KDQpJIGp1c3QgY2xvbmVkIHRoZSBsYXRlc3QgYmxrdGVzdHMgYW5kIHNlZW1z
IGxpa2Ugd2UgZG9uJ3QgaGF2ZSBpbi1iYW5kIA0KYXV0aCB0ZXN0Y2FzZXMgaW4gdGhlIHJlcG8g
KGNvcnJlY3QgbWUgaWYgSSdtIHdyb25nKS4gQW55IHBsYW5zIGZvciB0aGF0IA0KdG8gZ2V0IGlu
IHRoZSByZXBvID8gYXMgbWFueSBhcmUgYXNraW5nIGFib3V0IHRoZSB0ZXN0cyBhcyBjb2RlIGlz
IA0KdXBzdHJlYW0gbm93IHNvIHdlIGNhbiBydW4gb24gZGlmZmVyZW50IHRyYW5zcG9ydHMuDQoN
Ci1jaw0KDQo=

