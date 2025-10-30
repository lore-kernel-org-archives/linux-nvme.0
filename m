Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B04DCCF9F0
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Oct 2025 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d1f3CJDPSDRH5v6TqoWKEeBsmy2Qg7Vq6NcERdbxBvQ=; b=o4f+9tc5B8XzKDeusF6p7t7nYN
	ic0Qic2ZUteeFPRYK45vcQan1vIOxKESPbbKeo631aBT1IXt+GKSln8RJR972BsbCmd/k9vMEKJ+W
	TfuC3lx7QmJ3hznTWDlgYCEXnrtOqheTVtF50mnyLecRBcqZOnJ9XsXgH/mDRq3KDBd77Oac1kRgz
	dQxNWxyfrVdxLXwKNzpKlwgbPm6JuJYOrqJ36ezsTwEV3kLPOTLvq4MKnQdeF70fXwtmzCqXbvuAP
	4qkkw+Hl04EWXrxFWdHh0lzPQJMn+uIJUbs4t1nawcmf14ec2Aa3RrEWAqVMs2iqmWuXgAExhpWAm
	MlAHyYUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEMR3-00000003aFK-3uTs;
	Thu, 30 Oct 2025 06:47:01 +0000
Received: from mail-eastusazon11012066.outbound.protection.outlook.com ([52.101.53.66] helo=BL0PR03CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEMR0-00000003aEn-29jB
	for linux-nvme@lists.infradead.org;
	Thu, 30 Oct 2025 06:47:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlR70fipTG6BlwrP0RFPnQqlJt6MiYigmwok7aFIaB3Dj6J8NndeFgSDnai6gdJCcIwmpsh0IAJoqH8MIw1VpCa4mqcMyl8wmH6GViphJfn7Z8G8LAGvSm9PlxpRB0aOgOkVNlKEcQRSxtTdsaPDEb7Gshf/ScGqQR4NrUYrhr0Kb7FcV8IHcGTkKg8lSra0+iPQP7GAYtULEEYVbMqdM+Y2YnHql+xkOLT/fOStBX+kqvLlocRf+qs3mJsr2g9HGXSaTTs2QEz4Uw9vk7Omlm14MhZtUsON2Tk3VPTo7N+2LvtYTO9OqR4fb0EiuGoR7ZCve2u37nOKJE3JX7LgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1f3CJDPSDRH5v6TqoWKEeBsmy2Qg7Vq6NcERdbxBvQ=;
 b=dDhk2290zgPfdpoE8aOPBF0dVkytlivJBxmGkEKseuo0Aa6PT6c6NI0VcWTbO812kanYxiyucuJegABCfrWnR8JQM3jghavpucF6qer6xL/ZRjUMgwqP87wODafgV7X6DNg2bDA04MB1agvlGidO4JOb8mkH2lzCMlFHw30PjgQGhT1oLTOvZO1HxxtDGCOmjTNrDhEQH+2VDn9Dj0PzgxM8ZqubKLId9xD2W5QXstUnl+lZiDOuw11Is5OCi8nYkPZZuJZqCdg06GOMnuRBwBTJzqwfNrj2i47/hX4WWPPO6DTWBYegysL1ybJFM2VZOF4Acdvh+nL+L7vrc1DP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1f3CJDPSDRH5v6TqoWKEeBsmy2Qg7Vq6NcERdbxBvQ=;
 b=nEKwdXMkWwa+bTJWk3YNoTU2ZDPKtIzy9H7rBeWodt/tSdZpO0FPCLgZZn+0wlopwrYSXqNHktYs68dvhWchbIG/Hrn1YO0HrXvKgDJFBSa1rPgu7LYaCbzJ/q+chppcAhy8N6O0zodH3h6sG+8VcoGlyixWP3rSYhN+TBtIQg7Lhmrul/X87O8bIch9JlDrKJVeihXpzlRuxIkxcwhSU5meDOuTGzQffxkNLOiTzvqxt0kt90iwoAcYm3eE9VnWCdxdMVfNmqlCLM+YHzEOvzqwsgHqXAK2Nzwl/yLGH5zQ86GGuJmWKLtRehOQ1P+JFTxJFLGz4TEuBny4AA4R1Q==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BL1PR12MB5899.namprd12.prod.outlook.com (2603:10b6:208:397::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Thu, 30 Oct
 2025 06:46:53 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.9253.017; Thu, 30 Oct 2025
 06:46:53 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>, Maurizio Lombardi
	<mlombard@redhat.com>
CC: "bgurney@redhat.com" <bgurney@redhat.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] nvme-pci: expose active quirks in sysfs
Thread-Topic: [PATCH] nvme-pci: expose active quirks in sysfs
Thread-Index: AQHcSBeS/Wfpc7fZOkySrLZKHYolZrTXwNeAgAAHrQCAANZrAIAAJYsAgAECEACAAHNMAIAAB+0A
Date: Thu, 30 Oct 2025 06:46:53 +0000
Message-ID: <f0bf5480-c66c-45a5-ae85-5bc0ff1bc172@nvidia.com>
References: <20251028142916.700438-1-mlombard@redhat.com>
 <2bfd5388-0bde-4f86-9edf-fb74dd0d4c79@acm.org>
 <DDU46S76MOXJ.XX5QODFDZTZN@bsdbackstore.eu>
 <08f479ed-9817-4806-bf68-c929c8a844a6@nvidia.com>
 <DDUND9A6HFVR.14U2BRGS72CEP@bsdbackstore.eu>
 <5f38e8ae-41c3-46ef-ac3d-b6e1c106379f@nvidia.com>
 <DDVFSEFQUAUU.25A7L3KG2PBT1@bsdbackstore.eu>
In-Reply-To: <DDVFSEFQUAUU.25A7L3KG2PBT1@bsdbackstore.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BL1PR12MB5899:EE_
x-ms-office365-filtering-correlation-id: 0f05e6c1-9fd9-479a-b6e1-08de17801c56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZUp5cElLRENEUFBEdU94bUFUOEk2OTVFQ1c5SWszcndTZEhQWnVJWGxlZzRp?=
 =?utf-8?B?QW1wUHlWMlNZVEZ0Zi94Z0c1elFuN2lZdnYwMW5aaEUvcjcrdTdWaDcybC9C?=
 =?utf-8?B?Vy9US2JlcVdQTjNaZEJWZ3cwTUMrQTNPeDZFRjJBdVRrMFJZeTBmMTgxZmFO?=
 =?utf-8?B?SlFOTE9hd0NxOTBtdGRRSjNrR2JacGgzaTBJU2pNY2gxNWwvdWo2Mm5sTThx?=
 =?utf-8?B?L3lzUmRyY2dIV0dodTJYVVlKWGQ5OEd2eTZmVFd3SVN4RUo3NHJ6STFFdFhU?=
 =?utf-8?B?b2tFRDdScHJhOWR5VzlPc0JSc09yTjEvRHJTbU5OUmNCYjRDWEViUi8xN1Ew?=
 =?utf-8?B?NTArc1dmaVZjOTNaZkl3MFhXS0tpNHgvbU12TGVDejlDYno1Y3hqaFMwZUlx?=
 =?utf-8?B?bmVvTStmdmJoTHE5NjFUb3R5MEwyZ29Xc1ExMlZLcFh6Tkw5bXJ3M0Z5dC9x?=
 =?utf-8?B?WTZQNlZEUmZ1Z3BCS1dEcVBLZXkzTkd6MytiZ2liZjdRa0V5UEVGTE80dmh2?=
 =?utf-8?B?S0Y3SjJXZlRGMDJCS0ZVdjlkcGFBdlVHRjAxWS9oYVJDdWViZ0dVbDZOVWUy?=
 =?utf-8?B?bGdPRmZvQXJhSlQ4SHNwVDNpYzl6Y21OeUE3ZFZ3b2k5SDdqTElnR3pKcHU4?=
 =?utf-8?B?VitRTG91R2JjcHpzdmVwSWI3aDJFdmE0cU04RXZwV0gzYzhmN0V1ZDcyTk1G?=
 =?utf-8?B?UC94cGdZMkZSS1JaS3VtS0VrajZrYnUyUi9mYWlnd1hmc3ZCK0tGcWVUVUJL?=
 =?utf-8?B?elJnaHBjOFlKSXRyMWR1RzI5UGw0c294SXpBeWFqTlhaanI5MHV1VWpvSEdG?=
 =?utf-8?B?dkZPRklBM1V1SmU3bWdUeGI0ekFXWXJsR2UyYklqNFg1TXFYQm94emQzeUVm?=
 =?utf-8?B?OEdFYzZBa3N2NTZkbEp5MW5xWWJ0WFF0eDdScGpubURVUjBSU09ZbUhXbHhk?=
 =?utf-8?B?elhkRFBadUJxNU40dVl4K2ZKT3JFd1Qxa0RrUkp2c2xqbThwRjBXMnZMaVBP?=
 =?utf-8?B?dWEzYXFaa25nenRLeVN1ak54V0dOQXhaS3VRVHcyMVNLVHFPSEY2bERBb3Jr?=
 =?utf-8?B?d0dYRThZSXVkZVNxSCtZMjBpTDBxU0dhVXZIM05JSXZ1amFJSHdhdmtZcHcw?=
 =?utf-8?B?NzFkdmV3b2hUalNzaW55OW11aytqbGZra0xiNzlnbTdtVXdOOUV2aVVoRnJw?=
 =?utf-8?B?RVBEQkxzK253ZDg2bnRwT09TNGVpVDgydEVaenZjOTBQUnpobG9PbFBxaHF2?=
 =?utf-8?B?S0lpVUxQYUhubVN6cDNkN09md1Y2UEVGck1QT282N3hucmhESXcveVFBenph?=
 =?utf-8?B?cXdaZ3RGTkRyYmszd3JEZUI2SFFld1o2c3MxMFhBVDNNUXRiVmZGMnEzd2w2?=
 =?utf-8?B?blBmWHF3dCsvUXFQOERFWGQ4MXpnNWVMektqT2tGNXZoN2s0ZWhocjhKWjJi?=
 =?utf-8?B?eFA1TGxUMDRwd2dabWtJTlhET2pwZGpYaXYycDVzNWJSSVNsNElkUitSQTQ1?=
 =?utf-8?B?ZkJORW1sUHlKcjM2dUdkRmFwdElZOGR5WFJzOG1sdHFZKzU3aHByQVZOU2hE?=
 =?utf-8?B?R1psM1BzVVFabzd6bk1sOTNUVFl0U1F1dk5qcjZneFEweTZrTjV6RVA3VzNC?=
 =?utf-8?B?REhCRUx3cW9Nd3B3UHA3YVhmQ1RuOUEwZVdXbVVycUpmTlhSV1UvT1lnaGpx?=
 =?utf-8?B?WnNhenBhZFF4VnVnbjZJamdrT01BL1loRDlCY1VaQ2plNHFkcFdvNGpTYURv?=
 =?utf-8?B?RWRFaWs3ckFGRWtFY3BVYVUzM2ZZN1FiUzBOU0NoVHZtZnZRZWpZRjNiVWZQ?=
 =?utf-8?B?cjR1dGdVQXdvVEpjMFVaTm1xL29BaFpxTEhNQjlhVHRBZjR6cHpQRnNDQXBK?=
 =?utf-8?B?b0htV1RyREthK055S251b2NjVUMvSFdURWRURnlRdVdHaXd6TTRYY082a2tC?=
 =?utf-8?B?N2hieFFLaER2bkZJYW9iUjNUSENoT1k4aTlkS2dGaDFubG5BcC9PcUdxdjBT?=
 =?utf-8?B?TlNoTEZjSjRyd3dWUHloeW1RUndhUTVtblFRMkN0L2QvZDdYYmxVN3dmQ0Ry?=
 =?utf-8?Q?02Pkn5?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHVxblU4blJ4aGlvTU1lcUViZnVUOXBUaGlRKzFxaEFIUytMVlY5OGJkT3d5?=
 =?utf-8?B?TzM3Y0d1R3U2eDIrUmFtWGV5Ni9YOEMwclFRM0ZMYUU1RE1qb0lndDRrcDJp?=
 =?utf-8?B?Z0dKTlZoMFZXeW5MQUxzVC8rVktjUmZRN1QxdTBJRlVsSFcrMCtYSFlKMW5B?=
 =?utf-8?B?RVRib2REVS94dkV5bjE1NkpXcTBGTkJUdStabHVjL0FWTzJZV3FIN2lDS250?=
 =?utf-8?B?Z2crdkJtbEFNdmFJNUVCVHNKMzhRUnh6dVY4K1NHN3ZXRFVZOEVsYk1ha2Qz?=
 =?utf-8?B?cFdxT2lUTE9NK1Y2NG9KR29BNk1ramw0ZnZldDNCVmg5NGRTREkvWlRLb21R?=
 =?utf-8?B?dDBiU0RZNk8rVGxiV1A2UnlYeFk5WEppZnA3bVVtQk5pTDRyckFLSXR6ODdh?=
 =?utf-8?B?RnNibTc1dmlRUDhWYXhaS2NvQW9IU0lCYWgvVG9UampidmhIWHZ0QnB6RUlT?=
 =?utf-8?B?WmQvQXMwOW5sYlFXczUvMlp5MlMzdU9hTW5KclBuUWNvaGhoZm9naDVOYVRP?=
 =?utf-8?B?M0JEMk5JbHZBQllZUFY4blVBaXcyTjlqQ0J3bitITHhJNGxxRFNvS1M3cUFC?=
 =?utf-8?B?bTJOajFSUm9EUG5mNGFNMXJrZUdVR01VZ2FtUzE4Z2RmNVN6WXBYc3NWMFlX?=
 =?utf-8?B?cEJyQXVnVVcvQkdEQ1ltRGpTV05BdHlKM1R2aWVQbG1OWExVL1JWVlNKVWlF?=
 =?utf-8?B?L3BhSUtydGticEdudGNoWTU5MXpzVERFRmM1QUJzSEJlcFBvUmtEQ3VtbGt2?=
 =?utf-8?B?NkFReS9CK21yNTc3a2xld2dLSU5kWGRvSlk5WjVTTjczdEtCaDM0UnhBRE43?=
 =?utf-8?B?dDhmS2F5L1N5dXQ3bVZDUkRkeXlTeEZ6R0s1M0tveGN6b1VhQWpua3ZGdG12?=
 =?utf-8?B?dW1Ka2RhUlJKUkFPUmJDYkJnNWJMZVA3dnhjQnVLNG5SQy9Fcy9UNFhCOXJa?=
 =?utf-8?B?M0NheWJTdTgxbFJ3VmcwVFNRU2ttRmJxRlVnaVJHdUd3YmI1U2dzaEt6RU02?=
 =?utf-8?B?UkR1YlFHWEN0Z1pDSmpra0QrWFR0S1RwdlRBMTJKZkprQ1dTbDkrRkhuVjZz?=
 =?utf-8?B?akRhd2FrOXFFd3hIVlcwUkZUVUluejJwRUNybkMvYXhOMTBwOEVqNHVpMzBl?=
 =?utf-8?B?bVMzSXNJQnNXV1N5NUtoNkZ2Mi9rektMeXZSQXBySDJ2c2NISXQzZWgwbmNL?=
 =?utf-8?B?ZFpKTGNIQ0F2aXhNMG1ENlNVVTBMNWU2WVBkSnhXbjQ0VDRNV05kWUt4aWI0?=
 =?utf-8?B?TGY1SVR5RUdEdTQxRTFQQThKWkt3NHdodFE0SjQ3blFnbm41MG1Ja21Zc0Q5?=
 =?utf-8?B?clZ2c2gwQi9INlhhMW05T1p4UmdtWUhmaVYrNm5PVFhTMHVmZmlsQUNnZEZQ?=
 =?utf-8?B?LzR0b2Z6Uy8veEJQS1FhTmlEZXRQWk1ocE5WY2FVY2tPME12WEJXcDJGRjdk?=
 =?utf-8?B?czVBOFpaUnozTUhtVVdsVnJSVnQ5VGg4eEh2ZDBZTmdMa2VvWHg2WEREVmdL?=
 =?utf-8?B?eGdpQmQzZWcvWXJIcEplTWVEMm1XT2VwQkU3dXNaVzJjYmhvTmVSYll5c2l0?=
 =?utf-8?B?WlgrOEpDT2VCY3YrQWxoMS91S0pQWFEvQlhCS0lOcmhmZDkzTkVyMjNlQWpG?=
 =?utf-8?B?TlJBNm14S3NhT2JtSjR1RVpIbkErT1dsMjhVU1ZGR2tla2pLMVI1djMzOWZV?=
 =?utf-8?B?cFNyVHpjTHN0RTJ2YThoTGtPbm1SU0JMeUROZnRvbTRxL1dvOGR3RnBqVTVh?=
 =?utf-8?B?ZzNYZTluOXhtZGtYMys1bmhZR29iSzlIR1pNdGRxdlQ2Z01JcVFyakM0ZTUv?=
 =?utf-8?B?SjRkQWQxN0RSczNKQmJKOHBZbXEveHgra3FIOXUwbklXZEcySnZBNHJpNkhD?=
 =?utf-8?B?VnlVUG5tM0lHUzBSMi96MlMyZzhERUF1N3Y2dm1qQVlqTlA3anEwVS93NGtT?=
 =?utf-8?B?ZHZkOHlSeXBRdmVWRHlMc3hNVW84Y1IrQ1B0dy9OaFE5NjlDcUovZWxvM3dT?=
 =?utf-8?B?Smt5YmZHSlVnQXowVmtJT2M5M201VVlmQ3BYRWtHaFR4NXR0OHFRQ0JjL3lt?=
 =?utf-8?B?OGh0V29LMW9zdm9oYmdLd2hRbDJvcDU3b3k5SXFocVVObnhmRkg2Mk40Rm1n?=
 =?utf-8?B?RFlJNXVRbmttVWhvaVh3ZUwyYnBKMFFINXpRMnN5VnBQaXBkVUJUWU01b2Uw?=
 =?utf-8?Q?idzJ2oV5M8m3xoffx1E+gzAq3u9JI0/a/fxOjOLNK65b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <588226732775D64AA1EA7B8D680D8221@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f05e6c1-9fd9-479a-b6e1-08de17801c56
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 06:46:53.0978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cOsAI/hSVAxs0lGnR0vSWMf5rpsl86gd6UpL6kBCKl6HXf/edXQYJa9lJC3lxQ9qeeBF71zwkS14MrXuLP3kLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5899
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_234658_668942_8A419006 
X-CRM114-Status: GOOD (  18.70  )
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

T24gMTAvMjkvMjUgMjM6MTgsIE1hdXJpemlvIExvbWJhcmRpIHdyb3RlOg0KPiBPbiBUaHUgT2N0
IDMwLCAyMDI1IGF0IDEyOjI1IEFNIENFVCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4g
T24gMTAvMjkvMjUgMDE6MDIsIE1hdXJpemlvIExvbWJhcmRpIHdyb3RlOg0KPj4+IE9uIFdlZCBP
Y3QgMjksIDIwMjUgYXQgNjo0NyBBTSBDRVQsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+
Pj4gT24gMTAvMjgvMjUgMTA6MDAsIE1hdXJpemlvIExvbWJhcmRpIHdyb3RlOg0KPj4+Pj4gT24g
VHVlIE9jdCAyOCwgMjAyNSBhdCA1OjMyIFBNIENFVCwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOg0K
Pj4+Pj4+IE9uIDEwLzI4LzI1IDc6MjkgQU0sIE1hdXJpemlvIExvbWJhcmRpIHdyb3RlOg0KPj4+
Pj4+PiBDdXJyZW50bHksIHRoZXJlIGlzIG5vIHN0cmFpZ2h0Zm9yd2FyZCB3YXkgZm9yIGEgdXNl
ciB0byBpbnNwZWN0DQo+Pj4+Pj4+IHRoZSBxdWlya3MgdmFsdWUgZnJvbSB1c2Vyc3BhY2UuDQo+
Pj4+Pj4+IEFkZCBhIG5ldyByZWFkLW9ubHkgc3lzZnMgYXR0cmlidXRlICJxdWlya3MiOw0KPj4+
Pj4+PiByZWFkaW5nIHRoaXMgZmlsZSB3aWxsIGRpc3BsYXkgdGhlIGhleGFkZWNpbWFsDQo+Pj4+
Pj4+IHZhbHVlIG9mIHRoZSBjdHJsLT5xdWlya3MgYml0bWFzayBmb3IgdGhlIGdpdmVuIE5WTWUg
ZGV2aWNlLg0KPj4+Pj4+IFRoaXMgcGF0Y2ggY2hhbmdlcyB0aGUgY29uc3RhbnRzIGluIGVudW0g
bnZtZV9xdWlya3MgZnJvbQ0KPj4+Pj4+IGtlcm5lbC1pbnRlcm5hbCBjb25zdGFudHMgaW50byBh
biBBQkkuIEknbSBub3Qgc3VyZSB0aGF0J3Mgd2hhdCB3ZQ0KPj4+Pj4+IHdhbnQuDQo+Pj4+PiBJ
IHVuZGVyc3RhbmQgeW91ciBjb25jZXJuLg0KPj4+Pj4gSSBjb3VsZCByZXNwaW4gaXQgdG8gZXhw
b3J0IHRoZSBuYW1lcyBvZiB0aGUgYWN0aXZlIHF1aXJrcw0KPj4+Pj4gcmF0aGVyIHRoYW4gdGhl
IHJhdyBiaXRtYXNrLCBpZiB0aGVyZSBpcyBhbiBpbnRlcmVzdCBpbiBoYXZpbmcNCj4+Pj4+IHRo
aXMgZmVhdHVyZS4NCj4+Pj4+DQo+Pj4+PiBNYXVyaXppbw0KPj4+Pj4NCj4+Pj4gcXVlc3Rpb24g
aGVyZTogZG8gd2UgbmVlZCB0byBjYXJlIGFib3V0IHNvbWUga2luZCBvZiBzZWN1cml0eSBiZWZv
cmUgd2UNCj4+Pj4gZXhwb3NlIGNvbnRyb2xsZXIgaW5mb3JtYXRpb24gdGhhdCBpcyBpbnRlcm5h
bCB0byB0aGUgZHJpdmVyID8NCj4+Pj4gQ0FQX1NZU19BRE1JTiA/IC1jaw0KPj4+IElNTyBJIGRv
bid0IHRoaW5rIGl0J3MgYW4gaW5mb3JtYXRpb24gdGhhdCBuZWVkcyB0byBiZSBoaWRkZW4uDQo+
Pj4gQWZ0ZXIgYWxsLCBhbnkgdXNlciBjb3VsZCBydW4gImxzY3BpIC1ubiIsIGdldCB0aGUgdmVu
ZG9yIGFuZCBkZXZpY2UNCj4+PiBpZCBhbmQgY3Jvc3MtcmVmZXJlbmNlIHRoZW0gd2l0aCB0aGUg
cGNpIHRhYmxlIGluIHRoZSBzb3VyY2UgY29kZQ0KPj4+IHRvIGdldCB0aGUgZW5hYmxlZCBxdWly
a3MsIHRoaXMgc3lzZnMgZW50cnkgd291bGQganVzdCBtYWtlIGl0IGZhc3Rlci4NCj4+Pg0KPj4+
IE1hdXJpemlvDQo+PiBZZXMgaXQgaXMgZGVmaW5pdGVseSB1c2VmdWwgYWZ0ZXIgb25seSBkZWNv
ZGluZyA6LQ0KPj4NCj4+IGxpbnV4LWJsb2NrIChmb3ItbmV4dCkgIyBjYXQgL3N5cy9jbGFzcy9u
dm1lL252bWUwL3F1aXJrcw0KPj4gMHgwMDAwMDAwMDAwMDQwMDAwDQo+Pg0KPj4gQWN0aXZlIHF1
aXJrczoNCj4+ICAgICBCT0dVU19OSUQNCj4+IGxpbnV4LWJsb2NrIChmb3ItbmV4dCkgIw0KPiBB
aCB5b3UgYW50aWNpcGF0ZWQgbWUsIEkgd2FzIHByZXBhcmluZyBhIHNvbWV3aGF0IHNpbWlsYXIg
cGF0Y2guDQo+DQo+ICoqKioqKioqKioqKioqKioqKioqKioqKg0KDQoNCmhvdyBhYm91dCBzb21l
dGhpbmcgbGlrZSB0aGlzIHRvdGFsbHkgdW50ZXN0ZWQgPw0KDQpkcml2ZXJzL252bWUvaG9zdC9w
Y2kuYyB8IDY0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQogwqAx
IGZpbGUgY2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
dm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KaW5kZXggYzkxNjE3NmJk
OWYwLi5lYTk5MDRlMmRiZDkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0K
KysrIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMNCkBAIC0yNDk3LDYgKzI0OTcsNjkgQEAgc3Rh
dGljIHNzaXplX3QgY21ic3pfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsIA0Kc3RydWN0IGRldmlj
ZV9hdHRyaWJ1dGUgKmF0dHIsDQogwqB9DQogwqBzdGF0aWMgREVWSUNFX0FUVFJfUk8oY21ic3op
Ow0KDQorc3RhdGljIGNvbnN0IHN0cnVjdCB7DQorwqAgwqAgdW5zaWduZWQgbG9uZyBxdWlyazsN
CivCoCDCoCBjb25zdCBjaGFyICpuYW1lOw0KK30gbnZtZV9xdWlya19pbmZvW10gPSB7DQorwqAg
wqAgeyBOVk1FX1FVSVJLX1NUUklQRV9TSVpFLMKgIMKgIMKgIMKgICJTVFJJUEVfU0laRSIgfSwN
CivCoCDCoCB7IE5WTUVfUVVJUktfSURFTlRJRllfQ05TLMKgIMKgIMKgIMKgICJJREVOVElGWV9D
TlMiIH0sDQorwqAgwqAgeyBOVk1FX1FVSVJLX0RFQUxMT0NBVEVfWkVST0VTLMKgIMKgIMKgIMKg
ICJERUFMTE9DQVRFX1pFUk9FUyIgfSwNCivCoCDCoCB7IE5WTUVfUVVJUktfREVMQVlfQkVGT1JF
X0NIS19SRFksICJERUxBWV9CRUZPUkVfQ0hLX1JEWSIgfSwNCivCoCDCoCB7IE5WTUVfUVVJUktf
Tk9fQVBTVCzCoCDCoCDCoCDCoCDCoCDCoCAiTk9fQVBTVCIgfSwNCivCoCDCoCB7IE5WTUVfUVVJ
UktfTk9fREVFUEVTVF9QUyzCoCDCoCDCoCDCoCAiTk9fREVFUEVTVF9QUyIgfSwNCivCoCDCoCB7
IE5WTUVfUVVJUktfUURFUFRIX09ORSzCoCDCoCDCoCDCoCAiUURFUFRIX09ORSIgfSwNCivCoCDC
oCB7IE5WTUVfUVVJUktfTUVESVVNX1BSSU9fU1EswqAgwqAgwqAgwqAgIk1FRElVTV9QUklPX1NR
IiB9LA0KK8KgIMKgIHsgTlZNRV9RVUlSS19JR05PUkVfREVWX1NVQk5RTizCoCDCoCDCoCDCoCAi
SUdOT1JFX0RFVl9TVUJOUU4iIH0sDQorwqAgwqAgeyBOVk1FX1FVSVJLX0RJU0FCTEVfV1JJVEVf
WkVST0VTLCAiRElTQUJMRV9XUklURV9aRVJPRVMiIH0sDQorwqAgwqAgeyBOVk1FX1FVSVJLX1NJ
TVBMRV9TVVNQRU5ELMKgIMKgIMKgIMKgICJTSU1QTEVfU1VTUEVORCIgfSwNCivCoCDCoCB7IE5W
TUVfUVVJUktfU0lOR0xFX1ZFQ1RPUizCoCDCoCDCoCDCoCAiU0lOR0xFX1ZFQ1RPUiIgfSwNCivC
oCDCoCB7IE5WTUVfUVVJUktfMTI4X0JZVEVTX1NRRVMswqAgwqAgwqAgwqAgIjEyOF9CWVRFU19T
UUVTIiB9LA0KK8KgIMKgIHsgTlZNRV9RVUlSS19TSEFSRURfVEFHUyzCoCDCoCDCoCDCoCAiU0hB
UkVEX1RBR1MiIH0sDQorwqAgwqAgeyBOVk1FX1FVSVJLX05PX1RFTVBfVEhSRVNIX0NIQU5HRSwg
Ik5PX1RFTVBfVEhSRVNIX0NIQU5HRSIgfSwNCivCoCDCoCB7IE5WTUVfUVVJUktfTk9fTlNfREVT
Q19MSVNULMKgIMKgIMKgIMKgICJOT19OU19ERVNDX0xJU1QiIH0sDQorwqAgwqAgeyBOVk1FX1FV
SVJLX0RNQV9BRERSRVNTX0JJVFNfNDgswqAgwqAgIkRNQV9BRERSRVNTX0JJVFNfNDgiIH0sDQor
wqAgwqAgeyBOVk1FX1FVSVJLX1NLSVBfQ0lEX0dFTizCoCDCoCDCoCDCoCAiU0tJUF9DSURfR0VO
IiB9LA0KK8KgIMKgIHsgTlZNRV9RVUlSS19CT0dVU19OSUQswqAgwqAgwqAgwqAgwqAgwqAgIkJP
R1VTX05JRCIgfSwNCivCoCDCoCB7IE5WTUVfUVVJUktfTk9fU0VDT05EQVJZX1RFTVBfVEhSRVNI
LCAiTk9fU0VDT05EQVJZX1RFTVBfVEhSRVNIIiB9LA0KK8KgIMKgIHsgTlZNRV9RVUlSS19GT1JD
RV9OT19TSU1QTEVfU1VTUEVORCwgIkZPUkNFX05PX1NJTVBMRV9TVVNQRU5EIiB9LA0KK8KgIMKg
IHsgTlZNRV9RVUlSS19CUk9LRU5fTVNJLMKgIMKgIMKgIMKgICJCUk9LRU5fTVNJIiB9LA0KK8Kg
IMKgIHsgTlZNRV9RVUlSS19ETUFQT09MX0FMSUdOXzUxMizCoCDCoCDCoCDCoCAiRE1BUE9PTF9B
TElHTl81MTIiIH0sDQorfTsNCisNCitzdGF0aWMgaW50IG52bWVfZ2V0X3F1aXJrc19zdHJpbmco
dW5zaWduZWQgbG9uZyBxdWlya3MsIGNoYXIgKmJ1ZiwgDQpzaXplX3QgYnVmX2xlbikNCit7DQor
wqAgwqAgc2l6ZV90IGxlbiA9IDA7DQorwqAgwqAgaW50IGk7DQorDQorwqAgwqAgaWYgKCFxdWly
a3MpIHsNCivCoCDCoCDCoCDCoCBsZW4gPSBzY25wcmludGYoYnVmLCBidWZfbGVuLCAiTm8gcXVp
cmtzIGVuYWJsZWRcbiIpOw0KK8KgIMKgIMKgIMKgIHJldHVybiBsZW47DQorwqAgwqAgfQ0KKw0K
K8KgIMKgIGxlbiArPSBzY25wcmludGYoYnVmICsgbGVuLCBidWZfbGVuIC0gbGVuLCAiQWN0aXZl
IHF1aXJrczpcbiIpOw0KKw0KK8KgIMKgIGZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKG52bWVf
cXVpcmtfaW5mbyk7IGkrKykgew0KK8KgIMKgIMKgIMKgIGlmIChxdWlya3MgJiBudm1lX3F1aXJr
X2luZm9baV0ucXVpcmspDQorwqAgwqAgwqAgwqAgwqAgwqAgbGVuICs9IHNjbnByaW50ZihidWYg
KyBsZW4sIGJ1Zl9sZW4gLSBsZW4sICIgJXNcbiIsDQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBudm1lX3F1aXJrX2luZm9baV0ubmFtZSk7DQorwqAgwqAgfQ0KKw0KK8KgIMKgIHJl
dHVybiBsZW47DQorfQ0KKw0KK3N0YXRpYyBzc2l6ZV90IHF1aXJrc19zaG93KHN0cnVjdCBkZXZp
Y2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUgDQoqYXR0ciwNCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGNoYXIgKmJ1ZikNCit7DQorwqAgwqAgc3RydWN0IG52bWVfZGV2ICpuZGV2ID0g
dG9fbnZtZV9kZXYoZGV2X2dldF9kcnZkYXRhKGRldikpOw0KK8KgIMKgIGludCBsZW47DQorDQor
wqAgwqAgbGVuID0gc3lzZnNfZW1pdChidWYsICIweCUwMTZseFxuXG4iLCBuZGV2LT5jdHJsLnF1
aXJrcyk7DQorwqAgwqAgbGVuICs9IG52bWVfZ2V0X3F1aXJrc19zdHJpbmcobmRldi0+Y3RybC5x
dWlya3MsIGJ1ZiArIGxlbiwgDQpQQUdFX1NJWkUgLSBsZW4pOw0KKw0KK8KgIMKgIHJldHVybiBs
ZW47DQorfQ0KK3N0YXRpYyBERVZJQ0VfQVRUUl9STyhxdWlya3MpOw0KKw0KIMKgc3RhdGljIHNz
aXplX3QgaG1iX3Nob3coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0
ZSAqYXR0ciwNCiDCoCDCoCDCoCDCoCDCoCDCoCDCoGNoYXIgKmJ1ZikNCiDCoHsNCkBAIC0yNTU3
LDYgKzI2MjAsNyBAQCBzdGF0aWMgc3RydWN0IGF0dHJpYnV0ZSAqbnZtZV9wY2lfYXR0cnNbXSA9
IHsNCiDCoCDCoCDCoCZkZXZfYXR0cl9jbWJsb2MuYXR0ciwNCiDCoCDCoCDCoCZkZXZfYXR0cl9j
bWJzei5hdHRyLA0KIMKgIMKgIMKgJmRldl9hdHRyX2htYi5hdHRyLA0KK8KgIMKgICZkZXZfYXR0
cl9xdWlya3MuYXR0ciwNCiDCoCDCoCDCoE5VTEwsDQogwqB9Ow0KDQotLSANCjIuNDAuMA0KDQo=

