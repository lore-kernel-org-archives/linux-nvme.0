Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B88C2BBCA
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jun 2024 03:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mxh9uX5YSEM1vRoOLwNcopIkoVS+aUJfULle/ebkCj8=; b=jJcRR8JQJ9YNxqkuw321wEwsiR
	vbhcrzfmRbV5Iw55rrLI/x89Ez0FXpdySWtTJtSxZpigh0ozimGHvfa2ZS5DVk7EaMuV7lj8CDwhs
	MXFS2HQYrcGk137fAXl6cUrYv7NcoPPjrUATqIIX2Okg+ILjPRpEt1EZDP0wrWCiwXpw49VxAgwOh
	Po72okIUAAcs0ETlcrlP1cJZSgu2sfwReZ/5uyedhvntXb8HFbL1Vb/e029zypOmpgkBgyORZClSe
	NP6i4chn0mXYKNp+8FLFV43drTCxeh/SsupGvIk0pSA5AQAzLGgtOyQbPfE6ACfcW+bX7qclPIWFR
	93BpI6eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLa0i-0000000FLXk-37Ma;
	Mon, 24 Jun 2024 03:04:52 +0000
Received: from mail-dm6nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:2417::600] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLa0d-0000000FLWe-3Nbl
	for linux-nvme@lists.infradead.org;
	Mon, 24 Jun 2024 03:04:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2yePBZ6hbmUYkUAtJsmWgL0c1JZxItfW3foRvMqV96Go6gU5kC5w+SiKIiqnNDPzolsM+iX8S+EAQegrFpG7+UriBD8asyb5fEY5/mQCv0J1awMzNmJuovBhP940fibeSNP8VWYmVQP3bS6gBwHF89ldcMoG09/AjQDaaaDnqKDS+3NvvDrXiFTq/exDuPi9odjTgt9Uixo1SPu9+dZtY2jbFLutW+75FvDhtDpsJ+unGCgiJyJWA14AZUiqyFnZxUp1+3TIgXt+R/BkuDvYT9zhg7jZ6Ft6PGGLOGeHVMySDGoQoDa3gtyA4+VyXdffiZ1MOfPwC1L/vg29CMhdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mxh9uX5YSEM1vRoOLwNcopIkoVS+aUJfULle/ebkCj8=;
 b=MgQI+K2SNUN/olYKB5G7jNeKdAlqsdwauX5XH2NLGLPyl1k1SKG6UWbNsTMiTgNNqd6UuETiW2CPcF2fHAfCU8aeBbh6QB3zDxLbQBlfw5Gge9FxvTksX3Yr+aKjp9Hk2joB0/zqjr34QxTfxJRCI66yhPsyYUoND5e3J4mNFZI7s4fsbHsR4HTuplsPc2P8ygfhJUSUweWNaTIcm+FWu9OJTztLTvFGOYu1TrhOTau+kdDZiOV9kaeU3AaBvHxnRDHeyliB7nV/gpJHGvVHcHK+VlvkENELKKMcQBAdQhN7QSHaW4sFTIUlRi0icYx9N+XoYBr5ZVNhCZsbvNPd0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mxh9uX5YSEM1vRoOLwNcopIkoVS+aUJfULle/ebkCj8=;
 b=Vth5fqLykFti+lnA/49AH8fFV2tiB6EH8xHsI6jgRG46xB5g48/WlbGVYDHSAqP1EQScvwDsf3/6IJUB//pu1dkVL/T+MDOy6E5+vineYqpV6Vk4MP5XSDpY8uwmT9XAQrIDVZ3si1sviTnsvqO+h7XttbijXJFCYFa53HNpp4uYvXw9FnAQdCgVx7Vsa9nbChTgM3Wk/ByyPnoH36f7QFq5aGtRQOvMdV4s++R1PZ1dtQfu/xye5Ww7a6lLSV6sowoOUnqwhrzaWeJ7KPuvoxPDZzSNPBmf6/XN7P+VzRh7ZUHJ1qKY0xW5rBMbyR2691KAKXrxxG0LmpfqkjQY3Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB6718.namprd12.prod.outlook.com (2603:10b6:510:1b1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 03:04:25 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 03:04:25 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>, "dwagner@suse.de" <dwagner@suse.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"venkat88@linux.vnet.ibm.com" <venkat88@linux.vnet.ibm.com>,
	"sachinp@linux.vnet.ibm.com" <sachinp@linux.vnet.ibm.com>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCHv4 blktests] nvme: add test for creating/deleting file-ns
