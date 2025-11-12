Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED41DCCFA18
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Nov 2025 00:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o6/tVyI+yNsoPPGBjBEmsEWC+dji0HNoZXNWSuyvdxA=; b=I7zaE7wHr9dYCUGfMCSocKLPlE
	Xolo0m5a5Uvd5WzE2RUuw7ygs96PtTRX/YaGZqh4Tzdlpf5YnEiyxcTS/Qxsb/ZhlnUH0aH+6PPoi
	CGAztaolwNNIHsP6c0B2z0kxVqAJdt0Sl1+HmlBTCytWInKIxsGTMUVNcSCOd2wIT/SVht65RyyWU
	SJZO5wqoOIC1msQlsY1rvRTRal9hsCMckpebvVEhWgNTSPSKTHleZOYCgVx6d1LOK52KVd770qHtL
	PDGgX2M+AAxpXHKym3dJ43b5WSnVZW2zd5QJ/6qlusBSjBesNheKZQmGa/7vZ0AKWBMliK5x99Brv
	9mYxvp5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIyz5-00000007vl4-42qJ;
	Wed, 12 Nov 2025 00:45:15 +0000
Received: from mail-westus2azon11010013.outbound.protection.outlook.com ([52.101.46.13] helo=CO1PR03CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIyz2-00000007vkS-44Tm
	for linux-nvme@lists.infradead.org;
	Wed, 12 Nov 2025 00:45:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q1Xoj56241jdY1oFsOvcE2ut3sn/fDKfff9JtaGyGQ9Unp6cxy/j3U0GfTei2ZKKW1Yuf/FdCnlMZ+mCQy55rzmkixOh6IDWMiW1Fct4TYfqM1f4bHlYFbxEI7aKM3UpueZAETdnZgGqbXWAu4SrCzyWtTZR2YPOsu7OhaA6z98cduiKj9meyDdCQgqnAM3u+ZuQI1+GcfbZ73J7JKKAlqZxvQjjdd3M+Tr5lR+UzNpdhQpMrQrK2u+vAjnfU7eX3SldJqLX9FmTKytIX8lxbu3lEYO5iP//npzqfphyNclWEad/rzXOWUMAgYVycm+CzUfAtaONG6q79YY7uKJwXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6/tVyI+yNsoPPGBjBEmsEWC+dji0HNoZXNWSuyvdxA=;
 b=gJF9Dk/VVvRS3UwdrN/0uecq/OMx9r2uABQWRbvjedBCfcwHZKmA3PTvK/NcNp2y0s+Cxgc0n6n5+ZQePHyzIm+NS7H3aLoxS5wAxuyWraMDWfI2Ed3M4kGdUoQ2sqyfXM28tZ4ETQ+PanD6qObY0b4Nef70XGya2283TRWlkfgqpy4Lm1wMRnz1OLLURQvTrs3wriOwGQNmDkLnDYb/dV/3zOdO3t1oylKQDjrNKrN3H68r6d1b3/VvF1OSx3oaB4YotpSowP5mlJV4mut2/VMCZpoOq219Z5kxqG36d5wPkHsKmKAMJfz0ojL59Q7dQZpp1xsTi8eKPxUq4RD9fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6/tVyI+yNsoPPGBjBEmsEWC+dji0HNoZXNWSuyvdxA=;
 b=K9DgNGF2esiWmywNQrHUjLPba1B6+Lr9o9sNu2MBsiHH2MdJe94ps97hyDPmcmq9yvHZlaOlIk1YhuzndZQjxlP9yI/lHLLs/K06kEYWIrQibgxpoFvuhM2g+wNEKLq++Hkq1NPcKeiOvqnG2BF38lNwaBWleibwJQnvyIeyfAvxmuEi6k1BVUZJNH+edAelHZpMUpN7su+e/BCVRBEtaTp8ir0sqMRXGEZ4KbdLyKM9TuY+/Elg5E90GSGe0bATPcEySpyoqI7PRm1aUMOCPtimEi5ekKsvUqkLk+1VPOP6CqE+IurZmepkEJF8TVQ47bPco6TIsf/me8cWa/1mgg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Wed, 12 Nov
 2025 00:45:04 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 00:45:04 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "alistair23@gmail.com" <alistair23@gmail.com>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de"
	<hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, "hare@suse.de"
	<hare@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alistair
 Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 4/4] nvme: Allow reauth from sysfs
