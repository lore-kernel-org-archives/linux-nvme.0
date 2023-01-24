Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B9AC25B50
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 12:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EPSZbsA3TfJ5InQy0WZVATEFcF8bLMyqZMdJvQrmsLE=; b=Y2Jo79pokhEkLESXxV98YkTy6b
	zfhRO9+6WKLA1AE5l6Qi7D5yUIoBcOKR4p9HoO9qBN/9HymYBO90jmrGR07j5tmp28JrqRzLdn0c0
	DQLn8O7q1a1fMC9MshP+Zp/B5IKAUlSBNL7jJGsqg2fhB7cWYcgIdgDbCSKwaz89f1E8AtgW3ghWc
	vdccgLtw6Qw1EMc3zp/MDZB0nfxeHUM8mkiDzKgykTB8KB2a57bUpjrw0zJ8OrTwRWh9Zmjzk5jLa
	MKhV6Icfo7AKyO5opL/UOEsBORGsNIBdWotAvc1PP2Dlx+ED1po6pAGGkmuqYbm6yWdG8zCGBo4yp
	94qsRQBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKI2J-003chP-5I; Tue, 24 Jan 2023 12:04:23 +0000
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com ([40.107.94.54] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKI2A-003cco-Ro
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 12:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQc+2qLBrfuKqtiXKKVrHqJdGC/AH6DHxuUguBIgkV2JQkhYwPoxBuIzH7rkUL4vkeR1ojOTPVWBGqlG2kbvepw5cnMhKjwIQik2nZSzVr7sgs63mu4cQY1u/XHHEbIzA0+l7QX52uEgctKU1LzSN6dFizdBGm8bxzE75dbs4ZIoN34bhSb71hiGY5VaaJfT0jkITyhRer5AtpbRK955aMt+YfSAsNoBU+bryZGgKkZ5R/Ff+dTRx5AeV6lNBwxWPsmVWC4qbquSM3pK77BEI2tEchZZ4T6Ug6wrcAeWhYRrfYTxSy5Sd00wc7sGryKCm90cGuZmI/VRrBnCkzBjng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPSZbsA3TfJ5InQy0WZVATEFcF8bLMyqZMdJvQrmsLE=;
 b=FL9lvYg0rHmb+ZuIO15db5vbDBSuqCk7d2eJf2cNJmgmYSrHAcSe7PjWOy6QgJOSDTvA+PXK/A3g9oC+jwrWqcnVFGDRQJiN01T1HmCzpUyCJC5W1zJm6HEwHSPVaAxAanzKadgVwQtO+2y71CbA30CK6ScSaDwHz1yHxhIgqVPBQ5nWVHq0Lut/F6BX9q+9nI9mpkwLpGfU3/GMjJDRj2iUgm+tF0gv6ve26/ckwL3RIN9jpkX1U8BzQXEf+3cWXzKRHg3YqLMXsc0dG+69MjwaVIWKLSdyUE1n+1pn/qNpGEa3dOKi+6pLQjsSB4/GtuuLQ3sM1ki978sR7EiyZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPSZbsA3TfJ5InQy0WZVATEFcF8bLMyqZMdJvQrmsLE=;
 b=X1mwMGnApcvGMzYxssX16ACkqufMD2D9bjE0+vR/dpzMh5BSQMCml0mwm93QcFhsoKGG1YqW4EyZaxGPE9XchDP87DiZNVrv4Ml/pLh1rgWKOOcyuOx64XOLWCvb3wMdVCHqJFRzcWF4+jMjHCO4nAscyCt+i9MWfbrDgvtYQ0C1hHh/O9Psv/I48C8KJIxiQjL7UHVJzKFtAXJZ3/mDPEoC4iHNGcDwU2VjIhclmSDMXFFxEWPJKnxzz6RLDaBOemUI3WyjICFLNX5cbrf7cAcc1DPaVuodH9xeBqA8Zp1AzhZ0dGFVOUEW5zf2aWNrz79sNUwKoO3xHT6QbDYrgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH0PR12MB7960.namprd12.prod.outlook.com (2603:10b6:510:287::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 12:04:09 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::6d66:a4bb:4018:3c70]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::6d66:a4bb:4018:3c70%8]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 12:04:09 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com
