Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9184EC87FD2
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Jul 2025 13:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EBGLRW/+Z20fuuY/1+y8SpPPzqgKM9j6G1VsBKgZJX8=; b=KKgcWpNl4qXA+z7qKoeJnloPb7
	ZoiUZYI+rIGYREsd2ox+LnF2ZCSuY9irOz1ikgtn/5BTVAnKevULGnO17zaHSeLuGr5zl5ilplHDV
	/FnGAqOKtXHMrmIAWbKH18LONIiUjp9v1Y42NjrBpUGl6C1S3C/npwbdMB9B8gVIhNpdBmGp5rSbP
	ezSrfPF4iD+MxVYIBF4BkgaFCw+vvJzPz4IixrHtFQ7UodTkpTCvnOLxuK2rTd8TQcLvBY2i+OLq8
	FM+VbTCKEJMnaPe9xrIw2CFHiQqic041KqeYFeNnuoRYIqD5Mw/ajfE9nZIGbCoXKK82VuMzPk0W1
	8EFOoBSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhStY-00000003dus-1g8r;
	Thu, 31 Jul 2025 13:00:28 +0000
Received: from mail-mw2nam10on20604.outbound.protection.outlook.com ([2a01:111:f403:2412::604] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhSal-00000003bo8-2rPP
	for linux-nvme@lists.infradead.org;
	Thu, 31 Jul 2025 12:41:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRpENA5XlugrCdtjmxuI5ff5S+ZtN6lsx6dvZovPrXNphDou/fVbOMlzc9vDem5BJkeBoKsd4LXSmJIQqd4/RqNDnjEigubvw6f/HuoImO38ly5syd/EQUAjwDcZwXDhhSYrdqIdtudICFzCa6Tl0mtZQ2ZS1f8lSKcweBus0AXoNlS77z7v1GIJ1x5j3IcjzEWnc4VICvMJ7sJRs76lp05zs1Q2AnYh0usUBSKFlXBn8snPR9ZbuGkl+SoaOpAMHROXFa8EpO1hCLyJ/R4vlR7T6j1t61/JAmvanCuvvXrr1EHxwhe6QE2JgxJf2mw5gzSWI537AVvHVA1ksgiIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBGLRW/+Z20fuuY/1+y8SpPPzqgKM9j6G1VsBKgZJX8=;
 b=bvyN4cpXWlXJsv1CDlbWx2QSNIOFgDL8v2yCmxKBNIfMyO9WytRybKZmRJdPxkc/nr8gKjdCyIgT3ez2MRv4YvASnnO6+0BAZ+xVHXsKm6ayr4Km/CpHpXtEbZuEzmXoskOVdPq0WrjD4I7pOLJk+Tsjvhw9hBJyQTmOKfXSYuAKNkizRwi4ofOYEOY6raCG+UIilWldSvwwhvCSPPwRyZNDD0cyv7Rc0Mi8u3QgfWBi51+JIDMSZK3DXoi8Gg33GiBo/UoS4uweu/tiajqRjTe6LvVyqRxlcBsljOHACJomAm6/t2Hx11mTcs9lp2NxLCI740211GgED5laEDXuNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EBGLRW/+Z20fuuY/1+y8SpPPzqgKM9j6G1VsBKgZJX8=;
 b=f0kFvbWcsNnEDmflwKhXtq4vtphNfXtvYZKiDLA2FtJtCtewl0G6uHX3rWFJTAyxBdnUPjMODk3nIg5+Flal64bR9HfzcLPAag12csHAIj2PcERcwQZZG4CdauQE8fsG6ZNyIFPA6RW9Vn7EApUUpd9WiyBoMdGTr54YA1v6YGcL9l6/c6MGKLoixxRQCepFJ9Kh/jIpwxwcMKzgSRK0iMidlSvpspzdQX3X+FbvcIzE3CLo20hW94qiu5+hZjkWyOI8qcWehZMhRfW0tqS7P5Oez+RTqeOfxsetsZ4rd+dmKFGf4TCjYBF987l7jYwkRCgCSgh4GmrTvTT/xoYpqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 12:40:52 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 12:40:52 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
 gus@collabora.com, edumazet@google.com
Subject: Re: [PATCH v30 00/20] nvme-tcp receive offloads
In-Reply-To: <20250715132750.9619-1-aaptel@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
Date: Thu, 31 Jul 2025 15:40:47 +0300
Message-ID: <253wm7o354g.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To SJ2PR12MB8943.namprd12.prod.outlook.com
 (2603:10b6:a03:547::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: f45b3648-2889-4f5c-c43e-08ddd02f7c20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sUdkvuGhWxJSc4RWaJV784IgM+/8K1hEmTUfqOz8R4B6eDa9elC7JrwzCJDP?=
 =?us-ascii?Q?RLK1Y227gt9lZ3sONYVZAFP2iT6GbbjblGIfZYSI0hWTEUQ9CsGjR6MbpiER?=
 =?us-ascii?Q?P5ca/WPXEg0uC02kyTKZlHcgHuwq2AUXDvITo1tkMUr5ks97+UOMX8AImol6?=
 =?us-ascii?Q?eaCV7h0ByO0Cd00OVJ5oAQ/K3B6zczyWzE8JX9wk3KtNo2rPxoDgiiEqaF7R?=
 =?us-ascii?Q?D9ZyFRz9bWVjo0TUgEfi0t9u4bU8evb1k3LsPKW2rvZowm2hgYPZodVrW1EQ?=
 =?us-ascii?Q?NhadkOr193D2vErEI4YQYvr4XTdSM1NMoleYQx+YCvcgaWYfN38sNSb3Eqs/?=
 =?us-ascii?Q?14wQGgti1sRDsXI7AVzjkxUrDIQtVUc5pCdSFNIeY1heQeelKgMb6E3Selsl?=
 =?us-ascii?Q?M9Qpnny5j/gydjbSbDHi31a71Mu8hUPEK0CFSw8HkjYRgytwA7HgStJPcJiM?=
 =?us-ascii?Q?AZ06Rg0ltEay1kqLJXlop+OQaK8xpvw0QHpG0P+v0s5qD3NEsqMklTZ9QMbr?=
 =?us-ascii?Q?q4yhX9lhexCC+MWk076RzLVclMxWsTeMYwkJ+rp6Ctyly6BIFluHNQ1TaEMb?=
 =?us-ascii?Q?xCQ5xdT5OYs2itFfto9htq7rv2vwehO9N6ltdeDkAfePLsUVmP+djml1TZOn?=
 =?us-ascii?Q?D16nfWj6g5SBqoznYTbqbuUyMj427bOWlUU8tLml4bdBX3aX7Hp6Mo8FfP6c?=
 =?us-ascii?Q?i2H0Xtvjk0DPldEGCTx6bk0k6/nFu3SKqqe1eq0jek6UsSyHzadT5f6Cc/MF?=
 =?us-ascii?Q?sexPFKBWVe5bGhQEB5QdTQ3TxnGVXHNmAyn6hYovAOipEmcRTK/kjQ7e0n1F?=
 =?us-ascii?Q?IXwx9s0P1xZfG8qX/w6Wfj4nS0SdW5fJuA7/cH0mahjAVDWx6G/090V9cxk0?=
 =?us-ascii?Q?2WaOSkFlgzWLPooszCp1/4fnc2RmFhMk3vLEMcg5lVpdaxMosvlMggmv5S0k?=
 =?us-ascii?Q?0WSKOXV/ZfHqSgbO/ORCJgCxHss1OiRRQi76RaXpsyf5IINYCa9BNTQ2uU6G?=
 =?us-ascii?Q?Z+iOdAVrx0+ec+xC1UIuYcLv/mpHKqPZJ9zwMy3nd6US+0yaiJmc92R9aoVh?=
 =?us-ascii?Q?2Xmooh4KcSKiZpNkoDl0q430GUPwkt6Pr/fWtU7ip2HVSyGBgO9gWGSQ40qO?=
 =?us-ascii?Q?KNdhoj+fEJDBClcaDUSOSv9aQoYTDRgxJwWDnbQ3iTIJKO7pY83bdS2EQsxJ?=
 =?us-ascii?Q?UsiNsGlYW+vtefDSYKsqhqLMMXBnWe9STVumposAGEpaxYpTFUnhQ6HDXOVB?=
 =?us-ascii?Q?grB2ER32+STxrCdO3+jogonG56PN3tL5pPwhmv25X2h1/YB4zQnNxXiuSfft?=
 =?us-ascii?Q?Df7oLZlNN7bqumd8ENf1aFFWcBgrXuxJvEGRvr+kzIfY6XfTe0rX370CiP6O?=
 =?us-ascii?Q?8a3E7e2/7almcsEyUkiq2dKagZr8lyMCm2LWYyZjiByxtHnGh3ci3WLVUlwE?=
 =?us-ascii?Q?VMZ6L3+xrzM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vz2PRJy/iPK4DRIpKBqLqMqsrRCfW4SccNwRNexCZnL8ltqH732rkWiYiJ2/?=
 =?us-ascii?Q?VYojurpZDDjI820gLY4aLOQD0GQZ+QeCXTSN0N+zuIBlJs96VcgKjN2QdPeI?=
 =?us-ascii?Q?U3MFFxFlkCL27Kgzr9GRiV6z5DPYqFE4MOTew7YSj4zA6T/XfMlc3REsY4sC?=
 =?us-ascii?Q?0FvHLuUM9MBpQbWJzIuSW+2Mhm/roXDhQ5Hwo+oHO3NlJgZ9iLDUuEu/nXR/?=
 =?us-ascii?Q?+LKUKGFkM61uyGWBRSO6z7hZ6uXneEBMidzwvfepVNtYHe5sHRUh0ZMWZEZJ?=
 =?us-ascii?Q?NqgtdGX3IcCSqov/p5DttMRTqK7tU9wVh1n+eDfA5EvISy7/Bq8yoJSJ+Eqb?=
 =?us-ascii?Q?XpwDTF4Nh0UfmPnnPjHDOJy1/pgbhCW89HePpyBFmeHu9tcJ0E4im3vckwIY?=
 =?us-ascii?Q?+lhq6V0+PUkkiSNMgz9FvrIDdfZVX6kopt01QbSf8YiYu/k2M/YIYCtQiEpI?=
 =?us-ascii?Q?Ikw1Bm2NK9xzeghGNZzUX2//3HGYIhr1pCydRb1ZZHUKzghzAe0OV6/c3BiQ?=
 =?us-ascii?Q?FxAPSQFC0QBOX1l9syIaEtlDLyOjlAun5ELC0nSfIdHMlyu6nSzyCTAdql8/?=
 =?us-ascii?Q?Wy/qyMr5h/k5twzt/zW89NpcbAYaSwBxH2rk2umc8KJJ40n3en0oeqkuzqAq?=
 =?us-ascii?Q?Gh+iH1JvTUICmy1D3LCYSHLS60/zrlPBEq/CSDA5JZ5dqU91aVuMLu21lhDP?=
 =?us-ascii?Q?IL5+aqk3kdk5LDsoSJwfVhn9ncVJMFPaF8gFstkJrTSgXrL+fOdxD4wZ2gP4?=
 =?us-ascii?Q?9TjmygPOhjdaObhlVc2WVKcJgBlMjYqd91EHrCoXw6UrbSyau2iPCs2GWWjk?=
 =?us-ascii?Q?V/xOtvJqqxtpQzWh7wcsvTT+a0mbBtOTyYP6EcSF266TXsEgVgOipcJxNC6w?=
 =?us-ascii?Q?5Wfh/6zc9rAjBsH3pQNx7cwqoh8sh/Y9zbb6i9THxKrAig8y3uYKFsn9VhUt?=
 =?us-ascii?Q?LTJ+ebvQmnCdQZ8Eyz5STL4/tQF1mRAvmYwj7qfswY9KjzBpvywECUm7SLme?=
 =?us-ascii?Q?Fss73Ck0jBl2T1MyAjTyXZ5MuKG1hCiTmq6fnlCG0kOTt+giTsH+YxLHqiHk?=
 =?us-ascii?Q?9dj34/vq3eq+a78egBqCjH5jaU9RD9iKTALVygzcETlzCb3BRJEL9RiLnbFI?=
 =?us-ascii?Q?lXuir5tYGwa+PseQOhY5YPO9H3Onm2WpWqo4QaWclo1j1h2khQEzRPzNc4rD?=
 =?us-ascii?Q?3x4o5vnbOHtkOp1pNEH6MsmH+DjV5LGoP0zVVAU9T8NWm9Hb4mxTUepNVj9j?=
 =?us-ascii?Q?cvYWjZ7zvczaLJW+HFXDadQ5saanMnXpmTIIItrTC+838eZYCgcIcQqgPS3j?=
 =?us-ascii?Q?KHS7iNi55QkuSwGE730Haos01be/pQ2wXF7o9p8IQsS4fWXt4aWVEiNOlJ9O?=
 =?us-ascii?Q?Z8U0cYvofCXLDxbeE0N+oIQ+OV3svfBf0/GnGddSJ5BMy9KHaQ3IZiyyNMBI?=
 =?us-ascii?Q?fSLpnrMUG56taR5fXE8jk03r5FVepZyKNHqnLLI+AGtQD+XbWxptGeS/rJdR?=
 =?us-ascii?Q?c9pu6o0C3y52uoI90U0u/O5QQWUZn8KP31vJCHJP/CV6dkWq2UDOErw8pX7N?=
 =?us-ascii?Q?yzFk/rWjm1FSxqLEb2btWLkytM8/w3du7KiXsoXn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45b3648-2889-4f5c-c43e-08ddd02f7c20
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 12:40:52.2937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BNEUQoLKRAnKVqbinOyN5lZWC9x9AQu6HTp7Om+JquOmevxN4mAj+fMPor5rKVM96mfz4H38T33LyeCd6aUUIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250731_054103_723322_FDF61FF8 
X-CRM114-Status: UNSURE (   2.82  )
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

Hi Jakub,

Any thoughts regarding the series?

Thanks

