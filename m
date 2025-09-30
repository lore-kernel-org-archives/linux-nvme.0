Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD8DCAC5B0
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 01:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZYeaCuXOby7UKLe3cBYHjw9TaiMRqYg+HB7Q7Vfeu3M=; b=ZErGVpviLiFE10TRg8FeL1U3yJ
	xt3jBu38stOXIQ3XVOLtyXVhQX5NbZ/jmL7vlUHmr+Vl6FEsgDGvpXnbQnw1IieLTyNPc8NNkDX7K
	cDJA3BAObyrBxP7At1hVnDcfv7cW2kYmdUVM5fTrKGesOFkzgxFrnpidFpieyO2AHwyiiRiv+KLxl
	eJHS2TscHZjdIUDiYG3w32M/2rz+fG41yuIDRdDyeEYiCMrlqIqtSeLSKIN01xmKKvIEGYGslRlfJ
	3n7lEi8o8VdKJOudUPBmoGBWgqN0BcfLN0NgO/emcYvd3pvcTurUYZF3F5vuNa9bB21kF9NvqxUsb
	o1fDU31w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3PPJ-00000003oDM-2x8A;
	Tue, 30 Sep 2025 01:43:57 +0000
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3PPG-00000003oCo-0pTP
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 01:43:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXhwAhg0YIT+dQKUT4lNIIdZ47bTWj9bpvGutsN5uDuiFpUtoF3IjYIXaenGz+sNTxGXR5UHocTsKE+/IiXIc7s2d291PZCelm2KkrYHWRjU5tOQLWEKPpZkoFv9lw1K1OAsd8ubkRpvU2H1JU82lXe1hjL7e2VQtFi90qC2MQHifZqHFHnNg/4z+9M2q7rB10mCDW3FFUUSHSG40/EaP6I8fLijtTAIUivCHl9YwYVqy9SX2/DhiiCWvy/GVMHZBrdkvhBuv1jMSfD6trAoXeHNg5rL9ackF0veMKC7IGWopLazpVJJ7/M6IGHyv2CR1XarvLtyR9rKy+iOxfdHpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZYeaCuXOby7UKLe3cBYHjw9TaiMRqYg+HB7Q7Vfeu3M=;
 b=WcS6hXotwuJ61fuHFNSIHMzkSlHr+KdNOdPiYpZ9ZjXb1YLfni7AoJw13cvV4Xm2+kj3wr6qYcVKPwBJ7IRK9rKKGieZRVRk7Xgcp22xPYcNuS7hJNt4fQt3KtqtLFuQEbwyy3htKi+4ZVxIyJ9kFA4nlvSXpnP8xPaysaMqrtfyDhNQQGh3FTEaxO17560IMznJ8Cg8JcB6oSQzuVPoyTf+Vu4O3wStULKG5BC6J/RCeXkfw+OfYcysdvGM84qHax1UZRydZahvDxudf7yTayYPijHBfgwZVZD2oWndNLWX4ga+yZKFreGlXwxYQnwNgKAauyRE/IaeqQ9wlo8+xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZYeaCuXOby7UKLe3cBYHjw9TaiMRqYg+HB7Q7Vfeu3M=;
 b=aGu3vur7cmC6H6iKG5wrWt+J+y6FnZF0g4/ECdZzYhDgpaiwjCpY5V2monIM21sz4rNWscr/3GEHuTAFTNg924QWu6KFKyeK1c0+DUj+315MlzddavAx75/R9HgUKj6N/7VLD3oAVI3A9PpkOgBdPxkuXiDCsaOXEJR56mpTYobgyr6ZffuA2BgkOe7vdANfN1mlgqxryalp1UVzvhzOfK73PuJxjxBW/ZuGwZDP3Un/5B0G122/HKsmrZFdmiKkhPMQWgdJ/96i4EsAm5c1+8RchPiCxoFSahENkuuF+7CelYK4HvgQJJjtfRG+OQbTWplAuE10TsmHJ2gdeV2cDw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS0PR12MB6437.namprd12.prod.outlook.com (2603:10b6:8:cb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Tue, 30 Sep
 2025 01:43:43 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 01:43:43 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "dwagner@suse.de" <dwagner@suse.de>,
	"johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Israel Rukshin <israelr@nvidia.com>, "shinichiro.kawasaki@wdc.com"
	<shinichiro.kawasaki@wdc.com>, "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org"
	<kbusch@kernel.org>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 4/4] nvmet: add --qid-max support for subsystem creation
 and setup
