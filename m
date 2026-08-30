Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57F1C61DB9
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Aug 2026 08:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+iMxSc243gm4e9BGIV9ILncY4YrUmdnSMQ8fJekRwU0=; b=QULXRsKo3icrE9fIMdSSk/7X8n
	QogwBkGVTApDTe6JE+QG3uPIBFxovEqvjLkFGKLWI/c93ha2Srv6FXF+r4S9DXfWPRsvBerKop8IP
	K4fITj0KSkykweF+zu2gPYasJPQZvs9tipweDHx6VYpTHHhf1xDW8JPE6hVHB/GynHtSrXi9VyE1a
	Rl/zA36ujO5mch7tfKKEjJAtpil8No8pHe7jDJEy8so/5cOpOAY4GIAdP6A8FP6B8csmTfmNiY+55
	5f6HMTfOtIkCY06GzMy9UsG8W5rRBoTCcJ2L6e1xEVsFLjYv++GGmZGvBgdsuxEwDzJ2991A9yI3M
	3tmIti2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0apD-00000007aii-2LuD;
	Sun, 30 Aug 2026 08:23:35 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0ap6-00000007aiK-0iMH
	for linux-nvme@lists.infradead.org;
	Sun, 30 Aug 2026 08:23:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1788078212; x=1819614212;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dsAFaV6GhH7oFEPQvufA7Xuo/T9KBAlzXfMlt4ymndA=;
  b=Ben1iT5W7GEAZ9HMFL78sCHHpl58pc6uTeJHrnOGG6vJyrVFD2+NC3ks
   GW7cmzOCaVszGCMIMzEIu3q8DA59QbI03OVTm8VWZ1KDvGLYdHCdMlNaK
   Pwyf4sVjQErsFCVqhL3DH+suuHpsPf3uONEPoL/0B38yXLoVvtBSKvyHJ
   DDwyjZ5mQg+L6cvIESEk2bEUZ6gEwdx6tqAw1XGej0tRHA0c98iVk318s
   l5NTKcfqrbMrj+7iDHDAd808d08UkySpZsHV4vrUvoJ4vakCEQoNCNPw4
   uVLLwILUvFgzZYKBHWz+9XrnGUzbkiP/UuMatgOS/2sZZa5GrDRnxkwrS
   w==;
X-CSE-ConnectionGUID: aPpclllfQ0+agFJVEAgAFQ==
X-CSE-MsgGUID: Daq4qpbyQOy5kaSWWyXWYw==
X-IronPort-AV: E=Sophos;i="6.25,251,1779120000"; 
   d="scan'208";a="152979186"
Received: from mail-centralusazon11011066.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.66])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2026 16:23:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpkaBRswLmblsvjuZK0AMgW9EbuTJv2RRc4eJz+qHIoAaGDoIvvLguYHplH/h7L1LgAStr7MFu8ncBowSzHtlxZq1+TJsSSJorCcjZpPwinBJKVP+Q78mpG66HfeTtaQgRcv7K6ffkXhQP1Zr0SBkVGVQYIuySU3FxKICMKEqMwyvdkwS6QZV/3OzwkIphgK40fjc9y7eWPG20oW5D1cszQ8hbNdNCzxNwQcblSP+BmgcPJ7QpFZtK2DOgcjFPMYuH87/fCGrEb1lTbeNBB8AfBbEkqCCCtPolwuCNiFoX5KTAz3DMCTZpYI9XUsrBgDU7P86z6lnXYzitSSvQLVXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iMxSc243gm4e9BGIV9ILncY4YrUmdnSMQ8fJekRwU0=;
 b=H+AYlkaWzk6VQlliKPQ24IfwTpZXl76HBJc/DGBZ+sAhaRCBVOiuxxpSYLvMIXCG6H/4bsyhT5Wo3FepmHL7/mVNwIn3Ag5+S2SJvIONxOLxyzvs55JYi3wpeNIS9jfkMQKm8FC2RFWRS2h13ZeGEXECaF/O4J6/EpQiEpMJnkcXG7ACMS6azWt0TwrliRSxfPGgDM7O9HlDH5GwAZG83zOKY2QnMhUHbW/lv9ZFJNLwrPYjrgXd3ea8uqNrEbUt+gQ664NmQsXgnxCnVabf8Plnsr3NaxDGC3WrG45Abjo9avA/4mp8e2oKuypa1bw1R6uvx05yKTeek8iK7+uayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iMxSc243gm4e9BGIV9ILncY4YrUmdnSMQ8fJekRwU0=;
 b=a4hiBnz+yJd1TZmqh5Rb3aAH6xNuxxt5Sj749EZQ9l2I46U8g1BBJqLWoS4w9m8rv4LeUwl9b4Oxbsb+AxXnTr9qd1cS5uegoHXaY28LROfqWGkoWqguPK0voDVMf8Ph05syZe0s8iooYDpViCzMolU1E0BTbhU/mJCNFkulgYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by DS2PR04MB994100.namprd04.prod.outlook.com
 (2603:10b6:8:4aa::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 30 Aug
 2026 08:23:21 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 08:23:21 +0000
Date: Sun, 30 Aug 2026 17:23:14 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>, 
	Keith Busch <kbusch@kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Daniel Wagner <dwagner@suse.de>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 7/6 RFC] nvme: test per-command retry delay
