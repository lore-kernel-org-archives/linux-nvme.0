Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71262606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 14:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IfRXYJ3E;
	dkim=pass (2048-bit key, unprotected) header.d=criteo.com header.i=@criteo.com header.a=rsa-sha256 header.s=selector2 header.b=Gf1XKtau
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=kRUp4YZ6Rlu3Fh4pgW/bHKHRNhe0Y4ojmhl0CqVZbrI=; b=IfRXYJ3Ezgj6Vql3GW3KeEpMsG
	0UrGDn/Q12/F7OXcDBPmOz9qtQW6h4MNNhqvK7cmDefT4Of8X6RmBg6R0sfY01violwdPjEnI/VLZ
	2xEgYLHYeJor1EjeiUZfyO1hLQYYV851jpOafRRE1/wTZnHeW5cmwQW4cIPGxPIaiI4aRCSOK3zqu
	HgGx58kEXHNoqdT6TgTpCUgnJ6x4647WJz4YSgdmRtfmaWPIFj/DNaZtfREfEvtCQB5qJv1ZXEhDi
	tsMj+DnT7OKaPAur5vv7x2VAWgTNKNUDyxa5yA9L8BZe/JSzQZ5V9V+s25jxjdIkXmWqeLV3ULEGf
	AgwNwUOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKGem-0000000GYn4-3Q94;
	Fri, 23 Oct 2026 14:54:08 +0000