Thread-Topic: [PATCH 4/4] nvmet: add --qid-max support for subsystem creation
 and setup
Thread-Index: AQHcMG5J1Yy0rTlbUkSnnzWF7ds7hbSq9nAA
Date: Tue, 30 Sep 2025 01:43:43 +0000
Message-ID: <d394dbe3-6b4d-428c-a5af-1e34b59cacf2@nvidia.com>
References: <20250928115125.38383-1-mgurtovoy@nvidia.com>
 <20250928115125.38383-5-mgurtovoy@nvidia.com>
In-Reply-To: <20250928115125.38383-5-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS0PR12MB6437:EE_
x-ms-office365-filtering-correlation-id: 9be852d4-9b23-4df9-5f99-08ddffc2c9e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?b3ZuekJKV3VmTHZMT2duVlJ3NVp6Mm5qR3FQclpPZzc3b3kyVklob2dybC82?=
 =?utf-8?B?Uk42UEVKNFM1VE5Bb3liejJvckF4YWZqOG1ldVdWVDI0Qk1IWHNPcVRJMzBB?=
 =?utf-8?B?MlZVcDlSWVhvWGFVRHczOGMvUytWYnVlY3g0TmJZZThWTEw4QXhOWCtBTlpm?=
 =?utf-8?B?aG1NMkdoMWxvZU1hUFpHR0hpK1dPdW1kdXUzTG5wcmdJaDgvdEc2UjlEdG8w?=
 =?utf-8?B?WThJazA1ZENRSE52ckUxSENiM1E0cXJhRFFNWVZDR3J3bmpVSXRXNkRkcjYx?=
 =?utf-8?B?MkwrTWhuOVVEdlYvdDJhc28zU2RyZzBBdUtQbWRjd0J4SmFwaW5NRDBXK0l3?=
 =?utf-8?B?WnFTbTRJUGxhWWprNjFkWXY0dEJXY1dzR0RZdzBFdW1oRkJFMG10RTVMWUJk?=
 =?utf-8?B?QU9YeVc5M01Mayt4eGRwd0NQbnJZcnV3NGphdjdkQlRQUEpPdmlrVFVLVFlS?=
 =?utf-8?B?US9WTnhPTGp6dUw1WmxLc2krOTJZaHVGZ0FveVlZNnc3ZlJzR0tJODcydWtP?=
 =?utf-8?B?RVhDMWRSZWk1ekoveHlaaDMwU0lLZ3RmNCtqS25uNW9GQjZXSTBaREp3dEtC?=
 =?utf-8?B?aElxV1RtZFh5a2doU1pZVUpIR1V3UWllVWtyZDlSTFltUVlGMXAyaXVMWEZE?=
 =?utf-8?B?eTc3NWlva2c2QzJFUTRjNThoR05tK1VaQ0NKQjVIWVNEaENyYm8xTUN5L0g1?=
 =?utf-8?B?TUxYOXcyTlpzQ3JOd3Z4Q2NxRDhmdEtyTm1VQkc1TEpSWGpqR01yTmZhMHBH?=
 =?utf-8?B?U0F2d2VRZEhycm1OelhDRlkwVzBzZUxaNm5XVEFGMXp6WXNiZ1oraDhQQjNX?=
 =?utf-8?B?OW5LbDFjaUEycStwQjgxMTZ2bXVVVHd3VWdMcHk4MVdlY2wxc3BWOElYZkZu?=
 =?utf-8?B?dlAzcGhBZ2g2TlhMN3dMc0lWcDZNSFh3Q01uNjhJbk1mdVBlWDZFRzRhbTlM?=
 =?utf-8?B?SVFBTm1DWmpoOGlQYlpEWC8yNTkxaHZnaWJHSkszWlZWVStjUWVPdXNRSEFo?=
 =?utf-8?B?WE5IdmQ5VkEwd3BhYXpGUXIrZGk3VHZiaWtvNXBHWUtUeVdyRXlxS2NYc0Zj?=
 =?utf-8?B?RHljSUowSGJCcnFucDM3RzFLVy9hbEhBRStieXlqVllXZFF4WVdrRXBXOE96?=
 =?utf-8?B?bVQxa0d3U0xkL1lERXNOUklLOWNsdCs1b0dZcUQzZE1BTXVBTnRvK0lHNEJS?=
 =?utf-8?B?YnlyK2hJTXpVNXpVTDE2V0M3QXZHeTltUWVJOEhsWSt2VDVHa21UdnliVytP?=
 =?utf-8?B?MTdUbWNnSkFrdUZwSUxEd0labzhTQXk4TjM3djhoUjhMM1Njbk5wTXZPbjZs?=
 =?utf-8?B?dGVxMkxtMU9EdjZDZmxscFFTd0twQTVOd2tPN2ZJQnZLQWg0NWtWYUpuN2N1?=
 =?utf-8?B?SFZraUFnWnEvL3hiTDJjMzQ0bzJZN2NiLzlHY2QyK0xRZGVKcDZkSElPaEhU?=
 =?utf-8?B?M2RpNEhFK2pWcDA5dHdkK2NpYnhuQWRSakRZL3o2ZW1TRC9vS3N0TXM5QjFr?=
 =?utf-8?B?Vm50TVBaT2xlZytnMHFud0w0a2s3L29ZMlFVbi9Kc1l2N29NYVVHU0tKNjRv?=
 =?utf-8?B?QXU4R2RDdjRKL25QdmJqS0FOMEt3ZW9FSzhCTHNPbi8wWWZQbFdZQk1TVFlL?=
 =?utf-8?B?UnFKUkdRZG9Mc0I5L1JENnJnNXhrelVvSzhnZ090dkNYOGNBRmRKVzFtZ2Vw?=
 =?utf-8?B?NWp4ZStEVlNSVEtqdHBPeDh5TlNoYitnMnJ4bjNjejBmL0FxMjhyVzNsOHVZ?=
 =?utf-8?B?bmw3SHQrMndxRkM2ak5kUUROSmNYTUdOTjdCd0FjTStCU1pBcjRVeWpROEcr?=
 =?utf-8?B?UGFlMGs2UitHeG1pT3FOdW8xaHdTWUtsQUh0cHJJdEYvZTg0V001ZDh4eE5V?=
 =?utf-8?B?Q2RaZ1V6YkZ5WG1WNTdhNjhKYVN3cTNFVzIxelAvZGQ4SXl3ZXBnemRRaERx?=
 =?utf-8?B?S2xVcDNrWnlDdzNmaC8wbXU0TkI5d05STTBXc3dVSWVZeGR2MmVwR0w5WmRK?=
 =?utf-8?B?aGFpa2FWWWxGNTVDZFFCTTdSUmxzTm5Icmp2V0pnR2h2ZnJzSWppT2ZQNnFz?=
 =?utf-8?Q?PS1T8y?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SDNpR1lSOEQ2MmcyMDlkeTBtY0xya3hLYWIxOXo2OUJqR21KRGRJTCthMEl6?=
 =?utf-8?B?N2dDWER6MzVRVkJQdVBmTFVhWEdPVi8xcWtGRnRRRGs0SkFWK2xFYnFJaVdR?=
 =?utf-8?B?MFY1bDFrNVgrdFhtSGVZSDdla2pHQ0lhUVlBN3REUjZvVlYxWjZ1dG5wa04w?=
 =?utf-8?B?dUhGSUVyWXlVY2V1azQ4RU5iV1BFc3JHdmZmaHdybmgrZ2tvTlVpTm1ndC9X?=
 =?utf-8?B?RnJacHV1M1VRc1p6N1pqZ09xWElPaFByY3RMRy9IWmlBY1V3b0VOVldIRDBz?=
 =?utf-8?B?RlpIdDMxbDkrajVFWGswVzZTWngwM0JHeGRMazF5UG9JNXcydmIzRkJUdWw4?=
 =?utf-8?B?dDNqQjY2bjZrR0xkYm16V0pZTUNiOTVhblVPcENsc1JTNVZ2a2FOZStuNHRr?=
 =?utf-8?B?eC95RGhhelJySGhBYWF1dkY1c0xTOWZiM2pHWUtjbUpsallpL1NZZHJrdU5E?=
 =?utf-8?B?Nk1mTW1uMHRRZ050SjVZNDJmcnZLMHpWSEljVlZIamZyYy9qSmxPM0hZSmNG?=
 =?utf-8?B?bE9SN1FnRENpeVVYZ3prQWRuZVF3SnpXbFY1cUlxSnNQNjkvN1l6MFFuYjhK?=
 =?utf-8?B?OCtPLzlTMXdUODJoOExSUTh3UGVRb0RNQTRiQ3Y5OVlvUUkwUTQwNVBZK3ZG?=
 =?utf-8?B?UjE3cFlnRC93L0hsSWsvTFQ3N3NVRmd2NU9SR05VTDZMSXhsZ2EzWmI2UCt4?=
 =?utf-8?B?Vk4va20xenhzSFZYZmNHbDF4SlFYODloT1hYTEJRWGlZSmV3RVBXYTVkd2Z1?=
 =?utf-8?B?RktHYXcrZDhmbFVnMkNYU2FZMEt3cUNoT0xMNFpSZlo3T1BNWVc0czJUNHlV?=
 =?utf-8?B?MlV5L0UyQTNRc0p1UFNpQ3FMZ2ZzdjRqQTAxMDhoYWhXekc5WS9ua3p2Q1Nt?=
 =?utf-8?B?T0IwaUtndzg2YnpYdUV1aENERG9sa2JQNVN6UTcxSWxUS1NIWWk0Q21Bbmw2?=
 =?utf-8?B?M2lrckk4Y2JVWlZEczZlSkE4Wnpad0RHZTVVbTVNOW1DT2cyRmVVeWhmZGxB?=
 =?utf-8?B?MTVCQ2s1N2tuM1g4eUw5ZGJJeGUxTk5WTWNwMGFOMU9vQVRIbWpKVVRYTTBI?=
 =?utf-8?B?Q1ZVN2VzV3paL3h4Y0RrUkdFd0dZeHcwMWJGc0hlSU1VZ2NDWk9ta1U5a2Nu?=
 =?utf-8?B?UGFTWnBrY2VhMmNLb0RKbW1reFNsV2xXUksrZ3U1anRoV2xoMHdnNDNEMGtn?=
 =?utf-8?B?ZEZYbjVWMmdGYUdyUjJaRnBld1B0MFNoTTRGbEQ2WnFvZ1lPWnRjcUdzNmsz?=
 =?utf-8?B?d2tCS2piK2pHaVYxbDA4RlZZVHJjMWhRMHJONXlZWlpvL08vSlN6NEpKWUEw?=
 =?utf-8?B?MVAySG45ZmU1ZlF4QnBpeG9sOE9Jcm9SN2FWZmxOYlFKeGpBc1RTUW9QT0RM?=
 =?utf-8?B?Njl1dmViRGExcDVXOFpsWWpyVnNmZjJjeUFvYUh4ckVUc05PZXVoVWh0N3U1?=
 =?utf-8?B?a0FXMzQra21JM0t0NGp1cWdTTUpaZWFUcnVuZU9wYzd4QmVwMmszNGVuamts?=
 =?utf-8?B?WlhYaGxOLzdpUnRHMmdBU0I3cVZSR05jZ3Y1S0tGc1JndCsxSkRuYXhETVNa?=
 =?utf-8?B?UEl2N2lHNG1WQnhvbWZDTkh5SmowRWtjcTNWNDhPeC9uMDBPN0p5amdBUk5p?=
 =?utf-8?B?T284SUNJNmNSdzJ6RURsaUNkU0FnUFFCRWo2Zm9MNXlWT0ppQmpQYWNTSlF2?=
 =?utf-8?B?SmVNMzRsQXpSalB6YmNqM2w3c2VXbnAvNzArT2V5ZTdJa0EyakRMbW5ySTFi?=
 =?utf-8?B?dlFyc29sTjAxcE9jRnMyWlVNb3VnNWRpYllWYmlXNTNhcmdLSFpoVjZjMExh?=
 =?utf-8?B?L0E2KzlleVoxdzRJWmV6TEhxMk96MzZYZjlJQkd3dW5ZUHZkL2hFdFRpQXZp?=
 =?utf-8?B?NzB3bk5pYlp4M0tEMnphU1JFMFlmSU5uLzdYVklPTTJEK1ZPQnJKZU1NTFNH?=
 =?utf-8?B?cmtUbGV1QWV5U1hlSlN3NE02OXUwdmJTZXh1YVlQZk5yZlErMG5adDVFNmlq?=
 =?utf-8?B?RTZlRUl0bm04ZUcxYjdjMlVaTWt1ZWxNTm1hK2d6cjRvMUJYNXJnK21zT21O?=
 =?utf-8?B?V2RRQis1RG1xZkg4UUNmZUFaQm8yamFOVnZjam9sY0JTMlVqNytIRVljUHN6?=
 =?utf-8?B?YmpXNmprSysvZVVlN3M3QlVKS2ovNk9vTWt5RThsenhvNnBqUmN6NGJLbCs2?=
 =?utf-8?Q?rZkiVGNZGJnH/ktb80s0JM17d5J/zV5TDh4uzOMYQ6LO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8EA045E134E55B439230A6E78B6CBFE4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be852d4-9b23-4df9-5f99-08ddffc2c9e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 01:43:43.2307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uVifFmUjEUGxobGkkrAc8pkwgT19Qr2E4rA0LJmz4a3nzFbpvhlyUjpjD74lI3jVggGgLvf16C4+VMcnzqRU1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6437
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250929_184354_625944_A5B58511 
X-CRM114-Status: GOOD (  11.97  )
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

