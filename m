Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71EA5C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 02:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nIpmARhJwA/vHIt+S69SHSLquKAG5RKPyJQjny7MDGw=; b=JeB8c2DFVUkn0D64ypyvdVfIii
	kBUlLcAMDbA/zudPkauT+ovvVFSl4gzF21XRXPwZgh1SET2dwICyCnhckHy4Lqi9z0DsMgrFOf06y
	vCqU61+YRkQyIDkBQCyBWBvTE4fVe9PIjY12EHIWAuhicKDFF+4nYWo6u6nvaKQPWuQKqY37mD5wJ
	tyumPT5JzKokFzEYa994wOxyJ/8usnIeDahO2ZfG7/Q+vW46Hp/4lYMZddoxj0KgD/jTEK9h8T6Cr
	HXHIXjHpDBwhQqXVQN/zjTvTz4C2iJJUutqC+ZNAiy9UQyMxlcLiumCgHt4ImhodxKZqY2SwZBeS8
	MB4OOUEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwYik-0000000AYz3-2RXI;
	Tue, 16 Apr 2024 02:38:54 +0000
Received: from mail-bn7nam10on20601.outbound.protection.outlook.com ([2a01:111:f403:2009::601] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwYig-0000000AYyS-2w9A
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 02:38:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1vPNm/p9w7XwTzDPcsTqXrERbcHKJ6ZSUMZUxTq4wYWUvciPSGLOSRZoWXvjUCAuOcrfIZiM2zV6erZbXliPT4gX+Mx4/Voo7b6Eqvx0h9CULHTHXfoNZXEN1fDnwZXiYyntaUY6X6CL1gRiet9f15dk+GCyTuRmR4mJnYGLYUtWX9PR1iyHhSnDxNmobP9eBeJwUNaJGExGsT9P+al4TmTp/nwxZiR6xvgND8Q0/wg22xIZAIlcDzIDnHRO8RZzi4zBfDcR8zxGO7QbkvA7mXK0mPhTjaSWqpFIL9Xpxvh81mSt6F7opA1cFyVm0q2jICdPk0DNTMIkvV9OlUvUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIpmARhJwA/vHIt+S69SHSLquKAG5RKPyJQjny7MDGw=;
 b=kOaGOg0HwoL1U4A75wSajs0X/NTxGKHcV/EwAJLV/zvV7vC98wQifmJPE5WCqiZXeBwgGuLP4gPCxZ/bV8UCvgeWZOMOhp+TncgOtdhcVIbl0svwyb7yDX3yPMLM0KI3Ngz2L/rffAndJRwBdK8UzWUXDRLDLNtcWcgwuxX+1y+5bCVvggR8mtKBHFfc1ODKfhYVMZlyv409AWRLywychz1D8cJpj18YjO7yevPa0+mG6ws42Zk6KHwbIggBkVh90V5QE9OhJ3x71UiiWlmYQYeDmfRAXSeOQPOIUm8GfvkzMrBD1H36JZT34g3wLXCmBm3vqOeys68xxYzXDVE99Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIpmARhJwA/vHIt+S69SHSLquKAG5RKPyJQjny7MDGw=;
 b=Lopxd6F4AiYKkJASka2dDTIb8GpOZ0SyUG4eZUQ3YIMKcqfczRoGCWJjTHtnvUQr9CcMwfE+e895wmfpB7TSbasWSCRYcLroGDn9Ehagh2yj5rgW2zZGxfws5IotE6cZQpjNkTJ6lrMaHqnj1QBKX7FSdQ53u0ZDPUo/16zCPYRQH85KzcdqYa8jrSEdX6PvqvcW1/MI2T4GoCgjQ5UxUGv4+xbG81eB9gwBLmKpGej+CBSIJfThwbQ6tlA7Xn6gvjo0sU88ptHH75nRYr10CM+7RZWhRfG6QbHPHruVoMbBliVzIInCfXMKR6b6iQae8fEYp9fbMbSgGPI12ruhyQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 02:38:42 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::a1:5ecd:3681:16f2%7]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 02:38:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@redhat.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de" <hare@suse.de>,
	"dwagner@suse.de" <dwagner@suse.de>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet-auth: return the error code to the
 nvmet_auth_ctrl_hash() callers
Thread-Topic: [PATCH] nvmet-auth: return the error code to the
 nvmet_auth_ctrl_hash() callers