Received: from mail-norwayeastazon11013063.outbound.protection.outlook.com ([40.107.159.63] helo=OSPPR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKGek-0000000GYko-2y88
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 14:54:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pP61BUWnUFAmXGxX2C/h1EX+0RZWR4KbLiqNnGZorAk1HuQKv9dclavfzhqCcCizlklDMek8Sxljb3aZie9UgGqnwddf62kHB/6fUCiUmRjlRSGlIpjQyqhkORwUWh5Zg3ZFAFrP6EBOvjxhqW1MUbZIaKdrCjrjpyHzDkjgLoCULbgXBF8x/Cn4cMajQ1G7CnP2dxrprlmB9Ou7I7X9c9K2t0w63zcRudkzduh4Hu1maLSZ5M+Dn4qBx187LsvZ/57qGOqNP/tn78gSzuJ0zYa+H8QqO6QSVw9ddEMxn7RUt4XXtzS9FyAlOepOtvWvffMhl1EejWjE3AAFw8s3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRUp4YZ6Rlu3Fh4pgW/bHKHRNhe0Y4ojmhl0CqVZbrI=;
 b=wEcypmTJoRB49oUus9QeK7Sb39wOjlnOaR3O1gZaoAkU1p5hlTS4GCs7bftTZLISsaNcYR0NUPZmeOVCFoN64XiwNqyUUFrNVM4PvLLcFS6URvXhbisTrit3HVVgzbnDmOljMtkHvO225LEKHz2rU83VUIVJ3UqU25IsbIGF6T2LlAKWZousmQ7v4DfMZPhLTq+MdOK7kJEtwm0HgUHpnS8Sqdnrq3L7Z6I1IdueXP6/VfR/QARklQbXGo9/osw9vlHttD1lNO1B6nRFFgG9e12g1L8xlzx6hfD3ilABC7eGSz29zI6N4SGDqvWptUqeiu75sDil0HVCiQMfKy9LVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criteo.com; dmarc=pass action=none header.from=criteo.com;
 dkim=pass header.d=criteo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kRUp4YZ6Rlu3Fh4pgW/bHKHRNhe0Y4ojmhl0CqVZbrI=;
 b=Gf1XKtaumpVusX8KuKhP7bY4D70+aAS0t4nBKW0q+uiomUEo2FTRVoc0w1h501y4JFwZdtFhSOLkr8Wiu4sIK18c4FdQaNbgcHaLuyg8daY56xw3WD7zObmhQRlgMyAzZhtRHj6Hq1H0jOluCyJnzy/dzIxmZiQUmXkdTISPk+FPCQiNBuwg9Tgd56XqwGpAnewVYWQA6ZpMODn2j4ANNTvz2ZzXV2QQaUkbfATKSrRUbg6wb10OoIGxWnO3ZZKaiMT8Jj5EI8rddn4PlLRhLpdvzSQBvq5KGiaLigMk73b+WTytNnOOX+Tn2lvka1Jvif6D8yeOv2Rz5AnXs119aQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criteo.com;
Received: from VI1PR04MB5310.eurprd04.prod.outlook.com (2603:10a6:803:57::26)
 by GVXPR04MB11588.eurprd04.prod.outlook.com (2603:10a6:150:2c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 14:53:56 +0000
Received: from VI1PR04MB5310.eurprd04.prod.outlook.com
 ([fe80::3b8e:ff4c:76b4:a012]) by VI1PR04MB5310.eurprd04.prod.outlook.com
 ([fe80::3b8e:ff4c:76b4:a012%5]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 14:53:56 +0000
Message-ID: <7fec6534-9e57-4041-8699-72c5950c7e2a@criteo.com>
Date: Fri, 23 Oct 2026 16:53:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: honor the volatile write cache enable state
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, linux-kernel@vger.kernel.org,
 Erwan Velu <erwanaliasr1@gmail.com>
References: <20261016141208.2641974-1-e.velu@criteo.com>
 <atJXYHJa4jkUWJmP@kbusch-mbp>
 <CAL2Jzuz1qFwLSA=iivp5qLCTL6-4rvKmvFzJbOQzjPu6j_7Y2A@mail.gmail.com>
 <atJeazM_rJ0uj3vt@kbusch-mbp>
 <CAL2Jzux8v6zCxfcdd=MY5n0zQMVSa-_8Lki9z-fz7bFShNf7vw@mail.gmail.com>
 <atJk_2FmzjUZYO_Z@kbusch-mbp>
 <f665dc3e-fc5c-4352-8e41-a46b7ae97946@criteo.com>
 <CAL2JzuwuZp0gg1D7wSn7cdgpnhotnuLP6YpPd-SrdVyqhkeiJw@mail.gmail.com>
 <atqZmctbU0siYmVX@kbusch-mbp>
Content-Language: en-US
From: Erwan Velu <e.velu@criteo.com>
In-Reply-To: <atqZmctbU0siYmVX@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0293.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:370::19) To VI1PR04MB5310.eurprd04.prod.outlook.com
 (2603:10a6:803:57::26)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5310:EE_|GVXPR04MB11588:EE_
X-MS-Office365-Filtering-Correlation-Id: 27d6c395-9feb-4874-b377-08df311575db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|4143699003|11063799006|10067099003|261021123027099003|56012099006|261022075727099003;
X-Microsoft-Antispam-Message-Info: wPtpjJzvEbBnmm2L+xZrpU6vrqtWCUAIC2hcs3jqQvT+AZzZsqO9GcWiyonaRBhfQkyrdW/J0xsUhw98l98l5w9HWwdR+sfMPTTYKIlkJm8PZrV55fwbJM0qQTGsCrRt/GnIztCIgr/c3FlTRGxCjjI8YQeAUNfUvkTYLoeAzeksWc6hrEHyjhqLfdY1w2ytUS142j4Hq6QD34T+VoxWpRqus09JVmqcBKwNgoBYaELMTGciQOwL7PtJqwmDnrMGwphZAM2Zgv1ONQtLibkcE40kK5HBf4bEFnt5xHrKrXiSE7PqTpjzlK36BVS/Hi7HXWVPbSr1Ht6ykVP1CRd5/V3Lh1pgAlvirlmGSK40q4RjvaAC1K5Ul0H4F5RbJW4YSv3VkdxkH6Fh5BLpjeSqH8A/QYXeAFXpAdy30Kg+InH7h29cDm7vKinGrAKNRWSRgld/C4AzBdPVn9CVmhBlILc0wqwXg40SwJl/QJ8Z+cWczUa0TLsqLkwBj+6y0EQls7pU4A3VTdQ6Q+HUuNWHAT5wEjiCPIqqzJDGKNwWW6ccEwqMQUOcSAHGNibg3T9G9OJPpqqyQAijNijTaxJ43vv7iYxo3HbmxLIlKBSL9Z8XX7qeNFcNBBjRlj5syGUlrYgu86P9EpwNKbfnNx3LP//h4iipUp7Jlo6D+zK5lgk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5310.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(261021123027099003)(56012099006)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCtTVTJhSWU1aDJoQzhyR09iaFJhVDZ0SHhPWHNPNlBMZWtpNFByNHhYWmNm?=
 =?utf-8?B?dVBKY1VkSTlJV2hpUU5jb3E4OUtPWmZnRHZ3TXBIS0JramRHZGtnNElRcVlS?=
 =?utf-8?B?Q2tud1FCeW14V1N6WkNBU1VSRmpIazJ3RnJ3Z0pDVlltVEZNUnQ4REowQUhD?=
 =?utf-8?B?ejd2U2t1dXFGZ3Q2aWJKdUM3S2tSZFhtMnRVWGpqR3Z1djZCZDEvQ05JYlJX?=
 =?utf-8?B?K2dYOGRSOWU4eDVyZHBJcms2bnZIZEN3c0xvZlRkUDZHNkp3L3VWaHJKNkJj?=
 =?utf-8?B?bERpNWptOVo1cVJjSHE1Y0YrenJoTS91MjR2RERDemovZjVyT0IyMzRxV0xp?=
 =?utf-8?B?b3BYVUNtc2Z5V0JmVGdVWHR2dThlVXBSbUcvUFhUMWlXcGZTMGVuV3l6MWVG?=
 =?utf-8?B?dFBqWGgyNk1FMGRFQW9JaUMxTkNJVm0wU0JvUlVPOUk4K3lEb01QODRUQjkx?=
 =?utf-8?B?cVJDMDNJSGsxNnJaaFQ5YmF2LzhoTVg0Ym5pQ2JaVytkUGFtT1ViQlZYSUJ2?=
 =?utf-8?B?dHRYSWZYa3pKQWVlczlmbGlsdWdETmg2WFF6R0ZOUENCbDBhRC9NQUo5RDAx?=
 =?utf-8?B?UlRsVFptM1N0T2pFMWx1a3oxT2FpK2xwV1RGaWlybEoyeW9uS3hYQ0FTMVlL?=
 =?utf-8?B?VzZxWnRQaTc5LzRIdXlORmFhWWVHbkVPNDlia1RxbnA4WGlyMjk1a0VGeTVw?=
 =?utf-8?B?Zm1hc3VwYlBCOHZQNlhyM3ZGbTFzOWhhcUNwUGVLRk1rcDlIZGh4ZVo5b1Fr?=
 =?utf-8?B?djBIeGtCQ2xZOTJxSEhleFE4aUlJWXlNajdYMFZ0M2hJeTZTZlc2aWhrZkla?=
 =?utf-8?B?T1FMRFpSSkthY2dIVnZxd1R2ckdEWnVndHl3b0N6czhTcXRVSDYvWHE5dmtn?=
 =?utf-8?B?N2tDS1d0a3A0YS9qVmxQQ0ZTczhIYUhndElRRnpibzN0SmFzUTVkNmNwSmZP?=
 =?utf-8?B?K01RdlZWV0oyNzRnRFRPYlg1VnlEcWwrSG9GS1Zpb0lma2UvdDQ3ZVBmREZV?=
 =?utf-8?B?b1Q0bHQ0dnVOQnZKak1FcHd3Ly83TkY5UWNvc0RraDc4TGI0YVBNY1U0cmow?=
 =?utf-8?B?enVPUWZ6bTc0ZXJqNUVUMUI1VmpUV1NqNDA1M3BldDRwOExpUTZydnQ1bmVP?=
 =?utf-8?B?bXhTU3hJM2JrRHlWeS96czJkZjJ5U0lZcVR5d2ZYZjJ1TUtxcW51NlB6aUdh?=
 =?utf-8?B?VTROdFJPSTY1RGVhS1JYdC9JQlRRVDV0N3hhOTFoS1U2SFRMYWovLzlFU21I?=
 =?utf-8?B?M28vQ3A2K1NsZ200cTg3cnVIdzFhVEJ2bDlsb3FMUUF3b0dJdXBJRFltWDNH?=
 =?utf-8?B?L1lKbE9FcCtOTjR1MWZzSWI4VXpkMDJVZlpyN0FxcTAwNmZBRWs2S2NMdDQ5?=
 =?utf-8?B?YUlwdm1FTnVHT3JqUVpOVkRScGVOTzJsQzRjWFFvckl2QVBaSDFHV1l0TlFx?=
 =?utf-8?B?Z3UyU3IzTG1ud1dBVnVqZGVFRDVWMlhiRVd6RTdKY255M0tqd1dITElXcFpa?=
 =?utf-8?B?ZzNIdXpQdXZOazFxM2NITmt4OC9OaDA2bXAwOUpVMVE2YlNJQjV2aHZYMDgx?=
 =?utf-8?B?cTdMcVF4OU95TnZ6Ui9LYWI1ZXFjMTdTZTJ2bFpvdEVXUzZkQlUrOWt3dTRu?=
 =?utf-8?B?dHpjVkpmeFh2VGRrVks4NG41aU93VnkraEplUW8rY2FGcVVEellhNm5Yakhi?=
 =?utf-8?B?cXBoNGpLbUdsRjhYdkptRS9yY3dJY3Zucm5ncGRxTlJ5MWdkU01UWlNLVitn?=
 =?utf-8?B?cUN3dmdIUGpPU0tqT3BraElWSm00WEhwL1N2cHFJc05nb3NwZ1dxVklwTVY1?=
 =?utf-8?B?MDR4MmwvcmRRR2NRNnhpRUNDVUFPMUkwUE9PV1RUMWJGYWV4TEJmOUtmdkNR?=
 =?utf-8?B?cjBpb1R6cTR0SmZkRHhWbjQ3RHpIUzdhSnF3QlNEU015bGYvditWdkhDVS85?=
 =?utf-8?B?UENKVlVwWmFNOE0xVWNzMkZPdy9reUF3T25iSnZJcUpqaUtpcENkVk1JS2xw?=
 =?utf-8?B?QnJBeDVuY2FpTU4rRkEvSGs0R0RyN1Noa1BDOGl5ajNqeDN6U3NoaCtldkNz?=
 =?utf-8?B?UFlUZE9xRmZlbEJNTlpHdXhWclA2SUp5ME9FZlhGaDNXcGd5Qmp6OWNqWGVJ?=
 =?utf-8?B?K3Q0YVFWYkpsdDNPWlg5cXpKZ1pUeVRqa0xVQkRGcXVXWm9NUVkzcnI4YkpW?=
 =?utf-8?B?TTA3MytjcGlQQmV3aGlwZnQ4TWhNVzIxVmVjTnNUTVJxZXZvNUx2NEUrZXpW?=
 =?utf-8?B?WldoNUlDN1dPREx6ajQ5Y2lZa3hBQW5heWQ1WkRzc2hLbFl4blNQWkV1R2dJ?=
 =?utf-8?B?VDAvY2o1Y0VEdnFqa1BZS00yRFdGb0wyVS9ZUWNtbERWRyt2UTZxUT09?=
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d6c395-9feb-4874-b377-08df311575db
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5310.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 14:53:55.9637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UDKjShvPgzauMSZPcO9YI829cfBnADK3WONsQVBUXQnySD3AT/So7vHaPcvyIPFtCNw4cexmx97AAXgLitxHnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11588
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_075406_890244_133008F7 
X-CRM114-Status: GOOD (  17.62  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/23/26 01:17, Keith Busch wrote:
[...]
> I just wanted to see if there was any difference in the controller's
> Flush behavior when the volatile cache was enabled vs disabled, and this
> looks like it's the same either way. The Flush should have been a no-op
> to the device with WCE cleared, so something seems off here.
>
> I'm wondering if the device is actually really respecting WCE set to 0
> now. That might be tricky to prove, but it wouldn't be the first time a
> device lied  about durability. Not saying that's happening here, but the
> behavior you're reporting is suspicious: 15usec writes are not
> physically possible with TLC NAND (your model says BiCS TLC) without a
> cache, and your controller says your cache is volatile.
>
> Anyway, the principle of what you're proposing looks fine to me from a
> spec standpoint. I'll get this queued up if I don't see any other review
> feedback or concerns that it's going to corrupt something...

Thanks for your feedback.

I'll discuss this firmware question with the vendor in private and will 
keep you aware.

Considering the performance impact for these type of device,s would you 
be open to a backport to stable once merged ?

This patch is really about matching the spec and it would be probably a 
great positive impact for many stable users to benefit from this patch.

WDYT ?

Erwan,