T24gOS8yOC8yNSAwNDo1MSwgTWF4IEd1cnRvdm95IHdyb3RlOg0KPiBJbnRyb2R1Y2Ugc3VwcG9y
dCBmb3IgdGhlIC0tcWlkLW1heCBhcmd1bWVudCB0byBib3RoDQo+IF9jcmVhdGVfbnZtZXRfc3Vi
c3lzdGVtIGFuZCBfbnZtZXRfdGFyZ2V0X3NldHVwIGZ1bmN0aW9ucywgYWxsb3dpbmcNCj4gY29u
ZmlndXJhdGlvbiBvZiB0aGUgbWF4aW11bSBxdWV1ZSBJRCB0aHJvdWdoIHRoZSAiYXR0cl9xaWRf
bWF4IiBzeXNmcw0KPiBhdHRyaWJ1dGUgd2hlbiBhdmFpbGFibGUuIFRoaXMgZW5hYmxlcyBtb3Jl
IGZsZXhpYmxlIHF1ZXVlIG1hbmFnZW1lbnQNCj4gZm9yIE5WTWUgc3Vic3lzdGVtcy4NCj4NCj4g
QWRkaXRpb25hbGx5LCB1cGRhdGUgdGVzdCAwNDggdG8gc2V0IHFpZF9tYXggdmlhIHRoZSBuZXcg
LS1xaWQtbWF4DQo+IHdvcmtmbG93LiBUaGlzIHdpbGwgZm9sbG93IHRoZSBuZXcgbG9naWMgYWRk
ZWQgdG8gdGhlIE5WTWUgdGFyZ2V0DQo+IGRyaXZlciwgd2hpY2ggZm9yYmlkIGNoYW5naW5nIHRo
ZSBhdHRyX3FpZF9tYXggZm9yIGEgZGlzY292ZXJlZA0KPiBzdWJzeXN0ZW0uDQo+DQo+IEFsc28g
aW5jcmVhc2UgdGhlIHNsZWVwIGR1cmF0aW9ucyB0byBhZGp1c3QgcmVhbCBSRE1BIEhXIGRldmlj
ZXMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IE1heCBHdXJ0b3ZveTxtZ3VydG92b3lAbnZpZGlhLmNv
bT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFueWEgS3Vsa2Fy
bmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=