Thread-Topic: [PATCHv4 blktests] nvme: add test for creating/deleting file-ns
Thread-Index: AQHawm3QXCOWFVOffU2FuODAgcGRR7HWQZSA
Date: Mon, 24 Jun 2024 03:04:25 +0000
Message-ID: <f8519486-e613-4074-94e2-957f5ea2c763@nvidia.com>
References: <20240619172556.2968660-1-nilay@linux.ibm.com>
In-Reply-To: <20240619172556.2968660-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB6718:EE_
x-ms-office365-filtering-correlation-id: 96f91ad4-7058-43ad-ac0b-08dc93fa5adc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|7416011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: =?utf-8?B?WVZJekZoSGlwcEQxcy83WlIvRzNzU3FTNHdhRE5IREJuKzI0Y09GdStoMitZ?=
 =?utf-8?B?bk5FUHlWYUkwaDExQnZLRXNydjJFUklBMUtCVGZyZ2x6SDlDR2RmWUt4aTRQ?=
 =?utf-8?B?bjdOQkpIL0pDaW1ERWhsSFBGUldHb21KekJud1VxeU1VQk1JblhOSVl4WnVm?=
 =?utf-8?B?bEhrcnB6VnVhc1ZOWmtOa2ovV01MSkp1VkZXdnY0SGNNUFU0Sk1JQTZmVXNZ?=
 =?utf-8?B?dWVNWGwrUUtPN1k1YldtT3dMY1Q5YlozeUNFT0RGVzdDZmdHNDA1RlUyeUIw?=
 =?utf-8?B?WHdoQlpEVVFtQ3BJQVZra1ZkOGF4OUpjUjUvdHM1a1hZdkNMa1pGM05qUDcy?=
 =?utf-8?B?MEZrYWFHbkhTTTY1RDFPeDJ1VUtNRXVBT0tURGI5dWJrT2Y3NkJwQU1VUjE3?=
 =?utf-8?B?RnYyTEtWMmF0cDNpQjUyeU53bnJyT3JlQlpJenNGTVQ3aHpiWFFuL0pLQnQv?=
 =?utf-8?B?dkRvNFBzSWxqb0ZFOGMzL2trWlNnSGgyNEk1THNkUlE2d0wxK3JRWlVPTzlt?=
 =?utf-8?B?UTZnaEdsSUVSVXpiYmViQ2IyUXdDRmcwRWZMaEhndzNNaWN6RmtVc0hYNDhv?=
 =?utf-8?B?elVvZEwxN2VraHNISEFHZ3pFb2tjby95YkhpNk1aRHhHamFnMFV1RGZINFRT?=
 =?utf-8?B?Q01aOXBUT0VJNVE3STNmSHM4YUVqaUZNY0Y5QSs5TU13VE9xL1dmWUo3ZmZ3?=
 =?utf-8?B?cm5QRlVjemNZSkxMZFhZK21aZU00dFZ2ejg1eEdnTlJyMldaNzFmT0hISWdM?=
 =?utf-8?B?WmNlNlY3dnhnWFFuMk03L3lyTEk3eC9JTVhUNXdLNVRyU2w2dGlOcE9YSUlL?=
 =?utf-8?B?b2tMWldoQjBKVXIzNWRYcUVIODhLekttNjN2czdyNXdQeUxLTGlsMENnTW1N?=
 =?utf-8?B?VTVqc2I4WEJ0M0VmQUprV3FZSzZFMjYwTiszOGo2dW9FQUw1d3dDS1VYdktJ?=
 =?utf-8?B?YlR2WWc1WU5NeHgzKy9pMVpMRVpSUk10aTZTajQrWmpySnpHZVd6MGZmTmor?=
 =?utf-8?B?QmRqV2JwbnFydFRObUNoZzZCMDZ5cTdrVEl4NTdGSkkyT1hoSjl6NUM0TmZN?=
 =?utf-8?B?VTF2U3JWbTZJa2pVUzhDdkFHOU42N1NPdmNNLzZncFNFa3FTd0tCUTJVRlMz?=
 =?utf-8?B?QVlCKzVWVWUySW1mUWNFYUc1OFIzdlZ1VE5XSUEwb2UrVWxpWFJ5elZqeWVV?=
 =?utf-8?B?ZndyM25DdzVEbnA4YjZOVHp0LzdSY0VDNHFacDdIQ0lIcTNxbTZxd1J4Vjl2?=
 =?utf-8?B?NC9mMmVYQmtmWXFDNjN4bFZqK1BBVFhzdzdqOFlhZFYvK004cXM4dVU4Wkda?=
 =?utf-8?B?QTBzUzNYaTVvUm1kYlFRTEJ0a3dDOUFxSXRWZ3MwRmxJWExqWSs4Mm5Tc3lj?=
 =?utf-8?B?SjRBeEVmSG5NNHZYeGRSSlNnMzBDY0RydFNsajRSbU9ZZTdiQkI3WGNwcWY4?=
 =?utf-8?B?YllWNWt0TC8rd0hQTlcwS2NGUW01OTlaTjN6NnNIYnkxcU5pTS9jdFVHNEJo?=
 =?utf-8?B?NVlTZGFUamtXNEVMNGdYQWVTNTBFUENQZzJpUUZweE1CTnpIOXFsOTVkeEZ4?=
 =?utf-8?B?eEdoSkFoQmNCeWlKSGxmQzd4U1ZrUE9TMHJFWkt5ZDl3T1lDYWU0dUFBMVpk?=
 =?utf-8?B?Q3liYzkxck5ORHpjNk1sQkJWekQ5aTMzMUQ1ZzBESndYNXNQTktuTjFydW9V?=
 =?utf-8?B?cis1NUhoay9hZWtrbmhmMGE5RGRiOWNMOTZ1TDlnM0pqMXg5N1M1Ry90dDI4?=
 =?utf-8?B?QnE3dkZjSS9LQVY3bHJpd2ZNUjdGb0gyVjI3WTFhRWkveThPay9jWFAyeDFY?=
 =?utf-8?B?VzJHV0RqYXdlTTZPUGhNZm5kQzFEQ0dQOS9KdkxHQUZtM1FpeCtuSEFJUWZI?=
 =?utf-8?Q?ngsh6XFLqOVb2?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2dROUdOb0lBOFVRN0JMZjBCOUlBS1pLdHg2N0RCblo4KzBvWjJVZ0lmc2Mx?=
 =?utf-8?B?OTVCR1VZY2x0VzRaVW43ODE2ZjNFNHByblFSa3ErajFWdjVXRFllNkJVdW9H?=
 =?utf-8?B?T3UvUzV2Kzdwc0xOTWxyQy9XRm1IcFpsTHUwakRyQmZaRDZ6QU1KTnF4SEhs?=
 =?utf-8?B?blR5Z2g4TWszMXBGMlREMzRvdjc1WFc2SDhBd2FKbmxDT1YrNVNNa3FhOVZj?=
 =?utf-8?B?bWJZWExEUVBKSWZkSkJLMVp5akg5Um1XMVJHeWs1dE9yRGVwTGE4UkMxeHNP?=
 =?utf-8?B?QlE3N04xV1I4ODkvKzNuRElFWEY3Y05pSDFJSDlJdElTbk1qbmZSYk5tV1dW?=
 =?utf-8?B?RDdQSThjL0FJbGxtYUlCY1hnYTY1TUovRXRLdGh0cGc3d1VyNVJCdkN1NmdS?=
 =?utf-8?B?dHpmQjQ5cjZjODlwUWdUSURpTmlwbEFrem1QUjdtbFZOTGhsR25JdTVHQ1o0?=
 =?utf-8?B?R0t2UjNGV0kyVG1DbmcvemtsVEhiNmE4R25PcFRBN3NQT1czWU9VUlB3VjA0?=
 =?utf-8?B?L3J4VVVOWkg2K254Z3V4RElRUjdCcVQ2VXMwKzN4T1NsTWdoelpXUW9MY051?=
 =?utf-8?B?cHF2NWtWQitTRFZHbUJobHFyeGRkSmxSazAwcVRhVUR3Y0dZcjZtZGFKWlNw?=
 =?utf-8?B?YWcvNXlubks2cUJ2VUhBZ0RkeHZuVU45R2Z0WURMR0J3OXZjR2wrRU5ub0Uv?=
 =?utf-8?B?R3NySllmY3RzUnpKMjBrbk1VempEaXlKUzZmL3FGTEZPQ202MzBBRWxhdE9y?=
 =?utf-8?B?SE9ScCs1d0drbURkVEN3Y0s4bGdqZ3hTMXRlOTg2aEhNUmVLRGIwS21seUVY?=
 =?utf-8?B?U0l4QXU1dllhcmFJYS9ZQWV1RGxSM0F3RkxFMisxQXJjRnUzeWJvaUpVSFlB?=
 =?utf-8?B?K09pRXFWcldkU3hPN1J4SlZiSEwyM1JyczZzb2Z2MUZ2bzY2TGVUM3duQnhB?=
 =?utf-8?B?MkpWcWNyWExPSTJ2ZWhyVlVKbTFNTHNoK2ZEbXgxRDhXTFBQM3k2ZUQxKzU3?=
 =?utf-8?B?QXJZajk0Q0lZeVlNZGNBb2trbkVQRUFRVnRtU0pCOVF6L1JIdGIwdW1PWldP?=
 =?utf-8?B?dVJZNUNxZFNSbTNTQWl1aVF3TlJ5R3FpeGNEZUw1L0JkZlZmamV2U1FVbHBT?=
 =?utf-8?B?L3QxVXArUURSQWc1ZGQ5SCs1STBpNERJWWZ0dlBpVFBVOE96L3R3V29PUnll?=
 =?utf-8?B?dEg4amQ2cWRFdDJkSmlmSlhtWVU4UUxqNy82Wmw1WnBxOXZYcjA2Mzh3K1cv?=
 =?utf-8?B?Z1NjZ0RMV2ZSY0RiV0M2aDlybUcxUnB5NlIyNE9RNnNLV2R0bWw0UURUTHJi?=
 =?utf-8?B?NVFYcHdUcWdORG5LS0o2YW9qY2gvdmJiamNPNk1uVXpxbjZhT1Q1dTg5Uk1z?=
 =?utf-8?B?SCs1VEFpNktUeWlJa2NwQ3J5d2x2WVFXaTB0cFFvSUpiNkg0ZHVFWXYxS1dY?=
 =?utf-8?B?R0NqTlRtZFYzMzFTZUlRVUFoKy9YT25aSVlGWmhDU1V6Q1JCVVBWL0wybEYv?=
 =?utf-8?B?ZFR4WVBKUlZGSXlIaXczODBmVmRVT010ZlppRHljNnhSTWhKRStVUy9YamNG?=
 =?utf-8?B?OTlXc25pd2ZBS0t2K0UvQTdxYVU4bUdlcEtXcXNEUWU5dVMrU01nT21XN0hh?=
 =?utf-8?B?NmFvZDdqZlUzNzRnWHFWK1BkQjJGQ05uSnVaRktpOE1rVjMwYWtnb1JvbGZG?=
 =?utf-8?B?OVhNb2dSVmtrVVhQUkFlbUt6TjhZY2c4aG5mdWNWbUlNcjQweWNvTHhOYkdY?=
 =?utf-8?B?VUJBLzQvUHBESkRYczhGSC9zVEdHdVYvbGZ6QnBhZXhxY0Z1QmJldktnY3lB?=
 =?utf-8?B?RzFpMnN2Z0J0U1M4aUdBZ2MrZWg2M1NrZE04bitLby9NTUphdVp5WXFrNzhx?=
 =?utf-8?B?ZnpKWk4vd1RmSTF4d2NxeTFQRmVNVnZtRG1nTGc4WkZhK2hFeUVuRThNUmVY?=
 =?utf-8?B?Y1BpM2YxSEU2TzJOWlYzNk5TblA3bG4ra01vV1hRNVEzSHJzMzR1ODJvN0Iw?=
 =?utf-8?B?WFpKWjdob1hGVHBWUWJWanVJYlNWK05FR0QvRlRJMmg5UE1tY3pMNElWdlVx?=
 =?utf-8?B?d0VTZElsT1dvdU5vNDdGd1NYeS92REhVZjlacUZ3ZDI4MzYyWm1JOXN0aTQr?=
 =?utf-8?B?WkpIK1FDRm1RdUhndXpwNXZ0NlZtWDd6dmgzRVFJRnNsQ3R6MnB5VmROLzhz?=
 =?utf-8?Q?/t8ctizDxpPF7qYtKTBCsjaTf9roxu7lInk1C9qzjL+g?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41B65AE63956F64EABA135507CB77880@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f91ad4-7058-43ad-ac0b-08dc93fa5adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 03:04:25.4985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pk4tk7PavKp1gskWxCFJyAxiuwuMU3/bAH2m4fj7KGbvtDJeTvOlroMFydBgR41myf31bjSkW2IzWny/pn9t0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6718
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240623_200447_869211_8FCCC9DF 
X-CRM114-Status: UNSURE (   8.82  )
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

