Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C1606A320
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Nov 2026 16:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fzwfNs7M;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=rKXZ2hFq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Cc:To:
	In-Reply-To:References:Message-Id:Content-Transfer-Encoding:Content-Type:
	Subject:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MDc7HWfqkaghkIPz5ibfN57irPQExvZMlTlsicLumB4=; b=fzwfNs7M27+UKbHGfV3iZhwBSG
	Ql/VdvRYcML6jUIJqVAdY/XkwPn4XncGy+YQDlibsb39ebBFe+P5bVajk+sAWnb3Tg4dn00L5ovw3
	fMGyZHDU/CJcFasBXKIF47Lmj1TcUzu0lFwbVabU5ac6jwRK9WCuw85kapFM6g8LRWIl2/F3is6H+
	5MDm0eTrIwy1qDoJbgy5lYqTJ404ABHjz5++C4Q1dk5FWY5zsA7AC6B3pI8Q0fxvtMRhmIxcRLUkN
	f1UnaQ7RzmIf5PeN2bLv1vwsuFwOFPX7Nr9fP1hAobJbhL3pDi7IH8tpZrxKmyqsGJwhc9WPov5Ue
	YzcD/XSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUnbX-0000000HPln-0Ghv;
	Sat, 21 Nov 2026 16:06:19 +0000
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUHcd-0000000E7Ex-2Le0
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 05:57:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zgpt1tm9t0K+6/KKCkOdNn0lU9Xj7Xvl+PP7xACXDdwh062OkoP2SsjrXkha/Q0MQOKFzlGdYM0B/QoOK28OHoUykFk5Var6B5mfO1KFHiXu5S6T9utMujCeT5/ay2g7OHnbqdxKZDBFtWSfGOBxLMuuLacH2Jk6fNPFp+S2KhfEwEd9EyTQ9WuB2+wv/cxK2ZRnniZhBjk6TL5D8wt4UbryQ3O9Q8te6NcPnYBLzkwrWl27MI2suU10ykoM3Ts1xI+6iksRi3G0sOB2gjGM3fFJ7Payja9UGBgVfpSRZ+JuIq4r9OMkxHs6e3OBSAbyFErVDJrPSWd4lKITUqdm/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDc7HWfqkaghkIPz5ibfN57irPQExvZMlTlsicLumB4=;
 b=Ss3qAP/4A+OkrBQSlcOn4wPfjLOPmwKc0Nu6Q+enE4UioluJuZ09EJwclUpnNk4wn5De654UN3XPdiIssEIjU39oiUiWgjaKMd1ZAQ9Ga1yIBNIsjcvyaqrUAfFjDBA9I6yVYAYUmI5d8ivRy9kmCMQacXR9dj5LAvpqo8e2Kth38/ev0knxsLhySQCo+Yki8+icPt1dloBybaCwlqAS9eyFa84Orcf2jeoSvI4PUT2XupiUiYlZH/eVEOYoHEtntxfZkE0RKEN5I36OjHj1sWj4F/W22xLJEAHCAidPC2WlCNY/L2dgq+tOZDbhU57TC2+yGftFg+07jjBR0hevGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDc7HWfqkaghkIPz5ibfN57irPQExvZMlTlsicLumB4=;
 b=rKXZ2hFqLfOiCrt9yLvl4+p2cfCaneyCUo1XXrMKGuA02nBNGpfyhi+JwnorWY//UAIdpDuZVUZiXEM5lyOp+njNFr4LNoCtg8awoal4czQ53/TrRfUOYvf61nkR5znIN5JGKkWqPO9WvTDmOz93Eldk1sIjAhMJJ99xOADuk85V28HVMu9MFn/j5zO3Nlvp6gb/Ucy8FEPynUCPVJQK8mV8bPZ4OP4zZF6GpfTXfhRw/HuGb0eTnQs2dN6RSi5jE2KGvx7iwDs0v8vuTdcLJQTnT/8w11oshc0sPvrP0w4QEixY+qZ5sKv1BTmToWkrHfCcSLpOz6SMsjV+ZSpJrg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14) by IA0PR12MB7675.namprd12.prod.outlook.com
 (2603:10b6:208:433::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Fri, 20 Nov
 2026 05:57:13 +0000
Received: from SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777]) by SA3PR12MB598757.namprd12.prod.outlook.com
 ([fe80::e206:100:5946:a777%5]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 05:57:13 +0000
From: Alistair Popple <apopple@nvidia.com>
Date: Fri, 20 Nov 2026 16:55:46 +1100
Subject: [PATCH v3 08/24] iommufd/selftest: Convert the test exporter to
 the SGT mapping type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-dma_mapping_type_v4-v3-8-c0183a409bdf@nvidia.com>
References: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
In-Reply-To: <20261120-dma_mapping_type_v4-v3-0-c0183a409bdf@nvidia.com>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dongwon Kim <dongwon.kim@intel.com>, Kevin Tian <kevin.tian@intel.com>, 
 Xu Yilun <yilun.xu@linux.intel.com>, 
 Karl Mehltretter <kmehltretter@gmail.com>, 
 Baolu Lu <baolu.lu@linux.intel.com>, 
 Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-rdma@vger.kernel.org, 
 iommu@lists.linux.dev, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Mina Almasry <almasrymina@google.com>, 
 netdev@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>, 
 zhipingz@meta.com, treding@nvidia.com, jhubbard@nvidia.com, 
 chaitanyak@nvidia.com, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>
Cc: Alistair Popple <apopple@nvidia.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795154186; l=2404;
 i=apopple@nvidia.com; s=20261105; h=from:subject:message-id;
 bh=rzVgm8jwszqPpkAPVHdLf9pyxEQsIZ10L+18abAzPsA=;
 b=J3hrkHKQiTQK/5iNHR24aasNW3RBGjrl38BcSRq6C7RXdToUD0R1a57rWj/Kjats5407clYJW
 2C8wrhvMdkbComyfMAO41ozK8ECK9ahUy5WapZVLmmxx7r3bAj+xq4q
X-Developer-Key: i=apopple@nvidia.com; a=ed25519;
 pk=WdWPT9rAq3YNfXldbGv1NSGVLGxzQGFGJvRUiShhNqs=
X-ClientProxiedBy: SY5P300CA0022.AUSP300.PROD.OUTLOOK.COM
 (2603:10c6:10:1ff::12) To SA3PR12MB598757.namprd12.prod.outlook.com
 (2603:10b6:806:52d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB598757:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d11fc72-4bc5-4e60-81f5-08df46cb1f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|921020|10067099003|11063799006|56012099006|261021123027099003|261028144727099003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261102130727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 6LLBdciwqXs+zuG4SMEd5cpsKlSEvdtYwkNS3hAmovz/tC/LmL/bEzugzGp8sYxggzLwDEVfL9SCqZpKtCK7lnVl7SIKnOSMSc3WYhGJ3CNHbuUd/B1gQh8CVcVTC5ir4HbAa6Ip7UB4cTo2g6MPSarmGwvwPrKHxEWxV9Gp82yrEmRzOp+NZWoatJ5Ros4r7xOY1dZUAaW/tpoGDU5leiKzl1SMqeTsd7zq4t0PMPvaO5qtHxZwipH9JZrdiOzTvQQZyqCEN+0AzsIPpH9DVaKpxJFNK3vRsg79dOjbIfSuAQUm/3lEVynhM6ns42dclV4g5S/2qmzPU3NzWTj8uAaRsOIKe2QBfvbUgJ1rKPF3LiWSI0D81a+ZRTTwiBBwGGUBRkSrd6pGiDiTD2J/MYoF/mHgR42hpfshjQBgVFfsOkWz963wfti9YBgsCBkCBfT4R5q2wRi/W+zeZ2ucdSVdoUQawdNgYH/S/KKosGZSTXFGTFi1+9mEdoRsvJz4K7RDv8TXV0rgUkHim++ITaWPfOh+BseUAzP7pyLmnzyWC2uWP9nJbN+rg24g0ql0ttoohJLqdsoA9t+3jUK95pWOdF0FLmtqEBpPZg42gKvJsQ4Lk359WJrV0TCq1bMY/pUSv3hW0xvotXaE59eKdyZPg0SVXZiXBLa2Od25AQydz3MDMhsZphXsd6PNhpDEEnwEgvePu7Q7YywTimyoIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB598757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(921020)(10067099003)(11063799006)(56012099006)(261021123027099003)(261028144727099003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102130727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnNqSU9SSHh3b0VvR2N3NW9KRDR0V2poOVpPQzlTcFkxb3FqQWM0ZUd3VVBk?=
 =?utf-8?B?TEV4MlZiTjFmbGJBaUkxWm9HdkZLWGJ5RDI4Z1kyOVNJa2RvaStjejFIOXdz?=
 =?utf-8?B?QTVKV2NnaGxoclptak1SVUxlYUlyOUhmV09od2dSUHh5Zndjb3V3aG92Umlk?=
 =?utf-8?B?dTRCTnhoQThXSkRXcXVNSGxXWk93Tndhd2Z6aWlUbHIwREkySXJieVdiQmVo?=
 =?utf-8?B?ZnlWcW91TzNVYWdSWjduTXF4L0lZMGI1OHB3dysrTmt5Q3pIQ3NHMkJpZ092?=
 =?utf-8?B?MGpYQ2d0SHNJSmlScUF5ZVY3K3J5WTdJalhYSmRiQzEyYnNKWnBycS9OTS9D?=
 =?utf-8?B?bWMvRG1iclRKUmR3RCtWWXlzUTc0ZE43T3pvVitIR2NUVkRsclpQVDk2bEJD?=
 =?utf-8?B?a0FHbFpBeWFpU3BldkxMcnN0eStKVFVKcWdzN1E3dXZVNnNieFM4MkJmT0hX?=
 =?utf-8?B?eEwxVi93bE43S3NXVkphckFoNnA2UEFVTEh1RWdpRlBhbk0wVzlocXhyTVNT?=
 =?utf-8?B?RkRPMEZhNit1MkxaLzVUWWlBbUtMTFVlYlJCZk5odUlWY09GQzN5SjVTVVFN?=
 =?utf-8?B?Y3VDd09jZm9yWkhyTVpITGs5NE83YmlPYS9BQ1dtK21UOVpwSXNzb2NMTjdV?=
 =?utf-8?B?WWZucTh0WEZvT3lTUDVlQmNjN1RPZmcxdVM5cWVpNXRZUHVwZ2MzMmlWU0FL?=
 =?utf-8?B?MVp6cEVoTGNwTU5JYm16dlprMFQyTmsvOWlqdlp4M2tqaWI0Wkt0YTFuSzV5?=
 =?utf-8?B?VzVaSjZ2RUl1dit0WHdnVmhpS1cxVWFFZEZYSis4QVh6V21CWVVFNUozNmFl?=
 =?utf-8?B?RTA2dE5CMjhxck42OG1NbDcwazVKTjg0WVNaZFM2Qkp4UDdmbmFCYXdQTGdj?=
 =?utf-8?B?ZXpmMGpJdDhsWms0alVEMHAxK3d5YWw2Y00vSGoyWDQ3ajQrNk1aNFpDNUVy?=
 =?utf-8?B?bStJTTQrLzJKaEJBZ3VyTUJ0ekFEeVVubEZrQzVkYVhLM0dtRmNpVnpwMmsz?=
 =?utf-8?B?OXF4RmxYWnJyekNCeEpaTytsUFVyc1hEYXlSeVVTV2FhUVFqZThoSHJ4SG80?=
 =?utf-8?B?Sit5bncyUVdlMkxIaGloTWNoUTZ1b2ZSYmhuVVhsL0dyUERpNGF1cnIvS2c1?=
 =?utf-8?B?dUFIdHBhazkvelpLc2Z1a1U0Y3hPMlRDUTJnYktOS0JsMWVuaXZ6L1E0VEdp?=
 =?utf-8?B?eHBHS1NOYzZzVGlFbm04UCtranBIblpWOUcrdWlweXFPcXd1c3dSVFZCaHZz?=
 =?utf-8?B?VTVqQm9DMFY4U0p0SWFDNUZLaVFsby9QaGU0cHByczNLU251NGxQSlk2UmNK?=
 =?utf-8?B?aThoamw3QVhXRGRta0NyZFdCdlM2ZmdvNldLRzVsQXNrZTF5dWJQQTRQSDFS?=
 =?utf-8?B?N083MXV6dHlqMWhpdGpPYnRYTlJ6Vm5DRkpVamJMemNiM2tXczNaVW9SMHZH?=
 =?utf-8?B?RnRLb3BmcEI2cStmcWdFTHZYT0lDRy90NC8zR25ZalRaMW1BVFJncVBYc01E?=
 =?utf-8?B?cFk5RVdkd1o3aXpEa1h4d1ZibGtpRnZvYThsN0F5KzVTbDBBeHJoQ3A4cGNv?=
 =?utf-8?B?NUNkUHB1aDRRM252RTM2UDBnY1phUjRqVU9NRy9RdXRjMXdtcHQ4R3R1RzlB?=
 =?utf-8?B?TjlFOUhybG1wSHpVcDZGWWZ1eGRQWmptTkNTaHoyaEZ5VW8xV3pPaDJTUEJ3?=
 =?utf-8?B?YnVKQTJZeDlNZ0g0NE1sYTB2a2xuR2pacVJpRnRpc0V5MlFGVG5DNTNhaG1r?=
 =?utf-8?B?YmdwcmdhTEV2L3NqQmx2UGdFa0VCU3d1c0JoakJMVmFUZDkwL3dHdVZpclpY?=
 =?utf-8?B?dEZ2QnIzR3U5bDVMZ2dlU0VJOExEQTNWQWtWcVZTOXU3Y2UydG5Edm1NMy9H?=
 =?utf-8?B?dWdadHNSdzF1UE1Mallwbk9aelJMZHExdWlyc2ptV1U4RGRFTlR3UTdERFBZ?=
 =?utf-8?B?WmRlVzRnQ0lBWmk3MGN4aXVJMEhwVExtS09HQVV3cmVXTzhlU0hRaU4xOVNE?=
 =?utf-8?B?Nk5reWoxRXhxemlldnUyb21oMi9xUzRPSHBvUkt1Wlc1akZwVVVybmFPN2Nu?=
 =?utf-8?B?cVhYbk1YS0Rxck8xdER4U29OZ3NsbzV4cFVWbWxWSTRPRW5WaFljeEZoWGtI?=
 =?utf-8?B?dC83RDRXaXgzV2lTbisxejZla05JVVhsTGE2S0ErVHFEYVh4cWU2Nmw3Zllz?=
 =?utf-8?B?Y2E4emFEOURNZCtrb2pDWGk1TVFtbEVRTHJKNXErL3hvUHZ5MGVuQmcxdjE3?=
 =?utf-8?B?RlpTNEZFK0dtbWpZTE9QU0ZCemRSSFY2UlBtSTRMZkZrRVllaGFEbTdUNzNr?=
 =?utf-8?B?bGRpRlAybXVsZ29lK3pzQmtpdURSaWd3Vi84U1pwdndGY0lLVkhBQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d11fc72-4bc5-4e60-81f5-08df46cb1f79
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB598757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 05:57:13.2446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KY3Mi9cgvGqpFNDWwfruqh40BLgHArwY0KHx6024hxkfxsljlZ3LK7RV//dxkj2zkEzXTiYGLt0cINxe33zMEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261119_215719_610036_DCEED379 
X-CRM114-Status: GOOD (  12.90  )
X-Spam-Score: -2.1 (--)
X-Mailman-Approved-At: Sat, 21 Nov 2026 08:05:55 -0800
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The selftest's dma-buf exporter has stub map and unmap callbacks
returning -EOPNOTSUPP so only the prototypes change.

Also drop the attach and detach callbacks which are optional and don't
do anything.

Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Alistair Popple <apopple@nvidia.com>

---

Changes for v3:

 - Split out of the single exporter conversion patch.
---
 drivers/iommu/iommufd/selftest.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 25387969ab75..b3fac041eb7e 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -6,6 +6,7 @@
 #include <linux/anon_inodes.h>
 #include <linux/debugfs.h>
 #include <linux/dma-buf.h>
+#include <linux/dma-buf-mapping.h>
 #include <linux/dma-resv.h>
 #include <linux/fault-inject.h>
 #include <linux/file.h>
@@ -1959,18 +1960,7 @@ struct iommufd_test_dma_buf {
 	bool revoked;
 };
 
-static int iommufd_test_dma_buf_attach(struct dma_buf *dmabuf,
-				       struct dma_buf_attachment *attachment)
-{
-	return 0;
-}
-
-static void iommufd_test_dma_buf_detach(struct dma_buf *dmabuf,
-					struct dma_buf_attachment *attachment)
-{
-}
-
-static struct sg_table *
+static struct dma_buf_sgt_mapping *
 iommufd_test_dma_buf_map(struct dma_buf_attachment *attachment,
 			 enum dma_data_direction dir)
 {
@@ -1978,7 +1968,7 @@ iommufd_test_dma_buf_map(struct dma_buf_attachment *attachment,
 }
 
 static void iommufd_test_dma_buf_unmap(struct dma_buf_attachment *attachment,
-				       struct sg_table *sgt,
+				       struct dma_buf_sgt_mapping *mapping,
 				       enum dma_data_direction dir)
 {
 }
@@ -1992,11 +1982,9 @@ static void iommufd_test_dma_buf_release(struct dma_buf *dmabuf)
 }
 
 static const struct dma_buf_ops iommufd_test_dmabuf_ops = {
-	.attach = iommufd_test_dma_buf_attach,
-	.detach = iommufd_test_dma_buf_detach,
-	.map_dma_buf = iommufd_test_dma_buf_map,
 	.release = iommufd_test_dma_buf_release,
-	.unmap_dma_buf = iommufd_test_dma_buf_unmap,
+	DMA_BUF_SIMPLE_SGT_EXP_MATCH(iommufd_test_dma_buf_map,
+				     iommufd_test_dma_buf_unmap),
 };
 
 int iommufd_test_dma_buf_iommufd_map(struct dma_buf_attachment *attachment,

-- 
2.54.0


