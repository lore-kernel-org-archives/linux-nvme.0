Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB5FC83F17
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jul 2025 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IUnFhERKNHCw46uTgLzNv124+GccgrV6AfNZhDpO/uI=; b=CaFCEmNSWeqPnVZjZrkrPQQDUl
	aa8L/vyegpsYJyRGA8lYkARdRdcIFoDGvFzbeeuLk7Nzbik5VkOPQE6Q/YeuvQZKUg/CnWc8iXuC/
	+lBd2UFWvfz85jY0DVCmVbQu00gV+Lc+LU8rETm3Opjq19vEmTAX9JHAY2wq/TEivEjCKO3TVh5aa
	GFL+1Mi+UIpGDd0mo9w1P6wtJhYnsOb+VZYRU8nN7zU7yv373ChEnRAbPg8GWDLxjukHoG3Cchhj8
	Pd+06SJYrfIiiMXA8X8eh4saU5vXAl2NEF+5KT9BL4VqeiyyF2NvgdJiP4kypMSXfmcnYK0WRufcz
	/195dlsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugS8z-0000000FALb-0SDY;
	Mon, 28 Jul 2025 18:00:13 +0000
Received: from mail-bn8nam12on2062c.outbound.protection.outlook.com ([2a01:111:f403:2418::62c] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugS0c-0000000F8bL-0xFo
	for linux-nvme@lists.infradead.org;
	Mon, 28 Jul 2025 17:51:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e97qDNxpYKHiLjCMePPl9JD5G4tzZ6hSPBcF76+lxxcvMFQUnQEJKe6kcJiu6Ruy5QSKDBduDfRqUubF//Zzs305F4OWDYl0hos4f6bFaNKXKjoGTJMSCtA3MPft9r0gUeLNQhmXnZpzWeU5zcLs9Orxkb4OrTq6Adcw1l+RSKT6C/BjJfpHVuWKB2oEw2oSuPAUp8eQ4lBzscA4q1pSXBqforz58tCxKXeX4+jAOxQjN85VthUcE+Q8EdTrf5FwOlGA13o/+iv5yAzt3sP42oIvPAuKFPO3K9+j0dNrUg1Su20sEDp8hdUc5971GZnFaU2IqbszD/P2JXfIJiFpag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUnFhERKNHCw46uTgLzNv124+GccgrV6AfNZhDpO/uI=;
 b=TDqiFEsQH1La+YnjDMRs268ZogM3xypzKVaa+SFjSS/N/l8wMy8BOvkT0ucuxCshP5/LXOajn2ZWGzRCmUq0QVzhIK7xHYnV1AKao8oRkGtXe604HCGKLhlrjG2/CBAnQ0AVcPbruuOMAXYimouO3F1SXXaRVrtnLMlHx9ZP7p9buWDsuZyIvVn4LGkxWF8Ju0FbWZDEdUDbX0lsR0/lLk1b3iOWTJ/ErrfNVWYs/oU6i9pCsPe3ZN7Hrb6KpzeJlGCJvBAOm/Sfsn45Ns90Vb1Wg2XdKUXBbVt77lH3njNP9HL28se8QK1M8mshb+uj7yI2KeJjbgc1oFTPxr9S+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUnFhERKNHCw46uTgLzNv124+GccgrV6AfNZhDpO/uI=;
 b=Y/czxoxbu9bqCQ2SjuTKh1sGzwWaIfKKhodE2TKJmlqB5EyRQZ0YafpbbjDUD/ekLgJHkuaE0ZBjQalwyiBCZcD4KydFi8V0B8jejXKbEwfwRrtIL+ls1fZ+wnrCY6y3FVMEYv364m7sZ7ixykhhYSf8n6pfKbUv2a1mTmRZOLJMrnLGAkzQdAFDliZDIeGajNoZcNGCAAdPbuANQt/SRFRxozr5QXgMAMdJslPHCMWWuQNixou1laJTdh43F1UlVtrHR6iH2IOE2goxBXzvg8/Pyui7D8AbkjKZthMXi0nTvi60WfwDOXs9VBZOPCz5IdFSS3/HE61ziA8du9oU/w==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH3PR12MB8902.namprd12.prod.outlook.com (2603:10b6:610:17d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 17:51:26 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 17:51:26 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Mohamed Khalfella <mkhalfella@purestorage.com>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
CC: Hannes Reinecke <hare@kernel.org>, Daniel Wagner <dwagner@suse.de>, Randy
 Jennings <randyj@purestorage.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvmet: Initialize discovery subsys after debugfs is
 initialized
Thread-Topic: [PATCH] nvmet: Initialize discovery subsys after debugfs is
 initialized
Thread-Index: AQHb/aXJJ4HMVPt7JUqz25Yk/lPeerRH1S2A
Date: Mon, 28 Jul 2025 17:51:25 +0000
Message-ID: <a8dfd675-d98c-43b2-8e31-a6d4d4915844@nvidia.com>
References: <20250725205005.1983426-1-mkhalfella@purestorage.com>
In-Reply-To: <20250725205005.1983426-1-mkhalfella@purestorage.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH3PR12MB8902:EE_
x-ms-office365-filtering-correlation-id: ab79aec2-af6e-46df-68a1-08ddcdff5fa1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?THgrclJncDRLZk1zSjFvakczbTh2Yk1vR0JKUS9lSlppMVhSMVptb015RjhG?=
 =?utf-8?B?WTM5RnhIOHh5WDJaV05rUnE0c1pFcE5oWDZaZklnZHVUZEF4QW1IdWhXNDV6?=
 =?utf-8?B?QithcThXUm8xTmtYa2lZQ2FZYzltOTlIUjhRdnlxL0cwd1NWMTM5aFowVDQv?=
 =?utf-8?B?L2ZqdDhqb0JpdGV4TW1kc3gzQ1VYWTZkTmI4Q3kwT0hBT25OdWk0WGJyS1Nk?=
 =?utf-8?B?cnpHTTZlWlFKT1JGY1A4ekMyM0lNK2VjR3k3WEF0UDJLZGZvbUxFTGM3ZzF1?=
 =?utf-8?B?Q0JlZk42d01oOG9abm0vSVpURlUwTm5CK0ZvdWhnMVBxVVFDQTRiU0FVWUhx?=
 =?utf-8?B?SjR4RCtyNlFqbEpSNnVzZGowMWhYZGNVSXA3RHRrK2lySFhWNVh4bjFucjgv?=
 =?utf-8?B?MGtVRWpKeFZoM2V2R3RacnpGbG1NSXNTWGk5eCsybVJiTm1LOGxBV1owcExZ?=
 =?utf-8?B?dUJkK3ozV2xtSGxNZVhRem55TmdPQ0pBdGJ3TTNWaTNvUGVuU0pycFpzT2Jj?=
 =?utf-8?B?TExtZm5XY0pjNkM1RVBYVWdDcTRJSTJRRExjSVBmMlVGU1hvRlphOXhuMi96?=
 =?utf-8?B?YzQ2aG90MjNYUkFiWVlzV2Z2aDVrV1dIc0FtRUFrZ0wwNkl5b1BhVXV5SHgy?=
 =?utf-8?B?Y3JPNkEwbEFvbVZqelBsZFQ2SDBjMXU5MzB5VTVxRURCRnl5SjB5azdnSkZr?=
 =?utf-8?B?NjladGhDbjh2VlZXRmtnbHR5UFhnSk5xZWJId2RpR2pra0ozYU8yeXJoZDVu?=
 =?utf-8?B?RXl6TERjc1lSWDRvd25OU0FWV00xZVdoR2w2NWRrRFFGVzdSYVRBeDhwbUt4?=
 =?utf-8?B?Nm56a1owOXdvaDVVRmpFUVF5ZFNEeU91eFB2R1FERlNBSHhkMVU2Rmp4aG5q?=
 =?utf-8?B?RHY4N2M4ejZuR3ljWHB1Ym9oRVNENkVLMXhKZm9YUU1VS1p6Sm11MXBnZTdF?=
 =?utf-8?B?ZDBlL2xsRlNNNitQUXpleU5uUTZpbkhvSytrZG9vQ3Boa2V5NktjRkZMcXBB?=
 =?utf-8?B?b0lTVG5rOThlRTlQcmNRZzc2OExGaXQxald4VGhOb3VoSUZrdTdNZERzUlZB?=
 =?utf-8?B?bDNvUlNLQzl1UG1YQ2hCcGhiYzJPVlVmTHJDb1h6REJCUm1FVVRiSVZpYkVR?=
 =?utf-8?B?R0JURjloaVBvZHdyRFdqbmVLb0tLT0xlbjhkWUxaUGRhcGloR1MvTnV1TktW?=
 =?utf-8?B?QVJ1U3lxY2dnUld0bzF3VlV1bndWZzNWMDBCakxPR3M1YTIwQUljSGNjNGtn?=
 =?utf-8?B?bzhSZmJWc1dpLzhSL0xYaHZlWHlqMTFqeGpKbC9vNlJnTDFUTllGY1lMRGpQ?=
 =?utf-8?B?M0ZBRHFUU0xiVWxhMFpSNVVRMUZIcU9xT1ZhR0loZFd5akUvYVJwQ3NTL2dV?=
 =?utf-8?B?VFU0bTMyVU81V2loMjlXK1ZNWUlQaGtjWHhyTFJyaUF4Ym02R0hmRTBha3Np?=
 =?utf-8?B?cVJzSWJoeUR5SHhLY0gzYkV6RXkxSlB3U0N0b1IzK3NadEhmb3U2M1M2VUxs?=
 =?utf-8?B?RE04ZFhoTWFYeHF6WDhUakhyM1l0Y0tqVXJQQjZvQnlSQmFQQWRVU1MvZzFH?=
 =?utf-8?B?OHorUGovNlp1aUI1S2FpbU13RndhaFZBUFVJWGgrSzNSZ3lvdnlnLzdOUDNl?=
 =?utf-8?B?YkVIQ3hncDdlTnZmTGF1TXh3VlRFNzd1OHprN05sWWpEeWh2WmQwTmtlQ2Nk?=
 =?utf-8?B?WlE3SzRLYUV5RWxIT25OQkRWektsbFN3TTB6am0vaWtRWmlQTmtWZlE3U0NH?=
 =?utf-8?B?ZFF4R2U0dUp0a0JvVVgxL3pOWnZRUCtwVWtJcTdRM2cvbHRJZG9TdG9zb1Nz?=
 =?utf-8?B?aHM1dzVySE84UGdPajVLcnBiZ2JkcWJpdWhzbElTYUx6YXZLNG51Zms0blJs?=
 =?utf-8?B?a0FUTU52NmxwQnNBU1kveEVBL2tOLzd5clp6SmJwN0ZDdU1ZMnpNUE9ORmFV?=
 =?utf-8?B?cVVvMnVOMnU3T2VzNTU5OWo0QmRYelY0dFlxVktHeldRdWh6VGtKWXpBVDdE?=
 =?utf-8?B?R2dMTmFqdnlBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UlV4bzNWWmFadm5UcFdoWk41QVBJTlBUcko4STJ6TE4zbXNwN1ZhT2xvL0Np?=
 =?utf-8?B?QjNlbDZyME01bG5xUXMxcFBpenpIcXVaTUJFdGJpaGpYUTRWWitDcjhjckFH?=
 =?utf-8?B?dHdKK1N0bjF4MXdLakxZbllqdlF6RVBqS0xDR3cwQU9nSmxQbGNobHBaV2U1?=
 =?utf-8?B?RVVET1pteXNsRzJETitlNjA0aTg2SUo3bFBPRUlwTy9iaG9FYWllQmdPZHRm?=
 =?utf-8?B?Zk4wM1JTanlnQ1AxVEc1aXFuRlFFVnZGb2Fkb1p6b1RQeDliUXpKeFk1L0RD?=
 =?utf-8?B?NWpRMjIvNXYrNEJJWWcwbkU2V0RTUE82dUtFVVRDa1ptVXc4bDFYSE9ic2hr?=
 =?utf-8?B?KzFzR2hpcVVtK3JYdFB3YnBzTk9WMnBRb25nSzFONi82cWNtQlM0U2FhSXRW?=
 =?utf-8?B?dmRZMGlQREo0SVpMb3R6STh2ZmxnaDAxR2lWUitXTEluZm55Y3RDeXkvWE5Y?=
 =?utf-8?B?RUI5Z1RZcW1MVE5qeG54T2RpbXAwT3B1U1FtNlRadG1ybFVCRGF4aWZ1SFNs?=
 =?utf-8?B?Q1l6VHRLaEo2T3MxOHdQdVdSMlJEcmZGK0xVYTlkUkFlRnpvTmRNYXJmY1dQ?=
 =?utf-8?B?UTNXVmNobGNqRGVaWTNCcWJIeUZUMzZETzllL0dMOUtUdDNNMzFWWkRQYlNk?=
 =?utf-8?B?R1krSU1IWVl5V3ZhRnQ3QWszVmNOWWduNnViaXMrRXhIUlMxSjlRUS95NGFz?=
 =?utf-8?B?Z21QREVCMllkdjZGWlEwUUZmTW9qemdjaXVIblZyL2Z0VTVZTlNIWnAyNUtR?=
 =?utf-8?B?K1hTN2RqaDdoMks3WUxxcHhyMmVYSU15ZS9nTUxWUjlOMVVQSmFIblpiMGZE?=
 =?utf-8?B?YTU1Z1FpS01rL295b3pUaHd5RnVWVzR4S25JNW4xYWtDMWYxU3FTTlJtMTlB?=
 =?utf-8?B?WHFpN3NiWnk2K0Y1c3JFUFlPeGRzK0kvRklZRVRlTnkvbVA3bUxDOFZReEtH?=
 =?utf-8?B?TVlpbmNRLy9YQ0xPYVlsaGp0dzdDOFdrUUhqR0pHWDVsK3NDSTVZUUNhTkJr?=
 =?utf-8?B?V2FwSk5LazhiNFVCOEkzU3Z3dHUzdEowTjhteHBLdHFPbUJIbGhtZTlpS3ZW?=
 =?utf-8?B?ZXRmdk1ucEtNb2dMS1R2dWJONUpPTWxyZWhFVktOcWZBcnVtTUZaNHVMYU5p?=
 =?utf-8?B?NGJxSFBXUkFVdCtuMlYxSXdIR1hYbHFaN1JMNi9WQlduM0lab2g4elN5SDlu?=
 =?utf-8?B?aVpVM1VKRFZWOGNENFJ1azdJd1Z0cU9vMEVKVDdSUTZVL240cTNJRVg5L21F?=
 =?utf-8?B?SzBBZUdicVRRUTUrR2NqcWlmK2REamR5MjVXdW1yMVNKY0wzMDYvRWJvd3hO?=
 =?utf-8?B?bEpnc2xOM2ZMZG1HTmpkdUxzeU1Va1VpYXNlQjNvZWJsSmYydThvT1drZlpm?=
 =?utf-8?B?c0NLdk1FMDZsTEhHMW5EclFaeU11QldqZkhlMHU1SnR1SUF3UWc2TW1WNzQ0?=
 =?utf-8?B?Y0RNOHEyKzl5a2pTTkVmT1NZd2JCQjAwSWhQS1BNTkVyR0NwSVh1RDhuQngr?=
 =?utf-8?B?VnB3bjBEcHVMRnhMbmowZnM5TGxtVnJpQ0orMGlFQnc3SjZ3aGdqbEprUCtD?=
 =?utf-8?B?WHhMVTZrdG5PcGJmOEQ5SVQwd1dCQWluUGtiSFBkK0F5YkFsYTRzNGN6Z1BO?=
 =?utf-8?B?M0ozNTd3WWI1NzZXS0ZhV3hxc3gyV1k3cm1CSTVQdmNpU1liZjZaaHRHSG9Z?=
 =?utf-8?B?NFVaMVd1SVM1VTNSNWpDWnptUmdKMHVKcHFmaXV2MEhrT21GSmtobGNUNTRN?=
 =?utf-8?B?eWh3aVlUL1FSZkEySzAxcWNxTFBLSmlCaGRhR0Z4TDE1dmw3cWRkMFVBUkRn?=
 =?utf-8?B?MGk5TTFBOVYyajMxRUNvTTJ3d0p3bGdLblBwU3JnZVZMVGdsOWF6M1FFRmlV?=
 =?utf-8?B?TG1ZbFB2VVdpMGFrZlNiSkFaYm5pUW02YjZvYUdwWEFpVjRucXJONFQxTlNz?=
 =?utf-8?B?dUprdGNUbG1HZ2RyMGxHT2FEcFNySldaNXllQ25SYVhOTlBjenB6ZFhnenBV?=
 =?utf-8?B?bzRpcGdRWE5hYWpWR2s2MzNrbDJ3NWxvaXhWNHZnOWpJRlc5VGVjMWxob2h3?=
 =?utf-8?B?MDlyaktwOGtOUkt6NjFWVmhrSWJPNm5PNWhIN0VIa3p5b0N5QjNJYVQrZlNK?=
 =?utf-8?Q?tfqj0OZeRIsCq7sY74eUWhkUc?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <198A2BB44296C74C807EC407C197336A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab79aec2-af6e-46df-68a1-08ddcdff5fa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 17:51:26.0962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmnnxYzC/EKhkZ8TdN70WtzOAdPgyy8Jqyp95VXuLo4JLkUrWVjBQwFtEHUcv1fSYR2TJHWXv85T+ibtE6/Fbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8902
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250728_105134_624452_25B89BF9 
X-CRM114-Status: UNSURE (   9.46  )
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

T24gNy8yNS8yNSAxMzo1MCwgTW9oYW1lZCBLaGFsZmVsbGEgd3JvdGU6DQo+IER1cmluZyBudm1l
IHRhcmdldCBpbml0aWFsaXphdGlvbiBkaXNjb3Zlcnkgc3Vic3lzdGVtIGlzIGluaXRpYWxpemVk
DQo+IGJlZm9yZSAibnZtZXQiIGRlYnVnZnMgZGlyZWN0b3J5IGlzIGNyZWF0ZWQuIFRoaXMgcmVz
dWx0cyBpbiBkaXNjb3ZlcnkNCj4gc3Vic3lzdGVtIGRlYnVnZnMgZGlyZWN0b3J5IHRvIGJlIGNy
ZWF0ZWQgaW4gZGVidWdmcyByb290IGRpcmVjdG9yeS4NCj4NCj4gbnZtZXRfaW5pdCgpIC0+DQo+
ICAgIG52bWV0X2luaXRfZGlzY292ZXJ5KCkgLT4NCj4gICAgICBudm1ldF9zdWJzeXNfYWxsb2Mo
KSAtPg0KPiAgICAgICAgbnZtZXRfZGVidWdmc19zdWJzeXNfc2V0dXAoKQ0KPg0KPiBJbiBvdGhl
ciB3b3JkcywgdGhlIGNvZGVwYXRoIGFib3ZlIGlzIGV4ZXVjdGVkIGJlZm9yZSBudm1ldF9kZWJ1
Z2ZzIGlzDQo+IGNyZWF0ZWQuIFdlIGdldCAvc3lzL2tlcm5lbC9kZWJ1Zy9ucW4uMjAxNC0wOC5v
cmcubnZtZXhwcmVzcy5kaXNjb3ZlcnkNCj4gaW5zdGVhZCBvZiAvc3lzL2tlcm5lbC9kZWJ1Zy9u
dm1ldC9ucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzcy5kaXNjb3ZlcnkuDQo+IE1vdmUgbnZtZXRf
aW5pdF9kaXNjb3ZlcnkoKSBjYWxsIGFmdGVyIG52bWV0X2luaXRfZGVidWdmcygpIHRvIGZpeCBp
dC4NCj4NCj4gRml4ZXM6IDY0OWZkNDE0MjBhOCAoIm52bWV0OiBhZGQgZGVidWdmcyBzdXBwb3J0
IikNCj4gU2lnbmVkLW9mZi1ieTogTW9oYW1lZCBLaGFsZmVsbGE8bWtoYWxmZWxsYUBwdXJlc3Rv
cmFnZS5jb20+DQo+IC0tLQ0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlh
IEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K

