Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA494CC6B2A
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Oct 2026 04:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3zMUckmdHlMtdlh/QB1ae7Hw29RsJYHLhEYheFqtBOg=; b=aulQJk5mzXjm2RlESSCdmpsLCm
	E5Z44KEaueKEoBw6KWxstVhW/j5a+b4hNmu97rhV+DZEMWpEJYPgKEhdYop6HBqEQonzR82dI0A7B
	ww/BsGNAWbZ/oXDCicrWjwOKJC6CLdt2eTcMz5kYwot58+sRyXVXcAMlpiRtWvv2T+v3o20Rh/rAB
	w6a2lq7f+j6KLxCk1K0/oemUI4/LmHXXk/5wPTg7IHaXB81kbdQyCf52Lk/fS4/KCF/zowSzNODB/
	KbV6PwYtyVNTs/4PNEdEBr8twQRenV3oN7BqfPYSvrDI7PsRAHaJtlfSrNJ8t5j+HFcSx6YDEXKNi
	KNNkewug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHvzY-00000004PUj-3xEx;
	Sat, 17 Oct 2026 04:25:56 +0000
Received: from mail-westeuropeazlp170130006.outbound.protection.outlook.com ([2a01:111:f403:c201::6] helo=AM0PR02CU008.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHvzW-00000004PUO-08Ot
	for linux-nvme@lists.infradead.org;
	Sat, 17 Oct 2026 04:25:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBGBvEp5oN+sNr3yorR4AxJRI6bkev63BDzBZmMJ5E9dzQ+anotP32KnrhJ01JkqS+LxKcVkfMY1UWZisUAY8XZfYPKUgNHNJDTs2x7IuyFpXXyyomzS6gkB/iVfyHu9lgjQwDTc576J1rKnFly00EZC/wn4R/+U1XNtNUMxwUekEXzlofl9BkFKmAcyoPzCBH1EFn008DwIL+gCjTRZ0QxJsgtEIzEclI8qgt+w6oLNQG+PdYaro9QtKnyTn4M5/UDK+5Q8Cwmaf/kZA7Z3mqrxfAPUbAhmNFhVNe/nHcjznaBeiZbrQPWwHU9wVCYoHKMYYRvk1XEGDzb6RyPeKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zMUckmdHlMtdlh/QB1ae7Hw29RsJYHLhEYheFqtBOg=;
 b=gfZBitEUeBojoR8X4jOxPHtTbzBJX+aciPXkBp98cXIbfEg3bvaNv9wiXAUMj1sGe98tQoK/G+BYeUbWRqxHLE9hd7O1EfJ0nIQn7S7cN4PQnB5iwlUi8RVivcJ25Rh0knPVpYfoHK9SRBbYLzmAAgKL/AUgxp8yo1HpEO5zIY3w8VyqA2OeuQjXgWGSP1AVNGQktivxEUUo1EH128aNMMMHcvvjo6N2yOuBAFaG98iQMFiILE+RSQhQmaDCIjSB0k/Ogu03gj1DfN8lYqadDRWDhCdRNdP6gloh/b93N3QAKM74H9/CpAGXnCS4GJO+Q1BMIRpVx7KeZYZTvmy4zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criteo.com; dmarc=pass action=none header.from=criteo.com;
 dkim=pass header.d=criteo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zMUckmdHlMtdlh/QB1ae7Hw29RsJYHLhEYheFqtBOg=;
 b=phGUqVea/jAU0z8HbXq/SDf3LzFiERredPLEvUtwxFHTSnxfpZmy6Xiak4G7dtwAWEh5a8zMIYF3eKS1y+laHLWpmko0t9pslraqEQtEygYj8K3Ff7T6D9cfECn9TfNXFvBpYLRW6+vL96jaMSpqitgTxrr3yAxC2L9nAZUdfEZpfl8FhiV27SFVzMYnjjQVdKqSwt4xFgUI2TVZv5a37rKfaUUDK+XJHrvFLwy77OKoTlryGqgUqRK9gJfCq+AoyYZqC6Pcu/+PgsTV2QUtLpbFjbPXZwvbPyT+wnqg4vMubqcowf9w05VDQhyN0m2X324tb2+r0ttlLoTjru/9Gg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criteo.com;
Received: from VI1PR04MB5310.eurprd04.prod.outlook.com (2603:10a6:803:57::26)
 by CPH1PF76D0E694C.eurprd04.prod.outlook.com (2603:10a6:388::3cb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Sat, 17 Oct
 2026 04:25:45 +0000
Received: from VI1PR04MB5310.eurprd04.prod.outlook.com
 ([fe80::3b8e:ff4c:76b4:a012]) by VI1PR04MB5310.eurprd04.prod.outlook.com
 ([fe80::3b8e:ff4c:76b4:a012%5]) with mapi id 15.21.0522.013; Sat, 17 Oct 2026
 04:25:44 +0000
Message-ID: <f665dc3e-fc5c-4352-8e41-a46b7ae97946@criteo.com>
Date: Sat, 17 Oct 2026 06:25:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: honor the volatile write cache enable state
To: Keith Busch <kbusch@kernel.org>, Erwan Velu <erwanaliasr1@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, linux-kernel@vger.kernel.org
References: <20261016141208.2641974-1-e.velu@criteo.com>
 <atJXYHJa4jkUWJmP@kbusch-mbp>
 <CAL2Jzuz1qFwLSA=iivp5qLCTL6-4rvKmvFzJbOQzjPu6j_7Y2A@mail.gmail.com>
 <atJeazM_rJ0uj3vt@kbusch-mbp>
 <CAL2Jzux8v6zCxfcdd=MY5n0zQMVSa-_8Lki9z-fz7bFShNf7vw@mail.gmail.com>
 <atJk_2FmzjUZYO_Z@kbusch-mbp>
Content-Language: en-US
From: Erwan Velu <e.velu@criteo.com>
In-Reply-To: <atJk_2FmzjUZYO_Z@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0009.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::14) To VI1PR04MB5310.eurprd04.prod.outlook.com
 (2603:10a6:803:57::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5310:EE_|CPH1PF76D0E694C:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1c48a4-770b-467f-a6d5-08df2c06b61c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|261009223027099003|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: N453uibhWPZkLELnUbauxZUndQgCefmu/u40VxATWz5huMedw6iBXD7llYo7MBoWx7mGj6YSGPfr+vglYzLIdyM59un3uVpmcJFRLDWuGsDFwUWrI2xrBqgt0S8+kqs/Y/2KbLOfHQEEYZg8bdh+MoxMBDP7nTraiT0gxlfeqk6UvuMuYNptk9Qry8uqjCLYRwTyKWsbHS/VeHc0E0N/HyOyQO+taVVc5OK3WC3c5crEsYDop6z+qFISemNhRkJuabd4yYVnq5XNaSm/bMRfuue0pWPzTcdKfeSyLgbMzCOtoK8hedLlzbmVQLAbtMGFgnLCrgmDYDuWsx43LdmHS9w3E2jGELSC+9OZbjK29CfeaNYy88h5kDKyw9aFc/3JmYX79fmei9Nm/O9sNWA8/HR/LkSRkCzCP4xwyJqJXCZOMy7hxjwX8vHEK1up57RYgzTgYUMDL8Vje03uz9YYJTRUElPp+9hpEuOfqnZWXg6hNqtqGNSJKWoW9PbpBGy/WrLENWqRD+wA3wgkOX0VjjZlBBAZpWrYTiJv4m2JDWBPH3v28yAutg7wsJfk112lZ/T7LnIYqv0z5bVywM8Hly860T7/oKzRXmp5GrjR0+bJMnbE/DZbvUquCPfJIBQOg8hTJ4Zpe5JOtOeKs6bWRtiVLDGKYAG9MsoBMgj4l1Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5310.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K1R2UVJMbFREcGZNdUQ1R3B0QmRjWWlLdldVYVRIZTRrV0lzS2dvQzMzK3VG?=
 =?utf-8?B?WlBBNUtpNC9xL25qdWdPQ251aWcyRlFQQnF6Z2hCUm02cjFrYkNlV0ZNTFFG?=
 =?utf-8?B?SldSVzN0aXI5LzRESG5jVmhFWEZDU1ZpbGpQZFRuUUx3OWFHQ1J0SnRQdEZT?=
 =?utf-8?B?cmMvcTZ3VVVnS2lEUkdPRU1QMldtNmZqeXZJOXUybjcxNVZnNFhKQ1o5Mldn?=
 =?utf-8?B?Wk5ObWhNWC9mUEhLTW1CUGhSYWx3d0paL2pHZlRXb0xFUVNlS0JDaEJ2YWxp?=
 =?utf-8?B?cWx1eTVraU1rS0k4aUd6UW1rT3hPRmpqeDU2UkVCN0M5QTYzc2pLUnRNTTFR?=
 =?utf-8?B?c1htTzJJa3g1OHNacjU0L0ZaWjFkVjJvREhoczVwZ29JLzRKNWxwdzVEOFpm?=
 =?utf-8?B?V1ZDUEsvZWkvdjl1eEs0TlBrdW5UM0s1ajh6VVpsb2xYY25zUmkzZ1VwVG1R?=
 =?utf-8?B?YWFZV05mSTE3WDJ5Tk5TV29wdEsxVUdUYkZqT3Y2OFdHYW9JeTV6bjJiNHVN?=
 =?utf-8?B?cHY2bGs2UG5rVnpDTis2bkMxblp3d0I0ZEtWRTJFZHNwdWo4UFB6TExSUnNv?=
 =?utf-8?B?MFQ5QTZ5NERCS0RnOU9FaWlTSXBsME12U3R3NTh1Rk5JaDFoc0NNVjc0bjV3?=
 =?utf-8?B?MTUvelhvbTZReExsRlRiVXMvaEZXZGdTMXpYV0J5NUZnTk56U2dwSTV3SGpz?=
 =?utf-8?B?MUtSbnJOclAzVG1YWE8zTWlxZUJKWk1xOS9hY1ZsVzQrNmVic3krWDd1MnBJ?=
 =?utf-8?B?VlJCVFVWZVB5c0VhcFFQWXJwb2FMaG1qbWZwRDNHU2F1aHZtK2Q3bDFxZUl5?=
 =?utf-8?B?ZDM0L0g5aURzTmNwNHVmQ0FZWXAyb1hPZmp2K0xpZ3NVUjRiSTR3b3RVMkpU?=
 =?utf-8?B?UUNHcTM3djJuYUlBNlF0M2dtcDI2VWZSYk1vYXgxc1d1Y1N3bUplRkc1Q2JD?=
 =?utf-8?B?MFJOL1FBaGwyUmFxdzBIWTFEL3FKRDRmUER0YkE5OHUyVHJHTXd6bFpxWUxV?=
 =?utf-8?B?UnN5cVM0TllNQXNGRkVGWFI5RTlydENyQVY4N1NoUHlQUzBUcGE2N3dZNGxL?=
 =?utf-8?B?Um9iTVhnY3RMd0NFNE9pWDFGZmxmRzhFVFAzejhLbnk5cCtvQTVrRXdJNW44?=
 =?utf-8?B?VnZ0aGV1d0VmUm5EV2cwWko1dHd6dkVxWlVPUmdBN0d1RU1KQ3hRZ09DZUZq?=
 =?utf-8?B?Y2Z6c1M5T2ZkZFBoVW5HTzhvaXlCRDNSdC9vR3dBNXlEWEdycGRLOVEyTWda?=
 =?utf-8?B?bEh4NDBuZzlxZnBnYWo4Sk0rVUU0THhhVE1QSXJkS2d3WnZReEdhNDY1ZFVr?=
 =?utf-8?B?R1YrMWc0ZE8wL3NvTS9kYmR6b0lOcWtIcVlvQXBPc2RlZWllU1NFYWhvb1hS?=
 =?utf-8?B?Um5NdFF5ZUh0cUM5S2VrWlFyU1FtWmk5bFNNRk54STNKSXgzaHJvU21PdVp3?=
 =?utf-8?B?L2tGbU9DRXcvbFZyNndhTDBkci9kWGM5SDVaeHVpUjc0OTNpOW42QUxHUmt4?=
 =?utf-8?B?Wms0TE1uclZoaFZvaTcyZ1d4alVKV0lpTjJMOExpbExXcE5hMVFxcDFuSVhM?=
 =?utf-8?B?eWdtaUlkZiszZklPM1orTlNFamh3THBVUHAvZStWbldVWXhVeW55MDJ4dXU4?=
 =?utf-8?B?QktxZTlabUlCbFdxK002UEN1SXRuZEx3VVdPVmJLRnpmLzNGd3hkdmVMekdF?=
 =?utf-8?B?NCtCenF0NXdmY2FwUk9DZHB4RmtOeGMvN2hiN1ZsMkNmMWhsNEZERVdUUmxt?=
 =?utf-8?B?MFBkWERPM1Z6VFVDckNYaVBkMDJBZE5IU0QyUGxKWTlrQWhQaDFpUTlyTkpC?=
 =?utf-8?B?dnprcTMvOGJ3SkFHMUY3c3RQK0ZlMkd5ZVgwdHhsRWZTMjAySStWb2l3dnZt?=
 =?utf-8?B?RjU4RlN6Zk52c1pSUXMzUUNENGhrY0dmR2o3cytRbUc0dnBNYkxHR1VzSGp5?=
 =?utf-8?B?ZFJQZktSdnpCWWlhY29WSDBnSEs5ZUdKaG5MVHZvWHJVT1NBK0JTMldrUVBC?=
 =?utf-8?B?ZU9Ea1hETFZxanpUN0V2MlVPVTA0YjM5QVdodXlaNUFkNWZudkVSK0lLQ1pJ?=
 =?utf-8?B?cU9UTkZWRUNiYm1VUDhMYWpqejJ5NDJIcWJQOFhPcStxSlhMNE1KRzZ1VFBj?=
 =?utf-8?B?d2EwU1JRYkpZN2VNUEV4WkdVNGFnM2VIMUNOZXF4U0c5U0Fvb0NjaWxBQ1hz?=
 =?utf-8?B?Q0FRSU9CNUNXYVVmeThMRjgyVUFjQi93ME5Ua0E2b2UxQ3VpNVhxeTdpdnVK?=
 =?utf-8?B?OEdKaFhiMUpPVUNOWk9PZUg1cnJKek9RWG1BbnNWVWpOY1UrZHd1cjh3K0tN?=
 =?utf-8?B?eWJxaXBqSFZMTUI3Z2JQQUpsQ0M3b2ZtNXRIYWRTRk5SUDhjNk1hUT09?=
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1c48a4-770b-467f-a6d5-08df2c06b61c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5310.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 04:25:44.8683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1z8FDO6QOZShYDVK7Mam1dPGsed4c7ZEyY5LVSg+gS4txT4lN+yH8Cdu4hSZmFWBAp2JZx9simdORzLeqYJzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CPH1PF76D0E694C
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_212554_226015_98D9E151 
X-CRM114-Status: GOOD (  11.69  )
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

[...]
> Unfortunately, no: there are contradicting statements here.

Hi Keith,

Sorry for the confusion, my previous replies were wrong and contradicted
the commit message. Let me restate it with new measurements.

To make sure the numbers are relevant, I switched to the latest nvme
branch, nvme-7.4 (2e8e30b3cf9f), and re-ran all the tests from scratch,
with and without the patch on top of it, on the same drive (Kioxia
CD6-V, NVMe 1.4, VWC 0x5, WCE cleared by default).

Both rows of each job in the commit message table were measured with
WCE cleared; only the kernel differs. Without the patch, WCE is ignored
and the namespace is exposed in write-back mode, so one Flush is sent
per fsync. With the patch, the namespace is in write-through mode and no
Flush is sent.

To answer your question, I measured the Flush latency at the driver
level, between the nvme_setup_cmd and nvme_complete_rq tracepoints:

  - passthrough: 2000 "nvme flush" sent directly to the device
  - fio: 4k randwrite, io_uring, direct, QD1, fsync=1, 10s

   kernel  | WCE | mode    | passthrough | fio: Flush | fio: fsync |  IOPS
           |     |         | Flush avg   | avg (drv)  | avg (fio)  |
--------+-----+---------+-------------+------------+------------+------
   nvme-7.4|  0  | back    |    194.8us  |   214.6us  |  236.1us  |  3917
   patched |  0  | through |    194.2us  |    (none)  |  5.7us  | 44433
   patched |  1  | back    |    194.2us  |   219.7us  |  237.1us  |  3916

So:

  - The block layer flush handling is not the reason: without the patch,
    the device accounts for ~215us of the ~236us fsync, the rest of the
    stack for ~21us.

  - The drive spends ~194us on a Flush whether the volatile write cache
    is enabled or not. It does not short-circuit the Flush when WCE is
    cleared, although the spec says it has no effect in that case.

  - Without the patch, WCE cleared therefore performs exactly like the
    volatile write cache enabled (3917 vs 3916 IOPS), while the patched
    kernel skips the Flush entirely (44433 IOPS).

The slow no-op Flush is a firmware behavior, but the kernel should not
send it in the first place when WCE is cleared, which is what the patch
does.

I also re-ran the commit message benchmark on nvme-7.4, WCE cleared in
both cases (fio 4k randwrite, fsync=1, 30s):

   job                   | kernel   |   IOPS | fsync avg | flushes |  gain
----------------------+----------+--------+-----------+---------+------
   psync buffered, QD1   | nvme-7.4 |   3917 |   249.2us | 117506 |
                         | patched  |  48227 |    15.7us |  0 | x12.3
----------------------+----------+--------+-----------+---------+------
   io_uring direct, QD1  | nvme-7.4 |   3888 |   238.2us | 116636 |
                         | patched  |  42580 |     5.5us |  0 | x11.0
----------------------+----------+--------+-----------+---------+------
   io_uring direct, QD32 | nvme-7.4 |   5674 |  5514.1us | 117774 |
                         | patched  | 140090 |   107.1us |  0 | x24.7

If you think it makes the commit message clearer, I can send a v2 with
these numbers, the kernel anitly, and the driver level Flush latency above.

Thanks,
Erwan