T24gNi8xOS8yNCAxMDoyNSwgTmlsYXkgU2hyb2ZmIHdyb3RlOg0KPiBUaGlzIGlzIHJlZ3Jlc3Np
b24gdGVzdCBmb3IgY29tbWl0IGJlNjQ3ZTJjNzZiMiAobnZtZTogdXNlIHNyY3UgZm9yDQo+IGl0
ZXJhdGluZyBuYW1lc3BhY2UgbGlzdClbMV0uIEl0IGlzIGZpeGVkIGluIGNvbW1pdCBmZjBmZmU1
YjdjM2MobnZtZToNCj4gZml4IG5hbWVzcGFjZSByZW1vdmFsIGxpc3QpWzJdLg0KPg0KPiBUaGlz
IHRlc3QgdXNlcyBhIHJlZ3VsYXIgZmlsZSBiYWNrZWQgbG9vcCBkZXZpY2UgZm9yIGNyZWF0aW5n
IGFuZCB0aGVuDQo+IGRlbGV0aW5nIGFuIE5WTWUgbmFtZXNwYWNlIGluIGEgbG9vcC4NCj4NCj4g
WzFdaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIzMTJlNmMzLWEwNjktNDM4OC1hODYzLWRm
N2UyNjFiOWQ3MEBsaW51eC52bmV0LmlibS5jb20vDQo+IFsyXWh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDI0MDYxMzE2NDI0Ni43NTIwNS0xLWtidXNjaEBtZXRhLmNvbS8NCj4NCj4gU2ln
bmVkLW9mZi1ieTogTmlsYXkgU2hyb2ZmPG5pbGF5QGxpbnV4LmlibS5jb20+DQoNCkxvb2tzIGdv
b2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0K
DQotY2sNCg0KDQo=