Message-ID: <apPZImACgVFO8Rsv@shinhome>
References: <20260823084903.193188-1-sagi@grimberg.me>
 <20260823084903.193188-8-sagi@grimberg.me>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823084903.193188-8-sagi@grimberg.me>
X-ClientProxiedBy: TY4P301CA0023.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::15) To DS3PR04MB10053.namprd04.prod.outlook.com
 (2603:10b6:8:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|DS2PR04MB994100:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d39568c-f8e1-4ed9-a5a8-08df066ff345
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|19092799006|1800799024|10067099003|56012099006|6133799003|4143699003|3023799007|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: CdA5/bXY1tSPB4VKxa+ijDv57isE67Z0AZVleS75afS4b6bvc/zWlGHklK99XSmwcOeHttnqldoCx6j8Iu2GwbOe3mq77wJYptv88Dj/We4KgRwuJAJg8Z2tFG0Gr4qRe4hyu8R4Txm2AajOZaWGAV2Vqg42+XWweRPTNAgdsgTS47rOzCveJQADl6OtJWgJ1ajsQzf7zDCZsfLcsV1pqJbfBT1/fk/N/OuMJryibfRPJRunObTfjFaMwC25Wj90SBuYrlvwNW5XAEFfr465qlB96C4/S21wwtZVW+g0KGTRC6tEscLa9TOWNrcp/QCrPzy9VcFH/cWenAHz4OPk4fgGZtVKSlBr5LqlE+FnEF3mrmGS7MpoABjpFrlPvUxKeRDtzPPjNAbbfUxiSsdy+xtTIDSv+ZJffJ5STOBHB7EpD070bwjBstcfo0q+Mke7NRGn+3gHa8mpzXgF3ZOgVTzsKLlDZj0u7Fh/q/muW4B7E1sOnXvycbNonouVK/NbJ07ShPbsfHV9QI+I0fLcDE069z90ifwnsIxEGxl7oWmbecP+oy7d1xka8FNI0wOdf2KJAbWF1S4p0MsxwfC1CeIa36z9u2K4HwZEbq8RwDpRcgr1Ll4v8lZkiCHT2sZkHtY4TIVz7460VWo95EtJnnpA3Q5ew07SYcjCt4HFxvI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(19092799006)(1800799024)(10067099003)(56012099006)(6133799003)(4143699003)(3023799007)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?svhEsO8mjniCE4kPPSv8MxbcNvPZz0pw5bIAcO1WWYyh1SUMG4rAv0mz7gFm?=
 =?us-ascii?Q?6v/o0LvzqSKWGapqhBeU+R3p1HKHGVF6pDzlZTgx9A+asIyHNuNM+K2EYbpZ?=
 =?us-ascii?Q?3IFdbr/8jUrq+iM68eBQLWbnKCPgH5xN7wXRb8CLNjUZT2PR2Ll6DepYLVgs?=
 =?us-ascii?Q?qtiWTmjyHeMe4/HXhE5QM/LK9eJ0hr0UtCdXcgxLSyD5TbwxW5Fq1JKF5UeN?=
 =?us-ascii?Q?yy4GMfw/lbE4u52yEQvdt4q7nkNTGXJA9hOiDltmykpbJXwqxkP6Wq8EfgtV?=
 =?us-ascii?Q?XzwajJdZLmiUz++JGoWTv/p/5i4obWE6q4qYSUrNPwlliSUTvqAcxca3E7i1?=
 =?us-ascii?Q?6S1Q8Hwt4FfjIXaLsSH+HBMwo1it9O9c8zcbcCiz9FMAg6Kl6MHQT7leh8OF?=
 =?us-ascii?Q?IdxrEff7SOvB6f9aX18r66pyCf9oDQ2DIMZzadpjCJxIq57gOVnAHQ5dkrcO?=
 =?us-ascii?Q?6TTRyNwdBOJrFHPMZ1pzTsZ7B8UTz1Ws+B+kgezPxRSeF8ZrbE72j3AQ/ow1?=
 =?us-ascii?Q?m7b13fZsN4cmZaC0Qib2QHvJBdg3p9Lq9X8TbgD+OaqlpDC7TSddBGKQshDL?=
 =?us-ascii?Q?EpVQDgvrJ1Dku2Nlk3zp6o/EiahNt+9d8vSn8olvdL0aQMpt0auv/eiU7BOK?=
 =?us-ascii?Q?ipmIbQJ+3H9HNg6plphuZ+wPTu1kETAXKKxos+YuG+ref2qcQKiRUAKMmk7+?=
 =?us-ascii?Q?ZSOWRbB/4i/FEN7jbu9bVkN2Emei3GYagVzyFdO303wG6DpzSIYTXudyGTR8?=
 =?us-ascii?Q?A5ZDWtFVI2EUl1Rla4Li3dPs1vQeM8oNLjdtOgwFtCqbcfDjRrfx0cPTEkvH?=
 =?us-ascii?Q?cnq+6OwokCRvFjEMM7455jOTBHiz+K9DshFCdllCCeEhNyCXRv6rXKNL/Awt?=
 =?us-ascii?Q?GE9kZUcbHhjagmK0d2tQIeZV0VrHvnJeL0SINNt1WGF67gFCFpq21YlMGfYy?=
 =?us-ascii?Q?8LcWyGo6dqE9nCBBt3qvRjq1W8fP9J4CqqqU9gWFnS2Dz8n1NzUOr88ShFzU?=
 =?us-ascii?Q?dGQTpCZjkk2zqZjJHWfGcHMWsZI+3Z5Uw9N78Rum1CxPm7WoKoZnNKHoL7Az?=
 =?us-ascii?Q?6uuNlDwXzhVvZneELYA1RfR60S/cAs0TtqEbN7mdSZxjO0uCohS1OxCvjsQJ?=
 =?us-ascii?Q?hqixMXLgd3+qCyDu/3iRhKQC/CNT+ovinQuQ61Xu2dV5KnXis88CvIMustcm?=
 =?us-ascii?Q?iPVbe1qLtNH7/Jw+SfiqdtdT61Xh4NznvSRjGCvStBZ392WQHxKQnkNPtStV?=
 =?us-ascii?Q?AwYEp5xLcMwf5dOKrCurGqiQhjSSXpEtgKctv52v0v7dn0YCZeGRnySwJQgN?=
 =?us-ascii?Q?s8OVRzJ+BcYZtga/4uysLwymgrJ4fkfl7JzEsBtLqy0gWzwvw88ynhfbjCM/?=
 =?us-ascii?Q?nr0qmw8nrMI+NE7P/vBc/N/85K6Suy8AgMZGOUn+g15qGcA6VKHqPor2WaiP?=
 =?us-ascii?Q?aZND+LiLpgLKnqInaBZuNBdO/s6lqlp2+Y8puepf+/p6YBPSjNdhwlfGjn36?=
 =?us-ascii?Q?IObgAqJn08zYcU8v21j5c/cRFivykSRYl3Iuo9GngVZshjDL3VH/5FNNFxHe?=
 =?us-ascii?Q?DbaBJQBqsax9oWYK7zrdeiJy1MSbZ7rOTKT/ILdAcHjLdhnPpNlzSQJk3hgE?=
 =?us-ascii?Q?GqIZ8/sd2iusZr9SQFpi0nW9dDgaGryHEpxJO3LBqAJWlsnLnVfRR/FqV/vK?=
 =?us-ascii?Q?rxwqkOyLbdXsID/CBkwXqnmOL4QIuYqU+R915GX3zm2GaXfkw+O034GkH9eB?=
 =?us-ascii?Q?qj+vJsnqoVsAIzp45XqHGGFmyiwiu5I=3D?=
X-Exchange-RoutingPolicyChecked: 1M7rBUgWSzcBeO0gcFFxRg/qRs5qXOP2H0YJDE25vXfhfa3yiD7l7EcCzDK5AI5UzT/M3RgG2n+KCnn/ddecCa7azGHyzzXPs6wpqfrH69g8qSf+6hPITyQsTcIDTXm5UdJDXwkEx0HlA2oXFbJRfkez2vSWwF3g1rGxvTjMbebx2yy6/S5CFDvL2DUVEzU7lTDEykuSArn9cJpUcU5XHN2bmys0DuPEvd7kVeA2kpL2D3K8uk2EC/dFfHk94SLp8isFOLi6ueyLuZK1UQxql7e2V+RjIM4mqYVUNswdiWeVIifdtmQr4okE6oIluECEG9Nw0Q29eH4xMsebVgQ4qw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Sz324RSMvDzbeF5vrfVgwylkfpHPvWphmBFk2MAeJ8jq/O4EWmosW9xXt/iAIzL5bigfQdK4MVGaRB4UJLVuBiGDVs6U17674zYUiWKCUdJ48XVOL53yIAzKAy1rbPyEEBkLNo3kHbcDr+J3KrvbXOfBZVFZtIegyOwJ5kjOXb6nmLkdj/gcRtpfMkNgZxPacwbBHkHBBK0B+wBX1qwk8KtY62GPE7gtsu6omGUTBf+w0kec+83qZi9X+slKk/wXcGSRRCHlCC+sSj85/QQs4soSrfjrngbmMsyMWhrdAVzdzw/ECE+j2w7IqbOV32tSU73OnkoMG2SnYAfX7/X/c8jCsFMPgys+1JkIiZeUfdmNgvW/66xpAwVd+6oHmrnee6DsXtIaI0HwMYo14/GZBgjTrbMZ9jimwkAv1USyCbqEwvIIcxlG2rVZIBPhgb1QMMfdG5ZHEceqOU1i/ZZqGSfHh9HExDQU1zilcuUTgmXJnT9opbQuO2DgHgXht8GFBANbeI+IovNTZTYaGuoFQc7Sebs1nxuSAIvISdyaeTT0pSP39bJIXJJ5Daom5eu7mq118cPLgzptVgyhqP+xZzeQVDvnDP+l/L+wMy17L5/praUmh+2kBdLCFqLiw+dU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d39568c-f8e1-4ed9-a5a8-08df066ff345
X-MS-Exchange-CrossTenant-AuthSource: DS3PR04MB10053.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 08:23:21.0693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9hUK1sK6x165yvE2G1E7P6X5REPhyCyS6l9K1xUhJ60W/9ioTTcYnd/unMm7c4CI2UCySXJTZUmFDugCilWwv+SFRrFc6GzjtRDNfjvJ/rY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR04MB994100
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_012328_289872_92BE6826 
X-CRM114-Status: GOOD (  31.57  )
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

On Aug 23, 2026 / 11:49, Sagi Grimberg wrote:
> Add tests to exercise host command retry delays handling.
> 
> 070: check that basic command RETRY disposition works and respect ctrl
>      crd
> 071: check that basic command FAILOVER disposition works and respects
>      ctrl crd
> 072: check that different commands completed with different crd levels
>      are retried independently, each respecting its paired completion
>      crd level
> 073: check that different commands completed with different crd levels
>      are failed-over independently, each respecting its paired completion
>      crd level
> 
> These tests rely on nvmet support for subsystem crdt attributes
> (_require_nvmet_crdt) and nvme host crd error injection support.
> 
> In addition we add some common nvme helpers to set nvmet attributes,
> inject errors, and leverage nvme diags to count retries/failovers.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Thank you for the patch. I ran the added four test cases using the kernel with
the kernel patches, and observed the all four test cases passed. Good.

I walked through the new test cases. Overall, they look good. One point to
improve is the global variable used to return a value. I will comment it in-
line.

I found the new test cases measure some numbers like retry count, failover
count, or elapsed times. Those numbers are used as pass/fail criteria. The
numbers are logged in the FULL file, but it might be useful to print the
numbers in the test run console like this:

nvme/070 (tr=loop) (test NVMe CRD per-request retry under fio) [passed]
    retries after   41       ...  42
    retries before  0        ...  0
    runtime         24.808s  ...  24.844s
nvme/071 (tr=loop) (test NVMe CRD multipath failover under fio) [passed]
    failovers after   100      ...  100
    failovers before  0        ...  0
    runtime           13.764s  ...  13.789s
nvme/072 (tr=loop) (test NVMe CRD per-request retry timer independence) [passed]
    CRD1 write  1090ms   ...  1079ms
    CRD2 write  10563ms  ...  10416ms
    runtime     12.363s  ...  12.166s
nvme/073 (tr=loop) (test NVMe CRD multipath failover timer independence) [passed]
    CRD1 failover  1068ms   ...  1065ms
    CRD2 failover  10091ms  ...  10349ms
    runtime        13.153s  ...  13.432s

FYI, I attached the script changes to print the numbers [*].It uses TEST_RUN[*]
feature of blktests.

Also, please find my in-line comments below:

> diff --git a/common/nvme b/common/nvme
> index f3999378db2d..a224dca61840 100644
> --- a/common/nvme
> +++ b/common/nvme

[...]

> +_nvme_now_ms() {
> +	echo $(($(date +%s%N) / 1000000))
> +}

Just comment: this funcion might worth moving to common/rc: tests/thtrol/*
scripts do almost same thing.

[...]

> +# Background timed direct write. Sets nvme_bg_timed_pid (do NOT call from $()).
> +# Writes elapsed ms to <result_file>, or FAIL on I/O error.
> +_nvme_bg_timed_direct_write() {
> +	local dev=$1
> +	local result=$2
> +
> +	rm -f "${result}"
> +	(
> +		local start end
> +		start="$(_nvme_now_ms)"
> +		if dd if=/dev/zero of="${dev}" bs=4k count=1 oflag=direct \
> +			status=none conv=notrunc 2>>"$FULL"; then
> +			end="$(_nvme_now_ms)"
> +			echo $((end - start)) >"${result}"
> +		else
> +			echo FAIL >"${result}"
> +		fi
> +	) &
> +	nvme_bg_timed_pid=$!
> +}

_nvme_bg_timed_direct_write() uses the global variable nvme_bg_timed_pid to
return the pid to the caller. It is not the best to use global variables for
that purpose. Also, shellcheck warns this:

   common/nvme:1773:2: warning: nvme_bg_timed_pid appears unused. Verify use (or export if used externally). [SC2034]

In general, bash functions return value with the "echo back" method. But I
understand this method won't work here, since sub-shell $() is required to pass
the echoed value to the caller. With this, the background task is no longer a
child of the caller, then the wait command for the received pid fails with the
error "wait: pid x is not a child of this shell".

As the solution for such scenarios, bash provides "nameref" feature (local -n),
which is like the pointer of the C language. The hunk below will add the third
argument to return the pid to the caller. I will comment how the caller sides
will change later.

diff --git a/common/nvme b/common/nvme
index f323c6c..273fa66 100644
--- a/common/nvme
+++ b/common/nvme
@@ -1752,14 +1752,15 @@ _nvme_timed_direct_write() {
 	echo $((end - start))
 }
 
-# Background timed direct write. Sets nvme_bg_timed_pid (do NOT call from $()).
-# Writes elapsed ms to <result_file>, or FAIL on I/O error.
+# Background timed direct write. Writes elapsed ms to <result_file>, or FAIL on
+# I/O error. Return the pid of the background process with bash nameref feature.
 _nvme_bg_timed_direct_write() {
 	local dev=$1
 	local result=$2
+	local -n pid=$3
 
 	rm -f "${result}"
-	(
+	{
 		local start end
 		start="$(_nvme_now_ms)"
 		if dd if=/dev/zero of="${dev}" bs=4k count=1 oflag=direct \
@@ -1769,8 +1770,8 @@ _nvme_bg_timed_direct_write() {
 		else
 			echo FAIL >"${result}"
 		fi
-	) &
-	nvme_bg_timed_pid=$!
+	} &
+	pid=$!
 }
 

> diff --git a/tests/nvme/070 b/tests/nvme/070
> new file mode 100755
> index 000000000000..14d7160664a0
> --- /dev/null
> +++ b/tests/nvme/070
> @@ -0,0 +1,95 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2026 Sagi Grimberg <sagi@grimberg.me>
> +#
> +# Test NVMe command retry delay (CRD) with the per-request retry timer.
> +# Requires nvmet attr_crdt* and host fault_inject/crd.
> +
> +. tests/nvme/rc
> +
> +DESCRIPTION="test NVMe CRD per-request retry under fio"
> +QUICK=1
> +
> +# NVME_SC_INTERNAL

Nit: the line above does not look meaningful when I see the line below.

> +NVME_SC_INTERNAL=0x6
> +

[...]

> +test() {
> +	local fio_pid
> +	local ns
> +	local retries_before
> +	local retries_after
> +	local inject_dev
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +	_nvmet_target_setup
> +	# CRDT1 = 5 * 100ms = 500ms
> +	_nvmet_set_crdt 5 0 0
> +
> +	_nvme_connect_subsys
> +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
> +
> +	inject_dev=$(_nvme_fault_inject_devs "${ns}" | head -1)
> +	_nvme_set_ns_diag "${inject_dev}" command_retries_count 0 || true
> +	retries_before=$(_nvme_get_ns_diag "${inject_dev}" command_retries_count)
> +
> +	_run_fio_verify_io --filename="/dev/${ns}" \
> +			   --group_reporting --ramp_time=2 \
> +			   --time_based --runtime=20 &> "$FULL" &

Nit: It is a bit safer to use "&>>" instaed of "&>" in case prep helper
functions leave logs in the FULL file.

[...]

> diff --git a/tests/nvme/072 b/tests/nvme/072
> new file mode 100755
> index 000000000000..2acda72cdd44
> --- /dev/null
> +++ b/tests/nvme/072

[...]

> +test() {
> +	local ns
> +	local inject_dev
> +	local crd2_pid crd1_pid
> +	local crd2_result crd1_result
> +	local crd2_elapsed crd1_elapsed
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +	_nvmet_target_setup
> +	_nvmet_set_crdt "${CRDT1}" "${CRDT2}" 0
> +
> +	_nvme_connect_subsys
> +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
> +	inject_dev=$(_nvme_fault_inject_devs "${ns}" | head -1)
> +
> +	echo "ns=${ns} inject=${inject_dev}" >>"$FULL"
> +	echo "CRDT CRD1=${CRD1_MS}ms CRD2=${CRD2_MS}ms"
> +
> +	if [[ ! -e /sys/kernel/debug/${inject_dev}/fault_inject/crd ]]; then
> +		echo "FAIL: missing fault_inject/crd on ${inject_dev}"
> +		_nvme_disconnect_subsys
> +		_nvmet_target_cleanup
> +		return 1
> +	fi
> +
> +	crd2_result="${TMPDIR}/crd2_elapsed"
> +	crd1_result="${TMPDIR}/crd1_elapsed"
> +
> +	echo "Arming CRD2 and starting first write"
> +	_nvme_arm_crd_inject "${inject_dev}" 0 "${NVME_SC_INTERNAL}" 2 1 || return 1
> +	echo "inject: status=${NVME_SC_INTERNAL} crd=2 times=1" >>"$FULL"
> +	_nvme_bg_timed_direct_write "/dev/${ns}" "${crd2_result}"
> +	crd2_pid=$nvme_bg_timed_pid

With the nameref, the two lines above are to be modified as follows:

	_nvme_bg_timed_direct_write "/dev/${ns}" "${crd2_result}" crd2_pid

> +	echo "CRD2 write pid=${crd2_pid}" >>"$FULL"
> +
> +	if ! _nvme_wait_inject_consumed "${inject_dev}"; then
> +		echo "FAIL: CRD2 inject was not consumed"
> +		_nvme_disarm_crd_inject "${inject_dev}"
> +		kill "${crd2_pid}" 2>/dev/null || true
> +		wait "${crd2_pid}" 2>/dev/null || true
> +		_nvme_disconnect_subsys
> +		_nvmet_target_cleanup
> +		return 1
> +	fi
> +	echo "CRD2 latched; arming CRD1 while CRD2 retry is pending" >>"$FULL"
> +
> +	echo "Arming CRD1 and starting second write (CRD2 still pending)"
> +	_nvme_arm_crd_inject "${inject_dev}" 0 "${NVME_SC_INTERNAL}" 1 1 || return 1
> +	echo "inject: status=${NVME_SC_INTERNAL} crd=1 times=1" >>"$FULL"
> +	_nvme_bg_timed_direct_write "/dev/${ns}" "${crd1_result}"
> +	crd1_pid=$nvme_bg_timed_pid

Same here:

	_nvme_bg_timed_direct_write "/dev/${ns}" "${crd1_result}" crd1_pid

> +	echo "CRD1 write pid=${crd1_pid}" >>"$FULL"
> +
> +	echo "Waiting for both writes (expect CRD1~${CRD1_MS}ms then CRD2~${CRD2_MS}ms)"
> +	wait "${crd1_pid}" || true
> +	wait "${crd2_pid}" || true
> +	_nvme_disarm_crd_inject "${inject_dev}"
> +	udevadm settle >/dev/null 2>&1 || true
> +
> +	crd1_elapsed="$(cat "${crd1_result}" 2>/dev/null || echo FAIL)"
> +	crd2_elapsed="$(cat "${crd2_result}" 2>/dev/null || echo FAIL)"
> +	echo "CRD1 write elapsed ${crd1_elapsed}ms (expected ~${CRD1_MS}ms)" >>"$FULL"
> +	echo "CRD2 write elapsed ${crd2_elapsed}ms (expected ~${CRD2_MS}ms)" >>"$FULL"
> +
> +	if [[ "${crd1_elapsed}" == "FAIL" || -z "${crd1_elapsed}" ]]; then
> +		echo "FAIL: CRD1 write did not complete"
> +	else
> +		echo "CRD1 write elapsed ${crd1_elapsed}ms" | sed -E 's/(elapsed )[0-9]+/\1NUM/'
> +		_nvme_check_crd_elapsed "CRD1 write" "${crd1_elapsed}" "${CRD1_MS}" "$((CRD2_MS / 2))"
> +	fi
> +	if [[ "${crd2_elapsed}" == "FAIL" || -z "${crd2_elapsed}" ]]; then
> +		echo "FAIL: CRD2 write did not complete"
> +	else
> +		echo "CRD2 write elapsed ${crd2_elapsed}ms" | sed -E 's/(elapsed )[0-9]+/\1NUM/'
> +		_nvme_check_crd_elapsed "CRD2 write" "${crd2_elapsed}" "${CRD2_MS}"
> +	fi
> +
> +	_nvme_disconnect_subsys
> +	_nvmet_target_cleanup
> +	udevadm settle >/dev/null 2>&1 || true
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/072.out b/tests/nvme/072.out
> new file mode 100644
> index 000000000000..d9f4520c8d23
> --- /dev/null
> +++ b/tests/nvme/072.out
> @@ -0,0 +1,8 @@
> +Running nvme/072
> +CRDT CRD1=1000ms CRD2=10000ms
> +Arming CRD2 and starting first write
> +Arming CRD1 and starting second write (CRD2 still pending)
> +Waiting for both writes (expect CRD1~1000ms then CRD2~10000ms)
> +CRD1 write elapsed NUMms
> +CRD2 write elapsed NUMms
> +Test complete
> diff --git a/tests/nvme/073 b/tests/nvme/073
> new file mode 100755
> index 000000000000..34911392437a
> --- /dev/null
> +++ b/tests/nvme/073

[...]

> +test() {
> +	local ns
> +	local port
> +	local -a ports
> +	local -a path_devs
> +	local path0
> +	local path1
> +	local fo_before fo_after
> +	local crd2_pid crd1_pid
> +	local crd2_result crd1_result
> +	local crd2_elapsed crd1_elapsed
> +	local sync_start
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	_setup_nvmet
> +	_nvmet_target_setup --ports 2
> +	_nvmet_set_crdt "${CRDT1}" "${CRDT2}" 0
> +
> +	_get_nvmet_ports "${def_subsysnqn}" ports
> +	for port in "${ports[@]}"; do
> +		_setup_nvmet_port_ana "${port}" 1 "optimized"
> +		_nvme_connect_subsys --port "${port}" --no-wait-ns
> +	done
> +	sleep 1
> +
> +	ns=$(_find_nvme_ns "${def_subsys_uuid}")
> +	mapfile -t path_devs < <(_nvme_path_ns_devs "${ns}")
> +	if ((${#path_devs[@]} < 2)); then
> +		echo "FAIL: need >=2 path namespaces, found ${#path_devs[@]} (${path_devs[*]})"
> +		_nvme_disconnect_subsys
> +		_nvmet_target_cleanup
> +		return 1
> +	fi
> +
> +	path0=${path_devs[0]}
> +	path1=${path_devs[1]}
> +	echo "ns=${ns} path0=${path0} path1=${path1}" >>"$FULL"
> +	echo "CRDT CRD1=${CRD1_MS}ms CRD2=${CRD2_MS}ms"
> +
> +	if [[ ! -e /sys/kernel/debug/${path0}/fault_inject/crd ]]; then
> +		echo "FAIL: missing fault_inject/crd on ${path0}"
> +		_nvme_disconnect_subsys
> +		_nvmet_target_cleanup
> +		return 1
> +	fi
> +
> +	_nvme_set_ns_diag "${path0}" multipath_failover_count 0 || true
> +	_nvme_set_ns_diag "${path1}" multipath_failover_count 0 || true
> +	fo_before=$(_nvme_get_ns_diag "${path0}" multipath_failover_count)
> +
> +	crd2_result="${TMPDIR}/crd2_elapsed"
> +	crd1_result="${TMPDIR}/crd1_elapsed"
> +
> +	echo "Arming CRD2 on path0 and starting first write"
> +	_nvme_arm_crd_inject "${path0}" 0 "${NVME_SC_INTERNAL_PATH_ERROR}" 2 1 || return 1
> +	echo "path0 inject: path_error crd=2 times=1" >>"$FULL"
> +	_nvme_bg_timed_direct_write "/dev/${ns}" "${crd2_result}"
> +	crd2_pid=$nvme_bg_timed_pid

Same here:

	_nvme_bg_timed_direct_write "/dev/${ns}" "${crd2_result}" crd2_pid

> +	echo "CRD2 write pid=${crd2_pid}" >>"$FULL"
> +
> +	sync_start="$(_nvme_now_ms)"
> +	while (( $(_nvme_get_ns_diag "${path0}" multipath_failover_count) <= fo_before )); do
> +		if (( $(_nvme_now_ms) - sync_start > 2000 )); then
> +			echo "FAIL: CRD2 failover was not scheduled on ${path0}"
> +			_nvme_disarm_crd_inject "${path0}"
> +			kill "${crd2_pid}" 2>/dev/null || true
> +			wait "${crd2_pid}" 2>/dev/null || true
> +			_nvme_disconnect_subsys
> +			_nvmet_target_cleanup
> +			return 1
> +		fi
> +		sleep 0.01
> +	done
> +	echo "CRD2 failover pending; path0 still selectable (NUMA/current)" >>"$FULL"
> +
> +	# Same path again: latch CRD1 while the CRD2 fot is still pending.
> +	echo "Arming CRD1 on path0 and starting second write (CRD2 still pending)"
> +	_nvme_arm_crd_inject "${path0}" 0 "${NVME_SC_INTERNAL_PATH_ERROR}" 1 1 || return 1
> +	echo "path0 inject: path_error crd=1 times=1" >>"$FULL"
> +	_nvme_bg_timed_direct_write "/dev/${ns}" "${crd1_result}"
> +	crd1_pid=$nvme_bg_timed_pid

Same here:

	_nvme_bg_timed_direct_write "/dev/${ns}" "${crd1_result}" crd1_pid

> +	echo "CRD1 write pid=${crd1_pid}" >>"$FULL"
> +
> +	echo "Waiting for both writes (expect CRD1~${CRD1_MS}ms then CRD2~${CRD2_MS}ms)"
> +	wait "${crd1_pid}" || true
> +	wait "${crd2_pid}" || true
> +	_nvme_disarm_crd_inject "${path0}"
> +	udevadm settle >/dev/null 2>&1 || true
> +
> +	crd1_elapsed="$(cat "${crd1_result}" 2>/dev/null || echo FAIL)"
> +	crd2_elapsed="$(cat "${crd2_result}" 2>/dev/null || echo FAIL)"
> +	fo_after=$(_nvme_get_ns_diag "${path0}" multipath_failover_count)
> +	echo "CRD1 failover elapsed ${crd1_elapsed}ms (expected ~${CRD1_MS}ms)" >>"$FULL"
> +	echo "CRD2 failover elapsed ${crd2_elapsed}ms (expected ~${CRD2_MS}ms)" >>"$FULL"
> +	echo "path0 failover count ${fo_before} -> ${fo_after}" >>"$FULL"

The lines above causes a shellcheck warn:

  tests/nvme/073:131:2: note: Consider using { cmd1; cmd2; } >> file instead of individual redirects. [SC2129]

I suggest to modify the lines as follows:

	{
		echo "CRD1 failover elapsed ${crd1_elapsed}ms (expected ~${CRD1_MS}ms)"
		echo "CRD2 failover elapsed ${crd2_elapsed}ms (expected ~${CRD2_MS}ms)"
		echo "path0 failover count ${fo_before} -> ${fo_after}"
	} >>"$FULL"

> +
> +	if (( fo_after < fo_before + 2 )); then
> +		echo "FAIL: expected two failovers on path0, got ${fo_before} -> ${fo_after}"
> +	fi
> +
> +	if [[ "${crd1_elapsed}" == "FAIL" || -z "${crd1_elapsed}" ]]; then
> +		echo "FAIL: CRD1 failover write did not complete"
> +	else
> +		echo "CRD1 failover elapsed ${crd1_elapsed}ms" | sed -E 's/(elapsed )[0-9]+/\1NUM/'
> +		_nvme_check_crd_elapsed "CRD1 failover" "${crd1_elapsed}" "${CRD1_MS}" "$((CRD2_MS / 2))"
> +	fi
> +	if [[ "${crd2_elapsed}" == "FAIL" || -z "${crd2_elapsed}" ]]; then
> +		echo "FAIL: CRD2 failover write did not complete"
> +	else
> +		echo "CRD2 failover elapsed ${crd2_elapsed}ms" | sed -E 's/(elapsed )[0-9]+/\1NUM/'
> +		_nvme_check_crd_elapsed "CRD2 failover" "${crd2_elapsed}" "${CRD2_MS}"
> +	fi
> +
> +	_nvme_disconnect_subsys
> +	_nvmet_target_cleanup
> +	udevadm settle >/dev/null 2>&1 || true
> +
> +	echo "Test complete"
> +}

[...]

> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 31a0fc59ff4b..f286d9a95cce 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -505,17 +505,39 @@ _nvme_err_inject_cleanup()
>  
>  _nvme_enable_err_inject()
>  {
> +	# Set status/dont_retry[/crd] before arming probability/times so concurrent
> +	# I/O cannot observe the debugfs defaults (INVALID_OPCODE + DNR).
>          _set_attr "$2" /sys/kernel/debug/"$1"/fault_inject/verbose
> -        _set_attr "$3" /sys/kernel/debug/"$1"/fault_inject/probability
>          _set_attr "$4" /sys/kernel/debug/"$1"/fault_inject/dont_retry
>          _set_attr "$5" /sys/kernel/debug/"$1"/fault_inject/status
> +	if [[ -n "${7:-}" && -e /sys/kernel/debug/"$1"/fault_inject/crd ]]; then
> +		_set_attr "$7" /sys/kernel/debug/"$1"/fault_inject/crd
> +	fi
>          _set_attr "$6" /sys/kernel/debug/"$1"/fault_inject/times
> +        _set_attr "$3" /sys/kernel/debug/"$1"/fault_inject/probability
> +}

Just comment: this function uses spaces for indent regardless of the patch. The
hunk above also uses spaces for indent, but I think it's fine to keep the
consistency. It is ideal to replace the spaces for indent in the function later.
I found three other injection related function in tests/nvme/rc uses spaces for
indent.



[*] Changes to report pass/fail criteria numbers in the test run console

diff --git a/tests/nvme/070 b/tests/nvme/070
index 14d7160..8fbbd77 100755
--- a/tests/nvme/070
+++ b/tests/nvme/070
@@ -84,6 +84,8 @@ test() {
 	wait "${fio_pid}" || echo "FAIL: fio exited with errors (see $FULL)"
 
 	retries_after=$(_nvme_get_ns_diag "${inject_dev}" command_retries_count)
+	TEST_RUN["retries before"]=$retries_before
+	TEST_RUN["retries after"]=$retries_after
 	if (( retries_after <= retries_before )); then
 		echo "command_retries_count did not increase (${retries_before} -> ${retries_after})"
 	fi
diff --git a/tests/nvme/071 b/tests/nvme/071
index 897a883..644921a 100755
--- a/tests/nvme/071
+++ b/tests/nvme/071
@@ -173,6 +173,8 @@ test() {
 
 	inject_after=$(_nvme_get_ns_diag "${inject_dev}" multipath_failover_count)
 	echo "failovers ${inject_dev}: ${inject_before} -> ${inject_after}" >> "$FULL"
+	TEST_RUN["failovers before"]=$inject_before
+	TEST_RUN["failovers after"]=$inject_after
 	if (( inject_after <= inject_before )); then
 		echo "FAIL: multipath_failover_count on ${inject_dev} did not increase (${inject_before} -> ${inject_after})"
 		dump_fault_inject "${inject_dev}"
diff --git a/tests/nvme/072 b/tests/nvme/072
index 2acda72..4515285 100755
--- a/tests/nvme/072
+++ b/tests/nvme/072
@@ -101,12 +99,14 @@ test() {
 		echo "FAIL: CRD1 write did not complete"
 	else
 		echo "CRD1 write elapsed ${crd1_elapsed}ms" | sed -E 's/(elapsed )[0-9]+/\1NUM/'
+		TEST_RUN["CRD1 write"]="${crd1_elapsed}"ms
 		_nvme_check_crd_elapsed "CRD1 write" "${crd1_elapsed}" "${CRD1_MS}" "$((CRD2_MS / 2))"
 	fi
 	if [[ "${crd2_elapsed}" == "FAIL" || -z "${crd2_elapsed}" ]]; then
 		echo "FAIL: CRD2 write did not complete"
 	else
 		echo "CRD2 write elapsed ${crd2_elapsed}ms" | sed -E 's/(elapsed )[0-9]+/\1NUM/'
+		TEST_RUN["CRD2 write"]="${crd2_elapsed}"ms
 		_nvme_check_crd_elapsed "CRD2 write" "${crd2_elapsed}" "${CRD2_MS}"
 	fi
 
diff --git a/tests/nvme/073 b/tests/nvme/073
index 3491139..27b682d 100755
--- a/tests/nvme/073
+++ b/tests/nvme/073
@@ -140,12 +140,14 @@ test() {
 		echo "FAIL: CRD1 failover write did not complete"
 	else
 		echo "CRD1 failover elapsed ${crd1_elapsed}ms" | sed -E 's/(elapsed )[0-9]+/\1NUM/'
+		TEST_RUN["CRD1 failover"]="${crd1_elapsed}"ms
 		_nvme_check_crd_elapsed "CRD1 failover" "${crd1_elapsed}" "${CRD1_MS}" "$((CRD2_MS / 2))"
 	fi
 	if [[ "${crd2_elapsed}" == "FAIL" || -z "${crd2_elapsed}" ]]; then
 		echo "FAIL: CRD2 failover write did not complete"
 	else
 		echo "CRD2 failover elapsed ${crd2_elapsed}ms" | sed -E 's/(elapsed )[0-9]+/\1NUM/'
+		TEST_RUN["CRD2 failover"]="${crd2_elapsed}"ms
 		_nvme_check_crd_elapsed "CRD2 failover" "${crd2_elapsed}" "${CRD2_MS}"
 	fi
 