Thread-Index: AQHajN9IDs9eAS+c2kiuEbySmTgIWrFqNKSA
Date: Tue, 16 Apr 2024 02:38:42 +0000
Message-ID: <8c0d00a2-66b0-45a6-812a-4fc516d89575@nvidia.com>
References: <20240412134154.565298-1-mlombard@redhat.com>
In-Reply-To: <20240412134154.565298-1-mlombard@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV3PR12MB9119:EE_
x-ms-office365-filtering-correlation-id: 54e19b22-4514-4060-efc3-08dc5dbe5466
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bA6S+CdcCSQcvthZj68w7Sa9/dXPYu3FCdgMLvMkEfPhBsgR1XrWpyMTszJ0/RkK7+xnL6NhUcMQZtLCBkPKnPg8OwTCJ4a/0IIw/gDhhHt/c7rJONeml4+i3TOR7EEaZfo7Qv/KMeGzMQeNDaL70LR1Wm+sUmu1Gad57WoKz6iZ9qtFMmrg9YyxNjVCIyBVyPSOv7/Z7AAlhcS/N4FEB+uQMuR37TuSczndPf6o7NT6jj6kSgVpXbWTZRQx7XHSq5NKQ2sWw7n0cQ5+nzoHo6sgIy8ZX5ib1Q7Sn616AmSVNjGcYE6gm10ECpIJNL2ITu0wDs2EWuKl560bj4VGf7ADIsaogeZiXHDpBbH3A4uvu1U8R6C6SvFN2NZSjM3R7sGrL9klDdbnaO62yfi6B9rxBUOCGMSFbqAMj4+qfsspRjfkrioZ8DZnONBxmyul9z0BwnsxrFwIL9oVJT47GMp+CMPc1PwDcL4+NIJTY1Hz0aqdOtMeH+qHUDlhgrlBgWsKW2JQVMAqL36VtBjIPUdAGrzRmcvV1DOjkSQW+zN/rQsS0SomEPrht6DWJQ++skbo8t7MS35X0Fe+lC4+6/R/QSfNGj5mQ6KVz5IEUwu5AtvaCPD5PDTEyen+PbcS/oOFAOmAV/DWy4AiHGBw8Z0nIyGmCYf0F7EVhs1slBlczHVDhxGMsjNQ1wb2zsjeqvQMuzy+sgSKJ+XiU4FKnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b29EL0hQVjl2QlJLakN5ZytFVTFrbzlHcjRTd01LQWhNVDk2UVJBMWx1L01P?=
 =?utf-8?B?MU5zOWtqMFdBWFZKR1RGaEthakxhSEIxekdENTdwSnQvY2FMTjBIYnZyRzFZ?=
 =?utf-8?B?L2RkaXBYS21IaXE2SUdodVlwNS80czdVckNqVHhKdXlxODdyR1Uybk42ZEpM?=
 =?utf-8?B?STFPd0wrTkViTDdSbFJmMWVKcUJ3ZE9oNUx1ZS9QbzQ0Q3liQkV2dFlIT0hV?=
 =?utf-8?B?dnZkZXRsVFQ2QUttVGlqS015cno5VXNCMW91YkVuc0w0L21paGloQkdYa1Nw?=
 =?utf-8?B?TXdVdDdOZnB1ZTdZaVU1aG5VemFZeldvQU45Qjgxc01yTVdZRFpKbzY1eFBq?=
 =?utf-8?B?a0tidC83R0JmQjRWcDd0SE0xZzBkVjU4NkJackFJa0xVb3JOMytRenNud0l2?=
 =?utf-8?B?RWRldHF6VzRMeERsMHpHc2FPVWFFcitISFR5MWI5SHE1ZGJvL2FjSEVhRXR4?=
 =?utf-8?B?d1pmcWJaQUlGSkRkRGpQVzl4TWJKOUtHQ0dlMEFUcDVVaXFvVDc1bUpHenlP?=
 =?utf-8?B?N0pPY2U1Tm5zMlJ1UFhRcmNJMk5zdFgwdWg3R3k3V3BGNGtFdThJQUNCMGRY?=
 =?utf-8?B?anF4emVneStMWXU1aGtqeThmeEZLaFJndk1BNy9nSmF1WmVWYkNac2gyVlN6?=
 =?utf-8?B?REhaa25zUERZVmx4bm5uUk0zd0dSd04yeGh6WGQzS21nM0JhWTBHdlNMU3Zp?=
 =?utf-8?B?QmY1R2xIamdkZlN6WEJUbjB5Q3ozU2dlSTN0OTcrOWRieWhxeko1Wmx3SCtZ?=
 =?utf-8?B?TUlYL2lST20wTUNTSGpYbjdtTXIvQVUrSlI5QjVid3E0NWIvaTFtS0VwMFRH?=
 =?utf-8?B?MC80em5ianB3ejZ5RDI4S2l5bFJZWFRaTzZ6UlAzQkVCRHZoa2V1K20vb2s4?=
 =?utf-8?B?TklIbDFGQTJSZmZ3VkhZSER0Vm1NMXg4dXFyaWZPZVFHYXpLajZMdXpCTEF5?=
 =?utf-8?B?UTNHSWp4UHpEYzlSOHFqTFczV2RLaGJ2WERtYXdrckZUSTRZcUVud1ZybzM2?=
 =?utf-8?B?d1QrTFNtY2dTUkVmMGF6bHlvZlNPVVRvdnBZVU4zNHp1K1FSR2oyWUg1RjJU?=
 =?utf-8?B?eXpJNDZjOWwrbXZvOHVVTWdzN213djNwZHdzd0ZmUHlmbHJWSmpPRG9WZ204?=
 =?utf-8?B?TXlKOUVVVkp1Q0dZQ05GVGZwSjhubXlVaDlGWWRhNi9PeGdDS2R4VHpwK3pC?=
 =?utf-8?B?NnovWVQ5SHoycmRoallKVDlJTzlKcGRLdGtqRTFxZk54ZGVTUmtVWW85ZUJo?=
 =?utf-8?B?VFAveUMyMHhkbDEvSmV3Z3phREtYMStwNldEL2lyTEMrVG8xQ1ZQeVpPay91?=
 =?utf-8?B?VzBVclN5UkVjNmpCWjdVV29BTTRGelV2WGZHUFNtcEN3RjRYMS9xK3IzSUV5?=
 =?utf-8?B?ajJYVVdpdDNWYU1odHVUbjRjK0VWY1Mxci9mMTFTbUFNSXltNFBaTUxHS295?=
 =?utf-8?B?ak13cjN6ZGIxeUNSdTllUVlCVlpYV3g5WWlrNXloT3J4ZUxXTEUyM3VITGpt?=
 =?utf-8?B?TXArYytYVGxnMkJHNmNHdm5ZaTVWSllqOWJ0RytUazh3OFNtL3ozeHhzNVNi?=
 =?utf-8?B?R3FtTjBiR1VCZUlhbEFFNVM0UG1xTzgwbklOcnpGV0lmM1B1Q2krNmg0bjNo?=
 =?utf-8?B?RTZXVXMzTmFHd2lUem1BZnROUU04dTBLU3ZxNHc1N1Noa1VHYUdqNXA4UU1D?=
 =?utf-8?B?ZFF4K2EycUY4WUxqelRXOERmaUhWRGpvOElxTWU3WnNUUVQ3YjRvdjlwc2FH?=
 =?utf-8?B?QWM5bFcxWE5GYytqb0kvT0FVUElqYVpPaHJmdXJiamNBVHlMZkhCNTdGNnV4?=
 =?utf-8?B?VVEvUnpxRVRhQ085a2lHZGNVZWJaM1VuUC9NVXZnakk2OTBXVEpaZkFjbnNZ?=
 =?utf-8?B?UERXVFBDWWw0cDVtMGgvWmQ5RktVTzV5Y2RlSkVydFJUTlNSdDdTVkhCaHJ3?=
 =?utf-8?B?Q0dpUzU0V3dzQXpsK0NPY3RKdm15d3NUbzRSaHVWRGlZT0QwS3ZTQ0VkcmxG?=
 =?utf-8?B?MEVzSzgyaUZ5ZTJDMHhpcmNoTnVxN2Nla2dDRWtySU41c1VpKzBCR2VIZ1d1?=
 =?utf-8?B?ck51MFdaWmtKOUF4TXlWUVpiemVLSGFHc0ZkR2RvQmgvczRqSHVtSk9ndEdJ?=
 =?utf-8?B?Vjd6VkgxaGdYRVJFWUl0dlNseHU0YzZKRDJkVmxlUXZjMDhqM25VUUZGMDFm?=
 =?utf-8?Q?DMdh6ITYrZFoGTpeLhQ55+CNbxuiOAUa4QW5NOFWgk9G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B55CC45C1C7C6C4B8551330F6E0E88AA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e19b22-4514-4060-efc3-08dc5dbe5466
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2024 02:38:42.0864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C9VTuyD48bu8WcFAJh2uSNIXdXYCvWngbh39+eg9mthNcKSV56rXReMSQOENKwsVqK3o9HQtAHa4HTU32y76FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_193851_005410_878C07E1 
X-CRM114-Status: UNSURE (   6.90  )
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

T24gNC8xMi8yNCAwNjo0MSwgTWF1cml6aW8gTG9tYmFyZGkgd3JvdGU6DQo+IElmIG52bWV0X2F1
dGhfY3RybF9oYXNoKCkgZmFpbHMsIHJldHVybiB0aGUgZXJyb3IgY29kZSB0byBpdHMgY2FsbGVy
cw0KDQpuaXQ6LQ0KDQpJZiBudm1ldF9hdXRoX2N0cmxfaGFzaCgpIGZhaWxzLCByZXR1cm4gdGhl
IGVycm9yIGNvZGUgdG8gaXRzIGNhbGxlcnMuDQoNCj4gU2lnbmVkLW9mZi1ieTogTWF1cml6aW8g
TG9tYmFyZGkgPG1sb21iYXJkQHJlZGhhdC5jb20+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpS
ZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoN
Cg0K