Thread-Topic: [PATCH v2 4/4] nvme: Allow reauth from sysfs
Thread-Index: AQHcU2VTAf4mi6UwdUGzcgokUO+MjbTuNF+A
Date: Wed, 12 Nov 2025 00:45:03 +0000
Message-ID: <69f44147-3c9e-41b5-9b26-5e235a418f6c@nvidia.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
 <20251111234519.3467440-5-alistair.francis@wdc.com>
In-Reply-To: <20251111234519.3467440-5-alistair.francis@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|IA1PR12MB9030:EE_
x-ms-office365-filtering-correlation-id: 444829be-2677-4bb0-a6c7-08de2184b809
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700021|7053199007;
x-microsoft-antispam-message-info: =?utf-8?B?M1lGMU9YMXcyakU1dTBoUVFmVFdPZzZPWnNPRm5VODhaQkU5b1R4NlVYaGk1?=
 =?utf-8?B?Z0RGdnpWd1VWMjBNVXlGOGs2c1hVN3E0U3pKOVdrUXRMUXBPWFpCa1FXMFRR?=
 =?utf-8?B?ajMyRFBpYzgwTHlUTllVYk5neVhwN2gzeXFFeVZISXExbnhYVHEwb0U1bndw?=
 =?utf-8?B?Y2prUmRGaEhjYk1KbGt2U09PUHVpbktIYzZYUStMdUdxaHphYml0K1cxSlhN?=
 =?utf-8?B?aTB3dy9Jc3pzMEd1U1o1RVRCQmRGSlJENGFLbzNKeVA0QmZHYnJZWThZOFJk?=
 =?utf-8?B?bCtqU1NsK1I2aFNad2d0ZzQ3ekVkMFhLK29QV3JEazJDMENSQVJab29CUTJu?=
 =?utf-8?B?TWY3N09BS2xsbW9HVmova3ROajJIQUNvZnExOE1VUDY3M1YxSld0c2ZpSEFC?=
 =?utf-8?B?NWVGL0lLdDN2bTdvaEZDY2xRK3gyK0NsRGMvQkhrbUFpNFg2ZWNVYTlDZWdi?=
 =?utf-8?B?WHRBRi9mRk1qakwxc0E3SGw2WjZjdEFUNjRrdXdEZnkwUEdmQVdQZmdxZDBE?=
 =?utf-8?B?eHVzTUk3QkpRdWVsS3o0QS94OEpYMkk2Z2trOC9WNWFlTWdnK1p0Nk9HV2Jn?=
 =?utf-8?B?VTVTaFlvcEFVYVo3YnlEYW56QnNLN2Y3K0xobk9lUEZtRGZSQnFRTnFyVTlk?=
 =?utf-8?B?Nk95eGtCQWhpSE1qNkl1eTlVa2VUZDEybXBWV01yR3Vlb3M0MiswZWxCWWoy?=
 =?utf-8?B?ZGdjTDJvd1FFUFJqdWd5YklmdUFNbG8xMzFKLzlJWkFwb2huT1gvVkxkVENQ?=
 =?utf-8?B?VkVNMURHNXE3WS9xKzJyOWYxUytTTVhCT0h2UlBoSVlTdER2M1RPblhBUmhm?=
 =?utf-8?B?NUZhMDY5ZU9GNWgzVUc2ejllbnNpMDFyVkE1QW4xUnhoblpUSFdtelRZczdO?=
 =?utf-8?B?NDV4a05NdWFVYmlaZ2cwZGdxMXVHSXdoT0xBdzdnMElDbE5vZlEvc1VsSEdl?=
 =?utf-8?B?M0pud3FCUXRNd3ZCQ3k3WXFYK3ovUkNTMzhndVYxYnZwK25KMXVjTzc0Undn?=
 =?utf-8?B?c0UvOTlSWEh5VDJqcXFHdlhkakxKZVBPK202cE5KR0d4dExIMWVENEc4Rmsx?=
 =?utf-8?B?dFIyZElHZEFORmhJVm8vU05sUG9WVEdRb0NTS2txY2NUMkJGdkd2am1taGxr?=
 =?utf-8?B?c2Fad0EzS0VtaHJkdEVDYnc2V09zUTIxNFlreVpoRFRuUGZ6L0JkbXlOY051?=
 =?utf-8?B?ZG83bkhMQ0dsd0wzWG9ud3d0ckFoZ2VTTURzTGJydlNCUm15WTZZeUs1WmxH?=
 =?utf-8?B?QlJRdzBiWERrVjFKelJlMS9iTG40OEtZUm1TaVhVVkNzcW9sOXJvQ2xUeUF2?=
 =?utf-8?B?bWc1UVBPWGxsRlJlWEVIWGhGNnFXT0ZoTkhibzJ0MDh0RnpDOXAyU00yUFBk?=
 =?utf-8?B?NGJrUG5LNnNseGYyQktCcVEzVm9KY0ljZ0hWV1Y3TnlTanRqWkZUZkQvcHJj?=
 =?utf-8?B?MWVPNHhtNVZEcTcyYWdSV2hzU0VRK0J3U3lKY1kxUFhBWkFIbFFBRklvd2Js?=
 =?utf-8?B?b0NsekJGVGhhTVQ0dFcreE44Z0RVdnNpUGZRbHY4Q3Z3L2x3VE1QZTc3WGlt?=
 =?utf-8?B?OGNQU1NIdzlrVUpVbnRuUkJBVGpLbHc4bFFyditERUJVQzFQcW9GQ0lrZUpj?=
 =?utf-8?B?aEh0WTgzLytFNCtZRGtvWXZreWdvVVMvWHVLbzZUcnVYZHgyTDNRQmwrYXdt?=
 =?utf-8?B?ejNPNmJDeDdLZ0k3WmhpMzVQcFA4TXk5UFI2b1F4M0FRUXpwaUJPNWI1aWw2?=
 =?utf-8?B?dkFIK0xrYlIyN3JTQTRUOENZNHdpd1hhM2VBS1NDczlLV0NmRVFiTlZpSmQ2?=
 =?utf-8?B?dzI0YVJVYWoxOWM3Vm8zT3dpSTlMTzFLOXJ5UzU3MFBKOWxlMGZtenhHZUs0?=
 =?utf-8?B?RnZGRnRvWkFYL1NVbHdWenFSc1Y4RURGc3JIOHZaVUFROTIxTjE3NERXWmNx?=
 =?utf-8?B?ZG5MSTFQUk4yRGlYL3k0cmJRbEw0aUI3QjdQcXpmS25BNC81UkFicmxMWTcy?=
 =?utf-8?B?aFBxank3RnZtays1ZGEwRHB5b3ZZSVBLTmt2N3RXT0YzZ2E3TWF1Z01ySEVQ?=
 =?utf-8?Q?HYwgDT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEZBSDcxZ1A0U3FCYndxdjRlcmh4TzB0NjRGeHJ2RFFjMmQrdWh6MXZiYytD?=
 =?utf-8?B?TlFobW5Zbk5zd2tndG9lbS9LNWJ5MDFwSHptNUt5VWFDZ2RXVWJYUjBpQkRp?=
 =?utf-8?B?dFQxeml6MGdCNXNVWVA3V2E0RGpGUGRwYTg2ZWExYzNGTUhJNXJEMEd0dHh4?=
 =?utf-8?B?WHZ5bVNLOXBiYmJWNDRMbnZzZDYyZUIvZVQ2UUd6aCt4Z2M4YWpXbmVFUFVp?=
 =?utf-8?B?TjVjTTlacUdMYXcxdUhwYTBzc3czZlYySTljU2swUlI3VmtlM3RqWVFNOGtz?=
 =?utf-8?B?T2kwTFcyd0pQaXEwWlBHQXV4YzZEZkl5K2JOZWVMUDhqRHgvT0VvSjg4WjYr?=
 =?utf-8?B?NlpzcUJLNHl4V0kwZFR6ZjVGMytkMGJuUkRoSy81QzIrcVpnTFNEM1FWcG1q?=
 =?utf-8?B?aGtxM3Y1SWR3S2VaZmlZSC9qOGxnNFRSQjVHZXdKM00rV1I3cHh6NExWcnVE?=
 =?utf-8?B?dERuQ1R2a1RnaVI2U0lYM3l2TkJ3YWJDbWN1eXowanZvSjVvZGMyT3ZPZUxB?=
 =?utf-8?B?Rm1xb1VQY0pvNmFPM3c0Mlh0NEczRTRVOUl3YVU3SzdsWmwyTlY1OWw0L3pa?=
 =?utf-8?B?a0c5Y0FnT0FSamkrdE81QmRQV1V3QjdaelYrQk5YbnU4T2ZvVWkvVmMvR3Jr?=
 =?utf-8?B?ZWw1WGNiU1JqOUVaNFJET0Iwekt3T2dmNDBjcjZXL1dJVmZkczE0ODZpeWMv?=
 =?utf-8?B?NVpnTFNoVmN0YmlzaUhteFhGOTI4Wk1vWGtqclpISjNqODVWV2thWVdrVmtV?=
 =?utf-8?B?V2V4Sys4dzFJTHdvSEZyM3BEU1RkVUhTVExKYjBwTHJyRkRrUElCbnFrd21v?=
 =?utf-8?B?M2w5Qyt2Z2RSRkFIMEdlYzBuR0dvZjFXS2kwY1d1OUUzSTNzR2VCU0pCZVpV?=
 =?utf-8?B?SWRwMlB0WW5UOE1vOVEvN2I1R0xzeldML2tGUkxuSE03c0hSU1RXeERvUi9Q?=
 =?utf-8?B?cm1nM0FVU0RldjJzOTFNbWp0Szh2SitqWlNPbFo1QldsZm5JRmsyZFh3QS9T?=
 =?utf-8?B?ZGFidHp2NWNhRFBSY29ldmxuSVJ4aW9MNFJGVVphbFlmeHZuc0pnVzN3bFJk?=
 =?utf-8?B?WGFVMjhwWmd4ZFFpQk5XZVRuU0IwbXhQblh0ZUl4Y2dOZWQvMnAxZTEvc2hF?=
 =?utf-8?B?aHdld1JBWFNLd3BMRmRnMnUyRHBhQTFRM0NHczA4YStUWjhMS2kvZ0gvdGlD?=
 =?utf-8?B?QjliSHVGK3RFTHVmelZxLzY1T0lCSzVYd0FSeFBRa3BCVFh6Mlc2VjcwajBl?=
 =?utf-8?B?d3ZHbTFieE1Ubjg5M09Ha1dFSldabytQVE03ODdidEhhNHhja1AwVXN2K3ZD?=
 =?utf-8?B?SE9VNG5Ccyt0K0xmUlcvd1RXSDdtMUx4UVpRWU83c0dKUlFSMit4UzdJVmhM?=
 =?utf-8?B?VTNtQzFlaGpCSTUyc2FXZ3FpdDdzNkxmVjBaZy90elZ0ZC9JbDA3UWNGeXVL?=
 =?utf-8?B?QnhBcG9ISlVrWU9hUzZBZ0dHcWVSY1JySFU0RGt3YnQ0TGsyWVp5Zkh3T05S?=
 =?utf-8?B?ME5nM1I1VTI5WUY0RkVHRHpadDc3M0R1THRaMDNMWjN0UCtwVHFkWnpPQ0xI?=
 =?utf-8?B?ZkhqZm1SS0dvQ2hnU0RFckZqNWltSXpSRTY4M3N6aHV0OEs0c2diUmp6dDRM?=
 =?utf-8?B?Q0NjTnlPRS8wU3dzZHVvWlhTU2FmSzNSekxuQ3ZQWFZkeGtGcGh1bEFPWU81?=
 =?utf-8?B?NDdkYnF1WWNpdGpKbHhUWWIrUDVCWnZCclI0MkNYd09WcGF3ZlUxY1Nsdjdm?=
 =?utf-8?B?Z3JSU0t3aWpqdzBsT1RWeDllcnRFMW9XN2NZelRLamZhbFlpZW5DZk9WamVH?=
 =?utf-8?B?Yno3NHhFNVVKMnFmQ2RCbFE1b3d0bklWZ1l6VTRMODAwVnJKWld0UGYyeGY3?=
 =?utf-8?B?Vy9OZWNoZFc4Wm1rdHhMblpoT2I4bHpBT1dGbHNybllnZ0x6WkZEUlowUWVz?=
 =?utf-8?B?TWpRL1BtdXN2QXhsNHFXQkg2YXZaNFpDUmpuKzdlWVhtbnhLUHdCTUo2ODlU?=
 =?utf-8?B?d3hhZHhLb25vRE9JeG81RE5YSTNpOEFUM0tCcnJPWnZVWjhGc0dCWlFrNStT?=
 =?utf-8?B?TXhkdkR0eStwZzlqUW1jS2UyT1FLcnZtakR0c29rODhKakhJRDdhdzY4WXhi?=
 =?utf-8?B?THZ3OU1KTy9TTGh2clFFdDhGUjYyQUxQMWVSMGNGYmtYc3JxNjNFdTVFcnVC?=
 =?utf-8?Q?0yGMrMTUnqKATeGP+DMm3mj2joB9pMQ6oqbSVs9Btpu/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0A941315CA5817428A3F8CE32C69401F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 444829be-2677-4bb0-a6c7-08de2184b809
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 00:45:04.0163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kh/3roZ74jBmg+8ROS4f07WoNW25VBGgDFXZIDpnhsiWoP99pCY+e9hHB3y+PDzzP0Z5GnKzrAKX4/OmbfvmuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251111_164513_014651_C0469312 
X-CRM114-Status: UNSURE (   8.24  )
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

T24gMTEvMTEvMjUgMzo0NSBQTSwgYWxpc3RhaXIyM0BnbWFpbC5jb20gd3JvdGU6DQo+IEZyb206
IEFsaXN0YWlyIEZyYW5jaXM8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KPg0KPiBBbGxvdyB1
c2Vyc3BhY2UgdG8gdHJpZ2dlciBhIHJlYXV0aCAoUkVQTEFDRVRMU1BTSykgZnJvbSBzeXNmcy4N
Cj4gVGhpcyBjYW4gYmUgZG9uZSBieSB3cml0aW5nIHRvIHRoZSBzeXNmcyBmaWxlLg0KPg0KPiBl
Y2hvIDAgPiAvc3lzL2RldmljZXMvdmlydHVhbC9udm1lLWZhYnJpY3MvY3RsL252bWUwL3Rsc19j
b25maWd1cmVkX2tleQ0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBBbGlzdGFpciBGcmFuY2lzPGFsaXN0
YWlyLmZyYW5jaXNAd2RjLmNvbT4NCg0KDQpMR1RNLA0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4gLWNrDQoNCg==