Subject: Re: [PATCH v9 02/25] net/ethtool: add new stringset
 ETH_SS_ULP_DDP_{CAPS,STATS}
In-Reply-To: <20230123143256.0666646d@kernel.org>
References: <20230117153535.1945554-1-aaptel@nvidia.com>
 <20230117153535.1945554-3-aaptel@nvidia.com>
 <20230119183646.0c85ac52@kernel.org>
 <253r0vlrtld.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
 <20230123143256.0666646d@kernel.org>
Date: Tue, 24 Jan 2023 14:04:03 +0200
Message-ID: <253r0vkuojw.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::11) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH0PR12MB7960:EE_
X-MS-Office365-Filtering-Correlation-Id: 168feb37-7d7c-4a6a-8664-08dafe0319ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	9J1A/mel59nm3CfbrmNXe3wfqOIv1FyvESeSHJ6vtagk3dL6Dg4Jyt3IFItEP8P2p8bH3+9+eAPzEOl1BVEOpuZWmpr9J2+Z0HYOn2I5/vwH+eu8FVGhJ3FvEPKWwe4qLMCOk8Mak0NkL47hSFPN70Baf0dp+iQhKeDg3eitHyIzQuuejiN/wqUeNVdY97omM/y4BBDygcBllPZjYQEGIGwsmmJDPg8ZmViNS9ag78OceQk6KRgYKbK3NA1Dd2Rot6PGP7HFTAZeEV8W+ZR3GuFKeBPWPEAAmnpNLRdfTB1dLaSy2izhBWECP2kt3PZ79Jqse+RzGHQAdL+buYBVC64Hilw0yalWf+NgGgZSG1ZoeKMZHRrgbyZYis9iV0xJ/rBH3l0QRkB6JbGxAbaEpF/BjERwb/uEZtOdSQI1HkaTzUbnaArsscrZivIV+ZUaeK1XJSnycpe6kTyGdgE7tcHzMm4ZS4vI2UpvGLcNjelRGOx8GsgI3NQ2lt0mEnwwJuhCefSF6++qxJpFEDZoe9Xo2ewDaGBDKVPl1vd7GZ6kC9Gk1it2MVz2bo4LF4BCkvfr+ju6GXt0wkD38h8Ivm9ow4jAdAqd48t+3OVhCFpSFpIGqxse6kcJq/CvUcccYaJSEFOARA4Z4vzAa+pOnA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(451199015)(86362001)(2906002)(7416002)(4326008)(4744005)(5660300002)(8936002)(41300700001)(38100700002)(478600001)(6486002)(9686003)(6916009)(8676002)(6506007)(6512007)(26005)(186003)(66556008)(66946007)(66476007)(316002)(6666004)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?us-ascii?Q?UG1qB3cPnikS0jadpat42HUNvITwM94kHQjXomIAsTZAru5S8d9vMn0YGunt?=
 =?us-ascii?Q?Z9k8aiRtGzByQN5330KBcE2TyIO5aeKO4glBg6RutOg7g5HiI9ADQsljD6tw?=
 =?us-ascii?Q?yipPFdpFicO0Z4t7M3AcZuJO+1mBUlBf9gjPf2c9BLMMLRd4jA1ZRGaz4nmF?=
 =?us-ascii?Q?pwHW0T+5XkFOTxL0oPDlOqLkPLQnojDN9uiJePuMF/S9POy11vfTt3khwsNa?=
 =?us-ascii?Q?Nt+dRyIYWXd/HTNfDfY5tJrhzXmk8z1v0xL+VCQcRV+k4uU7kNO0Y2OGl8Ro?=
 =?us-ascii?Q?zaS0AWgyRmTudLV3tRw/DzpIP69AblD76LmAKrClz4FrYeAWism8KrBiu8+6?=
 =?us-ascii?Q?9Rr8AgWmgVfCwNO5N+WZ3Z3enZ2hEWx1zg4UY8LPZxnugIHOdTe8JziaruX8?=
 =?us-ascii?Q?+Z+4kKWl24b6gjulUX89hy6vgwZE381H33SdKn6BSaG/ryPvm3E2qqcs4Ids?=
 =?us-ascii?Q?rNzNhQH/RIBhzdbO3VESkU+fLspUD16PRlr79wHBaaqrxrTcMApj7iboeU1A?=
 =?us-ascii?Q?BqnBE/0tESQBE8yKhpuI9gsC5FbeUl2Mu3Yy04rZ/UPa9o6jY/dKq2iUwO8n?=
 =?us-ascii?Q?av1vrAWn/r/JZVEQaF4szb4eo0rr98FKRBYH8Aqc7WUTyDbB7bLYaoIq5XuJ?=
 =?us-ascii?Q?BS9+MSCElMpkGF/NVmpTpVDEdSma3pSyWxlSVOfFAO6gkjPCY5OnySzdVtuo?=
 =?us-ascii?Q?/FuTEbzVALM6NP/Tk5X2dSIzlXWz9rWG4OloTV76CvCh88ELJfcL1k6WJkPA?=
 =?us-ascii?Q?MsSpR482I+6wtxw9LYHeTWMeafLf5HzhIVtt+QCwuhikUWLrJ+wltKyFvs70?=
 =?us-ascii?Q?huYCPkg+yt49KEpDxoPzLscj6oCMgN0Kc6O1hknJCcNzz99LIAWehgp66IMA?=
 =?us-ascii?Q?IXIM9+ro5ZV/EJXJSkDXigIM51oFKdrjWZVA7wZgw3aRaQWHVHBZWoHIdiMA?=
 =?us-ascii?Q?c0w1YSk96wrPvSuqAnOoPtadbz2SFDHNVa1iLp2IYFVBdsE+xK9TAe/mwDE0?=
 =?us-ascii?Q?FpriX/AScRBFpPV8yOFnnEIFxJqjlC3o0IrEf5z8mtTIFTY4FUpImnXVDYis?=
 =?us-ascii?Q?tInnp/3G47PogAWf5PPaTfiL2Nz7MIDRoioTp27FiL0GBzPbpdA1c9Ym4MqX?=
 =?us-ascii?Q?zvS/q7cJ5pKBr51V/MEKYvsMWCZYBrsq5hx233Uigy2G69QaCtKbDJkA87Sr?=
 =?us-ascii?Q?yCft71T42gW1LAyUHV7lesAB+31szrh0ylmFF9ZVsqZhPL0TV0fnrq+d0ngL?=
 =?us-ascii?Q?ATdhglqeH0mEfgAtqQrro1D5aKqjis5KTs1GwqysMLDThAV9EWfJsYXT9yNQ?=
 =?us-ascii?Q?xB2kdaRqWJxzKzvUnE+pPhIoum7PXih7DHFISuUGfHyQsUXgYbB9YXK1TdVw?=
 =?us-ascii?Q?vwDZDBHbHR4to4SRkzAN93ht96nipQbktX0Da8tbqsJ5EQQVld/jH8FwBY4Z?=
 =?us-ascii?Q?0JYGcf4M9X1/KVGbW63sZVTghVzkBO5Rze45CF1LsdkFvyPW4V6bmMq+nis1?=
 =?us-ascii?Q?NUD9pFHr/Y6AG5sUNM8uIr1eNheH1yAMb0xrCb9YiZ267UEbnvvSM69xPHWY?=
 =?us-ascii?Q?AzHgIm4hwOlDxulKOOPu0MvFvp3N3SXq+h/mxXRC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168feb37-7d7c-4a6a-8664-08dafe0319ac
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 12:04:09.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RrKR/flxcJPujkUqtUmGiO5/yTC3RuWq6bJlsije1mHw60R7jFTF3q3goSkIZuA69qE8DOEn1DnpkP+b58WBlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7960
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230124_040414_936944_9B0BAA50 
X-CRM114-Status: UNSURE (   6.54  )
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

Jakub Kicinski <kuba@kernel.org> writes:
> Not at all, but the names are really mostly for human consumption.
> If any programmer wants to use the stats (and assuming they use C/C++)
> it will be more convenient for them to use attribute ids from the enum.
> Without having to resolve them using stat names.
>
> This is how other stats are implemented in ethtool-netlink.

Ok, we will expose the enum to uAPI.

Thanks

