Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8724C54754
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 15:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9pElPaT9bNCDQykZKMhOArA7vCJDYorvKDRu5kKgVKg=; b=KlmTV+L7wOJt5DZyDU7fCAN+ju
	NVfr8aY+hERZPpHNi0QzEmniuFptBxA5tc0aJ0wL54/wJhpd0imPs3yRQKSQDSOk1yuOuvIqwxwds
	ljzncMvoQW++F/v9Vd837ea6QoCFM3DcrISNa7wTTwzdLuLWqkAr6VFkBdfZiX0VLIc+wfGZcPW2f
	OOxsmnIFqS+U4FpsrBGwldYHet9I9LDEn85hpWp4PWSy0GL4EfWmpyseoIK8uzlt+vyqQwfBuvwbY
	lsXuBdBdIqPenu46le2GBXGwZhYUVU1MRzFhjjv9CSmcukItDab0is7RDJhB35j+Kp7Jc0Z44I3f5
	SMb7tU8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFwiz-00000003nik-3QPq;
	Fri, 16 May 2025 15:11:49 +0000
Received: from mail-mw2nam04on2060e.outbound.protection.outlook.com ([2a01:111:f403:240a::60e] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFwLj-00000003iZ0-0Max
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 14:47:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYsZ4pS51iG8UxFsuRnTC9UgAP8G1MUjL1xnbTIptZ7XQ8g9NX8gxfM46W1oNi2DM4bkgbF2Av2Y8G59v8FLu+vbNixG22HiJhfroMpavPD+9elKPD91GSvbb7L965TGkq+bTwyxc5VUs6TuERR+GeMxUD5hxqiodJqSHtLjRSC9UhGOZiPMxqXW0DKmFYSpJmOk/VI885rVhNkjxHMDc750OPc4Hiat1H94OHeGtAGEkFkqncEpndJ0DdXSY141CMp+rJ9v+KWUeuNImOLl2QEhGuRcY4zl4k+KHWLXj0fyu/EvZcJVNTlirYWAuhka7CjU8GievVOmB1L9qi1cTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9pElPaT9bNCDQykZKMhOArA7vCJDYorvKDRu5kKgVKg=;
 b=xWgmHdwehCyx1Nm9mQBwss9nWuhk753CghqNdOGhbIQ1eXAZKX/3f5Tl5LHQgthXpuX59jlb0JQd3bNYza2IosqACLu3g2z2OKsV+XoVGvtJIfB58z/Ph6ezo8oO1lW9nK21Vb1DfLhs8+DLPeNg1X1rZ+/+MHN20DpYV7dZnatHn2yzpGF/yJswTNtLjb6ir4Sd4t25lBLJNKcLknb4t9mQS2RjVDEf209JZut06O6x/AMWbjZUrvxmMZDLNJt1q4Bbl4yFlhMye5uym3IK+3QZr6jVejGiLi6ckp8NVRB5AJiZ/HqkqsECZFLAdbJsXrMcVfx1tTO7Ic7v9/DQDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pElPaT9bNCDQykZKMhOArA7vCJDYorvKDRu5kKgVKg=;
 b=fMPVNva9GaCOqRtRRNB/qGNwQXDhEEH1Eu9nIMoJxS78wVSrNgEvky814dZ+w4fPIa5EtoTpAdwS3IxibwGZj8nth0/iO3f6/4ilocD4TaCidZjWrVKNCiolaW4Xi2e5VOwUTL169W6psSacnOFluOsvcbBd5jGP9NaUNIrm1SwY0esf/fSpISF6aHp2SZl6Q0nQYplDxXeFzBaK0p9oIE5s33SSBb3iNJrBiOyLFoHIhksCPqMRAtDdhw4OFg3nbKrSkM4R80YoPWpHg/py8fGbw2D0ZYd7/rKakOwmr/L3SLFBM0We7Lfms/QdMsLX2AxMmRRhUgPsolZgWw9WKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 14:47:40 +0000
Received: from SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc]) by SJ2PR12MB8943.namprd12.prod.outlook.com
 ([fe80::7577:f32f:798c:87cc%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 14:47:40 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: Eric Dumazet <edumazet@google.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org, Boris
 Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com, smalin@nvidia.com,
 malin1024@gmail.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
 gus@collabora.com, pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
 jacob.e.keller@intel.com
Subject: Re: [PATCH v28 01/20] net: Introduce direct data placement tcp offload
In-Reply-To: <CANn89iLW86_BsB97jZw0joPwne_K79iiqwogCYFA7U9dZa3jhQ@mail.gmail.com>
References: <20250430085741.5108-1-aaptel@nvidia.com>
 <20250430085741.5108-2-aaptel@nvidia.com>
 <CANn89iLW86_BsB97jZw0joPwne_K79iiqwogCYFA7U9dZa3jhQ@mail.gmail.com>
Date: Fri, 16 May 2025 17:47:34 +0300
Message-ID: <2537c2gzk6x.fsf@nvidia.com>
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0013.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::6)
 To SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8943:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: d1dd1fc0-08e4-438d-dd6d-08dd94889b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zq7UNluF+N72IyFP8yCnaMhw14b9bJuT+0mjYLWubr+iOGZH57jlW6tmdLM4?=
 =?us-ascii?Q?FhaRBdivj3vtoIbUJDVIyCYq17Yo/2KO1dBpY+L/p4Y5opeueGbljYHjfkQJ?=
 =?us-ascii?Q?HdvKr+2cAjw38E/zHUr3IhF51oSWaT8qBF6UXfzaq1keV6dyxmGHY6jp06iw?=
 =?us-ascii?Q?pkwT80vrwKQLeCt5bsQKE7gTgdUGnhi2Cd5b+n01BqJc/18zXfvdcczYcF/k?=
 =?us-ascii?Q?fjyZyvTNYL4uoDBftS6t7o6PyuwqkkMYNQLwR0+ebDIRiK1E69yDLaVqF+X7?=
 =?us-ascii?Q?Opu7fmaiSCOZPSimET1izFnLfP5GkWDkpoqhWcuxva+cu4EirZsUI2fMz8Cz?=
 =?us-ascii?Q?9D6W68qSlH+nNA8UA0D84noy8DwuqQGob5mSfzFLTUM7Xq5BHnvFj1hV+lKY?=
 =?us-ascii?Q?X7ZNUJ65F1dOqDRjCNo0hsNZp9l5gepRKKSnDTBeEoDVN4sdVLPW4ExXQMZF?=
 =?us-ascii?Q?CaBS3xG3TaYCqPVXBP9tgOvkINgNlnfSQES1BpWBdMLYuhO6PcDsmknbOmve?=
 =?us-ascii?Q?TnjV9CL5rKKKMcecbpyMtAfccRAQITNcxMa9HXnoGDOdrRrOIbZPaiuePlQz?=
 =?us-ascii?Q?5JnoMtmpFXf2h20ty4MQ0exyL9LdiB9V156Nbvlny549dDlpplNrIlwS28eg?=
 =?us-ascii?Q?QXqycYcRUFvZzjyYyveii4/0J2nMC9XU33wMrnPAKksAx5yWYGNyKVL83zLk?=
 =?us-ascii?Q?4VjVdkZ0MwiRf13ERIFhCaGink0+HbcuYY/B31hUnR0ZQcQhmolGax+hRH0X?=
 =?us-ascii?Q?MtsXhf3f9UGmptryidi5rScZhqOvonisZ2VVRxPWMmxjRyyr/zgfSVYmbUhX?=
 =?us-ascii?Q?0TRDMphK+vVx1LvM+fHq+kx+ONK//R7cZGhv+XwA5J//tl8tZrf/oNt1ZG64?=
 =?us-ascii?Q?rvr9L2erV/01ocg8aWZaOMCyWGxPnvxnU8Gi0ytt8o0BGcYXXxlFN7hzOqPl?=
 =?us-ascii?Q?5mFyxcRpPx30QXEllin7NwrRjdHEtUesstf6ZQBEy9G9MntMXQQQUY4kFV9w?=
 =?us-ascii?Q?rBKHS3pRdKPhDQjMKXT55IaJqsfZtncEOpioRCno2szVtHPgLCcUwsTQKwOW?=
 =?us-ascii?Q?So+cG6lIOTlP5IH3pfq89zHKIzeLvjEq7FerrzyXeddB2+cE9FNhv2Pfdcaw?=
 =?us-ascii?Q?qs+XeJQLla6D8rmLrAVylhppJMoAOPyFdRlfxw0QHLekIToDGWW86/mJ/PCx?=
 =?us-ascii?Q?o8eJeIRwafWaKoF8N3j6dsP+1cL4CpgT94X+KzKMGduxDnUY13nMhObH4k8D?=
 =?us-ascii?Q?NVoy2pTfIm7p6RncdRovm3eovdb98hKU4TxCo800IaC3Bf66+iX34owGkDG7?=
 =?us-ascii?Q?XgS1/ycdn0pEvy4WGj62W1r9flxQ0AUqepxH7U4mbfgtMqUEXxohh+oYudKJ?=
 =?us-ascii?Q?NxdytEfhqjlDOZmtsdvjgFVfv0IKFkAPEprV+oiRjfafANl933Gkb+pKTpq1?=
 =?us-ascii?Q?y6rk4VQ5yno=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8943.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xOgVgvk8jqE+g9c2kKjBriXHA3THnvJBg4WsPoloSLJR1VT5gS5oylEbG1f6?=
 =?us-ascii?Q?qFa3YA1D8BvBcb5dAJkUamOj5NnP9mk1nXqwuAp0EW0Nae4e4OlLiv7JZENn?=
 =?us-ascii?Q?8AeB1OZvcsc5V3sv6W33Z8stzoumy5veRhPVm/ZyAz+A4Md7FSUfmm752OYD?=
 =?us-ascii?Q?/QYBBB7JqHNfwHpaSOo5JaSlNGG7Lmq7uUzYv0lBRu/MJL77euZpUcAV1Dd2?=
 =?us-ascii?Q?zSbINCtHu5M0bQlvWynNfb1ivG7Px2y4thVn2EerUckMr8OwUee/mZdmVx4U?=
 =?us-ascii?Q?OeVHeYV2JJb6m+M5HfklOxWgcpT+7K1PAfHRFgnXU7rxBy1+0YKM5dt/AYWT?=
 =?us-ascii?Q?hamPmVSPe/MYcMpApwxBiypCWRzV23A+LKBJt4eImh8RGW3SaHtNAc4k4OUu?=
 =?us-ascii?Q?DaO9MyBtH2RtizjxSjBBSwDZdo2dN20A1hjpPDYtmxD4EUSshRfoZjsBHsYF?=
 =?us-ascii?Q?K4OKitOXQRuyWGUDti6GWMrqQp09sHihFoLjzsyl1L12c2Fiic1LCC9OHxvv?=
 =?us-ascii?Q?F4xuELGe/y5XE5vLum6kFwICLpOs5hcGC6rFx1eKaXQkpdEZa4mjsrYRW++V?=
 =?us-ascii?Q?Xpo2yUN62q6pT3Ojr2wMVrVRPRLcx6TRvBGr6ixvh2CTuyHJK12i1596dEuH?=
 =?us-ascii?Q?aKyL/94uqJpPpYUIo6kU7PvN3zgxaUyItYEwgSQayIaVoHLyn2EUCLJecUoQ?=
 =?us-ascii?Q?RJ8oevUoS6AlWm6KuoS2bFCgL1d1iAu0ynSMUqQjNGMB69Qe6T1oCXuoQnBO?=
 =?us-ascii?Q?/VoOtaK+XDfTTUwizKv4+0sNGseVcISRg1pA9IQokVw8Tr5ftW4A+3Qjrt3Y?=
 =?us-ascii?Q?lJFAoQ7NT5Wa/MZqn3MihEr5WZNmXuWEqRD/8NXIpzR+ikSAd8B4TmsEaInD?=
 =?us-ascii?Q?veWe/RoSYC+hPzvw8FveEpQBeoe7fednU0E9LKUIEvPIeg8JR27YINxA+mgf?=
 =?us-ascii?Q?df48hykXDKwvCswwGz/zM19CoVNECFEevrRZ+hnSmGXL0gi3yYBtcDtmEjSS?=
 =?us-ascii?Q?092bL9hdqp+Q+7Yn3JUfsbd9ryzEhmAkb8R/pPfoibI961LeY6qXhauHyVZp?=
 =?us-ascii?Q?/kRs6jeom0wcnD3eQbmGYeq5lnXVRG/BT6XlHI6Fh2yfEdA+Y7OxptK9BSua?=
 =?us-ascii?Q?XGTq58F5ioD/zqfBq6D/OnjPMBGMUQfsyzPrgPnX2TLLnRx5LnhiPhACUEW/?=
 =?us-ascii?Q?tVuvgHfebts4T5UuFicofMJhVOl8HmL4XGQ5MwL0S4pv+Gt3STHksv+ctS67?=
 =?us-ascii?Q?0lL3bIIuDDdogNHM2gCeyM3yciZBQh4+DnWloyGaLtm6NASWjg2Hq+a7Tknz?=
 =?us-ascii?Q?0KSLda8L13rrB+7RVao3nn43Gv7U/3+tdqXFM6ePstCi1AkmdTgO+kS088m4?=
 =?us-ascii?Q?G4t8cQf88WAOcfVczV+ihOn36oxp0irKT+VxBw+bJ+Iuch1RE0NiEhrSghFZ?=
 =?us-ascii?Q?4IK8ZU9V3cEAJJ+wqcxBzShzP981oFpJjgUY3ckD/m4Rk0qnGDrsguW39pN3?=
 =?us-ascii?Q?3nMrYAgJntKKi0/JyjkYrZ3hM33RfkY8YDVE5woj6T0tyUHdJzgR3T/l/+HW?=
 =?us-ascii?Q?XzG2c/EnpVXaDLHyN97VWHviqSDtmMEXwzHDyCXi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dd1fc0-08e4-438d-dd6d-08dd94889b61
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8943.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 14:47:40.1927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6A/9Y+auxx1BGVfFZ3EeLwj9ISCQV+xB4QGYnc5yewnNs7a4eYgUuAMhY7ja5o+rPpdDWRzt/rRvEXamqhBP+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250516_074747_125758_1576E4B4 
X-CRM114-Status: GOOD (  10.02  )
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

Hi Eric,

We have looked into your suggestions, but both have drawbacks.

The first idea was to make the tailroom small/empty to prevent
condensing. The issue is that the header is already placed at the skb
head, and there could be another PDU after the first payload. Placing
the header at the tail of the skb would require copying (which we want
to avoid) and could potentially overwrite anything after it.

The second idea was to use the unreadable bit. We tried setting the bit
in the driver and updating tcp_collapse() to copy the bit along with
other bits. However, making the skb unreadable causes issues at the
other end when the nvme driver reads from it, as the unreadable bit
makes it, well, unreadable. If you look at __skb_datagram_iter(), you'll
see it errs out if skb_frags_readable(skb) is false.

The offload works by calling the iter copy functions while skipping the
memcpy (see patch 3).  We think the unreadable bit is getting close to
what we want if it wasn't for the skb_datagram_iter() check. Maybe the
bit could be unset at a later stage but it's not clear where.
Alternatively, the no_condense bit might be a good compromise? readable
but not condensable.

Thanks

