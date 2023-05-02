Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F0DC77B7C
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 02:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vsMwVEZAzGi2B17vMjZ32AcKS8Mx8Jqo80KYiQQzodo=; b=hB7iI64gpGFjS+B9QLnVBRMWr6
	A6wuGYFVsHPZv/FmaMosvMNjnaa62Cfb44v/OinB8xgzLqbsBG8sL6J5oRBFJSt9+aFO6NFHc0XYA
	qsenpC4REM2senmcm2LnxC5Sy2Wfa1xjn88oLwK1CdRHYtvtWRMnQUYL0RdL20nfW6mkjSreLrhbD
	m6BgUqkTxSU4277z3AMpzEbDdTPAlx7jVIDnakHFyv2R2cccsCbO/bVi2m3or7zHv5bji0U9piKOe
	RemcjTKIZbn5Lki5BcvIqPUUGlc/S3hWsR0DpZprBU8NT1ijEV3+Jp5g6XdZBpVsxoIrJN8yoniLq
	wBsDuUKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptfuU-00HUTj-26;
	Tue, 02 May 2023 02:38:34 +0000
Received: from mail-bn8nam04on20601.outbound.protection.outlook.com ([2a01:111:f400:7e8d::601] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptfuR-00HUT0-2a
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 02:38:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lLp5BQiSZdRzmJia3K4GrtEMJMWVHn5LTlsOGMMYiWM0ccgGD1ww38NXeE6wqyE20k0MucB/F3BVsEU+qn8rDkq5uKmBy5DQ+uymHJgtNHu/FgvpU1FU9EH8+QB1R3P6yv0yoK4IzRXFpwZ5uP5wQt/wFuhWuS7urIX/hsg18wFQ0W6dpp+YoPGkUEFt+pfk/oYMplrhBB89Pex8Y82E4N1AWF/6aZDH/Ac969VqLjXkoC9/ndGz9srBNynMx+6O8y/gZaKqDHMv0akiAWfzO9fJYsNtNAsxUxYn/NNJKEJh6hLySTMQI609/QmXaZf+DJ/ANaOUAaBspDyfxQTkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vsMwVEZAzGi2B17vMjZ32AcKS8Mx8Jqo80KYiQQzodo=;
 b=Ps+CSfvhYMOnNQIw5X2HWFkpfv84t3myXAKpF/xbNiHZrqfDwzALw78Gs14SHEuffIWM00RIbtEvkMpCQtLkZAN0coWlZ6Wvcr+4BYzrBAuKqNAOgGh5uLDbLOqquLBpeJ6TxidLbsXBtCeMQA0Rze85Tnovogjbu8T1OX4TkxWzX11FULSjKWRU5uR5syA3UO1T60FUashjF4HWrhUSlSLKU7qnjagiUB1xZ2rbbUJIPYXk8sAADi7/ilVkMzdj95i1f4FwCoO172Z96z57l1qkPvpdV+eeOGrw28SQXTEC+ez9qqgDo7hhAZz1LR63jtjBcxwUieQjUrgWcXfk+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vsMwVEZAzGi2B17vMjZ32AcKS8Mx8Jqo80KYiQQzodo=;
 b=on32esgwU70zZV9jxr13kw2NZeQuqtGKYbP8r8Gs0WrK65cWLhso2EgydCy/hgWMhYgCVrwJfyB/LpYtlDtOlB0TfTdvSsJwjZ/31uErPIujOufmAnXruF9ftLqDqb6jcgCc1McJuvLyg8tzw24n8ObPTRH4oue0OpJl+ZAlDFb102Md++P3Z6MAMzhCtY2bbkcpQP9HXWroe0yBvEfWzNxkD9fHWMAPfC3cTfJ/jtwMcGjJYYMk+1nri7Lkh+a5qVhTT1q3o7nxP6gQZoQZXB7g6Fu/9N8kSqaKGyi7Jkl/Gj1jo0HBbt4Arm3L1WHEUZPcPvTynqX+ZvNOFLWmGg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL1PR12MB5175.namprd12.prod.outlook.com (2603:10b6:208:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.31; Tue, 2 May
 2023 02:38:27 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 02:38:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, "hare@suse.de" <hare@suse.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [RFC COMPILE ONLY PATCH 0/2] nvme-core: dhchap_secret code
 cleanup
Thread-Topic: [RFC COMPILE ONLY PATCH 0/2] nvme-core: dhchap_secret code
 cleanup
Thread-Index: AQHZeN6jKkS1R5yvf02kwnEgHmXciK9GTJoA
Date: Tue, 2 May 2023 02:38:26 +0000
Message-ID: <12e4fa7b-eaf8-5cbc-f0ad-5bb2a251a00f@nvidia.com>
References: <20230427080207.17249-1-kch@nvidia.com>
In-Reply-To: <20230427080207.17249-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|BL1PR12MB5175:EE_
x-ms-office365-filtering-correlation-id: bba4e265-2528-4017-a254-08db4ab64edb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  nhohKmpv6MySpAe4/riEjCS12DnwHjDIpR1gdO04rpU0lgWwPfbgZzDflml8x7t3Iu/VKdEFuH1KJZJWQ3OMjY+xlftblxaKhgfBgYZ8Y41gGCw8JtRtJJl2pS56aCd0pf1XlpmUnnL3hTpbu8hYBjeMr2ZWsZDsPp1/sERa1ZOmsKUqPfUuefZ0xjybL8ZxJ4TlnQmncXW/8XQqMKtlLLLBLtRi4x1vzfFntKsITqJGesQhSsAmMc38DyVvAk0/e1aYqTZ7GXMBZeVLXHh5GoSIjNqUsTCdw5jjUiWLgRwQ2iCgtKtqyHm5NBwki86KBn/7J9GFJ6PbZzvZvOT9H2PD5fJ28W27QyCMy220w3a0m14gmK/UXl9s33ueCy8n4BmDSUf3eR3e9ASbsz3r3xoLEppq6fPbnXJkb+nX/53hpMCqVGm3ACGkydPzLFRNyf2CRUG1oda3/ZmWJQjVp+m9+phd2ZudviY6DPGp1ZummDZfWTD6YcNFJeDvNhkxmVDocUHB8gw5bpHk1zYJ7fxuArWG7zgsnesYXwPiUWaA3C/zZnSg//BGW++AyHc0jR1gTN+KF8Muno54YQ3neFJLJ5KzIvG8mVaOSVe3n7rTJ0CgNBrcP6Z7KXAK0AZRbAMOi54u1vyJSg7mzZearuB7Vzoef9ZRuxa1fHVYay+M1uc9IbVG+qcBreqnrhBv7zOlEn+9xzatbAidGWoDWA==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199021)(36756003)(86362001)(110136005)(91956017)(316002)(76116006)(66946007)(66556008)(66476007)(66446008)(4326008)(64756008)(54906003)(41300700001)(6486002)(71200400001)(478600001)(5660300002)(8676002)(8936002)(2906002)(31696002)(38070700005)(122000001)(38100700002)(186003)(2616005)(53546011)(6512007)(6506007)(83380400001)(31686004)(219293001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?dXN3RVpDb3VjdVl0S3N1Y2YzMGoyaldReHdNLy9BSytISkhMaURnYzI3QXVD?=
 =?utf-8?B?NG1zQU04TUV0RXo1VmtOREpPSWtCYk1LMTlPcHcxZFhheStGK1hJeGs4cTdY?=
 =?utf-8?B?ZUJTaGRpdFFYVG1HbmdFaXk0Zkd3KzA2S2MrcTEzUFVWK2JyWlJiakFHOURT?=
 =?utf-8?B?dXNHUTU2aTJrTTlrTVRJTlNpU3pIS2oxSU9naUtRZnZObk9SWDc0aVZaN2Fq?=
 =?utf-8?B?RUhXTzJ2UWJwNm9mMGdxaDdnK3V1cXN5SU9SalVpOTI1dHg4MHh5b29TbmNE?=
 =?utf-8?B?QWhtQ1dya00yZEJWeXNlK1VQMUhIc05TRnNYbklDVlM1Vy9ZRmx5QnJmUldn?=
 =?utf-8?B?eG12T0dYUDAzSU5kSTNlRkJway82cUxjeGl5Q1dOem0rNXV3T1BOY3FpUGow?=
 =?utf-8?B?d0dyUWpHZUEyWCtLOXRWQWZOdXg1TmZBR2dZWFF1TTg3Y1pFUFlRYUh5Tktm?=
 =?utf-8?B?TEQ4dWZBNWJpdGUxU0tXWW1raXIvWWFkbmhwcjN3MExReEpjNGMvT2hzZ2h2?=
 =?utf-8?B?MmJ4aW5jbEdqMW1GQzFHUThUZGcxaXFWRWx1N0tXTXh3QVkwemFub2Fiemww?=
 =?utf-8?B?T05JUEo4Y2pDaVF6d0N4UGNBMVlUUFRPYnRoOFgwR2k3NEV1Y0tQUjJBOGxH?=
 =?utf-8?B?d2t4Sks2UjMyS3U5dk83MFJhYWZna05CRlpkekphOFd4REVUMWR6aGRxazQ1?=
 =?utf-8?B?NlJaTXRXOUY2NWxQMGdZd2cvOE5HTzUxbjdNcFRmYU9MSWZPS0JqUDQxeGpV?=
 =?utf-8?B?MTdMTC9NUTVKWVBYMU04YlJpNkphSlRuYWZCQzVzT0RrRTl0RkhPa1gvcnFI?=
 =?utf-8?B?UW13OFB1VUZmTGkwbXlFRlZxKzk3UzUrd0k0K2xpd1IyNzVmVjBZczdJc00y?=
 =?utf-8?B?UmdvcXgzTUdCVWhDNnRzZE1VQkpjSXNSTi9XOCtXdTU2ZWtLRmFMUmRvQk51?=
 =?utf-8?B?RGNiVkg2VlYyWktweXRSTjVBcEZKZjFERzVwUFh5WEhNeXVKdnlaTmhWMU41?=
 =?utf-8?B?SFJWbFQrQlg3YmFBZ1MyZzNPYzVtSk5ZZkVsclZSZzZKdjFScUxIWU4zSm9T?=
 =?utf-8?B?R3R3cjZTckNYdHJ3UlFaWU92aXlzSCtFeE8yT01OcDBsc3VmMzUxUzg2U1hn?=
 =?utf-8?B?RitXNjFrYW03OWtnS0FTTVh5T0dNVEUweVNCS0ZjT2lvMnBLUXBDZ0JNWVZJ?=
 =?utf-8?B?NnZwdWx3NGpXRGs3SU9hWDl6b09RK1pLSWN6akM3Z0U4Tk1BVFhWOFdXaXJ4?=
 =?utf-8?B?QmZSYUc1bXFMY0g0aGpMeFRuY3dHWmZrc0IrUld6ZUxRMkd5TVVPNlRkZGtV?=
 =?utf-8?B?UGlMMmlHalJMdDFHc0ZpRjJiaUtCZ3VjZVprMmpFY2czVmJXbGNpcjdQSzVT?=
 =?utf-8?B?YUJtWDRPbndWMy8wNFhYQkw1djZRNVNXbm0vQXprUTEyWDI3Z1ZMWUt5RzhD?=
 =?utf-8?B?L1hjNDFpcFlyR29tSE1mb2h3V0dzVVZ5RVRqeWh5VnY1bVd4WExlQkVOcmNN?=
 =?utf-8?B?RldFTnRJcURQSkVvbm52NFllZVZrYzQ3Um42NjZoSEVRTTVmTk9GRzI3YTkr?=
 =?utf-8?B?NmlGTCtJSlRHcndmZzV5bUhUdDVCYWlWbm1qQXp3bU5Cam9ucnBtTVJKM0pC?=
 =?utf-8?B?dDZjK29idnZpSTliRkpLMXpuZWU5NmtFNlRmUG04YWpsZ3JLY1hqZXZrbVNL?=
 =?utf-8?B?Z0pVVzhVNld3ZEQ3QTM4WjRHTXpnWGhnaWlkaXBnazRJNU9mQTV3VlJDN1FZ?=
 =?utf-8?B?VUZrM3gzZEpoTHYrNHFkZVBQYUxDVXA2aTZRTkI3aDYzbE1UREQ3aWRRWTFw?=
 =?utf-8?B?Z1hvTEtwWDAzalV3NWpCdzVGL3Q5bHVtNjF3MEVONVZlV3JxMUxWRStia2Vn?=
 =?utf-8?B?YTgxMkNBdVJDRHNmZ0QrL1V1bThJQ2V3OXdESXVnQTF6VWNtZksyQ05CdXRV?=
 =?utf-8?B?d0Q5RDBsUTJGWVh1WlNEOEtiYU9nUWhsbDJUa0VwY2FhUG1QeG1VTzByTmNZ?=
 =?utf-8?B?TE5vNGQ3bkVUR2JmQ204eisxYWxvcFRzZmExS3AvVllnWTU3cmZiSnk0aFl6?=
 =?utf-8?B?SjRyc2cyS1NDTHpCaTAzWVFCRmRPR1g1c1dlWGl0K3d6K0VyK2ZrSzF1THVX?=
 =?utf-8?B?SXN6N3g0TWdjSVFlYU1wYzF3b0VaYklGTjBtcVJkdFVhYWx3a2kzbVU4KzJn?=
 =?utf-8?Q?vsMUSC+Mxqm50bRMys63ScPOiN0neyd1ZjgQlsX3VUN3?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F04FF91C7C423343B656A699401D7AE0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba4e265-2528-4017-a254-08db4ab64edb
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 02:38:26.9981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ymYxIQZ7KmQrh38INj9U71W8misFk+829mMSQk01aKDRPNwM/cFj3DwfiBZ26G1vuCHSzSRneJB705BpIm/UUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5175
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_193831_866316_CEE3F489 
X-CRM114-Status: GOOD (  17.39  )
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

SGFubmVzLA0KDQpPbiA0LzI3LzIzIDAxOjAyLCBDaGFpdGFueWEgS3Vsa2Fybmkgd3JvdGU6DQo+
IEhpLA0KPg0KPiBNYXJraW5nIGl0IGNvbXBpbGUgb25seSBSRkMgc2luY2UgYmxrdGVzdHMgYXJl
IGZhaWxpbmcgb24gY3VycmVudA0KPiBudm1lLTYuNCBzbyBJIHdhcyBub3QgYWJsZSB0byBjb21w
bGV0ZSB0aGUgdGVzdGluZy4NCj4NCj4gQnVuY2ggb2YgY29kZSBpcyByZXBlYXRlZCBhbGwgb3Zl
ciB3aGVuIGRlZmluaW5nIG52bWVfY3RybF9kaGNoYXBfc2VjcmV0DQo+IGFuZCBudm1lX2N0cmxf
ZGhjaGFwX2N0cmxfc2VjcmV0LiBGYWN0b3Igb3V0IGEgY29tbW9uIGZ1bmN0aW9uIGZvcg0KPiBu
dm1lX2N0cmxfc2VjcmV0X2RoY2hhcF9zdG9yZSgpIGFuZCBudm1lX2N0cmxfc2VjcmV0X2RoY2hh
cF9jdHJsX3N0b3JlKCkNCj4gaW50byBjb21tb24gZnVuY3Rpb24gbnZtZV9kaGNoYXBfc2VjcmV0
X3N0b3JlX2NvbW1vbigpLg0KPg0KPiBBZGQgYSBtYWNybyB0byBkZWZpbmUgZGV2aWNlIGF0dHIg
aW4gb3JkZXIgdG8gcmVtb3ZlIGNvZGUgZHVwbGljYXRpb24NCj4gZm9yIGFib3ZlIG1lbnRpb25l
ZCBhdHRyaWJ1dGVzLg0KPg0KPiBObyBmdW5jdGlvbmFsIGNoYW5nZXMgaW4gdGhpcyBwYXRjaC1z
ZXJpZXMuDQo+DQo+IC1jaw0KPg0KPiBDaGFpdGFueWEgS3Vsa2FybmkgKDIpOg0KPiAgICBudm1l
LWNvcmU6IGZhY3RvciBvdXQgY29tbW9uIGNvZGUgaW50byBoZWxwZXINCj4gICAgbnZtZS1jb3Jl
OiB1c2UgbWFjcm8gZGVmaW5hdGlvbiB0byBkZWZpbmUgZGV2IGF0dHINCj4NCj4gICBkcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMgfCAxMjggKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyksIDg0IGRlbGV0aW9u
cygtKQ0KPg0KDQppdCB3aWxsIGJlIGdyZWF0IGlmIHlvdSBjYW4gcHJvdmlkZSBzb21lIGZlZWRi
YWNrLCBpdCByZW1vdmVzIGEgbG90IG9mDQpkdXBsaWNhdGVkIGNvZGUgYW5kIHBvdGVudGlhbCBi
dWdzIHRoYXQgYXJlIGFsc28gZHVwbGljYXRlZCwNCnNvIHdlIGNhbiBhZGQgdGhpcyB0byBuZXh0
IFBSIC4uLg0KDQotY2sNCg0KDQo=

